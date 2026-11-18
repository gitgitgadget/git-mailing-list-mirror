Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038844;
	b=qGlziI+JsMjSaNZkSrSSWlaYcyQdJJFJjD1c0Cf/hBxpQECZfkWgGjO41h+MNkidIYx0
	 J2YwFG8XOsCSgY3JT2RWbZ7yx/22pmnIa35XBi7pD/M8BrVXwS9ifvhTdjlhxM6W+UVzF
	 y5sSUVDowcIqDeP3IVdtIPDSeLMQ+h+aY7Bicarfde7gcXjRy4fxLSZxCgqyZ/84GEed+
	 DFicFQ0tENdtQExQ/wQhV8E1Tza/eYtvzzJuNEaEtg3AH58x7IY2dCZ7rolqu0HB9fpD+
	 8j6DfL4sfw2bkn8cqIk8dkbeCcrIdNdxXyrj8I+lr0Myr7mvUYe0zUjj666t3RgrP5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uE4rSojnGBxBd43oANqeoWzcXA1Mes/pr0cbpPaTljU=;
	b=FJ9GJsELUHbBcS0xJznDVhAIK3TnYrSi4iyb+xq639ejTfOm36VKp4436G/YDBWdyvis
	 5nUnBl1jZK2bldE8mMaIZGrF8HHU26iEsFvGa+TihP1PWQ4w7ZDEe4u+0sozS6H5+fxBx
	 Mg2iEHE0NJkplbHkdigjRzCpVcLPAKmnISIBj22C2OKAXNwz7r/Vi+LxCRjRGFRkJJ/Lj
	 SLpsAxPA5XAM6rHR91d2XvxBJhHfQ/vu3ixrVyjUDOtkaGxDROXV5raJNu7Xet9izAEOu
	 xMJ2Pw2QkP/1CvSR5/gCGhkRItLh+VNm+dn8su6Hvru0ozLub4V0ViNV0WbC8gPS4og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RWLML0t6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22A606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D22A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RWLML0t6
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b869ea8224so4659a12.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:54:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038843; cv=none;
        d=google.com; s=arc-20260327;
        b=Qj/XkBsrNs8SaGeRsmYvc6gYT60qOHCTSZd5t3kQy4k+KzpJaDWjW7pu7X6X88bekH
         PooDLLkCLHa1I98drsyV5vdmZhsaydCflnmciyAYoT+aJpmrVeEyoHHdQnrvWXJ1HbJt
         vPEpDdy3iwbBu0kNQTUJnwmpRq6B9r1R7TERCCbcSWOcCH6h39XIPWtnaJ0m589fnLHf
         c6qu6KDtb9KQP5crMULnMpUg7Ffdm0EuKUziI68WfuipacASl88I41vunQ697OFXvhO0
         WeDj/o8N9LYQc/cv8uHiO73Uuw7qwzWeZzEU+dFfq6JBB8X1shupTfTPUoQocmYMMv6z
         jGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=uE4rSojnGBxBd43oANqeoWzcXA1Mes/pr0cbpPaTljU=;
        fh=zJ8JK3udmgwA0dexoanoglnFGdvfwICv5ZUZgwZkLWk=;
        b=MwPWfGpGY22/asANyxozPBezBCCHfpDMucSrlrxG3JkQnt7VveyWa2mhH0xWlOID/8
         iHWDNiQpWHE+SuwOFGw6/Jf72qnqaGcmVBSvhkxTC7miz6pN4GAreUO2JTCxI9q0Kd7+
         9AYW1znjI1var/yRBGWXmo05lyEyt5UCPuu9Pa6exFr6HcLWYe9F0QfEqYfMerGYvXcb
         Rvwt/zQHz9UGEAO0pPT59sgcbIECzNJyiRM2El/uIyTiVLF3490kdfJZIYux7IVcy9UW
         7++QFZi7/5zcBvFpLN3ycwl1U/d1QIdWqq/zZOQpXy0S5mEINbw9DFpzG7wCB78gUe9P
         8FnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795038843; x=1795643643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uE4rSojnGBxBd43oANqeoWzcXA1Mes/pr0cbpPaTljU=;
        b=RWLML0t6YnyOFUMF88b0zmSVlEn1Ib87RWe8MkcDiL8mD6rfMbKvQk6l9NHEgedsBt
         eEtbStgQb/UGQeQReYet8PO66QFpgvrR3aFGz20DqC7aLhaiq1HUeX7VywQ7E2J5R3BN
         0ERimpCStMJiLiAHxeCQqTNJFDI05yEG2Epp7fqv3ZT6JEtG6h4wZhjOWWk73H7bdM0j
         gHWiX4/nvHGrK3hFVTM4n0788QMWnlEszR4XqAOnfCIwcUFv+HRvQmqARC4Af2mfXwft
         fTfy7P4IZW9lpMj5o1a9uiFKqjlugBLfE36fvZNOFE+IgN4uBVvwOts9zd8K1idOcVpv
         4bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038843; x=1795643643;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uE4rSojnGBxBd43oANqeoWzcXA1Mes/pr0cbpPaTljU=;
        b=J4a+38WVaRv5ICaYKDoDPDgufN25dDLJ62C9cDPj0LkPphR63MWtrYYK3rh6/3EayA
         bTFe3pOkzqpJv1MGtkUQLxh1jqwEPIjOPUn22ToUCDuFUztcjazo6AWgyX3EyumFVJQI
         yVsYjsKmTs6DFcQ5h9hhIoF/2Z04899Bd0HmwUyThYPyPjKWyzHzh1agc2y14YgExUtw
         OdiMIu9b8uBZ0XXU6PBmnA4apNXg9Ju59pPE4FKj5NgfsWjuNyx0CxRweLue3haV6o/Z
         jrVCucZCVLnQBdtuewLsviCONAM98In6prNUliAQzKFU4XMc7rY428el26pc4j74arB3
         QStQ==
X-Forwarded-Encrypted: i=1; AL+hErFFovN+WttfTI9Jsm4eAu5v0MPQSO1ZiOFJp4wQZFT/hK08BjeVS7BtMRWdduB7IUzb1IA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/t5p4n7bzz/NQ+MMqvoA8IrXotG7LQ5DA2JFFddarzNVSdXWrl
	V05m6WrePsnYZLt0ItH9KX65bXCDPHKKa7AVq01+IUyO/i9udhSaGx83QeP0S+jEIqTSauPynoX
	04KO37DkD+vZfaTUR3L6foUKkGIn48+FaMfgzIZyv
X-Gm-Gg: AYBFou24WfZCEDO3ChrYdoLIjb5bGHpAqFedbly7kyzKTGv+wlYDURhoS4QWeiBrsNZ
	frNH2aR1WRDTmt2A43KwEto3RcQjB084SeVZUrkdpDVKHC/svMklw2p866h9wIDthsyUX7XiYw4
	TBUJRiehp1/B9UpC1wto4BbkZloq8U8civQGLe32E9XvXraovU94mODjDylbv1XQ0y0AaPKCnqa
	2Efs/QyC3zoM0uGyhdritV112Zy7VS3PX0xeMW5HTv59xj+Q2vdDWvYyTcNOm2I2Cj5tOqABhKq
	iV0ZWZo+pvgyRy+RY8ZIKGyvu+j/4+DdvjxNpkpH3uhuPJz5Z4Ymkt+zE4OL2GNhw3Pv4bVtixu
	SVZiwRLbBMIpHocdEDljEfiExSMFx8JkIWhbSeam2oeJ012PIfttRkfztMmIhnnHEkPffshBLGq
	SNl3G5aqDSxsEHFaNSzYwY9+qfVGRy3aw=
X-Received: by 2002:aa7:c4ec:0:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6ba100a9db7mr8280a12.7.1795038842370; Wed, 18 Nov 2026 13:54:02
 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 13:54:01 -0800
In-Reply-To: <av2TibWYq_fHjOli@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com> <61e3ffe9ab8890908eb76c37fcdf4e44654d1bd9.1794022836.git.gitgitgadget@gmail.com>
 <av2TibWYq_fHjOli@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 18 Nov 2026 13:54:01 -0800
X-Gm-Features: AclHuK_-gzY19fARb6r7DrEuLShYM4zmCnCsTiCRX94B3pXv0wf5jzM8Rjqu5lA
Message-ID: <CAF+mdid=oZ69ngUYRMdhh252f+Q+7eD7r7V0G32-rg-d9vETSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] http: default http.retryAfter to 10 seconds
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> So we ignore an explicit "Retry-After: 0"? Shouldn't we honor that
> in case the server explicitly tells us to retry immediately?

Yes, I agree, we should honor that. libcurl's CURLINFO_RETRY_AFTER
returns 0 when Retry-After is absent or malformed, and <= 0 when the
server sends "Retry-After: 0" or a past HTTP-date, so the existing
retry_after > 0 check could not tell them apart.

I will inspect the Retry-After header in v4 when CURLINFO_RETRY_AFTER
<= 0 so we retry immediately on an explicit "Retry-After: 0" or past
HTTP-date, while absent or malformed headers still fall back to
http.retryAfter.

Thanks!
