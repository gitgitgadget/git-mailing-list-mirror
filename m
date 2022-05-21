Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA903C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 15:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355346AbiEUPIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbiEUPIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 11:08:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C404393469
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:26 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay35so4330080wmb.5
        for <git@vger.kernel.org>; Sat, 21 May 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q4Nq0XKv3sAz87ZRO+MCbKnQgUW64Vx3dbiERrPUd8U=;
        b=X9TJ3y2wzDJvVarqCCWPhTqiCfS+YvaQLC5iQd4jrPOlKvvHV+tCxbY9a2Ou6SnIkP
         OWccXfYBfjkYb4wyo9NQSgR4HqLNgQ8wbiUiE+2Q06MQcnwBINkaNHRV/cqkbvEb2jZA
         TvJR7/K1NKVoiH0tyzWxP1dHS4mFRke1LLuRu+v8OcpRA/tiIsdlfJkkJw9J1RWDSEy5
         0EQCByqvoyEppuNqJ2cDi0c0ue6OV03lSykgd8kBhK56kSsi79ahw3IGP+y59PZkaXMf
         BjNr5kq+A/qXW0W4yVCRE4M3AKX7dA2HXvC2MQQcuj6UyTH3u/Xge3mMo7/LRsjulb6h
         DYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q4Nq0XKv3sAz87ZRO+MCbKnQgUW64Vx3dbiERrPUd8U=;
        b=u0s5JaZ7nrbJO4F3Ge97oczwiBdP7X/g7arYrPZRfUKbmHa+tPP1TBHAKwI+1Ye5cN
         J9/27sR2AHc5IderJ9QvwuVNZKLbB4SbydsMYcHHJ/DDXU5/RfAJCBw4EzbA/pYJL145
         m4oc27yw9RypVteMLGSEniUoNGuuyKI7YtKFqibfeA2E2f25wekPxDYA2PATRjEk6r68
         06gJXUt+O2xCfNsgVvb+4U55m66HMioH22Qyy/+M7PCxulgi9P7AG55QaRyHAsP3Rk7b
         tyksfHCbonAT+jnSWVclrWFWiCAj/Iz8bmbU/9GJn4OHjQTTfHuaWBsn8NkxA+sK0nhj
         xMKA==
X-Gm-Message-State: AOAM530b7ydbeA1coQ4k9TF0mlu+XjiRIVq/Uhr6DRxZ5Ux78hB0Xqno
        LaSZJpnohQbAPa01d8AgovYChv5tNsI=
X-Google-Smtp-Source: ABdhPJxtsWuze+VjaG4ucBK9H81OVUPkknKiNexsHdNtqozg6jclG5m4cyByaRSRUx2M6fjcxyWApg==
X-Received: by 2002:a7b:c242:0:b0:397:43cd:8095 with SMTP id b2-20020a7bc242000000b0039743cd8095mr2149699wmj.174.1653145705011;
        Sat, 21 May 2022 08:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11-20020adfc74b000000b0020e68218048sm5651594wrh.93.2022.05.21.08.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 08:08:24 -0700 (PDT)
Message-Id: <15cd7f1789601662c0db979e4c12f13c632efb3c.1653145696.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 15:08:15 +0000
Subject: [PATCH v6 6/7] scalar: teach `diagnose` to gather packfile info
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
index 0a9e25a57f8..d302c27e114 100644
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
 		     "--add-virtual-file=diagnostics.log:%.*s",
 		     (int)buf.len, buf.buf);
 
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
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

