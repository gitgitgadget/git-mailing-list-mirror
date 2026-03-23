Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBBB370D45
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253150; cv=none; b=eHnJKM+KG7h1KJJjjhhJysD5FG1D51oYlJTwDlCxFnSNDFABeANzCxcWMrMqeM280cLgWAKTpFPZkdEFN4nilnxq8lgBBOkrMTIDufRCWrwFW8uEv/chjyJ8O1rHj5QIuwyanGOMkkfeyCbRzXbbhScBZzTCVc6NcXnX4rDlbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253150; c=relaxed/simple;
	bh=QBBy//dbC+9cJGU11cKj+s6NJRAd4Rf/akpaWl7EagU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X908O6gtvf6TTermzBMjALu3rPgKKqZbOrYyeBMofXS/EyWNW6eswvhaJEa/81lMcBSDytsc9shOmM7Zd23VB2E+D/35UE6N+ynU+CK+24/0vNzfSKb6Ur3dYs1o/p1SobeDLCx0cRSPTVtUZ0xtTyOyM1SE1p7dPcwfSy0adoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0/b31DU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0/b31DU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35651565e9.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253147; x=1774857947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehUxgAyai8s6KwYy8BNNJqLv+ObyJJTXyCqnKkqglHI=;
        b=R0/b31DUhqBQ8aCjKgi8zrrJKV24BBIjMxSQPIW6m0vNvJVDvDhNMDVwaR6s2yKLID
         IH7BbklIFqa9BGJ7z4krZGmsXJjUdieIyMJjAQpEQIi2NPgKClTjwR9SmdTMqBT+9j+4
         EysGwHi62J2r9h+ZXvJhAg4pwY2G0qAcVsRR769C1LKdKSAZX7nN4Bdi52FpBN37uQCU
         8CWSev3lhmruf9mIVYS71kELdUPrWd92U7A38Zaum/nrLUPSxf7AWOhD0scIiEFxHgbc
         14ZT6r20+TFn+uPa7eim+liMQCIUmToFhlsYPlehXYOaQzMrpQWw48EOpOIdnDn0qHnK
         RC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253147; x=1774857947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehUxgAyai8s6KwYy8BNNJqLv+ObyJJTXyCqnKkqglHI=;
        b=R3yTkt7R3WVTx+TB8P80onVCM2FQPh5nhrtICw6HQCS0H3y993F9i4Pbf+8VSYppBA
         Xa2i39gDx+xaDymfif3g7imssp6aQDrEFVTwMiSl6tDZZ7fs9lFm9uGM46Y4dMCQJFet
         fsg890inihSdMwpW6NKLwEAhw/NHEowooTw39GuSkdFyn84pts3Pf6AaYTPqPRHIn3vw
         SBMy8vSU+CFEo9jDIneWSg5MoceIHY51qZAhYx+NNNlgmfT6eh5PiengZa51Kwc/oCxr
         23u6yCUEfdPAkVnV+2RuV05ANxKHYQzmlO183Eo3XIqpoOvnoHlFa+PhH9eObU2nczcp
         pQig==
X-Gm-Message-State: AOJu0YwubC7ancuLtAG81hcajSW2wXgw2tb29WsVE09niZ/ldcNRjFjP
	hRKFRk4KfMDheK+IM30AcCOD0DlER7XqdcGuAB1da+p8oBdicdp1Sj+Ddp+vXQ==
X-Gm-Gg: ATEYQzxSCiI7uOtSGT1fmAkqNs78XpmYE/wSUyJT2D/bfZDO9OeOeW6GJDQBxY8w+VO
	410WLscTbXTwg9n22sqOSiZC1uQH2GR93i36xKhU6blyC8j0FTmLOTWKvJ3SZo6gna8ABUgnTgz
	xi8bSUlHeKNr4lIXyVSecgdrwsR8fw+Pwq+yCtzXqVwRIn5KIubaN40cTLj8cXim+QrmwSsBuKS
	1uKwSjhNa9HoiA8PSYOCjVLu+R7TVWkR8q84M5EW0R+J/OG0OexaM8vOTkYFFfETn5ABORfvYIr
	fg0puI0tsfEKnchW31m6vbFvnaa3heK3cz6dDm7Cl9opXnwMRlfvn4z9fJlDhZ72m7/DxqkO7/9
	fCirek37Z7+cISxFxEYO+CxRUDfeqyS8PjEXxZJojyAkHTd2keD290/K6AUQie4+bAmMb8IPlYs
	9UyQSjTIWh70PqrGd8XryafGFRsCry5gqVgyFvUdtiGGWeUbojVG7qgtVUbml64B3lCereo4HXT
	fAP23nFtVEGPY7m3PrzxmMRgDf5H1XuzvorlFY=
X-Received: by 2002:a7b:cc03:0:b0:485:6e55:28b0 with SMTP id 5b1f17b1804b1-486f8b72044mr189594675e9.12.1774253146777;
        Mon, 23 Mar 2026 01:05:46 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/16] promisor-remote: refactor accept_from_server()
Date: Mon, 23 Mar 2026 09:05:09 +0100
Message-ID: <20260323080520.887550-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we are going to add more logic to
filter_promisor_remote() which is already doing a lot of things.

Let's alleviate that by moving the logic that checks and validates the
value of the `promisor.acceptFromServer` config variable into its own
accept_from_server() helper function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index eda38223b9..3116d14d14 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -852,20 +852,12 @@ static bool promisor_store_advertised_fields(struct promisor_info *advertised,
 	return reload_config;
 }
 
-static void filter_promisor_remote(struct repository *repo,
-				   struct strvec *accepted,
-				   const char *info)
+static enum accept_promisor accept_from_server(struct repository *repo)
 {
 	const char *accept_str;
 	enum accept_promisor accept = ACCEPT_NONE;
-	struct string_list config_info = STRING_LIST_INIT_NODUP;
-	struct string_list remote_info = STRING_LIST_INIT_DUP;
-	struct store_info *store_info = NULL;
-	struct string_list_item *item;
-	bool reload_config = false;
-	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
 
-	if (!repo_config_get_string_tmp(the_repository, "promisor.acceptfromserver", &accept_str)) {
+	if (!repo_config_get_string_tmp(repo, "promisor.acceptfromserver", &accept_str)) {
 		if (!*accept_str || !strcasecmp("None", accept_str))
 			accept = ACCEPT_NONE;
 		else if (!strcasecmp("KnownUrl", accept_str))
@@ -879,6 +871,21 @@ static void filter_promisor_remote(struct repository *repo,
 				accept_str, "promisor.acceptfromserver");
 	}
 
+	return accept;
+}
+
+static void filter_promisor_remote(struct repository *repo,
+				   struct strvec *accepted,
+				   const char *info)
+{
+	struct string_list config_info = STRING_LIST_INIT_NODUP;
+	struct string_list remote_info = STRING_LIST_INIT_DUP;
+	struct store_info *store_info = NULL;
+	struct string_list_item *item;
+	bool reload_config = false;
+	struct string_list accepted_filters = STRING_LIST_INIT_DUP;
+	enum accept_promisor accept = accept_from_server(repo);
+
 	if (accept == ACCEPT_NONE)
 		return;
 
-- 
2.53.0.625.g20f70b52bb

