Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0244A3F4
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791457287; cv=pass; b=NoVUKAo2mQnanEy0L+nVR1fbV3aLiHY7dU6/SoV8JuZc3GBEWdH33Zt7mrnkstFi5xdZ2/+Q4GeXh5BKR/zF6x36ZuhG9/YbdR/9dlGGSZGMn/giZlxHxpSvgVESt8lZsfeYrXygOjvcsZyEPr5iPZcExrd6Fr+i7CiJlL2SQd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791457287; c=relaxed/simple;
	bh=xYp2II/7bI7EDXLBpDRT4vUfuY3a96ZaARaqsRP7aBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZ6APx4B407VXC/eLq2KEp5RuPo+heAz0qzDbBvPYUXV7sgDJW9yYS4gxGk8CHj+B5j6YY0JCcV1ZXqwMBfcofWrxgbVlWuQflWrt/JS9Hs0ZOe3WiLb30H5cuAwXfAgj/EsG36DLb61mT6/i9rEHui+INv7kOaE10UTnq6/H8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0YQ6sKg; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0YQ6sKg"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a75f960be4so21248961fa.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 04:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457283; cv=none;
        d=google.com; s=arc-20260327;
        b=YyRZHjvL/AYyJjrryPtuxuSKT8jUHfwMpTbStTKmpQDu9yrTZn8q/99jwi9W8K4jQg
         oOH9sy9SNwAGrwHEGY1RemfkclP6rNPVaPo0CCmc6d5O8CZzxci+jw7NMJ2T1nnPQgvm
         AuNC2h3DzyGRxPamdB22Dkszi5J4gM1MAjIloN3fncbTy/RrGPdUhJ3ZTMwRTu5zJXCM
         p7P6vJVhDdVZrIxwFGP2kFXu7wlTEdAtuPCKgfTNgtfBXDvtiTiBetgmUA3+4WArz7ZY
         Cmw0k9vihKoziOl6jhOjT4ajkaqrOPwgwBgZHNkaPhTNztCX1ReTpvvelif7az8u017C
         C/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xYp2II/7bI7EDXLBpDRT4vUfuY3a96ZaARaqsRP7aBI=;
        fh=5iQ5cD2wfd98w3FaoBVZZ/h/CpFdpbVM7J2dJKYKXoA=;
        b=MibHkRjl5hB98Z9DQSUlv+HmIX+nAOlNU6347decXBWzX7UqhQnLG2Dl1zWoMBybtq
         OxZCQwGowJVBKxFm7r0p1F6hlJ7O6boyC8lrSyT9r4NHWS5lS6xCVeBP39jW+TEN08Sw
         KHFlgnS1CSbD7poLXfYfAaacHPMua+1fkiW2GPHUZlsg0F2znFiZp4Ur8Jf8xV3pUXAQ
         luXBq2W85rP0GptB812mY81HNIqPMZcnLiG/GX7zXDv9GcNwtVshI0Z0KZ5Dsca/TCGZ
         CLXkPKVEVMri6aKWspVcph1bjrPyipOMPkbF9V9yx/E2QKGmO0CsDYPGBjA7103+cYOO
         eisQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791457283; x=1792062083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYp2II/7bI7EDXLBpDRT4vUfuY3a96ZaARaqsRP7aBI=;
        b=C0YQ6sKgeIY/G1z1PWLKwsFw5wgs58ritCDjNZL+SUecUMeYWhklILcXbLM4qyKrnJ
         MBzyA3IwXGwT3p95pIbbz+dzuaeGyXsXsnPzTRj1av3E+3YYHEQUeT+zMwUUldVtRZDb
         z0G6H9POxkTWC8T5lbekpd66PiJsLwsOHnEeqwity6nNvSfGCkzJBSBpiJFqV4ie5mJe
         wfDyYYxfawRZJrGRYNrUju7tgIZPPPKUSdzR6rfADEfqbsbx1BwOQdbUUHzzlFharUrB
         a3Hfb/X30mzQcsC52zaRozjpKo5FbKbV4jhNfBnuOXM/a8O/cR6JVvForNLkAEDwiV+5
         rvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791457283; x=1792062083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYp2II/7bI7EDXLBpDRT4vUfuY3a96ZaARaqsRP7aBI=;
        b=DcT0auEBieSrAqklylbhaU2uCtEAxNwx18+Nu0m6eCrFYbgFdRbYByPvRCy7bJq04M
         JTJGwhJIPtSpL2ojUfiXp9fd8LDy57R1Ar1Qv84cUFjuUJbPMSDQ3nqt0IjhvzrcEXz/
         xcIrKPUzbtpGTZLoliF4Rx8kH5+TlsOBU1Y9Hi8/qzWHonui9olEYyXz20dbpjz1VBch
         scd8Rq0hQQqcJpJ8Bb9tE2xTJ1eHfkfU0WWSI09sTpeM/NfPTaUKRdpUXScYWH8eSzlH
         PqrNvLFfEnS4Go7vYl1iJPTEIwScI3NtcWw4+zTX9bMGDgAEhzCZjpfo69EBAaQ3avqD
         LmCg==
X-Gm-Message-State: AFq9FYI5rzEBc9Va8HvYlE1aZ5GU/JKsbFtHCcB4rfOb3ZR6sUwQzNub
	FjKbvI+hX5EGQN10ha9HKvsQENQFfISqXpU5VtyStfwB7mC8+JufwE9f6nqPopsenjxsr0Fz+Nj
	pIarBvtckf+ZYUDh8zydSWop+6F6TGnc=
X-Gm-Gg: AYBFou0v25VV34axfhTEB28WdajXiy0eg9upaBOpZ4nprk9Wh3VYbcAftk3EJ1crL/E
	ttM/WomMB2P+2w7kaHLy/FPEP01VUS1/HWanmZRzHki0RKnehp9+Ew0JOD+c/3K25fQvF81ZVDE
	VMiyWlyDHxAXOgAquhsYHKTLHGybFFacQxP2Aik4QorhPkrXA5VHNt7Ta5wGXX9Zg8cLRkkYOG1
	MtnvVX/jo7UyWI8LvOzDBVEoswYwermBT7OtxlGsMDs6zw+CGZsrrKCl+H24L/qn5/eTRhh3RQ7
	3gjZ9EZRv6Fz/hAh9AMdzuxjIwfnSYJJ4EPGiAB3ZGuoq6093VJq1Y+h0A0opcYhUF9jRJHmuk9
	MF8Kb4dyTVSICFaSVQoPumc7MMXkKPMvI/SEf98wBK6qctKG9FOKpCmvc0XZJIOl55P6gsVA2fQ
	==
X-Received: by 2002:a05:651c:41d2:b0:3a9:7425:7c33 with SMTP id
 38308e7fff4ca-3a9a2d5e623mr12318491fa.28.1791457282673; Thu, 08 Oct 2026
 04:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
 <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
In-Reply-To: <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 8 Oct 2026 13:01:10 +0200
X-Gm-Features: AclHuK-K7dSEr9nrgL_Qfq4a1wzRSnuDcUrjHhGpVeYQ5Yci5rTnkn5b9jsaq1Q
Message-ID: <CACQ=SRGOdtUvxDEBeXz93nrC01oRaTALx6EztyBEfuCtnmTk-Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 12:10=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
> And as a consequence, reviewers are very likely to disengage and stop rev=
iewing your patch series altogether, which is frustrating to everyone invol=
ved.

I also read Notes from the Git Contributor's Summit yesterday, so I
understand the problem, and I'm curious to see how things develop. I
try to respect the people reviewing code and avoid being just a "meat
proxy", but I increasingly feel like I'm becoming one myself. Month
after month, AI is doing more and more of my work, and it's simply
better at it than I am. If I had written all of this by hand, first,
it would have taken me a month, and second, I would have made far more
mistakes than AI does.

I understand that the patch is large, and I'm concerned that this
could be a barrier to code review and discourage people from reading
it and eventually merging it. After all, the more code there is, the
harder it becomes to maintain. If you don't have the time to review
it, I completely understand. In that case, I'll wait for someone else
to solve the problem, as I suspect it will come up again on the
mailing list at some point in the future.

Thanks,
Maciej
