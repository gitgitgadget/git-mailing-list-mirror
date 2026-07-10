Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5F43B48A
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701699; cv=none; b=CMq8iFv+wEDHAJVajibaL28ZrjAoCGmUF53IvAlgwIL1YsdIvkD2blKIi7OrHgcjBHxpk0eELoNkMpYAwDm8VwaRjlyj8hTCZubAMm2bK+pZgkM3cyoar98ub0DXZOP5rBq3tpuZ576xIT1//e/Oj9XXnrokwFIeQdL/ia56SY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701699; c=relaxed/simple;
	bh=zIPQgXuM+kSMB+p/l8zBj3xeUQuJCD35A8pJAP0Lv1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVLF95JKy+uk54R++H5mbYun/s10h3OrX72ecv7qhJ6CIzWmcBFWsH2CkqnQieOjpNQeTeTJ9f00YE/TfUnn1bfTJjjbOjxguuW8vRhv2h1fG573dsmonm4UiIdPrhB4o4nQUYVy082qhYRlGUtF6jVUtZWToMAyAA6cuxISGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXY4zwvl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXY4zwvl"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47d6c634f45so713832f8f.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701694; x=1784306494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=mXY4zwvlPGzhcpavPZG2SZZdMrzPqvbL9hqiBSz+UiV1Sx5Ve/lvEsfp1SpBKy33pX
         Z+U0sxWTA0oX/ziU2oNahvstRk4uQVncPSUADd6jjTWhywhs3vWqc4lX9DXsCuNmtwoZ
         h11dIcIS43jQHy7A+vP4ihX76F3OoxHTAblxfUhfvqyxvN205ZpWuQ5Ph+tcDb/U/BEZ
         7uOiP7VDTzT6Z9x7+VxN9+fLOrZKWs7Y7nTCJFfCvpqcUVGhTMSb5MuUb12ifugBw6d4
         iFZH2Ji7aF+mvhySpB5wGwvzQPINfJTDaKjBxzgzu7rQ9MHytdpB3nPVB12AIYlkwhcj
         fEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701694; x=1784306494;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EGIlaMlC6bUm5CEAU3RPpqireG7fRDCnfzf9/p4On4=;
        b=CSlt536NCxcaeBGGcFtHZy9y4jx3cb/D6jhcaq88nQ6dXFS46CRnS8syXMHsYVGrry
         xj1CmOMxQgxMq+jK5FBANndzK5sEIFQxSZKgpzWnGnYHRuQTSAXIzp/lSSRXNpRKaWcy
         tmfcGB39pVGDhX+yQkJDeQ0kOOFu9Lfw3JWRrLn9uHFd1S4b8MCYAeK/xGtYzUV0j3wr
         mDmIWyZPPfRlLB7wukHZOof5JkbqOe5lrb6GRQ1yf+gM9/5XdxU7rNiGLzCGJK/3UlAX
         pzLjzwBVK7vbf84bQ+nShUcmkzrcRIM1sU/pPctxvLOYS4vvIvZaKDRAx9thGdJafIwc
         bzHw==
X-Gm-Message-State: AOJu0YyUulwCASvauTQGLR3wqmkze7iKqkDLKg6eEN53hXtByiWBFm9d
	oaoo/L4ktHlnAQIbOUCfFvKw4E5W6oLQ5jXsNViOeXrcy9IsM4BtJODAAJ2woPHf
X-Gm-Gg: AfdE7cnoQsSNESE4nhQR7nyFa5p6ttkCKXQgzNeXmErctCTofIXOgQzmnfYJEJapFEi
	DiQSLb3gkYzdAe7nd2/q/ndU37lH9kTmRjF4dquaVr89y34J9XtEDDZuX29M/IFaNtpupYisaQn
	chkrH8MiGnsOFGoYVReuslzQWhYAiJRYVJUqSdRNr8Ehn5lEeYe55XBrbugwWCSovjtpfaXLh4u
	ogUTxInroIgaaGRf0cXu5t3muNEFyU3+iHAl+3pv7LUS0Tx9z8Qdjpjn2j/cIOKvg94uEeDmozR
	7lYHFew3VFv5J+f2Qers3KGTwB3if5fsasLLTVBvhQJHrMRQj6UD6EXpSRUt0A9uJMUIV6ZGCVw
	UWMRkPmOhjLhDLHx62rUM1V637hsZjStB1dNefGwgE3zRvnDWcV+HsRtwwIBPrd61xlj9OGe+Ng
	rQzB7yXpEbGcOVf7iS+4jw3xcPuhew0q8CqjORfmdVAzKsiLhGdcuKqeq7ZW5K6k68KMvueLQP4
	NTxL+wGN0UeRp5JWRJWrs3HCgiTM/862hJwbs1szOovvMsEJmg1vQNGYjbtPx7+8VTkp4wq8ZdL
	QXBeVSEyaWeRzZsFtFm9+hRkBAQBW05kAMc5hi0pSlhKRjmAYfLA38398DrORQbv3p50sVzt5Vu
	izGMOso4T2YZWKpS27qb1
X-Received: by 2002:a05:6000:230d:b0:474:8aad:2e0 with SMTP id ffacd0b85a97d-47df071c082mr13486338f8f.9.1783701693686;
        Fri, 10 Jul 2026 09:41:33 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm63643639f8f.2.2026.07.10.09.41.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 09:41:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v16 09/13] serve: advertise object-info feature
Date: Fri, 10 Jul 2026 18:41:15 +0200
Message-ID: <20260710-ps-eric-work-rebase-v16-9-66e07b58a8fe@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
 <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This allows a client
to decide whether to query the server for object-info or fetch as a
fallback.

While at it, update the object-info section in 'gitprotocol-v2.adoc':
- Require full obj-oid explicitly.
- Fix parentheses.
- Define obj-size explicitly.
- Make obj-size optional in obj-info and document the behavior
  for unrecognized object IDs.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 11 ++++++++---
 serve.c                           |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 2beb70595f..d3530c52ea 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -568,21 +568,26 @@ An `object-info` request takes the following arguments:
 
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
-	information for.
+	information for. They must be full object IDs.
 
 The response of `object-info` is a list of the requested object ids
 and associated requested information, each separated by a single space.
 
 	output = info flush-pkt
 
-	info = PKT-LINE(attrs) LF)
+	info = PKT-LINE(attrs LF)
 		*PKT-LINE(obj-info LF)
 
 	attrs = attr | attrs SP attrs
 
+	obj-size = 1*DIGIT
+
 	attr = "size"
 
-	obj-info = obj-id SP obj-size
+	obj-info = obj-id SP [obj-size]
+
+	If the server does not recognize the object id, the response will be
+	`obj-id SP` regardless of the number of attributes requested.
 
 bundle-uri
 ~~~~~~~~~~
diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
