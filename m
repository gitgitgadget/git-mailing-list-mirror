Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617D39BFF2
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787176331; cv=none; b=rrMaW+Cocr1euX5NyBiTJV4p/qgeb5MovC4YokxRaQl/lITZZQTWNmm+vtF0Cw/eQKbfbAJoK/2zh91TkgO3p9/GhumSL7QIe55R+dGI9kuntvY/IUytjOPsydi6Oz4p/vzLoo2bTAKIATdoIr9kF7XU17wL5Ehd5Ke3MXGeC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787176331; c=relaxed/simple;
	bh=jBEY6i4QQp2oiEQpieRK/yn1Fc/dPwqUZrpvJ6tbE+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0KIqGPpgV0mIQTik8fqeB8DKGCQpoKu/XlDPTkMfGhPKW/Y6vLXN0anj907FCjKg6DidNHs/6M35UJyc8UmJrRZO8aDZrAqtbntVrHYGAK2WHDWc78MnOh5Orj6+bVsuEAVP0HzaOnu0SGolXvrtaTtcsYHeCA7j7HjRF0mJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6m2fJYf; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6m2fJYf"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b12d146e6fso720835eaf.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787176329; x=1787781129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jBEY6i4QQp2oiEQpieRK/yn1Fc/dPwqUZrpvJ6tbE+0=;
        b=J6m2fJYfj2OzQLFu35Mogig2r6dooF08XHynF3CAeBLCmFEkPGD84/zDJFjXZaPV0L
         Eh/1CgTZVIZImN4pYoOXpFCPRgNgyTaUC7GCyvKomTmRS7o3R7/BvI2RsLtShzn1VIQp
         zChvp+t5GOUvUmPONGWPaR/zu8cTEpc7kcRWbSzG2wf0vSVoCdg4cBIEXOOpDlbpGe/j
         fMAMQ6NuQX06cBke52YLjkdqv0USj4AWLAWfEKZfnBAjg2Zi96wApy0O4WbbDofX+z9Z
         p660qlCIqGo6jfYpT5/XMW4fgPwMEMOAqUlRc06FI+0i13K2HShcPpmDkDBXrxR89FHC
         5mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787176329; x=1787781129;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jBEY6i4QQp2oiEQpieRK/yn1Fc/dPwqUZrpvJ6tbE+0=;
        b=kAVBHMNAdPkLEXkYcTOxAkiLigRpgdsiiFrqXSyqM58CFzqDQYtT6aeJzDanu+R+1F
         3/9Yk8UzYnVDiGdVvoj5c1fjSUeT7wEPD6LNqHXHnSoZmdYOFDJMarUd/P8GPo8JzbBK
         Esj0pGQog5IJKkg2NWw9zRfK18+36X1XY81MPqPvHZkIFZxYDEUH53IlMTRLLBQQtNLe
         d4y5Fi0O959LIpKM2/g27A/o7Nw51pq31pOsp80X9G+tVHPtdvIeEEjTJdySh/XlwH8N
         HtEmc97UGfjxtyovjypW98b55zh9QbW+/WS0yxoeMk6D/zmPgGPDget2J4Lzn0Bvvkqh
         7KMg==
X-Gm-Message-State: AOJu0YympZtVE7rAsnDEwbYSOXSCf6aZZdzAaWI9dUQ9DW0VQER2BcJk
	bV9fe5tORMYWIxLUFjph2TS4cUy9YUhErt2WR165DnBal+WO6Zapqjvd+odBMw==
X-Gm-Gg: AR+sD13zbbklV5MVOGf1zadGgPwAZiDUd8TnWS2fqXRCa14Sw/LZQik0WefykaMgxIV
	5DcxWi6rkT2ShiZ+rsbTvtj7o9ARHJRHC0tnTeE7JGjrultGv+kU8GhPvJbZ4evPMdkgqHda8ko
	v2D7I7103cMlTxKd4jLhMtrFllga+1KZRFm2d5iV/q406w1s8s5sui34cgt1aTpKQnMPlet7Nal
	etksYNU5aJNRCeilKHGVSrJ/GX8XnjK7M0+OeZS/0q2zmFhCJq84rAPnRE9nerf5poUKtuT02c7
	8Q1qyz4DUSW7zIO1xYJbLGuXnwf8Czys2FLzTnnRq6o5MmOXQljJB6qVoo7XlIRCfA/fOtjDl+m
	v+mhZvkLKuHQDo3o0yXcg3sFa4vaDwwVwOgUHSFKOovixLWklWHsqvxvf0HetM2go+4Qp1behtz
	sCbQeKBAvI9PxCnWsQcjrZGUDfhXRsqjqlUeHEneUio5eruvp8o+purQ==
X-Received: by 2002:a05:6820:2222:b0:6aa:de55:1351 with SMTP id 006d021491bc7-6b13c6b39admr7006181eaf.33.1787176328811;
        Wed, 19 Aug 2026 14:52:08 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f440022fadsm2808905a34.17.2026.08.19.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:52:08 -0700 (PDT)
Date: Wed, 19 Aug 2026 16:52:05 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] bundle: generate packfiles via the object database
Message-ID: <aoYkfl3Q2_8bmijh@denethor>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-6-4c8a96ccfdb3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-b4-pks-odb-generate-pack-v2-6-4c8a96ccfdb3@pks.im>

On 26/08/17 07:39AM, Patrick Steinhardt wrote:
> git-bundle(1) spawns git-pack-objects(1) directly to generate the pack
> data that gets appended to the bundle header. While bundles are not
> part of the wire protocol, they are a transfer mechanism for packs all
> the same, so convert them to use the pack generation interface of the
> object database as well.

Just to clarify, so the intent here is that git-bundle(1) can be used
one a repository using a different ODB backend and still generate a
bundle correct? The bundle would still ultimately use a packfile as the
common language format though.

-Justin
