Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E90C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355349AbiEUPIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355343AbiEUPIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEDB93475
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso5773873wmp.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tFFHzUyw+itlS2o1LNy+a7mqx3/e2BvK13aAU/vxYfE=;
        b=JTGoBch51gqjN6A8TCxrG5K59b1t3X6CLe4sVaxNgx3JBsmm533TfjNLZWWQIr5/sK
         LBCzIw1x7Cik00j/uLZNoVvff3EqWJh3PbQB0ilHjIVIDd7KoNOhcsebd1GLzUcSJ7fJ
         GzMp6FuoSreBNg845UhjkalspspcabACsFzSmeomDFwwT3TDVztSCqjJsXgIT+dPsx/l
         pRUD++6VrItSKlyHl+Vo42evBvISknAtmqqlyOvPL01/bY6BgkFiyqsqS8uScoHMA8A8
         dndM3Gr3btb5Zua444zHdQnTcRQZAZ0u2/wR7wPObwR52wLBV5Hgug9tbFwM1fpLoz8U
         62Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tFFHzUyw+itlS2o1LNy+a7mqx3/e2BvK13aAU/vxYfE=;
        b=YNJJbGObM5HgnN3vH93ey9C1Os1OfuKfCWigffbBdHyAJVrDppnZ00TAJdkBhgpleI
         7rOmDBFQltKrPpmg5IRkkNCqL0u3thEepsdKxrqZJWApJh07GWGRVQDhpFJd1I3rU/Tb
         5r9ps4WaTnuDkH9p4G0+/rkDGRkYmjYbQXnOO3UDN/R6ktvYZCA+2pbJvdFaxvcZ4eeu
         SCDtPaM+jnWGbWbkrmEepF1rsqty41FFLzC2QjJpDDfnMbJGvwZmgDWl8p16949JwME+
         MTLt5I7Fd2G6axgi7atrfmXdLyxXaO/i26bbX40m+21kC9XDfLSe4N51JLEfdYlOpCPC
         lSyw==
X-Gm-Message-State: AOAM533nBUpqCs8tyQZXeL4G1saqTTp0x0UVQY+MmARkfUoprN/HdsoS
        T9WuYHX3D/DLzusypE/6yWnmyYnDe50=
X-Google-Smtp-Source: ABdhPJzGI/X0TNgLxoPDDcVirN2nse0kytMZO5nxXjthF7GTZuQMwHzifYZ+HJXtWW8GCMQPxz7IJQ==
X-Received: by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id n17-20020a7bc5d1000000b0037fa8a39e17mr12806290wmk.109.1653145706047;
        Sat, 21 May 2022 08:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020adf8bc9000000b0020d07958bb3sm5420685wra.3.2022.05.21.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:25 -0700 (PDT)
Message-Id: <a4a74d5ef58f9c80fd8f53003f34958e9f7df2a4.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:16 +0000
Subject: [PATCH v6 7/7] scalar: teach `diagnose` to gather loose objects
 information
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
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

When operating at the scale that Scalar wants to support, certain data
shapes are more likely to cause undesirable performance issues, such as
large numbers of loose objects.

By including statistics about this, `scalar diagnose` now makes it
easier to identify such scenarios.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 59 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  5 ++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index d302c27e114..0c278681758 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -619,6 +619,60 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
 	return 0;
 }
 
+static int count_files(char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count = 0;
+
+	if (!dir)
+		return 0;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) && e->d_type == DT_REG)
+			count++;
+
+	closedir(dir);
+	return count;
+}
+
+static void loose_objs_stats(struct strbuf *buf, const char *path)
+{
+	DIR *dir = opendir(path);
+	struct dirent *e;
+	int count;
+	int total = 0;
+	unsigned char c;
+	struct strbuf count_path = STRBUF_INIT;
+	size_t base_path_len;
+
+	if (!dir)
+		return;
+
+	strbuf_addstr(buf, "Object directory stats for ");
+	strbuf_add_absolute_path(buf, path);
+	strbuf_addstr(buf, ":\n");
+
+	strbuf_add_absolute_path(&count_path, path);
+	strbuf_addch(&count_path, '/');
+	base_path_len = count_path.len;
+
+	while ((e = readdir(dir)) != NULL)
+		if (!is_dot_or_dotdot(e->d_name) &&
+		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
+		    !hex_to_bytes(&c, e->d_name, 1)) {
+			strbuf_setlen(&count_path, base_path_len);
+			strbuf_addstr(&count_path, e->d_name);
+			total += (count = count_files(count_path.buf));
+			strbuf_addf(buf, "%s : %7d files\n", e->d_name, count);
+		}
+
+	strbuf_addf(buf, "Total: %d loose objects", total);
+
+	strbuf_release(&count_path);
+	closedir(dir);
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -687,6 +741,11 @@ static int cmd_diagnose(int argc, const char **argv)
 	foreach_alt_odb(dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=objects-local.txt:");
+	loose_objs_stats(&buf, ".git/objects");
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 3dd5650cceb..72023a1ca1d 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -95,6 +95,7 @@ test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
+	test_commit -C cloned/src loose &&
 	scalar diagnose cloned >out 2>err &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
@@ -106,7 +107,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	unzip -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
 	unzip -p "$zip_path" packs-local.txt >out &&
-	grep "$(pwd)/.git/objects" out
+	grep "$(pwd)/.git/objects" out &&
+	unzip -p "$zip_path" objects-local.txt >out &&
+	grep "^Total: [1-9]" out
 '
 
 test_done
-- 
gitgitgadget
