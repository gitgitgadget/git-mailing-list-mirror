Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E68C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbiEJT1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiEJT1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3AA2FFE1
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k126so10793700wme.2
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S5kaxr+/EdXJGKOsHbTN4MuYruvA2b0L7QgcHc8PT3c=;
        b=IsRWGK/VpgRhHnvWhjBKWFmH5pvjQ6TqBNPfo61yLA8l27r5S8TDRQ+qthiBcdhN6I
         E1LDXY+O7ViTVXQwDZUwuLQ3H8TD5UCYDpj1PqywV47A94EE2lDQxEteucXrRSTGXsxx
         8+ik5PJL4nnAm6ZFadivLd7p5iVkN+E5XVnopK1kQoA0GNfeMAEpHlRuSo7t3f8a1MyY
         T2VOUayap3viSDdivKKwKjblbZ3h+BRdce797mZ6hWLEiNHSGoBtfpvk4G4Sw6j93Pnd
         z9Vfl5KTKGU4xnnQz7adfIkRDwZDswEK/fo9MvtbsL0yDsfZ+HxgX0MNU70tqxGRJvae
         2Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S5kaxr+/EdXJGKOsHbTN4MuYruvA2b0L7QgcHc8PT3c=;
        b=FFbPxD/B0Yh9lk6bebSIrrmInjfcfFJx/pz+hI/cO9ITqCsvp6kMquZI9mAABQcLad
         8lHDS+WAopDk8i/CljfnN9/wMBFmcnmh0UOGJsG5bweSfK8AYIAZoKhkKTXkBfgpxeQ7
         htl01ulTwkU4GudivNnWSwI7xw+5LBhC8FCiRBUS0U9XAxByVgs08YNCcKWd3fD4HqK+
         9TIXZdVPKmew5VZkCOvulnGW8cDq+CvGj7GITEASENQnRkbiuRB3Prm4M84CWsrVo7iV
         dzeK2hlOFZ8mgFFt5d3xc5fcoyyTF6yWw1dqHdvJEszxCyU4WbzIuejUOuah/T7p7Bq6
         uNRQ==
X-Gm-Message-State: AOAM531dukKSW1A1ZeHkyg2vBdwncBESDgGJHMay4+ld5iM7wXKb1IUk
        3DeNckto8GCzq6KWjYXMRvW4wtsRzWM=
X-Google-Smtp-Source: ABdhPJyx/csIfAOm0qQBTVEn5dvHay5A8JxT7TD0Fj2DAluDnbM/3yqpiDUcyLePkeRy3ybk/ozogw==
X-Received: by 2002:a7b:cb57:0:b0:393:db11:52ad with SMTP id v23-20020a7bcb57000000b00393db1152admr1397692wmj.143.1652210838140;
        Tue, 10 May 2022 12:27:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a1c4b13000000b003945237fea1sm147532wma.0.2022.05.10.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:17 -0700 (PDT)
Message-Id: <e8f5b42f7b7a89ee5dabdd58da7449f31ebc2a4c.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:27:04 +0000
Subject: [PATCH v4 7/7] scalar: teach `diagnose` to gather loose objects
 information
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
index e8e0a5ec473..03da7452d83 100644
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
+	strbuf_addstr(&buf, "--add-file-with-content=objects-local.txt:");
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
