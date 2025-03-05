Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B85539A
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133611; cv=none; b=UxZPq4szGf3czkC6AYbqxYHLz0iAv9wGlLwe5YAwoe1K0N54CgDdlJC6557xncINI0zTTaibgCXr76uiWDVLupEQ4DBsMgWG7w1iH/0EkpbLQYlueUHS4sm3GANbMg0e89tGiDAcMrePWYsLmZfxSIipigjOu/Rb/AZGF9H3RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133611; c=relaxed/simple;
	bh=LHJB4hcisDpJT3wPzj25+47ysToZ5njmbyKmpVdokxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I31uZkgSTca/rASw9zzjNgNUx2Vxdgu9bk7CmF0CZ43FZkhITE74SzUP2SZrLXpOv2d0aOZSgbCgkQ4R9GVjRZSlTvWlLaKNtC8IDwpI43B51XVPl5sk51K/n8LQ/awEo/tQ8gbDLWchiXV7bUULbo9T14/bGXdQFpLhIVfISmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=momD1ZA8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="momD1ZA8"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fd64eea9c1so32825887b3.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741133608; x=1741738408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHJB4hcisDpJT3wPzj25+47ysToZ5njmbyKmpVdokxY=;
        b=momD1ZA8ZxOt0jSDOl3gje33U2v3PHRuYRu6OHEUOe5xNgmYjfyxY4ykXRaSXm3PbU
         TRTNSnrDAYGNGe3Pyc2nOkXGMTj2OtcY6WBYDWpeUm0pzdHKkRxGRYDl9aDOixQEPc6t
         tWnwVfPpDLs6w8e7et+x27pu7UgCeYByYSr2akWEUk7u+CviNtcouoMh2WgrU8qCtfSC
         N8B0+6Ub2nvUwLCUA/IIXaTMleBHjlsBrMSgg5OTpxvMgO5awmZveIFsE2w+5P7u4yl7
         GOrmgKhPNiTHrMWmJKNltglHuhdRBwbQApRKvvWqb/XaEx/rBH9Jb/GwZy39ZPsMjDb6
         Y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133608; x=1741738408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHJB4hcisDpJT3wPzj25+47ysToZ5njmbyKmpVdokxY=;
        b=qUVtE2kCm4YHqDkMPEYhGxCw3asPKIuX51/1X6QzHeSESpjWie4d6YXmI5KX6yup6t
         dS/fNFP893RGV6Ga1C937x+yvv5N3lfU55BY5qv7XPbD68nZrDIaIr1TpKKEOiceCTHO
         Lm64NMuWU1sgASj5YGUYJt5ZfDtWCAJBdG6ivdhGFdbfH49mMM1sR47yTBUgFcCHwe7T
         bxN6YYzwtuy73aR5Y+IjqubsCfjGU4lnUwEHy78eW6wt0nzJkYdvhro/z/8Ccu7t/7aB
         x8v6jXp6wOrFsTNNUOZMulnQsK9SNXeqxuhYf4PYzHR7QCqTSx91k3X78r47NFXXlwpa
         qJJA==
X-Gm-Message-State: AOJu0YxMxBC3tBImQzBj3ndkucjJOjlbgWTTwfd6bUDqzGpkqjf9RA+8
	Gwe6npDkb1G89dldqeakNvUeJAVQoEpnsTv4J2gfYBsRSsrzphw7DhE3CIM7s/16+hE69goQJdl
	j
X-Gm-Gg: ASbGncsTPL7z5rVHTA14L+EAfZsC/f90gN5rqJZPoRrVd0OPMXBYUSkPnDaC27XIF+v
	xT2Ztbk7kMja3aO9fsfs5dwL2tmrwDhz+ffZofKgdaX2Klxk+8Wk6GUzHMcq9NKbldHRARpSQ0B
	Vo9MXLXqn3/tSSaEdvILhLEVgPfD9ctDY1Je42kowthZrm44xSwRBaiDkfyKmuXB3PGwYCBv1Xy
	mZgUEtFnVs2q+ACZCUr9Ulv920h89o8dcTNCvjEdXPrENpBlngm+9M2TsYR+Pp1+4ZEIaSAkgqF
	h3xLYhsdBLZYqUlY7eipr0N+GI+29drfapLKZATY7FX32AIBsCCCWpwF3Ffdq6pKFAsIO+O+2+q
	9UJTv+tRIP323JRyE
X-Google-Smtp-Source: AGHT+IGZgd7Y1cQjlekpmtRqLNG0usZfWUTnVqfAxf8QX8Q0hNHbjoU47zg1wNScJ0VhokNKhbUYxw==
X-Received: by 2002:a05:690c:4c04:b0:6f9:ad48:a3d7 with SMTP id 00721157ae682-6fda2f06a5dmr16772347b3.1.1741133608497;
        Tue, 04 Mar 2025 16:13:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca66568sm27026557b3.58.2025.03.04.16.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:13:28 -0800 (PST)
Date: Tue, 4 Mar 2025 19:13:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] pack-objects: freshen objects with multi-cruft
 packs
Message-ID: <Z8eXJwyO9Hh9npLQ@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741124116.git.me@ttaylorr.com>
 <CABPp-BHv2_tgeQBKU6v4mnwU8_wOPHfPPRcpRQZ8wEP9P-HovA@mail.gmail.com>
 <Z8eVcn1wdnaV2VNH@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8eVcn1wdnaV2VNH@nand.local>

On Tue, Mar 04, 2025 at 07:06:10PM -0500, Taylor Blau wrote:
> --max-cruft-size and --max-pack-size are the same thing from
> pack-objects' perspective; the two flags exist at the repack level in
> case you want to set a different maximum pack size for cruft- and
> non-cruft packs.
>
> Both end up as a --max-pack-size value when repack invokes pack-objects
> for the cruft and non-cruft case.

Of course, I should have read Patrick's and your discussion earlier in
the thread before sending a new round. The first patch should
*definitely* not be queued.

I'll send a clean v3 that Junio can apply if he likes.

Thanks,
Taylor
