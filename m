Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355330AbiEUPIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbiEUPIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:23 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877192D22
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg25so5917412wmb.4
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eGahBRA+ydGjVWDYJywyOHiyVqpH6crsgCVHFETD+CQ=;
        b=GGfT2RHlOr0lhLBuJYdyEGUdLWMcVDD9jLgu701UeV9Mg1msP6MT5lLCfZ+Ic0B9QM
         m9wwztwMh+XMG3n44dbnHtwp5iax0wVrssRZ6lYSuuQLrQTuELLeNrYFoGwscHaLmUBe
         V1rQtl+rMVIcWBb31ZHzdHO6UpfrPw5V/Cci3Ns4+MDjiDoFGqpEO0q58okRRpmh8uc+
         fo/eZG/5CQtMre6jg6q881OiFL9+JvIL83ciDVAUQPTspijA6I+e8BxHgV4IGGmz1XBO
         9CMwk3qK2c6h0xbkFtquvMgPyq4GwqGJr1W10/3b3d4F0JmNv4qdubnkl67VJGbGLyjJ
         2qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eGahBRA+ydGjVWDYJywyOHiyVqpH6crsgCVHFETD+CQ=;
        b=iLP1FQo1zKnLEWLVzAvp/YySnteHb+faFg7IxVyoQOT/9ODKuhp+HXAxo6xangT71X
         wfsi0RT8zeGS0Q5yY22QJRWaZ03Zoz/9fEla+i+Xk9XmU7VsLG5aY7X2Ti7bQEKhNJaJ
         PTt1e7KMJ/ZFmolRiuf92Ud5yNSRIa3ipGzUgBBERHmQMfwdKt/kqHHdE5WKBj2Ndq8Z
         3UKJD3WIokRE8LPAiS4U6QjV7x9P2CzPTitr/LQfW5TiER2HzcLz6/54F0D5mId5p9I7
         OoUzX4kOSt8M9MrGRjVefjoKLWKkmoajnUA/uA7gv0enppbx8XFcKa7NtesdQ4G/UlR/
         AO6w==
X-Gm-Message-State: AOAM5325yPZhQexZGVPOaFazAyjuv858R1GDkaYYzXQYYD197KNmuA1v
        SgsVyFEfOWNzzQ4DhO8O/tznALk2p6Q=
X-Google-Smtp-Source: ABdhPJwbandQ1wbszz9KZfJvNuSDvlmu/lO87lcwB9UwxTxkjbnfLmBIW9/8Gc1vvvJcziL0Wnz9Ug==
X-Received: by 2002:a05:600c:2845:b0:397:32a8:4d54 with SMTP id r5-20020a05600c284500b0039732a84d54mr10911595wmb.37.1653145700405;
        Sat, 21 May 2022 08:08:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020adfb346000000b0020c5253d8fcsm6109998wrd.72.2022.05.21.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:19 -0700 (PDT)
Message-Id: <7eebcf27b45eb13541d4abae70a374a0e35ab6b8.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:11 +0000
Subject: [PATCH v6 2/7] archive --add-virtual-file: allow paths containing
 colons
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

By allowing the path to be enclosed in double-quotes, we can avoid
the limitation that paths cannot contain colons.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-archive.txt | 14 ++++++++++----
 archive.c                     | 30 ++++++++++++++++++++----------
 t/t5003-archive-zip.sh        |  8 ++++++++
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 893cb1075bf..54de945a84e 100644
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
index d20e16fa819..b7756b91200 100644
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
 	} else if (!strcmp(opt->long_name, "add-virtual-file")) {
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
 	} else {
 		BUG("add_file_cb() called for %s", opt->long_name);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index ebc26e89a9b..3a5a052e8ce 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -207,13 +207,21 @@ check_zip with_untracked
 check_added with_untracked untracked untracked
 
 test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
+	if test_have_prereq FUNNYNAMES
+	then
+		PATHNAME=quoted:colon
+	else
+		PATHNAME=quoted
+	fi &&
 	git archive --format=zip >with_file_with_content.zip \
+		--add-virtual-file=\"$PATHNAME\": \
 		--add-virtual-file=hello:world $EMPTY_TREE &&
 	test_when_finished "rm -rf tmp-unpack" &&
 	mkdir tmp-unpack && (
 		cd tmp-unpack &&
 		"$GIT_UNZIP" ../with_file_with_content.zip &&
 		test_path_is_file hello &&
+		test_path_is_file $PATHNAME &&
 		test world = $(cat hello)
 	)
 '
-- 
gitgitgadget

