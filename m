Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847624;
	b=42liIkVN13SvteLX6OSV0qXitbqn6BBifrAqoXH+JfArJGjSsrMdiVlYKkPCDbnyM+H8
	 GawRUsIVbd3HNijEyzA2EIZhUo1fOIY+HwbC/f/1rZ6uog+WNEbw093V3Pu01uN3J1kwR
	 v7Avs7nmmUSu56YIlj9jK2zGcI97gVMxW6jY8vftScmIs7W4aAcLkp880107m3s3xTV3T
	 mshzm77A0jbLw3KY2MVW+2hVMu+CZHRHVKCxFcbf1KUJifxNFLrCakXPOsWW9PnjuS8Mk
	 zFoise3GPs/kLxRJUYwXtiAdBu8DcZtkFKDaAk+2g+VOdywW+vfPgZCb/9zl1ju7Qbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:Cc:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Cp+6bz/1njH+guD4NKEtmQ9cEIraQ8BYePA1S2FNKhk=;
	b=K8LveyNU6UM3khjIM6zOPro/31iKTq7NFhArlSwGlaJRYkNkZRBWEg2cb61FG0h3m0xV
	 2IY5lDRMQb6ME4uORMc3kTt0/cjgnrI6TuXatcONH3pplfCY040moICLKCr3Peu+XwCpK
	 2OExPUR4aquXpAwQ7/WkyG1Y56BZytmDduA0bOAq+op/q9U9fjT1Y7wjLm7fKCF0YXFzM
	 AkZya19O9WTd3vg4HrOzHXHZWzI1YpbB4t8o4K8kuY2ag2bQEPsuoBQHqSMO8qzUYTKsG
	 PSwINg+Q9NMMuOQ821111TURkeH78AQb7SIR30VhdQbQVwXym49inua3/7zufQAy75Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H12Lrwhm;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A104606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 06:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A104606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H12Lrwhm
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc751eddf25so5511295a12.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795847624; x=1796452424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cp+6bz/1njH+guD4NKEtmQ9cEIraQ8BYePA1S2FNKhk=;
        b=H12LrwhmZ/8j3Wtyn2DAaiC6kmeWUmybWZPQnDODRJrLntCsRCGTzUYAhLX2x6r4yJ
         p14TLprOPVZPROzs+W1EFG35qnXpNxxtDpxjlrFtpLnxptPrlvTB80BRetSRGnwgJFe1
         dZJ6lxkQL+21GAT7cT6EjkwM6PB+U0IzvbrRg+Kc9dM3arvvuM243sJ3BSDZbcfCgJLM
         7e7LpaIFJD/brkaaKG1bI8b3nJBiQ0mA5QfF7Qg35FH7NrMNZ42N7xFRs3YOxGFh8nxi
         G4t74o1cCHpWEB+Q5kjjD5A4NKqo1ZZM6zuGh46U6wphNzOen6orkRgA6IHlRoNZGQcI
         g/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847624; x=1796452424;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cp+6bz/1njH+guD4NKEtmQ9cEIraQ8BYePA1S2FNKhk=;
        b=m7pfJQ2DrTrqACCT3qZVYVqKI2XpqSuDWx9cLK6hQN41NGlgq/O5TgkwqSjazvWpIC
         D6SUZirkw9c6gzQMyTkbYstjH0b63g2EQ1p/Bz3k6SpD2ycKJJnTDrvNI+ImzMq2jqCF
         XJdqar6K7OEP3+/AwAqmJByybCiWtmxil1QitaMd/dsILBQeHx/mSvGD8aUdBUPfj/n4
         tcHawXcAlPBA6P4qv7Bbgvja8Z8iqNR3a9P9/wOX0ct+RCHKg+6aVyclO100spfvBjea
         oKiMhmp1XOGTQg2Uo0dybnYKqoZaLXj/0trXmzFQCpKdsDWESWrVp4f++HnwBVq3BGwL
         XkhA==
X-Gm-Message-State: APuU4Z8Km0PCXpDJ+PPzLXLgNSlYRVQIMwAhvtiHJsM7IUHs0QCNvlHS
	g+LC0ZVnRM7QRBtfKrshGC5xnWKAUiQ7s87A0efL1nky8eJVL8zeyZi7DI2Lsw==
X-Gm-Gg: AZFdTZd9DE/4LXGz8Vu6AtgmivvJblIBMl9F4umh/+mWvTACYGppk+Bkrvov2DnCjG6
	Uf8k+mfIsOeo0ZbyF0DxnuKKSsHEOAm7h1DRFJnjBDTUB5wrkcVms7UGs86ei4giKpkA/Tyfp71
	edpk4/oEPQJVUgWIsTXTB/n/6PqQiHNH0EamTH1EQupUfplw+zGxeXZPKms8PaBDuzr6JRa2vUs
	x6Pp15Klq1pIVK0JU8Ls0AZ9du/CiKHRA1npxgGVSAuFEHNnp0PyrrOQKgUpSqgCOGtIysj8joD
	ShoxmP2zQZB+c5PkWvlSQP0IyMBiIq//OU4OJd1GB8TB7UwOK2U7OdgCnQLHe+RdNaAPyClDWBa
	eJCGMVCdHv7XCtjta6by09nef/XNhqHq0dybuj68rUtpEEiMUpnO/4LAX+D49sxl116E5uXoPov
	lMjaQTO7cUju8APgAEz0ikYfNppGodntKplHmBcB5I0iEFt74hts+VgHyZYqH8jg8YLb3JhVTrr
	uoLJg6X+ZuIq2X9ILjma5PsPGqY2LoTpjFKIsIfQhKuVByhKVgg/gB0/VbD3YZ5LJw9LY1TYnuY
	GqorAxfhVCGXrfl6Buhity4DWOPKZnq1O7dUNNfQYA+HOTA2XHxX5WO/Hty8iF6yBPn/vhvWex4
	HO3Mz6X9/
X-Received: by 2002:a17:90b:5546:b0:3b3:c44b:b779 with SMTP id 98e67ed59e1d1-3b41c935639mr29018218a91.46.1795847623809;
        Fri, 27 Nov 2026 22:33:43 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:ed80:211c:a254:fe90:c295? ([2406:7400:12b:ed80:211c:a254:fe90:c295])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdec1168866sm4297751a12.25.2026.11.27.22.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 22:33:43 -0800 (PST)
Message-ID: <73e555ad-5bd3-4816-8676-b25bf72257cb@gmail.com>
Date: Sat, 28 Nov 2026 12:03:38 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC] pack-objects: plural-aware thread message
To: Manoj <manojkumar148700@gmail.com>
References: <CAOVdN544jyuLG7XNE8jTBeA90iSBS_NanW-Cfn3XgOqTFgQJEg@mail.gmail.com>
Content-Language: en-US
Cc: git@vger.kernel.org
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAOVdN544jyuLG7XNE8jTBeA90iSBS_NanW-Cfn3XgOqTFgQJEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manoj,

On 11/9/26 20:37, Manoj wrote:
> Hi,
> 
> I'm Manoj, a third-year CSE student interested in contributing
> to Git for GSoC 2027. I've had a few open-source contributions
> merged, including uutils/coreutils#15558,
> kaelzhang/node-ignore#175 and bitranox/igittigitt#48.
> This is my first mail to the Git mailing list.
>

Welcome to the community!

> 
> Would this be a reasonable microproject to work on, or is
> it already being considered? I'd appreciate any suggestions
> before I start working on the patch.
>

I think you could feel free to send a patch for this.

> Sorry if this has already been discussed or isn't worth
> the maintainers' time.
> 

I don't think it has been discussed before. So, you should be good.

-- 
Sivaraam

