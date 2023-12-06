Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OWvXxQQ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xMiDc0aa"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89327AC
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 05:09:34 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id F19925C02A7
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 08:09:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Dec 2023 08:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701868173; x=1701954573; bh=fh
	zQs4a5Y9CTsNOta8ChI8MwJI87M2uToGZbka9aFgw=; b=OWvXxQQ2n0Yis0W3Xy
	cqZeXzJTZ0AF/H59sYyX3bA/G/rw5gObMpSiTFt7WT7krUp1mVi7Z1uKZO+xOFjc
	oTpYVGZX01FnilMrkcT0geAbdSmTBXXdxyFH8qKXL/IqTVaOOBd9yQFSzEKCpkvb
	kOVKOEiPKrLBsmPg/jvgjYf8KPSNT2/uge7MbGSF3qvL6oAtSpnD3jQHhTeenu+Z
	voEFudtc/3jqzp10/Fgl9bDQLJ5fh3iYMSATrp8xyauVzTItguNeqgZ2hasqOmWC
	i2gkcfNLtkwbDw/f8XaNTPOgU+k3hGb7D0JOr7MWI6s1fOmT/Br7w8acEjP9oi3p
	Zmkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701868173; x=1701954573; bh=fhzQs4a5Y9CTs
	NOta8ChI8MwJI87M2uToGZbka9aFgw=; b=xMiDc0aa+LRrEgK455vTffz9I2+HU
	AZA+xP9Wd+7NFbwV79eYcazb4xdHmz3L57QP91IjKFWjtmipZQt5lnBxBykGchk+
	/so6JbwEOAuHOmbcq4yWEyB3gf2eKUUh4keiPQsvF2FK9acGv4HdjvaM7E0X1ADw
	0ikgMUX2i3qwnBbV19PDjN6k1q+dAwvS3nUzMAHYlQVTJ7RKfPymZycwhRERYGaM
	A+csLfWy39vBKpYU1K0l4x97aLzJJEz3QS9p1cH7IFh5448rUnim8DrLKqlZDnDb
	2yL4fD+v0Tiokv/wGO950AJABZJstijx+5DHwooM6OfmFyVVEQt0kHZbA==
X-ME-Sender: <xms:jXJwZbQ3npXJxvSfT5MwciOC1sc6MgsSNDJJw9EKp8JBgC-hqk7OEQ>
    <xme:jXJwZcyLT5SoJZ5LQjyPEDGHdkIqH0kVUkvyPw6GmN8dODG_NGJqcEynzRhqZKlzD
    -1kjw3SuB4MddXhLg>
X-ME-Received: <xmr:jXJwZQ0m6FxjrSDTcoNMEVyi6l3Rs40jNzN79iQyMUxyxnak3Rtu4eDu6vr8KsIErqjR02tGDhuNDBc2YUjUxgkwyeDuEC9ENl3Sm7rO9w_HtG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjeejtdeigfegkefgjeehveevjeejveeuvd
    dtieekffevleeglefhgffgjeejfeefnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jXJwZbBN578dCR7STGQTzDw8uTvt71TfmfLFOA0gMQo_Ipj30AoCfA>
    <xmx:jXJwZUj4y_-z4blsu3JSrnEIqi57lI4opt_oC2xX7i6lWdQx_pnK0Q>
    <xmx:jXJwZfoCMP7cpKB6xNCLUG3-49phYxNNPbCVsApSjGGkVn6OwBNC2w>
    <xmx:jXJwZSfsVN7XDZTL68WJLczkfWf82cxrlyfOQwGB6f7AhSKriFGfGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 08:09:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 716f6330 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 13:08:05 +0000 (UTC)
Date: Wed, 6 Dec 2023 14:09:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
Message-ID: <ZXByiXj5rLUHgoAU@tanuki>
References: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RwRSSS3ZuEjtiW5l"
Content-Disposition: inline
In-Reply-To: <cover.1701863960.git.ps@pks.im>


--RwRSSS3ZuEjtiW5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 01:39:44PM +0100, Patrick Steinhardt wrote:
> Hi,
>=20
> when using git-clone(1), we initialize the complete repository before we
> know about the object format used by the remote repository. This means
> that we'll potentially create the refdb with the wrong object format in
> case the local default object format and remote object format are not
> the same.
>=20
> This isn't much of a problem in the context of the files backend, which
> never records the object format anyway. But it is a problem for the
> reftable backend, which indeed records the object format in the on-disk
> data structures. The result is thus a reftable with wrong object format.
>=20
> This patch series aims to solve this issue by initializing the refdb at
> a later point after we have learned about the remote object format. This
> requires some careful reordering of code. Unfortunately, the end result
> is not easily verifiable and thus I didn't add tests here. But it does
> fix cloning of SHA256 repositories with the in-progress state of the
> reftable backend.
>=20
> While at it I noticed that this actually fixes a bug with bundle URIs
> when the object formats diverge in this way.
>=20
> The series is layed out as follows:
>=20
>   - Patch 1 + 2: split out a function to create the refdb and make it
>     possible to skip its initialization in `init_db()`.
>=20
>   - Patch 3: allows git-remote-curl(1) to work with repos that get
>     initialized during its lifetime.
>=20
>   - Patch 4 - 6: address various corner cases where we access the refdb
>     before we learned about the object format.
>=20
>   - Patch 7: move initialization of the refdb to happen after we have
>     learned about the object format.
>=20
> This patch series is actually the last incompatibility for the reftable
> backend that I have found. All tests except for the files-backend
> specific ones pass now with the current state I have at [1], which is
> currently at e6f2f592b7 (t: skip tests which are incompatible with
> reftable, 2023-11-24)

I forgot to add the link to the merge request that contains the current
reftable backend's implementation in case anybody is interested:
https://gitlab.com/gitlab-org/git/-/merge_requests/58.

Patrick

> Thanks in advance for your reviews!
>=20
> Patrick
>=20
> Patrick Steinhardt (7):
>   setup: extract function to create the refdb
>   setup: allow skipping creation of the refdb
>   remote-curl: rediscover repository when fetching refs
>   builtin/clone: fix bundle URIs with mismatching object formats
>   builtin/clone: set up sparse checkout later
>   builtin/clone: skip reading HEAD when retrieving remote
>   builtin/clone: create the refdb with the correct object format
>=20
>  builtin/clone.c             |  65 ++++++++++++----------
>  remote-curl.c               |   7 ++-
>  remote.c                    |  26 +++++----
>  remote.h                    |   1 +
>  setup.c                     | 106 +++++++++++++++++++++---------------
>  setup.h                     |   6 +-
>  t/t5558-clone-bundle-uri.sh |  18 ++++++
>  7 files changed, 140 insertions(+), 89 deletions(-)
>=20
> --=20
> 2.43.0
>=20



--RwRSSS3ZuEjtiW5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwcokACgkQVbJhu7ck
PpS0Wg//bDsDpuEcrJUzYiqSTyhq6CtxkVSkFb0pdoXQmvCsuUBv2MAbKk4pQ4it
8sUruR21Xy44Xn0ptaiofEHpO9Z5nVQu+wEnnBvGIxjmPcdzcSV3q24qVR9qTJYj
QkheoopH5XXiuE+WKxFdGFC/SgwhpRfE/etKmXrWi5yc8iq2ZLHNAGP8Zzx1gK3J
KYYe3n7hrIDJ31z56fUMjENYUVltrwP6/V5842vGdT8MnNKgokiHbiir9v6TOkzn
8iKYSWRkPd+Y7guaLppuynIty2dbYT20EQj40kjTf8fASXxhI2GIbxssZkR4GWzX
ug/vtVwms4iD/LLDVmGx8r2TLaQaK7XjBllI41MqQoJ9Lx69lm1VKLgsbnMi339w
VJTDgYYw5azPjGAdC/ZaEL92mada8XwrF3M7967pNzfzRzarQ9y0Aj5ZWmJv8C6K
EYYQIZDWhkCTMkz6oMENGR8XoYc0PFpSI6vr7VCT3JROZZaYcy4pEpnHnGTM15Pn
QyfXLhVUyQkkzTC3q1YP4awfbx+aPxVG3asAXuulvvy4fF6mK882fdICHewfSR2q
20wmz6+s0sQK6obssCHhHMLz3XJw8ePo+YCFgJh5Zzj6xLkEofK+5FdsVHO0PYIu
MEs7bvbBn68nB2Z+eyU2klHMoOMZDwAgOqVcSXfjy9Efajc8i5o=
=NunX
-----END PGP SIGNATURE-----

--RwRSSS3ZuEjtiW5l--
