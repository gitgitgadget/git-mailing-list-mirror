Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D141F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfGAOVK (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:21:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46695 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfGAOVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:21:09 -0400
Received: by mail-ed1-f67.google.com with SMTP id d4so23779916edr.13
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ng14c98yDNsmmlTFuYPMoZa4vuYiKisvHodOogomvro=;
        b=tIDYdpGJD9ODrfShCY2hALmrWdxVyUvIuzJjf63Tx8wC6vQymMAqVvsw+Dl+lv+avy
         xFGdBECSS0/QFFHj1st063AA6sdDn2kQT/5VrCAb1Boy+M3/cprbGzZ1P7Y9CsKKtqIz
         93FYvtzi3qnLQVUHksubBYyJLxU58G4zaylkP17aFMTkh0lbxch7yR3bhD4uumsYF9tt
         h3iHNg4tHSOY+P2PmP1jpcE7X6idFEdrn5P+8c3qw0lgDXmu6hj6WmMl/512HYSisHET
         ed7ibkiR74ZrOTwHvmSavTaPUBAay7D/KLjoxlb0xP17rO2fulEzcWYZuOnftUT37qXE
         MHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ng14c98yDNsmmlTFuYPMoZa4vuYiKisvHodOogomvro=;
        b=jOBXG3trIdWvTw4+7/YJFHjp2GeODpokLhH/HAt26qHwUVR4fDaI9mVa3fT48Ajjx4
         uZK0FvmMceCthZYOL9Z0U1drCM21Swh4k4T9EeVgZdn3cwy6uaSNNrSQX951Dn5XUQpp
         z/lhLMPhHIcF6ZioqyIIB6VTkiLywiTLj15L7snm3yyclJN0BToVuS12ILEFcK45k0gb
         eG/Ho2bDF/KB3zDFP2E0tV8r7FqSeOSsWM+HJFyrpyocoNSC721+4SbTUOxNDYnAse8z
         vpaqRtPxq9VxzCowS4qRrNyYm1J7mazfou4XB1x3MWKpvpdxlY04WQV98mkcuzRrlVRP
         l4Ew==
X-Gm-Message-State: APjAAAU6ATkxELxcguApIw/9QSfTT+lhKUCXyaFZECHsYDVV2l5HNB0v
        O8RfdL/h4D5ToR3yKCJjQDWLqJIa
X-Google-Smtp-Source: APXvYqyWE//3EnGigEZZ3wU9FjTuiIawBLIlIgSOnvNSz/1ox+koTPXUjfw4FI8UDxMi1Ijnzqdgkw==
X-Received: by 2002:a17:906:2ad5:: with SMTP id m21mr22530064eje.55.1561990867413;
        Mon, 01 Jul 2019 07:21:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm2157819ejj.25.2019.07.01.07.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:21:06 -0700 (PDT)
Date:   Mon, 01 Jul 2019 07:21:06 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 14:21:05 GMT
Message-Id: <0f04fa2930d5cc7dfd2a5c5185573f7ecefa6055.1561990865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.281.git.gitgitgadget@gmail.com>
References: <pull.281.git.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-prompt: improve cherry-pick/revert detection
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user commits or resets a conflict resolution in the middle of a
sequence of cherry-picks or reverts then CHERRY_PICK_HEAD/REVERT_HEAD
will be removed and so in the absence of those files we need to check
.git/sequencer/todo to see if there is a cherry-pick or revert in
progress.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 contrib/completion/git-prompt.sh | 37 ++++++++++++++++++++++++++++----
 t/t9903-bash-prompt.sh           | 20 +++++++++++++++--
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 983e419d2b..1d510cd47b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -286,6 +286,37 @@ __git_eread ()
 	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
 }
 
+# see if a cherry-pick or revert is in progress, if the user has committed a
+# conflict resolution with 'git commit' in the middle of a sequence of picks or
+# reverts then CHERRY_PICK_HEAD/REVERT_HEAD will not exist so we have to read
+# the todo file.
+__git_sequencer_status ()
+{
+	local todo
+	if test -f "$g/CHERRY_PICK_HEAD"
+	then
+		r="|CHERRY-PICKING"
+		return 0;
+	elif test -f "$g/REVERT_HEAD"
+	then
+		r="|REVERTING"
+		return 0;
+	elif __git_eread "$g/sequencer/todo" todo
+	then
+		case "$todo" in
+		p[\ \	]|pick[\ \	]*)
+			r="|CHERRY-PICKING"
+			return 0
+		;;
+		revert[\ \	]*)
+			r="|REVERTING"
+			return 0
+		;;
+		esac
+	fi
+	return 1
+}
+
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
 # when called from PS1 using command substitution
 # in this mode it prints text to add to bash PS1 prompt (includes branch name)
@@ -417,10 +448,8 @@ __git_ps1 ()
 			fi
 		elif [ -f "$g/MERGE_HEAD" ]; then
 			r="|MERGING"
-		elif [ -f "$g/CHERRY_PICK_HEAD" ]; then
-			r="|CHERRY-PICKING"
-		elif [ -f "$g/REVERT_HEAD" ]; then
-			r="|REVERTING"
+		elif __git_sequencer_status; then
+			:
 		elif [ -f "$g/BISECT_LOG" ]; then
 			r="|BISECTING"
 		fi
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 5cadedb2a9..88bc733ad6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -211,8 +211,24 @@ test_expect_success 'prompt - merge' '
 
 test_expect_success 'prompt - cherry-pick' '
 	printf " (master|CHERRY-PICKING)" >expected &&
-	test_must_fail git cherry-pick b1 &&
-	test_when_finished "git reset --hard" &&
+	test_must_fail git cherry-pick b1 b1^ &&
+	test_when_finished "git cherry-pick --abort" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual" &&
+	git reset --merge &&
+	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'prompt - revert' '
+	printf " (master|REVERTING)" >expected &&
+	test_must_fail git revert b1^ b1 &&
+	test_when_finished "git revert --abort" &&
+	__git_ps1 >"$actual" &&
+	test_cmp expected "$actual" &&
+	git reset --merge &&
+	test_must_fail git rev-parse REVERT_HEAD &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
 '
-- 
gitgitgadget
