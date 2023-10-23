Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4F12E43
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gr5KTAUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZHA0Eq4G"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFE97
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:19:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C1F56320099A;
	Mon, 23 Oct 2023 05:19:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 23 Oct 2023 05:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698052763; x=1698139163; bh=+Y
	GxbxipsowFwwr/Rc3Xe/ZWI2IgNS8/nb1JotX3R6Y=; b=gr5KTAUONPAGCmgGBM
	QlkTkyNkJsBW+pIMHLU9BxFBk75vVVFblU0uIIBEvaADmNZYnMuUoBK76Y+ubsx7
	kC93EUDJNMbSR8QIDA8Pt8O+3BI0z6hFN7I39viwvRki3q1MFf1Q7ZovYt2NoR+g
	yRD/Y6xaElrunqvbIWpGeyoetC2xZV+qPzVNgPFkZSIh+NV1LeHWreWKHXI/SsMi
	I3225pcTQKOTkB92ZIiWyIYFk64a9HyJVvGVqDImAwtM0IDQ6svSxe2UeVsKjmdZ
	u8yueeaXJwbH94GpJ3uk25Ur3dQB7tQzUSEmo1jAZhtuCIN0GoyP06/JwwLoYT/7
	dHFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698052763; x=1698139163; bh=+YGxbxipsowFw
	wr/Rc3Xe/ZWI2IgNS8/nb1JotX3R6Y=; b=ZHA0Eq4Gn50q/nzjp3TgVQZC2vDb+
	DvwjwQfLTlube06+zXEhrYufLJgOr3mQ+36k7f4+6TNl0zqS/nMc+MB68lwPd3iF
	LON3TQnma0mN4Swr0HXmZRPmKjYh8SIaXWHBF88eFYFxLTUrvGv2u5r3nonwxX+e
	Gn3uzPbZQobBvQNsMVn3xtna0Vi3VXpxWP/HGzDVtK4gtoBEuWo3i0y22/qxjKZd
	j8HsKf6+daxf48r4mzdEiyTq9e54mLotaMeBmvfzGdBqEtPyiXkjKRkJuOCmEgYo
	Cth4dlE5blzhQHoUYV+FlkXXf/lnz+VbZJEwhDcvdJ3b5cOgyIoTmixcA==
X-ME-Sender: <xms:mzo2ZTQxwdSNm7n9SPq9XZN56RCsyjhOPlgTz3OVBlBT7VpSNE1wKQ>
    <xme:mzo2ZUzHXOQbmy3pbE6DjmM4KTvNoklTihMK7yRh9G758xDczQ5-PhPOZlfvvwkDX
    elowTdwlrBDkccitA>
X-ME-Received: <xmr:mzo2ZY17_y-vIunHOFYRAmjEPMadSn6ogMVOUxgh3mTfisdWYrx4YGzlxvfc8u9oc0pRh62c7N_3UULF0Uff6usEckFbzQi7B-b0LqWU-i3O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mzo2ZTC1p2k6KMWZrySZAYPIZFO7xvLGqLgFsOuvJSkI0fkBtlGa4g>
    <xmx:mzo2ZcgJtY3keMV_MpZbeJAm8r0RP2EsQ4ReoTOueCDCubDH5c-0lw>
    <xmx:mzo2ZXp2JfKFrLqgnnZcX1KXKanAtfVhJOQ7KxtXvrAL1jTWqrK-Bg>
    <xmx:mzo2ZUelI3tfVaE_0kz87lONjkVt3Hvf213DRMOdreRwSQTM-OESlQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 05:19:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f8853de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 09:19:19 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:19:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] merge-ort: implement support for packing objects
 together
Message-ID: <ZTY6lwtMgtRwmMrB@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S6W0PQVJlj65rXGn"
Content-Disposition: inline
In-Reply-To: <cover.1697736516.git.me@ttaylorr.com>


--S6W0PQVJlj65rXGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 01:28:38PM -0400, Taylor Blau wrote:
> (Rebased onto the current tip of 'master', which is 813d9a9188 (The
> nineteenth batch, 2023-10-18) at the time of writing).
>=20
> This series implements support for a new merge-tree option,
> `--write-pack`, which causes any newly-written objects to be packed
> together instead of being stored individually as loose.
>=20
> I intentionally broke this off from the existing thread, since I
> accidentally rerolled mine and Jonathan Tan's Bloom v2 series into it,
> causing some confusion.
>=20
> This is a new round that is significantly simplified thanks to
> another very helpful suggestion[1] from Junio. By factoring out a common
> "deflate object to pack" that takes an abstract bulk_checkin_source as a
> parameter, all of the earlier refactorings can be dropped since we
> retain only a single caller instead of multiple.
>=20
> This resulted in a rather satisfying range-diff (included below, as
> usual), and a similarly satisfying inter-diff:
>=20
>     $ git diff --stat tb/ort-bulk-checkin.v3..
>      bulk-checkin.c | 203 ++++++++++++++++-------------------------------=
--
>      1 file changed, 64 insertions(+), 139 deletions(-)
>=20
> Beyond that, the changes since last time can be viewed in the range-diff
> below. Thanks in advance for any review!
>=20
> [1]: https://lore.kernel.org/git/xmqq34y7plj4.fsf@gitster.g/

A single question regarding an `assert()` from my side. Other than that
the series looks good to me, thanks.

Patrick

> Taylor Blau (7):
>   bulk-checkin: extract abstract `bulk_checkin_source`
>   bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
>   bulk-checkin: refactor deflate routine to accept a
>     `bulk_checkin_source`
>   bulk-checkin: implement `SOURCE_INCORE` mode for `bulk_checkin_source`
>   bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
>   bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
>   builtin/merge-tree.c: implement support for `--write-pack`
>=20
>  Documentation/git-merge-tree.txt |   4 +
>  builtin/merge-tree.c             |   5 +
>  bulk-checkin.c                   | 161 ++++++++++++++++++++++++++-----
>  bulk-checkin.h                   |   8 ++
>  merge-ort.c                      |  42 ++++++--
>  merge-recursive.h                |   1 +
>  t/t4301-merge-tree-write-tree.sh |  93 ++++++++++++++++++
>  7 files changed, 280 insertions(+), 34 deletions(-)
>=20
> Range-diff against v3:
>  1:  2dffa45183 <  -:  ---------- bulk-checkin: factor out `format_object=
_header_hash()`
>  2:  7a10dc794a <  -:  ---------- bulk-checkin: factor out `prepare_check=
point()`
>  3:  20c32d2178 <  -:  ---------- bulk-checkin: factor out `truncate_chec=
kpoint()`
>  4:  893051d0b7 <  -:  ---------- bulk-checkin: factor out `finalize_chec=
kpoint()`
>  5:  da52ec8380 !  1:  97bb6e9f59 bulk-checkin: extract abstract `bulk_ch=
eckin_source`
>     @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin=
_packfile *sta
>       			if (*already_hashed_to < offset) {
>       				size_t hsize =3D offset - *already_hashed_to;
>      @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_check=
in_packfile *state,
>     - 	git_hash_ctx ctx;
>     + 	unsigned header_len;
>       	struct hashfile_checkpoint checkpoint =3D {0};
>       	struct pack_idx_entry *idx =3D NULL;
>      +	struct bulk_checkin_source source =3D {
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>       	seekback =3D lseek(fd, 0, SEEK_CUR);
>       	if (seekback =3D=3D (off_t) -1)
>      @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_check=
in_packfile *state,
>     - 	while (1) {
>     - 		prepare_checkpoint(state, &checkpoint, idx, flags);
>     + 			crc32_begin(state->f);
>     + 		}
>       		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
>      -					 fd, size, path, flags))
>      +					 &source, flags))
>       			break;
>     - 		truncate_checkpoint(state, &checkpoint, idx);
>     + 		/*
>     + 		 * Writing this object to the current pack will make
>     +@@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_check=
in_packfile *state,
>     + 		hashfile_truncate(state->f, &checkpoint);
>     + 		state->offset =3D checkpoint.offset;
>     + 		flush_bulk_checkin_packfile(state);
>      -		if (lseek(fd, seekback, SEEK_SET) =3D=3D (off_t) -1)
>      +		if (bulk_checkin_source_seek_to(&source, seekback) =3D=3D (off_t)=
-1)
>       			return error("cannot seek back");
>       	}
>     - 	finalize_checkpoint(state, &ctx, &checkpoint, idx, result_oid);
>     + 	the_hash_algo->final_oid_fn(result_oid, &ctx);
>  7:  04ec74e357 !  2:  9d633df339 bulk-checkin: generify `stream_blob_to_=
pack()` for arbitrary types
>     @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin=
_packfile *sta
>       	s.avail_out =3D sizeof(obuf) - hdrlen;
>      =20
>      @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_check=
in_packfile *state,
>     -=20
>     - 	while (1) {
>     - 		prepare_checkpoint(state, &checkpoint, idx, flags);
>     + 			idx->offset =3D state->offset;
>     + 			crc32_begin(state->f);
>     + 		}
>      -		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
>      -					 &source, flags))
>      +		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
>      +					&source, OBJ_BLOB, flags))
>       			break;
>     - 		truncate_checkpoint(state, &checkpoint, idx);
>     - 		if (bulk_checkin_source_seek_to(&source, seekback) =3D=3D (off_t)=
-1)
>     + 		/*
>     + 		 * Writing this object to the current pack will make
>  -:  ---------- >  3:  d5bbd7810e bulk-checkin: refactor deflate routine =
to accept a `bulk_checkin_source`
>  6:  4e9bac5bc1 =3D  4:  e427fe6ad3 bulk-checkin: implement `SOURCE_INCOR=
E` mode for `bulk_checkin_source`
>  8:  8667b76365 !  5:  48095afe80 bulk-checkin: introduce `index_blob_bul=
k_checkin_incore()`
>     @@ Commit message
>          objects individually as loose.
>     =20
>          Similar to the existing `index_blob_bulk_checkin()` function, the
>     -    entrypoint delegates to `deflate_blob_to_pack_incore()`, which is
>     -    responsible for formatting the pack header and then deflating the
>     -    contents into the pack. The latter is accomplished by calling
>     -    deflate_obj_contents_to_pack_incore(), which takes advantage of =
the
>     -    earlier refactorings and is responsible for writing the object t=
o the
>     -    pack and handling any overage from pack.packSizeLimit.
>     -
>     -    The bulk of the new functionality is implemented in the function
>     -    `stream_obj_to_pack()`, which can handle streaming objects from =
memory
>     -    to the bulk-checkin pack as a result of the earlier refactoring.
>     +    entrypoint delegates to `deflate_obj_to_pack_incore()`. That fun=
ction in
>     +    turn delegates to deflate_obj_to_pack(), which is responsible for
>     +    formatting the pack header and then deflating the contents into =
the
>     +    pack.
>     =20
>          Consistent with the rest of the bulk-checkin mechanism, there ar=
e no
>          direct tests here. In future commits when we expose this new
>     @@ Commit message
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bulk-checkin.c ##
>     -@@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_check=
in_packfile *state,
>     - 	}
>     +@@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checki=
n_packfile *state,
>     + 	return 0;
>       }
>      =20
>     -+static int deflate_obj_contents_to_pack_incore(struct bulk_checkin_=
packfile *state,
>     -+					       git_hash_ctx *ctx,
>     -+					       struct hashfile_checkpoint *checkpoint,
>     -+					       struct object_id *result_oid,
>     -+					       const void *buf, size_t size,
>     -+					       enum object_type type,
>     -+					       const char *path, unsigned flags)
>     ++static int deflate_obj_to_pack_incore(struct bulk_checkin_packfile =
*state,
>     ++				       struct object_id *result_oid,
>     ++				       const void *buf, size_t size,
>     ++				       const char *path, enum object_type type,
>     ++				       unsigned flags)
>      +{
>     -+	struct pack_idx_entry *idx =3D NULL;
>     -+	off_t already_hashed_to =3D 0;
>      +	struct bulk_checkin_source source =3D {
>      +		.type =3D SOURCE_INCORE,
>      +		.buf =3D buf,
>     @@ bulk-checkin.c: static void finalize_checkpoint(struct bulk_checki=
n_packfile *st
>      +		.path =3D path,
>      +	};
>      +
>     -+	/* Note: idx is non-NULL when we are writing */
>     -+	if (flags & HASH_WRITE_OBJECT)
>     -+		CALLOC_ARRAY(idx, 1);
>     -+
>     -+	while (1) {
>     -+		prepare_checkpoint(state, checkpoint, idx, flags);
>     -+
>     -+		if (!stream_obj_to_pack(state, ctx, &already_hashed_to, &source,
>     -+					type, flags))
>     -+			break;
>     -+		truncate_checkpoint(state, checkpoint, idx);
>     -+		bulk_checkin_source_seek_to(&source, 0);
>     -+	}
>     -+
>     -+	finalize_checkpoint(state, ctx, checkpoint, idx, result_oid);
>     -+
>     -+	return 0;
>     -+}
>     -+
>     -+static int deflate_blob_to_pack_incore(struct bulk_checkin_packfile=
 *state,
>     -+				       struct object_id *result_oid,
>     -+				       const void *buf, size_t size,
>     -+				       const char *path, unsigned flags)
>     -+{
>     -+	git_hash_ctx ctx;
>     -+	struct hashfile_checkpoint checkpoint =3D {0};
>     -+
>     -+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_BL=
OB,
>     -+				  size);
>     -+
>     -+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoin=
t,
>     -+						   result_oid, buf, size,
>     -+						   OBJ_BLOB, path, flags);
>     ++	return deflate_obj_to_pack(state, result_oid, &source, type, 0, fl=
ags);
>      +}
>      +
>       static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>     @@ bulk-checkin.c: int index_blob_bulk_checkin(struct object_id *oid,
>      +				   const void *buf, size_t size,
>      +				   const char *path, unsigned flags)
>      +{
>     -+	int status =3D deflate_blob_to_pack_incore(&bulk_checkin_packfile,=
 oid,
>     -+						 buf, size, path, flags);
>     ++	int status =3D deflate_obj_to_pack_incore(&bulk_checkin_packfile, =
oid,
>     ++						buf, size, path, OBJ_BLOB,
>     ++						flags);
>      +	if (!odb_transaction_nesting)
>      +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
>      +	return status;
>  9:  cba043ef14 !  6:  60568f9281 bulk-checkin: introduce `index_tree_bul=
k_checkin_incore()`
>     @@ Commit message
>          machinery will have enough to keep track of the converted object=
's hash
>          in order to update the compatibility mapping.
>     =20
>     -    Within `deflate_tree_to_pack_incore()`, the changes should be li=
mited
>     -    to something like:
>     +    Within some thin wrapper around `deflate_obj_to_pack_incore()` (=
perhaps
>     +    `deflate_tree_to_pack_incore()`), the changes should be limited =
to
>     +    something like:
>     =20
>              struct strbuf converted =3D STRBUF_INIT;
>              if (the_repository->compat_hash_algo) {
>     @@ Commit message
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bulk-checkin.c ##
>     -@@ bulk-checkin.c: static int deflate_blob_to_pack_incore(struct bul=
k_checkin_packfile *state,
>     - 						   OBJ_BLOB, path, flags);
>     - }
>     -=20
>     -+static int deflate_tree_to_pack_incore(struct bulk_checkin_packfile=
 *state,
>     -+				       struct object_id *result_oid,
>     -+				       const void *buf, size_t size,
>     -+				       const char *path, unsigned flags)
>     -+{
>     -+	git_hash_ctx ctx;
>     -+	struct hashfile_checkpoint checkpoint =3D {0};
>     -+
>     -+	format_object_header_hash(the_hash_algo, &ctx, &checkpoint, OBJ_TR=
EE,
>     -+				  size);
>     -+
>     -+	return deflate_obj_contents_to_pack_incore(state, &ctx, &checkpoin=
t,
>     -+						   result_oid, buf, size,
>     -+						   OBJ_TREE, path, flags);
>     -+}
>     -+
>     - static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
>     - 				struct object_id *result_oid,
>     - 				int fd, size_t size,
>      @@ bulk-checkin.c: int index_blob_bulk_checkin_incore(struct object_=
id *oid,
>       	return status;
>       }
>     @@ bulk-checkin.c: int index_blob_bulk_checkin_incore(struct object_i=
d *oid,
>      +				   const void *buf, size_t size,
>      +				   const char *path, unsigned flags)
>      +{
>     -+	int status =3D deflate_tree_to_pack_incore(&bulk_checkin_packfile,=
 oid,
>     -+						 buf, size, path, flags);
>     ++	int status =3D deflate_obj_to_pack_incore(&bulk_checkin_packfile, =
oid,
>     ++						buf, size, path, OBJ_TREE,
>     ++						flags);
>      +	if (!odb_transaction_nesting)
>      +		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
>      +	return status;
> 10:  ae70508037 =3D  7:  b9be9df122 builtin/merge-tree.c: implement suppo=
rt for `--write-pack`
> --=20
> 2.42.0.405.g86fe3250c2

--S6W0PQVJlj65rXGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2OpcACgkQVbJhu7ck
PpT/Yw/+KfpIx6FS6ytWKMKAo9Ly6XGFa9F1k12B05Fc26o+gLk2BvzWB+BorS5+
aZ/Qj07fQaD5YKjKJBKfPQazqmy1bVfoa3cwpuyu/Wae9dqFrfHdQTprrVpF+vRz
0fgKkUL2vhlAk++qzTd49vuR/g1O3pTwfpwE3zWEuC3gWihtQyQGJINsekUMyXFY
PwE2GRBhKsJ4v9zDOo9dSSvdmSl3RRDkRSVQOzzlKIYns4u9wvlztyvxBAgZ6XaK
qM6z+HwDQjKSYWPaaVkG7kJPuR+8WsC1qe7S00aTuLw5q1Q3O0eUBaE/NpuW7jjw
a5IR0i0Ot46lYzLHUDLtIcNTYexKMYiE+5c4sSVOtyCvLDKZCroJg9XBvygNrtmu
APDgmoNAP4Q17nbGZIDgqLfItU6o3G9ZT0B9R8w9eVrEVOGUEg8YRHRaW3HpAC7W
45d47PCNO0zrufZhaMSFFxXjUjllx50+4M7tDxHvnoOQr2ppQPkdi4m7Zoihl4ee
h6SfpqWWNCknscmpUacRx1XSUAyp+UWGY1zKkcokzsxAER6Tx+gAOHUROn8UzDbb
qaMJWF5/T4miQasx/yQqR6oVBm66XRIFqWwKWIVMQYpgLEb/MQOAyYTU/ZU1GSSp
NcQp39CyhuRFEk39jAbIA8gcw6dnX3MapH3O0O0al+4XpTFueIw=
=quYa
-----END PGP SIGNATURE-----

--S6W0PQVJlj65rXGn--
