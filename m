Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A5C433FE
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352395AbiEDP3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352587AbiEDP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:08 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875137641
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u3so2524055wrg.3
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kk09cc6aH5JwrraG91yckuDsGytEkoSbAAZiDDO1h4A=;
        b=o2Frpi+eUZOatKZTUZ2ub7IDtc+3SR6kZMlR9gWBazaJK3ZnIstZS1kcWmsGAxO45N
         6cXfZkqPIdXZbC2vX6EH+HlNZqjBvhFrpDVvx10Xv1h02kKJY0ktWDwjkJ/uV9B4TDkQ
         ullftKcG5qSMiGy/pjYZpBW/fo3TYRfpyhyXxSc8c5ALqt12FQ/sYsCAQ5aUHsbu4cr3
         77m8VPJKW6qDKzMRtpiDGeZYJbSjPZ737H+IF+ffM2LKVZ/d0kXQfFQvnD2Hru+MFTli
         Ql1k7M+lEmUdC1up8wplPDjFPhtcniRCsCUfL06Xp7XZuRxwQN0xxSg0oCVG0jIH/xs9
         JjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kk09cc6aH5JwrraG91yckuDsGytEkoSbAAZiDDO1h4A=;
        b=yegLdz0IwiEqRCKU0N5oKu/xFO5/dYODeU9jUEASYvUyByxNFot7yMn1yRa/G+zL0j
         U3qI8Yf1qUFsXcnAJvqXlZ2OpvAx8xfNR1fgozMwQIZ11hadChfqEFKezZemP4BQWaq3
         rSRALlWJrWe2JwSNpj6jdlF3qxH98mf7svnj4tL5iTEa6CCyaBnEBJuabvUaFlrBXpjw
         SK9UrZQhCSh2/0jixDnsMpCerAdA0SF385C66a5QCsh7BHM5Sv8t7d9Nc5E6ijS7Ppps
         Iqp7Dkl+baoSqfjtQrI3R+ow6xnTKG+yHL8eCYbAKXnoM2jwwOMNoaPta9MEcGpT7vx8
         L2nQ==
X-Gm-Message-State: AOAM531AZDvbbxnGvntoqX6cfZd0cfJyylG+MnngnmnDRDa+PHF/qrkN
        WiOHOaItu74KSL9eYCP2gD9UpVONn1g=
X-Google-Smtp-Source: ABdhPJw6sLov9y/dZy6b5/tnNSp64aQR+fyPm5pY3X2wEIZZCobgSWV5KjfnhYZliUXBI69d1UEU1A==
X-Received: by 2002:a05:6000:1844:b0:20c:566b:ddab with SMTP id c4-20020a056000184400b0020c566bddabmr15408987wri.706.1651677923759;
        Wed, 04 May 2022 08:25:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12-20020adfc70c000000b0020c5253d8fcsm14945276wrg.72.2022.05.04.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:23 -0700 (PDT)
Message-Id: <ce4b1b680c98d0f55d4d307b8c746a81d90ffa06.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:14 +0000
Subject: [PATCH v3 2/7] archive --add-file-with-contents: allow paths
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
 Documentation/git-archive.txt | 13 +++++++++----
 archive.c                     | 34 +++++++++++++++++++++++++++++-----
 t/t5003-archive-zip.sh        |  8 ++++++++
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index a0edc9167b2..1789ce4c232 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -67,10 +67,15 @@ OPTIONS
 	by concatenating the value for `--prefix` (if any) and the
 	basename of <file>.
 +
-The `<path>` cannot contain any colon, the file mode is limited to
-a regular file, and the option may be subject to platform-dependent
-command-line limits. For non-trivial cases, write an untracked file
-and use `--add-file` instead.
+The `<path>` argument can start and end with a literal double-quote
+character. In this case, the backslash is interpreted as escape
+character. The path must be quoted if it contains a colon, to avoid
+the colon from being misinterpreted as the separator between the
+path and the contents.
++
+The file mode is limited to a regular file, and the option may be
+subject to platform-dependent command-line limits. For non-trivial
+cases, write an untracked file and use `--add-file` instead.
 
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
diff --git a/archive.c b/archive.c
index d798624cd5f..3b751027143 100644
--- a/archive.c
+++ b/archive.c
@@ -533,13 +533,37 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 			die(_("Not a regular file: %s"), path);
 		info->content = NULL; /* read the file later */
 	} else {
-		const char *colon = strchr(arg, ':');
 		char *p;
 
-		if (!colon)
-			die(_("missing colon: '%s'"), arg);
+		if (*arg != '"') {
+			const char *colon = strchr(arg, ':');
+
+			if (!colon)
+				die(_("missing colon: '%s'"), arg);
+			p = xstrndup(arg, colon - arg);
+			arg = colon + 1;
+		} else {
+			struct strbuf buf = STRBUF_INIT;
+			const char *orig = arg;
+
+			for (;;) {
+				if (!*(++arg))
+					die(_("unclosed quote: '%s'"), orig);
+				if (*arg == '"')
+					break;
+				if (*arg == '\\' && *(++arg) == '\0')
+					die(_("trailing backslash: '%s"), orig);
+				else
+					strbuf_addch(&buf, *arg);
+			}
+
+			if (*(++arg) != ':')
+				die(_("missing colon: '%s'"), orig);
+
+			p = strbuf_detach(&buf, NULL);
+			arg++;
+		}
 
-		p = xstrndup(arg, colon - arg);
 		if (!args->prefix)
 			path = p;
 		else {
@@ -548,7 +572,7 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 		}
 		memset(&info->stat, 0, sizeof(info->stat));
 		info->stat.st_mode = S_IFREG | 0644;
-		info->content = xstrdup(colon + 1);
+		info->content = xstrdup(arg);
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

