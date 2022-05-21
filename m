Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1DBC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353608AbiEUPIZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbiEUPIW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F043592D25
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so13863055wrb.11
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jRvufZPqt+qoWVhZpC5LwCvQq2uy8PzZ64xc94DnHBo=;
        b=WgqPNH/l5oAj/ZJzzOoph8W3b/uQ96nFdVmhFkCKv0EewZThDsbI/iHw6GxttVCN5O
         Y7usf7jfrgogytgq5B1poMkg7WYT1RiaCduL0MNgRdPx+JGNXcRyh3SQdZ83bxflC12n
         +zBYKYETToVe2U1ldir6h/SVrhYwlADa30AXPTs5/V5IAEzZ58Iy2ZmuHh/f9xChGiJK
         icwvJGp9MdpXoyeQi3XlT7NSgeKahfpKxuftIrCLgNQZlU2JJ8xavNNTFSUbEA2mfwUy
         nFJFAFGMd8LCpUZMtTTsv5aSl7t+lO2+ODODCPlWCPOCJkQFGl75vgBPZ6Ki2xah3j5z
         Fwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jRvufZPqt+qoWVhZpC5LwCvQq2uy8PzZ64xc94DnHBo=;
        b=r4yeXRWfIC98ns4HqkT7yr7ASxnOc+h+kA+vXPYSz3grcWqOiSH37JUvBPluMIBH/z
         56w6tVsszOZRLNrsRb++SSgD9vjlCu0Bzj6NmDtVBCBpgwVieuGEIzTSO2mE2cUGydwH
         5sqJEtQ+Yz5FuyRxTTaYGdR8gis4f/hzJzVVVb7Av8tdw5fVVpI8AWVgdcdhdKXjw7yp
         qPBFscZVc/LV2LPJxSrhDi9ch96gmnA4O0foqOanCOXXwu4KIvdEJMgAOcJjm/+LUfP8
         ADCD32+iEN4I9msJ+F1vAxJK+E5EflVdJNBq5NVNcJwQZKyP8exZfQU+dvw3111CzyfL
         xSuQ==
X-Gm-Message-State: AOAM533pLyOeFmxg2fpv52ZDLBrYwLFwQzh+Dl+/AeZ7iUHENBHYrXu6
        DFF3I6Ofe1kOxRsu82PY31ZrMP2RRzw=
X-Google-Smtp-Source: ABdhPJz0ur9UqZNWFD36ZuJdNTSpDLB2Vz2RCa1i2iPleNLgwJVi8edwTeYvQQzjhbDnFfpK0l1Zlw==
X-Received: by 2002:a5d:42d0:0:b0:20d:2dd:22f7 with SMTP id t16-20020a5d42d0000000b0020d02dd22f7mr12435050wrr.136.1653145699091;
        Sat, 21 May 2022 08:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm4521741wmb.2.2022.05.21.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:18 -0700 (PDT)
Message-Id: <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:10 +0000
Subject: [PATCH v6 1/7] archive: optionally add "virtual" files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the `--add-virtual-file=<path>:<content>` option, `git archive` now
supports use cases where relatively trivial files need to be added that
do not exist on disk.

This will allow us to generate `.zip` files with generated content,
without having to add said content to the object database and without
having to write it out to disk.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-archive.txt | 11 ++++++++
 archive.c                     | 53 +++++++++++++++++++++++++++++------
 t/t5003-archive-zip.sh        | 12 ++++++++
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index bc4e76a7834..893cb1075bf 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -61,6 +61,17 @@ OPTIONS
 	by concatenating the value for `--prefix` (if any) and the
 	basename of <file>.
 
+--add-virtual-file=<path>:<content>::
+	Add the specified contents to the archive.  Can be repeated to add
+	multiple files.  The path of the file in the archive is built
+	by concatenating the value for `--prefix` (if any) and the
+	basename of <file>.
++
+The `<path>` cannot contain any colon, the file mode is limited to
+a regular file, and the option may be subject to platform-dependent
+command-line limits. For non-trivial cases, write an untracked file
+and use `--add-file` instead.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index a3bbb091256..d20e16fa819 100644
--- a/archive.c
+++ b/archive.c
@@ -263,6 +263,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 struct extra_file_info {
 	char *base;
 	struct stat stat;
+	void *content;
 };
 
 int write_archive_entries(struct archiver_args *args,
@@ -337,7 +338,13 @@ int write_archive_entries(struct archiver_args *args,
 		strbuf_addstr(&path_in_archive, basename(path));
 
 		strbuf_reset(&content);
-		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
+		if (info->content)
+			err = write_entry(args, &fake_oid, path_in_archive.buf,
+					  path_in_archive.len,
+					  info->stat.st_mode,
+					  info->content, info->stat.st_size);
+		else if (strbuf_read_file(&content, path,
+					  info->stat.st_size) < 0)
 			err = error_errno(_("could not read '%s'"), path);
 		else
 			err = write_entry(args, &fake_oid, path_in_archive.buf,
@@ -493,6 +500,7 @@ static void extra_file_info_clear(void *util, const char *str)
 {
 	struct extra_file_info *info = util;
 	free(info->base);
+	free(info->content);
 	free(info);
 }
 
@@ -514,14 +522,40 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 	if (!arg)
 		return -1;
 
-	path = prefix_filename(args->prefix, arg);
-	item = string_list_append_nodup(&args->extra_files, path);
-	item->util = info = xmalloc(sizeof(*info));
+	info = xmalloc(sizeof(*info));
 	info->base = xstrdup_or_null(base);
-	if (stat(path, &info->stat))
-		die(_("File not found: %s"), path);
-	if (!S_ISREG(info->stat.st_mode))
-		die(_("Not a regular file: %s"), path);
+
+	if (!strcmp(opt->long_name, "add-file")) {
+		path = prefix_filename(args->prefix, arg);
+		if (stat(path, &info->stat))
+			die(_("File not found: %s"), path);
+		if (!S_ISREG(info->stat.st_mode))
+			die(_("Not a regular file: %s"), path);
+		info->content = NULL; /* read the file later */
+	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
+		const char *colon = strchr(arg, ':');
+		char *p;
+
+		if (!colon)
+			die(_("missing colon: '%s'"), arg);
+
+		p = xstrndup(arg, colon - arg);
+		if (!args->prefix)
+			path = p;
+		else {
+			path = prefix_filename(args->prefix, p);
+			free(p);
+		}
+		memset(&info->stat, 0, sizeof(info->stat));
+		info->stat.st_mode = S_IFREG | 0644;
+		info->content = xstrdup(colon + 1);
+		info->stat.st_size = strlen(info->content);
+	} else {
+		BUG("add_file_cb() called for %s", opt->long_name);
+	}
+	item = string_list_append_nodup(&args->extra_files, path);
+	item->util = info;
+
 	return 0;
 }
 
@@ -554,6 +588,9 @@ static int parse_archive_args(int argc, const char **argv,
 		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
 		  N_("add untracked file to archive"), 0, add_file_cb,
 		  (intptr_t)&base },
+		{ OPTION_CALLBACK, 0, "add-virtual-file", args,
+		  N_("path:content"), N_("add untracked file to archive"), 0,
+		  add_file_cb, (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 1e6d18b140e..ebc26e89a9b 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -206,6 +206,18 @@ test_expect_success 'git archive --format=zip --add-file' '
 check_zip with_untracked
 check_added with_untracked untracked untracked
 
+test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
+	git archive --format=zip >with_file_with_content.zip \
+		--add-virtual-file=hello:world $EMPTY_TREE &&
+	test_when_finished "rm -rf tmp-unpack" &&
+	mkdir tmp-unpack && (
+		cd tmp-unpack &&
+		"$GIT_UNZIP" ../with_file_with_content.zip &&
+		test_path_is_file hello &&
+		test world = $(cat hello)
+	)
+'
+
 test_expect_success 'git archive --format=zip --add-file twice' '
 	echo untracked >untracked &&
 	git archive --format=zip --prefix=one/ --add-file=untracked \
-- 
gitgitgadget

