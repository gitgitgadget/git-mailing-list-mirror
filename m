Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD811C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC97861B2F
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhJBSqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhJBSqD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 14:46:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00FCC0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 11:44:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so14193361wmq.1
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I418HH5UaNsMpfqCUjO10f7Rvm63o5QtIrXEFp8Iqjw=;
        b=RviWlQs5+vuHnm3sDnxGBLBSlj5dDTVg1WejhrFkRHQxaV7zGNDE+3mihxPlPHR+6H
         ZJJz8+M+aTTtvjQ42ShWjJpDACx/5k7vKPB23fWSbS7ah7+qiifVSjHGP4Vw9paSzBga
         Qz/mbQMTvkkhAsc9Ehdk/f7njmBJSdviOcNaWWpmeIb/gzQIYs/qqmhTzBBlLIz05+RE
         5PSRzMLcrATMcq0VPEBpbdtIQNLyWXlAdaeCpvUTOSsq+s3NBi+sYdUsePmKhdRgfJYc
         nVNnmb+EVcGl35GacMXYxtJl/k0o95swN83QV1+tkPcuGYe8X7+OLD0Gdp26QSgpMJqA
         qEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I418HH5UaNsMpfqCUjO10f7Rvm63o5QtIrXEFp8Iqjw=;
        b=zM1jVNhydR3TR1uAxU6EeZlTqJji4HP7oIqutOAohagjyDdMuVBAFhWW9GFauhHUIq
         qxj3HpzmSbYAGl4EhMw6V9RgU43qJG5En1DcbqWa8Fw67wuAOAxEXHdE10529osvQ00d
         HL/YUqtsLl4+xw6M+jb52ulWopfgqBLQXYB7zp5we+MsFJeIttFvQrGyHkdZ8UMnZbD9
         MxRqGhG2/yzJIK2Rm0i2LD0Vl/fYa2xrngpJTExdYNZoWpUzGUTV0P5d6Uk6ZeT86sYU
         6hYFGtig6ji2/ig7L7f+7rNUBHzGhc4varm/VH4Qw4OZaFqWOhiaWvYgzj9+g1+9DdkU
         00Ew==
X-Gm-Message-State: AOAM5311BBlfn24QVuuamll9RgVJmXAnJ0I5Czn8T50X3Uj6U34dHWRb
        Slp6eWarGbFJjy2rgs/VV3Hnq/yPeOwqSA==
X-Google-Smtp-Source: ABdhPJyNbJEQMVie1G6IoF5tGxWdMOpwZITHO0uVH3j/Fpk+Lnzfm661eHLMywzauNFkuPi4Q5NR8g==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr10582742wmk.5.1633200253544;
        Sat, 02 Oct 2021 11:44:13 -0700 (PDT)
Received: from localhost.localdomain ([154.13.1.35])
        by smtp.gmail.com with ESMTPSA id o1sm10379552wmq.26.2021.10.02.11.44.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:44:12 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v1 2/3] *: fix spelling typos
Date:   Sat,  2 Oct 2021 20:44:06 +0200
Message-Id: <20211002184407.117282-3-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002184407.117282-1-rybak.a.v@gmail.com>
References: <20211002184407.117282-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of these were found using the 'codespell' tool.
https://github.com/codespell-project/codespell

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 Documentation/config.txt                       |  2 +-
 Documentation/config/mergetool.txt             |  2 +-
 Documentation/git-describe.txt                 |  2 +-
 Documentation/git-format-patch.txt             |  2 +-
 Documentation/git-mktag.txt                    |  2 +-
 Documentation/git.txt                          |  2 +-
 .../technical/commit-graph-format.txt          |  2 +-
 Documentation/technical/commit-graph.txt       |  4 ++--
 .../technical/remembering-renames.txt          |  2 +-
 bloom.h                                        |  2 +-
 builtin/help.c                                 |  2 +-
 builtin/name-rev.c                             |  2 +-
 cbtree.c                                       |  2 +-
 commit-graph.h                                 |  2 +-
 compat/precompose_utf8.c                       |  2 +-
 compat/simple-ipc/ipc-unix-socket.c            |  2 +-
 diffcore-rename.c                              |  2 +-
 git-instaweb.sh                                |  2 +-
 git-p4.py                                      |  8 ++++----
 merge-ort.c                                    |  6 +++---
 perl/Git/I18N.pm                               |  2 +-
 rebase.c                                       |  2 +-
 sideband.c                                     |  2 +-
 t/t0000-basic.sh                               |  4 ++--
 t/t0021/rot13-filter.pl                        |  2 +-
 t/t1407-worktree-ref-store.sh                  |  2 +-
 t/t2082-parallel-checkout-attributes.sh        |  2 +-
 t/t3431-rebase-fork-point.sh                   |  2 +-
 t/t5411/test-0034-report-ft.sh                 |  2 +-
 t/t5411/test-0035-report-ft--porcelain.sh      |  2 +-
 t/t5531-deep-submodule-push.sh                 |  2 +-
 t/t6404-recursive-merge.sh                     |  2 +-
 t/t7064-wtstatus-pv2.sh                        |  2 +-
 t/t7601-merge-pull-config.sh                   |  2 +-
 t/t8009-blame-vs-topicbranches.sh              |  2 +-
 t/t9150/svk-merge.dump                         | 10 +++++-----
 t/t9151/svn-mergeinfo.dump                     | 18 +++++++++---------
 trace2/tr2_tls.h                               |  2 +-
 38 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0c0e6b859f..1167e88e34 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -304,7 +304,7 @@ path relative to Git's "runtime prefix", i.e. relative to the location
 where Git itself was installed. For example, `%(prefix)/bin/` refers to
 the directory in which the Git executable itself lives. If Git was
 compiled without runtime prefix support, the compiled-in prefix will be
-subsituted instead. In the unlikely event that a literal path needs to
+substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
 
diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index cafbbef46a..f691afa93d 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -50,7 +50,7 @@ mergetool.hideResolved::
 	possible and write the 'MERGED' file containing conflict markers around
 	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
 	represent the versions of the file from before Git's conflict
-	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwriten so
+	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwritten so
 	that only the unresolved conflicts are presented to the merge tool. Can
 	be configured per-tool via the `mergetool.<tool>.hideResolved`
 	configuration variable. Defaults to `false`.
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index c6a79c2a0f..8ace8fb78a 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -140,7 +140,7 @@ at the end.
 
 The number of additional commits is the number
 of commits which would be displayed by "git log v1.0.4..parent".
-The hash suffix is "-g" + an unambigous abbreviation for the tip commit
+The hash suffix is "-g" + an unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The
 length of the abbreviation scales as the repository grows, using the
 approximate number of objects in the repository and a bit of math
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fe2f69d36e..f2c17164ed 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -242,7 +242,7 @@ populated with placeholder text.
 	or "--reroll-count=4rev2" are allowed), but the downside of
 	using such a reroll-count is that the range-diff/interdiff
 	with the previous version does not state exactly which
-	version the new interation is compared against.
+	version the new iteration is compared against.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 466a697519..b2a2e80d42 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -33,7 +33,7 @@ from warnings to errors (so e.g. a missing "tagger" line is an error).
 
 Extra headers in the object are also an error under mktag, but ignored
 by linkgit:git-fsck[1]. This extra check can be turned off by setting
-the appropriate `fsck.<msg-id>` varible:
+the appropriate `fsck.<msg-id>` variable:
 
     git -c fsck.extraHeaderEntry=ignore mktag <my-tag-with-headers
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index abace9eac2..6da99538c3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -42,7 +42,7 @@ OPTIONS
 --version::
 	Prints the Git suite version that the 'git' program came from.
 +
-This option is internaly converted to `git version ...` and accepts
+This option is internally converted to `git version ...` and accepts
 the same options as the linkgit:git-version[1] command. If `--help` is
 also given, it takes precedence over `--version`.
 
diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index 87971c27dd..fa6448641e 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -109,7 +109,7 @@ CHUNK DATA:
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
     * Generation Data Overflow chunk is present only when Generation Data
-      chunk is present and atleast one corrected commit date offset cannot
+      chunk is present and at least one corrected commit date offset cannot
       be stored within 31 bits.
 
   Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index f05e7bda1a..90c9760c23 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -40,7 +40,7 @@ Values 1-4 satisfy the requirements of parse_commit_gently().
 
 There are two definitions of generation number:
 1. Corrected committer dates (generation number v2)
-2. Topological levels (generation nummber v1)
+2. Topological levels (generation number v1)
 
 Define "corrected committer date" of a commit recursively as follows:
 
@@ -48,7 +48,7 @@ Define "corrected committer date" of a commit recursively as follows:
     equal to its committer date.
 
  * A commit with at least one parent has corrected committer date equal to
-    the maximum of its commiter date and one more than the largest corrected
+    the maximum of its committer date and one more than the largest corrected
     committer date among its parents.
 
  * As a special case, a root commit with timestamp zero has corrected commit
diff --git a/Documentation/technical/remembering-renames.txt b/Documentation/technical/remembering-renames.txt
index 2fd5cc88e0..7137181637 100644
--- a/Documentation/technical/remembering-renames.txt
+++ b/Documentation/technical/remembering-renames.txt
@@ -407,7 +407,7 @@ considered to be "irrelevant".  See for example the following commits:
 		no longer relevant", 2021-03-13)
 
 Relevance is always determined by what the _other_ side of history has
-done, in terms of modifing a file that our side renamed, or adding a
+done, in terms of modifying a file that our side renamed, or adding a
 file to a directory which our side renamed.  This means that a path
 that is "irrelevant" when picking the first commit of a series in a
 rebase or cherry-pick, may suddenly become "relevant" when picking the
diff --git a/bloom.h b/bloom.h
index adde6dfe21..83eb989d85 100644
--- a/bloom.h
+++ b/bloom.h
@@ -15,7 +15,7 @@ struct bloom_filter_settings {
 
 	/*
 	 * The number of times a path is hashed, i.e. the
-	 * number of bit positions tht cumulatively
+	 * number of bit positions that cumulatively
 	 * determine whether a path is present in the
 	 * Bloom filter.
 	 */
diff --git a/builtin/help.c b/builtin/help.c
index 7731659765..8daad9c872 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -489,7 +489,7 @@ static void open_html(const char *path)
 
 static void show_html_page(const char *page)
 {
-	struct strbuf page_path; /* it leaks but we exec bellow */
+	struct strbuf page_path; /* it leaks but we exec below */
 
 	get_html_page_path(&page_path, page);
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b221d30014..9a8e083409 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -595,7 +595,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	}
 
 	if (cutoff) {
-		/* check for undeflow */
+		/* check for underflow */
 		if (cutoff > TIME_MIN + CUTOFF_DATE_SLOP)
 			cutoff = cutoff - CUTOFF_DATE_SLOP;
 		else
diff --git a/cbtree.c b/cbtree.c
index b0c65d810f..fb68511247 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -11,7 +11,7 @@ static struct cb_node *cb_node_of(const void *p)
 	return (struct cb_node *)((uintptr_t)p - 1);
 }
 
-/* locate the best match, does not do a final comparision */
+/* locate the best match, does not do a final comparison */
 static struct cb_node *cb_internal_best_match(struct cb_node *p,
 					const uint8_t *k, size_t klen)
 {
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e1830..bf37480504 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -13,7 +13,7 @@
  * This method is only used to enhance coverage of the commit-graph
  * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
  * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
- * call this method oustide of a builtin, and only if you know what
+ * call this method outside of a builtin, and only if you know what
  * you are doing!
  */
 void git_test_write_commit_graph_or_die(void);
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index cce1d57a46..e330904497 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -80,7 +80,7 @@ const char *precompose_string_if_needed(const char *in)
 		out = reencode_string_iconv(in, inlen, ic_prec, 0, &outlen);
 		if (out) {
 			if (outlen == inlen && !memcmp(in, out, outlen))
-				free(out); /* no need to return indentical */
+				free(out); /* no need to return identical */
 			else
 				in = out;
 		}
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 1927e6ef4b..9685523f12 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -685,7 +685,7 @@ static int accept_thread__wait_for_connection(
  * Block SIGPIPE in this thread for the life of the thread.  This
  * avoids any stray SIGPIPE signals when closing pipe fds under
  * extremely heavy loads (such as when the fifo queue is full and we
- * drop incomming connections).
+ * drop incoming connections).
  */
 static void *accept_thread_proc(void *_accept_thread_data)
 {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index bebd4ed6a4..2d962ce2ad 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -926,7 +926,7 @@ static int find_basename_matches(struct diff_options *options,
 	 * spend more cycles to find similarities between files, so it may
 	 * be less likely that this heuristic is wanted.  If someone is
 	 * doing break detection, that means they do not want filename
-	 * similarity to imply any form of content similiarity, and thus
+	 * similarity to imply any form of content similarity, and thus
 	 * this heuristic would definitely be incompatible.
 	 */
 
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 7c55229773..d04536bda8 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -615,7 +615,7 @@ python_conf() {
 	ln -sf "$root/static" "$fqgitdir/gitweb/$httpd_only/"
 
 	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
-	# This asumes that python is in user's $PATH
+	# This assumes that python is in user's $PATH
 	# This script is Python 2 and 3 compatible
 	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
 #!/usr/bin/env python
diff --git a/git-p4.py b/git-p4.py
index eae4e5ff8f..3fd70fe477 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -36,7 +36,7 @@
 import errno
 import glob
 
-# On python2.7 where raw_input() and input() are both availble,
+# On python2.7 where raw_input() and input() are both available,
 # we want raw_input's semantics, but aliased to input for python3
 # compatibility
 # support basestring in python3
@@ -219,7 +219,7 @@ def run_git_hook(cmd, param=[]):
     if not isinstance(param, list):
         param=[param]
 
-    # resolve hook file name, OS depdenent
+    # resolve hook file name, OS dependent
     hook_file = os.path.join(hooks_path, cmd)
     if platform.system() == 'Windows':
         if not os.path.isfile(hook_file):
@@ -252,7 +252,7 @@ def run_hook_command(cmd, param):
        be run with the Git for Windows Bash shell.  If there
        is no file extension, the file is deemed a bash shell
        and will be handed off to sh.exe. Otherwise, Windows
-       will be called with the shell to handle the file assocation.
+       will be called with the shell to handle the file association.
 
        For non Windows operating systems, the file is called
        as an executable.
@@ -1655,7 +1655,7 @@ def __init__(self):
     status from the script will abort the process.
 
     The purpose of the hook is to edit the message file in place, and it is not
-    supressed by the `--no-verify` option. This hook is called even if
+    suppressed by the `--no-verify` option. This hook is called even if
     `--prepare-p4-only` is set.
 
     The `p4-changelist` hook is executed after the changelist message has been
diff --git a/merge-ort.c b/merge-ort.c
index 35aa979c3a..ec91f2ed7d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -925,7 +925,7 @@ static void collect_rename_info(struct merge_options *opt,
 	 * Update dir_rename_mask (determines ignore-rename-source validity)
 	 *
 	 * dir_rename_mask helps us keep track of when directory rename
-	 * detection may be relevant.  Basically, whenver a directory is
+	 * detection may be relevant.  Basically, whenever a directory is
 	 * removed on one side of history, and a file is added to that
 	 * directory on the other side of history, directory rename
 	 * detection is relevant (meaning we have to detect renames for all
@@ -1808,7 +1808,7 @@ static int handle_content_merge(struct merge_options *opt,
 	 * the three blobs to merge on various sides of history.
 	 *
 	 * extra_marker_size is the amount to extend conflict markers in
-	 * ll_merge; this is neeed if we have content merges of content
+	 * ll_merge; this is need if we have content merges of content
 	 * merges, which happens for example with rename/rename(2to1) and
 	 * rename/add conflicts.
 	 */
@@ -3419,7 +3419,7 @@ static void write_completed_directory(struct merge_options *opt,
 	 *     	   src/moduleB  2
 	 *
 	 *     which is used to know that xtract.c & token.txt are from the
-	 *     toplevel dirctory, while umm.c & stuff.h & baz.c are from the
+	 *     toplevel directory, while umm.c & stuff.h & baz.c are from the
 	 *     src/moduleB directory.  Again, following the example above,
 	 *     once we need to process src/moduleB, then info->offsets is
 	 *     updated to
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 895e759c57..228e4d6659 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -111,7 +111,7 @@ =head2 __n($$$)
 =head2 N__($)
 
 No-operation that only returns its argument. Use this if you want xgettext to
-extract the text to the pot template but do not want to trigger retrival of the
+extract the text to the pot template but do not want to trigger retrieval of the
 translation at run time.
 
 =head1 AUTHOR
diff --git a/rebase.c b/rebase.c
index f8137d859b..97fcc7d615 100644
--- a/rebase.c
+++ b/rebase.c
@@ -9,7 +9,7 @@
  * The callers that care if (any) rebase is requested should say
  *   if (REBASE_TRUE <= rebase_parse_value(string))
  *
- * The callers that want to differenciate an unrecognised value and
+ * The callers that want to differentiate an unrecognised value and
  * false can do so by treating _INVALID and _FALSE differently.
  */
 enum rebase_type rebase_parse_value(const char *value)
diff --git a/sideband.c b/sideband.c
index 85bddfdcd4..faea1dd100 100644
--- a/sideband.c
+++ b/sideband.c
@@ -184,7 +184,7 @@ int demultiplex_sideband(const char *me, int status,
 			int linelen = brk - b;
 
 			/*
-			 * For message accross packet boundary, there would have
+			 * For message across packet boundary, there would have
 			 * a nonempty "scratch" buffer from last call of this
 			 * function, and there may have a leading CR/LF in "buf".
 			 * For this case we should add a clear-to-eol suffix to
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 5c342de713..2384a8e533 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -811,7 +811,7 @@ test_expect_success 'tests respect lazy prerequisites' '
 	run_sub_test_lib_test lazy-prereqs "respect lazy prereqs" <<-\EOF &&
 
 	test_lazy_prereq LAZY_TRUE true
-	test_expect_success LAZY_TRUE "lazy prereq is satisifed" "true"
+	test_expect_success LAZY_TRUE "lazy prereq is satisfied" "true"
 	test_expect_success !LAZY_TRUE "negative lazy prereq" "false"
 
 	test_lazy_prereq LAZY_FALSE false
@@ -822,7 +822,7 @@ test_expect_success 'tests respect lazy prerequisites' '
 	EOF
 
 	check_sub_test_lib_test lazy-prereqs <<-\EOF
-	ok 1 - lazy prereq is satisifed
+	ok 1 - lazy prereq is satisfied
 	ok 2 # skip negative lazy prereq (missing !LAZY_TRUE)
 	ok 3 # skip lazy prereq not satisfied (missing LAZY_FALSE)
 	ok 4 - negative false prereq
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 7bb93768f3..98aa47c575 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -9,7 +9,7 @@
 # ("clean", "smudge", etc).
 #
 # When --always-delay is given all pathnames with the "can-delay" flag
-# that don't appear on the list bellow are delayed with a count of 1
+# that don't appear on the list below are delayed with a count of 1
 # (see more below).
 #
 # This implementation supports special test cases:
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index ad8006c813..1364f9c8f6 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -55,7 +55,7 @@ test_expect_success 'create_symref(FOO, refs/heads/main)' '
 # Some refs (refs/bisect/*, pseudorefs) are kept per worktree, so they should
 # only appear in the for-each-reflog output if it is called from the correct
 # worktree, which is exercised in this test. This test is poorly written (and
-# therefore marked REFFILES) for mulitple reasons: 1) it creates invalidly
+# therefore marked REFFILES) for multiple reasons: 1) it creates invalidly
 # formatted log entres. 2) it uses direct FS access for creating the reflogs. 3)
 # PSEUDO-WT and refs/bisect/random do not create reflogs by default, so it is
 # not testing a realistic scenario.
diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
index 2525457961..363a693ca0 100755
--- a/t/t2082-parallel-checkout-attributes.sh
+++ b/t/t2082-parallel-checkout-attributes.sh
@@ -90,7 +90,7 @@ test_expect_success 'parallel-checkout with eol conversions' '
 
 # Entries that require an external filter are not eligible for parallel
 # checkout. Check that both the parallel-eligible and non-eligible entries are
-# properly writen in a single checkout operation.
+# properly written in a single checkout operation.
 #
 test_expect_success 'parallel-checkout and external filter' '
 	set_checkout_config 2 0 &&
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4c98d99e7e..97dadf40a9 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -73,7 +73,7 @@ test_rebase 'G F C D B A' --onto D main
 test_rebase 'G F C B A' --keep-base refs/heads/main
 test_rebase 'G F C B A' --keep-base main
 
-test_expect_success 'git rebase --fork-point with ambigous refname' '
+test_expect_success 'git rebase --fork-point with ambiguous refname' '
 	git checkout main &&
 	git checkout -b one &&
 	git checkout side &&
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index 73a47d1ffd..415d4e3316 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -10,7 +10,7 @@ test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(B)
-test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL)" '
+test_expect_success "proc-receive: fall through, let receive-pack to execute ($PROTOCOL)" '
 	git -C workbench push origin \
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index c350201107..5d17aa3eb7 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -10,7 +10,7 @@ test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL/porcelain)
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(B)
-test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL/porcelain)" '
+test_expect_success "proc-receive: fall through, let receive-pack to execute ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index d573ca496a..2a1d092906 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -200,7 +200,7 @@ test_expect_success 'push recurse-submodules last one wins on command line' '
 		cd work/gar/bage &&
 		>recurse-check-on-command-line-overriding-earlier-command-line &&
 		git add recurse-check-on-command-line-overriding-earlier-command-line &&
-		git commit -m "Recurse on command-line overridiing earlier command-line junk"
+		git commit -m "Recurse on command-line overriding earlier command-line junk"
 	) &&
 	(
 		cd work &&
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index eaf48e941e..7f7b5c1f72 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -87,7 +87,7 @@ test_expect_success 'result contains a conflict' '
 '
 
 test_expect_success 'virtual trees were processed' '
-	# TODO: fragile test, relies on ambigious merge-base resolution
+	# TODO: fragile test, relies on ambiguous merge-base resolution
 	git ls-files --stage >out &&
 
 	cat >expect <<-EOF &&
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index eeb0534163..4c1f7b512a 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -80,7 +80,7 @@ test_expect_success 'before initial commit, things added (-z)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'make first commit, comfirm HEAD oid and branch' '
+test_expect_success 'make first commit, confirm HEAD oid and branch' '
 	git commit -m initial &&
 	H0=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 1f652f433e..22b88164ef 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -280,7 +280,7 @@ test_expect_success '--rebase overrides pull.ff unset' '
 	test_does_rebase pull --rebase
 '
 
-# Group 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
+# Group 4: --no-rebase heeds pull.ff=!only or explicit --ff or --no-ff
 
 test_expect_success '--no-rebase works with --no-ff' '
 	test_does_merge_when_ff_possible pull --no-rebase --no-ff
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
index 72596e38b2..c37c33a980 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='blaming trough history with topic branches'
+test_description='blaming through history with topic branches'
 . ./test-lib.sh
 
 # Creates the history shown below. '*'s mark the first parent in the merges.
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
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928..6908045a32 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -4,7 +4,7 @@
 #include "strbuf.h"
 
 /*
- * Arbitry limit for thread names for column alignment.
+ * Arbitrary limit for thread names for column alignment.
  */
 #define TR2_MAX_THREAD_NAME (24)
 
-- 
2.33.0

