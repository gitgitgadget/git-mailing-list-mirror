Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15224BC19
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478355; cv=none; b=RIld4+iInvLj/LSLN/z1cTiC2MXeYLTXdS4ICVBnR4D5HlSwsrql1m6gnpzN+NGQbTcEpgNgYtdbmTEcAGrbb0jWYBS9UqdsU3JSj37F9IUPNyuPTCQdVYKg20+EdDM1uPf75jwgp9PN4MblEsaWMsLzSkQ91AGSwvGBaRcP2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478355; c=relaxed/simple;
	bh=wd33tyzx4VGkO6mgzfPH2HQbkgN8zElNSsdDgNi8DbY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qcTCECEsvPJ3ib+SZacr4r81HeLKSKHN6umsKzc6yGDRgB9E9Sobvh7GCzUhIEQkrGf9PzpwO7AOVRKvWydP8LA7rJcBMd20zNSZhJuK6KSr3NmKm4gVCPh4QoWdut1Nf9RJpjBCwfFjLS4CQlHCIhORvIyupvLg+XhnPWm0bwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1SwpBDf/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1SwpBDf/"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd01781b56so14897316d6.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 12:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1739478352; x=1740083152; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wnB1KSLJK65kdBkVoTkyLNi38eugfTY8nHqfsoxDJY=;
        b=1SwpBDf/855WBmr0vroP6SLMr0xXM6drtO/30DnD4Qw4q+47WtzZPj6hjpPrt4URkY
         +UQfgKRsKBDAv6FNtG9ehm+L+5BHBRh909ylFarKKf+qIf7pWFvI0U/NxrtwjkSS8M32
         +voOSQflJDF5AN7o9pGLjxoGUSfd7vkMAxMLgSFNqcU3MOm75uPiNOODn6kxIHt67tAK
         /bP7m7k+XvAcn86Z7fOZKLze0P4Xiu4ScjTVfy3+NOokEDjcV9NHL/6ZuQ9xVfnnADj5
         bmJwIUAeDl3yoLMnMmXS/J/VGP3R5Ni7+I3pRX41OU6hRsLrt5nV2Be4NdhXX5Cj37Tg
         izBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739478352; x=1740083152;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wnB1KSLJK65kdBkVoTkyLNi38eugfTY8nHqfsoxDJY=;
        b=FhCvuflS6cDCNj7GlWT2h6in4Me5TlWuNnc6qFkBIlJh78GgvZef2UgxrIo1PQy3qL
         euFz/ruhFzDwo1OH9y23LVO3w/ExZ4DTCKNY3uMbZNG42VftXHeT0uQfJdkRU51F0L8O
         pB0eu/+SYDf+fbUf1c/ROF4EwwltZ/JMdE5URaxO8fJAT7/zcHiYLZ6H7RieD7J43wDW
         i8PpyPmlTyGhS6V4m81rszRh8P/jXCw4sUnC8sQhPGfGhikL/80yPRosk5HHHS8X4HnV
         RuHeV1fxUQhN7kfUAfh1dbyl3/ul9mQAMACR3fLzFA3nskstr8oebPd1UUOHrbARnqN5
         zjRA==
X-Gm-Message-State: AOJu0YzFpUA4AzKPow3BfyDWLYkide5icUceDY1bNne2srn2DMm+0oRC
	0tjS5VSNVwwSWek9Mt2wdXX7rMgjUpOXD678UtQUupcloQMOdpuDTmrUIpa6WWCTEO5dhPMrhdE
	m
X-Gm-Gg: ASbGncvwl27jKnJ/IXZa3OUZ36qeB6uvPF9ji5yZYQpEvPKxeFrLix3epiHCjqaQa2z
	1+IWwVk/9PhH+TNsKzw0yLkzYpL4MhfmGPjp/lvqlsfUQgJy2mwM9K6gh4RzupHG/KT2RoY8uN5
	qri38+I+3jr6Zs2V+thByNFqwSlMvDXV/FtXWfhKhoJ5e0fwW4500n3xeYnsHKKHebCk6oP/Lsc
	c/cP85VQ/3h3BAdkrbKcGjnwNv8t9zK/CWF107SnPC4YuHLJz6Y/Kmpxs4sdbxAzcnytHR296SY
	JgSzL7h8pHo7yyvAJfSbeLswYHX9oAjoLQmp4MKbk8Du+c43VD0OlZs6rx3yg9I=
X-Google-Smtp-Source: AGHT+IEtMXTc8U4Lg7IWqq5GHkN2Wa+cVS6/606cGQ/bwSkrP9zCfSnRzP9vpaO/pow1fNevynUj/A==
X-Received: by 2002:ad4:5fcf:0:b0:6e4:3eb1:2bdf with SMTP id 6a1803df08f44-6e65c1aab2amr59923266d6.44.1739478351990;
        Thu, 13 Feb 2025 12:25:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-471c2af31f0sm11318501cf.58.2025.02.13.12.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:25:51 -0800 (PST)
Date: Thu, 13 Feb 2025 15:25:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] Makefile: remove accidental recipe prefix in conditional
Message-ID: <a79e9e9f50410721d85747b03559d55be98bca20.1739478347.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Back in 728b9ac0c3 (Makefile(s): avoid recipe prefix in conditional
statements, 2024-04-08), we prepared our Makefiles for a forthcoming
change in upstream Make that would ban the recipe prefix within a
conditional statement by replacing tabs (the prefix) with eight spaces.

In b9d6f64393 (compat/zlib: allow use of zlib-ng as backend,
2025-01-28), a handful of recipe prefix characters were introduced in a
conditional statement ('ifdef ZLIB_NG'), causing 'make' to fail on my
system, which uses GNU Make 4.4.90.

Remove the recipe prefix characters by replacing them with the same
script as is mentioned in 728b9ac0c3.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 90c9662ad3..5b98a9d12f 100644
--- a/Makefile
+++ b/Makefile
@@ -1703,16 +1703,16 @@ IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
 ifdef ZLIB_NG
 	BASIC_CFLAGS += -DHAVE_ZLIB_NG
-	ifdef ZLIB_NG_PATH
+        ifdef ZLIB_NG_PATH
 		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
 		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
-	endif
+        endif
 	EXTLIBS += -lz-ng
 else
-	ifdef ZLIB_PATH
+        ifdef ZLIB_PATH
 		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
 		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
-	endif
+        endif
 	EXTLIBS += -lz
 endif
 

base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
-- 
2.48.0.25.g629188ede7e
