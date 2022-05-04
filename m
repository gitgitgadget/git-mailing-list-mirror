Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEAEC433FE
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352452AbiEDP3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352613AbiEDP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:29:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D5E2AC
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:25:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1041713wml.5
        for <git@vger.kernel.org>; Wed, 04 May 2022 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cuVoRoGcLognUfUtAbrG/alAPfTx3uU2pG6PzEbPVe4=;
        b=WeTjerE77VuD7mjBEAX1NqLxE8Y+DxKS2LWQHeLQPhl84x/kEcP4kNr9dxedVhWePr
         QeINm9DIpx6lO6WYMQ6Re4HVm4A3kpZweUZjuMcUZzFlpJZ0FAHQCWKFctV/8B7fRtMe
         vWi6eMiugFvKDkHe7xo4d0Gi8lSzO+rYrF6QeNF5pP5/lk1Jpl55LlWse6RZzuaxyQ98
         jd2epayhseafnNnlgHVGJ23FdI/sjdpiExVoBbrpTXfdiFEDQG9N4oO4Kv8paRZUjCn9
         TgufBLW4+7cO1nmkKnE9iPbRWRx8sbZvAnqczWW8zL4E7ozXARqiSIPwYEtCMRF8XBOj
         oWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cuVoRoGcLognUfUtAbrG/alAPfTx3uU2pG6PzEbPVe4=;
        b=Wbi75Cx4vOZjCAliYBDftZrFFibSi6gttGIUGWpPw3VM5y5hGSvTa9ZNy/yJ1Ka/k6
         YW2dBc0lk6cspa9vJCUPQGw9WXyeN/cAkwLsbYsOldwqYPfBfKKnX44WF8CaKFlNh0QU
         8K3NNUILlzp+Hh7U1pOMQnfrj0wO4qhWh9omRKZUehg2yNu4FxF5FdcRJUzFA+ZqJgqg
         d8buUpIoSLI5SpmXKTpqth5CfRRAVJMB2my0PkAKdoEAp1ux3OBfw8UUFki3WRoh1lKu
         8VAn6DsYMrGBplPnVnBIPumw16PtPjKXUsW8oUqcYRO6qTOh46fVWAbFaotEOszWJGWt
         KX1g==
X-Gm-Message-State: AOAM532RPhAs8eNO0/ByS+t9FGRi1tfkHPIpSCQMH/EXcDARki0XrmEI
        rx6AWr7aV1QFW3kqW1l6yoVG8r7Pl5I=
X-Google-Smtp-Source: ABdhPJw4inmzqgvgFn58QTN/LO7SgbVHnV8jtVVovuKeRRwi4QpMQq2QSCDX3U+EMvj44UHfvzeYTw==
X-Received: by 2002:a1c:f606:0:b0:394:1a21:f68c with SMTP id w6-20020a1cf606000000b003941a21f68cmr8249455wmc.131.1651677930232;
        Wed, 04 May 2022 08:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p26-20020adfa21a000000b0020c5253d8ecsm11766169wra.56.2022.05.04.08.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:25:29 -0700 (PDT)
Message-Id: <322932f0bb87db2e11fc7b8447c3fc0fe134ae9a.1651677919.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 May 2022 15:25:19 +0000
Subject: [PATCH v3 7/7] scalar: teach `diagnose` to gather loose objects
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
index 9adde8cf4b9..f2fe3858eca 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -616,6 +616,60 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
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
@@ -684,6 +738,11 @@ static int cmd_diagnose(int argc, const char **argv)
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
index e049221609d..9b4eedbb0aa 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -95,6 +95,7 @@ test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
 	git repack &&
 	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
+	test_commit -C cloned/src loose &&
 	scalar diagnose cloned >out &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <out >zip_path &&
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
