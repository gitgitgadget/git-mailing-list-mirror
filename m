Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD9C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiEJT12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 15:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiEJT1S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 15:27:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA02A715
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d5so8145wrb.6
        for <git@vger.kernel.org>; Tue, 10 May 2022 12:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T42C+4SBbpPKC+s/Z6/TtR9YCHC68Sfy/m5Tfi8ZBiA=;
        b=KSBvZFpWyGCXhmSR8M1QDt/De/KCZv/Y5fDjVyN1m0l+uVCz2tOdV81Mz0ItciteRP
         gCW7C/xvzuI93uw12KYdtnwmnTC5mw5vmq5uCzzEBJMK/TI2/RFnvocInxRZWjQ80hud
         1dn/+L3cMzq4CIFk/yqSkpIm6StOqNbTVCUhrHWoemYkC8y3GE/vKL6+LbkZVPTui+ca
         2vsSR8zrsr3cheM54wabMdHnD4VXXDE8eRD1C/n8rae95iLxIDN4hkbMx4BR9M0ZHx2i
         TCYzRg6YcZfSeb0pcuGq1hF07jqkqvl9HRqg4pbbA51+SNrBetUK15SpcSu08cv+sPX/
         FdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T42C+4SBbpPKC+s/Z6/TtR9YCHC68Sfy/m5Tfi8ZBiA=;
        b=rOfzixtK21/dqY4Nwi/wtsqW19irDYn5qOuxmT5jCtvZm5kZCthrkbhYXDOEzHw7XK
         DdLUOsAtGoOD8t7rjLxuR2HNehlM1DL5KVMjsGoldM+hipy059Sh9kNEswlGb2pPS+X/
         GuFA4IfbZK3dX/+NL9UUU7i0SbQIEeDIWpnyEqBzRCibS78yqUEByyfYquedw8Hrgfrm
         GVSAGkvGaHXTL+suxaM93ItRRAWbEnDOJbC46j7xvZG1KZVvPuPphchNuT//gy/zsEYK
         Fbz4PCYq9bXqB7zhjR9fxMGPLv1oLy+Cv5YJtw/4abwEgT1VyodMgmb/0Oj4EIseuBN5
         AYIg==
X-Gm-Message-State: AOAM531R7puwmti1SPV2o0QfjOAzG1SxFz6/UOmUtIX9j58PUvyO17lH
        z727D3p/lznEtrEX31G6zghRWfivAmE=
X-Google-Smtp-Source: ABdhPJxfJYKEciCb1JB+6iquHMfJQOqFkolOMjiEG02Fwovqy/BBmEP+aNNQM7/yqbC736bP4gEh1A==
X-Received: by 2002:adf:d1e3:0:b0:20c:6684:9b10 with SMTP id g3-20020adfd1e3000000b0020c66849b10mr20450507wrd.53.1652210836436;
        Tue, 10 May 2022 12:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020adfa14a000000b0020cd0762f37sm5263512wrr.107.2022.05.10.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:27:15 -0700 (PDT)
Message-Id: <fc1319338fc3e44584e92cb92bff2f6c99c59859.1652210824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 19:27:03 +0000
Subject: [PATCH v4 6/7] scalar: teach `diagnose` to gather packfile info
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

It's helpful to see if there are other crud files in the pack
directory. Let's teach the `scalar diagnose` command to gather
file size information about pack files.

While at it, also enumerate the pack files in the alternate
object directories, if any are registered.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 30 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh |  6 +++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 34cbec59b45..e8e0a5ec473 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "archive.h"
+#include "object-store.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -595,6 +596,29 @@ cleanup:
 	return res;
 }
 
+static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
+				   const char *file_name, void *data)
+{
+	struct strbuf *buf = data;
+	struct stat st;
+
+	if (!stat(full_path, &st))
+		strbuf_addf(buf, "%-70s %16" PRIuMAX "\n", file_name,
+			    (uintmax_t)st.st_size);
+}
+
+static int dir_file_stats(struct object_directory *object_dir, void *data)
+{
+	struct strbuf *buf = data;
+
+	strbuf_addf(buf, "Contents of %s:\n", object_dir->path);
+
+	for_each_file_in_pack_dir(object_dir->path, dir_file_stats_objects,
+				  data);
+
+	return 0;
+}
+
 static int cmd_diagnose(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -657,6 +681,12 @@ static int cmd_diagnose(int argc, const char **argv)
 		     "--add-file-with-content=diagnostics.log:%.*s",
 		     (int)buf.len, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
+	dir_file_stats(the_repository->objects->odb, &buf);
+	foreach_alt_odb(dir_file_stats, &buf);
+	strvec_push(&archiver_args, buf.buf);
+
 	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
 	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 934b2485d91..3dd5650cceb 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -93,6 +93,8 @@ test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
 SQ="'"
 test_expect_success UNZIP 'scalar diagnose' '
 	scalar clone "file://$(pwd)" cloned --single-branch &&
+	git repack &&
+	echo "$(pwd)/.git/objects/" >>cloned/src/.git/objects/info/alternates &&
 	scalar diagnose cloned >out 2>err &&
 	grep "Available space" out &&
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
@@ -102,7 +104,9 @@ test_expect_success UNZIP 'scalar diagnose' '
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
 	unzip -p "$zip_path" diagnostics.log >out &&
-	test_file_not_empty out
+	test_file_not_empty out &&
+	unzip -p "$zip_path" packs-local.txt >out &&
+	grep "$(pwd)/.git/objects" out
 '
 
 test_done
-- 
gitgitgadget

