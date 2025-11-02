Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038F2241679
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100301; cv=none; b=eXYBbTlsfDX0XI6sjkumBryV6oFfX3L4Qw/5gEUi+/BXlHrBQ/OlCUQ1507m1S0Xa5fELs2YJ0uy3GElriZzDFBBaPwW/1gYV3ad1HdrkC+mxYet/3dAKOTL4pm+thwJWvnLIl23q10NmRx2RBSeLaAC2PVkyRceijG2F4ZHiHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100301; c=relaxed/simple;
	bh=az9TNEqugCFux6XmgGXB1ZZpOV59pkO34Ypei2/0mv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8GvUZn2YHQq4wpgHiTzqNtFw2xYFiXGOFBrdknFEslgOpPkYo3OeSQnTh27AxnIgNjMhzduf3s9P6qt7CVnPmCrfdMO/SHQ/KBZnUg99P27/PVjLp1OluUcNzNZOm8J3tJF6iGEqb7xd9lk8oHBIgx1LHq6Mg0OtW2NBXerCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk8fswmx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk8fswmx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd0bso48525687b3.2
        for <git@vger.kernel.org>; Sun, 02 Nov 2025 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762100299; x=1762705099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxGHKYxcD3Qzc3a+gm1FiVxAZww00r3H3RpMykeEv+g=;
        b=Dk8fswmxmh8VD4rdgFgGKeWlfJU6ROxk/28mntqXjgnaGAlPHztB2/+2LKY/22paZy
         fZZ361T4rVX0l/Sd68bEI2mlRt8S48K2I5f7f4zsl+0wnzEC0ta+ZjOkm1Nf2EokKBZR
         ziB/6RhwBaLh2uNRvbch24Cv55KdXU9Khrd6PrTLZZBAtnw3rWzKRz3UVgohxLmRaVt3
         5nYMsQ4kmLvCQEQqBXRmEpwV0QhrM+4htq5vT+2LV9FGi3g4lrcu2JIoyi9DB42Chewi
         cW31j0wa07IkEC/oL8hZVS0PFv9RYTGOiNP1qulW5f2Pbqc0J15Q4qVwcelRbhfv54IS
         7ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762100299; x=1762705099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxGHKYxcD3Qzc3a+gm1FiVxAZww00r3H3RpMykeEv+g=;
        b=wAqWgEjma6T13RaOXyzGTM18rZsiPDEBd8lRhtaDm0jZozimf+Q2ICb1Hsb0oZcJxI
         UEf6LgFqd073PzyHyQprEA0wx+3j0HV2Fw8SUB6HywHpIa26RygPy6kjSTTpKyr7sv1G
         CMM9j6fx3DeWljF8ETR+/3StBf1ANb3OC/XlVdUCDlBlIGhSh1DGEIYcVLf1NOV3Xawm
         b8+liPZWsbBIFrhZHHx+JjGmE4jX/x5e42+2SSSrnK/+LDec0zUX80aJz9NPZL75SGeU
         G1fmofv/1A//N5L8jNvWWQPYPh10MYQEv3M+SbI5OttEer78sp1rk+0FW1g4BY3l22J/
         +GnQ==
X-Gm-Message-State: AOJu0YzHaKyzS85N+nB2JeXROHVis/rSm1LK6VSCEtGViK1NzCs2roHG
	OMNYtmAFMyzi6APLBI2pY2s2efnth/uk6ViW0Gihzm28NzGk67ngDi3mRA7FsNRRVXI=
X-Gm-Gg: ASbGncssbbK/9E+5IrEPN9nXCcddAYWNV8OuBNHt1dqzVW4lbZQ/2965l3SVhu7vr/c
	+2idResWILfh2NW/1R4fnszCQSyNDUB/ETzpwQhyAqUu3IPOhaovuUmtC2elJQjKkwthJvaRyZR
	9gu+eZnjrtrvJP1xJFBtvjSTzPfNrQck63gRig+iy6Q8NnFQHg7LcYahA+zzsJsjxrSbBQoiP89
	rkp0B/VlhNj8uhQunq7sOKyj72ZoavFuMAoR9L6cpSHNZxjfCOQ6QyS8JqXeOqm09TeZ2E/aE2c
	jAUHYbcT/R38D6BWVjWdeYyvEkAkY7fP96nHp5GGxANUqjSVGFxXkN2a8btWj0YzoALrnTfoSe+
	N4xSHZRrFAXjCn4SIjvXDtlwZwkMvG+c2vd3ND8eIwqFtFXMvle2jDag1/390km0dmxKTIvh/21
	pvnMmr5yN0MtIlhE9mAMlco0vgFl9RHoYtYyg1TQ==
X-Google-Smtp-Source: AGHT+IESIQDoWwpLw8fnQObeUJVOFC7oO9whEsxM5UlOHSpP6fBLM7ll4TebLsQ6ak8Gu6ezSlrG9A==
X-Received: by 2002:a05:690c:5c01:b0:786:4fd5:e5db with SMTP id 00721157ae682-7864fd5f630mr114993257b3.49.1762100298628;
        Sun, 02 Nov 2025 08:18:18 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:c038:e715:f394:297e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7864c6185c5sm22626967b3.32.2025.11.02.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 08:18:17 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/5] parseopt: use boolean type for a simple flag
Date: Sun,  2 Nov 2025 11:17:46 -0500
Message-ID: <10d531daf2c90d1bb53c07f1d72b087ebc1dd9c8.1762100242.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1762100242.git.ben.knoble+github@gmail.com>
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 parse-options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 6211b55a83..197c01987e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -208,7 +208,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 	case OPTION_FILENAME:
 	{
 		const char *value;
-		int is_optional;
+		bool is_optional;
 
 		if (unset)
 			value = NULL;
@@ -224,7 +224,7 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 
 		is_optional = skip_prefix(value, ":(optional)", &value);
 		if (!value)
-			is_optional = 0;
+			is_optional = false;
 		value = fix_filename(p->prefix, value);
 		if (is_optional && is_missing_file(value)) {
 			free((char *)value);
-- 
2.48.1

