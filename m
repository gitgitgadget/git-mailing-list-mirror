Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E0DC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 17:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiCVRaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbiCVRaR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 13:30:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ED1E39
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2383892wmb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lL7IRR3IAXAd1hNj4pTPG7N19dM5VsQBYzO3xGDzQAg=;
        b=lBtu910OjSRmMRnKAFe0+iUwygFwRxH4kOTDjuAkov5xMl8nkNkRCNVwgJo5i4B48/
         +oRsas+2rZralrgVzuQzcPdCJog87vgOFeIez/K68YxChR3VwetEIy2Gx6fnFNIcKMHR
         GZQCT12SQw52X8beLYKmMYE44mOcoojd+bXWfW6AJ23+0zWTN+TecugmyogrZP8QTNsc
         Kr1xZhqpdTDX0wtObidAqhy6aww4AymwBf+ohX+YH2y9BDp2iiwePW01G3kShI9Z/dy8
         gSF9AgzhO3jC+wLWpgovz184WjB2fjO7BGRv1+AFrwFbDk+nAqjJBVHKVroBLB5gsdKI
         MFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lL7IRR3IAXAd1hNj4pTPG7N19dM5VsQBYzO3xGDzQAg=;
        b=w6tHSXR4YGLn7gbDzqzG4WrXpcAI4+gLYPywqa6YoiDdX/I91i+L/9le2gRUqjm7oB
         9Dwq/zwGo2DBCAH97xlhfmt8O2mZYuBhcS7ieaZ7r+5HDzAhxKIlTRIWmZZTrHuoXFnB
         I776ZUWIrHWZv1gL47U2uIdJfvrbl+BfY770D7uiZ0E0Lbk3AhspnVrj5Z1su9zK784K
         fhFiMYppNVuoJQt1oK/4eMAgeBAEMeYHfC+SNXiclW+nJtYsp0YF+ZI/57prvH2HHFrL
         0ghv/PdJvSFhCn69999VvjdT/RWSm1gkue2MihdvrhZixiYqGrNgCnBYU4IDqs9zb6zb
         n4yg==
X-Gm-Message-State: AOAM533GXFufwBnG7hF/vJGo6ylnGYueOeK9GN3BR6l0IEJ6i5xRsMim
        buPSV8Fc+SAcOC0cArWQz42zsjbMi7M=
X-Google-Smtp-Source: ABdhPJwMHOat20ajSbcvI3dEcZsoPJJKESLWslC94qiJwqNsvxpRGNWAVEEavFmdQJVxUsUfcL4Emw==
X-Received: by 2002:a05:600c:4f89:b0:38c:bd13:e03f with SMTP id n9-20020a05600c4f8900b0038cbd13e03fmr2797442wmq.117.1647970125490;
        Tue, 22 Mar 2022 10:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d64e5000000b00203914f5313sm16184732wri.114.2022.03.22.10.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:28:44 -0700 (PDT)
Message-Id: <1b2130426bd7bd6c0bf5c56be2bf66a4d81f0b27.1647970119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:28:38 +0000
Subject: [PATCH 4/5] bundle: move capabilities to end of 'verify'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'filter' capability was added in 105c6f14a (bundle: parse filter
capability, 2022-03-09), but was added in a strange place in the 'git
bundle verify' output.

The tests for this show output like the following:

	The bundle contains these 2 refs:
	<COMMIT1> <REF1>
	<COMMIT2> <REF2>
	The bundle uses this filter: blob:none
	The bundle records a complete history.

This looks very odd if we have a thin bundle that contains boundary
commits instead of a complete history:

	The bundle contains these 2 refs:
	<COMMIT1> <REF1>
	<COMMIT2> <REF2>
	The bundle uses this filter: blob:none
	The bundle requires these 2 refs:
	<COMMIT3>
	<COMMIT4>

This separation between tip refs and boundary refs is unfortunate. Move
the filter capability output to the end of the output. Update the
documentation to match.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-bundle.txt | 10 +++++-----
 bundle.c                     |  9 ++++-----
 t/t6020-bundle-misc.sh       |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index ac4c4352aae..7685b570455 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -75,11 +75,11 @@ verify <file>::
 	cleanly to the current repository.  This includes checks on the
 	bundle format itself as well as checking that the prerequisite
 	commits exist and are fully linked in the current repository.
-	Information about additional capabilities, such as "object filter",
-	is printed. See "Capabilities" in link:technical/bundle-format.html
-	for more information. Finally, 'git bundle' prints a list of
-	missing commits, if any. The exit code is zero for success, but
-	will be nonzero if the bundle file is invalid.
+	Then, 'git bundle' prints a list of missing commits, if any.
+	Finally, information about additional capabilities, such as "object
+	filter", is printed. See "Capabilities" in link:technical/bundle-format.html
+	for more information. The exit code is zero for success, but will
+	be nonzero if the bundle file is invalid.
 
 list-heads <file>::
 	Lists the references defined in the bundle.  If followed by a
diff --git a/bundle.c b/bundle.c
index e359370cfcd..276b55f8ce2 100644
--- a/bundle.c
+++ b/bundle.c
@@ -267,11 +267,6 @@ int verify_bundle(struct repository *r,
 			  (uintmax_t)r->nr);
 		list_refs(r, 0, NULL);
 
-		if (header->filter.choice) {
-			printf_ln("The bundle uses this filter: %s",
-				  list_objects_filter_spec(&header->filter));
-		}
-
 		r = &header->prerequisites;
 		if (!r->nr) {
 			printf_ln(_("The bundle records a complete history."));
@@ -282,6 +277,10 @@ int verify_bundle(struct repository *r,
 				  (uintmax_t)r->nr);
 			list_refs(r, 0, NULL);
 		}
+
+		if (header->filter.choice)
+			printf_ln("The bundle uses this filter: %s",
+				  list_objects_filter_spec(&header->filter));
 	}
 	return ret;
 }
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index ed95d195427..c4ab1367afc 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -510,8 +510,8 @@ do
 		<TAG-2> refs/tags/v2
 		<TAG-3> refs/tags/v3
 		<COMMIT-P> HEAD
-		The bundle uses this filter: $filter
 		The bundle records a complete history.
+		The bundle uses this filter: $filter
 		EOF
 		test_cmp expect actual &&
 
-- 
gitgitgadget

