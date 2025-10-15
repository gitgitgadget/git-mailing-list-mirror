Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E430E0EC
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567296; cv=none; b=JvMTlHZSMWg+9li6zhsJOySAuPpBxxdr9EX3sqKtAjwT53q33QpIQkXY5ywVoYX4qA1t1QGlFev2PPb12mTfUrM1iL72OSsfZO7tboVb3HUV6bebXnkyUN4S3BAZ9pUiBZHZAyaf47TTVAYrYD4W3GLeGG9UZ6D1Pi7s9DMdGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567296; c=relaxed/simple;
	bh=3dJvJSFnapw28CafIXXyq8Rx/1FUVjEJPmm7PqurkrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O292jOyb8SVVFtGqNdQYsm3ZVs0E4ONuFRP8KyvV9CmU5gzH7iYCkMFD2gEMsumJefhIzy+aw5+Xs87HxlcoW3AD5inj/k5X4N0GaPYkaXJZArMr39g0lzXdzFVfjmfmBhytiJd4f3scX9WgZR8bA5dCHjv7xxUuPZlTR3MhaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DpB3YeA5; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DpB3YeA5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78113fdfd07so632417b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567294; x=1761172094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJaxGGKGsHTtaH/V22Gu1WgimdOESibD+8QTr0LHTSw=;
        b=DpB3YeA5xNqNnaRT9beUvTtxR49MI0CIY6VX0R3PFmnAGWL6TDwsyKhVQ/9j/etq7x
         hfpa6glzOXlY/ej0o56T9NLnxGwMR1oKzD2mCFjUYnb4r1V8/1Izi68o/6xslvezp36s
         SiPwh37EPkfvrWnpYb1G5JaxVo6aq+joDYsrXLFwcLxDo+D+lnmlN1LHEokNFWwvYGD1
         G6CfmPbxL8gDcArNNSJAC2bajDmUWjmSUnC6JWaROqCouLdteBjBM270YkmBeYOV5Q5E
         3FYIxAa3hCam3nLSTOfZkc6yd7xx52i9misPm4QgKud+C16dMDmE3KTyp5kB33csLnu2
         Zmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567294; x=1761172094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJaxGGKGsHTtaH/V22Gu1WgimdOESibD+8QTr0LHTSw=;
        b=jGaq/3zagXcZ+T1ly2jf9POo47iU8FPk5g0Eu1NsbRCYBQeDLg1Z633yz6s/oMlEgB
         bH47BckBLw3cx6H777aBRDRGfDYo8cl0Zbugv5c8T1HsSMMYlFH71Lc6vkGGPUVU3ucK
         NSyOXvDCd6Gbbe7toGIGFt2NCAhetEt6HHhMJVgQnu+6mABXgTcevN7UzM3NgHMGJwIG
         5jfCwCr8bIRuKOKMpQT4sBwU1fBokZpmDmUVarEgnUODaKX6P+AZUpPP/gHNeXCaSGGU
         ocHcrEv1nqYDOIcwK++22TH8G+On7IUqAgt5NuPmMduQ+YJGtjYl8f57P4mzcREN5Vt6
         4CBQ==
X-Gm-Message-State: AOJu0YyVAKoxg5zcj6erKlQ/FADMC7DF95d9TeJshbbN+zKSQcSqwkyH
	1iRErPz15+HHJ8RPTXKyizHs/runfIz/3mUtSEl7dtU+3rWz9Go0Aq0u54ezRkDizoVvaf79yN5
	tDG/02uO/4g==
X-Gm-Gg: ASbGncsctkSRJkCVHAnKPrGikLHrY1gyg+vEU8+JYSNN/CadVtnrhRHLdbywdNO6Ynd
	C2JDerDydWqhZrmUkF7/JaaBsTiZFpSNA2qu91E+B52RLm9g8G56nyVDtJ/dzRmzlDSFr5sRWlh
	FRg/wT2A487GGSIZeB1da2JHfYtSrlCiQnYNoO1kS0UHoIu/h17XOWtM3hwgJeoki2dAvtoe8B/
	pEI6sylwsAJcLrZ/LXMPYpIhWmWDDpWHSfczy7A6c+lLqGkdEwRYGnD3N9qb1PAykwSpENx9ULU
	m2IptxiSMLEyGig6bVMDPovKSQ8dkbJFYgBW0R/h3zxlNuujYPT+Lioamne1aS9abw/ZzyvLf4y
	E9uL4sGhB7jDgDScL7ffgAYCQrOJC2+1Vai0uNw6pMVhB+DxbpLoRJTvR6VrdBXDG3BaSSXsvNc
	HGlByFD5b7sD20piONbMXSzrp3F0jdQyMlIjij5E4KyiBReELl92NJPBggwVciIypsICn5yeuQj
	oAjScsk5SsagoMWxQ==
X-Google-Smtp-Source: AGHT+IGyQrEIkilXe1FB6N8tPeX8eGdTPPwskPUg9l8My1YB8JucMTtuYt2d9FjnMqS0x0aF3o2G6w==
X-Received: by 2002:a05:690c:8e02:b0:76c:f1bc:85b2 with SMTP id 00721157ae682-780e141ef80mr294177517b3.13.1760567294092;
        Wed, 15 Oct 2025 15:28:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828d3c3d76sm2739487b3.21.2025.10.15.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:13 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 18/49] builtin/repack.c: avoid unnecessary numeric casts
 in existing_packs
Message-ID: <46aa154b762ad68c67117d4072867a62c1144d4a.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

There are a couple of spots that cause warnings within the
existing_packs API without DISABLE_SIGN_COMPARE_WARNINGS under
DEVELOPER=1 mode.

In both cases, we have int values that are being compared against size_t
ones. Neither of these two cases are incorrect, and the cast is
completely OK in practice. But both are unnecessary, since:

 - in existing_packs_mark_for_deletion_1(), 'hexsz' should be defined as
   a size_t anyway, since algop->hexsz is.

 - in existing_packs_collect(), 'i' should be defined as a size_t since
   it is counting up to the value of a string_list's 'nr' field.

(This patch is a little bit of noise, but I would rather see us squelch
these warnings ahead of moving the existing_packs API into a separate
compilation unit to avoid having to define DISABLE_SIGN_COMPARE_WARNINGS
in repack.c.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c5a88eda12..e13943b637 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -156,7 +156,7 @@ static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop
 					       struct string_list *list)
 {
 	struct string_list_item *item;
-	const int hexsz = algop->hexsz;
+	const size_t hexsz = algop->hexsz;
 
 	for_each_string_list_item(item, list) {
 		char *sha1;
@@ -250,7 +250,7 @@ static void existing_packs_collect(struct existing_packs *existing,
 	struct strbuf buf = STRBUF_INIT;
 
 	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
-		int i;
+		size_t i;
 		const char *base;
 
 		if (!p->pack_local)
-- 
2.51.0.540.ga7423965ad8

