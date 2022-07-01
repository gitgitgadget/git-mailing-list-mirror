Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFB3C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 05:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbiGAFXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 01:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiGAFX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 01:23:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344A320BE5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso3012432wma.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qvezfsif24RxP/q1DoI0nPqqRLx3QsjDsyp57AfgCF8=;
        b=bhIzUv5BTIvO+W7Xx8Gp53Amz0OiIVc1RRml/3FMo3fAX9PbIJLs2axFs4eTklvpZv
         sPHt82TMNCMNYQfQsojO+llLb1fm0RNAEzGCzqcisZDTNRDSKGI2WU5lDzY5cK2/ZtQf
         uvcpm4Bh9+L3C6i/ue9QYbZYwb84iJlWwNAnX0a/1AJDw1v3TYi12SVzApUVRN9HKwR7
         7fob+Z2b0xrxjDj5CSWpFTYzu4NmdZEmq7uRCvINGbdP/Xuf0kBdOb0mAPCFq4Incja9
         jhiJ4voajZA/UkUsO5u8i5T5IcLmYoZSulAW8wSefTFVY3970Dyu1wG4kKvIshD5iQaO
         Joaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qvezfsif24RxP/q1DoI0nPqqRLx3QsjDsyp57AfgCF8=;
        b=EM69QJdy27oWMqId7jo5jQ2+AR3MOeSxO8IOvSqzwTbHSaGNz74++/tStYqfiYk7lL
         8KiN0sEFfkC/dphatRL+pF6ZsheVlsmqjDgDxlF2/kj1qh6uo6rLkbZF6VFDgClk6ap3
         8hdoUeTg2lpcTwtltJbr4/mLGBDCmznISBjOT31goyqcHebDHeAisXPxTTYzFw+IqU3/
         lGHQifAC3KeaZGER/ibob5s0zgMu5CyjBnnnUi5GmckzG5xnwOWXW5uV66Q7U6FRrhAV
         d/jHoKrTwfp8qqyzMibTxqVqUn+VMIvqd5UquVc92iSr1kVhadKrhL2RiIKMoLlxJ25k
         9IlA==
X-Gm-Message-State: AJIora9O8LV6XAhjBFf2CgwFmhv4G7OMsST5iv4GdI6P/2iJHC/AzL97
        GKhDp35v/uxgXQRWaknmCzcfVDQ3ECk=
X-Google-Smtp-Source: AGRyM1u9J30bEL0T6D69NR2mCNPRR0R8dwWdryuo8Oo6G88Y4WnvbyMV6y9nr9IZAlbNipVQEA6Fgw==
X-Received: by 2002:a1c:f305:0:b0:39c:4840:ab42 with SMTP id q5-20020a1cf305000000b0039c4840ab42mr15519932wmq.148.1656653007487;
        Thu, 30 Jun 2022 22:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm21680886wrr.3.2022.06.30.22.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 22:23:27 -0700 (PDT)
Message-Id: <121761e26e2468d77910a7bee2e1f18776995c68.1656653000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
        <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jul 2022 05:23:20 +0000
Subject: [PATCH v3 5/5] merge-ort: fix issue with dual rename and add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

Another way to look at this is that if the source name involved in a
directory rename on one side is the target name of a directory rename
operation for a file from the other side, then we avoid the doubly
transitive rename.  (More concretely, if a directory rename on side D
wants to rename a file on side E from OLD_NAME -> NEW_NAME, and side D
already had a file named NEW_NAME, and a directory rename on side E
wants to rename side D's NEW_NAME -> NEWER_NAME, then we turn off the
directory rename detection for NEW_NAME to prevent the
NEW_NAME -> NEWER_NAME rename, and instead end up with an add/add
conflict on NEW_NAME.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 8 +++++++-
 t/t6423-merge-rename-directories.sh | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index b496f0e3803..daa0e4496f8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2292,10 +2292,16 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	struct strmap_entry *rename_info;
 	struct strmap_entry *otherinfo;
 	const char *new_dir;
+	int other_side = 3 - side_index;
 
-	/* Cases where we don't have a directory rename for this path */
+	/*
+	 * Cases where we don't have or don't want a directory rename for
+	 * this path.
+	 */
 	if (strmap_empty(dir_renames))
 		return NULL;
+	if (strmap_get(&collisions[other_side], path))
+		return NULL;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
 		return NULL;
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index ed5586de28c..99baf77cbfd 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5250,7 +5250,7 @@ test_setup_12l () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (B into A): Rename into each other + add/add conflict' '
 	test_setup_12l BintoA &&
 	(
 		cd 12l_BintoA &&
@@ -5277,7 +5277,7 @@ test_expect_merge_algorithm failure failure '12l (B into A): Rename into each ot
 	)
 '
 
-test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (A into B): Rename into each other + add/add conflict' '
 	test_setup_12l AintoB &&
 	(
 		cd 12l_AintoB &&
-- 
gitgitgadget
