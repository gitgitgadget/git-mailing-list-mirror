Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD2CC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 19:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiKPTwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 14:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiKPTvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 14:51:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2AE56578
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v1so31681192wrt.11
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 11:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX+Qi4khe7Z9E7YyYDM1gBhRQumkHyVsNI42uohCUiQ=;
        b=maPEH+9Owxya2QFjHdzgfVDq11vPZkIAcNw3ED4XJcIlmwZqqL/csQ0mU/eMubhpcY
         tETtD/PS2Ua+0KQPFayx7Um6PPP45aH0+FFPgX/wzggFuPkSIywSaFGSLg/ZEGzgBKe9
         6ePh1uDJ4ZVFf1SnPH4/n2OHS1Sa2R1S+rj9sWom65FU9T44XjzFky+nHSK61NBNLjPH
         Eii8JHZhJHg5wgPDwlzA7ucHHrxGFRr5XoHz45yWdBJzaoK/hrgxoV74+DcOYLocvLI6
         4FEAdz3onYoIz1J7AS39OHjDCCx29SULiR+zQX0YLcSq6zukatE9VIvvBhG2/rQh33NF
         zDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX+Qi4khe7Z9E7YyYDM1gBhRQumkHyVsNI42uohCUiQ=;
        b=e/xAkQ5PAvYTESXAaqWmUpIx1RqlEvEMDDP+mBnMNGDMKWSP6UYMB3HomslMCR13MH
         G0bkpYkZL5iTdfZZCn2SoHW0Ki0aN9U5uJSETfUx2o6xY3adDQzPgk2QqT60OOcSVR/K
         o4yvNgjvBB4/duHEd3j856JtjLYjezi4rwBL/p+kt193sc4leGA1YlMAkkUW9qFXj7TR
         Bb1RPvhar5dwig0jXXdInstKROBrMvv0dkn+zHRjtdWIDXefl3vH6QPsifNoRsgLAu0c
         9I7qSMh1iKN26LIf4IZv+XxIkH/MRopjNKZkiBxv28xP0Gqh1KWkjCkcgLPh+2eAtCCY
         x0fQ==
X-Gm-Message-State: ANoB5pl07o8EuSn1CybaO/7u6JibS5wU53pXNxj3zxiK0dnoa9vTd748
        StbG3smF+5Tsth5nKruwxSwW0Mf/fjk=
X-Google-Smtp-Source: AA0mqf70SiEljeo4JZ/5NQc4MxJmeMhHyVdueB5TVaNIYZW6wxcT0gK3DqYOW0wqvCROjX25S23kyA==
X-Received: by 2002:adf:fec8:0:b0:228:d897:228 with SMTP id q8-20020adffec8000000b00228d8970228mr14667200wrs.539.1668628311031;
        Wed, 16 Nov 2022 11:51:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003c65c9a36dfsm2840645wmc.48.2022.11.16.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:51:50 -0800 (PST)
Message-Id: <f254da46a2c2afa74c6fdfd8cc1e2110c70455a5.1668628303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
        <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Nov 2022 19:51:41 +0000
Subject: [PATCH v2 8/9] bundle-uri: download bundles from an advertised list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The logic in fetch_bundle_uri() is useful for the --bundle-uri option of
'git clone', but is not helpful when the clone operation discovers a
list of URIs from the bundle-uri protocol v2 command. To actually
download and unbundle the advertised bundles, we need a different
mechanism.

Create the new fetch_bundle_list() method which is very similar to
fetch_bundle_uri() except that it relies on download_bundle_list()
instead of fetch_bundle_uri_internal(). The download_bundle_list()
method will recursively call fetch_bundle_uri_internal() if any of the
advertised URIs serve a bundle list instead of a bundle. This will also
follow the bundle.list.mode setting from the input list: "any" will
download only one such URI while "all" will download data from all of
the URIs.

In an identical way to fetch_bundle_uri(), the bundles are unbundled
after all of the bundle lists have been expanded and all necessary URIs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 21 +++++++++++++++++++++
 bundle-uri.h | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/bundle-uri.c b/bundle-uri.c
index ab91bb32e9b..5914d220c43 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -577,6 +577,27 @@ cleanup:
 	return result;
 }
 
+int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
+{
+	int result;
+	struct bundle_list global_list;
+
+	init_bundle_list(&global_list);
+
+	/* If a bundle is added to this global list, then it is required. */
+	global_list.mode = BUNDLE_MODE_ALL;
+
+	if ((result = download_bundle_list(r, list, &global_list, 0)))
+		goto cleanup;
+
+	result = unbundle_all_bundles(r, &global_list);
+
+cleanup:
+	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
+	clear_bundle_list(&global_list);
+	return result;
+}
+
 /**
  * API for serve.c.
  */
diff --git a/bundle-uri.h b/bundle-uri.h
index 7905e56732c..a75b68d2f5a 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -102,6 +102,17 @@ int bundle_uri_parse_config_format(const char *uri,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * Given a bundle list that was already advertised (likely by the
+ * bundle-uri protocol v2 verb) at the given uri, fetch and unbundle the
+ * bundles according to the bundle strategy of that list.
+ *
+ * Returns non-zero if no bundle information is found at the given 'uri'.
+ */
+int fetch_bundle_list(struct repository *r,
+		      const char *uri,
+		      struct bundle_list *list);
+
 /**
  * API for serve.c.
  */
-- 
gitgitgadget

