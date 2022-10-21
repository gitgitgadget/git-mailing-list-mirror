Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E716C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiJURIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJURIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:08:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC1F285102
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so5918930wrt.11
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTgFRH8NvEuDL6qrOKVv8nBrf31Xj7wIMu+UBji2a3E=;
        b=TXl84XvHBUhNXeXInNFq2P6Tqc5C1Mkjlym5CFcYFSNLCK+z3urrq3xPHfDb61osDG
         vsnTvw9C1nUltMKmjkNO9LgMRxHAPTVvKoTZPBUy209T34NUeFtusn2jyk7vpJ+qWXQI
         NALzdKNex06pV+ADSGyIhu27D1Tjs6ITnPgs/aX+QsCZ8z6XPWTIrHKbCaJBqwO3zODY
         +CFJyZijSYMScnwrZHHStLaRa3kJd2Q3NzfnxQmLhhWtOqD4wnLPji7pomT0XFBJI+5R
         6ChmAS9mQFrVim8WCc/vU7WUJi+aDp/YfMlvlIzC4Xlu3Zfm6ZohIHaUeht/13mwMdRc
         jgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTgFRH8NvEuDL6qrOKVv8nBrf31Xj7wIMu+UBji2a3E=;
        b=yW6DKGeAH1tcfF/OwbHHMJEeSwnSG64XPqa6DOYlRIumGVp3qHvqcMjWsDp7Gsv9RN
         HsYia4UJgBYDDcIQNqn6hhZKbJd1g2gclJa+cV/5duBk9ofiJcW7wte9hrjGx/IJsiCb
         mnZ02NE5Q0WL/4r8ndouVZjZ5GT23mk71W5o6N4msDgeAptVekbUIasxPhUiNGCYEtxo
         7UQt20pFleGPA5n3XKXzMXGKZqE5G8gLXnXXpJhOE+4SqoYRCdSIcLWPtQgSRSebeX9H
         CmOBsdhMdg6PK6fsErETJDQ3S0huM6YdcyEEF6vWavXj4mvncQkOjy0BOIE8ARwdaExE
         vt2g==
X-Gm-Message-State: ACrzQf3mVmX6EyYEkhFSXaD1pOfM/dJBhiKhVuh1gpRGdf69jN3RvrX0
        rPKobpGEZPCS6G+xHcq7izO8f/WZ5wI=
X-Google-Smtp-Source: AMsMyM4vDhw+m5BphaEkUnPg0S68i2P70M0gnmcRitZUeO97PlBc8D2U/KsroAWUtqNe44E+ncfqcQ==
X-Received: by 2002:a5d:6da9:0:b0:22e:53bd:31c1 with SMTP id u9-20020a5d6da9000000b0022e53bd31c1mr13999568wrs.358.1666372092918;
        Fri, 21 Oct 2022 10:08:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003a83ca67f73sm3302882wmq.3.2022.10.21.10.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:08:12 -0700 (PDT)
Message-Id: <a790c01f9f279bba227a8a27077e54b95fb991f7.1666372083.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
        <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 17:08:01 +0000
Subject: [PATCH v2 4/6] http: move proactive auth to first slot creation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
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
index f2ebb17c8c4..17b47195d22 100644
--- a/http.c
+++ b/http.c
@@ -515,18 +515,18 @@ static int curl_empty_auth_enabled(void)
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
@@ -901,9 +901,6 @@ static CURL *get_curl_handle(void)
 #endif
 	}
 
-	if (http_proactive_auth)
-		init_curl_http_auth(result);
-
 	if (getenv("GIT_SSL_VERSION"))
 		ssl_version = getenv("GIT_SSL_VERSION");
 	if (ssl_version && *ssl_version) {
@@ -1260,6 +1257,7 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
 
+	int proactive_auth = 0;
 	int num_transfers;
 
 	/* Wait for a slot to open up if the queue is full */
@@ -1282,6 +1280,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 		slot = active_queue_head;
 		if (!slot) {
 			active_queue_head = newslot;
+
+			/* Auth first slot if asked for proactive auth */
+			proactive_auth = http_proactive_auth;
 		} else {
 			while (slot->next != NULL)
 				slot = slot->next;
@@ -1336,8 +1337,9 @@ struct active_request_slot *get_active_slot(int no_pragma_header)
 
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

