Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318237C105
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113605; cv=none; b=AiS3f7RUw5C4d950sFuoaw6LeyjmLKLgBeoAnAQvforbALpLyHHy04m0dB0EtIEMycwEWYWVQRObf9ZDXAAB2aQF6jZXmMsw9XeuBKQ/KmKH+9odPuHLkEbrdGY5srTKcCzeWjjmRjoxxDpLxkjZDbgrNciWj+8fkU6xKUP3nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113605; c=relaxed/simple;
	bh=O2LHw9raOiY9ltrnNueMV0NQyLQl0TV+V30RAbtgHyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLFpMqFkSr8SUKT3rRjz1/vbahGzzyUd+og30EnppBrmZSJ8w6XbYwLsFArA9wP4N+UVACJnCaKIBiyEkJM7OfR787J20NZxTReRqKKf1DAMgAyOpn7R2XZLoQoSmESSLlaSX67miHQAslrZUzCDHpMRc590pYmC1Asa5LFjMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnC2q8l6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnC2q8l6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso4685415e9.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775113603; x=1775718403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yS8/0MYk2H8nPFixHgV3T6rntyoLovsGDbbxhKKM7Fc=;
        b=dnC2q8l6N4E47io2gGxfuzUoPTlo26pBdp+OooZz/tz6uXgp3KD7IZIpTb+BTv/l/n
         Qp+MHdnpAfSXwbQnd2ve6wmplupZH7c456+Y6znp7FL9KQTDAYYAb9WJQBp23jBWy33u
         YijX3kXNTxZzdL006dYHlVv7YX8tcTMIcWQJYsKCDM7/ml1ALP+cQ2MgDLiBNbmYJ5TN
         fvVWvwCjyeIgzeM9oE/SMhAkHLQu1Y0oV2qmd3BteZLkT4rq40FWtv/weMsoBBEtDo+l
         x/uoyJYecWgUfsvR/tY0rqyqzwA2t/caeNK3tVqetVyobQCGduytdDdMMvg35lN89wMq
         WMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775113603; x=1775718403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yS8/0MYk2H8nPFixHgV3T6rntyoLovsGDbbxhKKM7Fc=;
        b=jfHK0nAigempZpHntxz3CR9IORr6UnBRbb4Dp+NfrQoDePkFdh5y17+IOx9gRBNzmM
         K/bOZthXcDdT13ekNrI/GjYnVERdh0rtoUEm7IZ/vfu0SIiMqviIszk1iqAdxDsPkvel
         SMwaF3B7Be1WUB4Xxv0oRCTC4Q4xOt/2woxwVPLd7DsQfnJoDRaSJu7g7qndjI3n7DR3
         Got5xKgHUavuucv/JYSoTAzxK6AbxD4RnTJkbKAaaALqgjihLqob2sFiZiAUOQ32E1s+
         NOOlt1A7HfD78YEuvbNGvtEDG2UVC0UPx1g9mM7MMc0Vjc6kGkp0uaDZdHoxM+KKvL1h
         yQeg==
X-Gm-Message-State: AOJu0YzNElifjGZ9sQPnI0NKO18cPxEHKPWL5BRLLr/lRzLiwJStFhA4
	qgqz/WG49TV65pamdo9aPThOg8ozj3XXqDIJzGkdEPo1jMs2V9mrJ19/8hUAbw==
X-Gm-Gg: ATEYQzy/hl+BR3zxIVUJV0ucjgE8De2g64Crvx4gQhYqCrvHLB+/R5pzdPN4pyp+bDT
	4VUqO2HTLPBOjef+qQQCCtvyK5SBj04cUMA1yr9spnK+LEWY+51ku0KwOv3T6z5uhnP5xckeMCw
	LZNkVBfom/elqFExX1GaUf5qxh70FcyOvD2cTUmbryAGTpSMKvM/URmuf5hi26Ts+vSZ1Dsqx7/
	37YOT8KD0BglGtYQ4VCujxCOTyxeRTXqFxDv1sczpu3LlhsQQP1rreyUZQZvPNNMPFC9V/1DJRz
	NQzI7LvmrizKMOKf0PCvuSSrt27o2sVkot7fHljmLcIOSO3A8pMZuxfQsizXAqpAiMtA7EnUulr
	jxbMOFjiwaBm1w2slB5Rm6f6t6Oh1DAExxidtxRkgk5q18KIv11oF01+RXpP6B98ZUXvuROHxC7
	aWmB6JrtUTUMQvNdMizdEbliNrEEfpOwzvbo2n3pGftxXdx7W+0ONA/l7M9D7hc2XyEOs6BijpI
	tVRHDgxCkABGPw8nML0fSbhTa9sfIUpEz3uc30=
X-Received: by 2002:a05:600c:818f:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48883597d8amr112594235e9.16.1775113602502;
        Thu, 02 Apr 2026 00:06:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c8bc9dcsm101916335e9.6.2026.04.02.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 00:06:42 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/10] promisor-remote: refactor has_control_char()
Date: Thu,  2 Apr 2026 09:06:09 +0200
Message-ID: <20260402070613.85934-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.765.g57b94de1f0.dirty
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com>
References: <20260402070613.85934-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit we are going to check if some strings contain
control characters, so let's refactor the logic to do that in a new
has_control_char() helper function.

It cleans up the code a bit anyway.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5860a3d3f3..d60518f19c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -642,6 +642,14 @@ static int all_fields_match(struct promisor_info *advertised,
 	return 1;
 }
 
+static bool has_control_char(const char *s)
+{
+	for (const char *c = s; *c; c++)
+		if (iscntrl(*c))
+			return true;
+	return false;
+}
+
 static int should_accept_remote(enum accept_promisor accept,
 				struct promisor_info *advertised,
 				struct string_list *config_info)
@@ -772,18 +780,14 @@ static bool valid_filter(const char *filter, const char *remote_name)
 	return !res;
 }
 
-/* Check that a token doesn't contain any control character */
 static bool valid_token(const char *token, const char *remote_name)
 {
-	const char *c = token;
-
-	for (; *c; c++)
-		if (iscntrl(*c)) {
-			warning(_("invalid token '%s' for remote '%s' "
-				  "will not be stored"),
-				token, remote_name);
-			return false;
-		}
+	if (has_control_char(token)) {
+		warning(_("invalid token '%s' for remote '%s' "
+			  "will not be stored"),
+			token, remote_name);
+		return false;
+	}
 
 	return true;
 }
-- 
2.53.0.765.g57b94de1f0.dirty

