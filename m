Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCCEC433F5
	for <git@archiver.kernel.org>; Sun, 20 Mar 2022 21:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343759AbiCTV4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Mar 2022 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343754AbiCTV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Mar 2022 17:56:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C80E0F3
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q20so7570934wmq.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2022 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Juwv5Cy7+lSwZA4MJAFTHbhbw/7/VfeRQSW9/T8wlo4=;
        b=RS93do33SMvK33pa8s078Gsc3lP9pkQB3iTWFsFVf8wJN9RSmw6csZNHP/AwkbKLlB
         xjOPk7qLVirX1xZl6erRo/ya2dgpyM3009MYlP0czTDe3Mc2TZrlVDJNRSv4C/PhR5NZ
         4+CEprx/UKvvef+hkMvgD4++bhMRw/ckPBoemxCZswp4eCrHPon+Y25OFcZPDPGp0cAe
         z4X5YRbcK67UCM99JvU/elC+AKDubbDyG0J+bHhf6Wky5RPVvEdExHamAxicv/JNhjfe
         ch2E1QZi8X7Pxa6VMQCyPfB2st+sggPXgLKBmNMMnsQD54GQweGvTeU17NCGklLKqKDl
         pCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Juwv5Cy7+lSwZA4MJAFTHbhbw/7/VfeRQSW9/T8wlo4=;
        b=KYdcVZERjRg0CJsLQeBtNR02Gke2nMIaNfYqOXuFBgR4TBzo9c42GjMcDnBzFH9Lct
         7kgVgxsowRpmKl6cmIE+bf49kiRVT8Jp+kVK1rbEcPWsxAmOvO+oWqjgyqAiQI5+hcfY
         Jvh5IrfzUfTCgYfYzOxaMycoRmYrJv0k+cu+GqJRzR5z52llt8oL8CGLGcRxs28+NhZP
         VoT4cP9p3GdaUZJrdTXFlWj8ACpVfiJBqN/nnzH3HHUQfdujirDoIWfkF3d4BgGYoEsM
         0X2DaZPs4nIKvw30tbYMuyqJVL+yQep1X/JPcatU87/cVKih9pavsWFVDfv/W7pvxh+U
         fHUA==
X-Gm-Message-State: AOAM530XGkhp5ngl99usMmHREFfBmCRGwscz8YvIQdDXFEe1nvhkd4Si
        bG3p35XYgbYrKEQjmFrRsTHpU6ZQcPk=
X-Google-Smtp-Source: ABdhPJy91FZf8+kAl6XlMLrnGcYLrcjxKweNF2MvNqL/c57MexDJVVh5mjcoGwu8Xn66ixtzcY8lfg==
X-Received: by 2002:a05:600c:190e:b0:389:d9cf:1cf1 with SMTP id j14-20020a05600c190e00b00389d9cf1cf1mr16919781wmq.150.1647813294581;
        Sun, 20 Mar 2022 14:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020adfd1e6000000b00203f8effc22sm10740187wrd.63.2022.03.20.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 14:54:54 -0700 (PDT)
Message-Id: <73a3a8d7d97e00c94d891e30b96729e65ee4aede.1647813291.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 20 Mar 2022 21:54:45 +0000
Subject: [PATCH 1/7] i18n: factorize generic failure messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

In these message the command that failed should not be translated. So
it is simpler to just remove these parts from the message.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 add-patch.c                     | 4 ++--
 builtin/am.c                    | 2 +-
 builtin/gc.c                    | 4 ++--
 builtin/merge.c                 | 6 +++---
 builtin/revert.c                | 4 ++--
 fetch-pack.c                    | 2 +-
 remote-curl.c                   | 2 +-
 setup.c                         | 4 ++--
 t/t3510-cherry-pick-sequence.sh | 8 ++++----
 t/t6436-merge-overwrite.sh      | 2 +-
 10 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 55d719f7845..d545dea2ff2 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1181,7 +1181,7 @@ static int run_apply_check(struct add_p_state *s,
 			    "apply", "--check", NULL);
 	strvec_pushv(&cp.args, s->mode->apply_check_args);
 	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
-		return error(_("'git apply --cached' failed"));
+		return error(_("'%s' failed"), "git apply --cached");
 
 	return 0;
 }
@@ -1683,7 +1683,7 @@ soft_increment:
 			strvec_pushv(&cp.args, s->mode->apply_args);
 			if (pipe_command(&cp, s->buf.buf, s->buf.len,
 					 NULL, 0, NULL, 0))
-				error(_("'git apply' failed"));
+				error(_("'%s' failed"), "git apply");
 		}
 		if (repo_read_index(s->s.r) >= 0)
 			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
diff --git a/builtin/am.c b/builtin/am.c
index 0f4111bafa0..b26a55318e7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -586,7 +586,7 @@ static int is_mail(FILE *fp)
 	int ret = 1;
 
 	if (fseek(fp, 0L, SEEK_SET))
-		die_errno(_("fseek failed"));
+		die_errno(_("'%s' failed"), "fseek");
 
 	if (regcomp(&regex, header_regex, REG_NOSUB | REG_EXTENDED))
 		die("invalid pattern: %s", header_regex);
diff --git a/builtin/gc.c b/builtin/gc.c
index ffaf0daf5d9..d512c127b99 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1104,7 +1104,7 @@ static int multi_pack_index_expire(struct maintenance_run_opts *opts)
 		strvec_push(&child.args, "--no-progress");
 
 	if (run_command(&child))
-		return error(_("'git multi-pack-index expire' failed"));
+		return error(_("'%s' failed"), "git multi-pack-index expire");
 
 	return 0;
 }
@@ -1163,7 +1163,7 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 				  (uintmax_t)get_auto_pack_size());
 
 	if (run_command(&child))
-		return error(_("'git multi-pack-index repack' failed"));
+		return error(_("'%s' failed"), "git multi-pack-index repack");
 
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee1..3155f116610 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -325,7 +325,7 @@ static int save_state(struct object_id *stash)
 	close(cp.out);
 
 	if (finish_command(&cp) || len < 0)
-		die(_("stash failed"));
+		die(_("'%s' failed"), "stash");
 	else if (!len)		/* no changes */
 		goto out;
 	strbuf_setlen(&buffer, buffer.len-1);
@@ -352,7 +352,7 @@ static void read_empty(const struct object_id *oid, int verbose)
 	args[i] = NULL;
 
 	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die(_("read-tree failed"));
+		die(_("'%s' failed"), "read-tree");
 }
 
 static void reset_hard(const struct object_id *oid, int verbose)
@@ -369,7 +369,7 @@ static void reset_hard(const struct object_id *oid, int verbose)
 	args[i] = NULL;
 
 	if (run_command_v_opt(args, RUN_GIT_CMD))
-		die(_("read-tree failed"));
+		die(_("'%s' failed"), "read-tree");
 }
 
 static void restore_state(const struct object_id *head,
diff --git a/builtin/revert.c b/builtin/revert.c
index 51776abea63..ed032eaf0f8 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -238,7 +238,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
-		die(_("revert failed"));
+		die(_("'%s' failed"), "revert");
 	return res;
 }
 
@@ -251,6 +251,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
-		die(_("cherry-pick failed"));
+		die(_("'%s' failed"), "cherry-pick");
 	return res;
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 87657907e78..09b1cf6173a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -989,7 +989,7 @@ static int get_pack(struct fetch_pack_args *args,
 			args->check_self_contained_and_connected &&
 			ret == 0;
 	else
-		die(_("%s failed"), cmd_name);
+		die(_("'%s' failed"), cmd_name);
 	if (use_sideband && finish_async(&demux))
 		die(_("error in sideband demultiplexer"));
 
diff --git a/remote-curl.c b/remote-curl.c
index ff44f41011e..28619583ec5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1287,7 +1287,7 @@ static int push_dav(int nr_spec, const char **specs)
 		strvec_push(&child.args, specs[i]);
 
 	if (run_command(&child))
-		die(_("git-http-push failed"));
+		die(_("'%s' failed"), "git-http-push");
 	return 0;
 }
 
diff --git a/setup.c b/setup.c
index 04ce33cdcd4..3d123cc11fd 100644
--- a/setup.c
+++ b/setup.c
@@ -1506,12 +1506,12 @@ int daemonize(void)
 		case 0:
 			break;
 		case -1:
-			die_errno(_("fork failed"));
+			die_errno(_("'%s' failed"), "fork");
 		default:
 			exit(0);
 	}
 	if (setsid() == -1)
-		die_errno(_("setsid failed"));
+		die_errno(_("'%s' failed"), "setsid");
 	close(0);
 	close(1);
 	close(2);
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3b0fa66c33d..75a3fbd469b 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -193,7 +193,7 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	error: there is nothing to skip
 	hint: have you committed already?
 	hint: try "git cherry-pick --continue"
-	fatal: cherry-pick failed
+	fatal: '\''cherry-pick'\'' failed
 	EOF
 	test_must_fail git cherry-pick base..yetanotherpick &&
 	echo c >foo &&
@@ -208,7 +208,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	cat >expect <<-EOF &&
 	error: cherry-pick is already in progress
 	hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
-	fatal: cherry-pick failed
+	fatal: '\''cherry-pick'\'' failed
 	EOF
 	test_must_fail git cherry-pick picked..yetanotherpick &&
 	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
@@ -216,7 +216,7 @@ test_expect_success 'selectively advise --skip while launching another sequence'
 	cat >expect <<-EOF &&
 	error: cherry-pick is already in progress
 	hint: try "git cherry-pick (--continue | --abort | --quit)"
-	fatal: cherry-pick failed
+	fatal: '\''cherry-pick'\'' failed
 	EOF
 	git reset --merge &&
 	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
@@ -227,7 +227,7 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
 	pristine_detach initial &&
 	cat >expect <<-EOF &&
 	error: cannot abort from a branch yet to be born
-	fatal: cherry-pick failed
+	fatal: '\''cherry-pick'\'' failed
 	EOF
 	git checkout --orphan new_disconnected &&
 	git reset --hard &&
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index c0b7bd7c3fe..e8abcd10f5c 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -166,7 +166,7 @@ test_expect_success 'will not be confused by symlink in leading path' '
 
 cat >expect <<\EOF
 error: Untracked working tree file 'c0.c' would be overwritten by merge.
-fatal: read-tree failed
+fatal: 'read-tree' failed
 EOF
 
 test_expect_success 'will not overwrite untracked file on unborn branch' '
-- 
gitgitgadget

