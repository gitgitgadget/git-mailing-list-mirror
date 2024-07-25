Received: from sonic320-25.consmr.mail.bf2.yahoo.com (sonic320-25.consmr.mail.bf2.yahoo.com [74.6.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B6B199236
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.128.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907496; cv=none; b=NWhGYwy3LSxv5Znr0Pl6pIOFnoIV6GHKpvcL8q2anps85EhZvv8pSk7BRsxJfz4tsG74MmFjNUvXEGNBYoFhkKkVQTUzVnV5fEC03msXi/aP4HmfaYm21DASR4gNjhyVZrCYO5arqNUIPu4yqNi5WYGLu5sGsEQVmoMJI9x0uBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907496; c=relaxed/simple;
	bh=vpKbDcMIiNPHIbVYJCGqT7Py8+/W83fuadWqlWJR4VI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=izbh7Qbqn6QxSA6KMHEk1ekH2XTCaRr5LozxCifzqOevmjvk2L7N77HLarsCdKjbIJleYJZWdWqALzTm2kiiTXZgOeXmW4VBkdzNcyBNRN84Bih/ECcxi+9Yi9jqac8tKOWhVax/8klrOhgAPDJBGBxtllIL79Dgb8uuCcPZjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=q6BiKvVK; arc=none smtp.client-ip=74.6.128.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="q6BiKvVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721907493; bh=vpKbDcMIiNPHIbVYJCGqT7Py8+/W83fuadWqlWJR4VI=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=q6BiKvVKYomMBfhjbheGIZ68XZYvGMY5u0Y+DhNX52Vjuh/R4Sf5Q3ln483+xkhXn5InALAbkIUpP4l62ZU0jNoUx7Hn9kXCHUnnCaB4T75UtLF/BSlkICc9oiZQYlWeHEP8ZuGXwCpFpqRnIGXOWOVedGx8mSD217OGydbtjMAhIOIlA7fni8pivW/fDi+07XE9Eh+F6GfkoT80cHvWwUAZtIMznG9nY1/OM5UPUVkTb7KZ6PmxXCekK8bRwQbSOJw1seb9d5GUMyQ5pf8nz8XL1FTB7yLqKSi8LvTbPozeROe6dV1NnyrftcfnR5HZLm491Kjy4z5JlEa+A0OInw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721907493; bh=TJz8+sarE8xoFoZKigmwSBkF7Oe8qL139PJuLEPQiZZ=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=g+nO88MyugSVoNYYnX+n5xrW958cp2INkDkI7aGsrb4FxClZdJXe1+QJxyKt6tpOftOBebpf1j8WlV1z5LdPxdGhDBVoe0Yuan4XXdqV7UHBtKldKp9Vx5YU4KZ/OpTwxDw7toJRKO7u5Sda0P4j7p9kPD98NCy7QC9y+1RHG0RVTdZtKIhVc4HciHmlls6iJfm/eirARtnLiDt8W+AuH2pr7ujeaHb+ErMn5wUNOvCfjXRABWC2w0uwl/jTSlhzjXVZbFt2NEX80MZagehR46kihdGEstmcZ4RRIg+W7WJLpHSPT8jLSybhtlZYbiQZprzE6HoOF5ppYWlO/OJRdQ==
X-YMail-OSG: j3lwdIwVM1lfN8TwDPL0spSwQLgEt_rviooE047Xo0wENqgykiuYt5ApMbfYG_q
 8.jFJS6EICi9151N36Orikh90ZS0Ime5QENLzksd0t7nvdiDPoJ1WRK0TPYuHFHJ850KoTstZ7Lo
 3Yxxh0K4bucTcDrgJLbbcEOB15wM0mLbx4HeMqqOq7vN.5q3rmwXQQrjMyWg6CXJWImzZHitX60U
 Z4pQpROGJZMlcrx0D9VLaRX.hfyXsmkllSMzg2c8U4gu1SofnP_TsRCOo8NfniHOn3aOsdxYGM61
 5RhEq_nvH934tCHAVRgEBXP1OvL85XH1_sdWxKveh0oCrvCHSAoz9_x4HNqnwmmi.1l9UR2p_.3P
 Lu2CVb7pZPaGLsaZF.VfirrpetLbD6adluJUnGcBwoX0L6lWO1sAKJ3XSYLS20TD_29rf.GhkRxv
 7IYpYtcXLtDyBvcnZUahUKvEzBgK8EbABhay7QayZN36PHA0rgk5nv8P.tfPc_JyaAIcQGHVWsPa
 BNdVyG19q0FmCxdDHUbrkOkrlv9a8kZOeyJs.K6CHurwnbCRzpzYDkE.9uLTLGPv1ttnd5G.R3NH
 ZkJjx9wfUAzo32QBJQxTCMuvJwlWosVWu11g4nalxcsG_vvdbhzqJOjTFYsh7Tv1smqdq.DPWW5L
 YSlbPmbLtINxxJIG1Z03tDrW03.UA89qQI7bfzoJWxYTlu63wxvwbF7w7Wt.RvoHU.GWrWr42SGQ
 cAqmLI90FVIHI1rNqYwAC6WAfOzDmFQ5e9ILJ9NtuZ48VlXYTEMSI9keFMX4_pQdRgGc8hUtvvAI
 aM6KQv3vtT8b.lxDQywcaZygAmfXo3N1wnjhqqS1SK1HzOY2EzZMJ6N1rkxh_spEK4L1Rnf27.D7
 Tho_xVyKdOnLC70.CsCFNXQPwrx92Xp5ILq0IoAmRqUSWDO67LoPEvKiXHhBlpBpJkA7u8d9A1dR
 oiPU2lxFzEm1G.ikr7qfAH3fMGCILNWsMxVDuE6.f6dWcm.c_CW4zoe15amOvbzgb931XD7JnoN4
 YWV0xta3Ntj1YtypUdXd9s.CVAG8aDYnoapOtnlMYtTQpGSXbrvt9NVuNfa1lURPpaxLGUzBuehZ
 ABUhsdhFrnFYXJcBWbcTbzjiSYwdo4R1ldsJmSazN9VDi0BO1HhPNNsp3x0iUZI65eCUXQ8t3TIU
 h2yTa.ohWGGX6bFdktdVWB1xnxYNu_6cLuSMX3D1_COkBWHY7VMgDSBZZta3b8DfYX2vex2R6jq3
 jXFLu5514tOOpj1xCBR7mcm_IHnyPzVb.ri2zv4MB59dVusUdcot9seG8S_odZ9St97Iv4Adp9vB
 IWBEmCbLww2I6mbE4cmEKmZ7Qb1sUNk8E.TlGNyPap7bsb.Lt9f75p6Idib9HHjXzvWsM7TsS2G_
 2AadLA5yVeI1vzBRxIbbOmImoeQ4zSZRrVkVA9lvsfx.rXYqfrFrAx_zIcrNLDD.nO.p3g2gHwuu
 FbJYfylA6.1gAWYqmXf3VeO.mxFF5LVDB8diqewrzorvcVa8vmQaiEL0cjItyhGZjxQBdOcGGZt7
 H4NP6fOZkqCEVkUsaMLGeqcJvaWHdGpx0Z.suPf1_j_KkoB4U9SbskBtU4.Iln2XU23qR1zMbHdK
 yu1UCW.wDQjcHbG78uLj3OVxZHN9f71ROsONG9iuvj0DAQp7yTx98rtUWjTcGpNHUKmBKM6b2tvD
 whoGtv6ljBiVpq.f2eV9qklcojynz5QzD3fTA0aFsfyibltSTV4_VXX3ZJ6I7I9TJyFh5hxciUwc
 a5yBhr_Au.UJEkbivipwgsQynMGD2XCkXXf4kxGY4bi76BWiQ.8n997KC0gJaoR.xZ85KJiDYfoT
 48iL89nHk9NtWMm5VOLYtnVxnWkRaD2rVBGvdcHks01tBkZus4p.d5iqZCD05u2iy5NdXxitSNbL
 2NbRGJNtArn059gO9e6PzKKbkFh4190dMvARC9VAH9YOgprPSAejBnFXcU8R302hmw2aC0G1LCRt
 u59ccd2WXHx8x..shgdh2rn5OPLkV_je_WCGslWNZ6Yni2aavngEo_kblpEF9tt69jjDsD7qDE1o
 9f9DoztBIKkRkJjd3k9QlPIpdYCMIvs_pnc.RBHM.2UmbdnsY40b9FTcBqt8O65WEU7EotyFkzYo
 ch.I2jKYKkJDkt6b_P_qmh6yMFB2CRwUEHAsZu718j1BclCf.LyEs.vpkPL76ounwqfmkNLwJH4k
 965m98we.hBgOs1_RkLYtWEVkNk7pU1i6ur5BmkpZKv5t6Z_f
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 9d16bb24-0439-44e7-8f9c-ae3ee1d46450
Received: from sonic.gate.mail.ne1.yahoo.com by sonic320.consmr.mail.bf2.yahoo.com with HTTP; Thu, 25 Jul 2024 11:38:13 +0000
Date: Thu, 25 Jul 2024 11:27:29 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1106076396.2672924.1721906849141@mail.yahoo.com>
In-Reply-To: <1542063589.2363688.1721786934049@mail.yahoo.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g> <1542063589.2363688.1721786934049@mail.yahoo.com>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Wednesday, July 24, 2024 at 05:08:54 AM GMT+3, avih <avihpit@yahoo.com>=
 wrote:
> On Tuesday, July 23, 2024 at 11:25:29 PM GMT+3, Junio C Hamano <gitster@p=
obox.com> wrote:
> > >
> > > +__git_SOH=3D$'\1' __git_STX=3D$'\2' __git_ESC=3D$'\33'
> > > +__git_LF=3D$'\n' __git_CRLF=3D$'\r\n'
> > > +
> > > +if [ $'\101' !=3D A ]; then=C2=A0 # fallback for shells without $'..=
.'
> > > +=C2=A0 __git_CRLF=3D$(printf "\r\n\1\2\33")=C2=A0 # CR LF SOH STX ES=
C
> > > +=C2=A0 __git_ESC=3D${__git_CRLF#????}; __git_CRLF=3D${__git_CRLF%?}
> > > +=C2=A0 __git_STX=3D${__git_CRLF#???};=C2=A0 __git_CRLF=3D${__git_CRL=
F%?}
> > > +=C2=A0 __git_SOH=3D${__git_CRLF#??};=C2=A0 __git_CRLF=3D${__git_CRLF=
%?}
> > > +=C2=A0 __git_LF=3D${__git_CRLF#?}
> > > +fi
>
> > ... I would prefer to see it done without any "fallback".
> > Just forbid use of $'\octal' notation in the coding
> > guidelines document, and implement just one variant.
>
> ... off the top of my head I wouldn't know how this variant
> should look like. This one printf and splitting it later is a bit
> meh to be used in every script which needs control literals, but
> I also don't have anything cleaner off the top of my head.

I think I misinterpreted the scope of "variant". I thought it meant,
across scripts which need to use $'...', but now I realize it meant
between using $'...' and using the fallback in this patch.

So mainly as a general solution, but also applicable to this patch,
below is my best generalized solution so far, so that scripts don't
have to reinvent the wheel with this "string strip dance" above,
but I'm not too happy with it, mainly due to the gotcha that single
quotes in the value break the world (escape the "eval").

So unless others prefer this solution or have other ideas, I think
it's best to keep the existing "strip dance" which the patch already
has, but make it the only variant instead of being a fallback.

Generalized solution (without namespace-ification):

=C2=A0=C2=A0=C2=A0 # assign_as_fmt NAME=3DFMT ...=C2=A0 -->=C2=A0 NAME=3D$(=
printf FMT) ...
=C2=A0=C2=A0=C2=A0 # - works also if the output ends in newline
=C2=A0=C2=A0=C2=A0 # - NAME must be a valid var name
=C2=A0=C2=A0=C2=A0 # - FMT _must_ not include/output single quotes (escapes=
 eval)
=C2=A0=C2=A0=C2=A0 # - best used like $'..':=C2=A0 x=3D$'\r\n'=C2=A0 ->=C2=
=A0 assign_as_fmt x=3D'\r\n'
=C2=A0=C2=A0=C2=A0 #=C2=A0=C2=A0 (which also avoids accidental single quote=
s, but not '\047')
=C2=A0=C2=A0=C2=A0 assign_as_fmt () {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # accumulate " NAME=3D'FMT'" fro=
m each "NAME=3DFMT"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fmt=3D=C2=A0 # ignore non-locali=
ty for now
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while [ "${1+x}" ]; do
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fmt=3D"$=
fmt ${1%%=3D*}=3D'${1#*=3D}'"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shift
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eval "$(printf "$fmt")"=C2=A0 # =
FMTs become values, eval'ed
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 assign_as_fmt \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_SOH=3D'\1' __git_STX=3D'\2=
' __git_ESC=3D'\33' \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_LF=3D'\n' __git_CRLF=3D'\r=
\n'

