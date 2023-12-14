Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UQTKyOEz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z2+kA3xB"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B572710A
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 01:05:07 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 0A3DE3200A98;
	Thu, 14 Dec 2023 04:05:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 04:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702544703; x=1702631103; bh=Vf6tbEperG
	Z9crmyUBsIGqyqSKk8vee4yGKN7Gtni+k=; b=UQTKyOEzemD2157WpjEWGaSO25
	6gr6SNdcMs+ENOPJiX/5Gii1C2rpOvDcEoEQkRU88/JBtJz4QZZ/txsBe6Q17xSL
	gETGs1z7bah432mBuArLz9ok/qfakYJBJrYvo+E/y2QjeLypDWi8uMla7sHKl0EK
	aS019HModDuDEDsgacSFTDqwG1ioJwEqHMmw9MqX1mdCKjQ2Bbo8JTQ6GvpWOR7T
	cyRFKt+jX+//upjerypi0oPi1txNYKSmOt67qBUg/5aNr03nXqHSTvgSDet3Ogwt
	O3+E2UeDUJXmUB6IOqpsXW8Gl/yjekXxo7QTHUt+1HopGzif8UceOwH/Xp9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702544703; x=1702631103; bh=Vf6tbEperGZ9crmyUBsIGqyqSKk8
	vee4yGKN7Gtni+k=; b=z2+kA3xBJ53fNdD5eq+y8cdDo0yUzxr+8uVUvEBvn9wT
	fEF0ZS8DyVJgNipgry7Q1I5Ia4m2EfDxlOT3l9YpU4LzQoMfkCqihB93LKbEp+5R
	Q40Wn0yPbwjgU+Nb+efoWADADG7pbSVuX/aHrfNfQJ600Nl5IWtAfilUfLG1J5I0
	Jt+iTxEdIEbPreAaYXbC25BShwgk0m5KF/oBNX0mXcBpTDBRrRcnHASH9QL56glR
	T/jc1XUu8iXD9EjvyIGA6DyRi3UNZNnm0MBoANWCNsdd3jMzPsPfVBseXHD3O+9T
	THkJDXMnK6TJ2EoykH/eF+7cSAZHH9IAhBCtFdrTmA==
X-ME-Sender: <xms:PsV6ZexH024evmeP0Ilzxxj9BMWCIzpQkknzABJXt3d4P1G-OQlBZw>
    <xme:PsV6ZaTDGUDdqxERNC2y2eHe4nFCegXOmrfq6gz-vcuubkqU1NF8lvbY28mxIG-l-
    V8e0O8nITVUVvQjfA>
X-ME-Received: <xmr:PsV6ZQX9Tfu-zS8yvoYqQWpejop4zeSBlnVJm2gNLuCXgKK9ncVQrV552jltuV-Ou44zrOdepvI9jzjHZDEFm5R_gn721PYhJ5vWQS4UzRAJFVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelgfeitdffkedvteffgeduuedvffdtffehteefleffvedvffehvdffgeelgeeg
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PsV6ZUilBu1nYIktbAKBVKFILEeUpu3UqNuVrm6Ka1Hxvqz0sE2tGQ>
    <xmx:PsV6ZQDU9u4FEGAr0Ss8lAWiWt2inykzDhcuWsPRBbwVPOLTlBd1eQ>
    <xmx:PsV6ZVLgdnLtiQ8p9Ng3qM_aTIuBPKDnjz7q-p4tseUUl8nR26fqcA>
    <xmx:P8V6ZTM-KNY8dUZLQfGtmZ07gxWj4NPLJh6DfhV6Qkxdi8no8ErhMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 04:05:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84c64c7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 09:03:17 +0000 (UTC)
Date: Thu, 14 Dec 2023 10:04:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZXrFOtKNLxyT8Csj@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
 <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
 <xmqqle9zqidj.fsf@gitster.g>
 <ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
 <xmqq34w7os53.fsf@gitster.g>
 <ZXlfeWtDgr1GQFCL@tanuki>
 <xmqqmsuennfu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jpOQoKQcfPW+PL+p"
Content-Disposition: inline
In-Reply-To: <xmqqmsuennfu.fsf@gitster.g>


--jpOQoKQcfPW+PL+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 07:15:33AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Me neither, but once you start thinking about getting rid of the
> >> need to use one-file-per-ref filesystem, being able to maintain all
> >> refs, including the pseudo refs, in one r/w store backend, becomes a
> >> very tempting goal.  From that point of view, I do not have problem
> >> with the idea to move _all_ pseudorefs to reftable.
> >
> > Yes, we're in agreement.
> >
> >> But I do have reservations on what Patrick, and the code he
> >> inherited from Han-Wen, calls "special refs" (which is not defined
> >> in the glossary at all), namely, refs.c:is_special_ref() and its
> >> callers.
> >
> > I do not want to add "special refs" to the glossary because ultimately
> > they should go away, with two exceptions: FETCH_HEAD and MERGE_HEAD.
> > Once we're there we can of course discuss whether we want to explicitly
> > point them out in the glossary and give them a special name.
>=20
> OK, I somehow got a (wrong) impression that you are very close to
> the finish line.

You mean with the reftable backend? I indeed am quite close, I've just
finished the last prerequisite ("extensions.refFormat" and related
tooling) today. I will send that patch series upstream for review once
my patches that fix repo initialization with git-clone(1) land in the
"next" branch. The current state at [1] passes CI, even though there
will of course still be bugs which aren't covered by the test suite.

So once all prerequisites that are currently in flight plus the pending
"extensions.refFormat" series have landed I will send the reftable
backend implementation in for review. If things continue to go smoothly
I expect that this may happen at the end of January/start of February.

Anyway. This patch series here is in fact already sufficient to make
reftables work with those special refs. The only thing that we require
in this context is that refs are either exclusively routed through the
filesystem, or exclusively routed through the ref API. If that property
holds then things work just fine.

But still, I do want to clean up the remaining special refs regardless
of that, even though it is not a mandatory prerequisite. I find that the
current state is just plain confusing with all these special cases, and
I'd really love for it to be simplified. Also, I think there is benefit
in having those refs in reftables because it does allow for proper
atomic updates.

> If the intention is to leave many others still in
> the "special" category (for only the reasons of inertia), with a
> vision that some selected few must remain "special" with their own
> good reasons, then I am perfectly fine.

Okay.

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/58

--jpOQoKQcfPW+PL+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6xTkACgkQVbJhu7ck
PpRmohAAj6E5Ovg/qtCkyDeH3BBixLL5oQnDDD601PL7cXc90of79gTHTMyhPUDk
oTiXl8WTA2rYebsPhrwTfxaMjcNkODfHPANNUko3kCSqiN/W83GnG53ibRyJ998e
sa6Yvt8CWGbUJZk1zmjcIxne5hMQPo1DVaCPqlnhpURdr9jb8PiVxmaEYcertLic
g6SRwcFeZMPkBtrghC5bEyt7Mdr2h6p1iIPZhk/tX4n3MKXleZmQtM5oyxA7E7CQ
GAO+lyjH63nnxx70r0iFZhMve9EJ9p2gmdEsxTGppiF9358mEcDc11SCkBPle0lo
xpRQ1DU0+A6lsatiAgKM4qxmRhGBzi6Z9FW2JNkKQUwJMjh5Re8VqIAPXHXX9xr2
4kRbAMYymlVED0hJta0cB9Vau7OWlx7RBzT/iriVy9hDzvTEoFwwWQlLgbf0EgJR
kluT9N4QqFic8qHZbmbC35lbQGkE6fiRhrV4gJN8lIiU8T6o4yXpVMWlAKJ0vyw4
dq+0T15fLdwXJ1WO0zfCuvPLF8oTB5YenEjJH4PoI5hf+zzQ0F2SjHXzlIZpEMXj
nXCvgjoT+WXL6dZENdj+80diMxnuDCVAUxQh53wDBpBwygLTcWgVT6dth2rrLhGN
uSvHa050CdO6qIR7K9fE1VaoD3NIVWsielETlWYFNrBvGtkn0JE=
=9OSB
-----END PGP SIGNATURE-----

--jpOQoKQcfPW+PL+p--
