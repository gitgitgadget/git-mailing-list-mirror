Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7BC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiHVPTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiHVPS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1D2474E0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j26so5774816wms.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=4NW4/0bdG0kXFtejIGKFCn58tMh4l2G8g5WzbD8gXrU=;
        b=DQPMOy7REVNaNk7ptTtsvdoakJiVg0gpnRy8i6Ruwt6BlB7TyzRTrY6nZB7+mnvLC7
         Vv4TKctZXSo+SJAskosb9SoDHPipxVjLcJ2D4fo2XNfMi1Rh10/E6FUQY2O+j0J4Ztik
         Q4j7Wq/UMaxAiSJZ8uUqsoScZM6ndRlEVy1ObYLcsXVJoEUdRjm03RVKO4+m8UC3PpXF
         B09xzDAinubK9oDveti71X4wUgUOnZtziqeXIukAwI0KK61gaMU4+nE86eCp04NwCstW
         zN373F7g21CDfqmFuNcYB7/bYb9RfaEEWG50xRraLKGXwI4in4VGSvZvpx8YXbbGTWvR
         kKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=4NW4/0bdG0kXFtejIGKFCn58tMh4l2G8g5WzbD8gXrU=;
        b=vMxvcnflvF//1aITTTJZLgDc/4xj+Fyt9lRWMBpxEtCaVQdYVe5SZI8vOjKX56MWrv
         REleH/mUYRYp1HHUgPrJyL9c9O0MiesrJrzIOQyIv6GP85e0H1La26csODPZisz5caEN
         s/CqG5Hso3Q0VbbS2Q+V44s9ZT5MYKd54APJj5Ji+0mgn+Q5khZAYexRsaYMdx+X7Q7F
         EbSVOBd9JhzO2lpPme2083JUTU1C4gJQ0wnfF+GDL1tS7tNLeOoey4/ntD2+TftUBwK1
         vCd7gVv4VRMpHJWeGOEoiv82XEqd0uCtHZQyGmcNBLe2rA3PjXfau0kS92iByP09156a
         t3qA==
X-Gm-Message-State: ACgBeo2q7FBb3H0f0Zy4Coo7XaePze+L/F8VGr7B72/Ip5M6EOShkQkp
        msHDNb0kNTZacYgzHCJoTwRWCM7X/Vs=
X-Google-Smtp-Source: AA6agR4CtkrWJoOdSt+jxgeOnaYl98oFz6eLknd0oOV9tnyjkuJ/SUtK3jD7AsT70Y6doqRg9qyEVQ==
X-Received: by 2002:a05:600c:3b0c:b0:3a6:aa0:5966 with SMTP id m12-20020a05600c3b0c00b003a60aa05966mr12384583wms.183.1661181181715;
        Mon, 22 Aug 2022 08:13:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b003a5dde32e4bsm19416884wms.37.2022.08.22.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:13:01 -0700 (PDT)
Message-Id: <039e172849c6b028df1abf258666c77bd42b23fe.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:53 +0000
Subject: [PATCH 6/7] bundle-uri: limit recursion depth for bundle lists
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The next change will start allowing us to parse bundle lists that are
downloaded from a provided bundle URI. Those lists might point to other
lists, which could proceed to an arbitrary depth (and even create
cycles). Restructure fetch_bundle_uri() to have an internal version that
has a recursion depth. Compare that to a new max_bundle_uri_depth
constant that is twice as high as we expect this depth to be for any
legitimate use of bundle list linking.

We can consider making max_bundle_uri_depth a configurable value if
there is demonstrated value in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index dca88ed1e89..c9f3df28b2f 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -334,11 +334,25 @@ static int unbundle_from_file(struct repository *r, const char *file)
 	return result;
 }
 
-int fetch_bundle_uri(struct repository *r, const char *uri)
+/**
+ * This limits the recursion on fetch_bundle_uri_internal() when following
+ * bundle lists.
+ */
+static int max_bundle_uri_depth = 4;
+
+static int fetch_bundle_uri_internal(struct repository *r,
+				     const char *uri,
+				     int depth)
 {
 	int result = 0;
 	struct strbuf filename = STRBUF_INIT;
 
+	if (depth >= max_bundle_uri_depth) {
+		warning(_("exceeded bundle URI recursion limit (%d)"),
+			max_bundle_uri_depth);
+		return -1;
+	}
+
 	if ((result = find_temp_filename(&filename)))
 		goto cleanup;
 
@@ -363,6 +377,11 @@ cleanup:
 	return result;
 }
 
+int fetch_bundle_uri(struct repository *r, const char *uri)
+{
+	return fetch_bundle_uri_internal(r, uri, 0);
+}
+
 /**
  * General API for {transport,connect}.c etc.
  */
-- 
gitgitgadget

