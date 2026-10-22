Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691560;
	b=BTrNN3a5GkKHFChIB9OLdT8npVNErvjlqWVO0O9Bs5XiwrjR9rolpsJ44HiNyR2Zxwy6
	 X8SYrNo/d2SuDpwNOUJYTaIeJEzZgErLlcLNXI5v609b3jMtdyNEmXNHWWcsWo6LWNYBD
	 qFlOIo1Q9W4d1z4WafSQBVyDs23AvrO/R1J5gFe1daCsLZ0jEbsbRAriHti7zO5HA1uT7
	 CuzFgzd5e1cHIkf5XsW4WHH6iM4EIuZf4ZGEjbs7zAIgwC2ODNpDDt3jtwy6bqhKocUZv
	 0oxEDPg9aLhrTRi2ykRxONWxtQDbf61qwaxFPYDXLFU/CR3BizDD01LM5O6zbKhaweQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OAsf4KM5Q6yFQad3bUkgAIq3V6xUorzXessNwjRiNjk=;
	b=MFhdkiD+TKt+cXkrS4S6vQZ31ru+1OKa2rsGuZVGXuTHMbhSwMtQCl2An0QLemlVEmPT
	 yScK+STBFb/uZmzTG/ZNTHJMw69Lz4JiZqS99A0ct/YLiFDdF6zzp2Nd6akERM7Jvq0pU
	 o8qG7n6GgyYy9fns1NCDUPWFxfScKGx5PIFnK1nyG9FHQimAPAC5koEHf7CTJbCwEYSmS
	 Ecb7F2OGaCrfJiYQOz+m807QPul+orGMMNn1F2zrkd0vREoCSv1e4M7lv3142GuT7ZdGv
	 R442AD8aSgOMC1VfWBHWMMLvIVYpDNeyO78lDRzdQ6U+l8AGwpsNxR42vwKvkivN16A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beDkFRPt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4D606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA4D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=beDkFRPt
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b3dd83e779so3730996a12.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691559; cv=none;
        d=google.com; s=arc-20260327;
        b=QDcsV1JaHnfloCakjdhKMVd95GbCsfnc0jNIYCTs74QIj2pvduxzp82myYLDNdxtg7
         QqcGmRcpEucpmSOIbMaYZQJC1CEphPXX/K1twbLKVhANeR7sYfCdG0J19IY8FayME1jc
         V6kKK2m7a5ocsIBI0PeHDpTIdg4sPhuvy3NCbJ2bTwIt1JN+Z+VXvkqmsbJnJfpOxVU/
         RIpOLN2sqT5K+kslobxWMmGhbeJ31sEY4oxbk+VKY4TtHI+bLobIW+/0YGnOXsed8b0G
         i6yDAU9FnB9Th7GBT+VesC8TCxXW9vDkjxamxIAkS8hHqXnsG612Wn9BH0SR/BTerXjx
         tkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OAsf4KM5Q6yFQad3bUkgAIq3V6xUorzXessNwjRiNjk=;
        fh=4gYj2Gv4XjENw0iVQjc9Aldy4o1E4/Hz5UkK0i44Qkk=;
        b=iJg+/sjimnOlzLKUVCG7cKj+MBbUm/1SZbVW35dbfovVCP08W50y9ID8zMjwFcfLLm
         GOjCanOXwp6l5KGUuTiSIgasx8rUIigyYSJI3XFFMiOVpsOT195xSaJxFbsb9zDjq9/j
         j5O6E2997AoW7bQWCMV9fqT8vi2p32WNdIXB/vqMNptRNAgArgeed16r2avft0cvpRUH
         9NXk7T1+/e+pbSYGOJQTMlO8auKpVO9pXqO302VcE2LaWyXGDSiGe1XUbjgBUVTb9zm9
         Id+iiIMd8QXP4jWbN6vKx26BSd3Fy7PsessgrGuwtHmmhGExX42kIDeAVdCz1WJfCRnN
         PGHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792691559; x=1793296359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OAsf4KM5Q6yFQad3bUkgAIq3V6xUorzXessNwjRiNjk=;
        b=beDkFRPtO9DUIm9U3tT8TF4Q03X9EPFZl9OTLV8haKzWdtUEOtyidjEgmqNIxbbqJe
         eGjgXrMV2rAzcjNheychIavao6z82edZdKta5VM+zf82ctACyx45CC3o8D9RHcom7ysa
         iemEzRizqdggBE4DQXRUqx36Nzk23/96NW9YuZSVj2AsQJbqFwjRiOZWc6YnCGWoaCyy
         /QiltGydQWb9eDsPVmKSbh+SGJX418a9C80cZIngmzSIygk9spzjjG9huv5l5DAs/UzD
         zaDXX9i96UMzJ3FnGt/Av8VGwimttMITHzDSHUpyKl+pRTtczvF4DBspTN//zMvcQd/H
         kLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691559; x=1793296359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAsf4KM5Q6yFQad3bUkgAIq3V6xUorzXessNwjRiNjk=;
        b=jfGi7bZp0e6nhCnf1e2S1aaOi1//GTEEJd0kbkYQ1gipdaK/F2N0JhBiJKArj4UoPj
         ggZMdfG2ubcKo1l84ug9VNcqkiFf8s3+u378U/FPKUWvOoqbHTVhj+4tJbILZ7BN/ZQs
         IixqeoyyjHxzStbfx3/zUX8R3SKu1Swk44YTJpzi529LgJ3lgy9EW0dIDkLV1qeFS8+I
         KFSFK8Ynraegvz3MMbOyhnOiKYr4VrB/9MCA1Z+wNg6w0W634NE5ihEnm0CUd4qdsS+T
         JGo6qBCGdYdGurIzG0mY7Mcas7p9vSfXPCPNbprmBa8WdBmfM0NoY41AMsrfGumrY5oV
         VAoQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+f8lIG8s0XwLQQi1JNdCmeS5k1TU0v6UOL3qER0EVpIFAivXTBQzwAK/gY6sClJbdN40=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHckE2boS3VqzARZL3si8dddNCfVUau95shNqSRi0HLwzKcy6z
	CLDrlrmGM2uOuMM1sASUO21Nf1ufshc259sGRLwgm+OXfyz/iYplg4SxeLICrb/2RfhVCxnm9zR
	Pu/VvtiElW7ZxKB6bLdjy/Gc5csoDKdBvQFw0tR4=
X-Gm-Gg: AYBFou22TycjOaf/aqKRJjmaDdR6I8q7xsjebx13pI83diKjcTSXeaLhWZ6EUm4K9JK
	yNj91WORY0oQZjr8GJBQQyVN9bMekZxO94ckW7dDQMm1AeSTOkQQeH0wNfaPPMBhos+bfJ9iWy3
	AWNhhvMUNP+EXkqRYF1nTqoHv8VHSTqwNhzSF5QatWDuPttbbN58Q8VQDzrWEWe2qTfvmdpUUC8
	CJxB7mw2Fbg51pVMtVe1T/Kn+zZYQEPwXFWfDwrCROSFApr2RdXHgWqw8A2725b7iknFBGV0q+5
	Uo001U/kOuVoGGBpu7JPqAFJdiRon9nBSAwpiXX9AMDhRno5VRFLluL22YGdI1WzoTRGxLmpbob
	yWNVQ4HBWL4lhEQ775inCZcAQybd36T0+Y1tf
X-Received: by 2002:a05:6402:2406:b0:6b4:31c5:bb2b with SMTP id
 4fb4d7f45d1cf-6b432c337bdmr211031a12.41.1792691558718; Thu, 22 Oct 2026
 10:52:38 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com>
In-Reply-To: <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 19:52:02 +0200
X-Gm-Features: AclHuK_1GSsvM_0tmOVdbwG3-5yfPAwexV0TXqPAZDKQaidQHm16ctzOyPJGQ04
Message-ID: <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Ben Knoble <ben.knoble@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 7:14=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 22 oct. 2026 =C3=A0 10:39, Harald Nordgren <haraldnordgren@gmail.com=
> a =C3=A9crit :
> >
> > =EF=BB=BF
> >>
> >> I would much rather see more --option=3Dvalue,value,value syntaxes, li=
ke
> >>
> >>     git branch --delete-merged=3D'origin/*,into:origin/master'
> >
> > This feels completely chaotic to me and becomes a kitchen sink :)
>
> But is it better or worse than the kitchen sink of
>
>     git branch --delete-merged origin/* --into origin/master [=E2=80=A6]
>
> ? Hm. I suppose if you didn=E2=80=99t like commas, we could allow
> repeating the option to =C2=AB stack =C2=BB instead of replacing.
>
> But I get the feeling that=E2=80=99s not what you took issue with ;)

No, this is the part I take issue with:

    --delete-merged=3Dinto:origin/master

It feels akin to hacking some code into the arg like a

    find . -exec something


Harald
