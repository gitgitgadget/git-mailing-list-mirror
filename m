Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0A2D8760
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639194; cv=none; b=YyVVL6fy+xy2BNkgEbpbVv++VsMHAIwnry2u5UVpquQ4pdcwhEAZuMSWT9IpKAX/hajzs8BcjrELufq8fI+hcMo3Gx7z+oQWOc6mpRaGulOh51yo7y1ChOMQCVA8NNLra4WrAwulrErXmUXSQQj76/B6mt3QrO9KrZAAZxeswAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639194; c=relaxed/simple;
	bh=8yym7fY7pkXDbMBXNPteUIVP+DIwIPm5s8sfRyBLQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPg/Q4k/jtH0/candxUv74g+pDXbIdJkR+n/Hnm8cHsg/Gtbb+sBkCTDS1AgMK0elJMcl1azIdh9NSuiarokGoKV0xqEtt4F0WaPK73pSRRMNhl3t7q/BwEv4oPp/NhY688A945awOZo9a/yOI/QTEZHFh9b/oNLmEtOQB6+UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9sp5y2W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9sp5y2W"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so20325705e9.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639188; x=1762243988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=340U+UjMrL0swz+NkYJ99Ml9jQzPq8ZO24HCV3SttQE=;
        b=Z9sp5y2WS4e7mSb772b9QXeG6aCtTIX+0RpMkgeDv9KdiUYHUfagX739i1jLEAEt8h
         4hCp+o583ANTqklTAxbE3qkwtFKB5lH5bTPLtcssk1RNvHu00NPKvl9+TOvxdeOLPgf7
         H3uCuRwtRZcXoSo5RNbQggOQYVaSz+PuYxyyctBjJowp61fmxUq9b6gqnuofMVooxt/v
         KsKsMsd+0D/0WOEQAGsoErLgLk10RXUkrZNsbyj4C7KTFRI+vNLUXociihs0214jUDsu
         yuZrRXFopDhxH9trahfTYMg1dGs6jdH1rVoTjPbMRtn5aeva/wt/fNucxmqE+C1VOM/9
         HKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639188; x=1762243988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=340U+UjMrL0swz+NkYJ99Ml9jQzPq8ZO24HCV3SttQE=;
        b=jyqTQxrbWHVcfyA89C3nrrLAQLyrID3TGcbCli8AybJGbQPEKnQUfUp+9dgdrago6+
         z1rSl+QpZHnrbab/2R7+rgJPi9BDibl7kD65r+sHXZo/syDmBQBoyVxUeI6xkDBpR1G3
         in9fWshb7u9HISYIHwclwpzvq3MRbA1uQO2XT7E1xy1LYgLYikRNLs4BEFvYSypTm6eX
         N2oZFa9VJuqmkbQuNaQMcNl9lg+1Q5/ISriheQ9vLB8Vco9zWeAWMX9wNBcewh4HVlY2
         RNzqmp+VDqiqqKTCj4vixE8SuEY4oqQs4d5KXIr1Fy0EMacin6LZxWzhF7kEfN1CnGlq
         Jkcg==
X-Gm-Message-State: AOJu0Yzc4c5j1CuVrA/3CVeOVZdW58a0f5DW3+ggls6lwzIsUmZYDZeb
	N45EG4BTi25bVFsDtk01vG5eChEXivoN3s5RKBosUxJQT/+++/coadQ1AclL2A==
X-Gm-Gg: ASbGncuAM/XdjJPZsnwizMMEK0csvlwW9xl1qy6thd0qdc+Fk5TKiwSYiwV62NaOSXg
	m/KDy+UF6044AjBwq9EEw1YT/AFQ9KuYzl4wGNylAwUGIl60fq/Kt5uOUtU1JzudNXYnNcee8XH
	/bWzcHijfxaFLFKgyHCl5TeQuIqjTdOhspAtCWEdkraRjbKqAXpTK1aML9cJSpV8ck2Tt8KcRnj
	mLRpqw7tQVDpRL+5lC7F+AUr7UbBQeEzQLNnr0EEzVGTXerHcs4Pto5Q8+Qmy0LuM8kft9f4aBM
	80CZU+ra8QMq4JXK8JM3TzU/CCWLXWNVN2lJKgnU9FDpIb9VdDw90XcwwmKprg1AyTFm2HBm0k7
	grSAc1ThszBcUaXaaCN9ERjGYa5cb7z++lJ2U6WytrG5vPWQV77FFV6IGHPEXIkFULq0ur3zRVl
	5OfC3XC60aRXjZMbEMs8EunRXUoJw=
X-Google-Smtp-Source: AGHT+IGQ0XSePD/3aXN+SSC6F/CQuz7NpoYWXy72ENc0Y/H91aAb2G72aWoStbM1aR+Y/8yeav5PQw==
X-Received: by 2002:a05:600c:5295:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-47717e6ac65mr23103665e9.32.1761639188011;
        Tue, 28 Oct 2025 01:13:08 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:07 -0700 (PDT)
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
Subject: [PATCH 5/5] gpg-interface: mark a string for translation
Date: Tue, 28 Oct 2025 09:12:32 +0100
Message-ID: <20251028081232.3068147-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.540.g4ad31e1014
In-Reply-To: <20251028081232.3068147-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
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
2.51.2.540.g4ad31e1014

