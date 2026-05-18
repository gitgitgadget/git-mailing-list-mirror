Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EC388E6C
	for <git@vger.kernel.org>; Mon, 18 May 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128852; cv=none; b=N5mFS1LnVtC0fI1EQO6LS3W1Kjp3tZLQaaDZFTOC6wfAjcACXQS+EUg8y5rATopZCw57Jg/f9/+PPdKCartfZNm+uLwtXKAOGC9oYs0AKuplCrRSBe7KmnftP5WRcyZ1Q3L+xQYlPJtleWUK+JW6ubqPOl9aTElGzyi5RLKKeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128852; c=relaxed/simple;
	bh=P1brimXBSD3Mn6SBf13+alkeze2GMVtpYCmbiq8IJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv8waZuPxnpsZkfSK4S7MKtxGLQkUAt4wo/Uqqxrp2zMFOzOMqYzYkChoV4f+XCU259QMH2LJT6FxRDmej0UMILFKZafN7UGiKpF4nULYxYuEkeQfhXjhF2hO4dBvK7AXQAw41ATHZ3iY4Ts/oNsAT6OZEZlgiT4RY+8c+BjZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0g1W+qV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0g1W+qV"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bc7b311e77so10571395ad.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128849; x=1779733649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0oPRXs04pXauztxoLB7CKL8HMNfPaDumM03lO/ZSjQ=;
        b=c0g1W+qV6Hu9IwRphT+13tAVBYGAbAdUA4xTRoh8gb+k6HpnIRJ0QoOZX5XivOpmJ1
         d1GlP9deKVKq8v7MCiDP6eT71Hhb8vYG3bdLZCmOMQVdGP/GjLVTvSdohb51ro1k+53V
         vc8VtkMngfMWpcVzNTsQgxHm+BXt3hIvNqHrtoNIXOeaIULMfKNaHZMpitspI1oWCtB9
         woUosnp4/wXLrppcqHvWowbboFVQuc5OFd26IVSlza7MZErEOyMuW6adu2/V6wSv/8Xf
         Yy7FmD9EjDFnAJ/b6pGgrem50kh9TDRdhn/xcfRY3vjpUGTH9KRq1SamKOwpQmLk4Zps
         B1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128849; x=1779733649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0oPRXs04pXauztxoLB7CKL8HMNfPaDumM03lO/ZSjQ=;
        b=Q5ulxRqteCdsIuiVoQJjJ0W3VLTWLdi+OEGGn0p43lgzJX3HFOj26N0R2yYzWLVWLW
         j06vtEC3tduS+qLYqTskv6ydMjOckrrePJAHMln6GIkSOQXU9dWJaV9lH6LQoWxa9A5b
         yRPgfG1H/fsFSIQjLeWGxm+TkK0YoBR0K2C7iuKYExU3PHmNgwlcxxSgUZUbQI0bPcQc
         pDPSh3uD9Caa9lvakYIS6xjGffvDgBzqTxE0bz46aszw+dJ//a4mQSYZBGFwfi3EhCxI
         cvOVRyIX6cjhWZTqtBhuidRaQ4Zmy15cxqVMxUZ2ImK2Un7304WqJITBYN5tjmQkbIlV
         dkkw==
X-Forwarded-Encrypted: i=1; AFNElJ9ydClmSJXLApML4YLaFJnRidCF+2ktWgEsIdYSFlNVV+9RgYEIwojVVDVSfzyvriYHUv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtgF1j5yRlcAqQBIzRmMoCpCLdzfEe4Pjl2uaFn+kf7/4wpmO
	1ae9k246dctmwoDn4ZZgCBZLlTOvrBoh3XdeVmGS5DGTNBsGSRHCXC1s
X-Gm-Gg: Acq92OECVDBB8SMpWBNk+Os3w0gQeW5ejXnTkubA1y6SJ0r4SmzY4vg5D2OKh3ozPcO
	zmYFE0tpdNGGCReQOzDXdbTINQIIoOwWgRLKeFjiL9ef6j5bf2d/ZNFBra0aXskIH0iPERFgysO
	zxbEq+Ehu41Rf0AI0MRQrLJIfcX0UaH1XBe2OvdtfBKPv6OryTLYmj8WXm23W+b5hMlz168AcRU
	3dB9pNMUf38WDPMnWCPmxnRD6oYOkZ79yqG1DI3qkdML+mZ79c6GXWNVPxmPBAUUome/Sqv5Nkq
	0jMXCM4TPijJaEVu0ak1BqxTlYXEHGwpgngckNt0mcs4lTRsvqq6FVBCtxPdnpMN5U+/0VYdwkF
	BFfO/n8k6C0Gf7d+nuV9Y+fYjD5SSRbiBuMElQK83ksb1Fgc7hATHxcfbgF3hN0FAcAL1b2w+eK
	qisbzcyQXv8FGq/R6CJgAUgSHLsajRQ4GfKFtnOotpvYgIQdNsbbA3AgC5MqA1h+i3y0+T0MCSG
	bM=
X-Received: by 2002:a17:902:f545:b0:2bd:4bc3:2995 with SMTP id d9443c01a7336-2bd5281ff47mr173144215ad.22.1779128848864;
        Mon, 18 May 2026 11:27:28 -0700 (PDT)
Received: from archlinux ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600a4sm148530085ad.30.2026.05.18.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:27:28 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [PATCH v6 1/3] remote: fix sign-compare warnings in push_cas_option
Date: Mon, 18 May 2026 23:57:19 +0530
Message-ID: <20260518182721.155070-2-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518182721.155070-1-usmanakinyemi202@gmail.com>
References: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
 <20260518182721.155070-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `int` with `size_t` for `nr` and `alloc` in
`struct push_cas_option` to avoid -Werror=sign-compare
warnings when comparing against size-based values.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 remote.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.h b/remote.h
index fc052945ee..741d14a9fc 100644
--- a/remote.h
+++ b/remote.h
@@ -418,8 +418,8 @@ struct push_cas_option {
 		unsigned use_tracking:1;
 		char *refname;
 	} *entry;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
-- 
2.54.0

