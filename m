Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C439264FAB
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745239158; cv=none; b=scHB84Cm3X5IB/BuaFXBDcZ2Z5ciobmJ4/8QFHvb1Q1cMhtACWw+9bJESK5SAnnzY0POc1aClCnzdTX0QJzOt4SYTySsU/DeCR7XkKezvxfvEUHf8KiskYC+ozXkMPqzZMP1j+FIbTz6V48k/XGeWMrRIfP7aB4H2La+F6omRQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745239158; c=relaxed/simple;
	bh=r4ApJ6BpRYoffYlotNi0Gaub6wWlfWXSBVtgBktQeAI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=O6vJN8btC7M6pORT4pr3xkwqA2fPA4C1Ri7uMJl46Tp1uGBVkZqUM4Xm53tuNFh1r8LYwsU6m8JMwAdXP10Q3MVTyQVuo510CgYxMqCYRZSZ5NL5xxKwlxnhXcYMU3iTQg8vPt5lU1vYfJRxsD9Cev0E1eH3MywNyolJSJw6CYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1hOsVJl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1hOsVJl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso30435375e9.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745239153; x=1745843953; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbA7Nr7/4ODYZWUa5oik9mGMXCAH202DamVainI7CMQ=;
        b=a1hOsVJlGyhQ8JjtA0vFaLo1/+Bw031JNzb279ganOkmftXxeBTRdqLFvGRr37tEfr
         BtBtbcFDew5Guwh9Xy9czNSP25wvw5fSELKOGj9DMH2vUfXHLWzGrW77sHZ2JQkRviqc
         CgTpTp7eJ6QrvZgUqvYaphGuv8ZDWnsuQENBvJnBCg14lSB7VcK5u594Rri0rRYNkmoD
         HrintwbOXxoBxuE9aSrIr6MJMJQaF0Eq2ZzYz8ZnA2zEwn1vFqfTqv6GN3Bm1T7lTZ4T
         eT+lWPWE9TS5/ya0svxf2msrvgw+N7mCPbHhvKBG8C1vKgE+heVOhXxfJOEIcBxjC1+s
         e3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745239153; x=1745843953;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbA7Nr7/4ODYZWUa5oik9mGMXCAH202DamVainI7CMQ=;
        b=atkuZAByL/ZEalKEP38i5itQxLF1/nAuAzNJEYlDiJ/49jjoCUv6qMd9xSb+E+Ky06
         a5Ixk7rw8qRM7SUjeLcTfdQbHneo2E7LX3E8HQqNkgSDEDxZGAi+nU3cMuZh19kIwOLh
         uwK5cGif+O7DKaZ/VeC7Y/pXOhv/yIDHYQVbFMqNuUuynpKXNOXKYYzphRcbLV82tNqA
         +B+Q+sWJe/SIY1e0vPYsP2Afj1EDTIWvDudhQ1J4vJMYIQLq3Zbgapr0KyuAZTwVdC2p
         ttI46tIhcMDPQbe27joVA/PmmxjxapKX5bQt/79pLqkASlK/tl+Gd/Ms59j1BaR4mpwa
         CKKA==
X-Gm-Message-State: AOJu0YzIKWhFygchlpCHrgwm6+LKR2PxUs4fyaubfhVgHQaugAU+MMQe
	Q7NyTdP5pCS6Ho9QKDMjXb1m7wMArPeiufZf1MYQfBNfOWk4w0RyVEFhUA==
X-Gm-Gg: ASbGncs6MkNoImBYM87idpry0a0cy8pOhv/tz3eqQXbx5dT8TNyjUK+u1cT4sSfidgD
	jm3WQg7C+OjcYf3XTVly8wr8NBBg+nTi/lCMHC+Wy1153bVso4asqUMd1rN+oc4NERy2pKDhGyP
	U9vz/zTnBP7DUcZGpW8FHD1+fTM+Cfz2vrarRBRWhrlT3Eux5eHNcXgpf4aAYTF1VtFi7Bau5TX
	qxqrbfBRJ1xANyHpqmqnMRfvqcLRStiRrrs5N0xbPMetd6d8dKDn7XGZU6DesP2dRU7dge+7xWl
	TNTq2hrWiWTv+kB3a2lANLv6JXOHduxqLlsxUl5rvw==
X-Google-Smtp-Source: AGHT+IEL/NVkRzf70UswhaVU7Yw9UB0vEW/FmDimK7NuVZzthYt9rQXFPadfog+UwP658P0rY3wHSA==
X-Received: by 2002:a05:6000:1acf:b0:39d:724f:a8f0 with SMTP id ffacd0b85a97d-39efbace61bmr8457434f8f.42.1745239153417;
        Mon, 21 Apr 2025 05:39:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4d67sm11887139f8f.94.2025.04.21.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:39:12 -0700 (PDT)
Message-Id: <2feeadb0d3fb7a631489e36d861d112d46423f2a.1745239150.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
References: <pull.1904.git.1745239150.gitgitgadget@gmail.com>
From: "Dennis Ameling via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 21 Apr 2025 12:39:06 +0000
Subject: [PATCH 2/6] config.mak.uname: add support for clangarm64
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Dennis Ameling <dennis@dennisameling.com>

From: Dennis Ameling <dennis@dennisameling.com>

CLANGARM64 is a relatively new MSYSTEM added by the MSYS2 team. In order
to have Git build correctly for this platform, let's add some
configuration for it to config.mak.uname.

Signed-off-by: Dennis Ameling <dennis@dennisameling.com>
---
 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index b12d4e168ae..1e5d89f1aa4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -724,6 +724,10 @@ ifeq ($(uname_S),MINGW)
 		prefix = /mingw64
 		HOST_CPU = x86_64
 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
+        else ifeq (CLANGARM64,$(MSYSTEM))
+		prefix = /clangarm64
+		HOST_CPU = aarch64
+		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
         else
 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
 		BASIC_LDFLAGS += -Wl,--large-address-aware
-- 
gitgitgadget

