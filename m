Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e2G5W2TK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Du8uy4oX"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12E3DF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 07:32:58 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3AA495C0387;
	Mon, 11 Dec 2023 10:32:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 10:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702308776; x=1702395176; bh=3r
	87J6Ip8PuADQW5qUannvkJCqbe2i//F03rB/8tIv8=; b=e2G5W2TKOgkR+tVB1B
	N7Tsh0vdfrZXAVcuL9LSGn8eARUe6PAbpIx4JBCR/U8RQk7MkQcpdx67ExOvbDKY
	cGUrjzz6pOV6bjofwF3tRI/3PmioYYU0GXtDO86yjya7LjqdMbAxL6hsLLFiOMEZ
	CSaGpA19luxBo4R+GXJtcGeednveKGsuMiShJoL+bv5Mh8vUgIUwLZQAV+SVksk1
	ZywHMkdvBjo1lWlVXRObblJALjm0KvIjF5nwuHCjvoYjcgiIeoW6cuE+845gK0lX
	/8QQYGRfi58feXcN9LYMvnFpXBXfcMQAdIlRnieHnfmCyF5zYD3HNAxBC2hmmaNT
	USjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702308776; x=1702395176; bh=3r87J6Ip8PuAD
	QW5qUannvkJCqbe2i//F03rB/8tIv8=; b=Du8uy4oX6CBHMO5MAnLzUUvsxxY+M
	/1ByV5UblIbjuhzIebFgg1WI179C4xY42suyBwDGCxtiJB2znZunNjcbOPS5ojf4
	H4hvSf607am6/lcrFIvfoXvxts6PyHXv02GyVcHEQghGwD1N+LSJWDCkZP47dPNy
	wFZ/suNcopfeKXoGMrdBWJizYibPfm7lXP7N7j0hRUkgI+WIhfy8JiRCx9CCBvaQ
	S3YiHMyzirDAtq+j7epjFu4U6fr/wW3t7OKxD9bmKzkqqN0wNtRvLpL429AtpXxn
	rsWMJH6wZ9ZSak7TOBXcmRyByOD7VWAVD8e+aCSEVhL7l4Zqpz1k1BtMA==
X-ME-Sender: <xms:pyt3Zf1lIMkGvl0Utk1v79R81644WBxbCU8sxH_6RtqwUDHCEp3BKw>
    <xme:pyt3ZeHWnnFozM_YwxKsEv_SjXDXkwp14gTjL1Y8LwqYDXE1O2bsFgjCRzKCSEhRf
    2-X8Vk8vFlpKPDSUA>
X-ME-Received: <xmr:pyt3Zf77e0KjjsoXIMYQ1vzzOHse5fxmrs8_dyeklZh1j7QIgDNEcN9C08hxsQ5Xt4zLcs7oH9WLiXLlZZ44eMy0HB6aGrP80uOFnS7dPxwrAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeevieegvddtueefteffkeekjeeuheffud
    ejhfetueeuffehteevtddvjeevkeefvdenucffohhmrghinhephhhtthhpqdhfvghttghh
    qdguuhhmsgdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qCt3ZU3rO4prsyWZI7NuiNVf4C6rzjprmaHQpIMdyhn-WyCCYcqOjg>
    <xmx:qCt3ZSEiKp7ma-pmymfn07_XkmSf_whK492Tl9ENZB7HTGBHTNfYyA>
    <xmx:qCt3ZV_K7MdOPk5T6Zd6E0Cm6hhAZQOKMlJwt9yF-sovtqV7x_tu3Q>
    <xmx:qCt3ZUMzVvluLmqHpp1vkIGjs0Qjkjv0GJkenS43PgRyGEaFcScbtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 10:32:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e96e3670 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 15:31:17 +0000 (UTC)
Date: Mon, 11 Dec 2023 16:32:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
Message-ID: <ZXcrpGQhH121AQ7y@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <xmqq7clmn3w1.fsf@gitster.g>
 <ZXbzzlyWC3HTUyDA@tanuki>
 <xmqqmsugvlbe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MW0/sCdbscNpH8+F"
Content-Disposition: inline
In-Reply-To: <xmqqmsugvlbe.fsf@gitster.g>


--MW0/sCdbscNpH8+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 06:57:25AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> An existing test
> >>=20
> >>     $ make && cd t && GIT_TEST_DEFAULT_HASH=3Dsha256 sh t5550-http-fet=
ch-dumb.sh
> >>=20
> >> passes with vanilla Git 2.43, but with these patches applied, it
> >> fails the "7 - empty dumb HTTP" step.
> > ...
> > Before my refactorings we used to fall back to the local default hash
> > format with which we've already initialized the repository, which is
> > wrong. Now we use the hash format we detected via the remote, which we
> > cannot detect because the remote is empty and does not advertise the
> > hash function, so we fall back to SHA1 and thus also do the wrong thing.
>=20
> Yeah, that is why I did *not* say "the series *breaks* existing
> tests".  It triggers a failure, and in this case, a test failure
> does not mean the behaviour is broken because there is no correct
> answer.  ... oh, wait.  There isn't?
>=20
> I wonder if the right thing to do is to advertise the hash function
> even from an absolutely empty repository.  There are no objects in
> such a repository, but it should already know what hash function to
> use when it creates its first object (determined at the repository
> creation time), so that _could_ be advertised. =20

For the smart HTTP and SSH protocols definitely, and we already do. But
it's a different story for dumb HTTP, unfortunately, where there is no
CGI-like thing sitting between the client and the repository's data.

> > The only correct thing here would be to use the actual hash function
> > that the remote repository uses, but we have no to do so.
>=20
> We have "no way to do so"?  We have "not done so"?

We have not done so until now, and we have no easy way to change this on
the server-side as the server is not controlled by us in the first
place. That leaves two options I can think of:

  - Try harder on the client-side, e.g. by trying to download the
    gitconfig as you propose further down. I wonder whether admins would
    typically block access to the config, but doubt they do.

  - Change the format of `info/refs` to include the hash format, as this
    file _is_ controlled by us on the server-side. Doesn't help though
    in an empty repository, where the file is likely to never have been
    generated in the first place.

So it seems like downloading the gitconfig is the only viable option
that I can think of right now.

It does increase the potential attack surface though because we would
start to unconditionally parse a config file from an untrusted source,
and we did hit issues in our config parser in the past already. You
could argue that we already parse untrusted configs via `.gitmodules`,
but these require opt-in to actually be used by anything if I'm not
mistaken.

So... I dunno.

> It is possible for the client side to download the $GIT_DIR/config
> file from the remote to learn what value extensions.objectFormat is
> in use over there instead, I think, but at the same time, I highly
> suspect that dumb HTTP outlived its usefulness to warrant such an
> additional investment of engineering resource.

Fair enough. All of this feels like an edge case (admin that uses dumb
HTTP) in an edge case (the cloned repository uses SHA256) in an edge
case (the remote repository is empty). Sure, SHA256 is likely to gain in
popularity eventually. But at the same time I'd expect that dumb HTTP
will become increasingly rare.

Taken together, chances for this to happen should be fairly low.

> The simplest "fix" might be to leave what happens in this narrow
> case (i.e. cloning over dumb HTTP from an empty repository)
> undefined by not testing (or not insisting on one particular
> outcome), but ...

I would be fine with that outcome, as well. It's not like the current
behaviour is correct in all cases either. The only benefit of that
behaviour is that a user can in fact work around the broken cases by
setting `GIT_HASH_DEFAULT` to the correct hash, and that benefit would
be retained by the diff I sent that made remote-curl.c aware of this
environment variable.

One additional solution would be to print a user-visible warning a la
"warning: failed to detect hash function of empty remote repository" and
then call it a day, potentially pointing out that a user can correct it
by re-cloning with `GIT_HASH_DEFAULT`. But the warning may not be
actionable by the user, because they may not know what hash function the
remote uses, either.

Patrick

--MW0/sCdbscNpH8+F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV3K6MACgkQVbJhu7ck
PpRu6A//Uf0eb0sHUu55JNc9uCgYL5L6PLVLzjOZTs2IiomVCCNUU+O6RTed9P4s
WNclVwIu6AcfHUMIerrzLQ1Fv5AsXo6F5xRWPDEUTGfbApPE0ugDModxuTRoZtsu
oqx219CcK7/e/NVw6JvDZSt5tXpw6oacMRLXB0CTI5ZbiUq3JI0ggP7AlSDzeFpc
YbW72zxQizorZIufB+zYhwmJd+4rr5ik0/cXODZoRGSM/L11d/l0fNyC18rcscVS
ypOdFfVq1xDX3vjGNKsnPchooa8wXlHyTX8pg3DCNkMlSfoqoKHHZHT2YhPxOyok
A+GgbGfGlefYc3UmyOuhdmTIuycIFtLWVWb3G2RSot12RDNl5AA/hnv0fCAQvVCC
PynQBRGjWCgZveH9YaQg5wmGYRfGE8yB+Zna7lY4CuF5ZCdbJpGlQBwChnLKxvf4
d0GviCCKeKJeuEkne9gb6pPmPlC0CB4DZQJ4IOjEYRJQ1Oaiv7kJz2aAnK+Jz+nB
T+Ro+m9B0iujyRZ3rdiMY3Z9YojWSF85Qwho1+HMcG0irgy754bTkanhfSxR31oS
QU42s309Z4EJ3BkCg6recqSuFX2agvjOVmiIVjBDz0Zr57oLD0AidJPO91rT291t
8LKZNPmT6O3rpbat6l+aLoY/knba6KQlxN7+vCxz5mC0YhDiRt0=
=y6Sh
-----END PGP SIGNATURE-----

--MW0/sCdbscNpH8+F--
