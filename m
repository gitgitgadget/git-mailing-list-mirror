Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5EFC433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243832AbiESSST (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbiESSSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87F8CB0E
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s28so8203648wrb.7
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jyVAB3KM4yaayVBWUoDOwmy2rGzt9YVcaNOYJYx1hbw=;
        b=G/pA8fDvkP+qz8NCxMgTqhe/6Ov+cclphKmsR4qW4RiMYok8VKcbmB4OVghA5BUHNS
         QCFuvXK0EM1UKdt3pCLSg6FU7i2EBDyALu/ktV42cD5o2P6RKFoj7hNQEAiECDyEx06V
         F6WzQDAN3SfSVh6APhT8L4O582XqIpKMqWU639lqdTJrv1JGTHHACNg3qNQott/lrU8Q
         9CaJw8LAVbWuVxYuIICDaNtNlCbzaLKlD6kUu/vxEX3FWAFQzD0AiPddkZz1yDvGLqOx
         Xs5OGfxQoUsWIoY7+AEY7dqNKOuvgWkP088CgJ/qnBnpIvA4X4g/rkfQ4ZsaaIAy0zRE
         iOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jyVAB3KM4yaayVBWUoDOwmy2rGzt9YVcaNOYJYx1hbw=;
        b=JvoZbza6FO5nf10PIuaSRLMssHVweuqF8Iqr5RhJ9idB6qJqaNALcTfu4QSuThGaLi
         EgaIq/1Wu1767GOAvD6HBwsW8OEJ+DrCl1IisGueptKPMO3+s+oL/b66njA2VKTa7yu/
         uoeOgdNnJhqJ3HnJJixuZOsf1rSJMowWoIrSl1Hb52XMpf9p/Fs9z5NISPv/KbYrFd7c
         JMS945sE+VCJYA0IjwByqIKF/3D41b2nZRx/DXDXlQdMW9P0Lw8Z3Ppsemf66or9vicD
         OZCkjn7IJhGoV/xHGoc8rBU78AQUD9PPgoTuLUeP62A49mEHeN647ucZ/XST8sbMcLw5
         fvmw==
X-Gm-Message-State: AOAM5320XKDDJF/DjoCg1XXpuM1FIqRjXEqTMtbXOc1fe98dXHbmFH70
        6pxtL1lOyITYTCIAOd6L9+gHzY1efSk=
X-Google-Smtp-Source: ABdhPJzRMCTaP+Y/4ENpxFT5eGVXGrhqhcPAgax17iPANlX2Zxgjpk27U08VjkzRIdflXrtts6MW2w==
X-Received: by 2002:a5d:6950:0:b0:20d:8e2:ccf4 with SMTP id r16-20020a5d6950000000b0020d08e2ccf4mr5210040wrw.222.1652984286280;
        Thu, 19 May 2022 11:18:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az16-20020a05600c601000b0039729309a84sm216220wmb.20.2022.05.19.11.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:05 -0700 (PDT)
Message-Id: <42e73fb0aaca1f2498ed817c517859103d72d32b.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:17:57 +0000
Subject: [PATCH v5 1/7] archive: optionally add "virtual" files
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

With the `--add-file-with-content=<path>:<content>` option, `git
archive` now supports use cases where relatively trivial files need to
be added that do not exist on disk.

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

