Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C02FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiDTKAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 06:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377369AbiDTJ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:50 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAF73B003
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so890945wms.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DbmCoZwypBuMMIe4XObqTM7EOQuZ449bEHECh/zC6tc=;
        b=EsPs09eOep3qj10k3Qe14H9GxYcBFzxv8nB7xqNtrw8jNSUAKRVnqBhMX1UQGPKf1Q
         wprwkTdjynfxz5smN2/DEOyuXgIQ1N4aNDULZuT2sYDu3Fc0au5219Certq2+mEI86ET
         CtjdlFs0a7gh7FZDUzG8sBi4WhxiIr+NTaAew+IvBEL/rcL/7QJj1Dbb5x8+kt5ZWmVR
         /pmCIfnZcsWM5HAfifraB9irfejsj3CsYBsI5ks25ERnxGRqDo/rFWulcN2M+JO63FeF
         jAYU/FrHeXcRWn7cyJmAxGrguk3DzSDFri80fNLq9ujTvUcE1T9jAY98AFPp/pKdayZr
         Isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DbmCoZwypBuMMIe4XObqTM7EOQuZ449bEHECh/zC6tc=;
        b=RKG8wTqb4tKk+L5CcEo8wSV3VIFL5zp0D1YV/US0wdFAVJDBbst/pBu14q6G2wseO4
         KqTySThDoSZHPy02T+HN2SWxH+CxzVDxwDHleGrr5RO6o2fXHx7J7do9QgtdLDB/gDL0
         jgC8x0a1xp39kzLcEEGmBIiBGP3EpPSIN/Xvjz6bmrenY6+pWrSaiMHbPkRFEMXdBzyX
         vJlBW/XpLszJ0n3pbU7dVahZCTAYTGd11mCOZHxIIxr1aoFaaHML+76fxolWoFnVF9qv
         phuB+wonKSljYHeFBqZfARIfrQfHbvDSGd50NfYZlM/i4rcMafZSXxyrJaCaYRet3S9b
         /EOQ==
X-Gm-Message-State: AOAM531aJ5mSXWvoKxs0ne6xXBctyHjxPL7Z2DxBwyriBh3gESixJt4K
        G3fikimYuARmLB3eCFL+9wVqCwA3vIk=
X-Google-Smtp-Source: ABdhPJxceMbfmndN/ovj9HGTSFgenm0FDxs6+f+UtFqX8RR+KEH29Bmp+a6Kk8wDw2HgvjMIfakTcQ==
X-Received: by 2002:a05:600c:3585:b0:392:90a9:41dc with SMTP id p5-20020a05600c358500b0039290a941dcmr2886454wmq.4.1650448622885;
        Wed, 20 Apr 2022 02:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020adfed45000000b00207a480e6aasm14898337wro.116.2022.04.20.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:57:02 -0700 (PDT)
Message-Id: <d2c1dfbcd5e52bcc3f6040da088fc86b7a506579.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:50 +0000
Subject: [PATCH v2 7/8] rebase --abort: improve reflog message
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

When aborting a rebase the reflog message looks like

	rebase (abort): updating HEAD

which is not very informative. Improve the message by mentioning the
branch that we are returning to as we do at the end of a successful
rebase so it looks like.

	rebase (abort): returning to refs/heads/topic

If GIT_REFLOG_ACTION is set in the environment we no longer omit
"(abort)" from the reflog message. We don't omit "(start)" and
"(finish)" when starting and finishing a rebase in that case so we
shouldn't omit "(abort)".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 28 ++++++---------------
 t/t3406-rebase-message.sh | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 678339c7bf7..70426e17b40 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -992,23 +992,6 @@ static void NORETURN error_on_missing_default_upstream(void)
 	exit(1);
 }
 
-static void set_reflog_action(struct rebase_options *options)
-{
-	const char *env;
-	struct strbuf buf = STRBUF_INIT;
-
-	if (!is_merge(options))
-		return;
-
-	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	if (env && strcmp("rebase", env))
-		return; /* only override it if it is "rebase" */
-
-	strbuf_addf(&buf, "rebase (%s)", options->action);
-	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
-	strbuf_release(&buf);
-}
-
 static int check_exec_cmd(const char *cmd)
 {
 	if (strchr(cmd, '\n'))
@@ -1287,18 +1270,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 	case ACTION_ABORT: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
-		options.action = "abort";
-		set_reflog_action(&options);
+		struct strbuf head_msg = STRBUF_INIT;
 
+		options.action = "abort";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
 			exit(1);
+
+		strbuf_addf(&head_msg, "%s (abort): returning to %s",
+			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+			    options.head_name ? options.head_name
+					      : oid_to_hex(&options.orig_head));
 		ropts.oid = &options.orig_head;
+		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
-		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5c6cd9af3bc..ceca1600053 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -187,6 +187,57 @@ test_reflog () {
 	EOF
 	test_cmp expect actual
 	'
+
+	test_expect_success "rebase $mode --abort reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	git log -g -1 conflicts >branch-expect &&
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual &&
+
+	# check branch reflog is unchanged
+	git log -g -1 conflicts >branch-actual &&
+	test_cmp branch-expect branch-actual
+	'
+
+	test_expect_success "rebase $mode --abort detached HEAD reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout Q &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to $(git rev-parse Q)
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget

