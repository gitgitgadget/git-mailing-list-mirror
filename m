Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CC1FF7B3
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781579; cv=none; b=sgP9vpd6XhxQES2jF6KJ7Ad99iQcTtl8bAy1enk7IquzD6o8ZlNiTi+A9vKdqjHSoyxqs2sXIKmv+PjdLw3jNpksqLjZlhf0LEyD6IT1DT0wIFcEYBpAgzWSkYMcTFDOIKXg/95TQCa/5hqymAvRSFYaG5Iqzl88szuJ2A3ufrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781579; c=relaxed/simple;
	bh=fB80ASbecHtp4fGMlEVSHuxVoWUEiTfhiT/c1rpUQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNQMBpJpR2Sb+UKRAFEX2fu89Yxfg+nbS8XjVHqcZ5+cywXgbr+2NDux1cGZJnSd3tDs7qfOgpg7y8G8W4QTLTz4chiqloxsVo0FKtikL0INOClP7Dn6PwSORxQoB6Lfouedb4VWKKuvoMfr57onkgAlcLY5O/BjC5Rw/huIEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3AUX1O+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3AUX1O+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216728b1836so3161415ad.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738781577; x=1739386377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=i3AUX1O+KBbU46M9tVqLhHJv/t+CZBFD5ovg/UBAoTdKhwNrBH4jLyePQiY4USYozo
         zkcD4dptBFppaGlKW35UITGHsX04yXuqX+73olwHEmOZPfeEBBLPGhuvwkmy497ZEud4
         pDbuZlf4WX15vUxJTYczArrawlWwTi8GLBmyX7DGChWvcDDK/nBqju7PxT0agJI65nRm
         jl9grDBFFjqerOSGnugAjIj+SvzV9nHtt0BvMsEx6GYKXNXBS6CdkspaZTpqvKrgsTKM
         cQeuNTk/4WRX4zmMO3uW2butHmI3mKgh/QvVVgP56Sj9LcOef9YG+IXXvxbTzKb/o2iG
         VJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738781577; x=1739386377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUev6MBsFEBj9LcEfo26+7FRqWVh8ngUTgpXCvWBZ7M=;
        b=vtHuXUBqsdlp7CLS77uIOkCWKKmcrnJmI5X008+zVs35J6Hino2vWe7sNMC9iF4HR1
         5M5bYdwweFxNNJ/0T6d+c1x9jocam4l88E4ZW+3nJI4A3e9X+ZeS8N83Uv1z3+F6Oruu
         UPv2X0lCtkTDNZbTiagWVLKpFnUxGXHhdg7oOqFMWOrTo97lCqHYJwVDX+dJsciDBde9
         r0/NWxPvfbeLEUWEAZUk7UyzfgD3ME3JoGxZK3WeYMth9lwLCAKuS6S2U53yFhb9Megh
         JflcIWcThiSaUSmcwzenjP47yQr2JyE2DkZV86fXF5n1ChgsRFPRpuwFbdnDtWHT3ZED
         +qQg==
X-Gm-Message-State: AOJu0Yxgy3tFz9NiqLthRDwx8p54Dk558PK42TxxYPCo+zbnTi6wDB36
	IMLjdKAX9wR37wEXrKrHog9nF7vPLc9Ow3b01ajzO1DLy6n2eAiadrqusmABk8A=
X-Gm-Gg: ASbGnctU/qLkRBwFP8JQPEssDdxLZ12/zUVnF612bRWlTRK46rEyjdDXP+sigHBqY00
	714/oLubKv2mEm1qDMprP0/wp3G5Du5ZjQ4DsZ4Mv64Wtw4GoOdyd5s7YUL0uZorb0sNBcoUq8P
	ulDjY3wTkmdiGhfbDt2WH8FpXi7GT+LCwPseBXEx+Hz5rRNTVNBe6oXtwttSqj3Jq1wjA2BZwBZ
	RLIvCBVhD44l8H7SSszaiZgcrfI/jSoeYA1Wf53xP1I5N3wfM6tLqeARsSL9OqVS1bDI6FdVW/n
	fIIzsQvAZHsbCnDhvZWafgE6m4ht5dB9cT7ZJOuA
X-Google-Smtp-Source: AGHT+IF90ntoiAkUnT+yf3d0aMKc5lw81zxrZ5g1K8Rtmkcr4Ehh7eQrCdbe4wy98gxlNNLUAydEmw==
X-Received: by 2002:a17:903:2d2:b0:215:acb3:3786 with SMTP id d9443c01a7336-21f17e46165mr74799645ad.19.1738781576854;
        Wed, 05 Feb 2025 10:52:56 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f1e9f3ebbsm13754285ad.190.2025.02.05.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 10:52:56 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	=christian.couder@gmail.com
Cc: gitster@pobox.com,
	Johannes.Schindelin@gmx.de,
	johncai86@gmail.com,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im,
	rsbecker@nexbridge.com,
	sunshine@sunshineco.com,
	usmanakinyemi202@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 1/6] version: replace manual ASCII checks with isprint() for clarity
Date: Thu,  6 Feb 2025 00:22:31 +0530
Message-ID: <20250205185246.111447-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205185246.111447-1-usmanakinyemi202@gmail.com>
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 4d763ab48d..6cfbb8ca56 100644
--- a/version.c
+++ b/version.c
@@ -2,6 +2,7 @@
 #include "version.h"
 #include "version-def.h"
 #include "strbuf.h"
+#include "sane-ctype.h"
 
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
@@ -29,7 +30,7 @@ const char *git_user_agent_sanitized(void)
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
 		for (size_t i = 0; i < buf.len; i++) {
-			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
+			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
 				buf.buf[i] = '.';
 		}
 		agent = buf.buf;
-- 
2.48.1

