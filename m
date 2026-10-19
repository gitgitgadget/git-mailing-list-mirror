Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427035;
	b=QECtL1ANgGAeBih2WGpU6tD+D6OACOXqTxjMxVgqpsG4uutcL7dMb5ZO62Vg6TCNyfov
	 darm3kBm4uoki2/lT2OXmp39WSx0859+pWDWvWoKqccKjjyqUGhvgVz5Q4v2r6wJNPrSW
	 THmDZDbFQyDh0/Yx8DGr0WvKCd+z5ASU6I8NgajTdbBzXF7rreDYaASxwst3M8ThslY/T
	 MM6gbfSsSlB/e8Xgu4PQ2eIhsXL2FUeIJIkdFg261TyvxWkbC6VyVZHY+s2pmRy1Y+Ic5
	 hhzqZ0EI6hRYFzxVHLF1RZPKbekgJgonaM9s0TyAW9yKD1ta4P7lKP9lmtvzunsLQ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=dmXl7c04auBJ186RaDTKZ9YevKHSIdMnvhKKHC6vAp4=;
	b=Ajc/UM69PZT6uxVQNYCcd8Ho/69KYSyDlEkmP1CVkRPvQ13LW+08XVrE8DlQxsh4wout
	 DTdRO2qTRGnKYKiVBrjHxrSL7155dmggZiHdALIUrVQsBn55HplzUp+ExIkhh3tBea4kb
	 X0vc1LoBvRBOYAXRfKYKQZ9AvbgkVP67TZEdeIeRNoATWW/TB4LiEPnpColnSX57uayri
	 LiHjxccdA2dFgrOOq0aLROVg2R1dCTw5y1YNVuIVZqwcByQzgERXRjJYXykLBb1lnoIXO
	 5bnWK8Qd+Dyt1oxqr8DA6yn4Gi9Q8QDqa5uFLbIHgC6d8k8//pgi1mVm2A02F1MDV+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DapLdETy;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9B606A31C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8C9B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DapLdETy
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6774639a8a4so1854413d50.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792427034; x=1793031834; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmXl7c04auBJ186RaDTKZ9YevKHSIdMnvhKKHC6vAp4=;
        b=DapLdETyhBRZjJELiq9stpgCVPyG7GzhNZhlxiR2q0Ru95p4a936r3B8xi9EB93jbS
         roSu9mdKOCCPdw5hGJHBekl5m0g+Usnup4iqzpCDM4vLhVpfklamzDtCuC7jGZniiL5V
         KZW7FucWEU69vZdBHJt/vTN357lbI0iEgx/Y8V06JCuclIr3qjccRFjGaEmkhAUEJgsm
         3gWnm1+1oudpsRxEFShVIzxaRq0TOaI/eb4bGGkUIQBjKjv0RXZOI/cn7sDddh9JdghL
         y0czopjD5G1vBT4mi8Ak9BvNYcaKX5my7waAXd6WHtO3nNEFW8hsf20u2pa/pvo9UWe2
         DTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427034; x=1793031834;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dmXl7c04auBJ186RaDTKZ9YevKHSIdMnvhKKHC6vAp4=;
        b=IWEyRZiX3FD8e/7BRro94OzB3SLHcYKFo7yVeEhGVM9qIrW92TzDKUG19YwDpK1H3P
         YC/wMbrYBXp3yowHCI1ri9gtmJYFrL5niajWK6PFwUe4ku2wo3n3b1vxOva9sGj4Dd6s
         h97J+Dyg8bjKxClwkjD+4jqqkIk1AkCOv05B18Z7dKToguZk2tIQLBsNxHQ0jLHhEWwK
         UQy+ErLQdNcLWGCUv3eX4VXrn8h1kAZz9mE92Ofltvoo4G2Ma/jjGwHioWpEw9UDJCY2
         yfC7infc/DFvuwx53Wdau8uqlB5QD3lQBYRUjLJ4YfEPZYJfCVxhWBfqdyzxEGlR46wR
         BkRg==
X-Forwarded-Encrypted: i=1; AKwUvBwj7uC1LkD4wWY3hTXsiJ+xLWaEPEIqYLRmxYQ5AjFpCDDqPSNWMjFZlaMfRw/6Fv+zzUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKVvaXTDmR6wdxkojMj/9syPYd8W4lq1BNQFPTOX5yiIHMz9VY
	iMFOWW4KOxjW87T9uf3NjuMhpYrs/xbEQMHLjs8F0C9zgsIr8GvJJ+jP
X-Gm-Gg: AYBFou3mB9Rw4edViuyC9jQQUhA/4Cft6UXFbBnFnI6EphzSu2FhbVSX/mHSGebtW5K
	v0zJjiGFcrt2rocwlDhow1ODgAACnR4NxbcSvyesoCeKeAkzqSOduKvVm388Yu+Nro6SKDkuc+d
	3PnoWAVRWh+7+g/X20YiUyrlxilGwXX2KGZxEb5Tvpt/sEzjYP4IdyA00enJUhj2B3aEaOS/nmo
	neLiVc3gFiFjAKlLxtEeSGtlubT2Xg5dalzI6mxQWfOYLj2xhtak7plMjzZqWVtMwEwvG553ZH8
	OFDy+wmsayNhuA5A+nUxJNx3stgCFofihae5+yTvkFFDF5Sx6gjgmPttcWvMGnTJBGKBaqkAvBz
	5WForSG2ITI8UEPhRyNZzSb7gPYwAW0GvsZCdpgzAZOnX4pMUH2nN3SBqTlatfRxh3EslC5EDo0
	sH2cfsg0iXF3Fvw5SYYwNvY/s3WXjQoBs4nFQlGHUxdY5VJJEaumkXSlS/Sj9XfOPg5u7q44/7J
	+j+fyHNccrBAgzGEPDAEao4TOkekRIEH+Xa5Do/hN0WF1/948beo+tT0NLYccS6lM/z76QJGRbn
	0C9IV0D6hibuda0JWqOoZgju7dLPnsrGFsxjnJI9Ts6OE2U=
X-Received: by 2002:a05:690e:d4b:b0:679:c916:46f2 with SMTP id 956f58d0204a3-679ca75a364mr1690184d50.31.1792427033658;
        Mon, 19 Oct 2026 09:23:53 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1909:b48c:a809:b114])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e09d42sm4318852d50.4.2026.10.19.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:23:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] repository: add core.indexLockTimeout
Date: Mon, 19 Oct 2026 12:23:40 -0400
Message-Id: <F02EB9EC-E157-49D2-BF27-81DFF625D884@gmail.com>
References: <20261014221233.1694344-1-quark.zju@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, peff@peff.net,
 ps@pks.im, Jun Wu <quark@meta.com>
In-Reply-To: <20261014221233.1694344-1-quark.zju@gmail.com>
To: Jun Wu <quark.zju@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 14 oct. 2026 =C3=A0 18:13, Jun Wu <quark.zju@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Tue, 13 Oct 2026 15:05:52 -0700, Junio C Hamano wrote:
>>> Default timeout is 1s, effective but not too long to avoid breaking pote=
ntial
>>> user expectation (e.g. "an index.lock error means I should check whether=
 a
>>> commit message editor is open somewhere"). Tests that are slowed down by=
 the
>>> default timeout now set the timeout to 0.
>=20
>> I am not sure if the change is making the right trade-off between
>> background tasks and end-user action that expects immediate
>> response.
>=20
> It seems the trade-off is between command success rate and command duratio=
n.
>=20
> I suspect that end-users want commands to work (not fail) first, performan=
ce
> comes next. In my experience, high command failure rate escalates to oncal=
l
> incidents, occasional slightly slower commands often get unnoticed unless w=
e
> look at the metrics explicitly.

I=E2=80=99ve given it some more thought, and acknowledging that=20
I=E2=80=99m unaffected by the bug being fixed, I would add:

It seems like working flows have to become more complex=20
to handle these broken flows. And that leaves a sour taste for me.
Folks do notice hangups at a shell that is typically quick to respond.

But, as I said, I=E2=80=99ll bow out since it seems like there=E2=80=99s som=
e support
from more experienced folks for this direction.=
