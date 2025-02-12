Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B527182D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334140; cv=none; b=C3J/8N2GnMLhm4uwViKDaJywkazgZJT7zbl18TamujVHdpfh16RwWcPSNojWsDwFgRYLkAq2qHQPZt87jyifp8tFGI/7QZqtfqbZ3Ecf7My2d14E14eyHY2QqsFfRFeVdwbquXvwz/J8/HGxoHeOZJQEAoKWYbQQwlFxfIy16RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334140; c=relaxed/simple;
	bh=MiqikVEC4W883oHo0g1IyCjcl5uc2MrdSAitsbir3og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvJ7jeZBEJTws5jf9HxLf/+NaqGWJb9z9s4lgDCkcnu7w1GveJXVZeffEURFZh9hqjnfbtcuMCX4al9piAOtd1r6LYS6GtvGcQGF61LHmFLzfPjzOpk2orDxsgJ7HZn0g2b2D7WuQfYgdg1cWAPQFxMS/ERwi1L3wRtpb2sDJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9r3VKU5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9r3VKU5"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-726819aa651so1756330a34.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739334137; x=1739938937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv7q8EP0K/g2PbhTJ4bMYfbqMlYut/xuC8p+c856jRw=;
        b=i9r3VKU53nl+/dqE2XWLBL6N/MOFzHCLSUPARCTGxBtRlf+p1xpkZSSfZAdtln1pJS
         NsWfrfk3TTx1VYWEiT0jWEe8w8i8rl48e/BaPkXKgdjTvdpZhNTgiOKVhEO45nqQWj1Z
         FL9wfR95MVgi07IigATM3ttMcRvTOR87cM3JgBOnTXz18n5LeRMSpNZ1YBaxcujEnjua
         J4oJMQzO+tK5Q9kvsMb1F+XNG12csODP2bfCJIZgV4uhGR2H0DgEiyyijCsxEE8qzcXR
         SV5EbJzEiUuwR3UeG24s/G+MXUkRx2qkBuwz+i/sAvBttS8X6l8z4PUC9CKsjBcFT8xD
         w+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739334137; x=1739938937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv7q8EP0K/g2PbhTJ4bMYfbqMlYut/xuC8p+c856jRw=;
        b=PNdeureiS1vLKXCbo6xZXP0ukcXhxCa5RaFNzzmOQEkThvEpDYC79Jre73qGzq31xC
         n5bsBR1JpgZS6AxwGF+fuZWz6RcmCjO5ZlUca3KzlNzKjOL/DOMReId0qWT3D9NZOofu
         onxRHDwCVcpo2eAQZpbkLf1ZiMjQrF6KmjOQbzj7X2XzdLTUHdtH7p1D4DrLsFB9pNhF
         E5SXc6DOhAdqsa5FLdj22WqQbPhgfSIE8SPXMkCf5bJvedkALDv4MzHogfjFig52HOWr
         us9J8eytOL8YcjYweAMASNi2aH4cj+KJjvD8guOap/HDsSFK8IBVNqrClPmqGYNWLUyz
         lGRg==
X-Gm-Message-State: AOJu0YycY3yuV3Cfh05QWSE3qrj1MMj3+pMYPOWE0ayMMXQ7Ponk8Pkb
	cNf0WfDHvaRODMzyNkXDJYjJ+A4tib2CiQocIc+tYLPKYbzEtQu34bzkkA==
X-Gm-Gg: ASbGncuAuES/X8lerxTT/ygaa4ifIs8o6FUQbpKVqAvNsYeYfw8Tajvq7RXdpzq7FkY
	A/zDchc4s2+IqYuweWGHSZ133WWEfJX7BGJH2lX1xM5SgXmOdGrUg0zT1OJfvC8ta0GUE3T5Gy8
	1zKxQgeZrU9R3TamSA/f2nVuLQ5fB/noHW1Y0eMZH2my1Mm88fA4MIQGdIrytg6BH/+0ukZpkf5
	bSHd1RwX5Oi8kbeP+VOvQizn04G9EVA4x+OCS94FV+eujHN3btQCDdR83zBTU2duvOQ6biy28Um
	qn5v/kbfjcpwDxiZ/AbymMg=
X-Google-Smtp-Source: AGHT+IGWoDXpFYR9eUyxfCfCFqQFtT96p8LpOTPGjCgxyYMUoHVIETGq46MqgPcwTiLGKxfUF9MJvQ==
X-Received: by 2002:a05:6870:d1c9:b0:29e:2caf:8cc with SMTP id 586e51a60fabf-2b8d68cbe5bmr1156637fac.37.1739334136634;
        Tue, 11 Feb 2025 20:22:16 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8a0bb67fesm2293392fac.39.2025.02.11.20.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:22:16 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/3] builtin: introduce diff-pairs command
Date: Tue, 11 Feb 2025 22:18:24 -0600
Message-ID: <20250212041825.2455031-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212041825.2455031-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1), a single diff can be generated from a pair of blob
revisions directly. Unfortunately, there is not a mechanism to compute
batches of specific file pair diffs in a single process. Such a feature
is particularly useful on the server-side where diffing between a large
set of changes is not feasible all at once due to timeout concerns.

To facilitate this, introduce git-diff-pairs(1) which takes the
null-terminated raw diff format as input on stdin and produces diffs in
other formats. As the raw diff format already contains the necessary
metadata, it becomes possible to progressively generate batches of diffs
without having to recompute rename detection or retrieve object context.
Something like the following:

	git diff-tree -r -z -M $old $new |
	git diff-pairs -p

should generate the same output as `git diff-tree -p -M`. Furthermore,
each line of raw diff formatted input can also be individually fed to a
separate git-diff-pairs(1) process and still produce the same output.

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitignore                        |   1 +
 Documentation/git-diff-pairs.adoc |  62 +++++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/diff-pairs.c              | 178 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             |  80 ++++++++++++++
 11 files changed, 328 insertions(+)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

diff --git a/.gitignore b/.gitignore
index e82aa19df0..03448c076a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -54,6 +54,7 @@
 /git-diff
 /git-diff-files
 /git-diff-index
+/git-diff-pairs
 /git-diff-tree
 /git-difftool
 /git-difftool--helper
diff --git a/Documentation/git-diff-pairs.adoc b/Documentation/git-diff-pairs.adoc
new file mode 100644
index 0000000000..e9ef4a6615
--- /dev/null
+++ b/Documentation/git-diff-pairs.adoc
@@ -0,0 +1,62 @@
+git-diff-pairs(1)
+=================
+
+NAME
+----
+git-diff-pairs - Compare blob pairs generated by `diff-tree --raw`
+
+SYNOPSIS
+--------
+[verse]
+'git diff-pairs' [diff-options]
+
+DESCRIPTION
+-----------
+
+Given the output of `diff-tree -z` on its stdin, `diff-pairs` will
+reformat that output into whatever format is requested on its command
+line.  For example:
+
+-----------------------------
+git diff-tree -z -M $a $b |
+git diff-pairs -p
+-----------------------------
+
+will compute the tree diff in one step (including renames), and then
+`diff-pairs` will compute and format the blob-level diffs for each pair.
+This can be used to modify the raw diff in the middle (without having to
+parse or re-create more complicated formats like `--patch`), or to
+compute diffs progressively over the course of multiple invocations of
+`diff-pairs`.
+
+Each blob pair is fed to the diff machinery individually queued and the output
+is flushed on stdin EOF.
+
+OPTIONS
+-------
+
+include::diff-options.adoc[]
+
+include::diff-generate-patch.adoc[]
+
+NOTES
+----
+
+`diff-pairs` should handle any input generated by `diff-tree --raw -z`.
+It may choke or otherwise misbehave on output from `diff-files`, etc.
+
+Here's an incomplete list of things that `diff-pairs` could do, but
+doesn't (mostly in the name of simplicity):
+
+ - Only `-z` input is accepted, not normal `--raw` input.
+
+ - Abbreviated sha1s are rejected in the input from `diff-tree`; if you
+   want to abbreviate the output, you can pass `--abbrev` to
+   `diff-pairs`.
+
+ - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
+   the initial `diff-tree` invocation.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index ead8e48213..e5ee177022 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -41,6 +41,7 @@ manpages = {
   'git-diagnose.adoc' : 1,
   'git-diff-files.adoc' : 1,
   'git-diff-index.adoc' : 1,
+  'git-diff-pairs.adoc' : 1,
   'git-difftool.adoc' : 1,
   'git-diff-tree.adoc' : 1,
   'git-diff.adoc' : 1,
diff --git a/Makefile b/Makefile
index 896d02339e..3b8e1ad15e 100644
--- a/Makefile
+++ b/Makefile
@@ -1232,6 +1232,7 @@ BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diagnose.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
+BUILTIN_OBJS += builtin/diff-pairs.o
 BUILTIN_OBJS += builtin/diff-tree.o
 BUILTIN_OBJS += builtin/diff.o
 BUILTIN_OBJS += builtin/difftool.o
diff --git a/builtin.h b/builtin.h
index f7b166b334..b2d2e9eb07 100644
--- a/builtin.h
+++ b/builtin.h
@@ -152,6 +152,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix, struct reposit
 int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/diff-pairs.c b/builtin/diff-pairs.c
new file mode 100644
index 0000000000..08f3ee81e5
--- /dev/null
+++ b/builtin/diff-pairs.c
@@ -0,0 +1,178 @@
+#include "builtin.h"
+#include "commit.h"
+#include "config.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "gettext.h"
+#include "hex.h"
+#include "object.h"
+#include "parse-options.h"
+#include "revision.h"
+#include "strbuf.h"
+
+static unsigned parse_mode_or_die(const char *mode, const char **endp)
+{
+	uint16_t ret;
+
+	*endp = parse_mode(mode, &ret);
+	if (!*endp)
+		die("unable to parse mode: %s", mode);
+	return ret;
+}
+
+static void parse_oid(const char *p, struct object_id *oid, const char **endp,
+		      const struct git_hash_algo *algop)
+{
+	if (parse_oid_hex_algop(p, oid, endp, algop) || *(*endp)++ != ' ')
+		die("unable to parse object id: %s", p);
+}
+
+static unsigned short parse_score(const char *score)
+{
+	unsigned long ret;
+	char *endp;
+
+	errno = 0;
+	ret = strtoul(score, &endp, 10);
+	ret *= MAX_SCORE / 100;
+	if (errno || endp == score || *endp || (unsigned short)ret != ret)
+		die("unable to parse rename/copy score: %s", score);
+	return ret;
+}
+
+static void flush_diff_queue(struct diff_options *options)
+{
+	/*
+	 * If rename detection is not requested, use rename information from the
+	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
+	 * does not mess with rename information already present in queued
+	 * filepairs.
+	 */
+	if (!options->detect_rename)
+		options->found_follow = 1;
+	diffcore_std(options);
+	diff_flush(options);
+}
+
+int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
+		   struct repository *repo)
+{
+	struct strbuf path_dst = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
+	struct strbuf meta = STRBUF_INIT;
+	struct rev_info revs;
+	int ret;
+
+	const char * const usage[] = {
+		N_("git diff-pairs [diff-options]"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	show_usage_with_options_if_asked(argc, argv, usage, options);
+
+	repo_init_revisions(repo, &revs, prefix);
+	repo_config(repo, git_diff_basic_config, NULL);
+	revs.disable_stdin = 1;
+	revs.abbrev = 0;
+	revs.diff = 1;
+
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	/* Don't allow pathspecs at all. */
+	if (revs.prune_data.nr)
+		usage_with_options(usage, options);
+
+	if (!revs.diffopt.output_format)
+		revs.diffopt.output_format = DIFF_FORMAT_RAW;
+
+	while (1) {
+		struct object_id oid_a, oid_b;
+		struct diff_filepair *pair;
+		unsigned mode_a, mode_b;
+		const char *p;
+		char status;
+
+		if (strbuf_getline_nul(&meta, stdin) == EOF)
+			break;
+
+		p = meta.buf;
+		if (*p != ':')
+			die("invalid raw diff input");
+		p++;
+
+		mode_a = parse_mode_or_die(p, &p);
+		mode_b = parse_mode_or_die(p, &p);
+
+		parse_oid(p, &oid_a, &p, repo->hash_algo);
+		parse_oid(p, &oid_b, &p, repo->hash_algo);
+
+		status = *p++;
+
+		if (strbuf_getline_nul(&path, stdin) == EOF)
+			die("got EOF while reading path");
+
+		switch (status) {
+		case DIFF_STATUS_ADDED:
+			pair = diff_filepair_addremove(&revs.diffopt, '+',
+						       mode_b, &oid_b,
+						       1, path.buf, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_DELETED:
+			pair = diff_filepair_addremove(&revs.diffopt, '-',
+						       mode_a, &oid_a,
+						       1, path.buf, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_TYPE_CHANGED:
+		case DIFF_STATUS_MODIFIED:
+			pair = diff_filepair_change(&revs.diffopt,
+						    mode_a, mode_b,
+						    &oid_a, &oid_b, 1, 1,
+						    path.buf, 0, 0);
+			if (pair)
+				pair->status = status;
+			break;
+
+		case DIFF_STATUS_RENAMED:
+		case DIFF_STATUS_COPIED:
+			{
+				struct diff_filespec *a, *b;
+
+				if (strbuf_getline_nul(&path_dst, stdin) == EOF)
+					die("got EOF while reading destination path");
+
+				a = alloc_filespec(path.buf);
+				b = alloc_filespec(path_dst.buf);
+				fill_filespec(a, &oid_a, 1, mode_a);
+				fill_filespec(b, &oid_b, 1, mode_b);
+
+				pair = diff_queue(&diff_queued_diff, a, b);
+				pair->status = status;
+				pair->score = parse_score(p);
+				pair->renamed_pair = 1;
+			}
+			break;
+
+		default:
+			die("unknown diff status: %c", status);
+		}
+	}
+
+	flush_diff_queue(&revs.diffopt);
+	ret = diff_result_code(&revs);
+
+	strbuf_release(&path_dst);
+	strbuf_release(&path);
+	strbuf_release(&meta);
+	release_revisions(&revs);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index e0bb87b3b5..bb8acd51d8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -95,6 +95,7 @@ git-diagnose                            ancillaryinterrogators
 git-diff                                mainporcelain           info
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
+git-diff-pairs                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-difftool                            ancillaryinterrogators          complete
 git-fast-export                         ancillarymanipulators
diff --git a/git.c b/git.c
index b23761480f..12bba872bb 100644
--- a/git.c
+++ b/git.c
@@ -540,6 +540,7 @@ static struct cmd_struct commands[] = {
 	{ "diff", cmd_diff, NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
+	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
 	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
diff --git a/meson.build b/meson.build
index fbb8105d96..66ce3326e8 100644
--- a/meson.build
+++ b/meson.build
@@ -537,6 +537,7 @@ builtin_sources = [
   'builtin/diagnose.c',
   'builtin/diff-files.c',
   'builtin/diff-index.c',
+  'builtin/diff-pairs.c',
   'builtin/diff-tree.c',
   'builtin/diff.c',
   'builtin/difftool.c',
diff --git a/t/meson.build b/t/meson.build
index 4574280590..7ff17c6d29 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -500,6 +500,7 @@ integration_tests = [
   't4067-diff-partial-clone.sh',
   't4068-diff-symmetric-merge-base.sh',
   't4069-remerge-diff.sh',
+  't4070-diff-pairs.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4070-diff-pairs.sh b/t/t4070-diff-pairs.sh
new file mode 100755
index 0000000000..e0a8e6f0a0
--- /dev/null
+++ b/t/t4070-diff-pairs.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+
+test_description='basic diff-pairs tests'
+. ./test-lib.sh
+
+# This creates a diff with added, modified, deleted, renamed, copied, and
+# typechange entries. That includes one in a subdirectory for non-recursive
+# tests, and both exact and inexact similarity scores.
+test_expect_success 'create commit with various diffs' '
+	echo to-be-gone >deleted &&
+	echo original >modified &&
+	echo now-a-file >symlink &&
+	test_seq 200 >two-hundred &&
+	test_seq 201 500 >five-hundred &&
+	git add . &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	echo now-here >added &&
+	echo new >modified &&
+	rm deleted &&
+	mkdir subdir &&
+	echo content >subdir/file &&
+	mv two-hundred renamed &&
+	test_seq 201 500 | sed s/300/modified/ >copied &&
+	rm symlink &&
+	git add -A . &&
+	test_ln_s_add dest symlink &&
+	test_tick &&
+	git commit -m new &&
+	git tag new
+'
+
+test_expect_success 'diff-pairs recreates --raw' '
+	git diff-tree -r -M -C -C base new >expect &&
+	git diff-tree -r -M -C -C -z base new |
+	git diff-pairs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-pairs can create -p output' '
+	git diff-tree -p -M -C -C base new >expect &&
+	git diff-tree -r -M -C -C -z base new |
+	git diff-pairs -p >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-recursive --raw retains tree entry' '
+	git diff-tree base new >expect &&
+	git diff-tree -z base new |
+	git diff-pairs >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'split input across multiple diff-pairs' '
+	write_script split-raw-diff "$PERL_PATH" <<-\EOF &&
+	$/ = "\0";
+	while (<>) {
+	  my $meta = $_;
+	  my $path = <>;
+	  # renames have an extra path
+	  my $path2 = <> if $meta =~ /[RC]\d+/;
+
+	  open(my $fh, ">", sprintf "diff%03d", $.);
+	  print $fh $meta, $path, $path2;
+	}
+	EOF
+
+	git diff-tree -p -M -C -C base new >expect &&
+
+	git diff-tree -r -z -M -C -C base new |
+	./split-raw-diff &&
+	for i in diff*; do
+		git diff-pairs -p <$i || return 1
+	done >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.48.1

