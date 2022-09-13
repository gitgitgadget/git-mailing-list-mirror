Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A6FC54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIMT0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIMT0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23A72B55
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36so562298wmb.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=SEIrIWSvchzYGJ1jiEGsC50LyAYDFjVOJpzFYRqqQrI=;
        b=DIRB6fg0XiYDzFjzLVd/XGOo7xz/92SBDxd8To16kMt7rCWaUTTw/JU0J+cmb3RtfH
         ELsxzoQOAK39Z9sBzdH27ZnABm2Fs8jG7YBthb9S6hU51o+voYpv/FmxDA7+h1bJ0gQy
         pSF78Vk5Lievq2Z5J8njAunonF7Qqm/IKWvEaet2SygoEgzJXUdQwxzYGbLPIrpMqO9X
         GSgPC35B4WpHkDtI8BdhV8+6T0iL/xGX1K5lDWzL+4Wd/E5UAxB/7YRr/tpP88+aH8nB
         Dr+Kt/ZaTJMIwnEOasHTLb35uuQlQ6uv6m4fHvZBrnhk6f/1iNSydtRnbcbQWoyDeAQK
         LlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SEIrIWSvchzYGJ1jiEGsC50LyAYDFjVOJpzFYRqqQrI=;
        b=35AMgXb2C12XmR1FhhorsSNvKs6j1/jreCAnAvDTYZdRC7HznYdLZyNgoqen+p5H2n
         Zt4OSKrj1AhVKaKBvDUcJ+EFeyJt2cXM+XLGRH2xSbwa/8dHBtQ3sGYJ1rclniiSLJyM
         LEZ1N57NmqFqL6+/r6Uq+8xsopnTUwuZDaH11VpsMPNeVPG/x2Ultn0yd5+aOXUskwku
         vD93W7nVH6FnJqkbhgoiBld3k9U+GBNboXfrBJ2haoH9WqaU27FPTJZUnzsAoGEfAauZ
         twCQ9M797L6EmxFuWdP9mfQkz+wKOwXwayfQqtqR1fyczmWdt7xhdgJnCaSrNx1GG/X3
         PGhA==
X-Gm-Message-State: ACgBeo0S89glql/WbM53pMt4QxVbxZlv2nVxUmc3KpBFaxAsUM4AuFqy
        VnW6EnNDGJfdZ8g5ilRGoYzTqh+K4vQ=
X-Google-Smtp-Source: AA6agR7QL5tTANTxJBX0xyZgYCzb/pu6rmy2MYRp+1DEyfUUhluoSEBaVYQGpYyjFTQ6y028BZv32Q==
X-Received: by 2002:a05:600c:3c84:b0:3a6:9596:fa1f with SMTP id bg4-20020a05600c3c8400b003a69596fa1fmr602756wmb.162.1663097164482;
        Tue, 13 Sep 2022 12:26:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11-20020adff18b000000b00228daaa84aesm11433305wro.25.2022.09.13.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
Message-Id: <cae7180bc37663e0499fd15fe36b39e70b046d35.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:55 +0000
Subject: [PATCH 7/8] http: move proactive auth to first slot creation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Rather than proactively seek credentials to authenticate a request at
`http_init()` time, do it when the first `active_request_slot` is
created.

Because credential helpers may modify the headers used for a request we
can only auth when a slot is created (when we can first start to gather
request headers).

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/http.c b/http.c
index 42616f746b1..8e107ff19b8 100644
--- a/http.c
+++ b/http.c
@@ -514,18 +514,18 @@ static int curl_empty_auth_enabled(void)
 	return 0;
 }
 
-static void init_curl_http_auth(CURL *result)
+static void init_curl_http_auth(struct active_request_slot *slot)
 {
 	if (!http_auth.username || !*http_auth.username) {
 		if (curl_empty_auth_enabled())
-			curl_easy_setopt(result, CURLOPT_USERPWD, ":");
+			curl_easy_setopt(slot->curl, CURLOPT_USERPWD, ":");
 		return;
 	}
 
 	credential_fill(&http_auth);
 
-	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
-	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
+	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
+	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
 }
 
 /* *var must be free-able */
@@ -900,9 +900,6 @@ static CURL *get_curl_handle(void)
 #endif
 	}
 
-	if (http_proactive_auth)
-		init_curl_http_auth(result);
-
 	if (getenv("GIT_SSL_VERSION"))
 		ssl_version = getenv("GIT_SSL_VERSION");
 	if (ssl_version && *ssl_version) {
@@ -1259,6 +1256,7 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
+	int proactive_auth = 0;
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1281,6 +1279,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 		slot = active_queue_head;
 		if (!slot) {
 			active_queue_head = newslot;
+
+			/* Auth first slot if asked for proactive auth */
+			proactive_auth = http_proactive_auth;
 		} else {
 			while (slot->next != NULL)
 				slot = slot->next;
@@ -1335,8 +1336,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 
 	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
-	if (http_auth.password || curl_empty_auth_enabled())
-		init_curl_http_auth(slot->curl);
+
+	if (http_auth.password || curl_empty_auth_enabled() || proactive_auth)
+		init_curl_http_auth(slot);
 
 	return slot;
 }
-- 
gitgitgadget

