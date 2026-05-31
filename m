Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4FC31352B
	for <git@vger.kernel.org>; Sun, 31 May 2026 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780253085; cv=none; b=psc6EDnrBycGiLnvKPvUqcpU8bkLdyvrQqBk3ypjcE6Dl1ws9pMdyZIRFZE8X7kDdQ0AT8TezQX4GEH2Z5degGFbnQC07PfQn4bLMY+hqgnWzxxUe+dZJGa+idXQAcHbRigCu+x6MdJ0RVS0+o9hiOOrd3xKwR+W9N/QZTeHGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780253085; c=relaxed/simple;
	bh=0uQnQovcD3JsjitumO3LN9s2w5wq/IzMBsUtxeQY5h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJwhTUaMRdfeNC7YIybC85Wb24uqrGeUFpwsL8rxiVs+xuKcHacLHMSd/de1PCLVpnPWOjV4+fE8E5hFHatmv9x/zCJINX6iY9RxjMYr5sHtpM2/diYp5R4msqF2v6UVwaVundU89B70UBaNZxTXpW0lFIcqqhazGH15RKoj0vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY9beor4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY9beor4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a765f2feso6502935e9.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780253081; x=1780857881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V8p7q76sVzp/rbiLEzocLiHs6+E56rFezWSSL+Nf/E=;
        b=bY9beor4/MAUYz/WjgGWIHA92g+AkriFEuOfaNgTpmCxGqI83jfV5Nw7Wq2UcFgWTA
         F1tM8/aRZLKM0UrHum1DprJ42zVr7RfMr0UbZ/+b6v9lIwlfZeuDa9ZSLYgEocwImM4C
         VXXNi95qYHv0C8x2sPkApJyhwvn1xepGoxqc8nPEeFX8VykrpvGg7NN+shdLrRj20sR7
         5RVdQyYaWRP2rAWKJOEbk8gkTtenMIvb/Q82DK+Z/q6jRzgFrI4xkNlmNJfPEPLaEuSL
         QRZjvy/5krOZCY9GQCifq74CPU7TuknGl+juudURhrmBfm4V8hz3NzewYxevHFoOcXvV
         4BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780253081; x=1780857881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4V8p7q76sVzp/rbiLEzocLiHs6+E56rFezWSSL+Nf/E=;
        b=I7gWEVljE+AvvL+7SsLWrhZFOdcAQ5yJvWU5IIb5LhJBmRMfF5jS6B9ZRdf0ZkLAU1
         f1OKumxHyyMxF1UPZqNENZ8syDojXK2qFSrVx6WK8CY3bhihoRdMmUpqEgy5E6/CxcvX
         lP3kd/vpJhWXA8kHK7cn8PhTH8IuIHl6f68Jk+k63KfUePLLzmfvIHxlner1X9YZXsKC
         4k81dHxjTlhb77Xfthh89Bj3CgwbSuQxooZ/xofg7yUlCIpPbTgCLHB/yQnbZ4fK+Ho7
         PeVsLpldctQfJlnJk/nrC/AjUmYaYuMZ8wADyGuQfrb8CtzvzZ8BnJGWvUOgR4jmp75e
         RNXg==
X-Gm-Message-State: AOJu0YwVARj+RZhW6BTM4mBJBohD5QQGw3BGZ0hTVxWy/eehNv4vKgmR
	9whfyC+tYz0tcMXG8FryNrKGObQwQt3djPtHmK1yWMuA/BoXHx3KVT0p80KOpg==
X-Gm-Gg: Acq92OHdtyAGDMlHYKPW+++SrfwW9fSW8moj0+t5Z2nk8qIqzomdrixudwQrBDGyi+p
	cLRhZEpcmnZtQj5GCD0pkyuUK5qN5a/nmgeLSXbYvGWphJJPP0A3X6Sz6lFE+Mk8H8o4NqOrlex
	V/tE2Wiy6yarX8MrhxAy0KgB9CWVfbSC17t5/aGr+F9rm0mxYU6po3ZYcOhoT9/86DBimnBmowm
	+1an2n8LGNvZzbIQlWduabRTo5Ei+bTQ1zIN83lJrjWaaYx4WbGm7A9XXClYqdCqcl+LsynEtes
	bCG/WeR6fcXqkGRMLmxnGCE3jVkSzNhRM6AMZFtcI9R8vcZVnSg2JTgrskoeFSMSBdV3fl1xjmY
	sUPv+WaYH6b1BLYMvSnvwcog6Lt/wAvK+klsuyEgYPRusr52T1GMO5wNZSw+7nEnqoGgFjMtyOp
	pxfRzDf5NsrNO1MxVPx59tUKf8ye8=
X-Received: by 2002:a05:600c:4714:b0:490:53b0:9e53 with SMTP id 5b1f17b1804b1-490a290bdfcmr150131245e9.1.1780253081024;
        Sun, 31 May 2026 11:44:41 -0700 (PDT)
Received: from void ([2a00:a041:e0a8:f400:3b90:bc78:60d8:574e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09be7fsm60409435e9.7.2026.05.31.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:44:40 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2] doc: fix typos via codespell
Date: Sun, 31 May 2026 21:43:58 +0300
Message-ID: <20260531184428.55905-1-algonell@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506101631.18127-1-algonell@gmail.com>
References: <20260506101631.18127-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are some typos in the documentation, comments, etc.
Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v2:
  - Drop typos under po/ and git-gui/ (different projects).

 Documentation/SubmittingPatches            |  2 +-
 Documentation/git-sparse-checkout.adoc     |  2 +-
 Documentation/technical/build-systems.adoc |  6 +++---
 builtin/pack-objects.c                     |  2 +-
 commit-graph.h                             |  2 +-
 compat/precompose_utf8.c                   |  2 +-
 hook.h                                     |  2 +-
 meson_options.txt                          |  2 +-
 midx-write.c                               |  2 +-
 odb/source.h                               |  2 +-
 packfile.h                                 |  2 +-
 path.h                                     |  2 +-
 reftable/system.h                          |  2 +-
 t/README                                   |  2 +-
 t/chainlint.pl                             |  2 +-
 t/chainlint/chain-break-false.expect       |  2 +-
 t/chainlint/chain-break-false.test         |  2 +-
 t/t1700-split-index.sh                     |  2 +-
 t/t3909-stash-pathspec-file.sh             |  6 +++---
 t/t4052-stat-output.sh                     |  2 +-
 t/t4067-diff-partial-clone.sh              |  2 +-
 t/t9150/svk-merge.dump                     | 10 +++++-----
 t/t9151/svn-mergeinfo.dump                 | 18 +++++++++---------
 t/unit-tests/clar/README.md                |  2 +-
 24 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d570184ec8..35b4952c8a 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -92,7 +92,7 @@ input and avoids unnecessary churn from many rapid iterations.
   topic are appropriate, so such an incremental updates are limited to
   small corrections and polishing.  After a topic cooks for some time
   (like 7 calendar days) in 'next' without needing further tweaks on
-  top, it gets merged to the 'master' branch and wait to become part
+  top, it gets merged to the 'master' branch and waits to become part
   of the next major release.
 
 In the following sections, many techniques and conventions are listed
diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 0d1618f161..e286584c67 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -134,7 +134,7 @@ the `clean.requireForce` config option is set to `false`.
 +
 The `--dry-run` option will list the directories that would be removed
 without deleting them. Running in this mode can be helpful to predict the
-behavior of the clean comand or to determine which kinds of files are left
+behavior of the clean command or to determine which kinds of files are left
 in the sparse directories.
 +
 The `--verbose` option will list every file within the directories that
diff --git a/Documentation/technical/build-systems.adoc b/Documentation/technical/build-systems.adoc
index 3c5237b9fd..ca5b5d96f1 100644
--- a/Documentation/technical/build-systems.adoc
+++ b/Documentation/technical/build-systems.adoc
@@ -47,7 +47,7 @@ Auto-detection of the following items is considered to be important:
 
   - Check for the existence of headers.
   - Check for the existence of libraries.
-  - Check for the existence of exectuables.
+  - Check for the existence of executables.
   - Check for the runtime behavior of specific functions.
   - Check for specific link order requirements when multiple libraries are
     involved.
@@ -106,7 +106,7 @@ by the build system:
 
   - C: the primary compiled language used by Git, must be supported. Relevant
     toolchains are GCC, Clang and MSVC.
-  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
+  - Rust: candidate as a second compiled language, should be supported. Relevant
     toolchains is the LLVM-based rustc.
 
 Built-in support for the respective languages is preferred over support that
@@ -142,7 +142,7 @@ The following list of build systems are considered:
 
 === GNU Make
 
-- Platform support: ubitquitous on all platforms, but not well-integrated into Windows.
+- Platform support: ubiquitous on all platforms, but not well-integrated into Windows.
 - Auto-detection: no built-in support for auto-detection of features.
 - Ease of use: easy to use, but discovering available options is hard. Makefile
   rules can quickly get out of hand once reaching a certain scope.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 480cc0bd8c..558cf821fe 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1349,7 +1349,7 @@ static void write_pack_file(void)
 			 * length of them as buffer length.
 			 *
 			 * Note that we need to subtract one though to
-			 * accomodate for the sideband byte.
+			 * accommodate for the sideband byte.
 			 */
 			struct hashfd_options opts = {
 				.progress = progress_state,
diff --git a/commit-graph.h b/commit-graph.h
index f6a5433641..13ca4ff010 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -18,7 +18,7 @@
  * This method is only used to enhance coverage of the commit-graph
  * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
  * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
- * call this method oustide of a builtin, and only if you know what
+ * call this method outside of a builtin, and only if you know what
  * you are doing!
  */
 void git_test_write_commit_graph_or_die(struct odb_source *source);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 43b3be0114..6e709bd138 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -85,7 +85,7 @@ const char *precompose_string_if_needed(const char *in)
 		out = reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
 		if (out) {
 			if (outlen == inlen && !memcmp(in, out, outlen))
-				free(out); /* no need to return indentical */
+				free(out); /* no need to return identical */
 			else
 				in = out;
 		}
diff --git a/hook.h b/hook.h
index b4372b636f..27bb1aeb2e 100644
--- a/hook.h
+++ b/hook.h
@@ -128,7 +128,7 @@ struct run_hooks_opt {
 	 * While the callback allows piecemeal writing, it can also be
 	 * used for smaller inputs, where it gets called only once.
 	 *
-	 * Add hook callback initalization context to `feed_pipe_ctx`.
+	 * Add hook callback initialization context to `feed_pipe_ctx`.
 	 * Add hook callback internal state to `feed_pipe_cb_data`.
 	 *
 	 */
diff --git a/meson_options.txt b/meson_options.txt
index 80a8025f20..d936ada098 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -106,7 +106,7 @@ option('highlight_bin', type: 'string', value: 'highlight')
 
 # Documentation.
 option('docs', type: 'array', choices: ['man', 'html'], value: [],
-  description: 'Which documenattion formats to build and install.')
+  description: 'Which documentation formats to build and install.')
 option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'], value: 'platform',
   description: 'Default format used when executing git-help(1).')
 option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
diff --git a/midx-write.c b/midx-write.c
index 561e9eedc0..19e1cd10b7 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1461,7 +1461,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 		/*
 		 * Attempt opening the pack index to populate num_objects.
-		 * Ignore failiures as they can be expected and are not
+		 * Ignore failures as they can be expected and are not
 		 * fatal during this selection time.
 		 */
 		open_pack_index(oldest);
diff --git a/odb/source.h b/odb/source.h
index 0a440884e4..2f51fcb9ff 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -341,7 +341,7 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
  * are only iterated over once.
  *
  * The optional `request` structure serves as a template for retrieving the
- * object info for each indvidual iterated object and will be populated as if
+ * object info for each individual iterated object and will be populated as if
  * `odb_source_read_object_info()` was called on the object. It will not be
  * modified, the callback will instead be invoked with a separate `struct
  * object_info` for every object. Object info will not be read when passing a
diff --git a/packfile.h b/packfile.h
index 49d6bdecf6..5729a37018 100644
--- a/packfile.h
+++ b/packfile.h
@@ -124,7 +124,7 @@ struct packfile_store {
 	 * that packs that contain a lot of accessed objects will be located
 	 * towards the front.
 	 *
-	 * This is usually desireable, but there are exceptions. One exception
+	 * This is usually desirable, but there are exceptions. One exception
 	 * is when the looking up multiple objects in a loop for each packfile.
 	 * In that case, we may easily end up with an infinite loop as the
 	 * packfiles get reordered to the front repeatedly.
diff --git a/path.h b/path.h
index 0434ba5e07..4c2958a903 100644
--- a/path.h
+++ b/path.h
@@ -217,7 +217,7 @@ void safe_create_dir(struct repository *repo, const char *dir, int share);
  *
  *   - It always adjusts shared permissions.
  *
- * Returns a negative erorr code on error, 0 on success.
+ * Returns a negative error code on error, 0 on success.
  */
 int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
 
diff --git a/reftable/system.h b/reftable/system.h
index c0e2cbe0ff..628232a46f 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -84,7 +84,7 @@ struct reftable_flock {
  * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
  * we block indefinitely.
  *
- * Retrun 0 on success, a reftable error code on error. Specifically,
+ * Return 0 on success, a reftable error code on error. Specifically,
  * `REFTABLE_LOCK_ERROR` should be returned in case the target path is already
  * locked.
  */
diff --git a/t/README b/t/README
index adbbd9acf4..085921be4b 100644
--- a/t/README
+++ b/t/README
@@ -972,7 +972,7 @@ see test-lib-functions.sh for the full list and their options.
  - test_lazy_prereq <prereq> <script>
 
    Declare the way to determine if a test prerequisite <prereq> is
-   satisified or not, but delay the actual determination until the
+   satisfied or not, but delay the actual determination until the
    prerequisite is actually used by "test_have_prereq" or the
    three-arg form of the test_expect_* functions.  For example, this
    is how the SYMLINKS prerequisite is declared to see if the platform
diff --git a/t/chainlint.pl b/t/chainlint.pl
index f0598e3934..2d07a99700 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -35,7 +35,7 @@
 #
 # In other languages, `1+2` would typically be scanned as three tokens
 # (`1`, `+`, and `2`), but in shell it is a single token. However, the similar
-# `1 + 2`, which embeds whitepace, is scanned as three token in shell, as well.
+# `1 + 2`, which embeds whitespace, is scanned as three token in shell, as well.
 # In shell, several characters with special meaning lose that meaning when not
 # surrounded by whitespace. For instance, the negation operator `!` is special
 # when standing alone surrounded by whitespace; whereas in `foo!uucp` it is
diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
index f6a0a301e9..db6f8b12a4 100644
--- a/t/chainlint/chain-break-false.expect
+++ b/t/chainlint/chain-break-false.expect
@@ -1,4 +1,4 @@
-2 if condition not satisified
+2 if condition not satisfied
 3 then
 4 	echo it did not work...
 5 	echo failed!
diff --git a/t/chainlint/chain-break-false.test b/t/chainlint/chain-break-false.test
index f78ad911fc..924c9627c0 100644
--- a/t/chainlint/chain-break-false.test
+++ b/t/chainlint/chain-break-false.test
@@ -1,6 +1,6 @@
 test_expect_success 'chain-break-false' '
 # LINT: broken &&-chain okay if explicit "false" signals failure
-if condition not satisified
+if condition not satisfied
 then
 	echo it did not work...
 	echo failed!
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ac4a5b2734..869fb4a14e 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
 		git checkout main &&
 		git update-index --split-index &&
 		test_commit more &&
-		# must not write a new shareindex, or we wont catch the problem
+		# must not write a new shareindex, or we won't catch the problem
 		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
 		# i.e. do not expect warnings like
 		# could not freshen shared index .../shareindex.00000...
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 73f2dbdeb0..3afa6bff3d 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -29,7 +29,7 @@ verify_expect () {
 test_expect_success 'simplest' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didnt ignore
+	# More files are written to make sure that git didn't ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&
@@ -47,7 +47,7 @@ test_expect_success 'simplest' '
 test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didnt ignore
+	# More files are written to make sure that git didn't ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&
@@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didnt ignore
+	# More files are written to make sure that git didn't ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index e009585925..62d3d2604c 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -420,7 +420,7 @@ test_expect_success 'merge --stat respects COLUMNS with long name' '
 # enough terminal display width, will contain the following line:
 #     "<RED>|<RESET>  ${FILENAME} | 0"
 # where "<RED>" and "<RESET>" are ANSI escape codes to color the text.
-# To calculate the minimium terminal display width MIN_TERM_WIDTH so that the
+# To calculate the minimum terminal display width MIN_TERM_WIDTH so that the
 # FILENAME in the diffstat will not be shortened, we take the FILENAME length
 # and add 9 to it.
 # To check if the diffstat width, when the line_prefix (the "<RED>|<RESET>" of
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 30813109ac..a9dec84c30 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -159,7 +159,7 @@ test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites'
 	# We need baz to trigger break-rewrites detection.
 	git -C client reset --hard HEAD &&
 
-	# break-rewrites detction in reset.
+	# break-rewrites detection in reset.
 	git -C client reset HEAD~1
 '
 
diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
index 42f70dbec7..6a8ac81b11 100644
--- a/t/t9150/svk-merge.dump
+++ b/t/t9150/svk-merge.dump
@@ -77,7 +77,7 @@ Content-length: 2411
 PROPS-END
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -206,7 +206,7 @@ Content-length: 2465
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -310,7 +310,7 @@ Content-length: 2521
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -417,7 +417,7 @@ Content-length: 2593
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -534,7 +534,7 @@ Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
index 47cafcf528..d5e1695637 100644
--- a/t/t9151/svn-mergeinfo.dump
+++ b/t/t9151/svn-mergeinfo.dump
@@ -87,7 +87,7 @@ Content-length: 2411
 PROPS-END
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -260,7 +260,7 @@ Content-length: 2465
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -365,7 +365,7 @@ Content-length: 2521
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -473,7 +473,7 @@ Content-length: 2529
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -578,7 +578,7 @@ Content-length: 2593
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -767,7 +767,7 @@ Content-length: 2593
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -948,7 +948,7 @@ Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -1172,7 +1172,7 @@ Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
@@ -1414,7 +1414,7 @@ Content-length: 2713
 
 # -DCOLLISION_CHECK if you believe that SHA1's
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
-# enough guarantees about no collisions between objects ever hapenning.
+# enough guarantees about no collisions between objects ever happening.
 #
 # -DNSEC if you want git to care about sub-second file mtimes and ctimes.
 # Note that you need some new glibc (at least >2.2.4) for this, and it will
diff --git a/t/unit-tests/clar/README.md b/t/unit-tests/clar/README.md
index 41595989ca..a45b9c8e5d 100644
--- a/t/unit-tests/clar/README.md
+++ b/t/unit-tests/clar/README.md
@@ -138,7 +138,7 @@ raise errors during test execution.
 __Caution:__ If you use assertions inside of `test_suitename__initialize`,
 make sure that you do not rely on `__initialize` being completely run
 inside your `test_suitename__cleanup` function. Otherwise you might
-encounter ressource cleanup twice.
+encounter resource cleanup twice.
 
 ## How does Clar work?
 

Interdiff against v1:
  diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
  index 40e95bccb4..23fe76e498 100755
  --- a/git-gui/git-gui.sh
  +++ b/git-gui/git-gui.sh
  @@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
   	if {[file pathtype $p] ne {absolute}} {
   		continue
   	}
  -	# Keep only the first occurrence of any duplicates.
  +	# Keep only the first occurence of any duplicates.
   	set norm_p [file normalize $p]
   	dict set _path_seen $norm_p 1
   }
  diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
  index a4703af028..7e1462a20c 100644
  --- a/git-gui/lib/choose_repository.tcl
  +++ b/git-gui/lib/choose_repository.tcl
  @@ -15,7 +15,7 @@ field w_recentlist ; # Listbox containing recent repositories
   field w_localpath  ; # Entry widget bound to local_path
   
   field done              0 ; # Finished picking the repository?
  -field clone_ok      false ; # clone succeeded
  +field clone_ok      false ; # clone succeeeded
   field local_path       {} ; # Where this repository is locally
   field origin_url       {} ; # Where we are cloning from
   field origin_name  origin ; # What we shall call 'origin'
  diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
  index f4cffeac66..c18e201d85 100644
  --- a/git-gui/lib/themed.tcl
  +++ b/git-gui/lib/themed.tcl
  @@ -4,7 +4,7 @@
   
   namespace eval color {
   	# Variable colors
  -	# Preferred way to set widget colors is using add_option.
  +	# Preffered way to set widget colors is using add_option.
   	# In some cases, like with tags in_diff/in_sel, we use these colors.
   	variable select_bg				lightgray
   	variable select_fg				black
  diff --git a/po/el.po b/po/el.po
  index c45560c996..703f46d0c7 100644
  --- a/po/el.po
  +++ b/po/el.po
  @@ -2748,7 +2748,7 @@ msgid "Low-level Commands / Interrogators"
   msgstr "Εντολές Χαμηλού Επιπέδου / Ερωτημάτων"
   
   #: help.c:37
  -msgid "Low-level Commands / Syncing Repositories"
  +msgid "Low-level Commands / Synching Repositories"
   msgstr "Εντολές Χαμηλού Επιπέδου / Συγχρονισμού Αποθετηρίων"
   
   #: help.c:38
  diff --git a/po/ko.po b/po/ko.po
  index 6bc20a43e3..7a6847f023 100644
  --- a/po/ko.po
  +++ b/po/ko.po
  @@ -2062,7 +2062,7 @@ msgid "Low-level Commands / Interrogators"
   msgstr "보조 명령 / 정보 획득 기능"
   
   #: help.c:37
  -msgid "Low-level Commands / Syncing Repositories"
  +msgid "Low-level Commands / Synching Repositories"
   msgstr "보조 명령 / 저장소 동기화 기능"
   
   #: help.c:38

Range-diff against v1:
1:  381e2c1fc3 ! 1:  674edefc99 doc: fix typos via codespell
    @@ compat/precompose_utf8.c: const char *precompose_string_if_needed(const char *in
      				in = out;
      		}
     
    - ## git-gui/git-gui.sh ##
    -@@ git-gui/git-gui.sh: foreach p [split $env(PATH) $_path_sep] {
    - 	if {[file pathtype $p] ne {absolute}} {
    - 		continue
    - 	}
    --	# Keep only the first occurence of any duplicates.
    -+	# Keep only the first occurrence of any duplicates.
    - 	set norm_p [file normalize $p]
    - 	dict set _path_seen $norm_p 1
    - }
    -
    - ## git-gui/lib/choose_repository.tcl ##
    -@@ git-gui/lib/choose_repository.tcl: field w_recentlist ; # Listbox containing recent repositories
    - field w_localpath  ; # Entry widget bound to local_path
    - 
    - field done              0 ; # Finished picking the repository?
    --field clone_ok      false ; # clone succeeeded
    -+field clone_ok      false ; # clone succeeded
    - field local_path       {} ; # Where this repository is locally
    - field origin_url       {} ; # Where we are cloning from
    - field origin_name  origin ; # What we shall call 'origin'
    -
    - ## git-gui/lib/themed.tcl ##
    -@@
    - 
    - namespace eval color {
    - 	# Variable colors
    --	# Preffered way to set widget colors is using add_option.
    -+	# Preferred way to set widget colors is using add_option.
    - 	# In some cases, like with tags in_diff/in_sel, we use these colors.
    - 	variable select_bg				lightgray
    - 	variable select_fg				black
    -
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt {
      	 * While the callback allows piecemeal writing, it can also be
    @@ path.h: void safe_create_dir(struct repository *repo, const char *dir, int share
      int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
      
     
    - ## po/el.po ##
    -@@ po/el.po: msgid "Low-level Commands / Interrogators"
    - msgstr "Εντολές Χαμηλού Επιπέδου / Ερωτημάτων"
    - 
    - #: help.c:37
    --msgid "Low-level Commands / Synching Repositories"
    -+msgid "Low-level Commands / Syncing Repositories"
    - msgstr "Εντολές Χαμηλού Επιπέδου / Συγχρονισμού Αποθετηρίων"
    - 
    - #: help.c:38
    -
    - ## po/ko.po ##
    -@@ po/ko.po: msgid "Low-level Commands / Interrogators"
    - msgstr "보조 명령 / 정보 획득 기능"
    - 
    - #: help.c:37
    --msgid "Low-level Commands / Synching Repositories"
    -+msgid "Low-level Commands / Syncing Repositories"
    - msgstr "보조 명령 / 저장소 동기화 기능"
    - 
    - #: help.c:38
    -
      ## reftable/system.h ##
     @@ reftable/system.h: struct reftable_flock {
       * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
-- 
2.54.0

