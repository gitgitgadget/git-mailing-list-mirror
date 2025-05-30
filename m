Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B6A23505E
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617843; cv=none; b=rqny1xqavHBVHNdOgIa2n/7IOq0Wn37bH4E/M34bPRjhXkn7RJHUxQr3oBhDSvAHTGLbRDufiV96vNSD2DjqyvG3lKxW/e3ysFLmmcoKR2PmWAdl+Kdr/iPOuAmPF7Pan9SvDadSJudsNJ/Wc3B1McWp0M11lBpkVbFM8vRlIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617843; c=relaxed/simple;
	bh=TEydHQt4vkGDeNvUR8/NfIf9El3gPBoncyZE8wqgx9w=;
	h=Content-Type:Subject:Mime-Version:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=TC5GShCqvPqGik5iy309CwovJNWE3oU1cFnE+9pf8ix61+hA7ISlpoJ+9nRPFZZzSPeNOOs4VgUAYZw+gPXpQ0xi5VIKuUBz+x1e10n7bQpjdiJUYReAk5mOIAcBPq5npewwNQH/ttfaemDA7INVGQZ2xfBX2F37QFlXm4aHM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQUEtFE2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQUEtFE2"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47698757053so28360541cf.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748617839; x=1749222639; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeFk+46NwuBeabDGfSRBrIv3SrEYoXr0+xJze85kGyI=;
        b=NQUEtFE2/P9qEUHAC+SLxJFLJhmxR/izcSIDVcLf+R5bdg9mA+CIj158wR3xhd4Zfm
         Ktyee2MN0BiOfWQxwJVGKdU0+lwBrdIBxUuKuiUEGBwit/227GNTX6/BwA/cHPVB+NCR
         4tZDRwbs1RbQT14OnUZU0/w4hSuFg73DJzfF8uvkqB1yZo1WxjpPGNMcZCLAKc6vqWBs
         XlHMaEhaE1tIXUmh1rYCsQ40qAvS8p4qnrmoSAApHjkBu3OewoqVKm+OP2FZyajVcVVy
         LVc90N6ZT1m2srjwUyyvBK/AQasRLUmnywLYy65Q0Eu1rT3vaU7uGdJOKk17wbJrhIKd
         ty1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748617839; x=1749222639;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeFk+46NwuBeabDGfSRBrIv3SrEYoXr0+xJze85kGyI=;
        b=H7k3fxbkHeECd4x5QX+AQVaSnDJcBc9Y+Jh3wA/UkZaDe/DiNDWK6Gpqybr0wKUAvw
         pE1cJXFGkaOjL4davsSQR6E0Bs5snvFIG1gKkmIAG9665feXEifqpwPguobGNGucTBcC
         VbjfN4NA0+g9gyonNiEUYG4/GLCmtKrDvW5k26mhBBBiUBq+sZDJgyzEGX1WMOk9ElbT
         MppqP3Sv3zB7RgiFqprtfvKVq29+ar3Sqb+TqaiVy9Yo3MNrzZETMrIT91TO2OFAFWy8
         0a2hhhzPduek9jvwXgxtptEOhJKn6HYNFethkYUnugEMJDe4uEFNZoG0f4YrMBIcOS+u
         GeyA==
X-Gm-Message-State: AOJu0Yw0grJa/C12MgSZf71j+jqSpUKLVi/cYU83H13JHdvSJ4wDJnjq
	qthw4ICpUXNFsrOmOaM57bTvHY2LEEEA1z7nvIRwENGkrKSV7kd1aFEQ
X-Gm-Gg: ASbGncvgZLQNDvRiw9F7TR3fK+QObLGb826IJr1mpM8DDDT1EgVxq+rT0tsY3t1FdDp
	HLV9lwpn603fRyNHPhlk7aBfz8BCt9JnPPWgIQ7A7CIdGOkaaaOvwHSdhm5C1FDynwLNviiAI+Z
	jhlcXxPPhnT18+MSiI9JettD5ZbCVKc0ipS4s/cjQ8p1IjeyqSGENMLRQezTnx7aRx6xe4OUcVk
	Ybuc938Ean4Om7oAF5OsDQy7Y0k0Ewpdgkzwz4L1Vw/1lpuyKAvU0V2XXYxt/mkMOIR5VWyaPwz
	z3UbQNO4588STj6CEeGVL9sqe6w9nqMhqHEbiZCA35W1JeO4sEo9wUApMoulh+m/h/r6PvZK9L7
	1BCc=
X-Google-Smtp-Source: AGHT+IFTpdNTOIUoHOT+h6tDZTSEZ68Ucn20xqvcRo3Oe/PfcbrBVuNOMEB+sotYFYZdr+rIat8peg==
X-Received: by 2002:a05:622a:5589:b0:4a3:e3df:f9cf with SMTP id d75a77b69052e-4a44005a6f3mr67003341cf.23.1748617838902;
        Fri, 30 May 2025 08:10:38 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b113:7ee:3564:854c:29ec:6765])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a4358b4ff4sm21760291cf.26.2025.05.30.08.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 08:10:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 11/11] builtin/maintenance: fix locking race when handling "gc" task
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: 6A07725C-6BAB-4BB8-A493-BBD4B04255A5
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <aDm7HcdCbam6wgbA@pks.im>
Cc: git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
 david asraf <dasraf9@gmail.com>
Date: Fri, 30 May 2025 11:10:27 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <0D09F80A-B6FA-40E7-AB2B-A6F78F2D58E7@gmail.com>
References: <aDm7HcdCbam6wgbA@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 30 mai 2025 =C3=A0 10:05, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Fri, May 30, 2025 at 08:55:49AM -0400, Ben Knoble wrote:
>>> @@ -1240,6 +1251,7 @@ static int maintenance_task_gc(struct maintenance_=
run_opts *opts,
>>>  else
>>>      strvec_push(&child.args, "--no-quiet");
>>>  strvec_push(&child.args, "--no-detach");
>>> +    strvec_push(&child.args, "--skip-maintenance-before-detach");
>>=20
>> I suspect this would be more obvious to me if I had the manual
>> available right now, but if we are not detaching (=C2=AB --no-detach =C2=BB=
) why
>> do we need to skip something before detaching (that presumably won=E2=80=99=
t
>> happen)?
>=20
> We have two levels here: git-maintenance(1) and git-gc(1), where the
> former executes the latter when the "gc" task is configured. What is
> important to realize is that in this setup it is not git-gc(1) which
> detaches -- it is git-maintenance(1). So git-maintenance(1) runs in the
> background, but any tasks it invokes itself must run synchronously in
> the foreground.
>=20
> The flow thus looks like this:
>=20
>  1. git-maintenance(1) starts.
>  2. We perform the pre-detach tasks from git-gc(1) in the same process.
>  3. We detach and thus the main process exits.
>  4. We execute git-gc(1) in the already-detached process.
>  5. We wait for git-gc(1) to exit.
>  6. The detached git-maintenance(1) exits.
>=20
> So because (4) is running in the already-detached process we ask
> git-gc(1) to not detach again. And because we already ran the pre-detach
> tasks we also ask it to not run those again.
>=20
> Patrick

Aha, thanks! I thought I understood the sequence, but I was wrong about some=
 details.

I was wondering if not detaching should just imply skipping work before a (n=
on-existent) detach=E2=80=94if there=E2=80=99s no detach, should we do any p=
re-detach work at all? But presumably that does the wrong thing for (non-det=
aching) invocations that come from outside git-maintenance, doesn=E2=80=99t i=
t? Hm.

Maybe the flip-around for me is that =C2=AB pre-detach work =C2=BB here actu=
ally refers to =C2=AB foreground work =C2=BB, which we obviously want to do e=
ven if we aren=E2=80=99t detaching, and which maintenance (which has already=
 done this) needs to skip.=
