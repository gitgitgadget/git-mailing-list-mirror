Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5CC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiEJT1U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbiEJT1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA6B30551
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 129so10789005wmz.0
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yH45y3rNUaaonemIU29IzN0qO3F7ZntSRBJ/LoN3o8s=;
        b=gOMI27ugYpF5sUNXomvsBobHwpluQYXOvtJM2bZkdozOS+RGikFPtU/QtPcJEqwaqW
         0J2z65kMmbUlzlMe9dRVu/gwUYrre7f9BM27KNnVJ4KYe7/KkLoSwlOOCLlCzt7UGVad
         h8Qbk6IP+/iy7JOZJk/lsWtjIcxYIf/hZX20Y2DRPIn0t/mK7Gfw04c6vvPgHA9Vz7wi
         2Tkid3bN6ZzoyvjgvNqQfj4TY+EfF3fWXOsHcmTJBHcSY+kx1FsKGzhflmwOND6U+qM+
         SmHwBm+diT68xFw5vsHhvgJKv4FAzxImJnjxHa0VELOABWX/aF+DixEBrQFw/4qZdtkh
         WFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yH45y3rNUaaonemIU29IzN0qO3F7ZntSRBJ/LoN3o8s=;
        b=8IzG6iF7XSKsz2yEpAJglgeb9kiHaaTCGeufyoMA9lfJ5H0kDZOCl7ZrfKE+yolPJC
         brHA1Pi0GdE6UZgj2gHJpwzAcgel+SLuI+i92GFWiIIbAohXvy6Zq4V+n5UDD98ULhg2
         i4LEXoXlcU6hlas7I0WGOWTO8mpVqPBod2xJy9RDDN2c5NCKkBVhIEKk9WjGTHp+gc/h
         RBSljUA2dspqUqmWhxvI6U1LDuHnL+FeJqAKpLrvfoAefyuc3tZYI9wVfP5yFlS7fYuf
         LrophX/fRXImH48vUmAjBSoC6G7NuQnxBMolSNrQyKLnn/AarqgEsW3rX5YvGtmgkRmB
         YV9w==
X-Gm-Message-State: AOAM530EdzOuOYP4Lk+mYD49trVkFnxDAMnJZk8g/iBo1X/Fi5YwDD1h
        pV2AKIswdA/+ipV3W91r0heGq6BbdCo=
X-Google-Smtp-Source: ABdhPJzfukqXxj5vKt1wvmw6bv15W3D2kv+5WC8Z7/4Z7+2fQ2d37BbY81+VC36dBBnpKKOLJqiPRg==
X-Received: by 2002:a1c:4e08:0:b0:393:fd06:c2ce with SMTP id g8-20020a1c4e08000000b00393fd06c2cemr1435599wmh.91.1652210829108;
        Tue, 10 May 2022 12:27:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05600c1e0700b003945781b725sm3589690wmb.37.2022.05.10.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:08 -0700 (PDT)
Message-Id: <fdba4ed6f4d5ed4f78404e0a0c5b338c22678533.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:26:59 +0000
Subject: [PATCH v4 2/7] archive --add-file-with-contents: allow paths
 containing colons
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

By allowing the path to be enclosed in double-quotes, we can avoid
the limitation that paths cannot contain colons.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-archive.txt | 14 ++++++++++----
 archive.c                     | 30 ++++++++++++++++++++----------
 t/t5003-archive-zip.sh        |  8 ++++++++
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index a0edc9167b2..21eab5690ad 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -67,10 +67,16 @@ OPTIONS
 	by concatenating the value for `--prefix` (if any) and the
 	basename of <file>.
 +
-The `<path>` cannot contain any colon, the file mode is limited to
-a regular file, and the option may be subject to platform-dependent
-command-line limits. For non-trivial cases, write an untracked file
-and use `--add-file` instead.
+The `<path>` argument can start and end with a literal double-quote
+character; The contained file name is interpreted as a C-style string,
+i.e. the backslash is interpreted as escape character. The path must
+be quoted if it contains a colon, to avoid the colon from being
+misinterpreted as the separator between the path and the contents, or
+if the path begins or ends with a double-quote character.
++
+The file mode is limited to a regular file, and the option may be
+subject to platform-dependent command-line limits. For non-trivial
+cases, write an untracked file and use `--add-file` instead.
 
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
diff --git a/archive.c b/archive.c
index d798624cd5f..477eba60ac3 100644
--- a/archive.c
+++ b/archive.c
@@ -9,6 +9,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "dir.h"
+#include "quote.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -533,22 +534,31 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 			die(_("Not a regular file: %s"), path);
 		info->content = NULL; /* read the file later */
 	} else {
-		const char *colon = strchr(arg, ':');
-		char *p;
+		struct strbuf buf = STRBUF_INIT;
+		const char *p = arg;
+
+		if (*p != '"')
+			p = strchr(p, ':');
+		else if (unquote_c_style(&buf, p, &p) < 0)
+			die(_("unclosed quote: '%s'"), arg);
 
-		if (!colon)
+		if (!p || *p != ':')
 			die(_("missing colon: '%s'"), arg);
 
-		p = xstrndup(arg, colon - arg);
-		if (!args->prefix)
-			path = p;
-		else {
-			path = prefix_filename(args->prefix, p);
-			free(p);
+		if (p == arg)
+			die(_("empty file name: '%s'"), arg);
+
+		path = buf.len ?
+			strbuf_detach(&buf, NULL) : xstrndup(arg, p - arg);
+
+		if (args->prefix) {
+			char *save = path;
+			path = prefix_filename(args->prefix, path);
+			free(save);
 		}
 		memset(&info->stat, 0, sizeof(info->stat));
 		info->stat.st_mode = S_IFREG | 0644;
-		info->content = xstrdup(colon + 1);
+		info->content = xstrdup(p + 1);
 		info->stat.st_size = strlen(info->content);
 	}
 	item = string_list_append_nodup(&args->extra_files, path);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 8ff1257f1a0..5b8bbfc2692 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -207,13 +207,21 @@ check_zip with_untracked
 check_added with_untracked untracked untracked
 
 test_expect_success UNZIP 'git archive --format=zip --add-file-with-content' '
+	if test_have_prereq FUNNYNAMES
+	then
+		QUOTED=quoted:colon
+	else
+		QUOTED=quoted
+	fi &&
 	git archive --format=zip >with_file_with_content.zip \
+		--add-file-with-content=\"$QUOTED\": \
 		--add-file-with-content=hello:world $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
+		test_path_is_file $QUOTED &&
 		test world = $(cat hello)
 	)
 '
-- 
gitgitgadget

