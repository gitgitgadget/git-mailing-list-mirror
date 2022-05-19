Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5714C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbiESSSX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiESSSK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B6FD0291
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u27so7503386wru.8
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R+TqfgqTPCf5Rm+tpY0Ass55F0F9IxWLmjxroeuUXKY=;
        b=HNx1JR0uZg2AGWjxNYWmuhVdjeAYjcXazE44HVCRPDnIdd+DJ9HZYi+0y8I7ZjZ1SD
         Xu/ACP7jLVHRXk+AbOVcGKyuy16NCdZyZqTSA/xBShTdCOi8xPinF4E8ksIllRYLxVYw
         u3mC73xrTmCE5UVV0HhiqKLVEjU5aE4BWfb2vR8LobIv0KKJeFpiDwK9qePzkVP2IU4t
         WeGlvwXi464sh8GyZATdgKW2hOIXze9tG29h6RIS28WtAyo+TSRQCDVVT5+ZPDUmj1be
         TZ/zJs7iaro3ZHUVbIL0p7Ivcy2IV8nOxig7719mCBY3/2QYoTYwJdIdlZ/Ngl38xARy
         naxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R+TqfgqTPCf5Rm+tpY0Ass55F0F9IxWLmjxroeuUXKY=;
        b=1pySikrCLDO7hvvxSuGOuCAy9Zkm/bj6wkb2E1CphgalLni19Tb5GpccP8ZHJfro+H
         Z39HPoaz2o98W1oW8AWFnaR8IevE/ctmRyTPPB37b3QpNQp7ntF6aWNnFSac7YbgvZlb
         pTrZBtB9AyVYjNhcIlPLUKM9Dfqdf6PzmMs7vSskgZQnUm5o6j50Di1+KX/LE+jMyT6H
         osq18GpqqDZ01ztFbZ4fu7NN9rOSj1PcdeGb7h17Z6hARB2PGmobr2mOc+w5P4cQRAaA
         ++bCE9cEABUlOnBrwhEDNTDZL8vPwGvihOL2sdO7M+8+BpZ842teftUmtPptmk0XT/2i
         57DA==
X-Gm-Message-State: AOAM530MIcppiCGgk1jC6uncg3zfwl+kYu1tpAvxQV/A+FY+aKohAaRe
        S6Uo4gGK1YnYri9CotQvovL26qWl/14=
X-Google-Smtp-Source: ABdhPJzRvrZavzEq/erCJ4imJve9fAlgA0oXxdTJpZ0qmZOoP2zqFxq+DOVsdZ52wF1+CnUP2Fin9Q==
X-Received: by 2002:a05:6000:1889:b0:20e:67e6:dffb with SMTP id a9-20020a056000188900b0020e67e6dffbmr4121627wri.691.1652984287518;
        Thu, 19 May 2022 11:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020adfba4b000000b0020c6fa5a797sm248321wrg.91.2022.05.19.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:06 -0700 (PDT)
Message-Id: <b5ebd61066ab4e1ef978605c376c1925a270e091.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:17:58 +0000
Subject: [PATCH v5 2/7] archive --add-file-with-contents: allow paths
 containing colons
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
index ebc26e89a9b..50932a866c9 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -207,13 +207,21 @@ check_zip with_untracked
 check_added with_untracked untracked untracked
 
 test_expect_success UNZIP 'git archive --format=zip --add-virtual-file' '
+	if test_have_prereq FUNNYNAMES
+	then
+		QUOTED=quoted:colon
+	else
+		QUOTED=quoted
+	fi &&
 	git archive --format=zip >with_file_with_content.zip \
+		--add-virtual-file=\"$QUOTED\": \
 		--add-virtual-file=hello:world $EMPTY_TREE &&
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

