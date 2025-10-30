Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970D3203A7
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827638; cv=none; b=KgtwLVw1qvsNJN4i6T735w+7814zzHfljpzDdqcmBp6jJrJJnZylqspu2YuxorW8Hz6C4MCeBBr8vVvK6nK0ztSqDlG5pSNNCREmTsGreQcAswgmERtLWJaO3HyamK2v4G/lCXB6k7J4QU3CLGN4PLpn5mWZJDj5aQ/KENoM9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827638; c=relaxed/simple;
	bh=RyQ2HO+QepX8CkbJIZnusDEtbOj5LXUtbtmhYWejdcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQnOXCOFvBqN5Y0GP3MZvk9gFYresd6EJzoDrO1quARESj4gT3ci6iLAJz5x2N+HfHmWMk1RmJnA12u2qPLK++HCp8d0y+9AYte4yoiqj8HLhQa4vW1XoE9lh2/Wpqq4BaEYXJibtylGflZ2zFUYbnWOR20wGJqHA/nym5iJRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhlrUDTK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhlrUDTK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so812631f8f.0
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827634; x=1762432434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/x3H5UhDrhZn1vdkjbvKEmH3pnnNJD0+9q1bECIeO8=;
        b=MhlrUDTKTwVoIh+5xIz+geIq/t++9pJIIoCq/l6C07gTytR1JxlIN91HwblomLP9x0
         v+MEhq+ClwC8EaJJZJE3PaXtwrp8xWTfsn3L6HE1yckSdokqr/otrfGobgb+6MmaQc2r
         CnxAX/oGj8XyXjyGt4xO8kOYshE8zqOdWh+G5LSiSobYp9YUMoPxnMDy+gyR17LY4p87
         RgnTiIM3qX7nMeav/hi0CI1lGvXueOSb4vA4644nKxHPwZPv77YCuLglaryUCd2xXLQZ
         kN0NgmJ0fSzsDNW6h12FMM0w/6GjQDIrizalUvJKsoZ3KSw1A4kiT3ddetLOvHITTWEE
         GEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827634; x=1762432434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/x3H5UhDrhZn1vdkjbvKEmH3pnnNJD0+9q1bECIeO8=;
        b=xOD8b4xzK3okgXNXuVfy2FQLsPkxpJvw6KAc/jWeP5gerfOuQXHTP51aIWFEYmsiZW
         i04/eVv3Ddj+7bgOpGJcHH/OFNBQ/4reXFPXFufiOAFxGtBigT6veIM81QZwYo8OotrQ
         rQToRSghvGxzj6C3na91TaU7cDgcI4JAyrYbScqF8siVAKjQEb+R2qMQGpEQH+c3VZtU
         qzkbRFBaDMyLBABvmGFy1c5RKkT3Xj/ftxP5auyNyr4UpNwt4g5i8T4+8utUOBiC+YJB
         91oZfZGCRL6Rs+hAPBqgK1Lm6GjVwjhPMPJi+KvU9yTx09EpNsPIniAzeZ29EE78Ao54
         Uv8g==
X-Gm-Message-State: AOJu0YzmHnNORS+RFh5CWm8zwDX/6pE+4MloWAbN4Xf/uiStWuWDLjIe
	kiaTousdgV3Ki65tdTNX2ETQ6fUpDLQs3w2R2ffJ2TYPctsidjJGK1mmSOCJ4w==
X-Gm-Gg: ASbGncvtoER9JhVQf/TGhowU/qdAEQwM1FnfbOHNGbjPcUUeDkK1uyTmkN3VQjacdL8
	3t2wALFRg678vq4R+NVNUkXRLM1KlvYAmLHf8y6xoyjia4Me3xGAvh55pqN9PQDjdM1MtA2WKIi
	VN2P4YxDiQtQXkFUhqvGuXY89Mbjo2LTacv5qCyHl0VvB1S1r8GaNw+S/nVfKIrnNdFpoRmMZWA
	Hi+vrZ7stKNaT0PcY4m2voKS9rhyV2HeWS33XAWhLATDEnZF9BL9a8F/nDN3wUjfGOqPxg0BVJT
	5i5j0sCr98f337C4WiOxOu8U0YJ7a1gO10skO4+CcmzsiC+eq0SAVq60ysUivI8zo6dVB/l8Pqh
	qUmGPqlIv9+9AMOYt/hjhPHhn2sT7485ithhlv7K9ugqYSMGJ2JJnnJM7agFkZ0b6KieLrx5wQq
	6ksCgXD13JhnoC76wTeU9GTv35gsTbnIDlQu3XOqjuk5wuXUs=
X-Google-Smtp-Source: AGHT+IHWxwaFpNKxGSTGa65FbhcVU9liPJ9JU902kbJXCq6nqNQVzMKqQsC2ud5DBBE1xM+NtvrcyA==
X-Received: by 2002:a05:6000:4902:b0:427:6a4:93d0 with SMTP id ffacd0b85a97d-429af0021a1mr5223377f8f.59.1761827634242;
        Thu, 30 Oct 2025 05:33:54 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:53 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 5/5] gpg-interface: mark a string for translation
Date: Thu, 30 Oct 2025 13:33:32 +0100
Message-ID: <20251030123332.3337684-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous commits have marked a number of error or warning messages in
"builtin/fast-export.c" and "builtin/fast-import.c" for translation.

As "gpg-interface.c" code is used by the fast-export and fast-import
code, we should make sure that error or warning messages are also all
marked for translation in "gpg-interface.c".

To ensure that, let's mark for translation an error message in a
die() function.

With this, all the error and warning messages emitted by fast-export
and fast-import can be properly translated.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 91d1b58cb4..6b895f83ed 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -876,7 +876,7 @@ static char *get_default_ssh_signing_key(void)
 	n = split_cmdline(key_command, &argv);
 
 	if (n < 0)
-		die("malformed build-time gpg.ssh.defaultKeyCommand: %s",
+		die(_("malformed build-time gpg.ssh.defaultKeyCommand: %s"),
 		    split_cmdline_strerror(n));
 
 	strvec_pushv(&ssh_default_key.args, argv);
-- 
2.51.2.617.g2aaa867cd1

