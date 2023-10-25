Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8D154BD
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZvKyK2L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T7iGykjB"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925E91
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:05:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 956275C032C;
	Wed, 25 Oct 2023 04:05:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Oct 2023 04:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698221108; x=1698307508; bh=lU
	bvddw67+RW1V2mFMtrTqemk4M/ZArmrLvsPU7IqIs=; b=jZvKyK2Llfk3nmAR8v
	DQQtXp603OC+ER2hd9Qk6WbQ1ogsPgNx8IXBF/gfxx0YW9AZ8o/QCPEBpiGBHOHA
	cSemduv5gK1qTKPe01o5MD5mLHof7uBJyn2W24I47w6Z6RYPkmjhqAEAD6pbw3dI
	uM8UFRdotd9Hm2u9Ylp7/mWAUKZBP2ef5jqEqTlUDUxBxui5QSjI6i399e9COqJi
	enxD7n7+/+udWAHfDjuE4mDdD78wmPSzV7vn4lJ39lwLKir/oqSlDGPPUHN69uwF
	Dt1MhT8AUdStVaYznHv0QMJmGv2N6Qa4/XM188JNGW1x2ZGI+HoIR5+zb717Y+wz
	CBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698221108; x=1698307508; bh=lUbvddw67+RW1
	V2mFMtrTqemk4M/ZArmrLvsPU7IqIs=; b=T7iGykjBnLDfkpoOy2h49uyhyGAQ9
	1f3RYL+niqJ+EWvVCJwI6lML5xQ0MEv4tk5AUmXjfg+aUxmUSdcScrlMl5mn8mKj
	mKgjqPeTNH7dl9WRIHstx1rG7vds0jLruNZiCR7Cd2XlVhHgbPHSOrLJ9iU1I/Iz
	3NltLxuZKKa9Sklf/wvUbu846z6mOJMR6XFoAa2y9Ku9tOn4Es75X4ZNwVPw1irF
	bMlLxZ9V6s75ghAMMierc6/6o1FLAkaZ3Tcsvusv2x+mHT3krtBG6yEWZW/EnPmB
	MuSrES6pnZNc1DOYMazUasnWqnT0PmbND9Q6OFydH7JMs+sfocWVGwXPw==
X-ME-Sender: <xms:NMw4Zd3WVoM8jz23OSYb-vABermN2b3NGIaiDSfujAE9Vj2KnbFDdg>
    <xme:NMw4ZUEmtvLXmAJnlGMQou3KjbUikxk6K3mFor6P9ReLKyBsjNCNooTtWjoAJBLBS
    6CX_8oF8TeChGQt5A>
X-ME-Received: <xmr:NMw4Zd4HOZfa-RpTR0FV5uaNYXmoMal13HRcUOOhk4vrWokDpi3GLCsM033YdoSAqLh8zvtZzHwtH92_vZ0bNYBzqZ8rv-STRMZfsu6juMFckmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NMw4Za055alqvVj-RwrrPof1gdkaAhC8jwf4z5vufmp0ftsrieaFFA>
    <xmx:NMw4ZQHBKraHVHejW4SJlbbhR2OZdZAXXiuBboFgvJjBz7KP3lhMSQ>
    <xmx:NMw4Zb-vbUVZCuKs7FtEsFL98KYbD76h0fg9-NSGGLk9YIs1Ty_vJA>
    <xmx:NMw4ZVSNUko0w-OOg6tH7Qe9abC88lLyFLC0AMB_1We92SZn5q5tLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 04:05:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eed56c0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 08:04:59 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:05:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file
 retrievalync-mailbox>
Message-ID: <ZTjMMC1GiPJUXnQm@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
 <ZTZDqToqcsDiS5AP@tanuki>
 <ZTav2u1JWmLexEHL@nand.local>
 <87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>
 <ZTip7JWm-WRWTImU@tanuki>
 <2b764f52-d3ae-467f-a915-fb73beb247bb@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8g6Q8X2nKbJgIz6b"
Content-Disposition: inline
In-Reply-To: <2b764f52-d3ae-467f-a915-fb73beb247bb@app.fastmail.com>


--8g6Q8X2nKbJgIz6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 09:33:23AM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 25, 2023, at 07:38, Patrick Steinhardt wrote:
> >> What do you guys think the signature of `git_global_config` should be?
> >
> > Either of the following:
> >
> >     - `int git_global_config(char **out_pat)`
> >     - `char **git_global_config(void)`
> >
> > In the first case you'd signal error via a non-zero return value,
> > whereas in the second case you would signal it via a `NULL` return
> > value.
> >
> > To decide which one to go with I'd recommend to check whether there is
> > any similar precedent in "config.h" and what style that precedent uses.
>=20
> Okay thanks. So no parameter for determining whether one is writing or
> just reading the file.

This parameter would only exist for the purpose of the error message,
right? If so, I think that'd be overkill. If we want to have differing
errors depending on how the function is called the best way to handle
that would likely be to generate the error message at the callsite
instead of in the library itself.

Patrick

--8g6Q8X2nKbJgIz6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4zC8ACgkQVbJhu7ck
PpR9Ew/+PqtJQ5Ak77yIeKJoKY11Sv1RzG7u3tnjJvxfzVe2+hDpZNOSVcga6DmR
Tu2ufpbKYIKnH2Tueqmq9Rw8KuGGr4WGIi7E6ehQ05nooaZSEVt3iZmnTtuM6tHX
VBovvJ2ks1dXZPuS1hiCL/aO2ZzUjsEvHVq1yi6Vth1wOQMNarxa2q54OvpWcitO
2x7ysP8fzVJMrrcE16jRKBgw7bOmxnpztkPWaEwPK3E9Lgnrjr1MReFFgFlUtKik
wjwcBO4psEr4vGImvLsdFX6nAXHMeztM80QpMRfpDCZOy3Gyl/dXMdm4V9Bjx5D0
pL+bMMOcW8ixcShsmyrTBqOQjsvXXuZbRDw8oyZmAWsWQTvLv1ztd9aBW5OUJxDi
jI3XV/VW1QoPks3W0a25iE6GBzX1wG8VOX8KFnC+DweBtbKYaBu7plbmWsq/iJqL
/uRFiC5Gjdyn8JqLfRXV/Lfk+I32UAb8ZE6DlfB7gWaybFYtr567tFkbuGMTASJn
y5YRSzVXz7oPbjAtApp6dIpAzGu0WDu1SfQL7KelU64N4/rZlX8zWzPLyPzTv5aZ
03KRpLBwkKAWIqeUVDWdldFvtAxCteNbYLqWdyHWLM0ioszQdMSKunt/sm7yatY+
PI/rBxSfzCudQu48V11y8+DasQiFS8dyQfwLOH3o8lv8OGE7zSQ=
=k6AL
-----END PGP SIGNATURE-----

--8g6Q8X2nKbJgIz6b--
