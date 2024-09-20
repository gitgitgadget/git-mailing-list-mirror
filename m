Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914114D44F
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841549; cv=none; b=WpBEUucM4Xqg6QgzO3Xnz/738Aus101bb9ai3w5DtsUkoPPtty8mdHVgdv+hewlcgLrBLFoVwBTcsAXqF8+u8i7Nj6/YDRL4RgMb6Bu/DT2BUkicITfdgnnA6JC3DiG5P2y1I9Vah+85IShCqVSOevEbAyIyrgKXr11tD82iVd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841549; c=relaxed/simple;
	bh=QB+953B2g1YyaIq4BOXI8VsfPQXrObI8aVjxcoeX/1c=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=q39JQftW7lR86mvcV+DPIYPw0dB92AdsDK6MXEKHvl5g+TQfKTJeNyFOoOx1eafcWGGPBGCGKPkHjt7+xi9l3D0hXlE4F4oT5e2PzhrpxE60sDuYHK2fZKABMdjzTpc0ihUs/MmUMSPHvEMDkaZboy29ycGWjRghy4y5zc/TfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=EaEkjNcA; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="EaEkjNcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=cQeGv38hWsU/RXxKWYF4s1a+B5kvewKw6rQcxwBIlxw=;
 b=EaEkjNcARO5QV7f2TEJQ3VUyl24p37N9dJLXO9x0SZh9t454X5fAKIXZwTpFbdh9eiT9mYn4sPL3
   aDWzqjglYAPHIyF/FqBCi4SXyrN9IWHpksNEM9s02CNYOzFkdhkEvU34e/lF2H6pkIvNujjJNco+
   61ZVTM6qZfBHnNMrv6ive5B8vQROfEoEvYMBkdzurJGAVVMO81O6aFFmz4BFfuTs01N/Sf2BhAsZ
   7te3gMIdsljSazzf6lKhRoHdTO9FLAEnZIVa6VT03rBO6O8uyiMSXO7qskxp1ANJ/O3FWhy5QEwk
   0QyV8L7tAjQXI9HweUJR3SKpWWZEfdLEY9sRdw==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SK400FBP7GK4000@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Fri, 20 Sep 2024 14:12:20 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 16:11:56 +0200
Message-id: <D4B6893HT776.LNXNEK2YJHQE@ferdinandy.com>
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
Cc: <git@vger.kernel.org>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-2-bence@ferdinandy.com> <xmqqtteb45zr.fsf@gitster.g>
In-reply-to: <xmqqtteb45zr.fsf@gitster.g>
Reporting-Meta:
 AAEQTJP+i0Qj+Uq3mLAK65p0by7A1vdchHgYKsZRBj0z3FEcFDN2K3n/mzoOUjpf
 aKq1RFqx0E6QA924e6Ll9KSMnbFxQWhm84Lg3jUOb7JuMU7doFaZ8NOlO02urCRN
 VEAzNfRb4PQNvdXr+lrd0v6R/RahK4eyvDe+OrV67ppXfZHso5ZV/cKOdpEAF6gb
 8hGWH4GoJRApmDrJcDSaT6YTQWCp4r5DaAF52HmVcTeQ88vQXJNBL+dWxEAjhFU1
 /xJnd7/S0ueYLKadF1Qiig94so7+X53lhAc9aPWtG2xsyQ39cyO5HyruZqAuy56Y
 iM/tbl8HGMsDr2uq30zQLNuDbSkifySE1QC8SID6MgfOmLX4E552T731lBVX+7bi
 WdHu/PcjfrPJ7QmOSEXSsUJKhyrAfOvEAcHBD7I3XI/TCXTFqy/OUVrmKibM93g6
 NvToSeWbUW4re2V3t2WJ1TuSyDHjhNGLQMR6yuD0nmucw+hNiIpY0l7T


On Fri Sep 20, 2024 at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
[ snip]=20
> If I wanted to create a symref that points at A, there are three cases:
>
>  (1) the symref does not exist. =20
>  (2) the symref exists and points at A.
>  (3) the symref exists and points at B.
>
> I'll see a symref that points at A at the end in the first two
> cases, and my request is silently ignored in the third case.
>
> I'd expect that the caller can tell the failing case apart from the
> successful case with the return value or something.  The caller
> might want to tell between the first two cases for reporting
> purposes, but I do not care as much as I would care about detecting
> true failures.

Hmm. So in case I'm passing REF_CREATE_ONLY I would not expect the above ca=
ses
to be error in the sense that transaction_finish should not report a failur=
e
and thus have all callers assume things went wrong. On the other hand it's
a valid concern, that the caller may want to check what happened. Actually,=
 the
idea that I mentioned in=20

https://lore.kernel.org/git/D4AK4USDVP5T.10INJOFE2I8LE@ferdinandy.com/ =20

may actually be useful here as well. We could record the state of the refer=
ence
atomically before the transaction in update, and then if the caller is
interested, they can match this against what they requested. That way they =
can
figure out which of the 3 cases they were in without raceconditions after t=
he
situation. Actually, this way any feedback could be given to the user post
transaction here as well.

If this sounds sensible, then I guess it would make sense to rejoin the
set-head patch into this thread as well ...

[snip]

>
> > diff --git a/refs.c b/refs.c
> > index ceb72d4bd7..7afe46cadc 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -2085,8 +2085,9 @@ int peel_iterated_oid(struct repository *r, const=
 struct object_id *base, struct
> >  	return peel_object(r, base, peeled) ? -1 : 0;
> >  }
> > =20
> > +
> >  int refs_update_symref(struct ref_store *refs, const char *ref,
> > -		       const char *target, const char *logmsg)
> > +		       const char *target, const unsigned int extra_flags, const cha=
r *logmsg)
>
> While it is not _wrong_ per-se to mark an "unsigned int" parameter
> as "const", it is a bit unusual in this code base.  The only thing
> it prevents us from doing is to mutate it until this function
> returns, which does not help all that much in making the code safer,
> as opposed to marking a parameter of a pointer type as a const
> pointer.

Makes sense, I'll drop it.

Thanks very much for your patience!

Best,
Bence

--=20
bence.ferdinandy.com

