Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC21FFC51
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961540; cv=none; b=Rt+YUq+QnI5Fre/Ui4NAdgUVV6P16fbu6nFtucwB/YzVmAlMT7fkEt5QlW5wyEE/Li+P5tVrHQ/Agg5Ii/1kHXFlPkUdHEEZm3N59sbfnJzYKBrBRD19EV9HfMcnYnfUHzWWLb0qrzGuTkNXQ8v8etaetcQYB1yJqodhVcpAMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961540; c=relaxed/simple;
	bh=W4bImaph0citfsukAEAATRJt1Kd8N7BrEMA/baDGg8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipkPl/UM0eRMN0zb6mrG0Su7W562c9h/F3ijNOa3NwjiJG9qJgbnxIowbF3wuU93R1lg/z70O9hsnT54lASjLVD6GIKYA0DhCvgWNZg04uVWfatQ8PxuVH3bT3FcpGX3Tc9CqB5UuxFjHDncOegcHdORXYCHb90/zq8FzCuDzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/G118VY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/G118VY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf257158fso14713495e9.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741961537; x=1742566337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9sbKceYibewCEsf+1vpBKWJ6b8kluoQ9iPfK3wbyXo=;
        b=F/G118VYKH8WluNHmHZNxEyTIhIb5otdsHTbB3xBW3mH9ObrbXe1TbXLtr5DKeSoKN
         mWe93gsERALw4DRSg455LFqlCv62v1Y5t0fujEHyw6We0ByL2UI65oCgUUA28mTI7sXX
         GSzePMKcXJYdi+Jz4Myywnayl6HCQZsmpUzP441wgrLCPIwVx200m99wecGrMeTEeeRE
         DayiSzFt8Nz1m9/0brZxm9yZeEJy65nZO7hsfdcBzQycZu5zoDv2Gt0ol8DROY5cvcbJ
         LbXakPGDzAIunpg5EtHqLhhQ+lJjEHos7nvNoPxC5mefoVYwjAWiHKexCf3Kc/qdoy06
         zP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741961537; x=1742566337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9sbKceYibewCEsf+1vpBKWJ6b8kluoQ9iPfK3wbyXo=;
        b=aLoxcr8un3orW1ilbfcMO4o/VeaX3CrER1OYky5ZShryHCiWZeeBE011IVtHM82RHH
         ohTuhyWF0Tn6kOcTBdbNbu4g45H7q7958rCyEZ7XmdVZkJW5Z3o8+Up6FYHYTzz1JvpY
         +eCA8OSXz6NTe3P5Jn2heW5Pp1QrxlGMWE/rcruSO9a9IK6HtImqqQqNe4IPeQlbkYpu
         ZAwAxPVndL+KRYbSbXaMmhtl0FMq1vxKAOkCMEzC3pomIU/HmxYKCzjT+Mk8cmQQGDre
         e2zbPUgQs59OiJIkTeD9mttBWIto3pMXEnXYQ7ah2881zxVf29EVkf2hdV7tcDJImxJz
         sXww==
X-Gm-Message-State: AOJu0Ywenugz9acwoSyJMRNBIlwDXqrDzXyQ4AlyEK85zahlYSvSapkl
	BIxYhlDvDjKXbLWL402aswm4r8PFedDwPEWzdFOfo2Tf6r4TkFsj50ZNXg==
X-Gm-Gg: ASbGncuojv+9lYvNLvGP8HKG7Ybjd2DUkOkECyPLLwfwklUqLjUq8xG5HI8opRs+KEw
	gQD8tgJe54kVysFR1VumARCi5Ie+iG/CCJLnAZhWc79lpjvb0vYHWk5ZAOFtVR2D4XQWRC47JVo
	HnxIv28IB83zDJR+dgKz7S9CzyJzH7IuOkZb0syCsUOMAu7kuI6O6j5W37dKITF+ZiIqiiujDrp
	WmZiZdhl6aNI88W1pIyuv8jvvbC/r65eKqM4uAFL+EqtMtTA/U7eoknjeRk8QVv3Z4hTqzEM/gv
	CAwvysXIP6w6Utjp742fwGDGASzHklnKqZFtjpU37cXeIqt0pfNTAW8vY+w3RJ2oek1chGnBjhV
	mAQ7+wJrFCRdAPfusst6dMNZhom4=
X-Google-Smtp-Source: AGHT+IFim/iq4tFF/Zj8E/jCOs/ygIORslcrienQ5sBgRF2w7TSI7Y24SchUcm+FTyuJRXuihmxWuw==
X-Received: by 2002:a05:600c:1c81:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-43d1ec90771mr25368985e9.1.1741961536739;
        Fri, 14 Mar 2025 07:12:16 -0700 (PDT)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe3a8cdsm8418255e9.2.2025.03.14.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:12:15 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/3] promisor-remote: compare remote names case sensitively
Date: Fri, 14 Mar 2025 15:12:03 +0100
Message-ID: <20250314141203.2548803-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2.36.ga8a9f9b33b
In-Reply-To: <20250314141203.2548803-1-christian.couder@gmail.com>
References: <20250313103859.817127-1-christian.couder@gmail.com>
 <20250314141203.2548803-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the "[remote "nick"] fetch = ..." configuration variables
have the nickname in the second part, the nicknames are case
sensitive, unlike the first and the third component (i.e.
"remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
but "remote.Origin.fetch" and "remote.origin.fetch" are different).

Let's follow the way Git works in general and compare the remote
names case sensitively when processing advertised remotes.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc | 4 ++--
 promisor-remote.c                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 9192acfd24..2638b01f83 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -26,5 +26,5 @@ promisor.acceptFromServer::
 	server will be accepted. By accepting a promisor remote, the
 	client agrees that the server might omit objects that are
 	lazily fetchable from this promisor remote from its responses
-	to "fetch" and "clone" requests from the client. See
-	linkgit:gitprotocol-v2[5].
+	to "fetch" and "clone" requests from the client. Name and URL
+	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
diff --git a/promisor-remote.c b/promisor-remote.c
index 0b7b1ec45a..5801ebfd9b 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -370,13 +370,13 @@ char *promisor_remote_info(struct repository *repo)
 
 /*
  * Find first index of 'nicks' where there is 'nick'. 'nick' is
- * compared case insensitively to the strings in 'nicks'. If not found
+ * compared case sensitively to the strings in 'nicks'. If not found
  * 'nicks->nr' is returned.
  */
 static size_t remote_nick_find(struct strvec *nicks, const char *nick)
 {
 	for (size_t i = 0; i < nicks->nr; i++)
-		if (!strcasecmp(nicks->v[i], nick))
+		if (!strcmp(nicks->v[i], nick))
 			return i;
 	return nicks->nr;
 }
-- 
2.49.0.rc2.1.gf94452eaa2

