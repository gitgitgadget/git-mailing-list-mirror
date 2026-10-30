Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793340774;
	b=qh0O9TFNfl9qm11BgU54s3CGPOAiU+FGiGBHO9LHphIDNAAzrouCYHxw1xcG5gJ3vWo1
	 ArRVbPLIldWx70/OT04UnI1Zynkp0Jv9gsF0Ulq3AIvzTi52qY9twcNS/2jMJJh0PqNYL
	 6M7zPDBKAJy2QnNQaUvITwc275nBc4+rxfD6GiMRgwB+TPH+//JAjENw11xtq9wvwjQGX
	 EsRfeW1xv+RlzamejdELV/V27rM1ZBRbqcgVqzyiSlodoOp0AdWMTW1NQHpr9Yhp73Oen
	 XOxZR+vvLI/GFELzvom4ldAWa/7Ioh3r54Z9C7Ae4JFQzmuZ5JBPZQTGa5RHBpJW3qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=koLzWHXW97TNEzE6lZyfsMu4/INbSHZoqvSoVHdmAK8=;
	b=wnTdP1rm5JxEqQoQ+b0zpOxpDOTT/8ixDQu3gNNNjcjsN5GSZy2ssSh09VNu/N1hi5a0
	 JXUys2YsIYfFMhB48sTbUqUYP8LbdguD0Zy29i0DN9MvKHewArzDgKSV4P49rUZfzk0XD
	 jlTffldgS1/ETKHxCEzKu2tIwAKMI7rx4qn5zZjziFhdQC+ZP2rjENcyikY5ZTzHIGRZY
	 G2UtQQdo+vlkGIk087+GX0s5/jWWYv4xLzVNTo8U6VPjNmB88CLp56wcUtm+JhABC/FH3
	 KDK/FQJ5niFkbPNc00qv9y372tyKS16xK32tQhDc+CV3q+CRU3AATkrbomT0PdzAM2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nortesoftware.dev;
	spf=pass smtp.mailfrom=nortesoftware.dev;
	dkim=pass header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=cHEerX2O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DC7606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35DC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.a=rsa-sha256 header.s=google header.b=cHEerX2O
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533797e72e8so1924581cf.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793340773; cv=none;
        d=google.com; s=arc-20260327;
        b=LLrwptRlhiei25SWYrwO3U9J30TA5LuMGTh7+BNooqqm5fZDLVxsR7zkOFImYjMrER
         rCbCbBhM9aPPSWfyzbqAbG54UFlDQvmW9hStl38m/nncZa6wtX/d31QDCHNxuYTrxa+F
         dBzDp5qsMWZ3PCdtc2+V79QqzNSDqsrX+MZ9J9WCH5+xfuHYZUwTJRsscWQHE4Bep9bQ
         G9wQWLCrvT15NwwDGHLWw1SEj9f1IlDyPdAN1B4ZPVEm0zTJZjDp7/THC/VEeSEO9ieK
         CAkklwc67aUZspvylPJJNZbLzdJIi2j5vVKwiFD5anBfS/y4/eHpm8A5G3otvAYmtpXp
         f82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=koLzWHXW97TNEzE6lZyfsMu4/INbSHZoqvSoVHdmAK8=;
        fh=l6RrM80C46TPjLLpc0VBUcGGhagrqWQY3cTc92IWjBg=;
        b=hdr6/LHtgxc8j0bek6Iw7vRfyPw/CSmiFI5Puc3ku1IAlUoLRTRPPPBgFWzKN67Ys3
         sFdZyaHXSCdnme370i2b0SxS/ppxhGuwX+A9Zb/94zfvf0tjsYkIq2Jf3MmlSddoyfru
         GF5K6sJpgHLHLycSMZLjIGCgmLHSXhSB4IBH2Dhk8f0LLt5jskKsBavm3RFQNyJ+yMjm
         j7zVpDv0PKAqYBK/LRDcWE6QJRe0Z5sDHUaFBeAYeqvnm9K7ZAWfBUtWnzMnMVewAFQJ
         DBCvdOYBVGZcGKaI0UQOAXA1uC8KF8bRQWzcgFQ43ZuUeVSLjd4fpsSi5Ers9L0o+AZk
         Mkhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1793340773; x=1793945573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=koLzWHXW97TNEzE6lZyfsMu4/INbSHZoqvSoVHdmAK8=;
        b=cHEerX2Ou9qKFvK2UNaPNr+StWTcV3VZdLbw+k44xSlQIwu6T5aQvDCrmMpzVwbSGP
         NbPGFonVEYG9SYUCs9Da1crw5T+0VGUyaE+ypdmghle2SU3t3D3hO09AChZc1s/3aSkh
         eiPTCdqlVXkfPM9HCeFLEZTjjDwTKh5HMCoO43560q1iEgci8avOIFT9fgArBgvLMTqv
         Agr4ovU5QwcOLgsEruxL6yqMbFCqNlEsuku5BR/yoOIbWoXVK/PYP3IIg81ghNmBJb3K
         mtvri1Gzvyje8P3ZO/FXjj00+b4TYuoUaCbheu6wkisx/XGjyfhSzkhueLIRiEbfG0H1
         jiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793340773; x=1793945573;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koLzWHXW97TNEzE6lZyfsMu4/INbSHZoqvSoVHdmAK8=;
        b=VLqv8zXv6P1GfugH38yofhKmnvti/vGXZ8CJjchImPUhMS9RgYpdZk4rxRJwlNGAAn
         mZLQiVVlc556Jd2UCoYy9yDs+nbevjD6bK1Sz3vZFxtEtO7cHhibtoPMtxZhWnJDbMLZ
         A1bpxCyeTpdQoGjK2LHTUCIGTQFSRLtxx9WqLNEifJt8sD0u3JQvWL/bDGxoa943gs5w
         gKC+TrJvrUcUcavExbDtCA5JooIoZtTbrxoWoz8/hkDcK9xvoNiPm4C2MqD0lu3E7vpC
         B43CLmN9xCl9Bq3UXKqIrLxAlMGI03Kc9Gg5p7xLi4d3f/+0zN6AB46MDRT6SeAsw+XW
         jf5Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8aAgOXwUzvGk4AHGc2GHeqa5E5ZEPwRfu/YDJ/fL0ajoNTrREacIV1DBrFMXmjHH4KIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUhfrvoT9QWQYndEN2qriFoAj/gpgKYJ2DyXc4dQ6Ap4T9Hwsg
	KKy508miZsRTwYgm5DL4ngycZu8RfaCJpI7VUa4wsb/t6otPRvyUCSlV2W7gnBoZcbd0XL1boT3
	QvSDwoyHM4AZ2V9pElMFk5CeAS/a+gAlJz3nXW04gjA+TrRTj8FByUFmN
X-Gm-Gg: AYBFou0NnVPzkEmMr+pZQnYQnT6HkyHgU2qTgMMvQENXjZ8gCWAKeF1p6phTE8HEHRu
	9roVdnDfI0nBcmado20467I+F8YD0xEp+Zp9m1LRfoHBGrNT160437h/d/wVBeo+AyCCmn1He88
	5AhYbN9SZET2SMZZx9CAoBY0uV6aXNfmqTuDgJIH9ki5xf6s5kTYZjS/tHWAF3l4TsO8PdvnxoT
	t+me1oGXDyMtN0khnJBXrB19XdEBWU7gh6/ZMb1yaCK625ZBA+Pfft6MtE1x0kb3BAX24A8yODD
	C5XvBD2/XC5bnTcGZ7H/btHgwNdMb1BnmQYikj2a/OjQh4Ef3h+8XdVb1Minp8Xs21okxnTOsEh
	sAYp7iUM449gcXMzPYsnCtRi9mH0lfqgQmXZe/fGwyCEKewALgVZxkwIbQU5y9bVYFVJfd2Oz6f
	EFCt84DpdEGve9dZeiAsb/
X-Received: by 2002:ac8:5d8c:0:b0:536:64d5:553e with SMTP id
 d75a77b69052e-542b397df4fmr19908851cf.3.1793340772925; Thu, 29 Oct 2026
 23:12:52 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
 <20261021030347.565306-1-chris@nortesoftware.dev> <xmqqqzhior8t.fsf@gitster.g>
 <atmsSIJrFhA0t1rH@pks.im> <xmqq1p9hiszk.fsf@gitster.g>
In-Reply-To: <xmqq1p9hiszk.fsf@gitster.g>
From: =?UTF-8?Q?Christian_No=C3=A9_Ramos_L=C3=B3pez?= <chris@nortesoftware.dev>
Date: Fri, 30 Oct 2026 00:12:41 -0600
X-Gm-Features: AclHuK92C5aFzx6nNx0ivd_zm2x0P7mspNxXEfxaTyDByyQ641MxcOhKvc3S75g
Message-ID: <CAHGSfbYbP=sQEG4JGFx7CPHL1+tdYQjkXz1jKsevTZA_G5wGvA@mail.gmail.com>
Subject: Re: [PATCH] doc: gpg: say which date SSH key lifetimes are checked against
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Can you stick to the expected flow: (1) send v1 (2) get review
> comments on v1 (3) respond to these review messages and then (4)
> send v2 AS A DIRECT REPLY TO v1?

Yes, will do. Sorry about that.

Also, in What's cooking (Oct #09), the description of
cr/ssh-revocation-file-fail-closed seems to start with a sentence from
cr/doc-gpg-ssh-key-lifetime.


El jue, 22 oct 2026 a la(s) 10:45=E2=80=AFa.m., Junio C Hamano
(gitster@pobox.com) escribi=C3=B3:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > I think explicitly pointing out that the timestamp is under control by
> > the signer would be useful context though. It's implicit to us, but it
> > may not be implicit to everyone else. So maybe something like this?
> >
> >      Since OpensSSH 8.8 this file allows specifying a key lifetime usin=
g
> >      valid-after & valid-before options. Git validates the signature by
> >      checking the committer or tagger timestamp is within the validity
> >      time range.  This does not provide any security guarantees as the
> >      timestamp can be chosen arbitrarily by the signer.  But it allows
> >      users to change a signing key without invalidating all previously
> >      made signatures.
>
> Sounds sensible.  Thanks.



--=20
Christian Ramos
Director general =C2=B7 Norte Software
chris@nortesoftware.dev
 +52 9671456444
nortesoftware.dev
