Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQkt8Tkb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqwgxxih"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6614B9
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 00:13:16 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id EDAF33200A05;
	Thu, 14 Dec 2023 03:13:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 14 Dec 2023 03:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702541595; x=1702627995; bh=y6uU0uvvSh
	E+u2PKLwzJ+PKEojqEUFTgrXfQ7upKJ1U=; b=bQkt8TkbZtdyrDHAJZxUUhPi50
	BPZBXM3PefOuZH9+E8/dfK5okvZWVgLtgXUCx+MXqkmrdX8DEeJNn+P6e+Tgs3/R
	rDxq71ZvxAQBsfdE6axs3dvyRKWi1Kt9LmjV0pRH6oRtISz2sby8o9Yx9braHwP0
	ylne4zuszMylhPtjRmNJDL5PL9aTI4INdXkmu10mm4LFxM9AoHWrwzE2J8cc2Huo
	y8ZNSOUQhOft3Z8Zj9Fy0t56v3z/ABfRy9ouKkPoxqrf18rqwY8L1O22alpm3Yw6
	2IjXo9pEQFa0WZUEipYcqyZ3F69g8DdC7BigS0Zsd8+yqCzy/uyqeKQx9o6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702541595; x=1702627995; bh=y6uU0uvvShE+u2PKLwzJ+PKEojqE
	UFTgrXfQ7upKJ1U=; b=nqwgxxihpoI8rR/F5sf8NJA2ttgoA/vO6Y+Oo7KvyNiM
	ypSvRoyqInB/Cp+2qL3LLrgrc5ma999hSBuLjIt0aA+wKNmUIyJNeKcj9UcnrTt8
	vAsu7ZQmzdzo54DZlPIpPXKPZzdDjNS01OoUnPZ3BbE8Ney3azU+0FFspMI1+qMm
	YP7Lt/Qc9RnrKoJrApfcfDBEX6njlWoMD5IB6FjaUGFPIrvtDzIMbirxT4KARqOV
	OUyp/RG4ttrNpyCx/hOcOtOX+Ri/97u1f1mYOKkF5g+qq0+YLVWVoLUG+2d77HNg
	CatUB+h9rkNoPuRd7onMASFutmNKM2diX0wOboCltg==
X-ME-Sender: <xms:G7l6ZbX6Ai5HYM9RoHINg--EY33tEKRbc9rsw-NanBXOqikyD4tISA>
    <xme:G7l6ZTl5VaGNnaUFZImZY-fat7qNaB0yBPwyyH-EhLnsT0CSyqwQIh3WIHjqlnVl2
    6g8VfKa5WvZEPN_dg>
X-ME-Received: <xmr:G7l6ZXYrOqJe-5f6_8N3rLcv0eoNLJHX5m17n2n9dX7ZPR-Wm--KH-e2rI1vByTVxb-al9tbz85IFYvnmkZghFkHQAuInBow8GynsPp_eblUOMY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpedtieffleelvdffgfdtjefgveevhfelteejudfhuefhieelvdelteeigfekjeeu
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G7l6ZWXxe_-EjHxuEEcN1thoWWrEqMQxKDAgb39it6ib0fi_HAQFNw>
    <xmx:G7l6ZVlKBn5WxTb0mIvqwloU2-F4L_81FeDl8AF2LcXQvfleYO3iiw>
    <xmx:G7l6ZTc6bIjemKiZt8RVsRyAvgNG9KTqoA1P2M0MWQjSZrRtOAQ2-A>
    <xmx:G7l6ZVvk16NNN_qfs3Zk34KTJGYsW4gyLdx_0LZ8jdLBAD6CnWolUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 03:13:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b04947c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 08:11:31 +0000 (UTC)
Date: Thu, 14 Dec 2023 09:13:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
Message-ID: <ZXq5GL723v4E3_IH@tanuki>
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
 <xmqq8r5zrzg1.fsf@gitster.g>
 <ZXlbNlG28e1sAYPU@tanuki>
 <xmqqr0jqnnmn.fsf@gitster.g>
 <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s6VUKMyaa1VwNVUk"
Content-Disposition: inline
In-Reply-To: <CAPig+cRc2hW_xhJRPJmEVYik71zWLDQ_EFjBFw095OgPGYrWGg@mail.gmail.com>


--s6VUKMyaa1VwNVUk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:33:00PM -0500, Eric Sunshine wrote:
> On Wed, Dec 13, 2023 at 10:11=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > >> I do not think "prefer host Git" is necessarily a good idea; falling
> > >> back to use host Git is perfectly fine, of course.
> > >
> > > Why is that, though?
> >
> > Mostly because your "differences in features supported by just-built
> > one and what happens to be on $PATH can cause problems" cuts both
> > ways [...]
>=20
> I sent an alternative solution[1] which should sidestep this objection.
>=20
> As usual, I forgot to use --in-reply-to=3D<this-thread> when sending the
> patch, even though I reminded myself to use it only a minute or so
> earlier. Sorry.
>=20
> [1]: https://lore.kernel.org/git/20231214032248.1615-1-ericsunshine@chart=
er.net/

Thanks, I've replied to the thread. I think by now there are three
different ideas:

  - Improve the logic to pick some kind of diff implementation, which is
    my patch series. It would need to be improved so that we also probe
    whether the respective Git executables actually understand the repo
    format so that we can fall back from the just-built Git to system's
    Git.

  - Munge the whitespace of the expected results with some regexes.
    I like that idea better because we can avoid the git-diff(1)
    problem, but find that the result is somewhat hard to read.

  - Fix the ".expect" files so that we can avoid all of these games.

I actually like the last option most. I'll have a go at it and send this
third version out in a bit.

Patrick

--s6VUKMyaa1VwNVUk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6uRcACgkQVbJhu7ck
PpR2Ew//Z4/tvavaL/W9IcGFQLBZuzBHzKvToQGNeXn169JYZMgnR52BEe5U1TlZ
UVcQvEEyypqgHPOl9aQg355/YZqBcXwt6ie+Fw4T2qOaaHfM6wefVqKuOqWQO5ij
agEHVd+FuXvF+SpX+EFM3Hx5Oepj6fUEf0JSMb/4aIyKH7HAqLJMsZn6j5ieRMiP
FYuml//5uQBTHAYpZasMyg3MedyOGQ1gSYHT7JmGWewStx9hOw/OW5nLmMRNnaZX
PSOjCoASniQFETlSGfXWQNLYm405EmoQoem2eRGseCuPt4/9eOMMA1X3uK6u4o2H
SPEAH8YHqeG0gGu7bmd11fK9cGni9gAZ278ZdkGMn+eGXEBXs9tAm4eKP3fPnkwF
dhc865cowvqf3pEHpWCoyoj7DKBTJppSZXK54Qws2lznF2CMEbi4c0KZ3JJiUv9K
PKBdlO9Zjk94vYXicVZcolLJgqh6v612cihTixf1/oHnG57OOuasTVKmwaeuuDSp
+SNBulS2S3RmKHdp5f4y/eQOXM92grDWMJ0LNa9RYgvOlPzBxxyedAO1qw8pP9Yj
GLy9NSBrcDxaf+N65tpY57pd4NI2ZI8DTzjnqjtBuC+ZcdaCh1siDJcKC5wGWBVm
iQJ3Tfz7CbyK1Maci3oSlxETt/BkXHEduJevisAvRVkTjnY0bo8=
=tnJp
-----END PGP SIGNATURE-----

--s6VUKMyaa1VwNVUk--
