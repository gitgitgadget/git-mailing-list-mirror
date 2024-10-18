Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013F91EE03D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259588; cv=none; b=CfjAtZXIZk8oO+C9zmCYWmzS9nrx6Cp2zqeAwtnn3flrMX2hL4jHss5IzxNYPapiPLMBuNKFZNftl1tfaufeOTSJnLhK/uJ8iAmx1wjM/7mi+dEKH5b/YjVlN5iFtkZubWq35YoLUYyz7Rr+CAtOA1ugL5URXyUNZPB1dHKHJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259588; c=relaxed/simple;
	bh=sKWsnbOYV+1FPRwrCVpviSK03dCOXSFdSaWRp0HT+rI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pSlZG+9VHiWIDnbWITWIbrP8jNTajojLREfFoJr2Y1GT69ALw8BIc0jj8O9yUipDFiZL9Ng/pJa2iOLHw7rM0yUAFi4QU8k1hrxl6a+icSVrjaGDMxfTy1xaOGutOvZ6eyp+SyI/fmG++HXUph6dCsVnUe+WDXGAjGN8FyOvFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw54PTWG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw54PTWG"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso261069966b.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729259584; x=1729864384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhwAPeMCPwsKMWp/iXaVKrWIcarxNsNe6c4GuExN1yE=;
        b=Iw54PTWGSTjty9wCIpwg51lZUlYkjvzpzfcvm/6ULiFO6Aj/b1jKh3ztTFik7R2jns
         WmfhRAhl4zx9Hh395TEJBCor9WPa0uY/OG9L5/2YsXQl72Dgi2MsF7OMRK2j1PqO09BB
         4BEDFWysypcCuk1DUFrl+W3ZNOdwPWnojIokJNV3wvZUploMKu+V7Y47ad4SvVQybmRq
         Abj3Ulz/nEl/KpcFi+kaAEKH6h3fRbmaCY7QbPViHCOWk2rYGSaUy+TBwOHs3aEZlOeB
         7j0sf9qCU6ZUxrI278Js3SXBh3faQV/b6XSFtuY42DAXCRjuRfSbkWDuJIgHJYIaqffA
         dZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259584; x=1729864384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhwAPeMCPwsKMWp/iXaVKrWIcarxNsNe6c4GuExN1yE=;
        b=Ru9YMskA99DlsNTYQnByngCq44GdmNvu/lL216chUYyG8rkImdrdV2UlPb9bs/x/WF
         ctQc7t7vvM+OvLVTKduUNoiUPR5oudscOX/HbHb2YSI0dT/+rVIRcgP1x/Ybx+FhDrl9
         jcTAFkNXJXXtiDbQHNvhlQhQSvSLozDotxF6lBBJOKXrmyx4BEF6O+8nvlKckmR1O/Sa
         SdXDhjzmFaL+A7Gdd7N4Qwtzw2X+ur8jVovZe0Q4birniU6osnzqL/8aiWnrutNiJxj+
         +Y2mQV2JajHHLyW0ESCeRHQlHzp3hP/91Htr62+a6t0nZf8aEok6Gw5Zvo016gadrepU
         51Ww==
X-Gm-Message-State: AOJu0YzmBoke6fEa1uk2KzG5a3vQBuIXzLz/mLCO/NpRQMKHSxOa1Fkj
	yKEUCIKbouD47yDy1DoopXCYbsA2U05Dz6VuUQW3GerSiJ4SWs5OgoXYpg==
X-Google-Smtp-Source: AGHT+IH9T3s7BeQBStJU02mC7ZtckYeU07UtUIO/foGwhX6SsR+CTtUUIoEIbwNE0HxciK38QPxOHg==
X-Received: by 2002:a17:907:7d9e:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-a9a69a7dc95mr234816066b.21.1729259583500;
        Fri, 18 Oct 2024 06:53:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bf621csm99034466b.165.2024.10.18.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:53:03 -0700 (PDT)
Message-Id: <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
	<pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Oct 2024 13:53:00 +0000
Subject: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
 and UIDNEXT parsing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replaced unsafe uses of atoi() with strtol_i() to improve error handling
when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
Invalid values, such as those with letters,
now trigger error messages and prevent malformed status responses.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 imap-send.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ec68a066877..8214df128e5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		return RESP_BAD;
 	}
 	if (!strcmp("UIDVALIDITY", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
 	} else if (!strcmp("UIDNEXT", arg)) {
-		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) || !imap->uidnext) {
 			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
 			return RESP_BAD;
 		}
@@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		for (; isspace((unsigned char)*p); p++);
 		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
 	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
-		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
 			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
 		}
@@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (!tcmd)
 				return DRV_OK;
 		} else {
-			tag = atoi(arg);
+			if (strtol_i(arg, 10, &tag)) {
+				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
+				return RESP_BAD;
+			}
 			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
 				if (cmdp->tag == tag)
 					goto gottag;
-- 
gitgitgadget
