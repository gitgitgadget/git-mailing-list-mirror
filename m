Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199485;
	b=NEu/gBRy1xGeK+k16tNLNMHRdUABWVz4eQOOaHyHUIDefY3ijSkDLMOwmj43wl3hAiQR
	 ONFjltKjIPpe4NZWtYIfEB7mUgnFY0JJHqMT/jz14iWs01OWQ05DxA7cOMeaodOhkaVPz
	 Ut47NBwuhRO+00XsTbtTJJ73vI/O69Kat8AuR2MSFoWey/Omijq4aJa5BSw2DOiRHROdh
	 ySqscCuiCa8DzhMmyCjjnVjerMc3ak4QnUVgwnrcVzklgXhbxPFWGkaOb/3fa7OlNDvwZ
	 Zo1r69RsBWqf5n/qOAbuj+KUO4i0Wi2WiDMtw87Jq38LOsd9fmxwMZf9D9U7Y9PninQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=wnWox4R32Bl9RnFhj9Bb5gAyaGuujHUVK55cN7MPsS8=;
	b=XUR6q+EjEkEUkf4NEb4P7UZMNrRy32EK9g76udw45yz8xRlpi/pKgdBPik6yyGa3OBVz
	 oPEo5XCYA4mPxfM5cie6cGxlopJMTjuccgP8Jxh/mQHv0AmbCOvB52FHi3cS/YSqNiAZk
	 zBMKxj7PFFZ/Hs2cO+VXIliJ/JDkQV1ROyXt9MUhaOo6WPwKbWti5HkxEC0GePqfD6bLV
	 ZnmIRVy98/zfOdvUHjLVSzN3hdVtNruvkeFYp/LBu/wXf1zEyep+dsulL8bDLF0IahK2p
	 XtlRqGx4EgFS3jSk1q5SgFJHJUOOwZ2PfTfHa4bsdcPlmx8Maa1MfX21ocITJGFhKtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDCdmN3L;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0A606A334
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF0A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDCdmN3L
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so761969a91.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199484; x=1795804284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wnWox4R32Bl9RnFhj9Bb5gAyaGuujHUVK55cN7MPsS8=;
        b=HDCdmN3LfocOu9+TyIYMey1ZaUiv7g9ESLZE+Ny+Rhfjwds4AxWaTApe1u318kZxm9
         ZG0FiIfOqjNcyZqO7VM1L76+Yi0YZQ1QuYdO+Qq0ezyI2F9UGi8py/8k5tvrYMBZ1yzN
         ZnmXqND/RsHlxf1Koibi5eFO8tfETbKcpztKCCVd3tuOvykxlbc+QS71PXuoia02BOrv
         Bqp+CJP1N4FMLVnIo3+qI9tWnxBUxE61H8DYPgAn5PC8uTv0kyy7t4/Vqj4o9IzgrfMT
         1agvKeL4qefk7uBV/XP2JopYVg4KjfaZDY2FZqJfxi+GCfho81cNfwg8noZAvSKCg8zw
         sO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199484; x=1795804284;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnWox4R32Bl9RnFhj9Bb5gAyaGuujHUVK55cN7MPsS8=;
        b=hEmva0b1xu9JKrm5WZmyrNA79yPv4rEWxprqgFVHeY59XhAy9UTYbrxS6485QkZiyp
         76lVeNH94JUvNh7OXZ9byErS5EAlwGRWxi+HXdIf87KEH4ASUEfhSz0tcL8EdKB8S1x7
         aVeZHP6p9F7//Ya0/MCmHZd9lVkKbAQWPQjZeaPWaY6GerZEI/eihnuqGzK7qwla43Gk
         gg+u3BKLTJVQmejUHlcdIxOMRsJz68BaSurVwYTPgQAn52xDMIRFQtm3MEEKWm5rbGck
         QiTg6zXbFPtNdgtqY6GXLql9L3299GWtKLy+DuDC6fAVApO9ZizeoMtxdYlDcDPpVLpI
         n9Kw==
X-Gm-Message-State: APuU4Z8EoWSDt478YVIThS/JAtPqXOZwFDfybSsajVEavN8+W+z9tnsu
	ftQid8OiKGOpPsI8pJnsUmCiJBORRZ1BVrJc5d7otwF0qNtwJJ7bT9zxN5I65Q==
X-Gm-Gg: AZFdTZeqDFAUitBGTzkleQf9OdgjQMgDnr/62nsqKc698C8btNnkmZep6gnka0+3eYN
	2/xo7bj5NHJn/fH8iFQYkaICyP9YWXQYzyZ1z7IyiuLohlaf01Pf/DqlvMARStE1k2zFLlK2qyw
	iKQ3FxFx/F4iMhjzkYhVFYPangInv2TrubO144koWynH9JhdaUDmyLkXDGjYT6xaXo6SvmmArpB
	h1NHR3YQtT2II6Rs+Kp3v9BkudMKDkCDOrzG4LjZSzBfISOneyXh0kUg+vp0Zc3o2bX0e37aOgm
	i+SsJNvG2wVbQF1IWnBre8cZ5P+75EJO3GR78cm4prEA6INpp4weizcpHrK2eeBmLMQGQCfYviF
	/FgPN8Nqh9hsc8FTFZZ7jGxYuzLldQUZFt8d89u4aizQDhtOytgg8rcpLzqfCUWsrpMR5Bz0Pqd
	xKVxPj+Q3CIevm0SCic6fP4zZkfHF2/UVAEZx6+zU1KNoXM9zrQj13zCTavfPzAcFGPQaIil5KH
	AWjY2BhVFh5kocQRpmd7yCp2/F93aSbeYHD1vY5JmY3phgTzPb/WoL0rCadjbEQgV9Y8lZzpqqt
	jGsMGEsx69NUjzRpqEOZhKEasgLZoN/6+3J06zzoxeazNFu39KWyBCEWrciHiSfnPswGH30sRls
	Ly31V6R/f
X-Received: by 2002:a17:90b:39a7:b0:3b3:9ce9:f747 with SMTP id 98e67ed59e1d1-3b41c9b2d4fmr3491801a91.19.1795199484211;
        Fri, 20 Nov 2026 10:31:24 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-142.us-west-2.compute.amazonaws.com. [3.42.157.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c13sm5205841a91.14.2026.11.20.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:31:23 -0800 (PST)
Message-Id: <pull.2495.v2.git.git.1795199483155.gitgitgadget@gmail.com>
In-Reply-To: <pull.2495.git.git.1795194253192.gitgitgadget@gmail.com>
References: <pull.2495.git.git.1795194253192.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 18:31:23 +0000
Subject: [PATCH v2] doc: update README file name in my first contribution
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

The translation notice in MyFirstContribution.adoc references
po/README, but the actual file name is po/README.md.

Change it to po/README.md.

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: update README file name in my first contribution
    
    The translation notice in MyFirstContribution.adoc referenced po/README,
    but the actual file name is po/README.md. Changed it to po/README.md.
    
    Changes from v1:
    
     * Update commit message grammatical syntax

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2495%2FOphirBleicher%2Fpatch-2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2495/OphirBleicher/patch-2-v2
Pull-Request: https://github.com/git/git/pull/2495

Range-diff vs v1:

 1:  4e8ec81b21 ! 1:  11905ef191 doc: update README file name in my first contribution
     @@ Metadata
       ## Commit message ##
          doc: update README file name in my first contribution
      
     -    The translation notice in MyFirstContribution.adoc referenced
     +    The translation notice in MyFirstContribution.adoc references
          po/README, but the actual file name is po/README.md.
     -    Changed it to po/README.md.
     +
     +    Change it to po/README.md.
      
          Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
      


 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index c58253fd54..29dc402e5a 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -186,7 +186,7 @@ decent starting point as we can now add build rules and register the command.
 
 NOTE: Your throwaway text, as well as much of the text you will be adding over
 the course of this tutorial, is user-facing. That means it needs to be
-localizable. Take a look at `po/README` under "Marking strings for translation".
+localizable. Take a look at `po/README.md` under "Marking strings for translation".
 Throughout the tutorial, we will mark strings for translation as necessary; you
 should also do so when writing your user-facing commands in the future.
 

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
