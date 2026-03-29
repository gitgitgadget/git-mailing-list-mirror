Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF145F9D9
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795197; cv=none; b=ry0+xGX5v+HwCs2VGKyX9O0JghpAYX9SYG8sEhl1qidDn/tvcCgSMRVJlru2xbhCu4grFsKmiFZoRmBy2fhAMoC23QJE1cVwB7Ml3n1BEE9YAxhCkhm5EdvlUcy8eQ7H0RsZBOMasiHrAkxWVnODDaxPCVXl27jmCBIJ8UtDREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795197; c=relaxed/simple;
	bh=HVA2AeLSkvUM6fS5q1jRSC8Dgy6fSRNPsGvNcFRprbw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=unEpzmRKEUd/NkocPGr3AfEAGSN89/CpVw6pMNeVB3wsb9U38g4iN7QOQIErN21pasmadGpsf52rb7B1/smCbhU/LBdvOVfkGmcBVRk/N1LLLgygTJaGpYDxIXOffrPBeX4rvItMbsl2z3ErYOnIK9uY39BEjKGKGyctmB8xFuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=begjMbOH; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="begjMbOH"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64e8ae85700so4502279d50.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774795195; x=1775399995; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVA2AeLSkvUM6fS5q1jRSC8Dgy6fSRNPsGvNcFRprbw=;
        b=begjMbOHHdUqVdMRQk9e0EQbccK6Nx9E7dN3l743+RY8m4jEdovnFNfhnZQfalfbIm
         7KsrC48dnEhfGx3cfRMlgu7s4WwjWt/VYSeFJxnNtFTZb/uG/1ifb1UlLHPl2ClqLRKt
         vI2y0jI8XgQctHaignU4XqvmTR/xRZIS/2PSnqE3/CKXUN0JFzhezlG3PR4gAqJctriq
         QjUJL0pRSKIJcofcePm25FmImGN2oHfuQ4Jsc9SVnoKc17LzSss4IbeLIc1x1TwVZz1H
         NMq7xW0DD+Cvow7Rjpgntw1rMgdtR8/Hvg+9zE5rRVdCkpiKHJvGxJTiHb53NNpuz8E8
         ATGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774795195; x=1775399995;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVA2AeLSkvUM6fS5q1jRSC8Dgy6fSRNPsGvNcFRprbw=;
        b=hjZElEXht0CtGNbXqQoXsAe3DJpL43uIn0Mog2XPNz3PGHDtZt81I/EDG7Mxp/Yb5C
         sF//1LjzOG6PCBzQTvBv6h6u1fOeiNGs4jbkOE0E9l7t3D5b3rhOWw1nXmfz2I0shNLy
         +9UGC/NJGlmlLy7X/AkihtfqrC5P271uGA7gjtdVK43XACCb9OW+phnE+UddaQuXs9dr
         3gJv4xfA5m+itu1cMyIYjorlI1DeyyJRNSFFiP5kG1LnYmXRxmLagg6JVjCee7fYey2N
         vsqEs99TvxEdzzX+HEbuPzrH4GHW3Y6bp81QR0mwsfbws3alDwuF5ZnZ6COFea7c3wY0
         F5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXdNj8oN8MiN7fK1bthwc/Vb+vSudDapthitR+lYNeMzJEaDzhmSj8NslCH582QNgc0zEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2t7MTPmCo3TNv3nM5sWbElUnJnczIEpmmzbgOArjBCfWiivAr
	LgwiIBSaMXap2ZsHjbwvNrwOk6Lrc2gxhH2xzYvYaz4Kn4uWx3TCLOqQPPisSg==
X-Gm-Gg: ATEYQzxQW6WUDEbGycd/cR11sTwWCWNbt6j6rDYNsioV8S+SMRW90ls7LtKp7qgSscC
	tjZHTw0X9hUL2VwxS1KnKDqX1lmEuyfNgw+aEfmFOJ4lwCglaVGs+B7PDrtm2CHA/HlUnToDe12
	5s7Nxe2AoQrhSeyAHrFuSN5AjyM7Y0rbmuUCGIKLRwV8yp9HUqAa11sg+aSHH++UFAzTQkOwdVk
	VtA8Js4sCV+VV5kLTF263tiArzrYODo/Q64iWVL2zf3HCgNxSFLKWCpUmEzYv2Jlv8hcQ+2PyDh
	xATwoMdPESuWqvrqBeUSW+TAIsG6gacsc045/zKLC2C47ko6mgxFc8+gCEfMRNSdDta2OUslm2A
	McOgzcGB3z8UVG9CybfRwbjmsVBblgubNihI5Slv4IRoVs1vQofR7OWfmpEy1PIw5hKlDR4KlmU
	Xo+wMRS01sujlledCIjlEnSKgM4YngqLyd3n/ZxRlsRWlLiEoRLrvdlHEFd647iKRH67p/PfO5f
	UJQqwwM+1GxQ9LR9l/GwWLR4N9AX+0ElhHHUWLAtndZM2N5zCtRih0=
X-Received: by 2002:a05:690e:168d:b0:650:1bc2:7de2 with SMTP id 956f58d0204a3-6501bc28480mr506541d50.21.1774795195154;
        Sun, 29 Mar 2026 07:39:55 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:841:cc51:4211:e4d4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500934c235sm2559014d50.17.2026.03.29.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:39:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Spelling JavaScript (was: Re: [PATCH 0/2] [GSoC] userdiff: adding typescript pattern)
Date: Sun, 29 Mar 2026 10:39:44 -0400
Message-Id: <74C8BE85-4731-4C02-872D-DFB65D9AA3FB@gmail.com>
References: <08f1c2b1-5f2c-40e9-ba87-f45cae6af541@kdbg.org>
Cc: Dhruv Arora <a_dhruv@outlook.com>,
 Dhruv Arora via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
In-Reply-To: <08f1c2b1-5f2c-40e9-ba87-f45cae6af541@kdbg.org>
To: Johannes Sixt <j6t@kdbg.org>
X-Mailer: iPhone Mail (23D8133)


> Le 29 mars 2026 =C3=A0 05:32, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit :
>=20
> Javascript and Typescript are related languages, if I am not mistaken.
>=20
> -- Hannes

FWIW, I believe both languages are officially spelled with a capital S: =E2=80=
=9CJavaScript=E2=80=9D, =E2=80=9CTypeScript=E2=80=9D. At least that is how W=
ikipedia and official sites present them.

I knew what you meant of course, and will now take my pedant hat off ;)=
