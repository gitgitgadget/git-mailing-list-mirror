Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624829BDA3
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205854; cv=none; b=M4ibKofrl3qYqIIoTA2JEs3uSdTGBjB4mJSxkoWwi4JORb68vK6LIf7C9FT2PKaEKzzQertsOLJRMNDRzJOWEatSnkcAyIzy/uugMA/9hhyZL66v5URbs02260dTPRsuiLrFIx0m9odewZK/Zkh8rYtKmzURTh+51RucC8UqVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205854; c=relaxed/simple;
	bh=vbm8NPu0BCB2pLri4azkjJ+5rQVIJkY4mYqpqUPH8Rk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lW3/eps7kZwQJ4FaWIb/9PEaGl058Q4t6Ehd5N0Xk7Fft84Jvrt9KdGLijo/8RhCG71kVaLgILAB/scaOZZhVot92wfRhrsapd0X/NDOUXuBEofUah8tRWcvURZqyIp2xf23oeG12XJKEZZXrOEYpUFINnSUFo9Eb1G4b9Ebpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7exaRQR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7exaRQR"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948f9b5987dso12339839f.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205852; x=1764810652; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyE9gXcOzCHNYlNbeO1KattvihM/g1viHvOP5Tzfx+A=;
        b=g7exaRQRUd6Hi/asix5Tutmff86/8CuIGN1lpE3NG0XkEx0taqmgCufWRh5Nly13++
         GzhmWakNTRxYjKWZGGPPmKufYQSXHg5vTScZB8aZogY4FZfSzDxiEqUOf1QG7JoBOesA
         sAHkPfC6avz5MVK61EpVRAeJs1hdkWQCZA8CIEXzFFikWxquIcYVXvpI7a1acdGjq3XQ
         0b1RIeTsML6h4yG0XM+YV3kGTKpctrzUr0RyGxBIEq5YhIttdLeCg3nzS2Y9rM0MBOob
         E34rgha7DH+vPWDAikkXJ6u6V51v0uMxlACQtdletWQ9o9piYJWH/hI448oEjqzPdYXV
         66Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205852; x=1764810652;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyE9gXcOzCHNYlNbeO1KattvihM/g1viHvOP5Tzfx+A=;
        b=juEAmsSCOkMrbeMYWR3U7jq9fXUVxTrzBgouudoMOeQrf/VVb14mfyptkZz50UWR4u
         uDdngdU9yE616vYT8+6Y5/57OEOBcpxRNa7swf27nYzjp3b7ctNRpdKdOdchHegFOMjk
         dYgL9Ft8DK811MsMF63Y+9XINalrhGwMeFTxAiyjJUMloPo6AHb4o/P6fRiHh732LAVF
         IpRZ2AL2AZ1RhVnb0dMUnt6vzxPGfpMR6pM5A3kdj5YH5c+99IQO3TGSxXrnZjjVu+Dc
         B2LjnapK/rIx8PB22LeZ1cp81lTqYwTqVoh758fmJbZ5hD9d+X7u9l+0gi7o4YjRXKzA
         rxAQ==
X-Gm-Message-State: AOJu0YxV3qVAHsXlgncbTBd6xfPgccdT5ei+YvIati3YuhxFXAuTHlqh
	7XFGVLEIC+Mm/ygD9DUz1YYWvCtmB541PmRog22BJupOwIcf/SDn7j9kPUEO01vq
X-Gm-Gg: ASbGnctOCrmDjJ2ROahBTUI+68ODKJYgdIpIlhdW2+D59BRSIJWImjfrHJv4ILOvBG/
	LDgTTJIZfMr2eqYPb37HoNMKg5QdOP4ge9XWp9Gv1GUiLwnFKGEdNDKAZ5FtmyA9BL1zIqudxML
	lkfxUKx4sru3yCjYDdI1T659ux/43319JTq4k7YXgeiFq/ebuPDvptEm6pzWeglTMQOnGO00WZm
	jr3Y+16bFd0qYZgSAhi3DTBDGsE/BGEt6SU5dk2gZz3pRJb9OepuK+H+7Ws/2f+xjKdkM6bTyHj
	2AUKCyksNz5C++uJjyluMiWgKbQHhgCtQbuOcEaAqyE9cbiSnU9j1FiUY79o069uxzApRU6BqQt
	Xf7FTWVtAjh8/60u/el+Y4R8eJDYDGKDV0ZrtsrT/u9GqUcHrHJgq8C3mcH0ZKchkkXnxZLzYHS
	psr12T2LDlfX9XBQ==
X-Google-Smtp-Source: AGHT+IGjNNDEsz422Estzl/N7923n8rU8M7ef/otg6+EoaCpHwkQ3V/eSrbokm22AXHtMAsuIScjDQ==
X-Received: by 2002:a05:6638:a209:b0:592:969b:a29f with SMTP id 8926c6da1cb9f-5b967acf28amr11643026173.18.1764205851995;
        Wed, 26 Nov 2025 17:10:51 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954a5064csm9261210173.17.2025.11.26.17.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:51 -0800 (PST)
Message-Id: <72429e04843a90e3cf9a1d697c1ca7f57de8950f.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:32 +0000
Subject: [PATCH 10/13] make: delete files in generated/
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 8a73afca16..6da9db7d83 100644
--- a/Makefile
+++ b/Makefile
@@ -953,7 +953,7 @@ rust-compile:
 	done
 
 rust-clean:
-	$(RM) $(RUST_LIBS) Cargo.lock generated/
+	$(RM) $(RUST_LIBS) Cargo.lock generated/*.h
 	cargo clean
 
 $(GIT_BUILD_DIR)/lib%.a:
-- 
gitgitgadget

