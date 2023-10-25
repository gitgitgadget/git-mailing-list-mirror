Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521062770C
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gMx0xdbd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPdZ3utk"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06285185
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 04:50:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 6587A5C01EF;
	Wed, 25 Oct 2023 07:50:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Oct 2023 07:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698234653; x=1698321053; bh=Ne
	PJHr+nvIFjNtwbF3nq92Muk+rEyRjgY2CN/0jLHgY=; b=gMx0xdbduXjNfOAQ41
	IvJ5eMOmpEawgChDh+Id9AsGdZbhZnbiDlEobVVBY1kjQaqtMbJAKWHpFawls2uK
	uBhYYUI+VlZuHfqQuKwe5R29sbOoEFUFMQ8IgGNSlNJ+bxUK06OmOXW5CgAqT7bs
	1vxxM2tLkG5t+2UHxMh43ROXoOzBiu0t0h1RPSKlh/35pelCrtyB8CbFuz/Rui4d
	EsVl/TMNcEfHvx/bjiehIMxKtmsHChNjR1mZjH9bUdsyh9J5pxgaMLOPeSFfuTv/
	nUsAeelOiMFFTAsSSaxGopuuiebSQaZ54rhfom8WrOkhimkAMu5GCMmUFggtDGFw
	c2vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698234653; x=1698321053; bh=NePJHr+nvIFjN
	twbF3nq92Muk+rEyRjgY2CN/0jLHgY=; b=WPdZ3utk6U//c8PLbPKfWJzCYAkAg
	7qPDJpGSBrcmBtOT9ZTkq5S5jMoKI7P3/ykAV81L9HJoXH8gykON2wpwoUaSk7Om
	yO6ij6K7FnS1CvvbVSwTNv+uCQI5aMRlIfB3VkscRQfRiT/8wstMJ7pZxf6csJHB
	L7KWTF37q0Julxp7JOhVzVSbYZLZ+PIHASFFAt3RMJgQhM9Z7u6iinjFxVJ7xm92
	nz3rNJlqOPprfRlzpG9wU90LXQKKrJDCs5fXRxioElVU0C1K+1wXARL35wsSYvxS
	VSb7CTW0qLenZYEsFSJbArGg1b6Mp3O5DJo2Bnzpk/B6/oqyNC4hatRDg==
X-ME-Sender: <xms:HQE5ZXV2xfpowWSzpsWCYO6OCNq4VBlKGENCeSoQSNcQuNBGozeaPw>
    <xme:HQE5ZfmpUiAiK1OFZOLSiYBwOw-JmH5ezMzGiYEDtBvcgZKtpB-9Y4XJFfBarNLhi
    hW8iHRelznDjm0npw>
X-ME-Received: <xmr:HQE5ZTZt1J7CTTs3Zo4WOZPrccEgmJgS8lDkiOD1Twvk0ccpM3_Z8Pq9KsNnFL6qmsxigJ7MZXGS6yx_VLK8kvyzzzdu8cNpsMjHYv3KVTXR1XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HQE5ZSVwPEHbCpFiBP3xyxbEmrMoCeJv61L-piUZO1ZZ2neEPVE1Rg>
    <xmx:HQE5ZRnC3MepQR5vVNWlgvNcJA3Exyv2bSyhK2JEq2ZgQfsLuh-AHw>
    <xmx:HQE5Zfe2U40IAV-YmivAfqV0eJzn82EQgvSENiMzfuRRVd4SSvICOw>
    <xmx:HQE5ZWyZajGmaR_dXLgm32v8adv_6bOpnm8yFuZbjClBx8DU1ULFHw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 07:50:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b34d732b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 11:50:45 +0000 (UTC)
Date: Wed, 25 Oct 2023 13:50:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/12] builtin/show-ref: explicitly spell out different
 modes in synopsis
Message-ID: <ZTkBGob0IU8BE-_h@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <adcfa7a6a9d8fb6f915faf77df52362544cd590e.1698152926.git.ps@pks.im>
 <CAPig+cQ=VhRm40oW=TQYzy2NXKNJm4QVQhtw3FAKsFRn12qYLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bisKaXg1hrMC1x/n"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ=VhRm40oW=TQYzy2NXKNJm4QVQhtw3FAKsFRn12qYLA@mail.gmail.com>


--bisKaXg1hrMC1x/n
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 03:39:28PM -0400, Eric Sunshine wrote:
> On Tue, Oct 24, 2023 at 9:11=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > The synopsis treats the `--verify` and the implicit mode the same. They
> > are slightly different though:
> >
> >     - They accept different sets of flags.
> >
> >     - The implicit mode accepts patterns while the `--verify` mode
> >       accepts references.
> >
> > Split up the synopsis for these two modes such that we can disambiguate
> > those differences.
>=20
> Good. When reading [2/12], my immediate thought was that such a
> documentation change was needed.
>=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-re=
f.txt
> > @@ -8,9 +8,12 @@ git-show-ref - List references in a local repository
> >  SYNOPSIS
> > -'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
> > +'git show-ref' [-q | --quiet] [--head] [-d | --dereference]
> >              [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
> >              [--heads] [--] [<pattern>...]
> > +'git show-ref' --verify [-q | --quiet] [-d | --dereference]
> > +            [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
> > +            [--] [<ref>...]
> >  'git show-ref' --exclude-existing[=3D<pattern>]
>=20
> What does it mean to request "quiet" for the plain `git show-ref`
> mode? That seems pointless and counterintuitive. Even though this mode
> may accept --quiet as a quirk of implementation, we probably shouldn't
> be promoting its use in the documentation. Moreover, the blurb for
> --quiet later in the document:
>=20
>    Do not print any results to stdout. When combined with --verify,
>    this can be used to silently check if a reference exists.
>=20
> should probably be rephrased since it currently implies that it may be
> used with modes other than --verify, but that's not really the case
> (implementation quirks aside).

Good point indeed, will change.

> This also raises the question as to whether an interlock should be
> added to disallow --quiet with plain `git show-ref`, much like the
> interlock preventing --exclude-existing and --verify from being used
> together. Ideally, such an interlock ought to be added, but I wouldn't
> be surprised to learn that doing so would break someone's existing
> tooling which insensibly uses --quiet with plain `git show-ref`.

Yeah, I also wouldn't go as far as this. The mutual exclusiveness for
`--exclude-existing` and `--verify` makes sense in my opinion because
the result is extremely misleading and may cause users to assume that
the wrong thing has happened.

I don't think that's necessarily true for `--quiet`. It may not make a
lot of sense to specify `--quiet` here, but it also doesn't quietly do
the wrong thing as in the other case.

Furthermore, we also don't have any interlocks for incompatible other
flags, either: git-show-ref(1) won't complain when passing any of the
mode-specific flags to the other modes. If we want to fix that I'd
rather defer it to a follow up patch series though. And as you said, I
would almost certainly expect there to be some kind of fallout if we did
this change.

Patrick

--bisKaXg1hrMC1x/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU5ARkACgkQVbJhu7ck
PpTsxw//ZxSMG1voNdokuw+uquKYokUJLYaoscEdKscVfYkNCXyTTz4ejEq9LeWi
/c6bitBnjC3KDzwwHd9rlsptuozSy3X3XhUpAVdOaEYnhdAJV0mi9gaD9kAfJnh3
+qbD5UO1f+ZekvmNeGLhZi4a9iItUlfQA5xvosFG4QK0qV/kRUZSglB4u36zzPjr
kq306QKXlL74RZbVK1871T71CFvWGWKsVCMVm7RYkKY+C03pAUb7UEd/CnEGZM1E
wkOqLc+qdSk4bNI0O9wU23AB9juv53I/2TIhr3qad3tiUuF/MiGDBuRCazk3wFSd
TUpI54NEXpHz5dsZgvkbaisxZPPvlRCz/oGok3GGcAi+78S2qvrU5MjAKQlrxE/q
irUce0jEa+imZBOKcr5ksJpKhm26qispgl20qDF9mwB2HaOd2C8XoL2hRYIOIolJ
SSfW+s351IZpwNovGsKJ4pfZSJyFdkpNynVumk9nTygdeZfwuNu2OkoMUzUR6t5z
Pik5+89n+KG2uMYvXo077cyNao8Wwrmnjp0zbAIznjLNQ56+nQXB1nY10jbY7f6r
lOvbsA3H/K0FnX6j5tTXa5BXW3YVmgGj+/yZTP4/7QZkR3mSNCqb9i+yJuvdpbRY
oIRUD1XVsFKhI7T7GdDcWsz6KeRBDZNF5LRQQhIoL0rl5yhUW7s=
=RfJw
-----END PGP SIGNATURE-----

--bisKaXg1hrMC1x/n--
