Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A261F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 10:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404121AbfAPKcZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 05:32:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42206 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbfAPKcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 05:32:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so2649674pga.9
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GEeGQp+YLgKeQb9Zfqqzn9tXJ5SYGiJHFn5ZaMRJ7U=;
        b=aI2U48BPW3C6lJRKZ2/fDW04tTlG9CV7hCk8HzNLQFB4fScfCatbxf6r9bSGD5a0rt
         jfqSKzn419gfDaWB0aDj6Y+7Ufupe/mqH2JJ11gvuYhn78tk7xV7/+BpmW4jZKDD3uCT
         mh+uk9pWRifz6TkWm3KmvUcreus1+Zpw/Dp4FXQG0c6LzJ4+wjgQIJsfUcnezzPfN/Qc
         TwbQRISJOV2fSK2IWX0TxBb/1UQ+WKFQddUT6rH02mdV9izBIBr9OO4+VjuFG+BX0nXW
         ggkWLiTOBG5Q9voWeRH6q0euRMZ8+FL1yF6KYGyvIOENjHR55C1/Z8a+Sf2QjBxZENZB
         ndQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GEeGQp+YLgKeQb9Zfqqzn9tXJ5SYGiJHFn5ZaMRJ7U=;
        b=AIjuS+hwWYgd5K6GhZfuaL+9aDE6JLl5yq7jVsAtnee1+cjkRZOyQF2HXrgjWbYeJy
         +CCRPribG//lEIQ4+gGwosjW9ZGFYAziqinsY4w8Wvl4VO8r3FgxWyxsna/HLNte6HEN
         Xzv5C68+f2ZKmZY0bGZqsu5KJih+1P+6JZnSSJBAfxDFrDypsTWjlvWiynHWDVhX7LVS
         2CV/DnpXCKdciK6VshXQaE6QjlqfR1s60ScEAn7IcujAFb4Jc+M6ptP2X6jXzkvoz79/
         XpM1S9sCijdcvxrgwCKm4PnGEwLR749u9hzhqCrfZOLpNIQCIIztMg/JwosxOVfGr/2v
         XWxg==
X-Gm-Message-State: AJcUukf1/KVyUSvwxDqnZPWpLn2SrYqKNHHJ3gOYkPz6+mKhkjLIagRj
        mm4f9uYrZY/BGjry0wDQWC+HfwR3
X-Google-Smtp-Source: ALg8bN4skkhrIWihitvzvz0eQ2l8C0ZQGNQjMGOkNv0ARlHMVhHIeZV5ZffBeO1ibHB760kC5vv/sw==
X-Received: by 2002:a62:425b:: with SMTP id p88mr9155624pfa.137.1547634743785;
        Wed, 16 Jan 2019 02:32:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y84sm16692885pfb.81.2019.01.16.02.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 02:32:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 16 Jan 2019 17:32:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, tsniatowski@vewd.com,
        Jonathan Nieder <jrnieder@gmail.com>, marcnarc@xiplink.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/10] submodule add: support multiple worktrees
Date:   Wed, 16 Jan 2019 17:31:52 +0700
Message-Id: <20190116103159.9305-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190116103159.9305-1-pclouds@gmail.com>
References: <20190116103159.9305-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The entire submodule section in the superproject will be per-worktree
and written to $GIT_DIR/config.worktree.

The behavior when you only have one worktree (and not enabled
extensions.worktreeConfig) is the same as before, everything is still
written in $GIT_DIR/config

'submodule-helper config --check-writable' also checks if it's
supported worktree configuration.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/submodule--helper.c    | 17 +++++++++++++-
 git-submodule.sh               |  8 +++----
 t/t2405-worktree-submodules.sh | 42 ++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 6 deletions(-)
 create mode 100755 t/t2405-worktree-submodules.sh

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 232bfaac7f..7b328ec060 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -18,6 +18,7 @@
 #include "diffcore.h"
 #include "diff.h"
 #include "object-store.h"
+#include "worktree.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -27,6 +28,18 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
+static void check_multi_worktree_support(void)
+{
+	char *worktree_config = get_worktree_config(the_repository);
+	if (!worktree_config)
+		die(_("submodules cannot be used with multiple "
+		      "working trees unless the config\n"
+		      "extension worktreeConfig is enabled. "
+		      "Please read \"CONFIGURATION FILE\"\n"
+		      "section in \"git help worktree\" for details"));
+	free(worktree_config);
+}
+
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
@@ -2162,8 +2175,10 @@ static int module_config(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_config_options,
 			     git_submodule_helper_usage, PARSE_OPT_KEEP_ARGV0);
 
-	if (argc == 1 && command == CHECK_WRITEABLE)
+	if (argc == 1 && command == CHECK_WRITEABLE) {
+		check_multi_worktree_support();
 		return is_writing_gitmodules_ok() ? 0 : -1;
+	}
 
 	/* Equivalent to ACTION_GET in builtin/config.c */
 	if (argc == 2)
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e608f8bad..695939eff9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -288,7 +288,7 @@ or you are unsure what this means choose another name with the '--name' option."
 			esac
 		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
 	fi
-	git config submodule."$sm_name".url "$realrepo"
+	git config --worktree submodule."$sm_name".url "$realrepo"
 
 	git add --no-warn-embedded-repo $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
@@ -302,18 +302,16 @@ or you are unsure what this means choose another name with the '--name' option."
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
 
-	# NEEDSWORK: In a multi-working-tree world, this needs to be
-	# set in the per-worktree config.
 	if git config --get submodule.active >/dev/null
 	then
 		# If the submodule being adding isn't already covered by the
 		# current configured pathspec, set the submodule's active flag
 		if ! git submodule--helper is-active "$sm_path"
 		then
-			git config submodule."$sm_name".active "true"
+			git config --worktree submodule."$sm_name".active "true"
 		fi
 	else
-		git config submodule."$sm_name".active "true"
+		git config --worktree submodule."$sm_name".active "true"
 	fi
 }
 
diff --git a/t/t2405-worktree-submodules.sh b/t/t2405-worktree-submodules.sh
new file mode 100755
index 0000000000..3ee5380e88
--- /dev/null
+++ b/t/t2405-worktree-submodules.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='multiple worktrees as superprojects'
+
+. ./test-lib.sh
+
+test_expect_success 'set up submodule source' '
+	test_create_repo submodsrc &&
+	(
+		cd submodsrc &&
+		test_commit one
+	) &&
+	test_commit initial &&
+	git worktree add -b secondary secondary HEAD &&
+	git config extensions.worktreeConfig true
+'
+
+test_expect_success 'add submodules' '
+	SRC="$(pwd)/submodsrc" &&
+	git submodule add "$SRC" sub1 &&
+	git commit -m sub1 &&
+	git -C secondary submodule add "$SRC" sub2 &&
+	git -C secondary commit -m sub2 &&
+
+	git config --get-regexp "submodule.*" | sort >actual1 &&
+	cat >expected1 <<-EOF &&
+	submodule.sub1.active true
+	submodule.sub1.url $(pwd)/submodsrc
+	EOF
+	test_cmp expected1 actual1 &&
+	test -d .git/modules/sub1 &&
+
+	git -C secondary config --get-regexp "submodule.*" | sort >actual2 &&
+	cat >expected2 <<-EOF &&
+	submodule.sub2.active true
+	submodule.sub2.url $(pwd)/submodsrc
+	EOF
+	test_cmp expected2 actual2 &&
+	test -d .git/worktrees/secondary/modules/sub2
+'
+
+test_done
-- 
2.20.0.482.g66447595a7

