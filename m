Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454E14F9C
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EUQNMBJD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EtrCOuXr"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 3357E3200A66;
	Thu, 11 Jan 2024 05:06:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 11 Jan 2024 05:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704967618; x=1705054018; bh=49AMbmFfk9
	mno+MnrNQksQab7rHFduMeb4BWWR/XHC0=; b=EUQNMBJDjJlEPyXwkzt9JRvyfF
	rJC3p0UDUEJEef1VIjsdsbFVJSN6uH3sl9NGY1EDmYGofzfhQXA+TiwPZW7/dkY3
	H7GE80McUx00jbFFzjeggbDPnUwgE6Zg7CByeQKmspoh2jZQ2rngw1xOzBafu6od
	BwAT1btLQnTx+AszjjvDupDxMZbombrpl6G1/1sCq2hc6wlsqLROSNGM9QR60ZsV
	s1m63w3EUCFNRkucRryoMHAdAgT75txR3CUDYwjPTTscc5O5cV6mkgXlRgIeGlCb
	rWtmtiHtuRgF9vN4t+LlqlBm5pIZEn8RogpjL5pKTNOaRojhaeIH/7M93Dsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704967618; x=1705054018; bh=49AMbmFfk9mno+MnrNQksQab7rHF
	duMeb4BWWR/XHC0=; b=EtrCOuXrwJSXjteig8OqLuOb+nRXYXoEhVILnWzY02c1
	EFnULY+CxCRjDmvNiP1+aFEGTd2e8Bg2AryHUaVXSmBQD2U7gDZD510s5fDxWKT3
	vxdaIj540VNceiPxr9Z9yRU30ZDQlB2C2GFxxePlFcTkz66VeVWAJZJBThaRYZ6c
	maIM+N0RmAcXjdfQc4KrK6eh4td4NVTxIgYFeRFj1xfPGCoUQJimI6ubjhW1hPki
	WO/VEruUauUvw8AvPyKzGr3ujNwqbCQba61idmDMjEjBNUVhRLkeJ0X/zeEl8eUQ
	ooHgZ4KXo2slG8sfv6QiE9WLl2NWbvns3ZRPuIWlPg==
X-ME-Sender: <xms:wr2fZQcRHHtrqiNaFmsNiqFHUr_2agqSRGh_fZfCWZKqQbqmlck08Q>
    <xme:wr2fZSOmqa4YdGX-KBoqwG9A6NE4K9uJq7rzxOIRUVMKjwnWOJ7shNZW1bVFgb9DP
    phzrAjdVJT1N4pU-Q>
X-ME-Received: <xmr:wr2fZRiHI0NuBf8RVE7I0BtmOSvs95Ak36fmteQOdi4VaZSAqdUm0f9HEt9hiHZE7gPURIAxLwcGm-FXX0kx3C1_gg-nr53pQbBvM1ULqfzBWgAh-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeifedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wr2fZV-BgyBR-2uoWCGHms64n8gvzBrR53snSmAH7Pyh7rstMx-zGg>
    <xmx:wr2fZcszEeBafSKPnM1ZsYHIeTFHZCn3RYnLvGaw6GyJR0Sp7QikTA>
    <xmx:wr2fZcEL5iVhfuPlYE2yfqMSjhglgnuGcjfDY-6FdDAdHz1VCNKpXA>
    <xmx:wr2fZZW5X628jga3AMp1C9a8_wEhTccXwF2iiuRAmb2QxWo1W-qKeQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 05:06:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd3347fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 10:04:16 +0000 (UTC)
Date: Thu, 11 Jan 2024 11:06:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] reftable/blocksource: use mmap to read tables
Message-ID: <e53a20c8e1a5f2169da4fddf2d430d584a7731d1.1704966670.git.ps@pks.im>
References: <cover.1704714575.git.ps@pks.im>
 <cover.1704966670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n/buAey+JegKpi9u"
Content-Disposition: inline
In-Reply-To: <cover.1704966670.git.ps@pks.im>


--n/buAey+JegKpi9u
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
already-written stacks, so it does not matter that we cannot rename a
file over an mmaped file, either.

Another unfortunate property of mmap is that it is not supported by all
systems. But given that the size of reftables should typically be rather
limited (megabytes at most in the vast majority of repositories), we can
use the fallback implementation provided by `git_mmap()` which reads the
whole file into memory instead. This is the same strategy that the
"packed" backend uses.

While this change doesn't significantly improve performance in the case
where we're seeking through stacks once (like e.g. git-for-each-ref(1)
would). But it does speed up usecases where there is lots of random
access to refs, e.g. when writing. The following benchmark demonstrates
these savings with git-update-ref(1) creating N refs in an otherwise
empty repository:

  Benchmark 1: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD~)
    Time (mean =C2=B1 =CF=83):       5.1 ms =C2=B1   0.2 ms    [User: 2.5 m=
s, System: 2.5 ms]
    Range (min =E2=80=A6 max):     4.8 ms =E2=80=A6   7.1 ms    111 runs

  Benchmark 2: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD~)
    Time (mean =C2=B1 =CF=83):      14.8 ms =C2=B1   0.5 ms    [User: 7.1 m=
s, System: 7.5 ms]
    Range (min =E2=80=A6 max):    14.1 ms =E2=80=A6  18.7 ms    84 runs

  Benchmark 3: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD~)
    Time (mean =C2=B1 =CF=83):     926.4 ms =C2=B1   5.6 ms    [User: 448.5=
 ms, System: 477.7 ms]
    Range (min =E2=80=A6 max):   920.0 ms =E2=80=A6 936.1 ms    10 runs

  Benchmark 4: update-ref: create many refs (refcount =3D 1, revision =3D H=
EAD)
    Time (mean =C2=B1 =CF=83):       5.0 ms =C2=B1   0.2 ms    [User: 2.4 m=
s, System: 2.5 ms]
    Range (min =E2=80=A6 max):     4.7 ms =E2=80=A6   5.4 ms    111 runs

  Benchmark 5: update-ref: create many refs (refcount =3D 100, revision =3D=
 HEAD)
    Time (mean =C2=B1 =CF=83):      10.5 ms =C2=B1   0.2 ms    [User: 5.0 m=
s, System: 5.3 ms]
    Range (min =E2=80=A6 max):    10.0 ms =E2=80=A6  10.9 ms    93 runs

  Benchmark 6: update-ref: create many refs (refcount =3D 10000, revision =
=3D HEAD)
    Time (mean =C2=B1 =CF=83):     529.6 ms =C2=B1   9.1 ms    [User: 268.0=
 ms, System: 261.4 ms]
    Range (min =E2=80=A6 max):   522.4 ms =E2=80=A6 547.1 ms    10 runs

  Summary
    update-ref: create many refs (refcount =3D 1, revision =3D HEAD) ran
      1.01 =C2=B1 0.06 times faster than update-ref: create many refs (refc=
ount =3D 1, revision =3D HEAD~)
      2.08 =C2=B1 0.07 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD)
      2.95 =C2=B1 0.14 times faster than update-ref: create many refs (refc=
ount =3D 100, revision =3D HEAD~)
    105.33 =C2=B1 3.76 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD)
    184.24 =C2=B1 5.89 times faster than update-ref: create many refs (refc=
ount =3D 10000, revision =3D HEAD~)

Theoretically, we could also replicate the strategy of the "packed"
backend where small tables are read into memory instead of using mmap.
Benchmarks did not confirm that this has a performance benefit though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 1e2fb5e9fd..8c41e3c70f 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -76,8 +76,8 @@ struct reftable_block_source malloc_block_source(void)
 }
=20
 struct file_block_source {
-	int fd;
 	uint64_t size;
+	unsigned char *data;
 };
=20
 static uint64_t file_size(void *b)
@@ -87,19 +87,12 @@ static uint64_t file_size(void *b)
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
-	}
-
+	struct file_block_source *b =3D v;
+	munmap(b->data, b->size);
 	reftable_free(b);
 }
=20
@@ -108,9 +101,7 @@ static int file_read_block(void *v, struct reftable_blo=
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
@@ -143,7 +134,8 @@ int reftable_block_source_from_file(struct reftable_blo=
ck_source *bs,
=20
 	p =3D reftable_calloc(sizeof(*p));
 	p->size =3D st.st_size;
-	p->fd =3D fd;
+	p->data =3D xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
=20
 	assert(!bs->ops);
 	bs->ops =3D &file_vtable;
--=20
2.43.GIT


--n/buAey+JegKpi9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfvb8ACgkQVbJhu7ck
PpQ3bw/9FvKAdYmOq3+IYoa9xbfPu0fYYPlUzUOLrkRRQLhNyDjhQ0GeZ1rLqlTb
DkFyS83frcCN6q5FN1rFHJPdA5aOwui99+nZwzXAXJXmuykGsUyGd26/OiGJKa3c
3zMZVIPtS+5sbVq4g/7l5Ig7rTMIaUrG1Uov47/nZyKiQJ0Z3NPdPBCCdZSRyYaq
AYdvDeftnQfcmko5fPrTgbFYTJqTAi0uBV20iMuAc4ORILaXhxblWVU9mkgy8gfM
G9XW1sv6KwUl4/hE82SAFU1OwKEzy53tAlnPl7GbUSTni1jVV4ppy7YFH84Bt9TA
QCvFi4f8dfhZgvPwAgLSbNE9YFEQT+YTXsOjYDHoaJ1uM6kRmWv6G07MjRrp/1+Q
3+gAkmTaatr8Ql3CEWgDpLmUddM4exurUjqhaXy2b7DhaBe1e6+32jERz6uvXeb2
APgG8p3ApBiX+xJrAGhq9WTZDrb9+X7OZJoqW9uFXl1AoVdt2g6L41sIY+M/sIPB
DakvOy1sEZAQLRtbeyghEwohjujWPVIpzRJaaXXqTFJ8z+taQzrs3cUtQ6YvSsYs
9sr1Dh0nfnPxz8ntF2m7HgPix/b/800gENrvG+tnSal6eHZvVKEBlsZWEL4PNmdU
87cxfkAHv5lEfdRtekBfGYVIeA+s35DLk9JjJiYs6U2bJZjPswI=
=haud
-----END PGP SIGNATURE-----

--n/buAey+JegKpi9u--
