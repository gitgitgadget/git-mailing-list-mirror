Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5B1643A
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0DL+wxlA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvGyRRqs"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02C99
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:58:12 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 7C5C85C037D;
	Wed, 25 Oct 2023 03:58:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 25 Oct 2023 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698220691; x=1698307091; bh=de
	25r61mLX7e86za8pD3JXuB2CtpqzwG2tOvIrrjhlY=; b=0DL+wxlA2dufB9ASn4
	96tPQI/JuYZ4BVmX3lPolmOdapFns0rLlFxQtmmgDH1a5y5NGkme7jMO5x9e5phy
	LLXAusFrcsy7XYHt5zM2baalbQJCBkCRNZI+51gCFxs7CSwqNQ8o/U9IMRrro5fK
	dC4r7SIXWm8WftqmIcyyL6TPmLnoKSeSwEbfp44cwii5Q02w5WaXmSSosB6xlW0u
	AtC54amSE7f6O+T1TBLqKB9Ey7wM2lMNdZEE7+iU3hzT9KyQc47ls9mGwb8Y9G/j
	Oc/f6+5rkp7ncrWi+gO3LiNvUsjQAhqm05WG/hkMFMIZMks9Z+1sVtcEfJrxVQwW
	F+VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698220691; x=1698307091; bh=de25r61mLX7e8
	6za8pD3JXuB2CtpqzwG2tOvIrrjhlY=; b=dvGyRRqsC95VU/e4fQrdJdAaIm0mK
	hXlbjA2Qqph6Kx/p4i8pPrdCmpMIqZaKYAMUQ/VYiXOObvswOiYUGT5a0IdYfGVM
	G//zjW23tNnv1IPFhPNwv0gsFp7Ow6b0PwiCdbEbbDx7FlB4zFvMyt53TsCPvDHv
	kbKtmQKwlNeTvwvuBgQRx6NWScvRpCYIPTNfi7+phjXkOODxV5s7QhWfrl1fjy1h
	4TAC27cQv6785lFMtJ9dxmzmerg/1DMVvWRVkc9JgRbnRR4699utrvWx78OOl5cL
	fTxXp+SabtWEOHAYnXx7euK7gGMosM2+VaN4e0sKdIzBpdT998QV+x5qg==
X-ME-Sender: <xms:k8o4ZQ9lDmVd9hjSc9tlhv0-Fk5o3fdPqrMY6BIHS9V0kAj68BtPRA>
    <xme:k8o4ZYudtmneTVhjq4IYZQGiw1ksoa-taXGDN85drAZxjxYAgj6-3X_EseCT53vE4
    hbtXgh7H3LdUeGAnw>
X-ME-Received: <xmr:k8o4ZWBO0NEw-BE3guWPAWr2ucEbD6aI6W0XrmTqhWl2Zo-qcN5eX_vumeOiOISHFWGIFSCThcqsW5UViaCg5CImTs_KITdf97jV4o0nbprwoQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgfelfeffkeelkeejgfehgeeifeeugeehheetfefgffdthfelledvtefhgeetheff
    necuffhomhgrihhnpehinhgtohhrvgdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:k8o4ZQcLf0FIv90iBkQelqCA0wdBX5-wqyptK93q2qgP1prEQ4F1IA>
    <xmx:k8o4ZVPAt389-NTvtDwKM01bUXIuM0ClZ9AXKfO-hH4heJYasroG2A>
    <xmx:k8o4ZakRcj-I49bHNV6qFC0cGSBgQVOUxUpcJvo8Pb5La25d0vrhzg>
    <xmx:k8o4Zapvj2UAOOyHKsDrjBalLQE0120Tb7ccDmyrqUvUxxpzKg_NjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 03:58:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc426200 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 07:58:01 +0000 (UTC)
Date: Wed, 25 Oct 2023 09:58:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/5] bulk-checkin: introduce
 `index_blob_bulk_checkin_incore()`
Message-ID: <ZTjKjkRMkmCuxDU1@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ClwiNeYZNzERTiUE"
Content-Disposition: inline
In-Reply-To: <d8cf8e4395375f88fe4e1ade2b79a3be6ce5fb12.1698101088.git.me@ttaylorr.com>


--ClwiNeYZNzERTiUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:45:01PM -0400, Taylor Blau wrote:
> Introduce `index_blob_bulk_checkin_incore()` which allows streaming
> arbitrary blob contents from memory into the bulk-checkin pack.
>=20
> In order to support streaming from a location in memory, we must
> implement a new kind of bulk_checkin_source that does just that. These
> implementation in spread out across:

Nit: the commit message is a bit off here. Probably not worth a reroll
though.

>   - init_bulk_checkin_source_incore()
>   - bulk_checkin_source_read_incore()
>   - bulk_checkin_source_seek_incore()
>=20
> Note that, unlike file descriptors, which manage their own offset
> internally, we have to keep track of how many bytes we've read out of
> the buffer, and make sure we don't read past the end of the buffer.
>=20
> This will be useful in a couple of more commits in order to provide the
> `merge-tree` builtin with a mechanism to create a new pack containing
> any objects it created during the merge, instead of storing those
> objects individually as loose.
>=20
> Similar to the existing `index_blob_bulk_checkin()` function, the
> entrypoint delegates to `deflate_obj_to_pack_incore()`. That function in
> turn delegates to deflate_obj_to_pack(), which is responsible for
> formatting the pack header and then deflating the contents into the
> pack.
>=20
> Consistent with the rest of the bulk-checkin mechanism, there are no
> direct tests here. In future commits when we expose this new
> functionality via the `merge-tree` builtin, we will test it indirectly
> there.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  bulk-checkin.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  bulk-checkin.h |  4 +++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 79776e679e..b728210bc7 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -148,6 +148,10 @@ struct bulk_checkin_source {
>  		struct {
>  			int fd;
>  		} from_fd;
> +		struct {
> +			const void *buf;
> +			size_t nr_read;
> +		} incore;
>  	} data;
> =20
>  	size_t size;
> @@ -166,6 +170,36 @@ static off_t bulk_checkin_source_seek_from_fd(struct=
 bulk_checkin_source *source
>  	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
>  }
> =20
> +static off_t bulk_checkin_source_read_incore(struct bulk_checkin_source =
*source,
> +					     void *buf, size_t nr)
> +{
> +	const unsigned char *src =3D source->data.incore.buf;
> +
> +	if (source->data.incore.nr_read > source->size)
> +		BUG("read beyond bulk-checkin source buffer end "
> +		    "(%"PRIuMAX" > %"PRIuMAX")",
> +		    (uintmax_t)source->data.incore.nr_read,
> +		    (uintmax_t)source->size);
> +
> +	if (nr > source->size - source->data.incore.nr_read)
> +		nr =3D source->size - source->data.incore.nr_read;
> +
> +	src +=3D source->data.incore.nr_read;
> +
> +	memcpy(buf, src, nr);
> +	source->data.incore.nr_read +=3D nr;
> +	return nr;
> +}
> +
> +static off_t bulk_checkin_source_seek_incore(struct bulk_checkin_source =
*source,
> +					     off_t offset)
> +{
> +	if (!(0 <=3D offset && offset < source->size))
> +		return (off_t)-1;

At the risk of showing my own ignorance, but why is the cast here
necessary?

Patrick

> +	source->data.incore.nr_read =3D offset;
> +	return source->data.incore.nr_read;
> +}
> +
>  static void init_bulk_checkin_source_from_fd(struct bulk_checkin_source =
*source,
>  					     int fd, size_t size,
>  					     const char *path)
> @@ -181,6 +215,22 @@ static void init_bulk_checkin_source_from_fd(struct =
bulk_checkin_source *source,
>  	source->path =3D path;
>  }
> =20
> +static void init_bulk_checkin_source_incore(struct bulk_checkin_source *=
source,
> +					    const void *buf, size_t size,
> +					    const char *path)
> +{
> +	memset(source, 0, sizeof(struct bulk_checkin_source));
> +
> +	source->read =3D bulk_checkin_source_read_incore;
> +	source->seek =3D bulk_checkin_source_seek_incore;
> +
> +	source->data.incore.buf =3D buf;
> +	source->data.incore.nr_read =3D 0;
> +
> +	source->size =3D size;
> +	source->path =3D path;
> +}
> +
>  /*
>   * Read the contents from 'source' for 'size' bytes, streaming it to the
>   * packfile in state while updating the hash in ctx. Signal a failure
> @@ -359,6 +409,19 @@ static int deflate_obj_to_pack(struct bulk_checkin_p=
ackfile *state,
>  	return 0;
>  }
> =20
> +static int deflate_obj_to_pack_incore(struct bulk_checkin_packfile *stat=
e,
> +				       struct object_id *result_oid,
> +				       const void *buf, size_t size,
> +				       const char *path, enum object_type type,
> +				       unsigned flags)
> +{
> +	struct bulk_checkin_source source;
> +
> +	init_bulk_checkin_source_incore(&source, buf, size, path);
> +
> +	return deflate_obj_to_pack(state, result_oid, &source, type, 0, flags);
> +}
> +
>  static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>  				struct object_id *result_oid,
>  				int fd, size_t size,
> @@ -421,6 +484,18 @@ int index_blob_bulk_checkin(struct object_id *oid,
>  	return status;
>  }
> =20
> +int index_blob_bulk_checkin_incore(struct object_id *oid,
> +				   const void *buf, size_t size,
> +				   const char *path, unsigned flags)
> +{
> +	int status =3D deflate_obj_to_pack_incore(&bulk_checkin_packfile, oid,
> +						buf, size, path, OBJ_BLOB,
> +						flags);
> +	if (!odb_transaction_nesting)
> +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
> +	return status;
> +}
> +
>  void begin_odb_transaction(void)
>  {
>  	odb_transaction_nesting +=3D 1;
> diff --git a/bulk-checkin.h b/bulk-checkin.h
> index aa7286a7b3..1b91daeaee 100644
> --- a/bulk-checkin.h
> +++ b/bulk-checkin.h
> @@ -13,6 +13,10 @@ int index_blob_bulk_checkin(struct object_id *oid,
>  			    int fd, size_t size,
>  			    const char *path, unsigned flags);
> =20
> +int index_blob_bulk_checkin_incore(struct object_id *oid,
> +				   const void *buf, size_t size,
> +				   const char *path, unsigned flags);
> +
>  /*
>   * Tell the object database to optimize for adding
>   * multiple objects. end_odb_transaction must be called
> --=20
> 2.42.0.425.g963d08ddb3.dirty
>=20

--ClwiNeYZNzERTiUE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4yo0ACgkQVbJhu7ck
PpQsug//aq2oQ1hrHsem3pXnIKdHjeBE2d1TioER0PVWutOS42KI6te9RKLldHuh
g/ks3dOvAkdFJ7Ygf04QTL6Go6kzFfvO06X0D8uXvHl3EQViTJPGpXLOPeg0HWT5
G4s+ADpts4leFZ90rwUH1LIN+Uprp4P/PCc5BYOGHqyZD3/xC8eWwQZ3vo4TtqpY
tlR3CQVS81MSJnzqQYHZzdZgX2noB6cjEjr2UZQs17A5Ar6dYURtZNV2Okf39R1Q
Fwt/OzrsAS0Z6d2wTp7wxnzuM0X3M+A/B9b9P66vcfontHFdZrWCBMGRxbBYNwF0
EbsNEso7lx1DYP2fe2dxP3gLWc8HHqyQM8p5x8R/yARM68JovlSD4japeCKTOnhD
Dez0LGphqbwpaufU56n6lRmuKKA23reQ5MSILOiOi7X/snMzgmc5v5ryxXYUDHnT
EeTdNvTzYFdUggDYmkFObyzRFu90450/ILycvpKZwNpRaVLoBtMwtXVQVFv5QQIi
GqVLEA+dum4eU0q6UrdoLyKWyUykqg7E5Kr8aDDYIuLNr6jup/PfZmYmNKZmsRoC
tuOJYh2SX0PvFSVERYEGRlO5u/l4qowe7hyA7fHsMFMhkVDcDVsFvMhMpJ0RkHP4
lN7uBybVSFBUZbHJOvUD7a2WXbBT6lAOBkrlKBVqGUwG/641cn4=
=Bktk
-----END PGP SIGNATURE-----

--ClwiNeYZNzERTiUE--
