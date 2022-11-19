Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C71C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 23:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiKSXMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 18:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiKSXLS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 18:11:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6446D1ADB0
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:11:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t4so6085922wmj.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcMarZnHzdMG5PqPrF6HVqqa2qQeHr6KLbG/005hGHk=;
        b=VdCYpyOCz4sGjTtuqIRvxxX+byZ1pJPhXGB2rZcwVB4KVT6dsTVlFHlOPTaNALG18w
         ibvgblEXTqkdA0MyGHVMBJPOn2Ys+5KcuKuW3uvcwGdkzfzJub6HSC397U8kqIApxWQI
         DPFvkaKR+2m8t6IROt1f6oy65VESnsyUa75n8vEgTtzMOHOrgGf/7MJzu+eghFnTSAjB
         ++9drWfau+TMfyVs2KoxtCEGSP5/djTQVEkxnqBzQ8mGNVNnMzcUVFJRrfXSQx3z/YDz
         wEowxju8tjL+ZC4eInueNqS/dienqMktwVrahFySPCBFwkghZ8BZRITvJJDiu3HFT7Dx
         ZYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcMarZnHzdMG5PqPrF6HVqqa2qQeHr6KLbG/005hGHk=;
        b=K3xMN5PCFisUKCreVMXhtu5dTOwEot8NpobOb3HHUw03uDMBlHkpd/0s0N8mGvb48t
         RI9ZDOXZ69uFAZe7bAMpg45OpoYlDi+Htl1AlnIt7yIfZf6KEqNF2YOAp3qaj8aEtDM9
         0u26x6R9i7aOZEsNlrYQIzzC7OeOScmOTccdzUE+o8Hh9mYkOAbOd33AVHPa30Jy6NL+
         YvgbqN3PZgIEhY/1bT6Ycyh8Yaxaw8t26H24cA0UrrY/mPAyLFlBJdaGpIc1Z++MJDMs
         ODMGEjfTwP0YlYoPhmKqZrecMFnkNsQuWklqWN20xNC9Sh5BnU2yatl5k9dzqdhOoozC
         PgSw==
X-Gm-Message-State: ANoB5pknvV15rOh8lfFPpJEiKBs0URjVvk0qrm+L2+JW08GQSsRGBrLE
        W7ArlyWLHBpE/fN+NbD1HTxgrg6b2Mk=
X-Google-Smtp-Source: AA0mqf77gbQABUl4oMMDrUun9wSikg7mVbpWY/gmnybbcZYjtzJg9PWFA2nrj95Bj3KgmFUeVpdizQ==
X-Received: by 2002:a05:600c:3845:b0:3cf:d70e:223c with SMTP id s5-20020a05600c384500b003cfd70e223cmr12230192wmr.74.1668899472983;
        Sat, 19 Nov 2022 15:11:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020a056000108a00b002366553eca7sm7202212wrw.83.2022.11.19.15.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 15:11:12 -0800 (PST)
Message-Id: <pull.1420.v2.git.1668899471058.gitgitgadget@gmail.com>
In-Reply-To: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Nov 2022 23:11:10 +0000
Subject: [PATCH v2] range-diff: support reading mbox files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Internally, the `git range-diff` command spawns a `git log` process and
parses its output for the given commit ranges.

This works well when the patches that need to be compared are present in
the local repository in the form of commits.

In scenarios where that is not the case, the `range-diff` command is
currently less helpful.

The Git mailing list is such a scenario: Instead of using Git to
exchange commits, the patches are sent there as plain-text and no commit
range can be specified to let `range-diff` consume those patches.

Instead, the expectation is to download the mails, apply them locally
and then use `range-diff`. This can be quite cumbersome e.g. when a
suitable base revision has to be found first where the patch applies
cleanly.

Let's offer a way to read those patches from pre-prepared MBox files
instead when an argument "mbox:<filename>" is passed instead of a commit
range.

For extra convenience, interpret the filename `-` as standard input.
This makes it easy to compare contributions on the mailing list with the
actual commits that were integrated into Git's main branch. Example:

	commit=5c4003ca3f0e9ac6d3c8aa3e387ff843bd440411
	mid=bdfa3845b81531863941e6a97c28eb1afa62dd2c.1489435755.git.johannes.schindelin@gmx.de
	curl -s https://lore.kernel.org/git/$mid/raw |
	git range-diff mbox:- $commit^!

This addresses https://github.com/gitgitgadget/git/issues/207

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    range-diff: support reading mbox files
    
    I frequently find myself wanting to look at the range-diff between some
    local commits and the patches on the Git mailing list, but unwilling to
    go through the process of finding an appropriate base revision to apply
    the patches onto (just to throw the generated patches away afterwards,
    anyway).
    
    So I came up with this patch. May it be helpful to other developers,
    too.
    
    This patch contains a home-rolled mbox parser. Initially, I wrote a
    really basic parser and it worked well enough, but, you know, as things
    go it became more complex than that in order to provide actually useful
    range-diffs for existing commits and their corresponding mails (because
    of in-body From: headers, because of -- trailers and long subjects, just
    to name a few reasons). In hindsight, it might have made sense to try to
    to reuse the parser that is available in mailinfo.c, which I had
    initially dismissed as overly complex and unnecessary for this use case.
    If anyone feels up to it, I would invite them to adjust this code to
    replace the mbox parser with one based on the mailinfo.c. Incrementally,
    of course, because the perfect is the enemy of the good.
    
    Changes since v1:
    
     * We no longer leak allocated memory in the struct patch instance
     * Made strtost() a bit more stringent
     * Postel [https://en.wikipedia.org/wiki/Postel%27s_Law]ized the mbox
       parser substantially, together with a couple more cosmetic fixes,
       based on Phillip Wood's excellent review of v1.
     * Extended the test case to cover mboxes containing CR/LF and in-body
       From: lines

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1420%2Fdscho%2Frange-diff-from-mbox-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1420/dscho/range-diff-from-mbox-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1420

Range-diff vs v1:

 1:  354840fc57c ! 1:  485249ddfb3 range-diff: support reading mbox files
     @@ range-diff.c: struct patch_util {
      +
      +	errno = 0;
      +	/* negative values would be accepted by strtoul */
     -+	if (*s == '-')
     ++	if (!isdigit(*s))
      +		return -1;
      +	u = strtoul(s, &p, 10);
      +	if (errno || p == s)
     @@ range-diff.c: struct patch_util {
      +
      +	if (!skip_prefix(p, "@@ -", &p) ||
      +	    strtost(p, NULL, &p) ||
     -+	    (*p != ' ' && (*p != ',' || strtost(p + 1, &o, &p))) ||
     ++	    /* The range is -<start>[,<count>], defaulting to count = 1 */
     ++	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &o, &p))) ||
      +	    !skip_prefix(p, " +", &p) ||
      +	    strtost(p, NULL, &p) ||
     -+	    (*p != ' ' && (*p != ',' || strtost(p + 1, &n, &p))) ||
     ++	    /* The range is +<start>[,<count>], defaulting to count = 1 */
     ++	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &n, &p))) ||
      +	    !skip_prefix(p, " @@", &p))
      +		return -1;
      +
     @@ range-diff.c: struct patch_util {
      +	return 0;
      +}
      +
     -+static inline int find_eol(const char *line, size_t size)
     ++/*
     ++ * This function finds the end of the line, replaces the newline character with
     ++ * a NUL, and returns the offset of the start of the next line.
     ++ *
     ++ * If no newline character was found, it returns the offset of the trailing NUL
     ++ * instead.
     ++ */
     ++static inline int find_next_line(const char *line, size_t size)
      +{
      +	char *eol;
      +
     @@ range-diff.c: struct patch_util {
      +	if (!eol)
      +		return size;
      +
     -+	if (eol != line && eol[-1] == '\r')
     -+		eol[-1] = '\0';
     -+	else
     -+		*eol = '\0';
     ++	*eol = '\0';
      +
      +	return eol + 1 - line;
      +}
     @@ range-diff.c: struct patch_util {
      +
      +	line = contents.buf;
      +	size = contents.len;
     -+	for (; size > 0; size -= len, line += len) {
     ++	for (; size; size -= len, line += len) {
      +		const char *p;
      +
     -+		len = find_eol(line, size);
     ++		len = find_next_line(line, size);
      +
     -+		if (state == MBOX_BEFORE_HEADER) {
     ++		if (state == MBOX_BEFORE_HEADER ||
     ++		    (state == MBOX_IN_DIFF && line[0] == 'F')) {
      +			if (!skip_prefix(line, "From ", &p))
      +				continue;
      +
     @@ range-diff.c: struct patch_util {
      +			author = subject = NULL;
      +
      +			state = MBOX_IN_HEADER;
     ++			continue;
      +		}
      +
      +		if (starts_with(line, "diff --git ")) {
     @@ range-diff.c: struct patch_util {
      +			strbuf_addch(&buf, '\n');
      +			if (!util->diff_offset)
      +				util->diff_offset = buf.len;
     -+			line[len - 1] = '\n';
     ++
      +			orig_len = len;
     -+			len = parse_git_diff_header(&root, &linenr, 1, line,
     -+						    len, size, &patch);
     ++			/* `find_next_line()`'s replaced the LF with a NUL */
     ++			line[len - 1] = '\n';
     ++			len = len > 1 && line[len - 2] == '\r' ?
     ++				error(_("cannot handle diff headers with "
     ++					"CR/LF line endings")) :
     ++				parse_git_diff_header(&root, &linenr, 1, line,
     ++						      len, size, &patch);
      +			if (len < 0) {
      +				error(_("could not parse git header '%.*s'"),
      +				      orig_len, line);
     ++				release_patch(&patch);
      +				free(util);
      +				free(current_filename);
      +				string_list_clear(list, 1);
     @@ range-diff.c: struct patch_util {
      +					    (const char **)&patch.new_name);
      +
      +			strbuf_addstr(&buf, " ## ");
     -+			if (patch.is_new > 0)
     ++			if (patch.is_new)
      +				strbuf_addf(&buf, "%s (new)", patch.new_name);
     -+			else if (patch.is_delete > 0)
     ++			else if (patch.is_delete)
      +				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
      +			else if (patch.is_rename)
      +				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
     @@ range-diff.c: struct patch_util {
      +				strbuf_addstr(&buf, patch.new_name);
      +
      +			free(current_filename);
     -+			if (patch.is_delete > 0)
     ++			if (patch.is_delete)
      +				current_filename = xstrdup(patch.old_name);
      +			else
      +				current_filename = xstrdup(patch.new_name);
     @@ range-diff.c: struct patch_util {
      +
      +			strbuf_addstr(&buf, " ##\n");
      +			util->diffsize++;
     ++			release_patch(&patch);
      +		} else if (state == MBOX_IN_HEADER) {
      +			if (!line[0]) {
      +				state = MBOX_IN_COMMIT_MESSAGE;
      +				/* Look for an in-body From: */
     -+				if (size > 5 && skip_prefix(line + 1, "From: ", &p)) {
     ++				if (skip_prefix(line + 1, "From: ", &p)) {
      +					size -= p - line;
      +					line += p - line;
     -+					len = find_eol(line, size);
     ++					len = find_next_line(line, size);
      +
      +					while (isspace(*p))
      +						p++;
     @@ range-diff.c: struct patch_util {
      +					while (len < size && line[len] == ' ') {
      +						line += len;
      +						size -= len;
     -+						len = find_eol(line, size);
     ++						len = find_next_line(line, size);
      +						strbuf_addstr(&long_subject, line);
      +					}
      +					subject = long_subject.buf;
      +				}
      +			}
      +		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
     -+			if (!*line)
     ++			if (!line[0]) {
      +				strbuf_addch(&buf, '\n');
     -+			else if (strcmp(line, "---")) {
     ++			} else if (strcmp(line, "---")) {
      +				int tabs = 0;
      +
      +				/* simulate tab expansion */
     @@ range-diff.c: struct patch_util {
      +			case '+':
      +			case '-':
      +			case ' ':
     ++				/* A `-- ` line indicates the end of a diff */
      +				if (!old_count && !new_count)
      +					break;
      +				if (old_count && line[0] != '+')
     @@ t/t3206-range-diff.sh: test_expect_success 'ranges with pathspecs' '
      +test_expect_success 'compare range vs mbox' '
      +	git format-patch --stdout topic..mode-only-change >mbox &&
      +	git range-diff topic...mode-only-change >expect &&
     ++
      +	git range-diff mode-only-change..topic mbox:./mbox >actual &&
      +	test_cmp expect actual &&
     -+	git range-diff mode-only-change..topic mbox:- <mbox >actual &&
     -+	test_cmp expect actual
     ++
     ++	sed -e "/^From: .*/{
     ++		h
     ++		s/.*/From: Bugs Bunny <bugs@bun.ny>/
     ++		:1
     ++		N
     ++		/[ -z]$/b1
     ++		G
     ++	}" <mbox >mbox.from &&
     ++	git range-diff mode-only-change..topic mbox:./mbox.from >actual.from &&
     ++	test_cmp expect actual.from &&
     ++
     ++	append_cr <mbox >mbox.cr &&
     ++	test_must_fail git range-diff \
     ++		mode-only-change..topic mbox:./mbox.cr 2>err &&
     ++	grep CR/LF err &&
     ++
     ++	git range-diff mode-only-change..topic mbox:- <mbox >actual.stdin &&
     ++	test_cmp expect actual.stdin
      +'
      +
       test_expect_success 'submodule changes are shown irrespective of diff.submodule' '


 Documentation/git-range-diff.txt |   3 +-
 range-diff.c                     | 333 ++++++++++++++++++++++++++++++-
 t/t3206-range-diff.sh            |  27 +++
 3 files changed, 361 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 0b393715d70..e2c4661acde 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -37,7 +37,8 @@ There are three ways to specify the commit ranges:
 
 - `<range1> <range2>`: Either commit range can be of the form
   `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
-  in linkgit:gitrevisions[7] for more details.
+  in linkgit:gitrevisions[7] for more details. Alternatively, the
+  patches can be provided as an mbox-formatted file via `mbox:<path>`.
 
 - `<rev1>...<rev2>`. This is equivalent to
   `<rev2>..<rev1> <rev1>..<rev2>`.
diff --git a/range-diff.c b/range-diff.c
index 124dd678c38..9dc1e3af3f8 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -12,6 +12,7 @@
 #include "userdiff.h"
 #include "apply.h"
 #include "revision.h"
+#include "dir.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -26,6 +27,309 @@ struct patch_util {
 	struct object_id oid;
 };
 
+static inline int strtost(char const *s, size_t *result, const char **end)
+{
+	unsigned long u;
+	char *p;
+
+	errno = 0;
+	/* negative values would be accepted by strtoul */
+	if (!isdigit(*s))
+		return -1;
+	u = strtoul(s, &p, 10);
+	if (errno || p == s)
+		return -1;
+	if (result)
+		*result = u;
+	*end = p;
+
+	return 0;
+}
+
+static int parse_hunk_header(const char *p,
+			     size_t *old_count, size_t *new_count,
+			     const char **end)
+{
+	size_t o = 1, n = 1;
+
+	if (!skip_prefix(p, "@@ -", &p) ||
+	    strtost(p, NULL, &p) ||
+	    /* The range is -<start>[,<count>], defaulting to count = 1 */
+	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &o, &p))) ||
+	    !skip_prefix(p, " +", &p) ||
+	    strtost(p, NULL, &p) ||
+	    /* The range is +<start>[,<count>], defaulting to count = 1 */
+	    !(*p == ' ' || (*p == ',' && !strtost(p + 1, &n, &p))) ||
+	    !skip_prefix(p, " @@", &p))
+		return -1;
+
+	*old_count = o;
+	*new_count = n;
+	*end = p;
+
+	return 0;
+}
+
+/*
+ * This function finds the end of the line, replaces the newline character with
+ * a NUL, and returns the offset of the start of the next line.
+ *
+ * If no newline character was found, it returns the offset of the trailing NUL
+ * instead.
+ */
+static inline int find_next_line(const char *line, size_t size)
+{
+	char *eol;
+
+	eol = memchr(line, '\n', size);
+	if (!eol)
+		return size;
+
+	*eol = '\0';
+
+	return eol + 1 - line;
+}
+
+static int read_mbox(const char *path, struct string_list *list)
+{
+	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
+	struct strbuf long_subject = STRBUF_INIT;
+	struct patch_util *util = NULL;
+	enum {
+		MBOX_BEFORE_HEADER,
+		MBOX_IN_HEADER,
+		MBOX_IN_COMMIT_MESSAGE,
+		MBOX_AFTER_TRIPLE_DASH,
+		MBOX_IN_DIFF
+	} state = MBOX_BEFORE_HEADER;
+	char *line, *current_filename = NULL;
+	int len;
+	size_t size, old_count = 0, new_count = 0;
+	const char *author = NULL, *subject = NULL;
+
+	if (!strcmp(path, "-")) {
+		if (strbuf_read(&contents, STDIN_FILENO, 0) < 0)
+			return error_errno(_("could not read stdin"));
+	} else if (strbuf_read_file(&contents, path, 0) < 0)
+		return error_errno(_("could not read '%s'"), path);
+
+	line = contents.buf;
+	size = contents.len;
+	for (; size; size -= len, line += len) {
+		const char *p;
+
+		len = find_next_line(line, size);
+
+		if (state == MBOX_BEFORE_HEADER ||
+		    (state == MBOX_IN_DIFF && line[0] == 'F')) {
+			if (!skip_prefix(line, "From ", &p))
+				continue;
+
+			util = xcalloc(1, sizeof(*util));
+			if (get_oid_hex(p, &util->oid) < 0)
+				oidcpy(&util->oid, null_oid());
+			util->matching = -1;
+			author = subject = NULL;
+
+			state = MBOX_IN_HEADER;
+			continue;
+		}
+
+		if (starts_with(line, "diff --git ")) {
+			struct patch patch = { 0 };
+			struct strbuf root = STRBUF_INIT;
+			int linenr = 0;
+			int orig_len;
+
+			state = MBOX_IN_DIFF;
+			old_count = new_count = 0;
+			strbuf_addch(&buf, '\n');
+			if (!util->diff_offset)
+				util->diff_offset = buf.len;
+
+			orig_len = len;
+			/* `find_next_line()`'s replaced the LF with a NUL */
+			line[len - 1] = '\n';
+			len = len > 1 && line[len - 2] == '\r' ?
+				error(_("cannot handle diff headers with "
+					"CR/LF line endings")) :
+				parse_git_diff_header(&root, &linenr, 1, line,
+						      len, size, &patch);
+			if (len < 0) {
+				error(_("could not parse git header '%.*s'"),
+				      orig_len, line);
+				release_patch(&patch);
+				free(util);
+				free(current_filename);
+				string_list_clear(list, 1);
+				strbuf_release(&buf);
+				strbuf_release(&contents);
+				strbuf_release(&long_subject);
+				return -1;
+			}
+
+			if (patch.old_name)
+				skip_prefix(patch.old_name, "a/",
+					    (const char **)&patch.old_name);
+			if (patch.new_name)
+				skip_prefix(patch.new_name, "b/",
+					    (const char **)&patch.new_name);
+
+			strbuf_addstr(&buf, " ## ");
+			if (patch.is_new)
+				strbuf_addf(&buf, "%s (new)", patch.new_name);
+			else if (patch.is_delete)
+				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
+			else if (patch.is_rename)
+				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
+			else
+				strbuf_addstr(&buf, patch.new_name);
+
+			free(current_filename);
+			if (patch.is_delete)
+				current_filename = xstrdup(patch.old_name);
+			else
+				current_filename = xstrdup(patch.new_name);
+
+			if (patch.new_mode && patch.old_mode &&
+			    patch.old_mode != patch.new_mode)
+				strbuf_addf(&buf, " (mode change %06o => %06o)",
+					    patch.old_mode, patch.new_mode);
+
+			strbuf_addstr(&buf, " ##\n");
+			util->diffsize++;
+			release_patch(&patch);
+		} else if (state == MBOX_IN_HEADER) {
+			if (!line[0]) {
+				state = MBOX_IN_COMMIT_MESSAGE;
+				/* Look for an in-body From: */
+				if (skip_prefix(line + 1, "From: ", &p)) {
+					size -= p - line;
+					line += p - line;
+					len = find_next_line(line, size);
+
+					while (isspace(*p))
+						p++;
+					author = p;
+				}
+				strbuf_addstr(&buf, " ## Metadata ##\n");
+				if (author)
+					strbuf_addf(&buf, "Author: %s\n", author);
+				strbuf_addstr(&buf, "\n ## Commit message ##\n");
+				if (subject)
+					strbuf_addf(&buf, "    %s\n\n", subject);
+			} else if (skip_prefix(line, "From: ", &p)) {
+				while (isspace(*p))
+					p++;
+				author = p;
+			} else if (skip_prefix(line, "Subject: ", &p)) {
+				const char *q;
+
+				while (isspace(*p))
+					p++;
+				subject = p;
+
+				if (starts_with(p, "[PATCH") &&
+				    (q = strchr(p, ']'))) {
+					q++;
+					while (isspace(*q))
+						q++;
+					subject = q;
+				}
+
+				if (len < size && line[len] == ' ') {
+					/* handle long subject */
+					strbuf_reset(&long_subject);
+					strbuf_addstr(&long_subject, subject);
+					while (len < size && line[len] == ' ') {
+						line += len;
+						size -= len;
+						len = find_next_line(line, size);
+						strbuf_addstr(&long_subject, line);
+					}
+					subject = long_subject.buf;
+				}
+			}
+		} else if (state == MBOX_IN_COMMIT_MESSAGE) {
+			if (!line[0]) {
+				strbuf_addch(&buf, '\n');
+			} else if (strcmp(line, "---")) {
+				int tabs = 0;
+
+				/* simulate tab expansion */
+				while (line[tabs] == '\t')
+					tabs++;
+				strbuf_addf(&buf, "%*s%s\n",
+					    4 + 8 * tabs, "", line + tabs);
+			} else {
+				/*
+				 * Trim the trailing newline that is added
+				 * by `format-patch`.
+				 */
+				strbuf_trim_trailing_newline(&buf);
+				state = MBOX_AFTER_TRIPLE_DASH;
+			}
+		} else if (state == MBOX_IN_DIFF) {
+			switch (line[0]) {
+			case '\0':
+				continue; /* ignore empty lines after diff */
+			case '+':
+			case '-':
+			case ' ':
+				/* A `-- ` line indicates the end of a diff */
+				if (!old_count && !new_count)
+					break;
+				if (old_count && line[0] != '+')
+					old_count--;
+				if (new_count && line[0] != '-')
+					new_count--;
+				/* fallthrough */
+			case '\\':
+				strbuf_addstr(&buf, line);
+				strbuf_addch(&buf, '\n');
+				util->diffsize++;
+				continue;
+			case '@':
+				if (parse_hunk_header(line, &old_count,
+						      &new_count, &p))
+					break;
+
+				strbuf_addstr(&buf, "@@");
+				if (current_filename && *p)
+					strbuf_addf(&buf, " %s:",
+						    current_filename);
+				strbuf_addstr(&buf, p);
+				strbuf_addch(&buf, '\n');
+				util->diffsize++;
+				continue;
+			}
+
+			if (util) {
+				string_list_append(list, buf.buf)->util = util;
+				strbuf_reset(&buf);
+			}
+			util = xcalloc(1, sizeof(*util));
+			oidcpy(&util->oid, null_oid());
+			util->matching = -1;
+			author = subject = NULL;
+			state = MBOX_BEFORE_HEADER;
+		}
+	}
+	strbuf_release(&contents);
+
+	if (util) {
+		if (state == MBOX_IN_DIFF)
+			string_list_append(list, buf.buf)->util = util;
+		else
+			free(util);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&long_subject);
+	free(current_filename);
+
+	return 0;
+}
+
 /*
  * Reads the patches into a string list, with the `util` field being populated
  * as struct object_id (will need to be free()d).
@@ -41,6 +345,10 @@ static int read_patches(const char *range, struct string_list *list,
 	ssize_t len;
 	size_t size;
 	int ret = -1;
+	const char *path;
+
+	if (skip_prefix(range, "mbox:", &path))
+		return read_mbox(path, list);
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
@@ -424,6 +732,19 @@ static void output_pair_header(struct diff_options *diffopt,
 
 		strbuf_addch(buf, ' ');
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+	} else {
+		struct patch_util *util = b_util ? b_util : a_util;
+		const char *needle = "\n ## Commit message ##\n";
+		const char *p = !util || !util->patch ?
+			NULL : strstr(util->patch, needle);
+		if (p) {
+			if (status == '!')
+				strbuf_addf(buf, "%s%s", color_reset, color);
+
+			strbuf_addch(buf, ' ');
+			p += strlen(needle);
+			strbuf_add(buf, p, strchrnul(p, '\n') - p);
+		}
 	}
 	strbuf_addf(buf, "%s\n", color_reset);
 
@@ -554,6 +875,9 @@ int show_range_diff(const char *range1, const char *range2,
 	if (range_diff_opts->left_only && range_diff_opts->right_only)
 		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
 
+	if (!strcmp(range1, "mbox:-") && !strcmp(range2, "mbox:-"))
+		res = error(_("only one mbox can be read from stdin"));
+
 	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
 	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
@@ -575,10 +899,17 @@ int show_range_diff(const char *range1, const char *range2,
 int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
-	const char *argv[] = { "", copy, "--", NULL };
+	const char *argv[] = { "", copy, "--", NULL }, *path;
 	int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
+	if (skip_prefix(arg, "mbox:", &path)) {
+		if (!strcmp(path, "-") || file_exists(path))
+			return 1;
+		error_errno(_("not an mbox: '%s'"), path);
+		return 0;
+	}
+
 	init_revisions(&revs, NULL);
 	if (setup_revisions(3, argv, &revs, NULL) == 1) {
 		for (i = 0; i < revs.pending.nr; i++)
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 459beaf7d9c..89ef9a5ffc4 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -783,6 +783,33 @@ test_expect_success 'ranges with pathspecs' '
 	! grep "$topic_oid" actual
 '
 
+test_expect_success 'compare range vs mbox' '
+	git format-patch --stdout topic..mode-only-change >mbox &&
+	git range-diff topic...mode-only-change >expect &&
+
+	git range-diff mode-only-change..topic mbox:./mbox >actual &&
+	test_cmp expect actual &&
+
+	sed -e "/^From: .*/{
+		h
+		s/.*/From: Bugs Bunny <bugs@bun.ny>/
+		:1
+		N
+		/[ -z]$/b1
+		G
+	}" <mbox >mbox.from &&
+	git range-diff mode-only-change..topic mbox:./mbox.from >actual.from &&
+	test_cmp expect actual.from &&
+
+	append_cr <mbox >mbox.cr &&
+	test_must_fail git range-diff \
+		mode-only-change..topic mbox:./mbox.cr 2>err &&
+	grep CR/LF err &&
+
+	git range-diff mode-only-change..topic mbox:- <mbox >actual.stdin &&
+	test_cmp expect actual.stdin
+'
+
 test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
 	git init sub-repo &&
 	test_commit -C sub-repo sub-first &&

base-commit: b75747829f4c277323c78b1c5973ad63ea038a2d
-- 
gitgitgadget
