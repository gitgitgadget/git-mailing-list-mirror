Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CAC433F5
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDD861AE0
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 18:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhJBSqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhJBSqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 14:46:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C184AC0613EC
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 11:44:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g198-20020a1c20cf000000b0030d60cd7fd6so902589wmg.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 11:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MAIrTdVNwGiyKZn2OBJ2YyxnXVySv+FpVhnXF0WTe+I=;
        b=LPWc9JNTTo0ZPJ48I1CGYjzpzwtX40HgFmBj9Ho4kOle38fhXqPh0iBnp3dH4Iu1Bt
         Je6s/i4ou07IAiyrusA1IAcDEdaPgRAQ1CX0OlEjufl3yc+eczqPDzOC/b3+bUIwZVog
         tHJU8tSA7koA7WM9qoad7yWcedII193+27H05Ilxce1PEqFlo7pZJBP24+g1KJ5eMtH8
         ChwEm0S3VeVkpcNJM63N3Hg5whgx5ZxJTRY5wkz/fh3gR05qhuvI9bdp/yNnHaeUhymD
         D94EIBwe67CscB4pfcvscqAGUK4QX6sIc5TJGKxjqs1ca7iSmH5geOugdKe4qZguVlxG
         Pi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAIrTdVNwGiyKZn2OBJ2YyxnXVySv+FpVhnXF0WTe+I=;
        b=XxLwujtDq0aj1BYD7xZPcWHcJlA/gaNkhRkfkv6IpZRCSgUwOQwnRNP8HukmOqOx55
         YvU7u9qnzQe4zV/gdpFvcLrDNz9QNYtNjkdXxsVIiUwIJAj+Hoijcwj1trCbEqJUmoW2
         pUILAOd3BkoV+4JKL3NOPw2EByZ0/JBxAhXE/j2vMfwJZxdnaIP3WZQunHzDCldunH3m
         eTjy++Lj7OYjJpW/yGZWRcrCUZ46eg0L/kvsxz5sVTCkAemhIG3Q4f8/iMuSWbbm0hOw
         lbG8FUPIVfNxHSGG4llVzqmK8ygEPkRtzjZIAF5wzliO5tg3lJCciFR7H/yFlbdHUzs1
         qrFQ==
X-Gm-Message-State: AOAM531A9zvPCpY5PAOTGQxHKVcB+g50DeXGi8VWbni/x3hvw9ps7jjD
        kjNsSMVlCFIlgia5kJKImfKfLhE72qOOcQ==
X-Google-Smtp-Source: ABdhPJwqGU8qTrzQ5WResAtm6WuDOZ8gNzSFyt5Mm/VFSBy6OTyMcIIxWbqkVc7jELyYA+OzGcDp4w==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr10561826wma.101.1633200252556;
        Sat, 02 Oct 2021 11:44:12 -0700 (PDT)
Received: from localhost.localdomain ([154.13.1.35])
        by smtp.gmail.com with ESMTPSA id o1sm10379552wmq.26.2021.10.02.11.44.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 11:44:12 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v1 1/3] *: spell Latin abbreviations correctly
Date:   Sat,  2 Oct 2021 20:44:05 +0200
Message-Id: <20211002184407.117282-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002184407.117282-1-rybak.a.v@gmail.com>
References: <20211002184407.117282-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abbreviation "i.e." stands for Latin phrase "id est".  Abbreviation
"e.g." stands for Latin phrase "exempli gratia".  Abbreviation "cf."
stands for Latin "confer".  Fix a couple of places where these were
spelled incorrectly.  All were found using:

    git grep -E ' ([Ee]g[.]|[Ii]e[.]|[Cc][.]f[.])'

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Originally the changes in this patch /3 were in three separate commits (one for
"e.g", "i.e." and "cf." respectively), I'm not too sure about it, but leaning
towards having it in a single commit.

 Documentation/config/commitgraph.txt             | 2 +-
 Documentation/git-tag.txt                        | 2 +-
 compat/regex/regcomp.c                           | 2 +-
 contrib/coccinelle/README                        | 2 +-
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 2 +-
 contrib/subtree/todo                             | 4 ++--
 convert.c                                        | 2 +-
 git-p4.py                                        | 2 +-
 midx.c                                           | 2 +-
 run-command.h                                    | 2 +-
 t/t0021-conversion.sh                            | 4 ++--
 transport.c                                      | 6 +++---
 12 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
index 30604e4a4c..c37a1b7ddb 100644
--- a/Documentation/config/commitgraph.txt
+++ b/Documentation/config/commitgraph.txt
@@ -6,7 +6,7 @@ commitGraph.generationVersion::
 
 commitGraph.maxNewFilters::
 	Specifies the default value for the `--max-new-filters` option of `git
-	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
+	commit-graph write` (cf., linkgit:git-commit-graph[1]).
 
 commitGraph.readChangedPaths::
 	If true, then git will use the changed-path Bloom filters in the
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 31a97a1b6c..84491ff08e 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -297,7 +297,7 @@ On Automatic following
 ~~~~~~~~~~~~~~~~~~~~~~
 
 If you are following somebody else's tree, you are most likely
-using remote-tracking branches (eg. `refs/remotes/origin/master`).
+using remote-tracking branches (e.g. `refs/remotes/origin/master`).
 You usually want the tags from the other end.
 
 On the other hand, if you are fetching because you would want a
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d1bc09e49b..fcf7b2daf6 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -2370,7 +2370,7 @@ parse_expression (re_string_t *regexp, regex_t *preg, re_token_t *token,
 	}
       /* We must return here, since ANCHORs can't be followed
 	 by repetition operators.
-	 eg. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
+	 e.g. RE"^*" is invalid or "<ANCHOR(^)><CHAR(*)>",
 	     it must not be "<ANCHOR(^)><REPEAT(*)>".  */
       fetch_token (token, regexp, syntax);
       return tree;
diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index f0e80bd7f0..c7723a5542 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -18,7 +18,7 @@ There are two types of semantic patches:
                a strbuf, 2018-03-25)
    f919ffebed (Use MOVE_ARRAY, 2018-01-22)
 
-   These types of semantic patches are usually part of testing, c.f.
+   These types of semantic patches are usually part of testing, cf.
    0860a7641b (travis-ci: fail if Coccinelle static analysis found something
                to transform, 2018-07-23)
 
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index f6f5195d00..12140b9734 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -21,7 +21,7 @@ fi
 # dh_test is a test helper function which takes 3 file names as parameters. The
 # first 2 files are used to generate diff and commit output, which is then
 # piped through diff-highlight. The 3rd file should contain the expected output
-# of diff-highlight (minus the diff/commit header, ie. everything after and
+# of diff-highlight (minus the diff/commit header, i.e. everything after and
 # including the first @@ line).
 dh_test () {
 	a="$1" b="$2" &&
diff --git a/contrib/subtree/todo b/contrib/subtree/todo
index 32d2ce3a40..c9cef579b7 100644
--- a/contrib/subtree/todo
+++ b/contrib/subtree/todo
@@ -1,7 +1,7 @@
 
 	delete tempdir
 
-	'git subtree rejoin' option to do the same as --rejoin, eg. after a
+	'git subtree rejoin' option to do the same as --rejoin, e.g. after a
 	  rebase
 
 	--prefix doesn't force the subtree correctly in merge/pull:
@@ -39,7 +39,7 @@
 
 	make a 'force-update' that does what 'add' does even if the subtree
 		already exists.  That way we can help people who imported
-		subtrees "incorrectly" (eg. by just copying in the files) in
+		subtrees "incorrectly" (e.g. by just copying in the files) in
 		the past.
 
 	guess --prefix automatically if possible based on pwd
diff --git a/convert.c b/convert.c
index 0d6fb3410a..83ad1c4183 100644
--- a/convert.c
+++ b/convert.c
@@ -335,7 +335,7 @@ static int check_roundtrip(const char *enc_name)
 {
 	/*
 	 * check_roundtrip_encoding contains a string of comma and/or
-	 * space separated encodings (eg. "UTF-16, ASCII, CP1125").
+	 * space separated encodings (e.g. "UTF-16, ASCII, CP1125").
 	 * Search for the given encoding in that string.
 	 */
 	const char *found = strcasestr(check_roundtrip_encoding, enc_name);
diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..eae4e5ff8f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1388,7 +1388,7 @@ def generatePointer(self, contentFile):
         # Git LFS removed the preamble in the output of the 'pointer' command
         # starting from version 1.2.0. Check for the preamble here to support
         # earlier versions.
-        # c.f. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
+        # cf. https://github.com/github/git-lfs/commit/da2935d9a739592bc775c98d8ef4df9c72ea3b43
         if pointerFile.startswith('Git LFS pointer for'):
             pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
 
diff --git a/midx.c b/midx.c
index f96fb2efee..11a9a4219b 100644
--- a/midx.c
+++ b/midx.c
@@ -1002,7 +1002,7 @@ static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
 
 	/*
 	 * Build the MIDX-order index based on pdata.objects (which is already
-	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
+	 * in MIDX order; cf., 'midx_pack_order_cmp()' for the definition of
 	 * this order).
 	 */
 	ALLOC_ARRAY(index, pdata.nr_objects);
diff --git a/run-command.h b/run-command.h
index b9aff74914..5d4c9dc7f4 100644
--- a/run-command.h
+++ b/run-command.h
@@ -170,7 +170,7 @@ struct child_process {
  *   non-zero.
  *
  * - If the program terminated due to a signal, then the return value is the
- *   signal number + 128, ie. the same value that a POSIX shell's $? would
+ *   signal number + 128, i.e. the same value that a POSIX shell's $? would
  *   report.  A diagnostic is printed.
  *
  */
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 33dfc9cd56..d9f1a04133 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -35,7 +35,7 @@ filter_git () {
 # Compare two files and ensure that `clean` and `smudge` respectively are
 # called at least once if specified in the `expect` file. The actual
 # invocation count is not relevant because their number can vary.
-# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# cf. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_count () {
 	expect=$1
 	actual=$2
@@ -50,7 +50,7 @@ test_cmp_count () {
 
 # Compare two files but exclude all `clean` invocations because Git can
 # call `clean` zero or more times.
-# c.f. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+# cf. https://lore.kernel.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
 test_cmp_exclude_clean () {
 	expect=$1
 	actual=$2
diff --git a/transport.c b/transport.c
index b37664ba87..999bf0f2ca 100644
--- a/transport.c
+++ b/transport.c
@@ -1167,9 +1167,9 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 	 * Rules used to determine whether to report progress (processing aborts
 	 * when a rule is satisfied):
 	 *
-	 *   . Report progress, if force_progress is 1 (ie. --progress).
-	 *   . Don't report progress, if force_progress is 0 (ie. --no-progress).
-	 *   . Don't report progress, if verbosity < 0 (ie. -q/--quiet ).
+	 *   . Report progress, if force_progress is 1 (i.e. --progress).
+	 *   . Don't report progress, if force_progress is 0 (i.e. --no-progress).
+	 *   . Don't report progress, if verbosity < 0 (i.e. -q/--quiet ).
 	 *   . Report progress if isatty(2) is 1.
 	 **/
 	if (force_progress >= 0)
-- 
2.33.0

