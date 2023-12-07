Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FANFp+Cf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9lBIUzi"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637DD3
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:01:47 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id D4C2C3200A24;
	Thu,  7 Dec 2023 02:01:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 02:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701932506; x=1702018906; bh=sq
	vMUoekKn3pWxY9ai5JIHBnH+3+eZkfNkiqzWYhbgw=; b=FANFp+CfnsgAbn/OZ3
	OAXuy4M6WWW1htaEv7CYCU0gscmozjex7E1a7byGSFIpMAPxxliXXzlTQlQIlYgr
	YASYvFtDw/FC9stABbESxI+j281j8V/Pe8GqOvX0vMYcXHsvU0LrSG+7Bh0ftIIQ
	ogel2qdpdBuyFpGl3PEu6cQNYNTPGIgART1tEQmZwEjGdge7W0Ad7fNe7h2G/Gfq
	9XfztlmklWfpMkzrvoXGoRYnmVFfE1G/CDSD4S4rAnx0ySEYX+lPznUS7OD82TL+
	zHi1a2KZ+X2Th6PKvtRD8PyMkdSxsv7Au72DAFwjkk9G6On1VeRCazUZZmr6dxZM
	akqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701932506; x=1702018906; bh=sqvMUoekKn3pW
	xY9ai5JIHBnH+3+eZkfNkiqzWYhbgw=; b=U9lBIUzikOqTME5L2CZAttrGtSQu3
	ILLxq1vzbUQ6PhBG9zEkBlbUP/2WSmjF6bk2BfgWTG3VYsoMlxddqWzqLF0QjR9q
	TWMjewXGLlWgqiBDQgd2GL9yiWZvS3gSlMBRjRuUHjg/mpeQ0UWyDvwqBUXblBIV
	lL0t7jrN0Frs1bT1rpi99yQUuMr7A2Lq7YSWFBf+mI+euNzaSmssFiCD63pFac7R
	ucXYVh4qxbC7LvDgeIfBdQGOyCoRUwoq1aPZw85qHQcIVN+xpPZJ9awM4TrfH24R
	Jn1rQWUcu5cisNHKMF2mZbLgiSDcEYJccfbq0zeLI5FOrSAQ5OMJ+X7oA==
X-ME-Sender: <xms:2W1xZbyQ2RMChJoGJgpQuA2vjFfCtpR4XOcrhk66SI7snjDFCqlYfQ>
    <xme:2W1xZTSk8aj9TIUe-oeEKcrIbdbyQc3kJqMrC_diPUnndb5hh7XdB40vnKT0S4z8M
    uBHZRpTc8AuImUn8A>
X-ME-Received: <xmr:2W1xZVX6uXf4ERdhvGqZK1eCp2PlMxdCBHOnqFM4lh7wqYX1Jts045VzuBwLhDSkE93oQPyrdReasW2NIs35BSvXtgmy0Y0NQWw94es20i-DL10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:2W1xZVhgV9I0fN7MW1j7MU9uFUwJBQuKfy8VVQ1W8b7uH8cMT9wEVw>
    <xmx:2W1xZdDZJm3w2TdpToA_vR2ZehXzHbbT83AriUOsOENO-sI0Q7qmcg>
    <xmx:2W1xZeI54g3Wwyi7IZKyGcWWnGOPxmfTNwT_uL_E9Y4Q3vFkd6F7WQ>
    <xmx:2m1xZa4eKRLpoc1_y8KAiq7F1WFhmZt4TQ8cImr7uj14JsYsaw3HBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 02:01:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0a683ede (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 07:00:15 +0000 (UTC)
Date: Thu, 7 Dec 2023 08:01:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZXFt1foDuHKBmFwk@tanuki>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWcOvjGPVS_CMUAk@tanuki>
 <20231206201048.GE103708@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="luFppGIUoEgwvLvZ"
Content-Disposition: inline
In-Reply-To: <20231206201048.GE103708@coredump.intra.peff.net>


--luFppGIUoEgwvLvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 03:10:48PM -0500, Jeff King wrote:
> On Wed, Nov 29, 2023 at 11:13:18AM +0100, Patrick Steinhardt wrote:
>=20
> > As I'm currently working on the reftable backend this thought has also
> > crossed my mind. The reftable backend doesn't only create "refs/", but
> > it also creates "HEAD" with contents "ref: refs/heads/.invalid" so that
> > Git commands recognize the Git directory properly. Longer-term I would
> > really love to see us doing a better job of detecting Git repositories
> > so that we don't have to carry this legacy baggage around.
> >=20
> > I can see different ways for how to do this:
> >=20
> >     - Either we iterate through all known reference backends, asking
> >       each of them whether they recognize the directory as something
> >       they understand.
> >=20
> >     - Or we start parsing the gitconfig of the repository so that we can
> >       learn about which reference backend to expect, and then ask that
> >       specific backend whether it thinks that the directory indeed looks
> >       like something it can handle.
> >=20
> > I'd personally prefer the latter, but I'm not sure whether we really
> > want to try and parse any file that happens to be called "config".
>=20
> We do eventually parse the config file to pick up repositoryFormatVersion.
> But there's sort of a chicken-and-egg here where we only do so after
> gaining some confidence that it's a repo directory. :)
>=20
> I actually think the "ask each backend if it looks plausible" is
> reasonable, at least for an implementation that knows about all
> backends. Though what gives me pause is how older versions of Git will
> behave with a new-format repository that does not have a "refs"
> directory.
>=20
> There are really two compatibility checks. In is_git_directory(), we
> want to say "is this a repo or not". And then later we parse the config,
> make sure the repository format is OK, and that we support all
> extensions. So right now, an older version of Git that encounters a
> reftable-formatted repo (that has a vestigial "refs/" directory) says
> "ah, that is a repo, but I don't understand it" (the latter because
> presumably the repo version/extensions in .git/config are values it
> doesn't know about). But if we get rid of "refs/", then older versions
> of Git will stop even considering it as a repo at all, and will keep
> searching up to the ceiling directory. So either:
>=20
>   1. They'll find nothing, and you'll get "you're not in a git repo",
>      rather than "you're in a git repo, but I don't understand it".
>      Which is slightly worse.
>=20
>   2. They'll find some _other_ containing repo. Which could be quite
>      confusing.
>=20
> So forgetting at all about how we structure the code, it seems to me
> that the problem is not new code, but all of the existing code which
> looks for access("refs", X_OK).

True. The question is of course how much value there is in an old tool
to be able to discover a new repository that it wouldn't be able to read
in the first place due to it not understanding the reference format. So
I'd very much like to see that eventually, we're able to get rid of
"legacy" cruft that doesn't serve any purpose anymore.

The question is whether we can do a better job of this going forward so
that at least we don't have to pose the same question in the future.
Right now, we'll face the same problem whenever any part of the current
on-disk repository data structures changes.

I wonder whether it would make sense to introduce something like a
filesystem-level hint, e.g. in the form of a new ".is-git-repository"
file. If Git discovers that file then it assumes the directory to be a
Git repository -- and everything else is set up by parsing the config
and thus the repository's configured format.

> I dunno. Maybe that is being too paranoid about backwards compatibility.
> People will have to turn on reftable manually, at least for a while, and
> would hopefully know what they are signing up for, and that old versions
> might not work as well. And by the time a new format becomes the
> default, it's possible that those older versions would have become quite
> rare.
>=20
> > Just throwing this out there, but we could use this as an excuse to
> > introduce "extensions.refFormat". If it's explicitly configured to be
> > "reffiles" then we accept repositories even if they don't have the
> > "refs/" directory or a "packed-refs" file. This would still require work
> > in alternative implementations of Git, but this work will need to happen
> > anyway when the reftable backend lands.
> >=20
> > I'd personally love for this extension to be introduced before I'm
> > sending the reftable backend upstream so that we can have discussions
> > around it beforehand.
>=20
> We already have an extension config option to specify that we're using
> reftable, don't we? But anything in config has the same chicken-and-egg
> problems as above, I think.

Not yet, no. I plan to submit the new "extensions.refFormat" extension
soonish though, probably next week.

Patrick

--luFppGIUoEgwvLvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxbdQACgkQVbJhu7ck
PpSlrg//aPRKxVwfu8cTM7rgpFE+yWuCDSoGRqAXyFH/8njgX3CrhvRMAf3yYY2R
1ufMf4pIgz6wGucblQtFI+aqvCp2SduyEmeGkt39SBm6PLjhCHOG032iULRp7GXY
VpyXxdms6AH3t4N3XxFQRq5VLJzFydy4JusHexWQ00IBUhH4geGNB7mYzLFnAo80
fcFY9bTNqrVvOOTgknlqnF6Hcjaj+o9GNXQdmBsudS3UlRoFQiejKkpJEqZuRnVP
3+owa5o9t83AQRImr6iT7uS0EgES8SE3r5y0lAWXxbfbvHJgufhBruePskWY2uYw
2mEZCmFNCoVpCPHkFbJL/S3YIcSf6h4x60Im4ClGWQoQRYUIENbWlIKVQbowwaW6
O+zvCUKZs1B1PGLoAoe7RDfWrIvOkd0BT5HALDn5UijowcIP88LDIH4KUIB6PhxO
EOwvJrV4+eThtS8fyLBIfOJafpzSDjv8TSUFxdx4qfxMdbxMXF2GRePCzvEXUpLv
e2A4cRUAufIO6N9BdmGVnAUNVUv3jaEgAqvGoNcbEpIAb5FUaeoMaIvVPDhqJFin
ow0nESIFlPUEqcVoQM64t0vbBHgRqWDxrWbqXUoUk8dXxYaTWDP8nivRe+0nNlyP
StyNC1Ac4yClcJ9eiK1oWX0gvhc70Ro3mzc4THNwjQLctJ27IO8=
=jdY9
-----END PGP SIGNATURE-----

--luFppGIUoEgwvLvZ--
