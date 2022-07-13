Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C503BC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 06:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiGMGIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 02:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGMGH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 02:07:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D8CB96B2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 23:07:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r127-20020a1c4485000000b003a2fb7c1274so134148wma.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 23:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sRM8udGSxb+U7fp++jcW/CueAN0Be58lzWPuMoxjWoY=;
        b=Wscm0PWrKPv0pbmVPNXzIAyK87Wpq+3wFGLZiMCoRXFZqd33orPKQcPSstszELInys
         dV9CoiVZqNFaZ9IIHpIaZ1UXTXwBModykM7mg+gYru+C+qM1q5pubELGTlbsGnzWRu9d
         Ww9LPXa/eghkOtHfb8Po7uuO8XOdtbxxZJMbDQurKcLI0bsVevcdIVqm5xcPmPmaVl4M
         lidvbriaBgl22CFirWTMRcnLR8tZRMWEdWAwtyUAbhLAz8nfmQlySbd8eaARtMHycJea
         hbMACJ3BvYDf6Nox64vR+2RQmJ1SRriKSnHvP7FpZuELq844GS5EaKzOQOFsQ8qbKOoa
         vM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sRM8udGSxb+U7fp++jcW/CueAN0Be58lzWPuMoxjWoY=;
        b=R2PN4ah/TYUSbF4uy6nOT4PzvT/W3+02Atkns3FWBC4R2mSYwhViGFQJTW/9ETiXvF
         Jx69oKPwfHz5FH/tnPTgEnDo1rKBtCJewTf3hOzFq4+Rhg27gLNRCCwWSMtM77PWIZ1o
         lxG0z9JFH06vlbk5f3s9+zIojWIpDMm3UObZYphZRDQPaGqUiy8KCVEkvJ7bw6p/mczc
         gJSd7S4043kWB9h/wA2WfkeIyhSCOG9nk45sa54JMhdTa7qVtlS2bKCErvz5IK3ApYm1
         7Yo5Uwf3NE9JukFCtSMU8T/cJ1iYyV2v94mP1Md2T+kCDVPdAHaY8kPWK7vdfvlGzSFr
         Lm8A==
X-Gm-Message-State: AJIora/F0k3myt5QJIvx9n9jzR/hpQd3kmPwBCW5DtudmrYX7Uq5M/nC
        ITt9GmQpLIgNSGjfYMXDFATfdkYrtwI=
X-Google-Smtp-Source: AGRyM1vqdWxCgw9qT0PAB6mx0LSZLjHSoZ++HdT+e0jWLATfjfEer8oZmizs0xjvGtultjIxcqbL2Q==
X-Received: by 2002:a05:600c:3788:b0:3a2:f2a5:4e61 with SMTP id o8-20020a05600c378800b003a2f2a54e61mr4103788wmr.196.1657692475078;
        Tue, 12 Jul 2022 23:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c405500b0039c811077d3sm1036224wmm.22.2022.07.12.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:07:54 -0700 (PDT)
Message-Id: <pull.1262.v7.git.1657692472994.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
References: <pull.1262.v6.git.1657558435532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Jul 2022 06:07:52 +0000
Subject: [PATCH v7] ls-files: introduce "--format" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add a new option "--format" that outputs index entries
informations in a custom format, taking inspiration
from the option with the same name in the `git ls-tree`
command.

"--format" cannot used with "-s", "-o", "-k", "-t",
" --resolve-undo","--deduplicate" and "--eol".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: introduce "--format" options
    
    v6->v7:
    
     1. Change documents helped by Junio.
     2. Fix bug of parsing format.
     3. Add more test cases for other mode index entries (120000 and
        160000).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1262

Range-diff vs v6:

 1:  57ed2c15728 ! 1:  9ca22edba94 ls-files: introduce "--format" option
     @@ Metadata
       ## Commit message ##
          ls-files: introduce "--format" option
      
     -    Add a new option --format that output index enties
     -    informations with custom format, taking inspiration
     +    Add a new option "--format" that outputs index entries
     +    informations in a custom format, taking inspiration
          from the option with the same name in the `git ls-tree`
          command.
      
     -    --format cannot used with -s, -o, -k, -t, --resolve-undo,
     -    --deduplicate and --eol.
     +    "--format" cannot used with "-s", "-o", "-k", "-t",
     +    " --resolve-undo","--deduplicate" and "--eol".
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-ls-files.txt: quoted as explained for the configuration variab
      +
      +FIELD NAMES
      +-----------
     -+Various values from structured fields can be used to interpolate
     -+into the resulting output. For each outputting line, the following
     -+names can be used:
     ++The way each path is shown can be customized by using the
     ++`--format=<format>` option, where the %(fieldname) in the
     ++<format> string for various aspects of the index entry are
     ++interpolated.  The following "fieldname" are understood:
      +
      +objectmode::
      +	The mode of the file which is recorded in the index.
     @@ builtin/ls-files.c: static void write_name(const char *name)
      +static void write_name_to_buf(struct strbuf *sb, const char *name)
      +{
      +	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);
     ++
      +	if (line_terminator)
      +		quote_c_style(rel, sb, NULL, 0);
      +	else
     -+		strbuf_add(sb, rel, strlen(rel));
     ++		strbuf_addstr(sb, rel);
      +}
      +
       static const char *get_tag(const struct cache_entry *ce, const char *tag)
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +};
      +
      +static size_t expand_show_index(struct strbuf *sb, const char *start,
     -+			       void *context)
     ++				void *context)
      +{
      +	struct show_index_data *data = context;
      +	const char *end;
     @@ builtin/ls-files.c: static void show_submodule(struct repository *superproject,
      +		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
      +	else if (skip_prefix(start, "(stage)", &p))
      +		strbuf_addf(sb, "%d", ce_stage(data->ce));
     -+	else if (skip_prefix(start, "(eolinfo:index)", &p) &&
     -+		 S_ISREG(data->ce->ce_mode))
     -+		strbuf_addstr(sb, get_cached_convert_stats_ascii(data->istate,
     -+								 data->ce->name));
     -+	else if (skip_prefix(start, "(eolinfo:worktree)", &p) &&
     -+		 !lstat(data->pathname, &st) && S_ISREG(st.st_mode))
     -+		strbuf_addstr(sb, get_wt_convert_stats_ascii(data->pathname));
     ++	else if (skip_prefix(start, "(eolinfo:index)", &p))
     ++		strbuf_addstr(sb, S_ISREG(data->ce->ce_mode) ?
     ++			      get_cached_convert_stats_ascii(data->istate,
     ++			      data->ce->name) : "");
     ++	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
     ++		strbuf_addstr(sb, !lstat(data->pathname, &st) &&
     ++			      S_ISREG(st.st_mode) ?
     ++			      get_wt_convert_stats_ascii(data->pathname) : "");
      +	else if (skip_prefix(start, "(eolattr)", &p))
      +		strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
      +			      data->pathname));
     @@ t/t3013-ls-files-format.sh (new)
      +done
      +
      +test_expect_success 'setup' '
     -+	echo o1 >o1 &&
     -+	echo o2 >o2 &&
     -+	git add o1 o2 &&
     -+	git add --chmod +x o1 &&
     ++	printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
     ++	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
     ++	printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
     ++	ln -s o3.txt o4.txt &&
     ++	git add "*.txt" &&
     ++	git add --chmod +x o1.txt &&
     ++	git update-index --add --cacheinfo 160000 $(git hash-object o1.txt) o5.txt &&
      +	git commit -m base
      +'
      +
     -+test_expect_success 'git ls-files --format objectmode' '
     -+	cat >expect <<-\EOF &&
     -+	100755
     -+	100644
     -+	EOF
     ++test_expect_success 'git ls-files --format objectmode v.s. -s' '
     ++	git ls-files -s | awk "{print \$1}" >expect &&
      +	git ls-files --format="%(objectmode)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format objectname' '
     -+	oid1=$(git hash-object o1) &&
     -+	oid2=$(git hash-object o2) &&
     -+	cat >expect <<-EOF &&
     -+	$oid1
     -+	$oid2
     -+	EOF
     ++test_expect_success 'git ls-files --format objectname v.s. -s' '
     ++	git ls-files -s | awk "{print \$2}" >expect &&
      +	git ls-files --format="%(objectname)" >actual &&
      +	test_cmp expect actual
      +'
      +
     -+HT='	'
     -+WS='    '
      +test_expect_success 'git ls-files --format v.s. --eol' '
     -+	git ls-files --eol >expect 2>err &&
     ++	git ls-files --eol >tmp &&
     ++	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&
      +	test_must_be_empty err &&
     -+	git ls-files --format="i/%(eolinfo:index)${WS}w/%(eolinfo:worktree)${WS}attr/${WS}${WS}${WS}${WS} ${HT}%(path)" >actual 2>err &&
     ++	git ls-files --format="i/%(eolinfo:index) w/%(eolinfo:worktree) attr/%(eolattr) %(path)" >actual 2>err &&
      +	test_must_be_empty err &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format path' '
     -+	cat >expect <<-\EOF &&
     -+	o1
     -+	o2
     -+	EOF
     ++test_expect_success 'git ls-files --format path v.s. -s' '
     ++	git ls-files -s | awk "{print \$4}" >expect &&
      +	git ls-files --format="%(path)" >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git ls-files --format with -m' '
     -+	echo change >o1 &&
     ++	echo change >o1.txt &&
      +	cat >expect <<-\EOF &&
     -+	o1
     ++	o1.txt
     ++	o5.txt
      +	EOF
      +	git ls-files --format="%(path)" -m >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'git ls-files --format with -d' '
     -+	echo o3 >o3 &&
     -+	git add o3 &&
     -+	rm o3 &&
     ++	echo o6 >o6.txt &&
     ++	git add o6.txt &&
     ++	rm o6.txt &&
      +	cat >expect <<-\EOF &&
     -+	o3
     ++	o5.txt
     ++	o6.txt
      +	EOF
      +	git ls-files --format="%(path)" -d >actual &&
      +	test_cmp expect actual


 Documentation/git-ls-files.txt | 39 +++++++++++++-
 builtin/ls-files.c             | 95 ++++++++++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 87 +++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..d7986419c25 100644
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
+	A string that interpolates `%(fieldname)` from the result being shown.
+	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
+	interpolates to character with hex code `xx`; for example `%00`
+	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
+	--format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
+	and `--eol`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,36 @@ quoted as explained for the configuration variable `core.quotePath`
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
+The way each path is shown can be customized by using the
+`--format=<format>` option, where the %(fieldname) in the
+<format> string for various aspects of the index entry are
+interpolated.  The following "fieldname" are understood:
+
+objectmode::
+	The mode of the file which is recorded in the index.
+objectname::
+	The name of the file which is recorded in the index.
+stage::
+	The stage of the file which is recorded in the index.
+eolinfo:index::
+eolinfo:worktree::
+	The <eolinfo> (see the description of the `--eol` option) of
+	the contents in the index or in the worktree for the path.
+eolattr::
+	The <eolattr> (see the description of the `--eol` option)
+	that applies to the path.
+path::
+	The pathname of the file which is recorded in the index.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..6f3ebcaaff7 100644
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
@@ -85,6 +87,16 @@ static void write_name(const char *name)
 				   stdout, line_terminator);
 }
 
+static void write_name_to_buf(struct strbuf *sb, const char *name)
+{
+	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);
+
+	if (line_terminator)
+		quote_c_style(rel, sb, NULL, 0);
+	else
+		strbuf_addstr(sb, rel);
+}
+
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
@@ -222,6 +234,73 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+struct show_index_data {
+	const char *pathname;
+	struct index_state *istate;
+	const struct cache_entry *ce;
+};
+
+static size_t expand_show_index(struct strbuf *sb, const char *start,
+				void *context)
+{
+	struct show_index_data *data = context;
+	const char *end;
+	const char *p;
+	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
+	struct stat st;
+
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-files format: element '%s' "
+		      "does not start with '('"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-files format: element '%s'"
+		      "does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(objectmode)", &p))
+		strbuf_addf(sb, "%06o", data->ce->ce_mode);
+	else if (skip_prefix(start, "(objectname)", &p))
+		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	else if (skip_prefix(start, "(stage)", &p))
+		strbuf_addf(sb, "%d", ce_stage(data->ce));
+	else if (skip_prefix(start, "(eolinfo:index)", &p))
+		strbuf_addstr(sb, S_ISREG(data->ce->ce_mode) ?
+			      get_cached_convert_stats_ascii(data->istate,
+			      data->ce->name) : "");
+	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
+		strbuf_addstr(sb, !lstat(data->pathname, &st) &&
+			      S_ISREG(st.st_mode) ?
+			      get_wt_convert_stats_ascii(data->pathname) : "");
+	else if (skip_prefix(start, "(eolattr)", &p))
+		strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
+			      data->pathname));
+	else if (skip_prefix(start, "(path)", &p))
+		write_name_to_buf(sb, data->pathname);
+	else
+		die(_("bad ls-files format: %%%.*s"), (int)len, start);
+
+	return len;
+}
+
+static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
+			const char *format, const char *fullname) {
+	struct show_index_data data = {
+		.pathname = fullname,
+		.istate = repo->index,
+		.ce = ce,
+	};
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_expand(&sb, format, expand_show_index, &data);
+	strbuf_addch(&sb, line_terminator);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
+
 static void show_ce(struct repository *repo, struct dir_struct *dir,
 		    const struct cache_entry *ce, const char *fullname,
 		    const char *tag)
@@ -236,6 +315,12 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
+		if (format) {
+			show_ce_fmt(repo, ce, format, fullname);
+			print_debug(ce);
+			return;
+		}
+
 		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
@@ -675,6 +760,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_BOOL(0, "sparse", &show_sparse_dirs,
 			 N_("show sparse directories in the presence of a sparse index")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int ret = 0;
@@ -699,6 +787,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
+
+	if (format && (show_stage || show_others || show_killed ||
+		show_resolve_undo || skipping_duplicates || show_eol || show_tag))
+			usage_msg_opt("--format cannot used with -s, -o, -k, -t"
+				      "--resolve-undo, --deduplicate, --eol",
+				      ls_files_usage, builtin_ls_files_options);
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..e62bce70f3b
--- /dev/null
+++ b/t/t3013-ls-files-format.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='git ls-files --format test'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+for flag in -s -o -k -t --resolve-undo --deduplicate --eol
+do
+	test_expect_success "usage: --format is incompatible with $flag" '
+		test_expect_code 129 git ls-files --format="%(objectname)" $flag
+	'
+done
+
+test_expect_success 'setup' '
+	printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
+	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
+	printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
+	ln -s o3.txt o4.txt &&
+	git add "*.txt" &&
+	git add --chmod +x o1.txt &&
+	git update-index --add --cacheinfo 160000 $(git hash-object o1.txt) o5.txt &&
+	git commit -m base
+'
+
+test_expect_success 'git ls-files --format objectmode v.s. -s' '
+	git ls-files -s | awk "{print \$1}" >expect &&
+	git ls-files --format="%(objectmode)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectname v.s. -s' '
+	git ls-files -s | awk "{print \$2}" >expect &&
+	git ls-files --format="%(objectname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format v.s. --eol' '
+	git ls-files --eol >tmp &&
+	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&
+	test_must_be_empty err &&
+	git ls-files --format="i/%(eolinfo:index) w/%(eolinfo:worktree) attr/%(eolattr) %(path)" >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format path v.s. -s' '
+	git ls-files -s | awk "{print \$4}" >expect &&
+	git ls-files --format="%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -m' '
+	echo change >o1.txt &&
+	cat >expect <<-\EOF &&
+	o1.txt
+	o5.txt
+	EOF
+	git ls-files --format="%(path)" -m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -d' '
+	echo o6 >o6.txt &&
+	git add o6.txt &&
+	rm o6.txt &&
+	cat >expect <<-\EOF &&
+	o5.txt
+	o6.txt
+	EOF
+	git ls-files --format="%(path)" -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format imitate --stage' '
+	git ls-files --stage >expect &&
+	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with --debug' '
+	git ls-files --debug >expect &&
+	git ls-files --format="%(path)" --debug >actual &&
+	test_cmp expect actual
+'
+
+test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
