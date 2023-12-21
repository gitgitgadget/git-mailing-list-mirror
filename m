Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B176D1BF
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nviof3Ch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+Iv3p2O"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8910C3200312;
	Thu, 21 Dec 2023 06:48:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Dec 2023 06:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703159297; x=1703245697; bh=MYwAMVXO1N
	jW5zSd29HTqVZf5mZykukX9aIIIAxd+TU=; b=Nviof3ChpxoS1VP4sMyCeLLD4Q
	yWpvP+Xc3DBfR15VgCUGfO4E6SP7wcfOUYS2+ayCdP/EYSRwTHJkWwOoAqTTzy0K
	z+rGjjUXMlQpbSH0vrFFfW17CDDbIfcpp3dpNH9g4WNiWwmhQ2epSIDR4phfA5Su
	1XnqwrvQApxUylv6+GqKE0kuZZfj3Nel2MU26AWgGjOGyBrZIBsUh8xww73fDBNi
	GCTQp7jxwviQW2agpL4tyQBbbwwfxDyhrJ1xXjOzr34HEKvIZqtDGCeQrYI2T0mS
	E9qkYS7tuhbMR/+1hX9c7UPAYtY642l7Bffhen0ovB2NeechInqgm6IoFwrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703159297; x=1703245697; bh=MYwAMVXO1NjW5zSd29HTqVZf5mZy
	kukX9aIIIAxd+TU=; b=k+Iv3p2Om0EodXcL6u8QwTddEDFpaKYe1dm9TWz0KuKn
	U6h3rbJdDtIlMnlpJH2xN80cRTsmXEBA+NqcLKtw2IrRiQxcVoFTym0pViIGqqy8
	VnQC3fTis6XPPowCtUoSy936SFqb8YhR13Xio0uYnYffWEWASjQWd9n+un2CCh6F
	yk13p80EGwskHskk7lgd0LkI102d4Zw909U6aPfIdCGI2B4EDPgoSlyR5Y51hzAO
	QWMuGa6R0I2AULyckdVf8ua8Rj50kt9cDN8wf7sgi1kOnYA4Yj6KpLvquWvixUNr
	WY7cxHU9EEoG022cTUUPpAXVmuyYxmgjcNfyA67Hug==
X-ME-Sender: <xms:ACaEZUr7h7DlT_fyccxZ5z-rwqaS5Nk1_xM_-6F-ozEkGhDmJrNO_g>
    <xme:ACaEZaqW2HESHLmIhfPPxibU2O9Y-LdSdwzxyI-DlIW1-0K9f8BwddcUNctBEQvu3
    eR7zYgiPU5Mk2WJAg>
X-ME-Received: <xmr:ACaEZZM6rVjGLAATyBcka6OxHU0AJRuBxBAC3wUFdg-SDHSQ2jwOrCPC9StZeUuHq4ljz-2fv9YESnnO83lWe32QPO2qx3FCTaX4NJBJLUKvBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhieduvdeufeejvedvjeelheefff
    evveekveefudeuiefflefgieeutefggfenucffohhmrghinhepghhithhlrggsrdgtohhm
    pdguohgtkhgvrhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ACaEZb5uySJpZ1mdZj9kS9cQ7YKdlBz7CFQ53XVOe56tqU-kXAlZCA>
    <xmx:ACaEZT6fruC7gZrUNzm4W3tkauhKJ8lxq21jgSebSL34NRmfYhs6TA>
    <xmx:ACaEZbgdep9kalbOe57qfYehBLyXPwm0tIfFNebhqeDv5JjoWXCzhQ>
    <xmx:ASaEZVmCc-DAHI2RBB2XOhyDTgo9UpLdt0Vbf2MvNq0oBr_xnHYeuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Dec 2023 06:48:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id adbd47b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Dec 2023 11:46:17 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:48:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com
Subject: Re: Git mirror at gitlab
Message-ID: <ZYQl_G-S4vQibHWn@framework>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JY1TtCptLhGAp/Vz"
Content-Disposition: inline
In-Reply-To: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>


--JY1TtCptLhGAp/Vz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
> Hey list,
>=20
> For years, I wanted (tried, but time) to run the mirror for git on gitlab.
> Actually, the original idea was to run a docker container ([0] 10k+ pulls
> :p)
>=20
> I initially set this up via docker build containers, where docker hub wou=
ld
> pull my mirror of the git repo. My mirror, because I added a Dockerfile
> which was enough for docker to do its trick. I was planning (time ..) on
> submitting this upstream to the list, but never did. Because of me not do=
ing
> that, I had to manually (I was even too lazy to script it) rebase the
> branch. Docker then did some changes to their business, where the docker
> builds where not possible anymore.
>=20
> So then I figured, I'll do the same on gitlab and push it to the docker h=
ub.
> Thus I setup a mirror on gitlab [1], with the idea to work there on it.
>=20
> Again, I never got around to finalize this work, mostly because the docker
> container 'just worked' for pretty much everything. After all, git is very
> stable overal.
>=20
> So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add support
> for GitLab CI") landed, which started to trigger pipeline jobs!
>=20
> Sadly, this only worked for 3 builds, as that's when the minutes ran out =
:)
>=20
> So one, I would very much like to offer the registered names (cause they =
are
> pretty nice in name) to here, so people can use and find it.

Not to throw a wrench into this, but are you aware of the official
GitLab mirror at https://gitlab.com/git-vcs/git? I myself wasn't aware
of this mirror for a rather long time.

I also wondered whether we want to have https://gitlab.com/git/git as we
do on GitHub. I don't think anybody registered it, but it is blocked
=66rom being registered as far as I can tell. Maybe we block the namespace
out of caution, I dunno. I can certainly check in with our SREs in case
it is something the Git project would like to own.

> Two, hopefully get Patrick Steinhardt to help out to get unlimited minutes
> and storage on the repo :)

I'm sure we can do something here, but I'd rather aim to do this for the
official mirror which currently is the one I mentioned above. If the
project is interested in running builds on GitLab then I'm happy to
coordinate.

Also Cc =C6var, who is the current owner of the mirror. Would it be
possible to add myself as a second owner to the project? This might help
setting up the CI infrastructure. But please, if anybody disagrees with
me being added as an owner here I encourage you to say so.

> Three, see what the opinion of people here is on this. I'll do the work to
> get the dockerfile (now containerfile, we're inclusive after all) merged,
> and the CI file updated to create, store (and push to docker hub) the
> generated containers.

I don't really have much of an opinion here and will leave it to others
to discuss.

Thanks!

Patrick

PS: As most other folks I'll be OOO during holidays, so I may only
    answer sporadically.

> Thanks,
> Olliver
>=20
> [0]: https://hub.docker.com/r/gitscm/git
> [1]: https://gitlab.com/gitscm/git
>=20
> P.S. I'm not subscribed, so please keep me in the CC :)

--JY1TtCptLhGAp/Vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWEJfwACgkQVbJhu7ck
PpRnlQ/8CK3kUSu9H2JxsvvCk6VWl4DTnTwlbM6rfbD2QBY6CxIZiY4bGDdNMsTC
vBhXaWdv1lY5cfiX7cXJs/ZHJiIkbIL1uILOiQXn84h6bLo1dU9z7tooXveIuaT4
KJioyUx0eEfbNlpE8WqbFJXNnKiDiJUync4t6OUiX9Ch3+FJx4xktS+7MeiDv+3O
vHDyF4KLSH6WNxeSHmJKiWqwHr5eArjZrlD6Rty7Hx4uSfWoN01Vz1qJoVI5S5rD
XJnqRv8c8m5nTNeAzIHU2+6NVJLA1TFji0GtHf0qk5IwJtBRSYoUFcBH+zdMsArK
IJT51HyDZZ1PJCqlZa4oqo6GYWdSEB1PKY7Rkdzo6SpJHgTcXpG9t8KCL90lYUYe
MPYiOd0IP22sz1LDt+fYczqw8Un9EejXEigJyRmmobTO/ojgMmFnDhx5g/9HozeW
mpj2YIagImLjitQg7B80PkbhSeVEOjWscr1AX+JGjd7OFzU2CNJhB25mgR8LAgll
8OmSlpI2s8px6/Wbm+nJqC0QfwA35Gy2BhBm9ZRY9lOajcaIFtD2Nf9Rwwes2y4z
Nhts1QnvQjm0U7OXCCBKCpj9r0dKQ+sxSVkxgecd5SfCorTRCWPKKr5xvXArAnv0
8ASeZXmHA9KyOutpltAm0XEKpuFL8WIG8ZYloOtRKA3oGeX+DhA=
=S1Yb
-----END PGP SIGNATURE-----

--JY1TtCptLhGAp/Vz--
