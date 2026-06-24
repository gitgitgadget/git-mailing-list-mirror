Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117CB3A380C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782303687; cv=pass; b=mX6m0q5tNYLtUyyo8ivvUO4sSwH902ROTVrLcz57980URq18JDNwsasiOO0thlvSL4wPVuW0sggTvRWRzAUs4crx4piX0T9CMaOFyHeUSjawYFZbACTCFypQvNf9o/Uln/5WyZ0QtqjqodeTZ6Z8TpJfqLUfaeDLW/sedsSB4Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782303687; c=relaxed/simple;
	bh=0ao0Qmpp7akl6weqaoXJvAxpL+2pqdbUf0Hud6xkaaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIXNSbeSu9AAHdmeuKbqAGHLn5jlzjD3EKxURdY1lnOFEKi8xf5QIYr8jr42BhZzY4cPoz8dq/2RXNyYtQMBqZ/YCnFGTu+MQzynuGPiHiEHmEp/r/EmO6XebtIrF6xOA2Eflq7BVwN0omV6vAQVUz9e5c24RIBkc/tfzaQu8vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/I1sBDp; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/I1sBDp"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80814edb536so6482617b3.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782303683; cv=none;
        d=google.com; s=arc-20240605;
        b=bJNt/XiWQfhzycSnK5+2mcn/ECHLnPeKtgf3At3zjgHNtu79nLuJ6D1bbozkVb8E3/
         4NiHDZWr0346/tdzNhcj4J429Yxhrbd8r1EZk9mF+feH6w2WY1p/MRGPOzcSozJ4phme
         dsgMR+Zr7rDN/NSCgX0nlbtS1FN+ZP89wZl+7oDFtKZe7yDKWdM+1SqZ/ocPDCxUjd9e
         6uVY6aKnfLGpjWciGnZgwCHp9PbzMRQX/iSAgo9fV5JYjGDg8O+ebCqApQPMNrUTXyTJ
         QTpqagR6Wj7MJpc7TwYyJtCIdpuejJvapwUyFlzSEP1a47/TxE72B/X2n6rXFWL1biX2
         DoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IQMz8jFreOPA8B6KC5tFxbNpgEU3QWAx+7lwwwBFMms=;
        fh=4AAliz/opCEtliGg79cKCwetSKpXBDj9P9fZxWKFIpo=;
        b=kM2kNWVauWd6T9xDV33K1cD7xW411UKpVU4/RyzHNBe02GQjnvubm59vm8Dy5mHFQ9
         yGZSyoU3Ou7ouQv1yZmwQio99s8BJhh6PfiH3LTsuyqKHgXwgxDLDOREOdkLwxVDqsHl
         F6aW2VPilGAPOc2frWom+n9lqZ2gdotQ4OtmLnOpP2kEcLlmha4eVTF2m49nGCVrbF2c
         YZPC3fWODOD+U2cWgf8vKz3+BcEkX6yU66UDSI93SWLMOBxqmOCDYFCUdmbF3dhICu4Q
         0M9BtAaFqwnJz7oqClTmEY1rdUxkGV2VR6UUGhjVmL6A2IosYCGOtTjaB1at22pz2zXL
         TaQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782303683; x=1782908483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQMz8jFreOPA8B6KC5tFxbNpgEU3QWAx+7lwwwBFMms=;
        b=A/I1sBDpQePXVSo9UrwspOgtrWeNJ4VyWLWd2D3uM7IoBztx719OiHh4dSPgNE7UAd
         H0gyjEPvNaoeZQwWOodyIHWt/4XYspStOwNy+tnjcGq8C1a8EIFI67cOHELexW/vULAy
         8OlhD8pOSgTfxLDnM61DF5P+nrYpRk3BZbTZRxM2Ul2B4tIAArj2By9awstddtb+LJTe
         17sxU7HChaGIp5gNGVRx+phH2A5NZ6PG8jhHSwPv33MkRfrofDmBRQIltfB+kX2SULA7
         WtN5JoGc/jYDfh3LsWkeRnqY3HeAB3yw8bl45owW5qf7vl7R1nkeL1aDprWcAXESGwjj
         CXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782303683; x=1782908483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQMz8jFreOPA8B6KC5tFxbNpgEU3QWAx+7lwwwBFMms=;
        b=gZIjNZNDOpUJz3vbPa0pS16I8DaJLs1y7RdpJvN2nAhiQasdYkyDwnQZ0ildLtAdha
         4YZI3wMR4NhfBh9DZJ07kieruJCRQjTQ4rxbd5D+2AiJBphf5hoQe0012TQUzUHGAyP4
         a1im1tGklGITLLkwF5oYjaTi35bPR1xtSq2Wd59AEfo6dU+Q6Qsv72kMZ5dhI4IKtddu
         V9CVManLRrgOpd6sE/k3sjJ+J3uWohmj/AX3kyoHUnx5YF9pNLCaLSkB4kXtMvJwwLbr
         wbxJbMi1anBb9e30+vlgSoDvF9JxuolX8+ApGtMrnlKftMzHgMHjLDVm+Wpe7gzyVOis
         laSw==
X-Forwarded-Encrypted: i=1; AHgh+RrB9mNjHtcoLpMLaglqPPpBqYS8HTNvzkR90kEciOsJVVrVI+keCMZJDGXZmF+URk1AMxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIelZMoZuStXx31rlFSTyw5z/tEsrRFAMBVUTTN9Ue40iZ7GZz
	y01mf7utSUFTAPiRYTFBn3q6Ab0WjTmwKKaD6cwWiFC7NuJkfvTfEkLHWLzKDgpdPom58vEd0/J
	/ruMApm1RZ9cJipQXus403yLowP65P90=
X-Gm-Gg: AfdE7cn3BW31vf/O0ovm+jObklwfWlc7ifcwj+s3FIt9BccYTMUu/6aULJJt7KQBbND
	lQXEhQFkVuoAxW1OecSClHIqykX/XuMCiFQm5nIi1IjaqymBfGcBJCAllCoqb6sSw4rDus3a4nb
	j4dJZTM59Kj31vLM3uiyGgHjDMSlUVfMP8nhKgaAmhE9rGL7Hn9Y7WxIKHukdH1i5JsDpnHglbp
	xHtENnSOWMp+3/+Q2EBqg50CPYMNSNSzZ/ZDvrK5vSjYfLdbXqdEbzu+floLP/G608kd9H8Oky6
	2AC2TDxmRL3Qlrauw7LQkeTh6h1Rlj9YS7tHSt18UG6r39zawo9iv5o5+wCqqHUVaO2cn5TKO0R
	5LbtQ6LVTD/9v8gwCchyNfzYGZ74eQfwJ8c4+3rSbbql4q9ajGPoWHOkBhNKRzW3vevjArMapym
	JRKZeyAw==
X-Received: by 2002:a05:690c:46c5:b0:7cf:d242:d966 with SMTP id
 00721157ae682-807ecbeec15mr30445597b3.15.1782303682885; Wed, 24 Jun 2026
 05:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-5-3d4c7315d2f8@gmail.com> <CAOLa=ZRUoBKPAjh6He0qgdZdzAzMxmeS9RMRi-czpHEfKG6EKw@mail.gmail.com>
In-Reply-To: <CAOLa=ZRUoBKPAjh6He0qgdZdzAzMxmeS9RMRi-czpHEfKG6EKw@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 24 Jun 2026 14:21:11 +0200
X-Gm-Features: AVVi8CfoZSrTttz4jKR8W4Y2kz5HnKCisgSnXp6iWDsmVeiOrhKeWAkzSRRR0CE
Message-ID: <CAN5EUNRMZd+NoiAHd-f0Gx4CqRPs7759a4UQh=GDeUgsFKbdJg@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 05/12] fetch-pack: move function to connect.c
To: Karthik Nayak <karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 22 jun 2026 a las 12:30, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > write_fetch_command_and_capabilities will be refactored in a subsequent
> > commit where it will become a more general-purpose function, making it
> > more accessible to additional commands in the future.
>
> Okay.
>
> > To move `write_fetch_command_and_capabilities()` to `connect.c`, we nee=
d
> > to adjust how `advertise_sid` is managed. Previously in `fetch_pack.c`,
> > `advertise_sid` was a static variable, modified using
> > `repo_config_get_bool()`.
>
> Nit: What's missing is why do we need to move it to 'connect.c', I
> assume this is because it being generic means its better placed in
> connect.c over 'fetch-pack.c'. Would be nice to explicitly mention that
> perhaps?

True, it is for that reason, I'll write it explicitly in the next
version, thanks!

>
> >
> > In `connect.c`, we now initialize `advertise_sid` at the begining by
> > directly using `repo_config_get_bool()`. This change is safe because:
> >
> > In the original `fetch-pack.c` code, there are only two places that wri=
te
> > `advertise_sid`:
> >
> > 1. In function `do_fetch_pack()`:
> >         if (!sever_supports("session_id"))
> >                advertise_sid =3D 0;
> > 2. In function `fetch_pack_config()`:
> >         repo_config_get_bool("transfer.advertisesid", &advertise_sid);
> >
> > About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
> > assignment can be ignored, as `write_fetch_command_and_capabilities()`
> > is only used in v2.
> >
> > About 2, `repo_config_get_bool()` is from `config.h` and it's an out-of=
-box
> > dependency of `connect.c`, so we can reuse it directly.
> >
> > Move `write_fetch_command_and_capabilities()` to `connect.c`
> >
>
> Nit: Wouldn't it then make sense to split this into two?
> 1. Drop usage of the static `advertise_sid` within
> `write_fetch_command_and_capabilities()`.
> 2. Move `write_fetch_command_and_capabilities()` to `connect.c`
>
> That way the second patch is simply a move?

Okay, seems fair, I'll do that, thanks.

>
> [snip]

Thanks for the review,
Pablo
