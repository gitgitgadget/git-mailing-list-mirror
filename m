Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094119ABC3
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752341247; cv=none; b=Kmk7S8oJrJp77EmgUg/pHimT3zqg+M5+udZcc7HO1MwjnRTFnl4Q3Td7hjA7xJQgojtCArIP7SJLB4+8Z0OpM4y478Qpy1KUIK9/8xShrf6KYqQOOJ71+wEn39H18XMomOZ/mxg5Z8xUPEgQE6LB7f2IDUlBymlsxy7j8nBowmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752341247; c=relaxed/simple;
	bh=VuamH3nSPL1YaFcZUzsJlkgiaGV/F87cT3y0N514hjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BR6dYPFSRqECKbtIbmpAkQCSy8u8TlsA5Wmd1aeVG/xGHq8xYXTp6TBOkOMH1d4muySwYOYf6gTFlI4HRLBpZIwwD+YlJ9ZgBpaK6pLqpQsN5P9Ysi1eWk8h/Gg9y0YGCmQgaDPpydWjctzFjJVgHcGyx6oGeQiN8R/3mrkLaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiRGkMU1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiRGkMU1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2350b1b9129so22241355ad.0
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752341245; x=1752946045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqhdUhikATKs2TnULIMoKj5cJ0/XOwN7sJRt4uBfU2I=;
        b=hiRGkMU18c3fhjrSXAdbyidL/P8+2ehem44olN91+xyAhW3liZARb/7w/yhAyvfzk7
         hO8TP3dO27b6jeSZhJ46yEK+81Nxnfs/wFVgwaOqx+GWK6ngx/QWlw7UpZDha4aW+5TY
         tGrmzy5H3WoCrDCc/2u6y7kgl9LeBj64mYsk+RTlCiQLWTyVYieL6RhlRhXRiGiqAfsW
         UEV/TNDDQA9uCrlyo8zwqvaK/e/EUMHMPPaVUHBmRukFwgnGS+vffE+kqa/L2aW7k7yt
         JqdKQjgyOV/qxu741VgJtsYR62OWzn0KNqvZWVz+aUDyLvADOQgNEqxbB2HEpTfuFlQI
         zzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752341245; x=1752946045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqhdUhikATKs2TnULIMoKj5cJ0/XOwN7sJRt4uBfU2I=;
        b=t9+CmX3NiRthTyIqKmAEGEbVNqQLxsO3n87XQrNvgR26mdMdipiEXHVUUFIWg9wgBP
         vNidjYnzlIw7EZrmgE00xP3DEhQrfN/A9rFhaLb6uy5jWa5eSuF6486MVBaj4kYHKMVw
         pi2HfVtocjVP0Brfwh+s8e+JHfRxzfyJkIk5AHsiwP2EhdfG1odYckqnujGACchrehsK
         8oYzhknqdKCqA9Cb2X8l4Ieu3TLkdL6ctpH8szkucdqhGadHBKoIZSnZYaKmsjWEOazk
         NjHNT0E0+GX5buJYZgDM228GaQowlUnJzuKC6+mTwANtcE3sTQM8CgbH49gYC+u+3BWN
         d52w==
X-Gm-Message-State: AOJu0YwTHL14l68VMS4EtUJ5e3o8NEYV0HfxD+isUy16V+pQPzQnwYlr
	Zz7nRp3ELFxe4OFMRQCh0b+lyTYm0thMV5XG5goCS2Sk75iLebbeLxzvmavm5w==
X-Gm-Gg: ASbGncvP5qwjp3xgddS7mdgtUGvGJ14++prbOITChIAheCfo+FqXBB1Fc/kJv2iay5s
	Au0YGFW60g5YJbuCkMWs1GUa4pJRYQzXfA6/R7Y9AIJJVHleqwHZr/b+RoZ9ZeuvFjk1F11ZCo6
	a6rWchVGDovBx+I1dURgCFbw1eo9TJ0emjKLdph+3B0llO+O5Svv9Wy9O1DseW0r19hlfqiAxzV
	vjrYvS630T5nQwsAPVAapUFZgINRDh2M+goC9pkjMQynr+XZlMv85ie8APk2Wq4KGdMBqE1A4E5
	AgAAB2VRbkFYccKgnrz8To5BOffBSI46SeOUIIkwIXxqkDtCc1m2I8fpLH7T4AMhnbVkPjH7dCK
	JAe5QJgBIjF0e5nK13ewpoyi4jYPx7Lvto+XY52SjxcoA1XxLrf4zezgixYiTOPACyhESu8mp
X-Google-Smtp-Source: AGHT+IFFpH4LbuOBhNyZ4eSsNC5GPcVeWSmL5Vfzr0PmQk9sqHPKCgLD257MG1nMr54Uo409no0N6A==
X-Received: by 2002:a17:902:f745:b0:235:225d:30a2 with SMTP id d9443c01a7336-23dee0ded1fmr109302555ad.48.1752341244893;
        Sat, 12 Jul 2025 10:27:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe579b0esm7160858a12.22.2025.07.12.10.27.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 10:27:24 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] meson: disable PCRE2 dependency by default
Date: Sat, 12 Jul 2025 10:26:15 -0700
Message-Id: <20250712172615.11364-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makefile requires the user to provide the USE_LIBPCRE2 flag to
enable this dependency, but meson has it enabled by default,
which can be problematic, at least in macOS.

While a popular option and matching what was done by cmake
(which itself reflects what is preferred by Git for Windows)
could result in a broken build or linking with the wrong PCRE2
library.

While not git's fault, macOS provides a PCRE2 library in base
that is not usable (even if it would pass the test) and not
configured properly, as it installs a pkgconf module that
points to a non existent pcre2.h header in /usr/local/include.

Change the default to off, and let the user enable it once a
proper dependency is installed or meson instructed to fallback to
the wrap.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 meson_options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson_options.txt b/meson_options.txt
index e7f768df24..0a0cac6f99 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
   description: 'Build Git web interface. Requires Perl.')
 option('iconv', type: 'feature', value: 'auto',
   description: 'Support reencoding strings with different encodings.')
-option('pcre2', type: 'feature', value: 'enabled',
+option('pcre2', type: 'feature', value: 'disabled',
   description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
 option('perl', type: 'feature', value: 'auto',
   description: 'Build tools written in Perl.')
-- 
2.39.5 (Apple Git-154)

