Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD01A3172
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145801; cv=pass; b=ZGTlWIAdpERwxvjXn4sZGFYTEYG2Ay/NdQzE2x7e4v2QTJyjFEg8XH+sgGkaRbrM8Qdc00dJ+cx8F22hAZeqkyECNZEEi2NfODXO1PKOI0EXaZ7U5pEaBg8CryiYvVJPg3h8YyJtWnFAyW8JiLe3c9X0j5PlOjl06L2npDEK1no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145801; c=relaxed/simple;
	bh=+5njhtzqPoD7siAX8WTjZxzCQMNS/bQMF3Mvp/zyGIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ps3gSQgrOAdhogd2jyCs4JVY2ZFQ+iWZmqf2PdeDfXFgBHVxP3Ar2OIunUhOXyulgmW68xJQQNPXpK/C7aZdRUY/RuChmsEJcPg6iTUgGFXZnJz6HIS+rF2nHT/syQEtEhyVpI1uWYblRT3O5pxIxFmPmUwZwqykew21l68sJzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsFtzDtd; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsFtzDtd"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f1cf92c9eso37457485a.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792145799; cv=none;
        d=google.com; s=arc-20260327;
        b=TEtn/rk+L0AzciIFadr10X48r2KXqMU32zPnXI+yu45W/fLlEhiaUSCxKINUct3tSf
         YhWBJthcGuh5bo8b8KFqoqMxH8/K5/+87MPLhN+88BrTZQNmrB/VJpxGAmxII9Vx3CIb
         PNcx3t5DyWAR37eCza+aSfbDfyfwM/ywwHenYRggR/34Hq7C2TbM5VAB7rnTDLGMWRDx
         G0ozLPePg8Uo+NTp0JPCYVeoyHhRsccg3nTyHxMq5Yisoty5xUVS83yNhkkrnJ4ymyi9
         3c75CCHHJxeh1V3ar2M2htnYbFJej0hpfg6P4DnzYBtxbJOGIKGL9n6gR+QGbEU6CGqr
         gUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+5njhtzqPoD7siAX8WTjZxzCQMNS/bQMF3Mvp/zyGIY=;
        fh=k32PHrs8xcxoHB0V3EscOSE0YtK79I8Nc07u+H8achU=;
        b=odfBRImwtzUtPZYYVseW2bQMU469KO7sWC5/q6MMeiobMHDjE/tViuYBzNGeUuv98q
         tT7YDeM6kSEIiN5YLbzoZsZO/VDDj93AOliFMCNXK2ZQmPMocXPE+9KVU+IcGuz1jk3K
         GbArt5n8RAUPmO7Ov2h21ltQY0IqepPV69rs2krmobO3D6hwJm+Cm4dDZR69AJDzDJ7l
         IKN58tp5uog9unlADkWs/gFnOKTPaySmAJVmTsabhB4JYGyOhpBJSIvPf3wnlD1ffigp
         iFvJF+xma5N+wDKBoTLhwuGW6NdpHaUUeJxbZ1GLC9yai1lCu9PANX5/10mxXRtuNfw6
         aatw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145799; x=1792750599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+5njhtzqPoD7siAX8WTjZxzCQMNS/bQMF3Mvp/zyGIY=;
        b=UsFtzDtdhmwej4L07g+MqotLDoEu9kznVjgWQbKqfGeDPcWYMQ87sSP7II3ZvUCQqL
         O84PopslL5F8re0dG3N4trhS2GMcrTdV+SyksZWkQ/SKP1yxChE/u7eeil1f0Mt82kpE
         57r+sXSkY19Or+KoE/47RQB8ZIZRgFyknBRt/1tkLs/W2iBuHI36aD0CsNlVMQ5U/cTD
         TBhQckbaZu6srStQ1FFS+TKMIr6oyr4pDEJ++vVtGRa0CoGZ9/yD8dNyk3ZH9ttKQD1B
         Pg5jspfiaUoLmeoVvPkkoOV6L6M8H9r97y1jip51F13EdaJaOvQIquXflJnRLzSWRA4u
         IOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145799; x=1792750599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+5njhtzqPoD7siAX8WTjZxzCQMNS/bQMF3Mvp/zyGIY=;
        b=yAzUF10cLFQOlzOEeclc7ioW2BDrHbbQsOZWC8U0ZCk5+opmBOWmD2Hm6bUGTcxO4u
         y8kPbrQHlopCfw5jGpFUIAkLlXUODro4bW3d/ND14indv3WCF1jW9IzzomdOqEVs/FU4
         G2D8EWlq3zz2ZeoEPzu6hxP48ZpgcD5cjOqk3RJ3cqi44iyPw1R7cHyNA2CMh537TWns
         ptXeBPJvpW6HU9Z7BF9i9Y8aq/izGbboa6SVguMB2qHMK2eoJsSdp1ps3BmHVx98Rlnx
         oHl72g1ROnH3ejiYRmtwVfEqMQL/ekwja4Oh2YR1cpfSHRczYzrTqWeVadG4VWosC9sD
         zYmA==
X-Forwarded-Encrypted: i=1; AKwUvBzBIodcP6HEpo4XL5EishgFt49ZFPD8Cp+sSsYcU2+E04sa/CMd8Py2ptagM55LJYAt9js=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhcpVKTbzx9KOp7u4gyyWUkRCSzs0Y/vNxV+LesLobztIlqV0W
	HBop71YAXiTsDeC9gYvvlZeBPQdeguq01STMoitt2S2SGtV0C4Qpzl8ZspktJccWpWQNKCuCegZ
	Ag4GD7+dNNVLT/oC/XswDMM63je6ivao=
X-Gm-Gg: AYBFou0sR2qAc+oEfF9Y03dHm+8yEmrl1fpblfaYLifSrJd60lnGfhW6Xe8B45oI/6v
	j/rB5mIgza1tNaNDOU3ItN4Nt3wpSIwg/7FW6S2dRatsBScLZYAwtl5o9NDEoKAZFktEpimEXZp
	JQ8vpoZvsJ6LQ9t/tnPem5TpG8Bm9bDeY9Gm/FQ7anHTN8V0XhJ8yK+bGRFihVyVwYbFOFQAXMF
	9wvU3alzlaMSizh7l/9URobbsaZOkWRA8PtBjGjlmd3T3LLi4e/Jc6MVChPovns6SjlqFnApwqw
	PPmepCRYM5HS5F7X1t5MamvJukmT7Sh4Ab5OQQb/r+MkH4Yk79jlMPLbNG1IDraDamqQBY3i8kX
	4E2puCVWnVtPkPQ==
X-Received: by 2002:a05:620a:880a:b0:939:36f3:fea8 with SMTP id
 af79cd13be357-93ebd1bb384mr3460058085a.25.1792145798960; Fri, 16 Oct 2026
 03:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2256.git.1791978767497.gitgitgadget@gmail.com>
 <pull.2256.v2.git.1792135548923.gitgitgadget@gmail.com> <CAHwyqnWT9f0FvthhsPcRb+c7j7xb1LBxGxxBheb_ddfcUqij+A@mail.gmail.com>
 <CABh_KWi-MkiTY56LOLdaZu1dxxYjkSNX3jjO8+9_+mp3-FaNkg@mail.gmail.com> <CAPSxiM8N4MjXpXjryxhx4170gEEQS6mfZu3+MQQ-1iRaFrxibQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8N4MjXpXjryxhx4170gEEQS6mfZu3+MQQ-1iRaFrxibQ@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 16 Oct 2026 15:46:29 +0530
X-Gm-Features: AclHuK9ItYIPL107wCdpBatPijvxodqIQhN4CphxG90_EWdjgHZDPyEqyc3aq3E
Message-ID: <CABh_KWg58zWEBL-FydbOy5L31_datHfhXih5kcs1rge1a1LHng@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy PATCH] t2030: modernize test path checks
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

Thanks for the feedback!

Got it=E2=80=94I will remove the search command and update all four instanc=
es
of test -f in that file, and I'll make sure to use inline replies and
CC mentors going forward.

I'll send out the v3 patch shortly.

Thanks,
Srujith A Poojary

On Fri, Oct 16, 2026 at 3:06=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> > Thanks for taking a look at my patch!
> > Since this is for an Outreachy microproject, I kept the scope small to
> > follow the guidelines. But I completely understand=E2=80=94if it helps,=
 I can
> > take a look at modernizing some of the other ones too in a separate
> > patch.
> Firstly, do not toppost when replying to a message at Git. Use inline com=
ments.
> While the guidelines talked about keeping the changes small, which is val=
id.
> But, that file has about four instances of the same "test -f", that is
> not a big change.
> You can change all of those instances.
>
> The main idea of Microproject is to get you familiar with the Git workflo=
w.
> > >
> > > Seems like a good change, but there are lots of these calls in the
> > > codebase. Maybe change the others ones too, while you're at it?
> Valid.
> > >
> > >
> > > Harald
> Thanks at Harald for the review.
>
> Thanks.
>
> Usman.
