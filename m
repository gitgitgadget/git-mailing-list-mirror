Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB6C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 13:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348031AbiFONqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbiFONqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 09:46:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF72F64C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1157195wml.1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NPBWuzVY91FUh67e4b+0VQMblVp/CpvyudUFAH3Sqhc=;
        b=ZRGikVNEFeHEXrBKgy6V/GPB3+wHdZEONqK8+A0LNPwFHFVe9ff1YxWwpMhQjm7Bd+
         nEPCuhF7W1aUAuR/XMgK1MQrm1WvGu6mKOymKsJrrOGllb4oITHRpNX3Apo+c9Q2DXgP
         YbhFtFSR4iGXM1RWHSYdDR0JlnhKs9Gew6DILuKiEdNM8QgbXvL2ke3IXuvpEr4/mWSt
         PriE5v8w1jZzL4JewyVUUxBilvO9bwYeftQlwj+M7hebpPl83hd5b7uDELjNqgqfZzrx
         zKim8M/KijUrSmXbjF62RHCgTT+ZWZRyS5VKLnovNLe6WQa39MkyAQ2F4QfiRErmpel0
         vqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NPBWuzVY91FUh67e4b+0VQMblVp/CpvyudUFAH3Sqhc=;
        b=OW3gHNC3ElHIaBOwd9AZeV0XxaZU2ZJ4YLrl7qCo4NTbL0/yCq1jpOz9qbC87PKeE6
         H/vAg5kCPMBgRsaEW8ZMAowysFsRLPg21OtRjIbHBNOe2FgdNWeyef2DEpBe+5wsOfXQ
         TY02WM+A5PxDmV1g2M76vwfBuKRJKBuVDThAY9NZHkibd36e8dgITp9YSx1gX8iDYZsY
         HxhQ4e3OwbtP3NdStp64eUyfHf46Qgo1YaFeN+ARvl91sqBrRcAcsjyAOCfteZa5w1DK
         savwYnJH5Kx7IScBRbn1ku677+SG/oDuMWo/I70hjyfNbGrwQVAhEsYOyO3CoSeQwHJN
         Bjug==
X-Gm-Message-State: AOAM533OjpsicdreWpj/Ho7nhZcHqv4NDs+xu+jh5e1/cFlWGf5wgofn
        +9HS1lt0CaN3k5Uo40JVt36RxIzWnWctsA==
X-Google-Smtp-Source: ABdhPJxdW8fDGQF2t6GQmkn8kcdO1gCWMwCXoRfvNGxdvK9xRwIoE2oogW8ueV0Z689vUrXkj9iz7Q==
X-Received: by 2002:a05:600c:4a28:b0:39c:4d97:37e2 with SMTP id c40-20020a05600c4a2800b0039c4d9737e2mr10025602wmp.31.1655300756040;
        Wed, 15 Jun 2022 06:45:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0020c5253d8fcsm17982663wrs.72.2022.06.15.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:45:55 -0700 (PDT)
Message-Id: <432d80b8c78355e5f70081c05e9a042a9ffcd033.1655300752.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
References: <pull.1262.git.1655300752.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 13:45:51 +0000
Subject: [PATCH 1/2] ls-files: introduce "--format" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add a new option --format that output index enties
informations with custom format, taking inspiration
from the option with the same name in the `git ls-tree`
command.

--format cannot used with -s, -o, -k, --resolve-undo,
--deduplicate, --debug.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-ls-files.txt |  51 +++++++++++-
 builtin/ls-files.c             | 126 ++++++++++++++++++++++++++++-
 t/t3013-ls-files-format.sh     | 142 +++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+), 4 deletions(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..b22860ec8c0 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev[=<n>]] [--] [<file>...]
+		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
 	to the contained files. Sparse directories will be shown with a
 	trailing slash, such as "x/" for a sparse directory "x".
 
+--format=<format>::
+	A string that interpolates %(fieldname) from the result being shown.
+	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
+	interpolates to character with hex code `xx`; for example `%00`
+	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
+	--format cannot be combined with `-s`, `-o`, `-k`, `--resolve-undo`,
+	`--debug`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,48 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+It is possible to print in a custom format by using the `--format`
+option, which is able to interpolate different fields using
+a `%(fieldname)` notation. For example, if you only care about the
+"objectname" and "path" fields, you can execute with a specific
+"--format" like
+
+	git ls-files --format='%(objectname) %(path)'
+
+FIELD NAMES
+-----------
+Various values from structured fields can be used to interpolate
+into the resulting output. For each outputting line, the following
+names can be used:
+
+tag::
+	The tag of file status.
+objectmode::
+	The mode of the object.
+objectname::
+	The name of the object.
+stage::
+	The stage of the file.
+eol::
+	The line endings of files.
+path::
+	The pathname of the object.
+ctime::
+	The create time of file.
+mtime::
+	The modify time of file.
+dev::
+	The ID of device containing file.
+ino::
+	The inode number of file.
+uid::
+	The user id of file owner.
+gid::
+	The group id of file owner.
+size::
+	The size of the file.
+flags::
+	The flags of the file.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..9dd6c55eeb9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
@@ -48,6 +49,7 @@ static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
 static int exclude_args;
+static const char *format;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -58,8 +60,8 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(struct index_state *istate,
-			  const struct cache_entry *ce, const char *path)
+static void write_eolinfo_internal(struct strbuf *sb, struct index_state *istate,
+				   const struct cache_entry *ce, const char *path)
 {
 	if (show_eol) {
 		struct stat st;
@@ -71,10 +73,25 @@ static void write_eolinfo(struct index_state *istate,
 							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
-		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
+		if (sb)
+			strbuf_addf(sb, "i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
+		else
+			printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
 	}
 }
 
+static void write_eolinfo(struct index_state *istate,
+			  const struct cache_entry *ce, const char *path)
+{
+	write_eolinfo_internal(NULL, istate, ce, path);
+}
+
+static void write_eolinfo_to_buf(struct strbuf *sb, struct index_state *istate,
+				 const struct cache_entry *ce, const char *path)
+{
+	write_eolinfo_internal(sb, istate, ce, path);
+}
+
 static void write_name(const char *name)
 {
 	/*
@@ -85,6 +102,16 @@ static void write_name(const char *name)
 				   stdout, line_terminator);
 }
 
+static void write_name_to_buf(struct strbuf *sb, const char *name)
+{
+	name = relative_path(name, prefix_len ? prefix : NULL, sb);
+	if (line_terminator) {
+		quote_c_style(name, sb, NULL, 0);
+	} else {
+		strbuf_add(sb, name, strlen(name));
+	}
+}
+
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
@@ -222,6 +249,86 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+struct show_index_data {
+	const char *tag;
+	const char *pathname;
+	struct index_state *istate;
+	const struct cache_entry *ce;
+};
+
+static size_t expand_show_index(struct strbuf *sb, const char *start,
+			       void *context)
+{
+	struct show_index_data *data = context;
+	const char *end;
+	const char *p;
+	unsigned int errlen;
+	const struct stat_data *sd = &data->ce->ce_stat_data;
+	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-files format: element '%s' does not start with '('"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-files format: element '%s' does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(tag)", &p)) {
+		strbuf_addstr(sb, get_tag(data->ce, data->tag));
+	} else if (skip_prefix(start, "(objectmode)", &p)) {
+		strbuf_addf(sb, "%06o", data->ce->ce_mode);
+	} else if (skip_prefix(start, "(objectname)", &p)) {
+		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	} else if (skip_prefix(start, "(stage)", &p)) {
+		strbuf_addf(sb, "%d", ce_stage(data->ce));
+	} else if (skip_prefix(start, "(eol)", &p)) {
+		write_eolinfo_to_buf(sb, data->istate, data->ce, data->pathname);
+	} else if (skip_prefix(start, "(path)", &p)) {
+		write_name_to_buf(sb, data->pathname);
+	} else if (skip_prefix(start, "(ctime)", &p)) {
+		strbuf_addf(sb, "ctime: %u:%u", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+	} else if (skip_prefix(start, "(mtime)", &p)) {
+		strbuf_addf(sb, "mtime: %u:%u", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+	} else if (skip_prefix(start, "(dev)", &p)) {
+		strbuf_addf(sb, "dev: %u", sd->sd_dev);
+	} else if (skip_prefix(start, "(ino)", &p)) {
+		strbuf_addf(sb, "ino: %u", sd->sd_ino);
+	} else if (skip_prefix(start, "(uid)", &p)) {
+		strbuf_addf(sb, "uid: %u", sd->sd_uid);
+	} else if (skip_prefix(start, "(gid)", &p)) {
+		strbuf_addf(sb, "gid: %u", sd->sd_gid);
+	} else if (skip_prefix(start, "(size)", &p)) {
+		strbuf_addf(sb, "size: %u", sd->sd_size);
+	} else if (skip_prefix(start, "(flags)", &p)) {
+		strbuf_addf(sb, "flags: %x", data->ce->ce_flags);
+	} else {
+		errlen = (unsigned long)len;
+		die(_("bad ls-files format: %%%.*s"), errlen, start);
+	}
+
+	return len;
+}
+
+static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
+			const char *format, const char *fullname, const char *tag) {
+
+	struct show_index_data data = {
+		.tag = tag,
+		.pathname = fullname,
+		.istate = repo->index,
+		.ce = ce,
+	};
+
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_expand(&sb, format, expand_show_index, &data);
+	strbuf_addch(&sb, line_terminator);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+	return;
+}
+
 static void show_ce(struct repository *repo, struct dir_struct *dir,
 		    const struct cache_entry *ce, const char *fullname,
 		    const char *tag)
@@ -236,6 +343,11 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
+		if (format) {
+			show_ce_fmt(repo, ce, format, fullname, tag);
+			return;
+		}
+
 		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
@@ -675,6 +787,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_BOOL(0, "sparse", &show_sparse_dirs,
 			 N_("show sparse directories in the presence of a sparse index")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+					 N_("format to use for the output"),
+					 PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int ret = 0;
@@ -699,6 +814,11 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
+
+	if (format && (show_stage || show_others || show_killed ||
+		show_resolve_undo || skipping_duplicates || debug_mode))
+			die(_("ls-files --format cannot used with -s, -o, -k, --resolve-undo, --deduplicate, --debug"));
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..61a2e68713a
--- /dev/null
+++ b/t/t3013-ls-files-format.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+
+test_description='git ls-files --format test'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo o1 >o1 &&
+	echo o2 >o2 &&
+	git add o1 o2 &&
+	git add --chmod +x o1 &&
+	git commit -m base
+'
+
+test_expect_success 'git ls-files --format tag' '
+	printf "H \nH \n" >expect &&
+	git ls-files --format="%(tag)" -t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectmode' '
+	cat >expect <<-EOF &&
+	100755
+	100644
+	EOF
+	git ls-files --format="%(objectmode)" -t >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectname' '
+	oid1=$(git hash-object o1) &&
+	oid2=$(git hash-object o2) &&
+	cat >expect <<-EOF &&
+	$oid1
+	$oid2
+	EOF
+	git ls-files --format="%(objectname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format eol' '
+	printf "i/lf    w/lf    attr/                 \t\n" >expect &&
+	printf "i/lf    w/lf    attr/                 \t\n" >>expect &&
+	git ls-files --format="%(eol)" --eol >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format path' '
+	cat >expect <<-EOF &&
+	o1
+	o2
+	EOF
+	git ls-files --format="%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format ctime' '
+	git ls-files --debug | grep ctime >expect &&
+	git ls-files --format="  %(ctime)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format mtime' '
+	git ls-files --debug | grep mtime >expect &&
+	git ls-files --format="  %(mtime)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format dev and ino' '
+	git ls-files --debug | grep dev >expect &&
+	git ls-files --format="  %(dev)%x09%(ino)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format uid and gid' '
+	git ls-files --debug | grep uid >expect &&
+	git ls-files --format="  %(uid)%x09%(gid)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -m' '
+	echo change >o1 &&
+	cat >expect <<-EOF &&
+	o1
+	EOF
+	git ls-files --format="%(path)" -m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -d' '
+	rm o1 &&
+	test_when_finished "git restore o1" &&
+	cat >expect <<-EOF &&
+	o1
+	EOF
+	git ls-files --format="%(path)" -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format size and flags' '
+	git ls-files --debug | grep size >expect &&
+	git ls-files --format="  %(size)%x09%(flags)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --stage' '
+	git ls-files --stage >expect &&
+	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --debug' '
+	git ls-files --debug >expect &&
+	git ls-files --format="%(path)%x0a  %(ctime)%x0a  %(mtime)%x0a  %(dev)%x09%(ino)%x0a  %(uid)%x09%(gid)%x0a  %(size)%x09%(flags)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -s must fail' '
+	test_must_fail git ls-files --format="%(objectname)" -s
+'
+
+test_expect_success 'git ls-files --format with -o must fail' '
+	test_must_fail git ls-files --format="%(objectname)" -o
+'
+
+test_expect_success 'git ls-files --format with -k must fail' '
+	test_must_fail git ls-files --format="%(objectname)" -k
+'
+
+test_expect_success 'git ls-files --format with --resolve-undo must fail' '
+	test_must_fail git ls-files --format="%(objectname)" --resolve-undo
+'
+
+test_expect_success 'git ls-files --format with --deduplicate must fail' '
+	test_must_fail git ls-files --format="%(objectname)" --deduplicate
+'
+
+test_expect_success 'git ls-files --format with --debug must fail' '
+	test_must_fail git ls-files --format="%(objectname)" --debug
+'
+
+test_done
-- 
gitgitgadget

