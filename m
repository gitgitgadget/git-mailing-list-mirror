Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400644BC82
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786540594; cv=none; b=LgpTeV5mdSC1uz7Dox5HLPr9liQnsthFiCFbG0sGb/doTy75CJUUo1M1oQ9R1fGCWVCRaG1npXKTQIg2KWS//KLfaMZOpC7T+zce3J80AZdWUFbhge6RqFXNQIAdcsJsBuIKqVT3STRQWFHZfezY/rieFVIya+zQ+eqqI/6H1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786540594; c=relaxed/simple;
	bh=hOHJUgRE2E0AYNCB6rAYsdzlaHdVHvM1iPo7w5/KiO0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZxVWnZcxrYK+x8Coeu7O8odNzhk28UqNSnr7+TRueWMEXMbks9DqioNi3MRE0D6tVTQiSOrjoWEn2/fMyfXQwojhQNCiDsdfS9ZcXlVqfPnCgtkrUmse3WhMkR4+ElTtE8VZiKbX+TzXC4N9keGrBjADXB2ncfMEONMzwF8x8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzEPsX9S; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzEPsX9S"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so963303a34.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786540591; x=1787145391; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c9BbOHPIf6MVYFlHeOoSRzLvp8xR60ysk2VioSrfjq8=;
        b=gzEPsX9S5EnFnh0z7to45lRQ3ylkgIrDLMDeGJIUYfbn1u5ykh+7JFsx2y2IEVMO+v
         IrWrvMfgs2cXCXJITRA1dWbBwLjKQgK9AXa7lxiHHclW+j+qcG10pcD9mpSXhDTNJrED
         ULBiO+pEY7/XL3e/KrBeOL6HTfbSSeYBKZV4XNFX450awg2FMaMRkJzY31rQVrYuujDO
         jx9/362Ql9Uk4uNJxOc81428GSOmCO+iNSYNkId2HxopkbY2HOpBfN0qglapTde7VZrV
         T0HsJumiJJ5vQt4GSGfRHHqaFCM0ckHj7icCH01+Cz9dMRfzEStOJbTTiDUvpHAHDs0c
         NJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786540591; x=1787145391;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9BbOHPIf6MVYFlHeOoSRzLvp8xR60ysk2VioSrfjq8=;
        b=eNaIR+sNxdJ5vQ/ZydIzdCcYdoFFc8A9a2MqVNa0aP5VF9hq4O52vC9csABxxJjoZr
         fil1oDpNvSuhZST7b9DsVh6/hTA/0sbnI3Ls/CsnSIBicmk6ciPQnq2nOr81S019Hw+p
         If8WHucx9uAdtuPrfzqFTS6TEg5gf7HWi5n3Rj7p8I723BMFC1JdrxZ/NNdIu/P1/JRv
         a6tmYPjqal8PvqfLgdYMylx8NOAKdjNcTS8Y018pcpmkHmXPCBdiyLmSZenOXQkyPuXH
         iTBvctJChyewbt1ibnFynlTQBqbGieB6oUvaR34Rlrbv9iUYd5nCC4HKK7gDMbfuOiZA
         nerw==
X-Gm-Message-State: AOJu0YxyCr6F34PXPtuyeB4BkazY+0ZQDrEqLrDRmEC8T/LaXLk+3yxE
	Wxr/Mlpn2qGRszGcZy6CW6XnB3pEt5V6LRu0n2CQMGssnFTvJfiLBKhmyhy+hA==
X-Gm-Gg: AR+sD11W6xnCPpC5bTcpfrdMACObJFfIlJ7rmAnmUe77Bt8CZ+UPQucRYDfYaFjv+w7
	EASY9CJoEHtIqHh0U3K7SQqQ7JMINkDfI85c5J41rmbt6/4NT+XzsRBsoF4oP9h4iYL+DMYsBEX
	8k40KQl/vvv1jigVR0aEsIQwngdUZc72BGSsZUEwh5Sqw4RLt8JbDuKyRZItUp2yhWkfrLPQF0a
	xdp9Z8BJoZXyKAiB2pmg5tuDBW61VdvQD4M+A1LCeJhQmpFkN8hyT8m/C99g9vn/uU15cgpP2z2
	lcnsQDfH/jvIiGAdVFwTJb3rCEKe9XojDLKNBNP9j0Nkyz+wP/2WCw1r0YC96NIzhAN2rYeGaec
	rQ5JaLHS6CLZ0ILpqjJ2B7M791RNgAqFnmOfX87T7rC7//oFzE2+aK/piPJJJZBoG/BDA65PenU
	yt037gbD3DvTxGU8JgKmJDRHEXs7gFfJiiFyEY8v6Xu6vwIThR49C+6AcxsjCwXakj
X-Received: by 2002:a05:6820:624:b0:6ac:8e23:3075 with SMTP id 006d021491bc7-6b0b24bb203mr3608733eaf.1.1786540591231;
        Wed, 12 Aug 2026 06:16:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.237.38])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0ad4745cbsm2695931eaf.3.2026.08.12.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:16:30 -0700 (PDT)
Message-Id: <75202a52d7912e67f6b92662f5349127c26c70b7.1786540582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<pull.2194.v2.git.1786540582.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 13:16:18 +0000
Subject: [PATCH v2 3/6] gitk: show color preferences on the button instead of
 the label
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
Cc: mark <mlevedahl@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

When the user goes to the color preferences, the eye is automatically
drawn to the color samples. However, clicking on the sample with the
intent to change it does nothing. Instead, the text label also acts as
a button and must be clicked to change the color.

Turn the color samples into clickable buttons and the text labels into
static text. Use non-themed buttons because their color can be changed
by simply specifying the color properties. (Themed buttons would need
a lot more elaboration.)

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 gitk-git/gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 137940defb..afc7c2d39d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11867,10 +11867,10 @@ proc prefspage_colors {notebook} {
     ]
 
     foreach {uielem colorvar idx label title} $coloruielems {
-        label $page.$uielem -padx 40 -relief sunk
-        ttk::button $page.${uielem}btn -text $label \
+        ttk::label $page.$uielem -text $label
+        button $page.${uielem}btn -padx 40 -pady 0 -borderwidth 2 \
             -command [list choosecolor $colorvar $idx $page $title]
-        grid x $page.${uielem}btn $page.$uielem -sticky w
+        grid x $page.$uielem $page.${uielem}btn -sticky w -pady 1
     }
 
     grid columnconfigure $page 2 -weight 1
@@ -11896,7 +11896,7 @@ proc prefspage_set_colorswatches {page} {
         linkfg    $linkfgcolor \
     ]
     foreach {uielem color} $coloruielems {
-        $page.$uielem configure -background $color
+        $page.${uielem}btn configure -background $color -activebackground $color
     }
 }
 
-- 
gitgitgadget

