Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5608C207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 02:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032239AbdD1Cuf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 22:50:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36576 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935814AbdD1Cue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 22:50:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so15223691pfd.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QqDKo70HbfvWqKlme1/L8HTYW6YEKX6wbHUUesg6OtA=;
        b=Hbs/WqymvmHDZLAxWLfo6B2yqIqacTnfFfzhRKYKDlABvz8EAu/dIhVBRuuy5s6lMM
         CxD1g0Tc4l57BSIg+76gvtd6DIZaLlPM5wXRLO4i1qGst+97Kw6i2UTJTdNyHC56Pwjd
         qFTjdgPQQc4B+WUeFOZCK6hTVswmZ5/BgT8xySuqvNN+jNnQxtnBN8kNezxgeP8KmkXr
         DLQdc8K8g6b8gxx6Jb6oAQ7ynBFODxisEfhK6wCBndAzCZSgzRFZ7ENq/fJJExmkaLJf
         gSLCDjBpUNDRhylfIr0geQdEppqqVOTeRti0jKNhghG6py0GXc2WXkFXaL8w8y4iJysp
         vhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QqDKo70HbfvWqKlme1/L8HTYW6YEKX6wbHUUesg6OtA=;
        b=bSnNM+Ae5vMsv09eyaMC7KX7+oP4w1ATGGlJI2DTJ3xROOuMtq7qCx1c3Fjzz0cizH
         hrqORZ3ZiVKVYHg9Xhoze6tOSCRX/Oh8dftGNn9g4wB+SqFoH1NRzUNtC92vl0ElqYul
         tntC/W32AjC2R/qoeEDHdyt46xjZGvsd8+2nsrmgxVF4bKyq/ksRQQhd+F8rI4reUowT
         dk1S5zKy5umuucCSLoa+gjLXXNseyF/UPfI3UUv13swIX1yNc0Pan5eXp/km74ahhFCJ
         ddCqEHaY7ztOggrmm+INCZkSNRfgtW9R5fKeD0bShFIm1AZX7a9WyrRk0e2fjSy0IBHY
         q3Ug==
X-Gm-Message-State: AN3rC/5p62UhIkD35nDD/5RjHRRlmDeYSOnxZPDj+U3KMZ6ioTzJRQoB
        K1+tsh2Y6XPwlw==
X-Received: by 10.84.149.168 with SMTP id m37mr11888870pla.74.1493347833268;
        Thu, 27 Apr 2017 19:50:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id i30sm7468409pgn.39.2017.04.27.19.50.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 19:50:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stephen Kent <smkent@smkent.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] status: add color config slots for branch info in "--short --branch"
References: <201704939828871.4296cfa6a746a5004d28db265800a@localhost>
        <20170427090423.amjqi7ca4xl7pzax@sigill.intra.peff.net>
Date:   Thu, 27 Apr 2017 19:50:32 -0700
In-Reply-To: <20170427090423.amjqi7ca4xl7pzax@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 27 Apr 2017 05:04:24 -0400")
Message-ID: <xmqqo9vhkzyf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As we discussed elsewhere, it would be nice if this tested remoteBranch,
> too. IMHO the simplest thing to is to rebase it on the t7508 update I
> just posted.
>
> The other option is to add config for remoteBranch which would do
> nothing for now, and then resolve it to check the correct colors when
> the two topics are merged (since the test will start failing then).
> That seems unnecessarily confusing.

Yes, let's do the former.

This is to be applied on top of your
<20170427090105.vaodugbqdaxunoin@sigill.intra.peff.net>

-- >8 --
From: Stephen Kent <smkent@smkent.net>
Date: Fri, 21 Apr 2017 22:42:02 -0700
Subject: [PATCH] status: add color config slots for branch info in "--short --branch"

Add color config slots to be used in the status short-format when
displaying local and remote tracking branch information.

[jc: rebased on top of Peff's fix to 'git status' and tweaked the
test to check both local and remote-tracking branch output]

Signed-off-by: Stephen Kent <smkent@smkent.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt               | 5 ++++-
 builtin/commit.c                       | 4 ++++
 contrib/completion/git-completion.bash | 2 ++
 t/t7508-status.sh                      | 6 ++++--
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..96e9cf8b73 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1137,7 +1137,10 @@ color.status.<slot>::
 	`untracked` (files which are not tracked by Git),
 	`branch` (the current branch),
 	`nobranch` (the color the 'no branch' warning is shown in, defaulting
-	to red), or
+	to red),
+	`localBranch` or `remoteBranch` (the local and remote branch names,
+	respectively, when branch and tracking information is displayed in the
+	status short-format), or
 	`unmerged` (files which have unmerged changes).
 
 color.ui::
diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da8..9028bfacf8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot)
 		return WT_STATUS_NOBRANCH;
 	if (!strcasecmp(slot, "unmerged"))
 		return WT_STATUS_UNMERGED;
+	if (!strcasecmp(slot, "localBranch"))
+		return WT_STATUS_LOCAL_BRANCH;
+	if (!strcasecmp(slot, "remoteBranch"))
+		return WT_STATUS_REMOTE_BRANCH;
 	return -1;
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b617019075..72c6d58965 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2378,7 +2378,9 @@ _git_config ()
 		color.status.added
 		color.status.changed
 		color.status.header
+		color.status.localBranch
 		color.status.nobranch
+		color.status.remoteBranch
 		color.status.unmerged
 		color.status.untracked
 		color.status.updated
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a000ed4e7f..567c4d4bab 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -661,7 +661,9 @@ test_expect_success 'status --porcelain ignores relative paths setting' '
 test_expect_success 'setup unique colors' '
 
 	git config status.color.untracked blue &&
-	git config status.color.branch green
+	git config status.color.branch green &&
+	git config status.color.localBranch yellow &&
+	git config status.color.remoteBranch cyan
 
 '
 
@@ -730,7 +732,7 @@ test_expect_success 'status -s with color.status' '
 '
 
 cat >expect <<\EOF
-## <GREEN>master<RESET>...<RED>upstream<RESET> [ahead <GREEN>1<RESET>, behind <RED>2<RESET>]
+## <YELLOW>master<RESET>...<CYAN>upstream<RESET> [ahead <YELLOW>1<RESET>, behind <CYAN>2<RESET>]
  <RED>M<RESET> dir1/modified
 <GREEN>A<RESET>  dir2/added
 <BLUE>??<RESET> dir1/untracked
-- 
2.13.0-rc1-211-gd5d57c8556

