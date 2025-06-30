Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040428C2C7
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293207; cv=pass; b=rmCi+vIruqMNaAIuNiU6rIJz1Pr1F4HPwZWV5/5TKXjYj+zV8GUSPP8nWgxB50R//2RQt4zKbZ6m759gQRQAPSKXjIqtE/aSDH95vgXvUYJeoiocWF21s7l7/tDbtZ0Ak1gxW0ELCFF+AWXHeUtDjtCKU8g9V6FCH4tSqrX3xow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293207; c=relaxed/simple;
	bh=mMDYoX0dVZaz5UKJhCcKzBWEPPcmk/4m/ByLDeyYpGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upqc9d4mu6SZ1AcPtY5mSQZOsUNhTEPZpk7Oe11jL83iT/hhyKI7WPw1jC1TUhZgy1ceX/l3knt/wDrshuMxlO85ew8fi4Slm2+M9MI82CwGS2mrfw2Omov1znoVHlW5+OJMFXNLu/7LdxudJrB2zioL4FFvmngZNzvHnkAFcKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=ds0xlOgy; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=kE56o0ME; arc=pass smtp.client-ip=81.169.146.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="ds0xlOgy";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="kE56o0ME"
ARC-Seal: i=1; a=rsa-sha256; t=1751293202; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M3q9JZA3SeIsrOJ0QHP4nDU869PCQl2jOtwRsuK4BYEXJN6yKLEntIN10f8snYd494
    ckD2RsHcv1HuxYn2fkJwGW+2hXFyOy6fmjVOKR0LzEY5wv3xInp3/S136twYQQ4VsqX5
    a33AHw/FiZOIVni5/qHioMqU2ohG4RJ0z+nbCGe5JjbSHC63ZaGJ44nktn2W290pEiea
    IxFLKsdMaUgorZSGiprQq5GFwQIqn6uV146LwoFH3L2NocCZEfB7QdTAIWqJJXnsHtGV
    HsCq7bjYh9Em+U1CC8I9gTo3qRsK3Rq11OuJgFEid3C+KKnisyOsjpiRLokNSYS20+sE
    yWfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751293202;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GmiuvPrA9SlTzBOfb4MGue9flV1jwpn+9YTOotrNrK4=;
    b=fTdi5m4nen/kQtSAcKgOC8BPjUVbTMVlm4muwG/BGoEycZi7Zx5p3+6EWvFIqOWydx
    InGlnLEPF76qJradXu8o2omR17yi+StltUYOP23OIliw63G2C7BsM6Paszwwgrx+3Ik+
    nD+jF2vS/vbTFKPQLbDqUy3Rzos/8QokHwsNG5WvfH4GaDvW+/M/DlG8cLU0wjAnt8+M
    qy1rWluFXlAG253erU1mMqcJbON03+HuIoY0udg5Yq6KDYiWPXmfU3Ag5/1snzCBg9FM
    zcQs0AUI5QBo23peUoeFaI6rpzBSboTXzIU4lGs8y/yMdJHD9sNfKZK1cDCMaHzYEoJw
    J21A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751293202;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GmiuvPrA9SlTzBOfb4MGue9flV1jwpn+9YTOotrNrK4=;
    b=ds0xlOgyAOELscJCKQ1nm2cNbFPHgUuuWCxsqHQ7myU/eQ5UZf8a1INz83oFj39Dmm
    njEA/BHdMxmxowazwrNldoETdOyLR8E2LUNAuRlXbBc7xUiwm0qjGMLJyuGiR7AW96eb
    y1Gz/DbPl+44uerKhIWTVPupAoX8W2GIjDK5kIVw254hFUgt6ekuxf8ODysgRe1TxVki
    lGSnntjI5oLtt8buWdk9eKHUPKLTlSeLSt/pWN20n/6dnespoJHtzYlWnePcu/RpFfO+
    yNXfYKTuzhTu2jLp3yqxt9r5FjUVkEMspiKPJNAOn/EOKFKknRM3IcXZIsCTGGh0RAPO
    t/gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751293202;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GmiuvPrA9SlTzBOfb4MGue9flV1jwpn+9YTOotrNrK4=;
    b=kE56o0ME4Lsrjx0VHWA2I9OFEsqmSdzS+QeIrvTgBrUdcrWRUEqXhg58MdkY+udE46
    SbbDgJje47ksF3L4XOBw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OmD4uXd0fmzGoJ8rBK6cWAVfDMmnI2IZ8kj8s0jE6n+P5L1"
Received: from sender
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id D2e95d15UEK1Eou
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 30 Jun 2025 16:20:01 +0200 (CEST)
Date: Mon, 30 Jun 2025 16:19:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: changed output in git branch -a
Message-ID: <20250630161953.3824c610.olaf@aepfle.de>
In-Reply-To: <xmqqsejh5pam.fsf@gitster.g>
References: <20250630121839.6252d9d9.olaf@aepfle.de>
	<xmqqsejh5pam.fsf@gitster.g>
X-Mailer: Claws Mail (olh) 20250514T101025.84a10d9e hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bJuo8MltFRR+4OkJCuRnDIc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/bJuo8MltFRR+4OkJCuRnDIc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 30 Jun 2025 06:31:29 -0700 Junio C Hamano <gitster@pobox.com>:

> You can try in the repository where you use Git 2.43
>     $ git remote set-head origin -a
>     $ git branch -a
> to see if the difference indeed is coming from different versions.

Thanks, it does not depend on the version. For some reason the repository
on the system with the older git had no default branch set. The repository
was cloned a long time ago, maybe default branches were never set initially.

I changed my script to use for-each-ref.


Olaf

--Sig_/bJuo8MltFRR+4OkJCuRnDIc
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmhinQkACgkQ86SN7mm1
DoD6cA//XPOJmsBQkMeik22lp1YMEZDliwzttG7zBqtnpspg8hBWCpJG3nJW7jf+
bUfGllzBgKePBd6S6eRUQK9uHz7MPdykPSIIEvdoA3SCfRul72SooKoENmmW1knP
qcUsnKCWwxsSn/KBmdBcY9ULDjKlPYtp3OeApcUYKyHt6CH36/CBFKwRhDVVUBvG
Z89VIDmGvzYxqDOBepKaYIggsy/Hk/wGXE2ZiGfGgKeMUnmNMgAvgRtkt7pP2nuK
d5IRo20fjlAz/U2YDGuZoXgBTXCsL4JQgeNrrs52/b+D+Pkkjm0AI3pK4QMfKYMY
h2QeKs9GD1+nO0T6VHmJXGK3QCOeEfCwgfF1U9y0uEt9towaaDYYxwBaQDP7ygf9
ZBUaX0UcW8KGo+NMOnjChiUWP/7JhtSZeBswx+r4IDqjkKySHDqhAwHPdP8Yqoxn
vv+BhMUorAzUt8xUsrRHZzq/MKh90yGWROdrnKwubTV8G/NyJxpSrTl01IfOKc64
/gsL/+Mcj/K/+5Aujq4gVviRV9h9U9yrj5lMctntGwL3+Mo/ubNCg6DCCQpnfATP
Te7/GnTbrUjVxWA0CdDmDkMdbVhyTzgGGOss1wOI/tvKDgR/La/8DUcuUqByF7b2
/yVR79MYCCEBc5fAy9JsQ7NLyOSrQFzduAoaE/jPGMy1MGJQ3nQ=
=lZsQ
-----END PGP SIGNATURE-----

--Sig_/bJuo8MltFRR+4OkJCuRnDIc--
