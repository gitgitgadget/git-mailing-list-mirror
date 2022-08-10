Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D82C25B06
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 23:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiHJXfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiHJXeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 19:34:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E78C47A
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l4so19449132wrm.13
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 16:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mmDpOspHbIoc2UzryC4S2CEZVo1GPtwQ9kMQcuDi3yg=;
        b=ab0MC1yMWMNXYnrlL5Jm/vglqGQhHjU0pqpgTbJ/0R/g3S2k0piitr37tE/Pqt9FDx
         BlCeqiIcnVtwHtok7F5FQAdqsJd05+vvMJJ3/fQRi09Tz0ze/DWXFCj1dikVHxc+Gh0I
         pjd+nPxHaUeUesRbPKtflwk4xAVjUhTRzDadBUht3JvzS+HkkWuDBLUi8VToViqZFI98
         qP4uj3Zgu/AhQSWDwUHfwt3H2hvJfdIGfQokKsWMLeR7l+iOGa245r7y1kyS3kqnMtHS
         k6AL7potrG7U/WrNFHH2CD/MwqEm/yAfLR17adjFLFppRFW1Icfq8ppvwthR92tpH/31
         AQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mmDpOspHbIoc2UzryC4S2CEZVo1GPtwQ9kMQcuDi3yg=;
        b=2UkjMVqcQApqhdBtb4VXaxmCSNX3EaQDqC5llWKaZWaQrhmsyK2jwANSjk1Mk0QL7Q
         nd1Dsijo9lnTnF6F2SZlPFgTZ8Q3QaInuCUmf2S4EsP0KffKT+O0tF3oyWZYVYSbyp5E
         bd81GDxZFSi/38q0ncIkQX/mcEb2+5jJEDUnpavMTHFqOYKeDOeWFwJZ0h8eUgdxVxb1
         s4KMgfifVfzFO1oQOjib3KHySeU8+Y2WNRw5eXDxI/aN2z7cfGHJjIvGGdHTp0+09Jc7
         ooIahWKIEZNV4BQ0x35GYZwBYOq8JPhcdQGcg4IlaQ80kw2c8wpeloJpTDSbii0eumgz
         aFVg==
X-Gm-Message-State: ACgBeo1u+6I0N8zOf8y8qz1NWva9fhzgtb6Aa2C98CWdfqalbkrxb/9Q
        Jwi/aFVx/q7ZvEMjap/MFgJ3jqjN+J0=
X-Google-Smtp-Source: AA6agR4nDJr1qAo/5b9u+cDfwzoxfj4FMNN8nnux6kEFoz281tmLDGrVVIaii8WSNYB76f+zmLMKvA==
X-Received: by 2002:a05:6000:4084:b0:21e:c694:80db with SMTP id da4-20020a056000408400b0021ec69480dbmr17281811wrb.681.1660174480088;
        Wed, 10 Aug 2022 16:34:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x3-20020a05600c420300b003a54fffa809sm3582371wmh.17.2022.08.10.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:34:39 -0700 (PDT)
Message-Id: <0a6c55696d88cde666c11cd6b5d723c9e75a3b76.1660174473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
References: <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 23:34:28 +0000
Subject: [PATCH v3 06/11] diagnose.c: add option to configure archive contents
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'create_diagnostics_archive()' to take an argument 'mode'. When
archiving diagnostics for a repository, 'mode' is used to selectively
include/exclude information based on its value. The initial options for
'mode' are:

* DIAGNOSE_NONE: do not collect any diagnostics or create an archive
  (no-op).
* DIAGNOSE_STATS: collect basic repository metadata (Git version, repo path,
  filesystem available space) as well as sizing and count statistics for the
  repository's objects and packfiles.
* DIAGNOSE_ALL: collect basic repository metadata, sizing/count statistics,
  and copies of the '.git', '.git/hooks', '.git/info', '.git/logs', and
  '.git/objects/info' directories.

These modes are introduced to provide users the option to collect
diagnostics without the sensitive information included in copies of '.git'
dir contents. At the moment, only 'scalar diagnose' uses
'create_diagnostics_archive()' (with a hardcoded 'DIAGNOSE_ALL' mode to
match existing functionality), but more callers will be introduced in
subsequent patches.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c |  2 +-
 diagnose.c              | 19 +++++++++++++------
 diagnose.h              |  9 ++++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 3983def760a..d538b8b8f14 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -534,7 +534,7 @@ static int cmd_diagnose(int argc, const char **argv)
 		goto diagnose_cleanup;
 	}
 
-	res = create_diagnostics_archive(&zip_path);
+	res = create_diagnostics_archive(&zip_path, DIAGNOSE_ALL);
 
 diagnose_cleanup:
 	strbuf_release(&zip_path);
diff --git a/diagnose.c b/diagnose.c
index 509d582f0ea..aadc3d4b21f 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -132,7 +132,7 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-int create_diagnostics_archive(struct strbuf *zip_path)
+int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 {
 	struct strvec archiver_args = STRVEC_INIT;
 	char **argv_copy = NULL;
@@ -140,6 +140,11 @@ int create_diagnostics_archive(struct strbuf *zip_path)
 	struct strbuf buf = STRBUF_INIT;
 	int res;
 
+	if (mode == DIAGNOSE_NONE) {
+		res = 0;
+		goto diagnose_cleanup;
+	}
+
 	stdout_fd = dup(STDOUT_FILENO);
 	if (stdout_fd < 0) {
 		res = error_errno(_("could not duplicate stdout"));
@@ -177,11 +182,13 @@ int create_diagnostics_archive(struct strbuf *zip_path)
 	loose_objs_stats(&buf, ".git/objects");
 	strvec_push(&archiver_args, buf.buf);
 
-	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
+	/* Only include this if explicitly requested */
+	if (mode == DIAGNOSE_ALL &&
+	    ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
+	     (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0))))
 		goto diagnose_cleanup;
 
 	strvec_pushl(&archiver_args, "--prefix=",
diff --git a/diagnose.h b/diagnose.h
index 06dca69bdac..9bb6049bf0c 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -2,7 +2,14 @@
 #define DIAGNOSE_H
 
 #include "strbuf.h"
+#include "parse-options.h"
 
-int create_diagnostics_archive(struct strbuf *zip_path);
+enum diagnose_mode {
+	DIAGNOSE_NONE,
+	DIAGNOSE_STATS,
+	DIAGNOSE_ALL
+};
+
+int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode);
 
 #endif /* DIAGNOSE_H */
-- 
gitgitgadget

