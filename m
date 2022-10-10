Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C2BC4332F
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJJQEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJJQEe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:04:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7478172FDF
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so17674375wrm.12
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=WUiOUNLglp6rtwXSxD51UNKRDZ4tud6L/+JfphF8oMu0WbyZLKt0XTvgkVi3pyHgGF
         o2YiyGS0ticC5WRzbXxxuuwoLyUtPanoOoIDqKQYtF6SHx6sPdkKebfF0eiF9+MCg2De
         pkH6evkkdzcDZI1NSCDOKxf6zsAIc1h2XrK2BDrwIW3mcE6U6A+wIUFwtslna0GhUFfa
         yD4GKiqoHu4nnUSOjOHGMJgt2qk979Bmx1JMHhiU7pSoPfm6ckUImGZrdg4SFadMqYH+
         BxJC0eNJRb0+xiCdTvZ4qA2Y81wfnEKK1tfefTJvgVL3+v378FnC96jnZFY7LNWvJOgG
         V6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=3CXiUc4hRM1YhAOg4mjYqVig78HnHTvSmEJaI1dPTHwgzk/tKJgURR5vBL6T2HAJUx
         2S1bnWJNMx37aufPrcOYJrUBSIGcznQ2oTJMIoiGBzliZP1wuBQEPYmsam49Ht5vTatK
         vhKkbiwK2oL89K7IohCJkGKB6ttBADgy5SItsnvcFekklVqlr4V501z9spEIZsjZX3N6
         HnTeksH9E1YV7zUgzpaES6POhnxnWQNTQcixGaFhob5qrt5NPI8nZypuOQyjpTnmQ+Ch
         tXRc93CDNfTApaaJxzyHvRxRy2b5GL9HEOAsoUgwX8jrn1XyLM5WHZ6VD8dlcIfxr4Kv
         qvmg==
X-Gm-Message-State: ACrzQf3r4IteHjq9B6BYdPCpsL9Vn+861idEVgaozD5v1/E+6gr6KffA
        P8ocRneOCNV9nHy4xgCkphwmPC6QIsg=
X-Google-Smtp-Source: AMsMyM53Siq6Vbgk9ckQ+3XWs5FmP/feCymQVYjDBp4c/HEG/e2+S/qu+Yz1tm23O2kOc1MG3oiXEQ==
X-Received: by 2002:a5d:6e8e:0:b0:220:5fa1:d508 with SMTP id k14-20020a5d6e8e000000b002205fa1d508mr12798840wrz.337.1665417866287;
        Mon, 10 Oct 2022 09:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020adff386000000b002305cfb9f3dsm3243305wro.89.2022.10.10.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:04:25 -0700 (PDT)
Message-Id: <cd915d57f3bced015dc154572612d4dd221d1618.1665417859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
References: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
        <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 10 Oct 2022 16:04:12 +0000
Subject: [PATCH v4 04/11] bundle-uri: create "key=value" line parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

When advertising a bundle list over Git's protocol v2, we will use
packet lines. Each line will be of the form "key=value" representing a
bundle list. Connect the API necessary for Git's transport to the
key-value pair parsing created in the previous change.

We are not currently implementing this protocol v2 functionality, but
instead preparing to expose this parsing to be unit-testable.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 27 ++++++++++++++++++++++++++-
 bundle-uri.h | 12 ++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 0bc59dd9c34..372e6fac5cf 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -71,7 +71,6 @@ int for_all_bundles_in_list(struct bundle_list *list,
  * Returns 0 if the key-value pair is understood. Returns -1 if the key
  * is not understood or the value is malformed.
  */
-MAYBE_UNUSED
 static int bundle_list_update(const char *key, const char *value,
 			      struct bundle_list *list)
 {
@@ -306,3 +305,29 @@ cleanup:
 	free(filename);
 	return result;
 }
+
+/**
+ * General API for {transport,connect}.c etc.
+ */
+int bundle_uri_parse_line(struct bundle_list *list, const char *line)
+{
+	int result;
+	const char *equals;
+	struct strbuf key = STRBUF_INIT;
+
+	if (!strlen(line))
+		return error(_("bundle-uri: got an empty line"));
+
+	equals = strchr(line, '=');
+
+	if (!equals)
+		return error(_("bundle-uri: line is not of the form 'key=value'"));
+	if (line == equals || !*(equals + 1))
+		return error(_("bundle-uri: line has empty key or value"));
+
+	strbuf_add(&key, line, equals - line);
+	result = bundle_list_update(key.buf, equals + 1, list);
+	strbuf_release(&key);
+
+	return result;
+}
diff --git a/bundle-uri.h b/bundle-uri.h
index ff7e3fd3fb2..90583461929 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -67,4 +67,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
+/**
+ * General API for {transport,connect}.c etc.
+ */
+
+/**
+ * Parse a "key=value" packet line from the bundle-uri verb.
+ *
+ * Returns 0 on success and non-zero on error.
+ */
+int bundle_uri_parse_line(struct bundle_list *list,
+			  const char *line);
+
 #endif
-- 
gitgitgadget

