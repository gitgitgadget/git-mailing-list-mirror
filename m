Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792847923;
	b=tPIBaUbJv4E/MfSGkv8XoJ1qtjueP7MxJ4G5B1newdP89UI7s6Yh9e86DKRfBRbOQwCB
	 tu24z08F4t0kLOKScH66Dpp+GLar4UtOjdMFEwUchIjlCMygYXN8fkHTmBC783viUc+PO
	 UeyYN6IPjdsUq27M6GiMdoMwnB2GalnswFoq8piuVNXmyEttyLPMCEsfIieSPRe7WRzHZ
	 GgfNpqtFZ3AqNG2MAFW8gLUPgAu3vHBR3x8j0HG4n0HPMsvGTGhfGmyMc+8gqJfeqDYAu
	 ZE9jnSthD0u/Q1X5zUeW+cz7GMwQ6vN1iRLiYau3p/PW4c2Q2aITr5rWXjh5YeCi3gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=quh+7/vPxwsM86cHKH3lRrfBi1vtDCCvrJS8GyCYhlo=;
	b=Y4LA+9x4ZahyrChlLbUy0UnCKjiz1hPg57sFC7f2Qv+JsofjpsqGXIq6BcRBMb30ru6d
	 DdIjLkw1gf4NfyzmOQ3AY/IDVWsK4QMM4O8DWPjnhrNwbmQCuMe9Rqm22JoeygRcGlVfI
	 i3h7YGXfGIeH4H2RlsZspvkmCxZEle3fHDTSr7yzHdODa/8GwYXIAGeaIRZf0oYfG2hFp
	 kSmuh5qnGAvV7HpyDh44SxbDwyaKDhpiOFP5Kan+m/Auzs5FlQXkje40wM7/Zm6V8JhXU
	 rKRO4ETYYJ6nykptJ/5C+588eDV/CPhs5ucOjnIKnuQ3i59qUk2Vg3J7TSHNKmLqgoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=haWgv6Pt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA286606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA286606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=haWgv6Pt
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so711666b3a.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792847922; cv=none;
        d=google.com; s=arc-20260327;
        b=Df9mrauZ+w/7kqqZCNHlEftEA2qmwo2k3iWW4QQPCFYjgsBGuvFcIdY6XRHwYFE3DS
         RH7O9mzdQrvc70OmBuaCpgnjyTmhVcZETqc7T6FFSgLvV7Yz2kQIvHyBlaW7Zi2j14dy
         /4xio4YaIlLMG72uvZqV046ozRJha3b4J6ilfA9RN0h1qPVMsJAYyfnMilDYXLq1KLQO
         O4qKhF0o2Oh1ybB2FWPCyIGH8k6qJghyXr/Ehr8dQ1uSgzfUbBN45UEAdAbSOMf1QmwG
         RrI79H4ptTiRmKU1i0BSQANZFx9NPZp/nxY5z18AXv1LN6GORjJx2k61v00KLcrStuX2
         5dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=quh+7/vPxwsM86cHKH3lRrfBi1vtDCCvrJS8GyCYhlo=;
        fh=PcL3wScCLlLIrXR+AfGnfNRRS2EE6fINQym9DBF8wyg=;
        b=g1eO23kRtknpuzPTNB3dPYsttQE09umtnOKj1tV9ze2NVf8wQmrp7F7rggakSWYGl0
         6cdShfcWYHET5uSwCCZOmWy5NmgBSFatt0Rf/IAvR+NmWyvY+hv422fFAsW1loIG1Z4D
         MINVM4xLxQY3bnxT4HdAZ64l6Po1cEm5gmh2TAj+DcOrOa21TXXRG5fjcsVlOJj6TuhH
         3Z4Sd5oucnWIa1hv2KLcBoq0aQ/3jhw5zvob1y0sb8FUKxquGEljC1yiRISuadRQXSnz
         /lxEf1CpywcvjGt+sMdUMBt/Ax6rf3aW0uZITTuUBV4ZBFnakDNJsqlyquLs8pet5+HW
         plZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792847922; x=1793452722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=quh+7/vPxwsM86cHKH3lRrfBi1vtDCCvrJS8GyCYhlo=;
        b=haWgv6PtlRW08NbiEEsEhzg4HO6OJkkt9BDBIcW0x51We2LN5B4osd118V2HzYX6RY
         /wSnNXTQuq3VFn51yg0+3EkhjW6P36CXNqzujsYpdEPaIMJl8zynHkVL6lgTvYADHxTy
         MOYanKl0CXktov8HoZVG5swY94/II4/T9uRJkf0eesDnNMMFuF00f6TgAdCghD2qDK25
         LVLM+Tp7jqxvbvwvVAB/vCQUHQSyQ1siDi9ZtezWVe5LJaC+cge9bFna+pcnkU6szKYB
         oVahGG+UwbNdBqhuBPvBvQihZzjnsxb9OEPCDzPaTaCyIA8cTKaV9+LpDuMosaXNXD9L
         UmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792847922; x=1793452722;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quh+7/vPxwsM86cHKH3lRrfBi1vtDCCvrJS8GyCYhlo=;
        b=o4fzGX2XScSvWfq3eMmC0DVdHS5bSBEZhwCd+I9gr5mCX017S0AL2j9X3dFvIjOax8
         gorXLWTVuTAnDQ4vYfhyK4wx2MCKAyyPC95zXKGz/OXKY+ojCKLawKx5ZJ1bfroZk1nt
         LPyuAaB42NXGGbbL7oZJ8fZjmypjeKPL0vbNYxRWnBI5/AEOBuVoc5zPKhlszWBRMkTl
         TdVYCkkPfw3ljlgpTKhpm5AXovDMMUwTnygULMhDiIleSTtGv9QPPTTg7alhxpxIRdUy
         1RidOEceYrjn6jJS9uLcoGd7RNUSUEbUlhfOuOgv0ZwZPZVbSNC5fK903ykpUIpSqRW5
         dvvg==
X-Forwarded-Encrypted: i=1; AKwUvBwFw1Gi3xRGEjbzf75nNfsDp0POG5uQ7hbXuM2XBmKg8ukmJiPER4igjMrkEnwQDDpN7NM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLbjPLmzwFBctl//vxnLPMViaJOQFJ63Fs4Dhf0hCjiWEvcnyU
	MBvzSHlZ+vufpPlYVxNKqKyk0ZfQvQ0gTdOqZc2PpfEMxJCT/sozNrqjuKyRg5Sn7F1RxQ9/S7q
	8WGASlJtfjCgKc9WAdwgyMKCL1xR20AQ=
X-Gm-Gg: AYBFou0Yjzvq7Gr6whlAX4dRy+ZVELmBT2arD88SOxIL4xSmbzd7fGXVV0h2I8i7E+O
	97hgkWVgBPwZKtFn8iEweY5DlStx0gDT4GYR8kjnVGytxZ94jA+GdRHrsnyYIWlk5Ma4xRCX46K
	6fryUj5kzeOrBrAzrL6DHXHjItayx59uo/PrYdYGdN9obw63Fq6XmzVBRFYsY+OTdirBzBGC13v
	qatuyp78Tn9B0Q8U9HcVpg0QSC64RQ+1YQMbMYfqI0SLn7AUPPil6J8MnqBButkH67x1OQyQJmv
	M6LjuJcsbVHzzwITuDMnwMW4aPoPABYwB86Rb2yaWzyCh2WvkYP8DfgMX3UkJiKMu1iwbu2K9XN
	OEeQzsva/XBwzz6OhLsyqGN0RotUw7WdprFDVVIlQO6HRltIDCpddosv9v1tcBGjlztxVNSta1C
	gddUtYBotaOryv0amK2TnOf7vq8RhPkrFrSjovnzmMnNQWs8n1nuBM
X-Received: by 2002:a05:6a00:240d:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a364e63241mr1762156b3a.6.1792847922103; Sat, 24 Oct 2026
 06:18:42 -0700 (PDT)
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
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com> <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
In-Reply-To: <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 09:18:30 -0400
X-Gm-Features: AclHuK_YDbmvqlfAlTgoCQre7j5sxSQefV4dfK47KeyZjgit27dpO_OlbC_b3XY
Message-ID: <CALnO6CAd62NqWMw66UT7mDuM71rcSBFidrr5f+PfR2jA9D9v=g@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:52=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> On Thu, Oct 22, 2026 at 7:14=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> >
> > > Le 22 oct. 2026 =C3=A0 10:39, Harald Nordgren <haraldnordgren@gmail.c=
om> a =C3=A9crit :
> > >>
> > >> I would much rather see more --option=3Dvalue,value,value syntaxes, =
like
> > >>
> > >>     git branch --delete-merged=3D'origin/*,into:origin/master'
> > >
> > > This feels completely chaotic to me and becomes a kitchen sink :)
> >
> > But is it better or worse than the kitchen sink of
> >
> >     git branch --delete-merged origin/* --into origin/master [=E2=80=A6=
]
> >
> > ? Hm. I suppose if you didn=E2=80=99t like commas, we could allow
> > repeating the option to =C2=AB stack =C2=BB instead of replacing.
> >
> > But I get the feeling that=E2=80=99s not what you took issue with ;)
>
> No, this is the part I take issue with:
>
>     --delete-merged=3Dinto:origin/master
>
> It feels akin to hacking some code into the arg like a
>
>     find . -exec something

Well, I find it more composable than tacking on additional modifiers
via --long-options (which incidentally make the synopsis more
complicated, and add lots of "this option only makes sense in this
context" checks)---that "context-sensitive" nature seems to me to make
our interface quite a bit more confusing. See the "INCOMPATIBLE
OPTIONS" section of git-rebase, for example!

--=20
D. Ben Knoble
