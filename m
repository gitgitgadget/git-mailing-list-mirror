Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EC405E1
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkXplaOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XG7Sg43d"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 866E53201289;
	Mon,  8 Jan 2024 07:18:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 08 Jan 2024 07:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704716326; x=1704802726; bh=UF/ry2kAj9
	LIC50i1Nw1RkSQaNsR/6vArd7ZxNIQpH8=; b=TkXplaOxgpF+adqWXF+R54Yfg1
	9t8Gpi6Lj/J7wgJ33OufiGeqJ9njrVYuJQRhRXlJl4EGqRvjHtppt78xmUp2VUY1
	+BwFzUuJ4Nx6qSizbQPAQw/umNgKsIF51+r/o5qwCdMJ7fw2w7zJRDzb5/kOGPeW
	l/reOk227k9nMFpBWKb8G6eGEk2cURxV1hnyDGYyO1bkP5SvY25GFZa9yoIkBExt
	dkeK+aqsG5KOMZr3vDT4DDkmmvW0/phQsKq1pMe/cTy4Q+gHoD0UzOI3mC2HN+4J
	UyfgLTqhQqH/XNIjzh5TA7T5onMhlhIIHxxjc1mH0epkyIXGboB9/jADi+XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704716326; x=1704802726; bh=UF/ry2kAj9LIC50i1Nw1RkSQaNsR
	/6vArd7ZxNIQpH8=; b=XG7Sg43dVudyHg5XhXcNIZZK9WczrmynqELZ0mVac1KM
	MhWEQM7tbg3sdcOVyZ8qK6tee2x0rkyBD0Ygq8SMNN2A8jpQZ1k4gcJM90KDmB7/
	hgPMVh2C9u8vzPTqWL3nmP6l/ghgwg7Fj1bDsHUYC53L2IUEPKbTJY670cCsGR5+
	58CWOuNNfZAUnelKce9/jzKXwwvpRoEi8uCGN1yDPU5RDlpLC8neFB/ojqPUGk3m
	uXTs3Mh4fVvxiqk7R1FS4Tw+xc9/EAvTPTVo4fwSSSdqcAXQOju2O3jDoorTmLrW
	P3XpC54oiXJBdSmi3N1Dmn2icS8tmJLWEmsshLT9hg==
X-ME-Sender: <xms:JeibZee1mZhY-sOG1HR1_FrZkOV9bDC_lIUbiA2zDhhSVrI4XHIsmQ>
    <xme:JeibZYMZyl3w_0lwrtqXrc6WfVHV3v3X52pKXUncWclLKuR_MnKPYV888kl5KOU7w
    lKvnPEdjyDr1ErS4w>
X-ME-Received: <xmr:JeibZfjmHJjkTFwV_xn1FN-bQNRVZAXZcjOORYkNh5oy2wryrMQB4H5RmF4En8Rp0fbO2vdC7w2GG21YQ5-ZU0y1cHRcCCs4-VnCOBq84lbuy9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JeibZb-TVP1UhSV5yfRw57NmoFTz_LUdsZh91e3IIPe0uZZSE6a7fw>
    <xmx:JeibZatGGOyy9sPAUE8gXysRPTM5hxAm7h3p06XhG7i6h553XsWnIg>
    <xmx:JeibZSFVXkb6cPlZhY0Jixha1mLj8G_JqxAYjhuZVbPLMmEOsp-PJQ>
    <xmx:JuibZQ3rUiH7Mm3k_TXjo6JURg91zNVc3PMmUuk3votU-SKqTscx1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 07:18:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c775b688 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jan 2024 12:16:09 +0000 (UTC)
Date: Mon, 8 Jan 2024 13:18:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH 4/4] reftable/blocksource: use mmap to read tables
Message-ID: <a23f38a80609a5c5a6931400ffd28a92b33838bb.1704714575.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NBAaQiMxmUDYVcfF"
Content-Disposition: inline
In-Reply-To: <cover.1704714575.git.ps@pks.im>


--NBAaQiMxmUDYVcfF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The blocksource interface provides an interface to read blocks from a
reftable table. This interface is implemented using read(3P) calls on
the underlying file descriptor. While this works alright, this pattern
is very inefficient when repeatedly querying the reftable stack for one
or more refs. This inefficiency can mostly be attributed to the fact
that we often need to re-read the same blocks over and over again, and
every single time we need to call read(3P) again.

A natural fit in this context is to use mmap(3P) instead of read(3P),
which has a bunch of benefits:

  - We do not need to come up with a caching strategy for some of the
    blocks as this will be handled by the kernel already.

  - We can avoid the overhead of having to call into the read(3P)
    syscall repeatedly.

  - We do not need to allocate returned blocks repeatedly, but can
    instead hand out pointers into the mmapped region directly.

Using mmap comes with a significant drawback on Windows though, because
mmapped files cannot be deleted and neither is it possible to rename
files onto an mmapped file. But for one, the reftable library gracefully
handles the case where auto-compaction cannot delete a still-open stack
already and ignores any such errors. Also, `reftable_stack_clean()` will
prune stale tables which are not referenced by "tables.list" anymore so
that those files can eventually be pruned. And second, we never rewrite
already-rewritten stacks, so it does not matter that we cannot rename a
file over an mmaped file, either.

Another unfortunate property of mmap is that it is not supported by all
systems. But given that the size of reftables should typically be rather
limited (megabytes at most in the vast majority of repositories), we can
provide an easy fallback by just reading the complete table into memory
on such platforms. This is the same strategy that the "packed" backend
uses in case the platform does not provide mmap.

While this change doesn't significantly improve performance in the case
where we're seeking through stacks once (like e.g. git-for-each-ref(1)
would). But it does speed up usecases where there is lots of random
access to refs, e.g. when writing. The following benchmark demonstrates
these savings with git-update-ref(1) creating N refs in an otherwise
empty repository:

  Benchmark 1: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD~)
    Time (mean =C2=B1 =CF=83):       5.6 ms =C2=B1   0.2 ms    [User: 2.7 m=
s, System: 2.8 ms]
    Range (min =E2=80=A6 max):     5.1 ms =E2=80=A6   6.0 ms    90 runs

  Benchmark 2: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD~)
    Time (mean =C2=B1 =CF=83):      15.1 ms =C2=B1   0.4 ms    [User: 7.1 m=
s, System: 8.0 ms]
    Range (min =E2=80=A6 max):    14.2 ms =E2=80=A6  16.5 ms    71 runs

  Benchmark 3: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD~)
    Time (mean =C2=B1 =CF=83):     919.4 ms =C2=B1  11.2 ms    [User: 427.5=
 ms, System: 491.7 ms]
    Range (min =E2=80=A6 max):   908.1 ms =E2=80=A6 936.6 ms    10 runs

  Benchmark 4: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD)
    Time (mean =C2=B1 =CF=83):       5.5 ms =C2=B1   0.3 ms    [User: 2.4 m=
s, System: 3.1 ms]
    Range (min =E2=80=A6 max):     5.0 ms =E2=80=A6   7.3 ms    89 runs

  Benchmark 5: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD)
    Time (mean =C2=B1 =CF=83):      10.4 ms =C2=B1   0.3 ms    [User: 5.1 m=
s, System: 5.3 ms]
    Range (min =E2=80=A6 max):     9.7 ms =E2=80=A6  11.0 ms    78 runs

  Benchmark 6: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD)
    Time (mean =C2=B1 =CF=83):     483.5 ms =C2=B1   6.3 ms    [User: 227.8=
 ms, System: 255.6 ms]
    Range (min =E2=80=A6 max):   477.5 ms =E2=80=A6 498.8 ms    10 runs

  Summary
    update-ref: create many refs (refcount =3D 1, revision =3D HEAD) ran
      1.01 =C2=B1 0.06 times faster than update-ref: create many refs (refc=
ount =3D 1, revision =3D HEAD~)
      1.89 =C2=B1 0.11 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD)
      2.73 =C2=B1 0.16 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD~)
     87.55 =C2=B1 4.65 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD)
    166.48 =C2=B1 8.80 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD~)

Theoretically, we could also replicate the strategy of the "packed"
backend where small tables are read into memory instead of using mmap.
Benchmarks did not confirm that this has a performance benefit though.
---
 reftable/blocksource.c | 48 ++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index a1ea304429..5d3f3d264c 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,6 +13,12 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
=20
+#if defined(NO_MMAP)
+static int use_mmap =3D 0;
+#else
+static int use_mmap =3D 1;
+#endif
+
 static void strbuf_return_block(void *b, struct reftable_block *dest)
 {
 	if (dest->len)
@@ -78,6 +84,7 @@ struct reftable_block_source malloc_block_source(void)
 struct file_block_source {
 	int fd;
 	uint64_t size;
+	unsigned char *data;
 };
=20
 static uint64_t file_size(void *b)
@@ -87,19 +94,23 @@ static uint64_t file_size(void *b)
=20
 static void file_return_block(void *b, struct reftable_block *dest)
 {
-	if (dest->len)
-		memset(dest->data, 0xff, dest->len);
-	reftable_free(dest->data);
 }
=20
-static void file_close(void *b)
+static void file_close(void *v)
 {
-	int fd =3D ((struct file_block_source *)b)->fd;
-	if (fd > 0) {
-		close(fd);
-		((struct file_block_source *)b)->fd =3D 0;
+	struct file_block_source *b =3D v;
+
+	if (b->fd >=3D 0) {
+		close(b->fd);
+		b->fd =3D -1;
 	}
=20
+	if (use_mmap)
+		munmap(b->data, b->size);
+	else
+		reftable_free(b->data);
+	b->data =3D NULL;
+
 	reftable_free(b);
 }
=20
@@ -108,9 +119,7 @@ static int file_read_block(void *v, struct reftable_blo=
ck *dest, uint64_t off,
 {
 	struct file_block_source *b =3D v;
 	assert(off + size <=3D b->size);
-	dest->data =3D reftable_malloc(size);
-	if (pread_in_full(b->fd, dest->data, size, off) !=3D size)
-		return -1;
+	dest->data =3D b->data + off;
 	dest->len =3D size;
 	return size;
 }
@@ -127,8 +136,10 @@ int reftable_block_source_from_file(struct reftable_bl=
ock_source *bs,
 {
 	struct stat st =3D { 0 };
 	int err =3D 0;
-	int fd =3D open(name, O_RDONLY);
+	int fd;
 	struct file_block_source *p =3D NULL;
+
+	fd =3D open(name, O_RDONLY);
 	if (fd < 0) {
 		if (errno =3D=3D ENOENT) {
 			return REFTABLE_NOT_EXIST_ERROR;
@@ -144,7 +155,18 @@ int reftable_block_source_from_file(struct reftable_bl=
ock_source *bs,
=20
 	p =3D reftable_calloc(sizeof(struct file_block_source));
 	p->size =3D st.st_size;
-	p->fd =3D fd;
+	if (use_mmap) {
+		p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+		p->fd =3D fd;
+	} else {
+		p->data =3D xmalloc(st.st_size);
+		if (read_in_full(fd, p->data, st.st_size) !=3D st.st_size) {
+			close(fd);
+			return -1;
+		}
+		close(fd);
+		p->fd =3D -1;
+	}
=20
 	assert(!bs->ops);
 	bs->ops =3D &file_vtable;
--=20
2.43.GIT


--NBAaQiMxmUDYVcfF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWb6CIACgkQVbJhu7ck
PpSWpQ//f6PwhgHU9w6DvvWIViFUhEmT4HwYn726BLfOXNHnv05o/kyrH/e5YR0L
yXK15yYBa2ZjryEe2FHZeb1sLqbCo9mEvaSbrnfjMFt2dhqWXCvtVzk8QHEy3gfC
PAil78bQapAL60poLOtlGnBNrOVqti2nkwNcxNsNnn/Z7NZLcK7k/z0uuJKS+NbW
e927qvEnEM5KCBMfpY0hJarAqdbm5P3TBAj5Dytzvr55qdmTdtMB6a5cOjHPK3ct
eoCscBDlIpwFwzPXwI3JwIssxKjyYxatArhXY2lTba7TkiU0E+i1eVVVrzR8SUMq
ux7ryIJ0mzdI1jpGTRP7OjA+XQPg128T1lQ5yw0r4M4SI3lmq6E03SLK9fHFdmmV
cV3mb2xYQeJC4lcjBSF1s2RpPmVZgPoP0SWv+FCf2D0OaKKhB6omB8l5y+Lw7r8G
ZXX2RsXgi92B3PUd3P79E8Ou+/yu5E+XNAHpOp9TxhLVVRsz2Si8vvzqsA922Ztf
Ymh8724zv5lm29ZjDTO/7nv9KQK/tH2ftRWOM8Y/St1hnYqoaR2aKB2i1FED4bwL
hoBWvUIWal5v2eABcUf59tP4kBriXJDPIsgoiwSOJnXaW6UdIGudEQ0QeCqc3siF
Lu8bBXI3GTdIFWtgyYHH2lu2iD6r6g0Vin/Ju9/Z6gIndL+WASQ=
=5/f9
-----END PGP SIGNATURE-----

--NBAaQiMxmUDYVcfF--
