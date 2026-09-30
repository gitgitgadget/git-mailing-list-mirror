Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396E40F74B
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803611; cv=pass; b=TXk2u+epdFKEJKPmhb9LwRYeBqDoSDunOj0QSFkO6N+V8p6sqtA4xI1IhvvSY+GZnhZHc47bm6ZXZcoNmsS7pECT2yIvfJJNtmVQUWqo5ZLr05CCH+NHMjk+tYuX+wYy6CFaLAXmuks76A+o6qOedE6qj1Z3NH5nMJY8HEo0BIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803611; c=relaxed/simple;
	bh=GCtO9+NT04pl/WQi4Y5j72aeMHDm64ayj/BamsPbBFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibCqe5xcB2AdjzXTfsrzz52HvcA/s2BFCfUwD2GQOMOu2TprsaWT+8kX4CpqpqL3X2yPfEh2ROkgjfleUtjHPOSfelKwpcp/zGtPNT//nc+nwgrmVgsY5FkbQwQf5c4xaGfTmZCitBdn7NXu8yUCPTupB555IRnMtXhObGoNNKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Poo2A0zj; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Poo2A0zj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2db710396ffso583315ad.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790803610; cv=none;
        d=google.com; s=arc-20260327;
        b=JP5Ti06cjMCPs7dqcCne+ZLJPC6p+63MVsgZBcpfIWe6+8lWG0gNPWNuR3e1N16Szh
         nGJ50gW9fbdHS+gOwhWutobSPIkhWARwTJd7QwXJLyGduuhuLTkDMgFEYkmYC7dE9lTW
         JOCSv7ndq/Y/YqtWEkeEUimDfSoPT3n7paNtL3L4vZE6QamXFOrI86GfGjrWWKcNQVtf
         ZQCDAvnnVF09z+/bJLtm0OFcCQBvwuniYZKLUM+yYmzPj7gkImQTFgKUGx1JGL4NGPoD
         dIO01M+PUr79reMKlTPT6jo1igOFTsgqpOsQ/pUnj8uvcy4n7u+D0rslj23ljJqQWyBj
         0UdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXw6DXfNt1nAObx0P61UZ2iHqNiZPThpO7WQ+Qf1hR8=;
        fh=RakNZSpi2P6MPnl5yVFA7Z54/a9TOhJkSJB/jVpVb8k=;
        b=K33pHfstNL3ireGt9ClzEdayw1tLAuob+gWBJIhxa3G2jxRmBQPK1IR/75unlAFrpJ
         UPBZjGV4xyyJyxNrAJD30NV99VXCcFX0cUZcP/Yy+uCECYlpegyQnT8Ye1V83n15D+OJ
         7mjYoJzluy585kqavq4LYPR4eycTgddqHcnxCaZrhM8Tl/ePFWtD30EE+z4fFxdk4wql
         J+2PqK6oye6B51/+ijVCoh4d8chffqwn7/DPbCVNMCruNAE+OhpYBcLuKIEYZORI4Ib3
         +zUqHq4khUz9qHp8o4n1lWvxfzr9PT6XuIGxv/aAvqlc40T0X51Nbp8l1AEk4XaGjEOk
         zGAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790803610; x=1791408410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXw6DXfNt1nAObx0P61UZ2iHqNiZPThpO7WQ+Qf1hR8=;
        b=Poo2A0zjUDvJoHPEcRNjX/ZRNPkymXRTRFTwM2DBgLHKw/c/+fl34gVqPFCIXpGCUC
         DQf0TUTcUz6z6bu+YtpaKJYQOpQnGgj6Vh34plq6OI6J4UHjXQ0+bLP37YsMl25AQM5/
         +8dEIWr8FvQ0vKShrSV2eQWO8W/p4M+6dRdGqOJ3oakdLd5PH8WUAqs07fIOo3D1Olqt
         Bx/8J8xuCXWp/ajkgh/Soa5BoWOdiSCcGGqrmP02ciixqhEj0tf4DHErdMRG6QgjWDys
         SIMVQBiB9iH95/th5UaPxkAz2frJ/1Ep+YYNdBmclrL/n0LfDEYKzU7SL/lzIgEe2c0u
         2cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803610; x=1791408410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXw6DXfNt1nAObx0P61UZ2iHqNiZPThpO7WQ+Qf1hR8=;
        b=07pYAqa+3qgxJ/em6VUYKOFFvzEUxKmlt5rOBlqD3ohuvdwBFXOQNkPl5+9LQKTkwm
         8q8rmtWdIxGRu3sWNSHFnsjKjnxG8cZjCzV86WiX9+mRvNxh2u9V/oORsM5ZIlKPyovC
         bn42wcIfYjwcSH5+Sc9szgTRjXWUoRHQcqxyIEFaFprVMKkTltlRpQZI4Duw4BpUZmhS
         clUIqT0/gmE/ao0OWn8VOW6tui4N/bPhoRifv0L81lEOOL6ZjbA/THH9TZld9waVmXOe
         H/7gwek9lF+sQyDNeQ6WmpJXI9PadZW5+/vZXYlW3RJ7OfsV9QLAECiLa/1ZPtL1dvIr
         jckg==
X-Gm-Message-State: AFuF++nqvcnZ5QUbmaI9hiNsHtSLjy+yXFJsiS2F4KooU8Qs1bculOOj
	OLnJSCalKM3i5y8iTBdmJkwH+L9rkiv4B15XYRhLMqyhgmCi+hZzBwwpgo+sTkGPXXYUO6ISvOj
	2yybLl9OmebhPSqkuiJc/K4pqHjplmQ8=
X-Gm-Gg: AYBFou0cgfCw6gRCA5Pvz7p7S54r/iRGWS47DIPus9r9Na8b5h1g6LfZnJU+CUSYwRd
	giYM1aIJ6tDHIgrPenaHuQQHtKlWaX6NdfcvF03fiuz35hfDF3K9s4bZkVq8IyreFH9ICkK/x7g
	OHKLZvcObqdJIGVVPPWiSEO91VYHiO65SaJ8Rf87U2sqYM94z0du1R0D1Fu6aQ7iwIcRxDvTuKW
	zeNj5bBAB3ILRkNN7r/pgNVjPsapvM/ShbRzLbOLkBRCcMYCrlVPhmp0pp3IP9bFVJS71XEEiMH
	f8sogxen4vG7GTAqUKA4nCdwUndpJWKY9tZKt8toBipQ5nX1IxwMYwVJg4zeFvwPh+9YDJCiUsp
	xCsQ2UaCM0VMop3mhaT3DObeZKRrPVKSop1ZGWoUc7wWdq7LlFKM7eaEjlY7KyZx/aqUsGT3H1K
	Wr6ndCeyZI
X-Received: by 2002:a05:6a21:748e:b0:3dd:a9a9:396d with SMTP id
 adf61e73a8af0-3deace089c9mr549626637.49.1790803609953; Wed, 30 Sep 2026
 14:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ac59be-0688-4d60-871a-2ccebc91c58b@gmail.com> <F407EDB6-80C5-45AA-B8DE-CCD61DB663F7@gmail.com>
In-Reply-To: <F407EDB6-80C5-45AA-B8DE-CCD61DB663F7@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 30 Sep 2026 17:26:38 -0400
X-Gm-Features: AclHuK-xlXaNEndlywyR8x0fzYvzS-Q_M7oZ2G9sKcIeXaSRKUULKcpEOqizRXo
Message-ID: <CALnO6CALq2V0Nmx=VE8X79VVhNxa_xiH3dtv+QixaHsB1=K4iA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] stash: clean up index-mode test merge
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 1:32=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 29 sept. 2026 =C3=A0 11:48, Phillip Wood <phillip.wood123@gmail.com>=
 a =C3=A9crit :
> >
> > =EF=BB=BFHi Ben
> >
> >> On 29/09/2026 13:18, D. Ben Knoble wrote:
> >> Changes in v4:
> >> =E2=80=A2 Drop merge verbosity changes altogether. I was going to
> >>   save-and-restore, but when looking at the index-merge test case (mor=
e
> >>   below) closer, I noticed that "git apply --cached" reports conflicts
> >>   on stderr. That is, "git stash apply --index" would report conflicts=
,
> >>   and silencing the merge takes that away. So instead let's leave the
> >>   configured verbosity alone.
> >> =E2=80=A2 Only copy resulting index merge tree OID when successful
> >> =E2=80=A2 Fix interaction with t5520 (new patch 4/5)
> >> =E2=80=A2 Squash test from 3/5 into 5/5, since it requires actually me=
rging
> >>   trees. I've elected to keep it a separate test for now (contrary to
> >>   Phillip's suggestion) since it's written and working. Adapting
> >>   existing tests requires quite a bit more digging into implicit conte=
xt
> >>   assumptions ;)
> >
> > I've left a comment on the new patch 4, but everything else in the rang=
e-diff looks ready to me.
> >
> > Thanks
> >
> > Phillip
>
> Thanks Phillip. Pending other positive acks, I=E2=80=99m not sure if I sh=
ould reroll with Thomas=E2=80=99s new patch, reroll dropping it now there=
=E2=80=99s a seen topic for it, or just wait ;)
>
> I=E2=80=99ll probably wait a bit and see how the dust settles, but:
>
> Junio if you want to see a reroll hit the list using the new synthetic ba=
se to make things nicer for you, I can do so. In particular, I think the la=
st check I made when I saw your mail about the synthetic base had the prior=
 round.

I realized Junio wasn't CC'd on the prior mail, but since I re-rolled
and the merge base changed, I think I've got it right for v5, which
just went out.

--=20
D. Ben Knoble
