Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A38DC4332F
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352726AbiCXSgg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347496AbiCXSge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:36:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A44A3DA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:01 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n35so3250330wms.5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ggsen9t1DWi2PmRzGFNmuztbaUFwaSCRJRh3trWH464=;
        b=U0RB2qdVeOKVy9Hz8jWt5GSL+LyEF0heufpsFmUMHWXSKxENDkySHuiySpvsiW7tt0
         FB9nGS/lm17+zqfucMeRff8FJcw7sgMKl3rf58g4fctnQhkSpZj9NJJ9LTIKebjF20Fh
         //AC6ufo4SLQ3TUbk0dWqV4Gtc6tErrkmnEgw3F7An5zj0RpJYviiqpuGTrmpbXe7QCC
         uty9nw9a3fjhW64+ucsQ34S5ghfEbSEi0Ts88RVN9Ish7qZd33V5I3GwUoHfdoJ/7bYM
         nilL6XwL8oqSG8SJeIf283Hb9dfXnWJFWUOcHC6hYiNjUSa428fbYscfg/AyQfzslgru
         jlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ggsen9t1DWi2PmRzGFNmuztbaUFwaSCRJRh3trWH464=;
        b=h+QHfnTYelq9KflGHnnpEPTSdOqkBF3c4/bPMJkTPjDP2TowO6MeFAuqJ7Xa7wRhxf
         ovcBqPGTIJw/A21KP6iAUe1mOsAmFFC+580ioImQ5vSALN2W1ibVBhhcoC1ZZWzvP5Qv
         bHrgriC/7zyurxhjLH8jAJ9nXEioIz27uhCccJmZcmKU/VwBXE1/QTmMm2dldDpOhTnC
         /oNNtPO+prHoJEY0/e+hjc1b3vtYA34N1CxPKlOMYqyc9YGsuE8DtRrsXUo02ctZPrcT
         TF1YF7lLoAePYweZQpL8TXt74R+VrBKE4f+dvHIWlrrKvKgF1ZCzPto1trI4zzA85Tz8
         qDUw==
X-Gm-Message-State: AOAM530mBrGO0i/g/1nRS/K2XSZ+5Cj+xzjDI+5HBHzk+XDe81tDf3vO
        HgiEnxM6Y9SSOoYjf99aoO5uKhvEy6Q=
X-Google-Smtp-Source: ABdhPJyVzVkO+UrBZEpVtMmCdsAHNWGNo06p7Lm8R6tfXkTT+RHz+XYmN/g+pR7AKp+3a8MA0hfuYg==
X-Received: by 2002:a05:600c:589:b0:38c:ae43:a941 with SMTP id o9-20020a05600c058900b0038cae43a941mr5883746wmd.14.1648146900390;
        Thu, 24 Mar 2022 11:35:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6d52000000b00203da94cf01sm3228261wri.14.2022.03.24.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:34:59 -0700 (PDT)
Message-Id: <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 18:34:56 +0000
Subject: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The '--write-midx -b packs non-kept objects' test in t7700-repack.sh
uses test_subcommand_inexact to check that 'git repack' properly adds
the '--honor-pack-keep' flag to the 'git pack-objects' subcommand.
However, the test_subcommand_inexact helper is more flexible than
initially designed, and this instance is the only one that makes use of
it: there are additional arguments between 'git pack-objects' and the
'--honor-pack-keep' flag. In order to make test_subcommand_inexact more
strict, we need to fix this instance.

This test checks that 'git repack --write-midx -a -b -d' will create a
new pack-file that does not contain the objects within the kept pack.
This behavior is possible because of the multi-pack-index bitmap that
will bitmap objects against multiple packs. Without --write-midx, the
objects in the kept pack would be duplicated so the resulting pack is
closed under reachability and bitmaps can be created against it. This is
discussed in more detail in e4d0c11c0 (repack: respect kept objects with
'--write-midx -b', 2021-12-20) which also introduced this instance of
test_subcommand_inexact.

To better verify the intended post-conditions while also removing this
instance of test_subcommand_inexact, rewrite the test to check the list
of packed objects in the kept pack and the list of the objects in the
newly-repacked pack-file _other_ than the kept pack. These lists should
be disjoint.

Be sure to include a non-kept pack-file and loose objects to be extra
careful that this is properly behaving with kept packs and not just
avoiding repacking all pack-files.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t7700-repack.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 770d1432046..73452e23896 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -369,10 +369,56 @@ test_expect_success '--write-midx with preferred bitmap tips' '
 	)
 '
 
+get_sorted_objects_from_packs () {
+	git show-index <$(cat) >raw &&
+	cut -d" " -f2 raw | sort
+}
+
 test_expect_success '--write-midx -b packs non-kept objects' '
-	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
-		git repack --write-midx -a -b &&
-	test_subcommand_inexact git pack-objects --honor-pack-keep <trace.txt
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		# Create a kept pack-file
+		test_commit base &&
+		git repack -ad &&
+		find $objdir/pack -name "*.idx" >before &&
+		>$objdir/pack/$(basename $(cat before) .idx).keep &&
+
+		# Create a non-kept pack-file
+		test_commit other &&
+		git repack &&
+
+		# Create loose objects
+		test_commit loose &&
+
+		# Repack everything
+		git repack --write-midx -a -b -d &&
+
+		# There should be two pack-files now, the
+		# old, kept pack and the new, non-kept pack.
+		find $objdir/pack -name "*.idx" | sort >after &&
+		test_line_count = 2 after &&
+		find $objdir/pack -name "*.keep" >kept &&
+		test_line_count = 1 kept &&
+
+		# Get object list from the kept pack.
+		get_sorted_objects_from_packs \
+			<before \
+			>old.objects &&
+
+		# Get object list from the one non-kept pack-file
+		comm -13 before after >new-pack &&
+		get_sorted_objects_from_packs \
+			<new-pack \
+			>new.objects &&
+
+		# None of the objects in the new pack should
+		# exist within the kept pack.
+		comm -12 old.objects new.objects >shared.objects &&
+		test_must_be_empty shared.objects
+	)
 '
 
 test_expect_success TTY '--quiet disables progress' '
-- 
gitgitgadget

