Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D91C25B0F
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiHLUKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiHLUK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:29 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E284D7672
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k17so1046509wmr.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5XpJGv8eluRhP8y14ld5we3CaQHJVLkyzbbj70llQiA=;
        b=ZEREHJ6v7txLtL15aYoa/LlDNy299z6YuVHLNDZOGlu5A3BoFgfDbHG90QTyte5vcq
         kRBMgVGZ0d+Hhq7Xz75DMFPLVr12W74g+jaoMNxU5hJrWFgKXI3EB9r3MHVznwGJ6wOq
         At89oIo463VLFJBJ8xvUFKh5b3MLB2GeksjuJQ2iW2GwmB8Mbte/ymU4455zxPdMcykA
         Nls8O0HiuFeuvxJvN5vV8NG0NPacgfVthgc2Qb++02zIJ81kOOaC1ORbaM4Oly4r2vwp
         K2dk9sQ/tYZRuXy/eDqS3S10ysVCWFXvx7leNiUDTtJ4NL97CpXOyCZgsTi5yy1q/cqG
         qjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5XpJGv8eluRhP8y14ld5we3CaQHJVLkyzbbj70llQiA=;
        b=lrL491x9Qahd4U/PhJykCcZs7DSGiab84Mgul5L7z8xWDPRIjY527UQmFxVpWN1JMV
         8eWOayLwEYSRJ5S2XDQ2Imi8CO3or2b4/Yifm9dImZT/mEC8TpfjOntO24PLL/uMmlds
         jv+VJfD6YJXUgiL72/WPoiBmTfxPAXQdarZ+/3kbt6eyOe/rhrkA2To1LxT3O+ZFTSHJ
         0gIM93oNaz8bTcgc2wFpQzJLgb9G0TWwIOddvczPxTW8b2OghJ+qqVDupu2/5l676EIa
         lidcyZkYsW4Tjt1iUqqNmPD7vE1dmHI2aIMPja4R257gmYVcQCI4u4U5R/V3hZX86TdK
         yCKQ==
X-Gm-Message-State: ACgBeo30FnbbvGpFSkWVf+lfaLUkeTbZiG8R1ZZtQnd77ot0rn1uNpGe
        xjWW5SlRBzN/w0FXj5zD9vtywTgsj3Y=
X-Google-Smtp-Source: AA6agR6Ouq0TfmtljvAzL1S6zPeVxUMeSuWkTEf1g9Ss7KGcXkCahrCiUyJISyPdn67+HURRQEjHdA==
X-Received: by 2002:a7b:c453:0:b0:3a5:b42e:c4fb with SMTP id l19-20020a7bc453000000b003a5b42ec4fbmr3596521wmi.167.1660335027119;
        Fri, 12 Aug 2022 13:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003a325bd8517sm744438wmq.5.2022.08.12.13.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:26 -0700 (PDT)
Message-Id: <710b67e5776363d199ed5043d019386819d44e7e.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:14 +0000
Subject: [PATCH v4 06/11] diagnose.c: add option to configure archive contents
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

Finally, refactor from a hardcoded set of 'add_directory_to_archiver()'
calls to iterative invocations gated by 'DIAGNOSE_ALL'. This allows for
easier future modification of the set of directories to archive and improves
error reporting when 'add_directory_to_archiver()' fails.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c |  2 +-
 diagnose.c              | 39 +++++++++++++++++++++++++++++++--------
 diagnose.h              |  8 +++++++-
 3 files changed, 39 insertions(+), 10 deletions(-)

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
index f0dcbfe1a2a..9270056db2f 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -8,6 +8,11 @@
 #include "object-store.h"
 #include "packfile.h"
 
+struct archive_dir {
+	const char *path;
+	int recursive;
+};
+
 static void dir_file_stats_objects(const char *full_path, size_t full_path_len,
 				   const char *file_name, void *data)
 {
@@ -132,13 +137,25 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 	return res;
 }
 
-int create_diagnostics_archive(struct strbuf *zip_path)
+int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 {
 	struct strvec archiver_args = STRVEC_INIT;
 	char **argv_copy = NULL;
 	int stdout_fd = -1, archiver_fd = -1;
 	struct strbuf buf = STRBUF_INIT;
-	int res;
+	int res, i;
+	struct archive_dir archive_dirs[] = {
+		{ ".git", 0 },
+		{ ".git/hooks", 0 },
+		{ ".git/info", 0 },
+		{ ".git/logs", 1 },
+		{ ".git/objects/info", 0 }
+	};
+
+	if (mode == DIAGNOSE_NONE) {
+		res = 0;
+		goto diagnose_cleanup;
+	}
 
 	stdout_fd = dup(STDOUT_FILENO);
 	if (stdout_fd < 0) {
@@ -177,12 +194,18 @@ int create_diagnostics_archive(struct strbuf *zip_path)
 	loose_objs_stats(&buf, ".git/objects");
 	strvec_push(&archiver_args, buf.buf);
 
-	if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/info", 0)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/logs", 1)) ||
-	    (res = add_directory_to_archiver(&archiver_args, ".git/objects/info", 0)))
-		goto diagnose_cleanup;
+	/* Only include this if explicitly requested */
+	if (mode == DIAGNOSE_ALL) {
+		for (i = 0; i < ARRAY_SIZE(archive_dirs); i++) {
+			if (add_directory_to_archiver(&archiver_args,
+						      archive_dirs[i].path,
+						      archive_dirs[i].recursive)) {
+				res = error_errno(_("could not add directory '%s' to archiver"),
+						  archive_dirs[i].path);
+				goto diagnose_cleanup;
+			}
+		}
+	}
 
 	strvec_pushl(&archiver_args, "--prefix=",
 		     oid_to_hex(the_hash_algo->empty_tree), "--", NULL);
diff --git a/diagnose.h b/diagnose.h
index 06dca69bdac..998775857a0 100644
--- a/diagnose.h
+++ b/diagnose.h
@@ -3,6 +3,12 @@
 
 #include "strbuf.h"
 
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

