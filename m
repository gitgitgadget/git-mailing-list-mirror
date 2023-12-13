Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OwlqRqaD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCovFpNb"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B65C10F
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 23:28:51 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 59EC73200A2C;
	Wed, 13 Dec 2023 02:28:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 02:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702452529; x=1702538929; bh=ztioVCfcIv
	O/i+gfZROXIBAP0LNn4Z8GGcqzcquT0h8=; b=OwlqRqaDOKiVJhcqTCT+Vf2+b8
	cQAqzjMYEn2miXu3e+jjW20cLgB/PwaXkQKvc9oacnzoMIGFfViIqdCijr4ju9WU
	cYSbZYyX+zlUeH6XESU4YrWyxF8TL+Nh3WRIvUYVami1UIAEPMd/nSmfU+1A8uMt
	nzWpDI/6jnWfYQTp/8uRkMOzZ1KYvAHwkmHmTbqvFUcMA6TGz2ns/Z3RnP8uQPiE
	fZjf4jfj7vaEjCA76G3mx2OP1We4Vl4w/6+kkOcqhbekEpRaQYqOv6PfzMClTAf7
	8rBQ0ZL+XH5LoI0JAZl9qb64rkFcNSxqJ950Z2TVGD3yEqlVYnmyFQX68nww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702452529; x=1702538929; bh=ztioVCfcIvO/i+gfZROXIBAP0LNn
	4Z8GGcqzcquT0h8=; b=gCovFpNbT4b3TKH+hFgd3k/9X5/XXduTzrAW2HgYmfVp
	rCbXGmZNdwsftaYl2j+XEwR9X0W2JRbR0SBnAzUtS3wEK64qr2oeBalagrzB1WoK
	ieeZXMCqoV9P9AFaTVVxX3K9NjAmuLHhmMjzaJpRvqT/4aXEAMMmIDV25wSB5gOl
	N0cK/FTTRF8MeTvXB64dhTW0PTqiTNtSUDi6kwkqCbrgLcQ95xzBCacQQaR/p1z1
	t6PNsV/2a2GA0pgG8zyNFjPoioA2TnxFcqPKgQauVropjEH1s2waq9pnBM6r1yeW
	OxiOH+R8LyLwUfeI0s+xxaF9scWRofG6l/9/yER/mQ==
X-ME-Sender: <xms:MV15ZYdxPWdbaZi509USHwvLqY2jcJg5Iw_CRiBTAV41qvqXXKtDoA>
    <xme:MV15ZaO8kivQNkbYmXdqEdw7Z5zPqT3561QqjhWYq8LZ849fCC5NbsxkYLaHAl-FT
    2XBNcRHzW6G1GN7dw>
X-ME-Received: <xmr:MV15ZZgbmZpbBUL5mgvqoLoQm4kmQrwdUYbMScxwws4IYRihImQofmRT8ACMGHOwPjkLoF_vjcqqOoFfRx1GUuYR7CUtWjsU1qGokIeeYvh0Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:MV15Zd-7_uaclxhLP3ZfC7MTqhQWTfK6xvP1CCpg63azESOMPKJWJA>
    <xmx:MV15ZUscGAedq_93J6TUsG1oxPnUvTgJBoBAdoftH2Auh--gBqQ7nQ>
    <xmx:MV15ZUEKuk7FCCAJyzU2oF2nmLbxNjDImWZKE95EJj4os9NDLsKc2Q>
    <xmx:MV15Zd5HUExUn6r_LrhSHozto0Zh4NSb5He8ydONyNMexLoyMDlMjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 02:28:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 75d75e2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Dec 2023 07:27:06 +0000 (UTC)
Date: Wed, 13 Dec 2023 08:28:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/4] refs: propagate errno when reading special refs
 fails
Message-ID: <ZXldLTofO3tt5JWo@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
 <24032a62e54fb37dad46c3ede7151efc8a7a8818.1702365291.git.ps@pks.im>
 <xmqqfs07qi66.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h/le15IbdVB65P00"
Content-Disposition: inline
In-Reply-To: <xmqqfs07qi66.fsf@gitster.g>


--h/le15IbdVB65P00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:28:49PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Some refs in Git are more special than others due to reasons explained
> > in the next commit. These refs are read via `refs_read_special_head()`,
> > but this function doesn't behave the same as when we try to read a
> > normal ref. Most importantly, we do not propagate `failure_errno` in the
> > case where the reference does not exist, which is behaviour that we rely
> > on in many parts of Git.
> >
> > Fix this bug by propagating errno when `strbuf_read_file()` fails.
>=20
> Hmph, I thought, judging from what [1/4] did, that your plan was to
> use the refs API, instead of peeking directly into the filesystem,
> to access these pseudo refs, and am a bit puzzled if it makes all
> that much difference to fix errno handling while still reading
> directly from the filesystem.  Perhaps such a conversion happens in
> later steps of this series (or a follow on series after this series
> lands)?

Yes, that's ultimately the goal. The patch series here is only setting
the stage by recording what we have, and addressing cases where we are
inconsistently accessing refs via the filesystem _and_ via the ref API.
Once this lands I do want create a follow up patch series that converts
all refs to be non-special to the extent possible.

I say "to the extent possible" though because in the end there will be
two refs that we must continue to treat specially: FETCH_HEAD and
MERGE_HEAD, which we were treating special before this patch series
already. Both of these are not normal refs because they may contain
multiple values with annotations, so they will need to stay special.

Patrick

--h/le15IbdVB65P00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV5XSwACgkQVbJhu7ck
PpRSFw//fsizReFc7Ol3dELgBMArreUmrA1IgK7jib75MxwCBRlL+96f/ZqMyQPO
iqRUj8qWL4LaQOBNYx964qzU2D2HSP501lgXgXEiUo36lsTQPj68yuVGQpSaKDcC
mTtsq59oyjsrkgutMgfaRvDFDNtXuJ8GF5uqsT6GGFvVFdthcuVbu3CE0VmilD/c
qy1VXFVJCapL0/VU9+on6qL4NQcLrNTa0DG4c8m6qBPQ3+ZqMAF2WL4MJ7q5+fbw
AS2Raq+Bqao75mNiTxE/uI63WfYPvsq8khkVIM/NyfjWMOH0q9nnXdXiXURhPM79
D6KxZqEKwrsm7F1c2WVoUg/0pMn0VWS5e8GH00UxN/NH6OducVxpbkJLeg8ba1ob
uvFzm5pROi1UAJxsZVAGJtorV3XjYF2J+OH0IxB4yD14sRHDzmGMcNqoeOhW/KAN
5v9Nlladx5O7Bf4G4HvFFNX6ysCch2KoSPQgDkiKwSGpbBpUeDuULNJcMMaROFlG
7Q0FivoqbYu4oPU4NsgM0wvWQYTpUrDyAWjaei/2IT/gdQl4KSosk2CXBVbanpxY
xCzUrFdl11HSGDjGjH8zWeYNN0luEb6O31vgJsS84zumASdmISGxzAqlO9IEK7y+
yWfpkmorr3H/YqbNyRMQOd6R9y8gQhyTeuUp8FbDGlEX4fmj5I4=
=Mv+u
-----END PGP SIGNATURE-----

--h/le15IbdVB65P00--
