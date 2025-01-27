Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D197EAD0
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991051; cv=none; b=o/jjmzs4XDCz8cOhcPxmHCuR/4eHbbcOWruYD7MkqL9120/AFONATVJVu4NvA5bdyOxTBr0MocKueWi5Bysh1lROhVkA22WVkO7MRqniJOtA7E8+nP/pPRhLPKrkPz++dH/WSwV55vnxjp2dKyWHSic5HrJJS614vS/DF/2Pq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991051; c=relaxed/simple;
	bh=kMCFmFbMiA7LGk5xaafDplS9MVHu/VFKm14qXmLkMqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oc6LK4E20y6Shpb7SeNFQCJsH4dQPoxq9BG0Cy9GHjvtHnH+pK7PIjPfosQZ4f8wwxLSwNsHFybFa/sHs3AA6aOH/dLNZ7PPX7ZKyRDU52ck9gSVxtvSoGjQQ6yh3pcon5GIuhZz2LOPQwGHxQrMl4ffN9/3Zk77XfyQ82YY+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj6Il+N+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj6Il+N+"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43635796b48so29343845e9.0
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737991043; x=1738595843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpnhQpTos0ngMkpy+QptF2iEeMTZvpVa0xor6HdzOvg=;
        b=bj6Il+N+j3m9C7lU6uBM6+biSKa14u0uW6AzwW498yUFLIKSIUD86HbEgtteaA+KMe
         8u/an9/9wYyh75DndryphbwtqnK8Xlb8UgsvF00DWEbV4nOKN2sQm1a3Rp2op7YMNlvb
         BnChYon13t+I88Icm/t7zatq74ILpjD8+OH3iYkbJrIqTyTcFR89BNMqQdrL9e66wbjl
         ZX1KXIbvFNq4fRGpePAfX9B82uJA2pM7ZlnAY2ZYCIrJjpsQ+5ylWOpP0MBx7UBVyxMJ
         A764OzYwSHw4wQIy76SUYMy4Z0UlHBXulXW/KCW9krcMo+6GGP1vuXaoCtneVYAQcR4a
         QLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991043; x=1738595843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpnhQpTos0ngMkpy+QptF2iEeMTZvpVa0xor6HdzOvg=;
        b=qjr+xlyEMLCmAQf+Ko+TcdgmUGwN0DqIFJKrrAmp5W7lGK9Q56eZxCs0dSmDNtWDgS
         PEDhVg2zBciVwpxJKuANZ7lVRAT/wuEOwLz6F8Nlc/FNo+EAk8uxDMKp9fdDGXtmWeOT
         KLLXVfLRhSudIHyexfUlPXe1hLac/GPkGy4VSlvWlTOWkL0vPcGy25ELqmyLE29ng/s+
         FFypeIT+OlMBJldAPHwjXlfg4XOjWN/PxF+YGLV1RDjM1RdH/r3PKDFpVzeAAOp+SqDZ
         dTtzWZ5IhGAHzAaByxSw+3uzYtoFTiIyGzjv6yQr/3BZTudbzQpkAfXuZo8ctPAhDPW+
         gV3Q==
X-Gm-Message-State: AOJu0Yx1aYbKr1GdL5kODc0s6zIufXuigY6dmbmVRzZPKQ7Jr1fr0npg
	gSu3BJKLR4DAiv3NikLgLdfXcBhr2nGCjR2pCIp48ncSLKEmAmdaKaGiwQ==
X-Gm-Gg: ASbGncvRDIfhD+JJCag1hNifDJVopki7izDWbxhxfcc74tdVAyarmzJl+zi+8PWSr3j
	gZRvvKLJndhGbBK0CcxL/M2pDC/4aXIbPR/0Hm8HSBmxo1Hfz4au822h0TrMC9shfobk6ZSuamq
	FtKE2qn1yPzl6jox0TjDbc0A68if7gEgYOPL+VyakrUMkbAZfmge6uYx9KQ5zPV1z4cRMwMI4og
	q82E6EW6YKfEFh3t09iShuNxgPUSbf4g1Awa7/fuLi/0OnfjOq5MXVpVxLpdGeoda3L+mbwGPb+
	reBvDT3sPlBxYHb9bOgEOeCdI/nIt0IdM+FHrzohRgkCY6s/mP/SLRXRw4VkA+A=
X-Google-Smtp-Source: AGHT+IGVaZgG8aWtZ8AQyosufEf8/zMNlWzy6FKafjLHqRlXBMDDbdT7SozZfc/46OVn6eshs4LjYg==
X-Received: by 2002:a05:600c:58c9:b0:436:e3ea:64dd with SMTP id 5b1f17b1804b1-438bd0a88dbmr121956125e9.11.1737991042537;
        Mon, 27 Jan 2025 07:17:22 -0800 (PST)
Received: from christian-Precision-5550.. (176-138-135-207.abo.bbox.fr. [176.138.135.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4d34e3sm135269625e9.39.2025.01.27.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 07:17:21 -0800 (PST)
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
Subject: [PATCH v4 2/6] version: refactor redact_non_printables()
Date: Mon, 27 Jan 2025 16:16:57 +0100
Message-ID: <20250127151701.2321341-3-christian.couder@gmail.com>
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

The git_user_agent_sanitized() function performs some sanitizing to
avoid special characters being sent over the line and possibly messing
up with the protocol or with the parsing on the other side.

Let's extract this sanitizing into a new redact_non_printables() function,
as we will want to reuse it in a following patch.

For now the new redact_non_printables() function is still static as
it's only needed locally.

While at it, let's use strbuf_detach() to explicitly detach the string
contained by the 'buf' strbuf.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 version.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/version.c b/version.c
index c9192a5beb..4f37b4499d 100644
--- a/version.c
+++ b/version.c
@@ -12,6 +12,19 @@
 const char git_version_string[] = GIT_VERSION;
 const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;
 
+/*
+ * Trim and replace each character with ascii code below 32 or above
+ * 127 (included) using a dot '.' character.
+ */
+static void redact_non_printables(struct strbuf *buf)
+{
+	strbuf_trim(buf);
+	for (size_t i = 0; i < buf->len; i++) {
+		if (!isprint(buf->buf[i]) || buf->buf[i] == ' ')
+			buf->buf[i] = '.';
+	}
+}
+
 const char *git_user_agent(void)
 {
 	static const char *agent = NULL;
@@ -33,12 +46,8 @@ const char *git_user_agent_sanitized(void)
 		struct strbuf buf = STRBUF_INIT;
 
 		strbuf_addstr(&buf, git_user_agent());
-		strbuf_trim(&buf);
-		for (size_t i = 0; i < buf.len; i++) {
-			if (!isprint(buf.buf[i]) || buf.buf[i] == ' ')
-				buf.buf[i] = '.';
-		}
-		agent = buf.buf;
+		redact_non_printables(&buf);
+		agent = strbuf_detach(&buf, NULL);
 	}
 
 	return agent;
-- 
2.46.0.rc0.95.gcbf174a634

