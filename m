Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C539FCB
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RttzkDXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnDPeiD7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id EF2B73200AD7;
	Wed, 10 Jan 2024 02:41:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jan 2024 02:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704872490; x=1704958890; bh=BPF1oTwWwX
	yWsthbBqPtCQcBeXuYQKrXhwMK0WzXbAI=; b=RttzkDXybjEr79Bn002HlWOPJd
	3VP4obReDigtbFP/e6nlL0tI9f9xeR/Lf1shWdy2639GljWEGOfDLBnouKzMzKiP
	RbDceAl/C0cvJUv9rvtiQiYI8nJ4eboYYR/1oMZU76Bsomg0Zps2uH3j+mPv/h3c
	eOAp76pCg1QsjXOyphdt2/kbJbjmJGprId6otidCpFLXYJM2jGXHBBLgBbwBsWpg
	0oBTTNN4n4aEv8qo+4h+Maw9daqloM6yPBVe4e2L+8MSu58fPaZs+crqqMX6cPxg
	kZt23c8B0hx3cGqwexP909zA2tweTRd1qlnF6eS7baFmTiO82yUZ+yyqy9AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704872490; x=1704958890; bh=BPF1oTwWwXyWsthbBqPtCQcBeXuY
	QKrXhwMK0WzXbAI=; b=KnDPeiD7Jext9yrYLMpWFuZm9KBjLCkDLhoO+AK6QLjf
	OZ0t5I8e1umosgK4ZO25bpp0B7g8MBW3Lw88x4oTqG20HEjeOvWDr3pfoZpXTnbD
	e1LNmVpumwfF8PpZUyildUC6unorGorAmID9qT3nSjJq2a4HcTgkmFbcErd6OrjK
	gSNW7ROkd2okG3u+F/9/El/EJbpJuceBbhf9PbRjiESWqMEzhmFugdbNk6TgeUBE
	ytj0BO9kOIKGuVEY50mo5okcO1CJ07VGDGHXEYiJMX2HdTP89Z1fe1YYV4KHLwx+
	IO0IWomWlRMhMGAyn9tHrFmM3zAD3+aROoGAKafvcg==
X-ME-Sender: <xms:KkqeZQKWjSnr8tPLscZ8LGmS3dOudvbCGPqmBZ9xm6CqT1NNSOkhYA>
    <xme:KkqeZQLH3DMNOrU2QAcEyDPW4z0jNzE-y8DU04H8AWIfcluhHXqYDtDcT7pXGxVRc
    1e-WOd4C1REVKxsuw>
X-ME-Received: <xmr:KkqeZQvgBJmJz0wfUGK6aUzIQWeMl0q_vhrJ_VBD_bTS-3-QNWUB_lN52IJniXRwHcP-tzpsLZDZddD6w4vDqmM68M29jwuVt5PcuvRenRceQP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KkqeZdayZOHgWBrCYZTfygvf9xB_wlB_OdC6UWC5fZTsxBldMCLRIQ>
    <xmx:KkqeZXYtGB4G0fuDewKGoVqQdMFxBVynZ6rpmc4kAV8J-rHybSqtkQ>
    <xmx:KkqeZZD70UasQEI-FjTLBkCWE6qM6M5G0dLElCRahFcXLBTiacgQFg>
    <xmx:KkqeZYDTqx9I63PmmONANF9jhZ0suJfd3m7ch6p_V3ueW1CvyPFGMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 02:41:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26461098 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 07:38:47 +0000 (UTC)
Date: Wed, 10 Jan 2024 08:41:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] t5526: break test submodule differently
Message-ID: <ZZ5KJX4tC0UIX00j@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <51e494a50e4416ed0cbfd3c474ffcaf8b72e6ef4.1704802213.git.ps@pks.im>
 <CAPig+cTB5OH1hCD-EagxNAcaw1=RR7yCeeZ_AzeqHtFTGxT-0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QFC/Kguiy/LxFeal"
Content-Disposition: inline
In-Reply-To: <CAPig+cTB5OH1hCD-EagxNAcaw1=RR7yCeeZ_AzeqHtFTGxT-0g@mail.gmail.com>


--QFC/Kguiy/LxFeal
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:23:55PM -0500, Eric Sunshine wrote:
> On Tue, Jan 9, 2024 at 7:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > In 10f5c52656 (submodule: avoid auto-discovery in
> > prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
> > recursive fetch with submodule in the case where the submodule is broken
> > due to whatever reason. The test to exercise that the fix works breaks
> > the submodule by deleting its `HEAD` reference, which will cause us to
> > not detect the directory as a Git repository.
> >
> > While this is perfectly fine in theory, this way of breaking the repo
> > becomes problematic with the current efforts to introduce another refdb
> > backend into Git. The new reftable backend has a stub HEAD file that
> > always contains "ref: refs/heads/.invalid" so that tools continue to be
> > able to detect such a repository. But as the reftable backend will never
> > delete this file even when asked to delete `HEAD` the current way to
> > delete the `HEAD` reference will stop working.
>=20
> This patch is not the appropriate place to bikeshed (but since this is
> the first time I've read or paid attention to it), if I saw "ref:
> refs/heads/.invalid", the word ".invalid" would make me think
> something was broken in my repository. Would it make sense to use some
> less alarming word, such as perhaps ".placeholder", ".stand-in",
> ".synthesized" or even the name of the non-file-based backend in use?

Well, something _is_ broken in your repository in case Git ever tries to
read the "HEAD" placeholder in a reftable-enabled repository. But I
guess you rather come from the angle of using `cat HEAD` as a user. I do
agree that using a better hint could help users, but this detail has
already been recorded as such in "Documentation/technical/reftable.txt".

We can of course change this to be "ref: refs/heads/.reftable", but as
you already say this is something that should be discussed in a separate
thread.

> > Adapt the code to instead delete the objects database. Going back with
> > this new way to cuase breakage confirms that it triggers the infinite
> > recursion just the same, and there are no equivalent ongoing efforts to
> > replace the object database with an alternate backend.
>=20
> s/cuase/cause/
>=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> > @@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a brok=
en repository' '
> >         # Break the receiving submodule
> > -       test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF ms=
g HEAD &&
> > +       rm -r dst/sub/.git/objects &&
>=20
> If there is no guarantee that .git/objects will exist when any
> particular backend is in use, would it be more robust to use -f here,
> as well?
>=20
>     rm -rf dst/sub/.git/objects &&

`.git/objects` always exists in a healthy repository. If it doesn't,
then `is_git_directory()` would return a false-ish value and we wouldn't
recognize the repository as such. Or are you saying that this could
potentially change in the future if there was ever to be an alternate
ODB format? If so that is a valid remark, but the test would break
regardless of whether we use `-f` or not: if a missing ".git/objects"
directory does not lead to a corrupted repository then the whole premise
of the test is broken.

Patrick

--QFC/Kguiy/LxFeal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeSiQACgkQVbJhu7ck
PpQs+w//RGPvSm+i78tg/Kci7DZgRgqneMyAmRCf6Rq/mIyaG4PxtCCKSRoXGI+M
5s0bES3ISquHXWv/RbvrJRhpZTJzUkOztStFymHor/HF3I2XWksfUSBnYblP0ZSH
zndAMqbmsNdeTZLxMsiCeE8tMCdIsL9RF4Afs8zvk10f/+EeukXjYDAmJubQ5x+b
A+rxjh9F3kBSExPUvS9jvG6/Z32HShB1Om+KEIEZm2u37Wkqpe9FKqltvwTR7D/U
9M6l3xaaJfTtdihwYASMAe8YWEZB7oZ4PAfEc6NlNMGs0Mc7I8aubUFdsgShVeTH
4FSMMpXS07t+a6aEyzKr2ITbm1JFuTDEwS9CnfgOybs0gaDC6eMLNjEerftoT/rO
jYPhE5BYCckCRyhiHX4dL8puWA+vv00WnUvY6P9S5lBK9Ih5qWG9SDJQio2IZ9Nx
7B+sWopfX3hiDIKpPHBt2AhkhuWNHOGDbr58qofcxWSYY/RO5LcOBT6t9k9KjjDE
KfGUDalwSpqN3OhRxnD2qq7mhIo775FhPvtmcivMpQDYMEDxCc6XPerpE3mAJ/Va
czxZkwU/13VPJeXL4xj9x7fvp0I2TaBoNphYIKZZL+ukivtI0NMiq5kTY85uTURo
1KergBHan9GPLUq+1X4D1Le4tUjT4q6Bq/bdy7s01678RYBxTsU=
=kcAl
-----END PGP SIGNATURE-----

--QFC/Kguiy/LxFeal--
