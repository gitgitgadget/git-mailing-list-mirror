Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138791C2B5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MrduXsV5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pfv5pDiW"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B7799
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:58:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 5982F5C031A;
	Wed, 25 Oct 2023 03:58:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Oct 2023 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698220700; x=1698307100; bh=Sk
	CiqyUHpljsOhp1Q84lwi5uAg/uErEhO0yG5yxcW0s=; b=MrduXsV56u0VuZqBsW
	0Eh+hG4vow4nkrULRTprhOQ5yN/AtACwL6RuXfJvUGxNh7alXsa2ifPqDN9USq5L
	ft9LCaDIe+WgxJnZbweddiPjq3xQaee1p31XNmsuCZEiYEy3DNJFZNyvXXRD/Kjh
	Nn4K7lMkUJl7Ktx1U8SNh07PvM8IIgYIkD1Cenk+iao3akYSj/+65o8vfkRYP//F
	imC+cfHZe6bc4PLndIYKX8e+fNJ6hzAotxfzHqpoRvT8zoky8aMBp8mE0bSqXKm/
	biLyXKGaOrExxIql9xtQ2PojjM4ymzHI4Hi8d5MNUFNtl0CBoRpNdejhyKuJH0Tj
	gYcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698220700; x=1698307100; bh=SkCiqyUHpljsO
	hp1Q84lwi5uAg/uErEhO0yG5yxcW0s=; b=pfv5pDiW4g5V7nZODdeXZNcXnjBsg
	QOUoQ8Mm261WfBcGUqTn8XdXfHNjGqmM+K+Yn2e3rRjTGucTXW5uVYc/UkjIkS0F
	/c337kKPaCegfPVv53mqJnjYC6peKRemfTVVr3XfbK5wmmvBozI0A/FqDHAclqh8
	CPLOKxlkG4xKZQtVIpl3wTrZx7DaMI3OLl7pLlHbMiXWSwdhE9AMdyPYiDSk6HW2
	u3SC66IC1+YpBeYbaVWSjMpFEElWJ5swxtkO+RdSpX9cnyk0AsK6A2yN5QWPI+LP
	Hirq4IOP/spJe2ymkd9p2jR9wEjNdEAdDubl7xs1aEowvUKwR9VHVVffA==
X-ME-Sender: <xms:nMo4Zdjb2QAskmKDxgbViQjlIXSGX2twV-xuXUGSd53ZdpTGgV4pjA>
    <xme:nMo4ZSDHXFusSUy9WDRLvJcWbQMFG3rM2ZKCbWqiBUatbWXrVj0Hy14r3ZD5sG7Mm
    NjuwV_GE-AqIydgTw>
X-ME-Received: <xmr:nMo4ZdHgR4pgTNY4Gn-PUYn6J71HAYKbOR1FglvIzcaxAB8fCsv8SyyHAh3wLKFtghdoO6oDSVnKFF8dvhTKdAIarUuhNPyQL6xNZmn-kGtj99w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjeelkefguddvveevfeeuieeufedvtdfgtedvteelfeeljeejgfehkeegfedtveff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhntghorhgvrdhnrhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nMo4ZSTrJThe-1j0XiEHuw_2z_LsbpC6rWOTZ0BdE6yDbXZSoGjhGg>
    <xmx:nMo4Zaw62zK3ucgBkOsJkYXtKjwDctUMIVCcOGrDItc8USfz7G5HOQ>
    <xmx:nMo4ZY4fhV3F4dqO88K0rfaEe2yReFXXX2trgHoIQZij4t7_Qh-LYA>
    <xmx:nMo4ZUtHJpwU-NaYiMo9JIG-NVTxDfWI2ln0ArgdZSrZSrifvBo9rA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 03:58:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e1a9a3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 07:58:12 +0000 (UTC)
Date: Wed, 25 Oct 2023 09:58:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/5] merge-ort: implement support for packing objects
 together
Message-ID: <ZTjKmcV5c_EFuoGo@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ptsggake4UL/QqF2"
Content-Disposition: inline
In-Reply-To: <cover.1698101088.git.me@ttaylorr.com>


--Ptsggake4UL/QqF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:44:49PM -0400, Taylor Blau wrote:
> (Rebased onto the current tip of 'master', which is ceadf0f3cf (The
> twentieth batch, 2023-10-20)).
>=20
> This series implements support for a new merge-tree option,
> `--write-pack`, which causes any newly-written objects to be packed
> together instead of being stored individually as loose.
>=20
> This is a minor follow-up that could be taken instead of v4 (though the
> changes between these two most recent rounds are stylistic and a matter
> of subjective opinion).
>=20
> This moves us the bulk_checkin_source structure introduced in response
> to Junio's suggestion during the last round further in the OOP
> direction. Instead of switching on the enum type of the source, have
> function pointers for read() and seek() respectively.
>=20
> The functionality at the end is the same, but this avoids some of the
> namespacing issues that Peff pointed out while looking at v4. But I
> think that this approach ended up being less heavy-weight than I had
> originally imagined, so I think that this version is a worthwhile
> improvement over v4.
>=20
> Beyond that, the changes since last time can be viewed in the range-diff
> below. Thanks in advance for any review!

Overall this version looks good to me. I've only got two smallish nits
and one question regarding the tests.

Thanks!

Patrick

> [1]: https://lore.kernel.org/git/xmqq34y7plj4.fsf@gitster.g/
>=20
> Taylor Blau (5):
>   bulk-checkin: extract abstract `bulk_checkin_source`
>   bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
>   bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
>   bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
>   builtin/merge-tree.c: implement support for `--write-pack`
>=20
>  Documentation/git-merge-tree.txt |   4 +
>  builtin/merge-tree.c             |   5 +
>  bulk-checkin.c                   | 197 +++++++++++++++++++++++++++----
>  bulk-checkin.h                   |   8 ++
>  merge-ort.c                      |  42 +++++--
>  merge-recursive.h                |   1 +
>  t/t4301-merge-tree-write-tree.sh |  93 +++++++++++++++
>  7 files changed, 316 insertions(+), 34 deletions(-)
>=20
> Range-diff against v4:
> 1:  97bb6e9f59 ! 1:  696aa027e4 bulk-checkin: extract abstract `bulk_chec=
kin_source`
>     @@ bulk-checkin.c: static int already_written(struct bulk_checkin_pac=
kfile *state,
>       }
>      =20
>      +struct bulk_checkin_source {
>     -+	enum { SOURCE_FILE } type;
>     ++	off_t (*read)(struct bulk_checkin_source *, void *, size_t);
>     ++	off_t (*seek)(struct bulk_checkin_source *, off_t);
>      +
>     -+	/* SOURCE_FILE fields */
>     -+	int fd;
>     ++	union {
>     ++		struct {
>     ++			int fd;
>     ++		} from_fd;
>     ++	} data;
>      +
>     -+	/* common fields */
>      +	size_t size;
>      +	const char *path;
>      +};
>      +
>     -+static off_t bulk_checkin_source_seek_to(struct bulk_checkin_source=
 *source,
>     -+					 off_t offset)
>     ++static off_t bulk_checkin_source_read_from_fd(struct bulk_checkin_s=
ource *source,
>     ++					      void *buf, size_t nr)
>      +{
>     -+	switch (source->type) {
>     -+	case SOURCE_FILE:
>     -+		return lseek(source->fd, offset, SEEK_SET);
>     -+	default:
>     -+		BUG("unknown bulk-checkin source: %d", source->type);
>     -+	}
>     ++	return read_in_full(source->data.from_fd.fd, buf, nr);
>      +}
>      +
>     -+static ssize_t bulk_checkin_source_read(struct bulk_checkin_source =
*source,
>     -+					void *buf, size_t nr)
>     ++static off_t bulk_checkin_source_seek_from_fd(struct bulk_checkin_s=
ource *source,
>     ++					      off_t offset)
>      +{
>     -+	switch (source->type) {
>     -+	case SOURCE_FILE:
>     -+		return read_in_full(source->fd, buf, nr);
>     -+	default:
>     -+		BUG("unknown bulk-checkin source: %d", source->type);
>     -+	}
>     ++	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
>     ++}
>     ++
>     ++static void init_bulk_checkin_source_from_fd(struct bulk_checkin_so=
urce *source,
>     ++					     int fd, size_t size,
>     ++					     const char *path)
>     ++{
>     ++	memset(source, 0, sizeof(struct bulk_checkin_source));
>     ++
>     ++	source->read =3D bulk_checkin_source_read_from_fd;
>     ++	source->seek =3D bulk_checkin_source_seek_from_fd;
>     ++
>     ++	source->data.from_fd.fd =3D fd;
>     ++
>     ++	source->size =3D size;
>     ++	source->path =3D path;
>      +}
>      +
>       /*
>     @@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checkin=
_packfile *sta
>      -			ssize_t read_result =3D read_in_full(fd, ibuf, rsize);
>      +			ssize_t read_result;
>      +
>     -+			read_result =3D bulk_checkin_source_read(source, ibuf,
>     -+							       rsize);
>     ++			read_result =3D source->read(source, ibuf, rsize);
>       			if (read_result < 0)
>      -				die_errno("failed to read from '%s'", path);
>      +				die_errno("failed to read from '%s'",
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>       	unsigned header_len;
>       	struct hashfile_checkpoint checkpoint =3D {0};
>       	struct pack_idx_entry *idx =3D NULL;
>     -+	struct bulk_checkin_source source =3D {
>     -+		.type =3D SOURCE_FILE,
>     -+		.fd =3D fd,
>     -+		.size =3D size,
>     -+		.path =3D path,
>     -+	};
>     ++	struct bulk_checkin_source source;
>     ++
>     ++	init_bulk_checkin_source_from_fd(&source, fd, size, path);
>      =20
>       	seekback =3D lseek(fd, 0, SEEK_CUR);
>       	if (seekback =3D=3D (off_t) -1)
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>       		state->offset =3D checkpoint.offset;
>       		flush_bulk_checkin_packfile(state);
>      -		if (lseek(fd, seekback, SEEK_SET) =3D=3D (off_t) -1)
>     -+		if (bulk_checkin_source_seek_to(&source, seekback) =3D=3D (off_t)=
-1)
>     ++		if (source.seek(&source, seekback) =3D=3D (off_t)-1)
>       			return error("cannot seek back");
>       	}
>       	the_hash_algo->final_oid_fn(result_oid, &ctx);
> 2:  9d633df339 < -:  ---------- bulk-checkin: generify `stream_blob_to_pa=
ck()` for arbitrary types
> 3:  d5bbd7810e ! 2:  596bd028a7 bulk-checkin: refactor deflate routine to=
 accept a `bulk_checkin_source`
>     @@ Metadata
>      Author: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## Commit message ##
>     -    bulk-checkin: refactor deflate routine to accept a `bulk_checkin=
_source`
>     +    bulk-checkin: generify `stream_blob_to_pack()` for arbitrary typ=
es
>     =20
>     -    Prepare for a future change where we will want to use a routine =
very
>     -    similar to the existing `deflate_blob_to_pack()` but over arbitr=
ary
>     -    sources (i.e. either open file-descriptors, or a location in mem=
ory).
>     +    The existing `stream_blob_to_pack()` function is named based on =
the fact
>     +    that it knows only how to stream blobs into a bulk-checkin pack.
>     =20
>     -    Extract out a common "deflate_obj_to_pack()" routine that acts o=
n a
>     -    bulk_checkin_source, instead of a (int, size_t) pair. Then rewri=
te
>     -    `deflate_blob_to_pack()` in terms of it.
>     +    But there is no longer anything in this function which prevents =
us from
>     +    writing objects of arbitrary types to the bulk-checkin pack. Pre=
pare to
>     +    write OBJ_TREEs by removing this assumption, adding an `enum
>     +    object_type` parameter to this function's argument list, and ren=
aming it
>     +    to `stream_obj_to_pack()` accordingly.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bulk-checkin.c ##
>     +@@ bulk-checkin.c: static void init_bulk_checkin_source_from_fd(stru=
ct bulk_checkin_source *source,
>     +  * status before calling us just in case we ask it to call us again
>     +  * with a new pack.
>     +  */
>     +-static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
>     +-			       git_hash_ctx *ctx, off_t *already_hashed_to,
>     +-			       struct bulk_checkin_source *source,
>     +-			       unsigned flags)
>     ++static int stream_obj_to_pack(struct bulk_checkin_packfile *state,
>     ++			      git_hash_ctx *ctx, off_t *already_hashed_to,
>     ++			      struct bulk_checkin_source *source,
>     ++			      enum object_type type, unsigned flags)
>     + {
>     + 	git_zstream s;
>     + 	unsigned char ibuf[16384];
>     +@@ bulk-checkin.c: static int stream_blob_to_pack(struct bulk_checki=
n_packfile *state,
>     +=20
>     + 	git_deflate_init(&s, pack_compression_level);
>     +=20
>     +-	hdrlen =3D encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BL=
OB,
>     +-					      size);
>     ++	hdrlen =3D encode_in_pack_object_header(obuf, sizeof(obuf), type, =
size);
>     + 	s.next_out =3D obuf + hdrlen;
>     + 	s.avail_out =3D sizeof(obuf) - hdrlen;
>     +=20
>      @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin=
_packfile *state,
>       		die_errno("unable to write pack header");
>       }
>     @@ bulk-checkin.c: static void prepare_to_stream(struct bulk_checkin_=
packfile *stat
>       	unsigned header_len;
>       	struct hashfile_checkpoint checkpoint =3D {0};
>       	struct pack_idx_entry *idx =3D NULL;
>     --	struct bulk_checkin_source source =3D {
>     --		.type =3D SOURCE_FILE,
>     --		.fd =3D fd,
>     --		.size =3D size,
>     --		.path =3D path,
>     --	};
>     +-	struct bulk_checkin_source source;
>      =20
>     +-	init_bulk_checkin_source_from_fd(&source, fd, size, path);
>     +-
>      -	seekback =3D lseek(fd, 0, SEEK_CUR);
>      -	if (seekback =3D=3D (off_t) -1)
>      -		return error("cannot find the current offset");
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>       		prepare_to_stream(state, flags);
>       		if (idx) {
>      @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_check=
in_packfile *state,
>     + 			idx->offset =3D state->offset;
>       			crc32_begin(state->f);
>       		}
>     - 		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
>     --					&source, OBJ_BLOB, flags))
>     +-		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
>     +-					 &source, flags))
>     ++		if (!stream_obj_to_pack(state, &ctx, &already_hashed_to,
>      +					source, type, flags))
>       			break;
>       		/*
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>       		hashfile_truncate(state->f, &checkpoint);
>       		state->offset =3D checkpoint.offset;
>       		flush_bulk_checkin_packfile(state);
>     --		if (bulk_checkin_source_seek_to(&source, seekback) =3D=3D (off_t)=
-1)
>     -+		if (bulk_checkin_source_seek_to(source, seekback) =3D=3D (off_t)-=
1)
>     +-		if (source.seek(&source, seekback) =3D=3D (off_t)-1)
>     ++		if (source->seek(source, seekback) =3D=3D (off_t)-1)
>       			return error("cannot seek back");
>       	}
>       	the_hash_algo->final_oid_fn(result_oid, &ctx);
>     @@ bulk-checkin.c: static int deflate_blob_to_pack(struct bulk_checki=
n_packfile *st
>      +				int fd, size_t size,
>      +				const char *path, unsigned flags)
>      +{
>     -+	struct bulk_checkin_source source =3D {
>     -+		.type =3D SOURCE_FILE,
>     -+		.fd =3D fd,
>     -+		.size =3D size,
>     -+		.path =3D path,
>     -+	};
>     -+	off_t seekback =3D lseek(fd, 0, SEEK_CUR);
>     ++	struct bulk_checkin_source source;
>     ++	off_t seekback;
>     ++
>     ++	init_bulk_checkin_source_from_fd(&source, fd, size, path);
>     ++
>     ++	seekback =3D lseek(fd, 0, SEEK_CUR);
>      +	if (seekback =3D=3D (off_t) -1)
>      +		return error("cannot find the current offset");
>      +
> 4:  e427fe6ad3 < -:  ---------- bulk-checkin: implement `SOURCE_INCORE` m=
ode for `bulk_checkin_source`
> 5:  48095afe80 ! 3:  d8cf8e4395 bulk-checkin: introduce `index_blob_bulk_=
checkin_incore()`
>     @@ Metadata
>       ## Commit message ##
>          bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
>     =20
>     -    Now that we have factored out many of the common routines necess=
ary to
>     -    index a new object into a pack created by the bulk-checkin machi=
nery, we
>     -    can introduce a variant of `index_blob_bulk_checkin()` that acts=
 on
>     -    blobs whose contents we can fit in memory.
>     +    Introduce `index_blob_bulk_checkin_incore()` which allows stream=
ing
>     +    arbitrary blob contents from memory into the bulk-checkin pack.
>     +
>     +    In order to support streaming from a location in memory, we must
>     +    implement a new kind of bulk_checkin_source that does just that.=
 These
>     +    implementation in spread out across:
>     +
>     +      - init_bulk_checkin_source_incore()
>     +      - bulk_checkin_source_read_incore()
>     +      - bulk_checkin_source_seek_incore()
>     +
>     +    Note that, unlike file descriptors, which manage their own offset
>     +    internally, we have to keep track of how many bytes we've read o=
ut of
>     +    the buffer, and make sure we don't read past the end of the buff=
er.
>     =20
>          This will be useful in a couple of more commits in order to prov=
ide the
>          `merge-tree` builtin with a mechanism to create a new pack conta=
ining
>     @@ Commit message
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bulk-checkin.c ##
>     +@@ bulk-checkin.c: struct bulk_checkin_source {
>     + 		struct {
>     + 			int fd;
>     + 		} from_fd;
>     ++		struct {
>     ++			const void *buf;
>     ++			size_t nr_read;
>     ++		} incore;
>     + 	} data;
>     +=20
>     + 	size_t size;
>     +@@ bulk-checkin.c: static off_t bulk_checkin_source_seek_from_fd(str=
uct bulk_checkin_source *source
>     + 	return lseek(source->data.from_fd.fd, offset, SEEK_SET);
>     + }
>     +=20
>     ++static off_t bulk_checkin_source_read_incore(struct bulk_checkin_so=
urce *source,
>     ++					     void *buf, size_t nr)
>     ++{
>     ++	const unsigned char *src =3D source->data.incore.buf;
>     ++
>     ++	if (source->data.incore.nr_read > source->size)
>     ++		BUG("read beyond bulk-checkin source buffer end "
>     ++		    "(%"PRIuMAX" > %"PRIuMAX")",
>     ++		    (uintmax_t)source->data.incore.nr_read,
>     ++		    (uintmax_t)source->size);
>     ++
>     ++	if (nr > source->size - source->data.incore.nr_read)
>     ++		nr =3D source->size - source->data.incore.nr_read;
>     ++
>     ++	src +=3D source->data.incore.nr_read;
>     ++
>     ++	memcpy(buf, src, nr);
>     ++	source->data.incore.nr_read +=3D nr;
>     ++	return nr;
>     ++}
>     ++
>     ++static off_t bulk_checkin_source_seek_incore(struct bulk_checkin_so=
urce *source,
>     ++					     off_t offset)
>     ++{
>     ++	if (!(0 <=3D offset && offset < source->size))
>     ++		return (off_t)-1;
>     ++	source->data.incore.nr_read =3D offset;
>     ++	return source->data.incore.nr_read;
>     ++}
>     ++
>     + static void init_bulk_checkin_source_from_fd(struct bulk_checkin_so=
urce *source,
>     + 					     int fd, size_t size,
>     + 					     const char *path)
>     +@@ bulk-checkin.c: static void init_bulk_checkin_source_from_fd(stru=
ct bulk_checkin_source *source,
>     + 	source->path =3D path;
>     + }
>     +=20
>     ++static void init_bulk_checkin_source_incore(struct bulk_checkin_sou=
rce *source,
>     ++					    const void *buf, size_t size,
>     ++					    const char *path)
>     ++{
>     ++	memset(source, 0, sizeof(struct bulk_checkin_source));
>     ++
>     ++	source->read =3D bulk_checkin_source_read_incore;
>     ++	source->seek =3D bulk_checkin_source_seek_incore;
>     ++
>     ++	source->data.incore.buf =3D buf;
>     ++	source->data.incore.nr_read =3D 0;
>     ++
>     ++	source->size =3D size;
>     ++	source->path =3D path;
>     ++}
>     ++
>     + /*
>     +  * Read the contents from 'source' for 'size' bytes, streaming it t=
o the
>     +  * packfile in state while updating the hash in ctx. Signal a failu=
re
>      @@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checki=
n_packfile *state,
>       	return 0;
>       }
>     @@ bulk-checkin.c: static int deflate_obj_to_pack(struct bulk_checkin=
_packfile *sta
>      +				       const char *path, enum object_type type,
>      +				       unsigned flags)
>      +{
>     -+	struct bulk_checkin_source source =3D {
>     -+		.type =3D SOURCE_INCORE,
>     -+		.buf =3D buf,
>     -+		.size =3D size,
>     -+		.read =3D 0,
>     -+		.path =3D path,
>     -+	};
>     ++	struct bulk_checkin_source source;
>     ++
>     ++	init_bulk_checkin_source_incore(&source, buf, size, path);
>      +
>      +	return deflate_obj_to_pack(state, result_oid, &source, type, 0, fl=
ags);
>      +}
> 6:  60568f9281 =3D 4:  2670192802 bulk-checkin: introduce `index_tree_bul=
k_checkin_incore()`
> 7:  b9be9df122 ! 5:  3595db76a5 builtin/merge-tree.c: implement support f=
or `--write-pack`
>     @@ Documentation/git-merge-tree.txt: OPTIONS
>     =20
>       ## builtin/merge-tree.c ##
>      @@
>     - #include "quote.h"
>       #include "tree.h"
>       #include "config.h"
>     + #include "strvec.h"
>      +#include "bulk-checkin.h"
>      =20
>       static int line_termination =3D '\n';
>      =20
>      @@ builtin/merge-tree.c: struct merge_tree_options {
>     - 	int show_messages;
>       	int name_only;
>       	int use_stdin;
>     + 	struct merge_options merge_options;
>      +	int write_pack;
>       };
>      =20
>       static int real_merge(struct merge_tree_options *o,
>      @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opt=
ions *o,
>     - 	init_merge_options(&opt, the_repository);
>     + 				 _("not something we can merge"));
>      =20
>       	opt.show_rename_progress =3D 0;
>      +	opt.write_pack =3D o->write_pack;
>     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_opti=
ons *o,
>       	opt.branch1 =3D branch1;
>       	opt.branch2 =3D branch2;
>      @@ builtin/merge-tree.c: int cmd_merge_tree(int argc, const char **a=
rgv, const char *prefix)
>     - 			   &merge_base,
>     - 			   N_("commit"),
>       			   N_("specify a merge-base for the merge")),
>     + 		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=3Dvalue"),
>     + 			N_("option for selected merge strategy")),
>      +		OPT_BOOL(0, "write-pack", &o.write_pack,
>      +			 N_("write new objects to a pack instead of as loose")),
>       		OPT_END()
>=20
> base-commit: ceadf0f3cf51550166a387ec8508bb55e7883057
> --=20
> 2.42.0.425.g963d08ddb3.dirty

--Ptsggake4UL/QqF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4ypgACgkQVbJhu7ck
PpQpqA//SZ0AgDp6aeVq49SDjL3ewjJQF726uy3P0CUMGsImea7aSw72OzwfVTT7
VVAokwXpuolmwBT9u/9NkABfI9hWViEgZuJVudmys+bw7V1uocCUteYoDkM/JpSK
lW1iTpkCsT8TgMVv4yeQsj1XQYMbH1CfzyA0kGLuEG0XScRWAk00ruFXNGKnqGz7
s2aWpkCq/5X+9/15qJEscZ9f2y8Y+tc78IuIfCFpFFb3TgKwlIYiptTgSsQV0laA
31W+DPID0bE2im7FW2X2rmkSMhVD339yYVJ0uxTj8pt9Fpib9gcwxBa4Cd/rY6uC
r8+zp/m+Y8dBOZyOMeoDpuN49HGJvv4+mQOJhHuX4wATt8mmWYJZe1CUAMdzucXZ
ZvdFFeOpgY06GCWjkKfECQXmsBpGE+aVVpXRnNGNP2rxktFM/LFl758N5KFgJQbi
1x+5KjeTZACi0BrskbkN8uyOpBUiEVzQrPiTWYnII8ZwSy6C5xbra/KktDzPFAZL
bYd5xSrgOzgqUz+OR09BG8Iy5r+XMlKiN5y5MsCERMDG0fB453xrhJMB1XmCInFg
EHsrCh040HScNsm06uQET8kD1VnnzhtFpDJFhjozq1neW7xR/L/asDqFPxMpL3RQ
NSr2O1y9O1Foqc6kIXgM16OOVzGQYxQ1XIaEz7+eTtpBpGcs7uE=
=4MmO
-----END PGP SIGNATURE-----

--Ptsggake4UL/QqF2--
