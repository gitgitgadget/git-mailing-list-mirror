Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60845C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiETSlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbiETSlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD00377FD
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so12594552wrg.12
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=lOIg9TF27CBJhPQhP1I2w3do2M/6NSYPj6mKiI5KMSY=;
        b=ZnUxo7osX6eF1omuikYmsb4w5wnb/nTFzLOCbnVBjTVGjlJOI7kK9T891i2m/2M9I0
         3zqbi4to950z4jK/CRfMKEXGP6R33JlyXWnWgzZF/TYXHXiDOHt8mEwdZgzqFsBl34/V
         wop09HEB09GVqE0q8mDbuYMYcTnLG41CmAkRi2LOJ16aTauhPI4VWkQGTcYef53SB3QL
         1kZmMBFxCONhKp7/II1vDK4rCrZb63s8sUbLBV4nCWjA5hZgpcb3FKIJbvGBpH/3uMX2
         jsAnAV8yCcJJs0lJcO6/1FCx+X5bNI7NNqDjskb+qO1qIYYGZPrxHEt5ymZqR/KrDw4p
         ROEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=lOIg9TF27CBJhPQhP1I2w3do2M/6NSYPj6mKiI5KMSY=;
        b=7yeLDCkNCbZlab83NxwHLm6ufqqiSfTujm79S4KvJqoA86Ie0EvP4fzUzuJ55W6F2i
         o8J1zG7aSkTLqSPr9QTD6JbEL5Cb8TiPVGti9C4O8HLoPzVw8wxKKEBQ3hspVhjrQe4H
         nopGDNOUGtHwXiK8g/OLycB82to8Si7kEtzZhCilK21hLCDjxCAfsDKIBSc79B8kdXe5
         D/werdkX0jShHcnlecQh6lZn0eCLFZbPtpASjxvfwni/3ocRhEP3PFy+6qZlAzQTOis/
         JroDhs1k+18MWu+MiP1PpTLe9seOXmGTzecnC6u+0IPSn7kT0XtidZXdlxp+xSueL5/f
         sYfg==
X-Gm-Message-State: AOAM5329YUn/ZiSG3Iojaeiz8PaafzvFjbHK4mkXEOFyYZEv+Bhui7lG
        cBJRQtf0+Uaa4eSimDLvuYcKhbp7sY8=
X-Google-Smtp-Source: ABdhPJyHg6e5SL473u/5MDQu+X0L96neg5VQs9bBZEpo6mZPCSWUM6vqfQXJ5wk1NOliNRjkfsgYwQ==
X-Received: by 2002:a05:6000:2ae:b0:20c:57b6:32e1 with SMTP id l14-20020a05600002ae00b0020c57b632e1mr9462913wry.285.1653072056927;
        Fri, 20 May 2022 11:40:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1-20020adf8901000000b0020c547f75easm2994629wrs.101.2022.05.20.11.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:56 -0700 (PDT)
Message-Id: <4e0286f8e20da83c3d111e99eb9f6d9d764a84e6.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:29 +0000
Subject: [PATCH 11/24] bundle-uri: create "key=value" line parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c | 29 +++++++++++++++++++++++++++--
 bundle-uri.h | 14 +++++++++++++-
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index f18bba7071d..948f974c478 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -72,7 +72,6 @@ int for_all_bundles_in_list(struct bundle_list *list,
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
  * is not understood or the value is malformed.
  */
-MAYBE_UNUSED
 static int bundle_list_update(const char *key, const char *value,
 			      struct bundle_list *list)
 {
@@ -300,4 +299,30 @@ cleanup:
 	unlink(filename.buf);
 	strbuf_release(&filename);
 	return result;
-}
\ No newline at end of file
+}
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
index 0f95197744c..344d5943922 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -78,4 +78,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
  */
 int fetch_bundle_uri(struct repository *r, const char *uri);
 
-#endif
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
+#endif /* BUNDLE_URI_H */
-- 
gitgitgadget

