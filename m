Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5B2036E3
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130111; cv=none; b=qlZj5sEPt+swAN3brDn3JIK8A8gUQdmiooSRW5k3KxNJt2+sil6Ls8Nwbp2Sgiq7HsWKmn1W2Mdn3vxzPqAHOPPFzXgvgVaQMk4EjiuXRVZwkCYaFgUyCd/9Kn/4rV5sOy0IZrzJOPfB4AQovyfJl4HV+KdeXkojUhbYxvsYPPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130111; c=relaxed/simple;
	bh=tgu8W5xkDvM0V2H1CwB39WL6B50Uzy4ADj6kQhAwB0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQWhL1U0x3j2TR5cnSJr4zOElgkYH8ULvO78Jba4Qf5sqFibDtBWwx8C1CaVP9HC/g9oahdO8/Xj7C108tD2W61tW7fS+6tG56KeKKGGz5BCG8cWZJORH5PRl1/NnccDxO9vOioJzASarv5i3Ur7vcyUJhYKGrBgDAplfI5E7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l+PEANQP; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l+PEANQP"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so12620335e9.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 01:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740130106; x=1740734906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tgu8W5xkDvM0V2H1CwB39WL6B50Uzy4ADj6kQhAwB0s=;
        b=l+PEANQPOXJqQ5FXr4oBMu0e694hiL+MH/+FbRW+j3gb7+9bbn2015PFw2etm5gErI
         siEWQoL+3SGvMQXBE0oGdQ5o0dKHKyuwLwq8VsJPl4rHYiE1Mg2FwLZu8ZfoNB6pqyQf
         AiVnQP8disX7qlFltckc0YKRqm2gDKTVm5GnX7KhBCYOC+pk+wTZB8hegigA0AGkkhMp
         hfxqHqmbSa7Rk/lymA7r1Xi0CszY/NYE2zgCICtSYMPWKS7f8JiMKZzzSAAP96S+3Ofk
         ibuk1bORAKDHlJKJh9YYX3VHxCE5ANIp9bxLF9Xcj9x28qmaIllq0lCmopQiphNwwvfI
         Ai3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130106; x=1740734906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgu8W5xkDvM0V2H1CwB39WL6B50Uzy4ADj6kQhAwB0s=;
        b=PMKeID+I3t1SIsYMPf5mVwU/j7W0iFi+NBf95m5bAdVo6uU3VbVZvSkjwKufP+nhT6
         EiLeay2cLw7kNDIesUTjwxRbXY4BaimpiPa/xWajHx7jv/pYfs6i5PE45YWqUKcFgMNe
         SJ494rSeKR56qjGmdxeuByzqaEy0GheVKdVsS8SLSULOhvorq6wn5Ewij56MrmRSpPvi
         mvKZMp0BgzBGUAEWcL+RxkdkqYijre4/PhCiDLm0VSmanf1MtLXEYvMNodkJD4hu8aIE
         giYem/K9TZC7Ztjg3zI3GO11F89BmnMiPzGDXnCgGL89UP49SejbaiuApPfWyq19LsxO
         6WBQ==
X-Gm-Message-State: AOJu0YzM6k5l4AWvOE6Sb7GQsJf32Ka4uStjOdQheEOCYFUuNECjCxiW
	k4Dao/WvtQOsK56YpSRcx/YyJX2nu7XI3gpeOVrFhKuzOKLp0GK5hd3g0DiXqPg=
X-Gm-Gg: ASbGncsydH2KEHI66GGPe7vkfldJzaM3q5Kbr9Y0E6P3Y9RvP/Q0/0b9jA1ioVfu4aW
	wTte5RwH1KT5xDqeUmTg5o7eNZafJkiRu5SE1+gg+Vs9eXxCTrwsjjMeGIkJfelvHe8mXQ4FaYx
	FsVC7NfN+IPNa5wQivDhDZEUu16AoYPFHcPNWYMAo8elI6KknKZ8smZ/RlM3KtV0c4jkKT8dhY/
	6BQ03aeJyqFh1CM375P7wf7gS231PKsUv5SC5noCJSr+DPW5o1gUGNkSkKW+KXqM+RvHpVAI6k8
	xW8iCze0oxbzhlSc96ouvecV8K6KZh/Dxqbuotiudn7iY3FswQMPWdrhIaJQnjh+o4s4
X-Google-Smtp-Source: AGHT+IEXrwOZgNkXl2E5x4EgN0Mu0NSdb+5neZ5bv8lHeAOr+aaxwdSulqjLUD8trAxej4N1Sg+OpA==
X-Received: by 2002:a05:600c:4f43:b0:439:9a40:aa16 with SMTP id 5b1f17b1804b1-439b5aa80e4mr2594445e9.16.1740130106323;
        Fri, 21 Feb 2025 01:28:26 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce735sm11541285e9.3.2025.02.21.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:28:25 -0800 (PST)
Date: Fri, 21 Feb 2025 10:28:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: first bisection step takes quite a while
Message-ID: <4hx5uvjy7mzntb5zp6o4dg3ut44i46bthyfuera3lnbpbcvrey@kbo3ejype7ae>
References: <arrp2ye3kid76pwghguu5z4jkpv7xsskzdsjunbfkgmwejgby5@qh4phxwzenyp>
 <CALnO6CACJTKasKT9rX9w4_r9q0DPOPZhGnHt8f65oo6Q=8NxEg@mail.gmail.com>
 <xmqqikp4ctoh.fsf@gitster.g>
 <xmqqa5agcbx6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qzemjgiz7kkv4vpl"
Content-Disposition: inline
In-Reply-To: <xmqqa5agcbx6.fsf@gitster.g>


--qzemjgiz7kkv4vpl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: first bisection step takes quite a while
MIME-Version: 1.0

Hello Junio,

On Thu, Feb 20, 2025 at 05:40:53PM -0800, Junio C Hamano wrote:
> Comments?

It's long time ago that I looked into the git source code and I guess
many things have changed since then.

Anyhow, here comes my thought about how finding a bisection point could
work.

Pick the middle commit of `git rev-list --topo-order $bad ^$allgood`.
Lets assume this are 10000 commits. Check the weight of commit[5000].
Depending on how much the weight is off from 5000 make a bigger or a
smaller step up or down to find the next commit to check. So a scaled
bisection on the topo-order commit list. I think that doesn't
necessarily finds a best bisection point, but I havn't thought about
that a lot.

Best regards
Uwe

--qzemjgiz7kkv4vpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme4RzYACgkQj4D7WH0S
/k707QgAobK3G273XBcs6qniH+/ySCAA+tMCetqMaRx1RwDFENeCwdMz1c9O6TWt
rKHYNAvqx6Y3UdMtxo7Yq+S4PwK6SClJORaix8Aq6gD+ipalDSTkjnv8RZz4l0C+
4ERUVgmPacyWiAfGq7R92ZFU/mjr/s39ebIx0kFFURr75qqp7u5ywON8xvu6zyNJ
3GktySvi8do1KKUSo6cxtS7vM1Va8yEFo79bW7bpIJR19lGmh8HkBMNoTlJ+Zvft
1kZ0J7N0t7fQ4drIpr8lXWcrs1iZ2If+/N4772cinMZ2yfsrj/nyrfQH6VfBgSwm
usVBbtN61YGH0rbH9Opo5tirYwuP/w==
=7T2i
-----END PGP SIGNATURE-----

--qzemjgiz7kkv4vpl--
