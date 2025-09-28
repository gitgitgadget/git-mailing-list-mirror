Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EA29C343
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097324; cv=none; b=fhd6Udn0lxtnneHjjdcgdRAXOoRpyFeNXC+pEdiTre6ZJ7zIm73e0GxE4HuelIYlaFz+C1POJOohP9DkB+nuJAwsz4zynwOX2EvSMoGMCRAgAENdIBV/Gc4sAikQ4Nq+nQQghK179aZS9n2IdPiEOTblov9Lre1JB4vVO6GFOZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097324; c=relaxed/simple;
	bh=LRELeyGcQKT0M+PuVlIAQJB1yCAnC2D2MAv6ouh5ED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuMeiqsYmcNjsdcn0hbds0i6JjMcp36WxmPGjZdPYZg9OEp/arDbgSx6Nnk/CY0q+eR8gCPZwR2asB+xScG2nKqiNGjhpZ73MbCVzHJ4OjDHdtZqLr0XPgVAE9Xvfg+wCglTlU6e9igVsYzcwWdSVaeuhTf9TirUipScew+Fo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=aE97r4Bm; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="aE97r4Bm"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7501c24a731so34104757b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097322; x=1759702122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xe+CFEAozmtPQviL96CwuJDqqWJKp/r7uPnmHjAmzPs=;
        b=aE97r4BmELzvr1i+tprf7m9BECtLXTOVK2zuIdizjYqTcf+bIfMFLsdTO3bdgcvTpT
         PWVwClebJ7KOGQTnryAEsTL5dmPCZqJ1hOWm+6yY9vrxMuXaj3Rln4XsIKZ0sEbVfCeE
         SkB+aQw/7Dgy7Lw3P7drumepnDMxO7/4/flgseo6lgidABen3I+HAkXfVmsIFhen0xgy
         m4yMLVqe07TdSV4whLl/EeHdi7W7tZk9q9rTUfNx68r+pumlm4YPBWg/qMyMDDKhSoxg
         0oIE+uKTZwtEui2znLSUQ1TDnOu6umK/mgO0RW1rJ0lu0MTjOvIFpvCfixL1vBmBaANf
         w8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097322; x=1759702122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe+CFEAozmtPQviL96CwuJDqqWJKp/r7uPnmHjAmzPs=;
        b=j0rYsj75BVEmZi7hmE3b+HUij+hsE+7bRmEyAh1HhSl3pvBeX2uu7ElzkkahM3N6FC
         ux1XuoTMS0lKn42140Zbtxjg9jAEildf6TP6SncH/DbyeeHaD6lGwF5Ps8Wng3HNgZ1L
         YtXfQXrdonvJC4f6R6oTxQBqz6FOqNbIM+QcUf0zubK6Bhoou+9vPtlO/2ZxvkHwQrAZ
         TkdlZsfHEOzklfJmRXL4ZVh70XYgY6NA36fiBQLHoldSnh+VEuRb+cbqd2J/LA0qj6RC
         ODpTBojT7RfCb1gPaXv0qcGglo5/ZpXIUdPEviMg3uZo9O+2Po3diR0DRnsedLeYp4Ui
         Cdig==
X-Gm-Message-State: AOJu0YzZIlEPEGdXixYWB4E2dOT/EohwzbOGPGOIWADu6lBzmCOv7yPU
	bc/reQvI5gpXTaIRMdhQM6nP0sG05TxFs71HsdHSjG6u4uV1egVGYgTEai545wfffQWl9vUQ4MC
	uIWrEwI1Kjw==
X-Gm-Gg: ASbGnctF0378KXl9MzGRMOtG3P3gMHIV8t2mXdHudY4KfTz5sEobuzscMS3AX/FODxm
	21/5OKMAa89KFoM5NRk8XxKmkmtwJdPgUdEGbBz6odkJxICGiR8CSt6CAl4FuDZuR403FUF7brB
	FxOc39PUeRO4NOn2JGeANX1/MMBOGueKsJAILID+a3qVk1ESIhwMAqBNSGpMaOEfJvh6s+XYFvG
	lE2lYmCdS8cZJcFPeKdZUCGgSXnokQbU1T3ZUyKK+fqTe+lIhCCzXOORmXMhh7YD1a4dMU6tDK2
	K57yP4x4r3P+dRBPUBRMFE8qEUdYumxGeoVZoq0tacrupNT/2+rkFmhtc//qV8bdRKbFkd+PKUp
	vupkD2odyh5JPzfHmtk5/TRLTkQyR9mDLByKA2sW8GUq/6W3MjfrHHO5TTCNnVZuNTHSFqzZ+nY
	72EUue8pOQ0DP7ry3o6j5Ym8HwOexXUb8Ni2TW
X-Google-Smtp-Source: AGHT+IFIPIJMnDo8BP9rp8wJ9FqnMJZi6UCZsTQuV7LamnEIjYmJSJtWJGijsN9NKjG5n+t3Crn92g==
X-Received: by 2002:a05:690c:4507:b0:750:1c8f:e5b0 with SMTP id 00721157ae682-763f8b4da09mr130879117b3.6.1759097321674;
        Sun, 28 Sep 2025 15:08:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d8bbsm1932267d50.20.2025.09.28.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:41 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 23/49] builtin/repack.c: provide pack locations to
 `generated_pack_install()`
Message-ID: <e9d525d83a2f763429bdeb89f6f73f06a70f3319.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Repeat what was done in the preceding commit for the
`generated_pack_install()` function, which needs both "packdir" and
"packtmp".

(As an aside, it is somewhat unfortunate that the final three parameters
to this function are all "const char *", making errors like passing
"packdir" and "packtmp" in the wrong order easy. We could define a new
structure here, but that may be too heavy-handed.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2141c43bd2..a4f0a19453 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -185,7 +185,8 @@ static int generated_pack_has_ext(const struct generated_pack *pack,
 }
 
 static void generated_pack_install(struct generated_pack *pack,
-				   const char *name)
+				   const char *name,
+				   const char *packdir, const char *packtmp)
 {
 	int ext;
 	for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
@@ -1469,7 +1470,7 @@ int cmd_repack(int argc,
 	 */
 	for_each_string_list_item(item, &names)
 		generated_pack_install((struct generated_pack *)item->util,
-				       item->string);
+				       item->string, packdir, packtmp);
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-- 
2.51.0.243.g16eca91f2c0

