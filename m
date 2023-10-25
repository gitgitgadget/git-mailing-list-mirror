Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FF2D636
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BRd1EZfB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kuaKjn39"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE580130
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 22:38:59 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id C2EDB5C02B7;
	Wed, 25 Oct 2023 01:38:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 25 Oct 2023 01:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698212336; x=1698298736; bh=3v
	scJI428EVSRQL7oTiOMoPLsWiGKo7TYIcPndPxzi8=; b=BRd1EZfBYtj1mpaRLd
	uKsEoZEd08T2vxF9xqZmLCRQlo+KepDq1X0OxnmEhleA7mqYiduOq1gY3EYmRb5C
	t3YR4RfCYUtBLQCGA6Zm3GacQk0clceOuAtkMoyofO/9NI82f1JKrwYZFQcCoCjf
	7qkEmegiizQ+pC7eX7JGNN4P61Y2GB/HdYv5b4831N9Gh01nLZ8GYjPxkKW/z6Pm
	ay4T+ysXrYnGb47Q+YOS//xyXGxtk+1Fd3lv6FKibuu5LonYpiMtRzQ6A6VoyuMS
	AqBjVlQbhy1P8xDCyIU0lRvjlug0CnbN/WGunKT0JafE/MUTz9D714qthEqOem1O
	2VDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698212336; x=1698298736; bh=3vscJI428EVSR
	QL7oTiOMoPLsWiGKo7TYIcPndPxzi8=; b=kuaKjn39c595kk4BAsVdQ6tO1WNl1
	nitlaSKESDetXLsWw19YPr76ObyMuAJGLyNMCQuWsnnu22uRbuz0BIaitlrCzzcZ
	lZN6O7EDFtQYI9M5FrH2T+UFq+gJkMB43TEuIKynRTZq/f6qYofI/ak286uAg+0b
	4V+WOg7+476jRyLkFo+7sD3MlnwdCJHtE9nFOUMZ3X+HY621nOZ09PSuhs9Fp+/W
	+yPQQGQFcQ9qbn9F58Ol7ulqkH4RnLeDNwJJmxNV+JQg1UysSYhS5NBUN17hiViA
	NQaAsvgNqUuX1LsG+0Yk+3FNJJy0ORkNMFkBVemOJqlyP9wdx+YATbzAw==
X-ME-Sender: <xms:8Kk4ZX47vJJNFjJ9hlWJj-qU9sWSHUPcXY5X4KA7wSaSx366gGxJOw>
    <xme:8Kk4Zc6ktvsCei3ZM7fAt4aWpdQGYGmYS81eE1q2P5ZfaWMQytDSlwxthIcITB7hA
    lgwqL3nrIKUxsvoOw>
X-ME-Received: <xmr:8Kk4ZeeXHc5lXdxhgbErWY4BxuApxEzJkFzLlabQQ1BJnjEFh-OQuZ1t_ELKldy-Fl5ANYjYuXZsu7EsiaXCnnbdmrTQRRKkCUP15z8_NyC6jR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8Kk4ZYKj6vi72cdBcme8CXFymSVaM9rwBC9gazZUoHAecrcZcN59aw>
    <xmx:8Kk4ZbIu6n5JiV5LPexi1oY45HyvOM-HOkoDGua2NFfPJpoZxbN7cg>
    <xmx:8Kk4ZRxqqFh5qQEnFPkxEpSu2bfQalnQmtd-a90WoJzpbxx-AHDQ2Q>
    <xmx:8Kk4ZSWgtdm3CZ8kMr83EYZHRW2PCu7CzPwo8HT6DSsQnwG_DelDeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 01:38:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93c163a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 05:38:47 +0000 (UTC)
Date: Wed, 25 Oct 2023 07:38:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH v1 3/4] config: factor out global config file
 retrievalync-mailbox>
Message-ID: <ZTip7JWm-WRWTImU@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <147c767443c35b3b4a5516bf40557f41bb201078.1697660181.git.code@khaugsbakk.name>
 <ZTZDqToqcsDiS5AP@tanuki>
 <ZTav2u1JWmLexEHL@nand.local>
 <87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hKF01kK+oEFNt/z6"
Content-Disposition: inline
In-Reply-To: <87badbe0-de18-4f8a-9589-314cea46065e@app.fastmail.com>


--hKF01kK+oEFNt/z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 03:23:11PM +0200, Kristoffer Haugsbakk wrote:
> Hi Taylor and Patrick
>=20
> On Mon, Oct 23, 2023, at 19:40, Taylor Blau wrote:
> >> Nit: we don't know about the intent of the caller, so they may not want
> >> to write to the file but only read it.
> >
> > I was going to suggest that we allow the caller to pass in the flags
> > that they wish for git_global_config() to pass down to access(2), but
> > was surprised to see that we always use R_OK.
> >
> > But thinking on it for a moment longer, I realized that we don't care
> > about write-level permissions for the config, since we want to instead
> > open $GIT_DIR/config.lock for writing, and then rename() it into place,
> > meaning we only care about whether or not we have write permissions on
> > $GIT_DIR itself.
> >
> > I think in the existing location of this code, the "if we should write"
> > portion of the comment is premature, since we don't know for sure
> > whether or not we are writing. So I'd be fine with leaving it as-is, but
> > changing the comment seems easy enough to do...
> >
> >> > +		 * location; error out even if XDG_CONFIG_HOME
> >> > +		 * is set and points at a sane location.
> >> > +		 */
> >> > +		die(_("$HOME not set"));
> >>
> >> Is it sensible to `die()` here in this new function that behaves more
> >> like a library function? I imagine it would be more sensible to indica=
te
> >> the error to the user and let them handle it accordingly.
> >
> > Agreed.
> >
> > Thanks,
> > Taylor
>=20
> What do you guys think the signature of `git_global_config` should be?

Either of the following:

    - `int git_global_config(char **out_pat)`
    - `char **git_global_config(void)`

In the first case you'd signal error via a non-zero return value,
whereas in the second case you would signal it via a `NULL` return
value.

To decide which one to go with I'd recommend to check whether there is
any similar precedent in "config.h" and what style that precedent uses.

Patrick

--hKF01kK+oEFNt/z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4qecACgkQVbJhu7ck
PpRpKA/+OCY76ret4zAfD6ny2zbVjtQWxjaxdRUydjiHCEcCfbNAvnCtRbaGFWVf
1rGNySvDw46uisWrJPgZSp6AUajtRkN0Gt2EfL1hmg4usbM7NXLcxuR3eIrCZMsG
UvHKaEsJ0AAsnsLVDlYtN7HS5Ga3G/AwpO9aPxZy9GAPS0cpn14HSQ6NFMQ0t46G
tQCRYgA8BKxSufR52xBYaQ20zCZz7DM/c7ddxW/WfhT4GKXU0qDzm+IljTfLUGll
cqCtqNsQL/P1IzVwL4JgbU73EGji3ie5cBqj7KxysF+lKnufcZ5ZGxMW1GYVthWX
AbH1yH2MBJdHb7bJcB1A3vEzkZGip+T6qTWcbmi0FHJnCG0XNH474CVXLG+dsQEo
HpdDHY2PQV1EnVA35idMpYfWutAsTauIy5C+T0SDoHHlzDWPyhsVWqW1hGZkdfYx
tIqGurfmG8Uhx2FvwHTKePwo6onmVjpEJraRd62BVnofzZFKfij3Vug9Dx4x/UWU
mMtA0r1wzW84u4p2AYRRTAaYRsH4r90DuaujBMYSfmpjkIPeTjK3rzRdG3RNGS/w
hlwovuTQiqXilqG41o7GM7ZarsRB6z7lN2P+qjGWibAI+fGSnFpKtDL5J3epC7Eq
Pbej4wxmCSAoQdzTctqHZeP1XitqAQ7QRV6c3Ejway4r+eplef8=
=kJbS
-----END PGP SIGNATURE-----

--hKF01kK+oEFNt/z6--
