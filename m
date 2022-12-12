Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57684C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiLLReK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiLLRdj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2941E10B3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m19so6111886wms.5
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZMiw7s7FJbQu1LDSweZ3iytSvVyLV7dfc+zg18XjJ4=;
        b=AYqGsuRpV6DCYBsA/ktakoqUl/99bx3raV3tNM47dTg6gJoN06q7VBZ9DIez19X+Xr
         504GzIFuOcgeLmjghM8BjKh78wvmFa7nkWF8Ksriy3016TPTiqP55a3nm4xncRP/iCQD
         D40X67sAREOrXUy61sKw2PAhtGJ67aFIkChfaYlmvk1oTglgKXosVVjWyOycTK/6Xb74
         wWX4AKKqLYMCYinvgJO3yQ7yOkGCwMBcGqbDYfbaCOLz/pc56nX/3SycQFqJl+CywCi2
         j4T4li30JcxrtGV90hiKuTgg0FchnnuWfV4Grg+kyzO/uzKyGUKAgdVfdCIjZO6nQxaN
         XyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZMiw7s7FJbQu1LDSweZ3iytSvVyLV7dfc+zg18XjJ4=;
        b=t4vARFPvc8vHEln2XZD935heXua4+XQDSG2mejXT6p3MHjXkLc9FP7ajUdHCqg8q6m
         LRAiJ5U6j27O6r9KwssTBUu/86SzY41dMPwp1P2cCA1szGV8kTYk075QAmRZzX1lfZTB
         oK1+QxBp1dpIYFQFljciC2mVRdiCWSWvu5x3+9miRVyS37Xgblc0mBl82SRUJ75JiHN9
         02ZfFfleRwZcH9d2Qjvq031K4MGqsLoBStgjcPZXszQcZqYAM/k0hCrKv6k9bEi0G2Ug
         zVrExRawWma4VKGKwS20oalpWCQTa+BemmJ/ojFNG6mkhkYd3u50s9Rbc7gA1Sil6FaM
         UtDQ==
X-Gm-Message-State: ANoB5pncl8Ki4veqaTH1uNOtEOLHZWoqRo9SnWgai9NI11rxU3kAyXZ2
        ySiODwdQrddJglulu2fujpPvuyoThy4=
X-Google-Smtp-Source: AA0mqf7Pc3PnTtEHDjnMYE5jRDW0NX9qzSKrZW0ckrEfcOQ/aDk3dUcM8azsI3DU7sIBFo/LvCGefA==
X-Received: by 2002:a05:600c:1f19:b0:3d0:7a4e:f82f with SMTP id bd25-20020a05600c1f1900b003d07a4ef82fmr13112375wmb.15.1670866408570;
        Mon, 12 Dec 2022 09:33:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003c6f8d30e40sm10876859wms.31.2022.12.12.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:33:28 -0800 (PST)
Message-Id: <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 17:33:24 +0000
Subject: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'uri' parameter of fetch_bundle_list() was added early in
development, but is not required since the 'list' parameter includes a
'baseURI' member. Remove the 'uri' parameter and make this expectation
explicit.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c | 1 -
 bundle-uri.c    | 2 +-
 bundle-uri.h    | 8 ++++----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 12fb527d7bb..430b2e981e3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1284,7 +1284,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			if (repo_init(the_repository, git_dir, work_tree))
 				warning(_("failed to initialize the repo, skipping bundle URI"));
 			else if (fetch_bundle_list(the_repository,
-						   remote->url[0],
 						   transport->bundles))
 				warning(_("failed to fetch advertised bundles"));
 		} else {
diff --git a/bundle-uri.c b/bundle-uri.c
index c411b871bdd..8efb4e7acad 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -577,7 +577,7 @@ cleanup:
 	return result;
 }
 
-int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
+int fetch_bundle_list(struct repository *r, struct bundle_list *list)
 {
 	int result;
 	struct bundle_list global_list;
diff --git a/bundle-uri.h b/bundle-uri.h
index b2c9c160a52..29b0c98ee65 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -68,8 +68,8 @@ struct bundle_list {
 	 * In the case of the 'bundle-uri' protocol v2 command, the base
 	 * URI is the URI of the Git remote.
 	 *
-	 * Otherewise, the bundle list was downloaded over HTTP from some
-	 * known URI.
+	 * Otherwise, the bundle list was downloaded over HTTP from some
+	 * known URI. 'baseURI' is set to that value.
 	 *
 	 * The baseURI is used as the base for any relative URIs
 	 * advertised by the bundle list at that location.
@@ -112,10 +112,10 @@ int fetch_bundle_uri(struct repository *r, const char *uri);
  * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
  * bundles according to the bundle strategy of that list.
  *
- * Returns non-zero if no bundle information is found at the given 'uri'.
+ * It is expected that the given 'list' is initialized, including its
+ * 'baseURI' value.
  */
 int fetch_bundle_list(struct repository *r,
-		      const char *uri,
 		      struct bundle_list *list);
 
 /**
-- 
gitgitgadget

