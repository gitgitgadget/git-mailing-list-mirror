Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D8C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbiDTJ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377363AbiDTJ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8330F75
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:00 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so1538580wrc.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iqaxVSiB12UtAol0ouxrRdYyVpj3Yne/p84KirKNfjA=;
        b=egPTduhGnlXLUYDrCVBIU/HnVZmvzXqHjl2julFwHyz0ybN1bd8blmAUurQhglzLBr
         mEJndrs7uDHjlB+NsWkLPF0sPS0EWAhtAGVE9lne6bzZQvuWQ6htDLYdIRha5+vjTfIQ
         gsvRa2O94AX4yYaeTc/vg1TAmDRa2cJ7C3ZJkgMkm91ykLEfohcWq8nel3zTOB0+ApwS
         QL7s91j0DI43aF/L+cxS7S8Ai43LZM1i7QWC2iqJALoUl8Bekd99QS2rjFKSasQmri/e
         peNG3JOc//n2jyTEmPCg7x5VdY2fMYACFNkW8oharakRB1ZXaGna6n5HVTwMAKYqz+hP
         20mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iqaxVSiB12UtAol0ouxrRdYyVpj3Yne/p84KirKNfjA=;
        b=lxaIorC3faJfVkMzffpSLxTx/HtIWzprVEJoZYYxPE2/X50hh8fxZhuzuxha/Ju5Zk
         +d6xiTRBMeZXRU7Y+kWqd3bKqHKHXfQb5KJ9i7WQuH2NUWAAy9HKYdlYb6ibUQxJdS5E
         WIZ9W/DItbKGwXOq0VpYB9xMM8y5gFLILMxH4czHWqW0Hvyb7pLg+Hp/scHuwm0fk+q5
         m5IGwN0gUkz076dgrO2L2gzoAqpGvYjlOPBce2fO7ZrbkPlYBbVVcZfXW2xGAXayni2w
         ZbggXQnNYuYnJh8KFXJ0ACIVfV8HW+mFbTUVj7LNURcVbC0f7lgmqU3C/77KImn7jEaI
         Wv3w==
X-Gm-Message-State: AOAM530SHcmRZ4KZTtPAI9kvULsvXK5QcXQBwyNLXBX9mKUE2qIWPK3A
        5Vm/7RoAKRbXiBq/hlv/qK6pkIeVMhY=
X-Google-Smtp-Source: ABdhPJxpjX8n64CNpynsV7rXLgvhqlBapjm6BJpjFtDA+acvlRFOkEqws7aNe93GzskC0mJwd9lU+A==
X-Received: by 2002:adf:db8b:0:b0:207:9a90:3819 with SMTP id u11-20020adfdb8b000000b002079a903819mr15505369wri.617.1650448618996;
        Wed, 20 Apr 2022 02:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b0038ffadd6e4asm17683358wms.30.2022.04.20.02.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:58 -0700 (PDT)
Message-Id: <d3afa85ffc5f67722859b739eff3c91959482e48.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:47 +0000
Subject: [PATCH v2 4/8] rebase --merge: fix reflog message after skipping
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for every pick after running "rebase --skip" looks
like

	rebase (skip) (pick): commit subject line

Fix this by not appending " (skip)" to the reflog action.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  2 --
 t/t3406-rebase-message.sh | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cd9a4f3e2f1..36863117fba 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1273,8 +1273,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		options.action = "skip";
-		set_reflog_action(&options);
-
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 3ca2fbb0d59..8aa6a79acc1 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -163,6 +163,30 @@ test_reflog () {
 	# check there is only one new entry in the branch reflog
 	test_cmp_rev fast-forward@{1} X
 	'
+
+	test_expect_success "rebase $mode --skip reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --skip
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget

