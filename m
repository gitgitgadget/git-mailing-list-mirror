Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061B2F5A34
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773365988; cv=none; b=C1LQ0uRbiyNAHIFT2nns/HYqrpdPJiyvH6uMbdUWHVfyT77wu7keNi1HaB+X7wq5ngukw57qMF4KJPHdC4DMWuzl5ERvdCeLTm7iMHsBfBlWoBGWTcxzK15EGyEVm61/AhpbDiV4L10pbt5kWqHIndN1a6RPpeObx6EE9bHyzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773365988; c=relaxed/simple;
	bh=SimSezPDUX3sWC+meBWBAnslS8/egIYa67DAQbmHWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ro/qETqYeICDuHh1+KhALvXQJgj2ruawIF/JRBoRYmaxN4mMziA68rXS5ed5C6V60v4NvA//ZXapyY86xjdFXpw4QLym7fFqV9QFMEU7K1dZTOddjMhN/m58p533wnYvXfmAM4ivNzVsb/MOpmTsUwWL59XkDHmqtB3yLCz4/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAL5JoNw; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAL5JoNw"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-466ec4c6852so1054032b6e.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773365986; x=1773970786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=AAL5JoNwhgt9olvirq62qoTtIfExIwhW8jo/ucoRuyaqiXMrabbMVGZ/IfG7t1TRb7
         ZWQEKquxIDpAz5c2y5HzDdxS4HzDLZnEXzctSuVEZ6mNibSBjrODhdduK1ghdjYO7e3r
         7G2Up7P150TONPfWV0Briy1vuu0x6Ue9mCcPiICp4/8gw1nPNT1/lde745lCB9xB6ICx
         IXjY14oXtcrCrWx3C+pe0Zv2joH57Sg1U8wavjmcNbKwaqawzkYbt8s+gVILkqzpRhzq
         OYvI45VGMabUnqlM+RmagwxgGqvvIGgIamDNOyGvlAPFHnvWo1f/1t91NILIl8jGeJht
         on/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773365986; x=1773970786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=WLuX4s4jLrHt5ksbyMmekn5Nf97AqrPYwr+MfIgbSsHy50CfNBnZ5c/rjMKWN69mjz
         bm7RTbYhK7f08UiBwmli5HLXKNXI2CjkF+M8ZSUJXFZEnvlpFDC+aoKvdENZqiRUs9qZ
         X9g1n4vBrubn/s+p3AIeqfY/XEp92RppV+LD88OYaNb23oaWyLgUctlISFhD2VOjI5V7
         8uYF2LabuoAZbypzfZmj3Ec+73VruonUlJUTHDE4D3mofwRpZ3n4pFuEe1kf2Fc65VZD
         GQhPutw87emTG+oIPR+HWnuFtntTtqtn5AdvFleK9GuH0Jc7pn4umB7MtTGNfiADUTR3
         x6Mg==
X-Gm-Message-State: AOJu0YwaZU4u7Py5WDqwZ/+qGAXjl0cRkx4gYZm9g4pb81uZQfsKEwB9
	Km4L7H2zLY4+XoFb82qKEK2LDXrae58g0xRW/B2IaHp9GaqSAAIGuextCWWXxw==
X-Gm-Gg: ATEYQzw5XngqRLI511fHrkW716bNvrDWN1wP/u7eueszNDxfQmKL6lB4QCxcemfcwDJ
	4KfIPsR9E86aOEtGXwBdQFDVexYrAbyoAluAcSsGAGINcWitmuYqXIYaIBzWg0lE85n0b1dUP9W
	xeIKg1+rrQwDDaQ3HvLX5i5l7KJIMdWya/nxTrRY8p2DJna73wG8mp7QCTEhMjLb2GCBlg1xE83
	chKQCdwgZtDFviPyfVfayshlGd1M8oDCL0OvG9v3ylVxAj49Zv54EAYYbtdhkcGwTde16cbtaZI
	zDKJd8yzT7mJ2Qb9MIBiosyU2BDJNSiqeMAMzLYPPQ1YyGO4AbPi0XTsbEyoeHGIwkTwCXiU2Yw
	MliKbM1uWcq8sZ05egeZyRo6tebvAWBIVl+N5IhBKA4CBcTOvUNWZXYfiwBwfE6nnvfvv9vN/cs
	0SImoR98bu2Z3RXBWeQcOLMMH/bBbQJ1M=
X-Received: by 2002:a05:6808:1185:b0:467:15ad:9df0 with SMTP id 5614622812f47-467570a20c7mr822405b6e.7.1773365985636;
        Thu, 12 Mar 2026 18:39:45 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342c084asm3897154b6e.12.2026.03.12.18.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:39:44 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 1/3] commit: remove unused forward declaration
Date: Thu, 12 Mar 2026 20:39:36 -0500
Message-ID: <20260313013938.2742124-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260313013938.2742124-1-jltobler@gmail.com>
References: <20260312192228.481134-1-jltobler@gmail.com>
 <20260313013938.2742124-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0.381.g628a66ccf6

