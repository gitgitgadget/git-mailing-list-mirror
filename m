Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE18837
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991046; cv=none; b=fq76KtO2cJrYaotqjCjXHG2WB/2vhr4Ps0lErOLf20iDTwlMGYTPIv3ZE1qr2FUOZqBUC+IpbFSkZpAgGkXWZQ1u8Qu0Kc5oMIvlsIp9595y+wQiV1uuhdS0gfCSHzzdIkJxEbWv2Ucf4a4qCoVnIzWRH4/uHFvHEX7DVFberMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991046; c=relaxed/simple;
	bh=7jA2MviDdSVDCNXpUTDXPhYPlRNs1hRTM8X61jsiRLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOgwLhuuznPCFldyj7HJdieQq6pp5uIOq+/AMRgGN63tHwNw4qd7U18llKJC5oPskI9XHFYTEZiuIe3Qrtrzt4eT368IKhqKz2x9DklrS7CZN5shfKYmPT5sjHcvApSMZKo7+z2RUKv39Le9uEN313yAFs/eLnSkHK/h385vBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdW2g3Vr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdW2g3Vr"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43622267b2eso47437525e9.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991042; x=1738595842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOTr0Iw0jIP2ZrAUXkNJfxLZBWT8hPVKxbntGGW3kFA=;
        b=jdW2g3Vrw0AbaPJiommR5uWwBvG/vioQDyUeOFaa+3iISVhQmjnFqkufEbQLWcj0tT
         onpVyXwDKnXaHMZddLLQa87qPvx4mOe/OzVsFIEV7XdTdVfdB8sfPOenglUQpgxY/F8o
         oCPO1NTDw3qHsQxHSOY91pWQVaqYfOMIKabrPpdAQmzTCi/zWUu2KyeGn3FuUjnT9auK
         WAp02QsP3gfLq5z5zGrG+WUvAw9jZ5I1vy5ww9ss/BR3NXvdVZihaeDRlMMqfq1zbZva
         +s5rJxy3coU+nDaC2SYMxBIkfDQmw3ic08vUXtLyBCX3/onoybn5xfmRq/8aBi7xgP3o
         ZsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991042; x=1738595842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOTr0Iw0jIP2ZrAUXkNJfxLZBWT8hPVKxbntGGW3kFA=;
        b=MnhtSKGbK4cKlKLA6MhpJWFkCFS8eiwg/7tuRkCi6KwJk4ZzRk0wu0Lv+6E5Mva2I/
         eL+3zO+pXKuHYp9wkLuvrcbW7WJaYA0ESuBGwsooPAZFUGM4pV1A5pxoVTLbBlwfqvfT
         JCbphg/0R9L/8jpvFXKkiIHMoELtsewgt4eNRkAeo5bfduWG6klH4wtxeeFQK2MiK5B8
         jb1dI7FeaL+XrelzFkwK6LixsWC1WXEb/lFyLhboeygXKP/cGHOqZATs7JCaGyBkjybj
         ami9DrhNlgV9bff6UqiGh+Tk9SXJhDu3E4OC2LmpuMsvLu8nc6MWEDHP1yRr8ro9Japv
         Gz+g==
X-Gm-Message-State: AOJu0YwrqkPhQPsdf9bEqpfGCZrvX28zkQDMqU49IsW8Vkf6S6bGKF5P
	pCiOxgKw7mnBCZ8YlxMenZt3zGOUch4YIapVN9HMZah4XTOG3GK7vvb1Ow==
X-Gm-Gg: ASbGncu1b6LpN746r/Z5CDdgr66hudYDhy2DJHa0fgV5MJPWZJAtS/O5sAimu8YK481
	mDGGaB+wgQTssm3D+3CW5IyWOMzFxIZXtvunOBaW4U1IR6GpAVF24VdU5ADN7RNkpfZEZq39Ukw
	tUFP/Pyty+tO8KePZvmo+yFHFQHrb87dPOCe3n8d4lF0fIjGBUPhVegh6/32eU5aqF1whdwv2K/
	FTD0PN1azt9u6hB57hm5zuY5ciV/E7psCWhTe540qTPRvLGoc73+vGbdE8T1/2MOQA7pRgt/c4R
	tO/KBWskWF1gCD3uFGD8P54ddcziGdtINmp3hr4OKLsch0eBAHGmePwOm9oY2RM=
X-Google-Smtp-Source: AGHT+IGlsA/co/d1jCxxIlGp/WSujV+AR/XxZfnhTb4LBFGPQ/Qh2ZQ7nJHAzIKcYdD3jZn1uOAI/Q==
X-Received: by 2002:a05:600c:524c:b0:432:7c08:d0ff with SMTP id 5b1f17b1804b1-4389143768fmr370198965e9.23.1737991041572;
        Mon, 27 Jan 2025 07:17:21 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm135269625e9.39.2025.01.27.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:17:20 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/6] version: replace manual ASCII checks with isprint() for clarity
Date: Mon, 27 Jan 2025 16:16:56 +0100
Message-ID: <20250127151701.2321341-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.46.0.rc0.95.gcbf174a634
In-Reply-To: <20250127151701.2321341-1-christian.couder@gmail.com>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Since the isprint() function checks for printable characters, let's
replace the existing hardcoded ASCII checks with it. However, since
the original checks also handled spaces, we need to account for spaces
explicitly in the new check.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/version.c b/version.c
index 4786c4e0a5..c9192a5beb 100644
--- a/version.c
+++ b/version.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "version.h"
 #include "strbuf.h"
+#include "sane-ctype.h"
 
 #ifndef GIT_VERSION_H
 # include "version-def.h"
@@ -34,7 +35,7 @@ const char *git_user_agent_sanitized(void)
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
 		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
 				buf.buf[i] = '.';
 		}
 		agent = buf.buf;
-- 
2.46.0.rc0.95.gcbf174a634

