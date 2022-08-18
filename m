Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F8C28B2B
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiHRVlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347033AbiHRVk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:40:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B570ABD28E
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so3197464wmk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=hQq/+3jqAtLxzZd6175GBBSWucnabx+T9S8n8vEc/7E=;
        b=L8efHFyuJ3TZEsqRQNepNyYoswRLVN4qYd6ht99yVjC/cuThw6esFBvukoRBTk++iV
         kCCjUahSUylhOxaFG4twlBTBqbfdXMgwIp5k8gzHkxaA7uPiWNqRfuxIFrty0Rdx6pgU
         eeGHxc2vvaJDxtk89TR6GzHJmH+im3rmbg4P8JxeciV3iLgaoinBPd6chTggYBy9kAVV
         +8XZW2qncVnACqNz+kgHCJAD01MPjYNQ08Ko4vsk5dL/STOscFzVTRXwh211VCSTogyl
         EnpYe8+3So1BmKC1mx4ZNHUsTjO3Fc3V/9FAHftQSTZkJHUBqv/QOrVbimfl4jO/9uUX
         Eq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=hQq/+3jqAtLxzZd6175GBBSWucnabx+T9S8n8vEc/7E=;
        b=DpBhLfZ3K2exTBYe8sVP0kf/g6b14/kAn2t0dRjthmtK4ljekQs3knFIC1gePfp0Gw
         IXr8WuG0W3e3rcRaCY5eVO/dvodQX9zSuSroB/fArBKarP6YvWQzkT63JpToz9PSD6In
         +FODi0Nz7NVTBqYl7BX4YPFcG8VBO5V9NhQ9CjwwNNkdeWJ3AK2LUshABRAjzNx3+Mku
         42JctZaGrtfm2RN/jubjwfP6QsrDSbnK+K+9JlqH+RTTvE48UQ4oLYhXK5m6IPSPV1mR
         jF0r+XUfIO2C2tZPnhGqezbgDH4CBG6a6q+UWw25xRR8zCYawdQZ6uVYrduiVfXHeu3w
         p14w==
X-Gm-Message-State: ACgBeo2aaLAk6MIniEwZA9QxGlKFIN7r6T4+k3m8WKPiYWkCNvBdzGyv
        XSNKRG5vCE4or51kVDnNI8DDX7IrGxA=
X-Google-Smtp-Source: AA6agR6S9PT/FbJttXFunhb7MD0inQQ7RAVwZJZfCrTvSJUs0X9mSM2qqNkkaBm4VgVbOphsxXh3Jw==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id be13-20020a05600c1e8d00b003a5e37f6fd2mr6130353wmb.33.1660858855908;
        Thu, 18 Aug 2022 14:40:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d6d46000000b00225221fd286sm2342201wri.114.2022.08.18.14.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 14:40:55 -0700 (PDT)
Message-Id: <2f6cad8361324cecdb0ee7b13a96477a8317c358.1660858853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
        <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 21:40:46 +0000
Subject: [PATCH v3 1/8] scalar: constrain enlistment search
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Make the search for repository and enlistment root in
'setup_enlistment_directory()' more constrained to simplify behavior and
adhere to 'GIT_CEILING_DIRECTORIES'.

Previously, 'setup_enlistment_directory()' would check whether the provided
path (or current working directory) '<dir>' or its subdirectory '<dir>/src'
was a repository root. If not, the process would repeat on the parent of
'<dir>' until the repository was found or it reached the root of the
filesystem. This meant that a user could specify a path *anywhere* inside an
enlistment (including paths not in the repository contained within the
enlistment) and it would be found.

The downside to this process is that the search would not account for
'GIT_CEILING_DIRECTORIES', so the upward search could result in modifying
repository contents past 'GIT_CEILING_DIRECTORIES'. Similarly, operations
like 'scalar delete' could end up unintentionally deleting the parent of a
repo if its root was named 'src'.

To make this 'setup_enlistment_directory()' both adhere to
'GIT_CEILING_DIRECTORIES' and avoid unwanted deletions, the search for an
enlistment directory is simplified to:

- if '<dir>/src' is a repository root, '<dir>' is the enlistment root
- if '<dir>' is either the repository root or contained within a repository,
  the repository root is the enlistment root

Now, only 'setup_git_directory()' (called by 'setup_enlistment_directory()')
searches upwards from the 'scalar' specified path, enforcing
'GIT_CEILING_DIRECTORIES' in the process. Additionally, 'scalar delete
<dir>/src' will not delete '<dir>' (if users would like to delete it, they
can still specify the enlistment root with 'scalar delete <dir>'). This is
true of any 'scalar' operation; users can invoke 'scalar' on the enlistment
root, but paths must otherwise be inside the repository to be valid.

To help clarify the updated behavior, new tests are added to
't9099-scalar.sh'.

Finally, this change leaves 'strbuf_parent_directory()' with only a single,
WIN32-specific caller in 'delete_enlistment()'. Rather than wrap
'strbuf_parent_directory()' in '#ifdef WIN32' to avoid the "unused function"
compiler error, move the contents of 'strbuf_parent_directory()' into
'delete_enlistment()' and remove the function.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c          | 82 +++++++++++-------------------
 contrib/scalar/t/t9099-scalar.sh | 85 ++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 54 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 97e71fe19cd..92b648f3511 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -14,29 +14,14 @@
 #include "archive.h"
 #include "object-store.h"
 
-/*
- * Remove the deepest subdirectory in the provided path string. Path must not
- * include a trailing path separator. Returns 1 if parent directory found,
- * otherwise 0.
- */
-static int strbuf_parent_directory(struct strbuf *buf)
-{
-	size_t len = buf->len;
-	size_t offset = offset_1st_component(buf->buf);
-	char *path_sep = find_last_dir_sep(buf->buf + offset);
-	strbuf_setlen(buf, path_sep ? path_sep - buf->buf : offset);
-
-	return buf->len < len;
-}
-
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
 				       const struct option *options,
 				       struct strbuf *enlistment_root)
 {
 	struct strbuf path = STRBUF_INIT;
-	char *root;
-	int enlistment_found = 0;
+	int enlistment_is_repo_parent = 0;
+	size_t len;
 
 	if (startup_info->have_repository)
 		BUG("gitdir already set up?!?");
@@ -49,51 +34,36 @@ static void setup_enlistment_directory(int argc, const char **argv,
 		strbuf_add_absolute_path(&path, argv[0]);
 		if (!is_directory(path.buf))
 			die(_("'%s' does not exist"), path.buf);
+		if (chdir(path.buf) < 0)
+			die_errno(_("could not switch to '%s'"), path.buf);
 	} else if (strbuf_getcwd(&path) < 0)
 		die(_("need a working directory"));
 
 	strbuf_trim_trailing_dir_sep(&path);
-	do {
-		const size_t len = path.len;
-
-		/* check if currently in enlistment root with src/ workdir */
-		strbuf_addstr(&path, "/src");
-		if (is_nonbare_repository_dir(&path)) {
-			if (enlistment_root)
-				strbuf_add(enlistment_root, path.buf, len);
-
-			enlistment_found = 1;
-			break;
-		}
 
-		/* reset to original path */
-		strbuf_setlen(&path, len);
-
-		/* check if currently in workdir */
-		if (is_nonbare_repository_dir(&path)) {
-			if (enlistment_root) {
-				/*
-				 * If the worktree's directory's name is `src`, the enlistment is the
-				 * parent directory, otherwise it is identical to the worktree.
-				 */
-				root = strip_path_suffix(path.buf, "src");
-				strbuf_addstr(enlistment_root, root ? root : path.buf);
-				free(root);
-			}
+	/* check if currently in enlistment root with src/ workdir */
+	len = path.len;
+	strbuf_addstr(&path, "/src");
+	if (is_nonbare_repository_dir(&path)) {
+		enlistment_is_repo_parent = 1;
+		if (chdir(path.buf) < 0)
+			die_errno(_("could not switch to '%s'"), path.buf);
+	}
+	strbuf_setlen(&path, len);
 
-			enlistment_found = 1;
-			break;
-		}
-	} while (strbuf_parent_directory(&path));
+	setup_git_directory();
 
-	if (!enlistment_found)
-		die(_("could not find enlistment root"));
+	if (!the_repository->worktree)
+		die(_("Scalar enlistments require a worktree"));
 
-	if (chdir(path.buf) < 0)
-		die_errno(_("could not switch to '%s'"), path.buf);
+	if (enlistment_root) {
+		if (enlistment_is_repo_parent)
+			strbuf_addbuf(enlistment_root, &path);
+		else
+			strbuf_addstr(enlistment_root, the_repository->worktree);
+	}
 
 	strbuf_release(&path);
-	setup_git_directory();
 }
 
 static int run_git(const char *arg, ...)
@@ -431,6 +401,8 @@ static int delete_enlistment(struct strbuf *enlistment)
 {
 #ifdef WIN32
 	struct strbuf parent = STRBUF_INIT;
+	size_t offset;
+	char *path_sep;
 #endif
 
 	if (unregister_dir())
@@ -441,8 +413,10 @@ static int delete_enlistment(struct strbuf *enlistment)
 	 * Change the current directory to one outside of the enlistment so
 	 * that we may delete everything underneath it.
 	 */
-	strbuf_addbuf(&parent, enlistment);
-	strbuf_parent_directory(&parent);
+	offset = offset_1st_component(enlistment->buf);
+	path_sep = find_last_dir_sep(enlistment->buf + offset);
+	strbuf_add(&parent, enlistment->buf,
+		   path_sep ? path_sep - enlistment->buf : offset);
 	if (chdir(parent.buf) < 0)
 		die_errno(_("could not switch to '%s'"), parent.buf);
 	strbuf_release(&parent);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 10b1172a8aa..c069cffebfe 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -17,6 +17,91 @@ test_expect_success 'scalar shows a usage' '
 	test_expect_code 129 scalar -h
 '
 
+test_expect_success 'scalar invoked on enlistment root' '
+	test_when_finished rm -rf test src deeper &&
+
+	for enlistment_root in test src deeper/test
+	do
+		git init ${enlistment_root}/src &&
+
+		# Register
+		scalar register ${enlistment_root} &&
+		scalar list >out &&
+		grep "$(pwd)/${enlistment_root}/src\$" out &&
+
+		# Delete (including enlistment root)
+		scalar delete $enlistment_root &&
+		test_path_is_missing $enlistment_root &&
+		scalar list >out &&
+		! grep "^$(pwd)/${enlistment_root}/src\$" out || return 1
+	done
+'
+
+test_expect_success 'scalar invoked on enlistment src repo' '
+	test_when_finished rm -rf test src deeper &&
+
+	for enlistment_root in test src deeper/test
+	do
+		git init ${enlistment_root}/src &&
+
+		# Register
+		scalar register ${enlistment_root}/src &&
+		scalar list >out &&
+		grep "$(pwd)/${enlistment_root}/src\$" out &&
+
+		# Delete (will not include enlistment root)
+		scalar delete ${enlistment_root}/src &&
+		test_path_is_dir $enlistment_root &&
+		scalar list >out &&
+		! grep "^$(pwd)/${enlistment_root}/src\$" out || return 1
+	done
+'
+
+test_expect_success 'scalar invoked when enlistment root and repo are the same' '
+	test_when_finished rm -rf test src deeper &&
+
+	for enlistment_root in test src deeper/test
+	do
+		git init ${enlistment_root} &&
+
+		# Register
+		scalar register ${enlistment_root} &&
+		scalar list >out &&
+		grep "$(pwd)/${enlistment_root}\$" out &&
+
+		# Delete (will not include enlistment root)
+		scalar delete ${enlistment_root} &&
+		test_path_is_missing $enlistment_root &&
+		scalar list >out &&
+		! grep "^$(pwd)/${enlistment_root}\$" out &&
+
+		# Make sure we did not accidentally delete the trash dir
+		test_path_is_dir "$TRASH_DIRECTORY" || return 1
+	done
+'
+
+test_expect_success 'scalar repo search respects GIT_CEILING_DIRECTORIES' '
+	test_when_finished rm -rf test &&
+
+	git init test/src &&
+	mkdir -p test/src/deep &&
+	GIT_CEILING_DIRECTORIES="$(pwd)/test/src" &&
+	! scalar register test/src/deep 2>err &&
+	grep "not a git repository" err
+'
+
+test_expect_success 'scalar enlistments need a worktree' '
+	test_when_finished rm -rf bare test &&
+
+	git init --bare bare/src &&
+	! scalar register bare/src 2>err &&
+	grep "Scalar enlistments require a worktree" err &&
+
+	git init test/src &&
+	! scalar register test/src/.git 2>err &&
+	grep "Scalar enlistments require a worktree" err
+'
+
 test_expect_success 'scalar unregister' '
 	git init vanish/src &&
 	scalar register vanish/src &&
-- 
gitgitgadget

