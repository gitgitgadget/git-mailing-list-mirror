Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54903C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbiHVPTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiHVPSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:18:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C48275DE
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a4so13639590wrq.1
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=+WMo1J6aL1DMi2R8hkwa6RiChDV0Yf9lUicNPrOIeHA=;
        b=c/COa3rTH3Mb50Gj7F3tPfZmpq0cPz87dOelHzxJVHmJ/R2IEwx186OZikva78NQCK
         s2xfZacn9fAWP612vQDxiee3+MAy38J3QcwNcB6kXfJ/1TUN8trwJME+wNQ7x34kb35I
         K+XKoeCb1cOkPShM3ezNLTg8pB+VSx7Udu+Fmk0WVkKEIn2e4pLJKEpx5yE57sEHju4D
         yvW8/6M9rE6d7MgRmtrEDH3goU3N8Y2ubuifQZvSVA/h+6geSYoGh144toZs+AxIF5sY
         URG/Jh43X4V4RYcWn9vE1Y7IZUThbHXp/oqiHk30APOQrt3apP3pp4VFWLpPJ1EeEGDR
         ZYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=+WMo1J6aL1DMi2R8hkwa6RiChDV0Yf9lUicNPrOIeHA=;
        b=Ir4+Qfu3uo1riEKmD1wlBVqrSaRsykVIyYj5Fee01XZWPQb7IsH9Zxa9x/OnE2RB/d
         9q0CzxfXPXUQh3sY4uSl+qaWxR/RvTr2qMKjD9CFHsXeY2zJkzoN03IO+tUPAqEC48bu
         w6P7j27iIdfCKtwnGyajMr010hD/2KCMIDycqNWta5HP2e2p8xk3Ai/Q2bSq2b0Xl8Vb
         Ch1uPXR9aq6p9KSiKsDcYZT/yW2j2ACL54kuIM8ZkLFs3LlBqvT8jvyFwRkPhg0JvpIv
         FYl26ypMlZWMCXdvVwGKAw4vN38P8qYtF1QcVV8oiZ5YuGfPv86iJ94XDZ/Kj7VuM//+
         0iVw==
X-Gm-Message-State: ACgBeo3FyY1XAUuFavE57lbygtAEHB2QDnAODG2dwDWlOhvImQxI359O
        iK8hChu9Dtkg1Z+K9fpJ1lK7JX3DfRQ=
X-Google-Smtp-Source: AA6agR629zFra7ipWNiIgul+F80lysCr5LXMG/pyEwRT/2wbjcOM8CnYH10vhw5c0WXOVL/QoipFTw==
X-Received: by 2002:a5d:40cc:0:b0:225:26dc:938e with SMTP id b12-20020a5d40cc000000b0022526dc938emr11529177wrq.297.1661181178789;
        Mon, 22 Aug 2022 08:12:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b0021e42e7c7dbsm12012797wri.83.2022.08.22.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 08:12:58 -0700 (PDT)
Message-Id: <49c4f88b6fd804f0bd5c62d523b45431846f4cee.1661181174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 15:12:50 +0000
Subject: [PATCH 3/7] bundle-uri: create "key=value" line parsing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
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
 bundle-uri.c | 27 ++++++++++++++++++++++++++-
 bundle-uri.h | 14 +++++++++++++-
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index ade7eccce39..9a7d09349fe 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -71,7 +71,6 @@ int for_all_bundles_in_list(struct bundle_list *list,
  * Returns 0 if the key-value pair is understood. Returns 1 if the key
  * is not understood or the value is malformed.
  */
-MAYBE_UNUSED
 static int bundle_list_update(const char *key, const char *value,
 			      struct bundle_list *list)
 {
@@ -301,3 +300,29 @@ cleanup:
 	strbuf_release(&filename);
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
index 6692aa4b170..f725c9796f7 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -76,4 +76,16 @@ int for_all_bundles_in_list(struct bundle_list *list,
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

