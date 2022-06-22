Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC895C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 04:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356882AbiFVEWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356084AbiFVEWH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 00:22:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666334BB7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:22:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so8264192wme.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 21:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WpGUYGiduER+iqJ4m7SM94UODwIKGdJwNycBkkF3qNg=;
        b=Kxcu1/nmxJSK3K0P/YvwZXX5R2yKPIuwMgsj0+pdN8Dbjd0sQuUEHYZ08dVzbf/twJ
         93lF/SHwFUeklGyfjZtmGM3d675UuGfN9yAtrwegXFm3HQE6EeTzAjBx+o0P107wrQBI
         CNtWcAUJZyL71CE9ZFISOhyKOJbHvk+pT4IxotcEGNEFPIQbWT5raSZFGiFdULZhz0Ti
         9Tj6GPQ+8TQ9bP1z+P/WSD08PiS+d9q0U+4/G1wdBVgYXbDoiI1Mt9nhuh9ZpGR/AjPE
         gnilcakMcbNWfQmIYaRqnF5ZkCz6dZzFsT+NtNJiHn88ipviS3TyKtEwTBDszEKHe0uM
         PXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WpGUYGiduER+iqJ4m7SM94UODwIKGdJwNycBkkF3qNg=;
        b=hmf9dzdLVGbvisomFY8qb7++MlcW+86q5rQiPFzSEvR7JRncoC6gZxWkPAV42K2coj
         gMCkwQ2GOuIF3nLeOvjuvgnUF5KPOL9BpozEfMJiYD9T6qBpVI4KYprI0RV/OLzA6Zho
         fwqIhilrLCWjZVoDjqRP1ObUrTFX2V0zMjoDYIAXo0o7ru6aDjVNL3ppz4XxVQ3af2+6
         H9Ks5rA1zFN0XWnNAi8V6Vv2FEnDAIrzT5JurFpiZafHklzy9C6hdxPWKLXfpvAdu31t
         cEPBFTxC1eiqv3NKN4lteDnwYCM5ykk2JniJJGV+HC9Ejr9q7GCS+xl7XtrwJWvI98hc
         fZYg==
X-Gm-Message-State: AJIora9j3oAITfMjlmTc+hOZjE5ORPTkAghkwtnRaUCRWA/31uB92K5Z
        BX2dYVdrvPrInekLUapqFp2ff4QSr5+1qA==
X-Google-Smtp-Source: AGRyM1tvPEFoAebE1+BlsrHqgctQkiuUqBCbURjTZI5nPS5CgqASl9YS6XRawKdCqdOfiAsB+7TplQ==
X-Received: by 2002:a05:600c:4ed0:b0:39c:4acb:4e04 with SMTP id g16-20020a05600c4ed000b0039c4acb4e04mr1528002wmq.63.1655871724836;
        Tue, 21 Jun 2022 21:22:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d54c5000000b0021b88ec99cesm10600990wrv.94.2022.06.21.21.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:21:51 -0700 (PDT)
Message-Id: <bb2badccb71d76efe0e47431246376b1e7016b05.1655871652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Jun 2022 04:20:51 +0000
Subject: [PATCH 3/3] merge-ort: fix issue with dual rename and add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is code in both merge-recursive and merge-ort for avoiding doubly
transitive renames (i.e. one side renames directory A/ -> B/, and the
other side renames directory B/ -> C/), because this combination would
otherwise make a mess for new files added to A/ on the first side and
wondering which directory they end up in -- especially if there were
even more renames such as the first side renaming C/ -> D/.  In such
cases, it just turns "off" directory rename detection for the higher
order transitive cases.

The testcases added in t6423 a couple commits ago are slightly different
but similar in principle.  They involve a similar case of paired
renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
a leading directory of B/ to C/.  And both sides add a new file
somewhere under the directory that the other side will rename.  While
the new files added start within different directories and thus could
logically end up within different directories, it is weird for a file
on one side to end up where the other one started and not move along
with it.  So, let's just turn off directory rename detection in this
case as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 4 ++++
 t/t6423-merge-rename-directories.sh | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index fa6667de18c..5bcb9a4980b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2292,9 +2292,13 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	struct strmap_entry *rename_info;
 	struct strmap_entry *otherinfo = NULL;
 	const char *new_dir;
+	int other_side = 3 - side_index;
 
+	/* Cases where there is no new path, so we return NULL */
 	if (strmap_empty(dir_renames))
 		return new_path;
+	if (strmap_get(&collisions[other_side], path))
+		return new_path;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
 		return new_path;
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 296c04f8046..4286ae987c4 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5245,7 +5245,7 @@ test_setup_12l () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (B into A): Rename into each other + add/add conflict' '
 	test_setup_12l BintoA &&
 	(
 		cd 12l_BintoA &&
@@ -5273,7 +5273,7 @@ test_expect_merge_algorithm failure failure '12l (B into A): Rename into each ot
 	)
 '
 
-test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (A into B): Rename into each other + add/add conflict' '
 	test_setup_12l AintoB &&
 	(
 		cd 12l_AintoB &&
-- 
gitgitgadget
