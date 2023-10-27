Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B8182A4
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SGKxfk1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVruZBq6"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982851A5
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:11:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 535E05C012F;
	Fri, 27 Oct 2023 07:11:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 07:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698405088; x=1698491488; bh=zD
	Bz9HT7fi1oaM4330JxFMg4Pk8cnJZpoWPPhyD9Kxs=; b=SGKxfk1UyJV39kHZc7
	KsqS9pImOu2cGMOPSdZPXs8LVMD83BMmf6YztiKcewYhpxnD8ue4kKPogt5d7D1a
	XaKOElWkwRz8GO3p1EdIPhPZ/ETVQjd72f22L9Kw34VM8rNh/pXchFdARzPsAhnM
	bJ2wzIf5xDt/d6NXqz94edud3PuRpN0/U6NuMlFa6giVOrgbtpcqdW1KXB58+ndp
	8Y8SGH/F6zzNdenZtBI4UMOTbI8iVfO3T4VtDXvCkKdWHR+E+blw4BYP+a7S8HzR
	6NvU/LJFVctal5YY5eUC0/1lbChThGOYPrzvgoi/gSVUO2AwuzKTXYTLrjgtFmmk
	EPWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698405088; x=1698491488; bh=zDBz9HT7fi1oa
	M4330JxFMg4Pk8cnJZpoWPPhyD9Kxs=; b=FVruZBq694jX++m6zvnBSUDGv9TCu
	T1eu2DyM+awCNlO60qFZ1+kddTNgjaFo/yfP+/Y4oJ4EitKhrsWKFva7XJs1OjKp
	CiM9td3ye1k6NgjnE2AEkuD/zupHWgj7EQ1fCyT1niTKSQF2DwkiAgX8seww+N1s
	Lnj7plDgqhurrMw1u9HtTJ7TgZABF5nkRSSuqKbyy6dacdizPYqlF8fij8x8QY3m
	PM4wUgYqaXqkn1uFToGPlzprafdyX/rR0YBZhrN6vq4vvmea6tsgiaRelhOJedkL
	1SLYB+Lsxy+fHIyFK2Kvk/4JlUI0owNccM15CMWt8lZhtDIjhcm3s7Jog==
X-ME-Sender: <xms:4Jo7ZYldqAS5Um3Pif67jGAPmUSdnpkFrjWSlWjsIkiAPMMY4YOK3w>
    <xme:4Jo7ZX0F-4_IsjdjytVdZ-QxT3ZD8ezNiIRdmOA9YWpWiPCCxdr1wHf8KBbXoKstk
    xYfQw3iN8Z46dvxAQ>
X-ME-Received: <xmr:4Jo7ZWr8a0EGIaQ0jfxhGcjGw9oI6LVQnSiPzZIqdIa6unl5zBSO-6cZZhSGgbnOLQNPX8whWS_37UovoqFw6D5ClcUPQIwciXuiu05oUQQxGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:4Jo7ZUkhXcLJbIgXYd3mTlM5vl9bVKTvVz3hMSc4vzjsLhvpj6dUww>
    <xmx:4Jo7ZW2GHqfZHBvChp7jqBxBBd2c6V5nMpk3izvt5LhHZXK7idDAWA>
    <xmx:4Jo7ZbvGJ4ghNyRO1FQ2UqiKt6rvZPhVSwCdPsZ3kAFaRZGik1k6xg>
    <xmx:4Jo7Zb98UPr079KgxkN9ZbsomEkE78gmUZ-aFsqNYQEI3BA6zkJ9mQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 07:11:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f23a668 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 11:11:14 +0000 (UTC)
Date: Fri, 27 Oct 2023 13:11:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] ci: add support for GitLab CI
Message-ID: <ZTua26fWLxvUbQ4X@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <35b07e5378d960b93ae8990a3abb525e1762d97d.1698305961.git.ps@pks.im>
 <ZTosPCkpx/FMTDH5@ugly>
 <ZTtyHScKkMg4qnMH@tanuki>
 <ZTuVr54KxhdaIf+F@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r9/pvPK2Bwou5kS8"
Content-Disposition: inline
In-Reply-To: <ZTuVr54KxhdaIf+F@ugly>


--r9/pvPK2Bwou5kS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 12:49:19PM +0200, Oswald Buddenhagen wrote:
> On Fri, Oct 27, 2023 at 10:17:33AM +0200, Patrick Steinhardt wrote:
> > On Thu, Oct 26, 2023 at 11:07:08AM +0200, Oswald Buddenhagen wrote:
> > > you should probably choose a less generic name for the jobs, at least
> > > debian-*.
> >=20
> > The names are all preexisting, so I cannot change them.
> >=20
> aren't they coming from the yml file? would adjusting them in the company
> setup be an unreasonable effort?

They come from the ".gitlab-ci.yml" file, but I have to reuse the exact
names that GitHub Actions already uses or otherwise we're not testing
for the same thing. The preexisting CI scripts for Git expect exactly
those names.

I do agree that they may benefit from a redesign so that they're more
explicit. But I don't think this patch series here is where we should do
that refactoring.

> > I don't quite know what you mean by counter-intuitive patch structure.
> >=20
> it looked like you're adding the function to the github branch, not to the
> freshly added gitlab branch. of course that's just a diffing artifact.

Ah, thought you meant the larger "structure of how things were layed
out". Agreed and fixed in v2 of the patch series.

Patrick

--r9/pvPK2Bwou5kS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7mtoACgkQVbJhu7ck
PpSNLRAAoimgkPVNDrbJ2FiCESZSsB9abGV4YO0jv+iVH3kAWjejAj+LlHsjHVL5
Q9hpyqf36+muHUjB3fX0tK91W9Y7eIYTxQEK5qUXirGfAXCjQ6TYjIygzgp/cfT3
kXn5B5Lo36Uk2hwwaEL4AoLoglJB+Xv4qFP1KI/guhRUplQbS60jsdcEQ52zgkAv
2g6mWRfl6VcSBCrAsgd0HZHt8BzV+BCvkJYDIHmH87SVmqEsTAbp+6orZCi4X9Do
h4iVr24/tOXGT3JldPz+5p8Pljv4RTKmAZiT0jr1jA7VZME0fYU4K9awmdnb6wqd
rO4p6v7SdJKo359PY3lspun6lF6s9o/wByBOicOvr9U+gfWsUkavTtM43VmsZGVN
PVDuZYHqAjA1iZtKWZfYJe++KKCGGodqgyYrNAySdlL6tloCdxJXc2okCuiQHsq4
kkCuCL25RT/r0odZ0ouawDu8qugSokob2Mz9Pdxa8sRS7JUbIJxbS1vjvHQuro1Y
koVal9Mg7COSLrXnI9ZDG3HgK2g+nEE/Zp0sIHaR8VaeUPZtL6/bNX06NypAB1YK
NQc5hrEFwGwC3+qwx9WxuJO5pnmk70rvKllidUYn81T8C3r/kV3TXoDiL6XpjsJg
yS9ZpVu6+PWw698GGrzuZgQy6ElT5icp/8vQ3dX6vadWTT5/eB4=
=X2S1
-----END PGP SIGNATURE-----

--r9/pvPK2Bwou5kS8--
