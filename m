Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lCJqYm1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAzwcaEM"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7610EB
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 05:13:27 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 567ED5C010E;
	Thu,  7 Dec 2023 08:13:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Dec 2023 08:13:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701954807; x=1702041207; bh=ki
	SJce3V9YLGIX7s13Oq4wPPBI8iyECMkxocTJPtYGU=; b=lCJqYm1nVhwgFBgotn
	L4nVEfZr2kBn+ueDSs4a1C4/1iS1y1iShIRQUZbMg+dMfOgK9JKUGl3B+vO13BAu
	4FSDcbVGhB8QVKq+M0Y8LhjGUPcVHjv3eR54QAuf6S/dZ8ApNTbeYKM9+OnaNvmK
	uwulO6f+QWnVuXv5WGQoDToTkT9U9571kqmCEhhfXHgx6XLhy4uGgOSdMeTeEPjk
	obKkqFv7ZXXUJKQ4dsXs44/m1ihJ1fPhLKl3VQ9/b3Bnycb4f93m3Mc96lNpQwlw
	zndWYCo3R7AxRN1Ms1TGMWdiM8YXPuV2a7Ikx1qqSAgz24nJ/18G9uMvC0uaCOU6
	7eFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701954807; x=1702041207; bh=kiSJce3V9YLGI
	X7s13Oq4wPPBI8iyECMkxocTJPtYGU=; b=SAzwcaEMzbwB3O0o1DPBdRp3XJZF1
	aPgNCz6zUJgKff6YC7y9oCd3jo2XcohFNo1BobO8y2+idbu1CkB9EMgnDA+8prRx
	imcUHZTVFtlXvN/LBGqlK/4CgTGM1I+0RjkXc5VPAzPVD1JzZZrUIkCPmTUqXRaL
	N8nrjWBJ9IAcmBk5Dxs6UQV5Wvvhc2LjPsXA0jMUueY5g0WAHpP0uIzhxnIMFRTx
	4HJjIRWtLy/MPufC5h7wjju/e5qUNkzcuIXEsKwjVa/DCnB1Jt8VOkzY0/0ZgrkS
	Ez16EzbzfC0dhbXeaQFxKGMZUGpfKftcVqVKW4Z2+Hg14qYBmkROR1pHw==
X-ME-Sender: <xms:98RxZe5ABtTg-eka_8B4XlJjj0luyLBm2jW634AaDeYF7j6cNqJDPQ>
    <xme:98RxZX6VXWyBGLQu53ECqBApx87xOTxKqefQGgrT_AqakLftO8x_eu86iBMuz9bdO
    RKIpV0x-BD4Qs38aQ>
X-ME-Received: <xmr:98RxZdcysENnBb8h-bCLesUE548yVdLNjJltCI4ttfbr0igYaNTM2mpI4vaCVwgRI3nPU9v7JAxDwb61iYC4Es2EUukQlA2RDUOfQ5MgNUH9Qvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:98RxZbI7yrQG6nJaS7NEgkDT02VPAUM8VYlP3Ffl2vtpM7J9NbT3TA>
    <xmx:98RxZSIbGUzcCPWiMUzdncHLiCwOBkQ-Xc0HlzO3hUPJ2sWyV0qWnw>
    <xmx:98RxZcy1T_VIhvjN-ftXrPf6wKYO5Dky2aeCuSxPm6zmXwk_4_yekQ>
    <xmx:98RxZZWqyy2k1noqJnjwYqbwWHTb4vIOEqG0vN0iDvTjP7G9eJzriQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 08:13:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49ea5e67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 13:11:58 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:13:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/24] pack-objects: keep track of `pack_start` for each
 reuse pack
Message-ID: <ZXHE9L7iqXQAit_1@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f4fba861b59f909148775ee64c3ba89afc872b5.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tjrvsalqpBhUH9Wy"
Content-Disposition: inline
In-Reply-To: <6f4fba861b59f909148775ee64c3ba89afc872b5.1701198172.git.me@ttaylorr.com>


--tjrvsalqpBhUH9Wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:32PM -0500, Taylor Blau wrote:
> When reusing objects from a pack, we keep track of a set of one or more
> `reused_chunk`s, corresponding to sections of one or more object(s) from
> a source pack that we are reusing. Each chunk contains two pieces of
> information:
>=20
>   - the offset of the first object in the source pack (relative to the
>     beginning of the source pack)
>   - the difference between that offset, and the corresponding offset in
>     the pack we're generating
>=20
> The purpose of keeping track of these is so that we can patch an
> OFS_DELTAs that cross over a section of the reuse pack that we didn't
> take.
>=20
> For instance, consider a hypothetical pack as shown below:
>=20
>                                                 (chunk #2)
>                                                 __________...
>                                                /
>                                               /
>       +--------+---------+-------------------+---------+
>   ... | <base> | <other> |      (unused)     | <delta> | ...
>       +--------+---------+-------------------+---------+
>        \                /
>         \______________/
>            (chunk #1)
>=20
> Suppose that we are sending objects "base", "other", and "delta", and
> that the "delta" object is stored as an OFS_DELTA, and that its base is
> "base". If we don't send any objects in the "(unused)" range, we can't
> copy the delta'd object directly, since its delta offset includes a
> range of the pack that we didn't copy, so we have to account for that
> difference when patching and reassembling the delta.
>=20
> In order to compute this value correctly, we need to know not only where
> we are in the packfile we're assembling (with `hashfile_total(f)`) but
> also the position of the first byte of the packfile that we are
> currently reusing.
>=20
> Together, these two allow us to compute the reused chunk's offset
> difference relative to the start of the reused pack, as desired.

Hm. I'm not quite sure I fully understand the motivation here. Is this
something that was broken all along? Why does it become a problem now?
Sorry if I'm missing the obvious here.

> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 7682bd65bb..eb8be514d1 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1016,6 +1016,7 @@ static off_t find_reused_offset(off_t where)
> =20
>  static void write_reused_pack_one(struct packed_git *reuse_packfile,
>  				  size_t pos, struct hashfile *out,
> +				  off_t pack_start,
>  				  struct pack_window **w_curs)
>  {
>  	off_t offset, next, cur;
> @@ -1025,7 +1026,8 @@ static void write_reused_pack_one(struct packed_git=
 *reuse_packfile,
>  	offset =3D pack_pos_to_offset(reuse_packfile, pos);
>  	next =3D pack_pos_to_offset(reuse_packfile, pos + 1);
> =20
> -	record_reused_object(offset, offset - hashfile_total(out));
> +	record_reused_object(offset,
> +			     offset - (hashfile_total(out) - pack_start));
> =20
>  	cur =3D offset;
>  	type =3D unpack_object_header(reuse_packfile, w_curs, &cur, &size);
> @@ -1095,6 +1097,7 @@ static void write_reused_pack_one(struct packed_git=
 *reuse_packfile,
> =20
>  static size_t write_reused_pack_verbatim(struct packed_git *reuse_packfi=
le,
>  					 struct hashfile *out,
> +					 off_t pack_start UNUSED,
>  					 struct pack_window **w_curs)
>  {
>  	size_t pos =3D 0;
> @@ -1126,10 +1129,12 @@ static void write_reused_pack(struct packed_git *=
reuse_packfile,
>  {
>  	size_t i =3D 0;
>  	uint32_t offset;
> +	off_t pack_start =3D hashfile_total(f) - sizeof(struct pack_header);

Given that this patch in its current state doesn't seem to do anything
yet, am I right in assuming that `hashfile_total(f) - sizeof(struct
pack_header)` is always expected to be zero for now?

Patrick

--tjrvsalqpBhUH9Wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxxPMACgkQVbJhu7ck
PpTSFw/9EX2HO3hAYawUYmZIcVkrnRh/zk9U0tuVvWXKlDg+vNyfjGPDlHNec0Vh
qbzdk4+eBnMhGJlzlz116Z6Glhiv6LB1fIz3tfgt98H5MVEfaYsW9byH1mDL0NKJ
EVc2IYM29EucFs6ovhAai2weTjxVOvghNqTyJGefqEA2L8UfGMtLbXlOIUxQoQzz
rSwTrO6x045aU2ehI/wybKxlVAU51oyxlo9Mh+3+Tip9MylyLpFCTSIk6dD9eDkV
ovJboBzrQB5uPRPLmwpiqerHZagQpp1hjPMqmDb6Igee9WRct2cmcxhhXsLx3wFv
QF+mXgteAvr1COITFUUdnWtFC2SNA2gcXa6XMShQ6umjPCSxHim7TLKmbL131MNv
kqVUhQHCwBt0sXaGBhjVViUuu+5vMMvxoCAYd8o6V00Mp+felK/DXT7QJGL7uTaG
znemjk1wU2Xm4el2GGXfFbpuaAQUp4uMTW+EK8+Vmj36lMwOHSOksOOaqth0h/0v
tx/KFo4FxhhXgnH7dCkBZeDnEeha+g2x7g2Po6D9vxh6TKSBEBR4sVwPTDrFxaSy
Tywt7LdkqZDqP5ntBfoec8rIatM86x1LemCQ80epyuL5OERoakcREeNz7oqcMKEP
X+aip8yodnJjIVMzek2YKWU3YgO2qJ/qEHMlsumDNbtJecmyHaA=
=NEmT
-----END PGP SIGNATURE-----

--tjrvsalqpBhUH9Wy--
