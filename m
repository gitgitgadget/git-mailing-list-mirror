Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB47C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 12:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJDMel (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJDMea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 08:34:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396B32A99
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 05:34:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bu30so1211845wrb.8
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 05:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=IouwFGY730Vi465uljFJ64cZCgmdEAh1cuo1pwddSSpMEXMxgMLBlGqR2nuM8CAOR5
         IIqZDBP9rELadzAWFeB3eHhivT55gxCpAquh7wtIN0TGVyNbu36arWDyDbw+3iRTy50X
         JHYR6J67lrnKDLiHE9jd4qQgMvsRxcicXHmchIfOVBzknbc//t1LO/IQlQHrLyYm8GJr
         ArvawAF7mKjOUH9OwtRKLzLG11r49OAk5VSjHNOqNawUBOrWNuqKwnpSmoRILZ/Wgmdw
         nVEz8q/bZiHqX6vge1nRm+DoIHskdTSCEHn3pilGO9QqN374+w/uz44tqOemhjN4MJxm
         WbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fnuvRU/s4CwFnk6H9aTDmG6Z/zW4bmJU9S4El1WdLLY=;
        b=ybval/sdTWDiDtl+L4rx0aTzq9BuV6v/Me99SRQBMHOqa+3hioDaFl3QO4EKa8qWSz
         7crDm9o8ofNe8ewGdH1LiHmHlHkN007oONjj3amS6anf4cssA+r8a/ZVYKu9DGGCgTY0
         TcM9SGplbKNCOh2NRlQhUHA9w7ZppbIpGnG+PlPa50QTROZqwXcUhPQkZCoA/n2VWBI4
         jEw+lJu/mAXuOBfikkCKvib0SsJpjUIfJomKvkFhmJEH1wFzBx2afunguZh/4FgMuOAN
         8wTF3tQllO8L3zvgmr5pK3xjyDMDwfiYxotOy5PQ/r4X/ZSWgS9Wlwb2hLU8ktG8wtpo
         AEfw==
X-Gm-Message-State: ACrzQf3l16Hae9Zmyo9nnVqS/h+w8hFlFUfsv0N3+ZjWp6udsWi2SAJo
        THcVPpvwvAkE8IsbR2vg2io3YRdYR8w=
X-Google-Smtp-Source: AMsMyM6oldM4Y+hFl+r6qcPgttoT5/6cnj9/G3SVCYNqnRO+lbEIiAn7Eh+ZcOd4quK4JkMtB4S4cg==
X-Received: by 2002:a5d:5403:0:b0:22e:34f2:81c1 with SMTP id g3-20020a5d5403000000b0022e34f281c1mr7617776wrv.346.1664886867439;
        Tue, 04 Oct 2022 05:34:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13-20020adfed8d000000b0022dc6e76bbdsm11844958wro.46.2022.10.04.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 05:34:26 -0700 (PDT)
Message-Id: <cd915d57f3bced015dc154572612d4dd221d1618.1664886860.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
References: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
        <pull.1333.v3.git.1664886860.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 12:34:15 +0000
Subject: [PATCH v3 4/9] bundle-uri: create "key=value" line parsing
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

