Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EjodkgbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WHdx8MbX"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FEAD9
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 01:07:34 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 2AF893202619;
	Mon, 11 Dec 2023 04:07:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 04:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702285650; x=1702372050; bh=LJ
	/g0545/x/e+4Xu5F2PbRkxU6v3O9UdggpGZOihIps=; b=EjodkgbY+KA3NM1ltX
	zgvGvnbnkx7RiOZPqo+lAk3Ju2onG7Pb/VwQ3X+/nAlUnHY72h4STrdliYBn2bGt
	vBvWT5i13Gl+9Ufnw8ZZLU9f1ENsK+uAE/5B9YjslZ0HTYuJQua4t1E+iSOMQ9Pp
	tS6L4yj/fJ14gAV7ch6BRpdHh3k110tNx2tpz4CBct3XcX7GUQ5jqL3uxZPnvOKs
	7ovlmDBaLiUGSpYA/uFDvcNnamhYt2sAAmq1KRZRoSLD9bbUZFAO3+2l5/v/rE+Y
	DZvaVjidmW1IkAeEVV+4DMjKYkv5EUXKvsIFPVLx+ixIKl5TgwP+FCsg2zL1notE
	ZJ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702285650; x=1702372050; bh=LJ/g0545/x/e+
	4Xu5F2PbRkxU6v3O9UdggpGZOihIps=; b=WHdx8MbXPKN7kPW2k4qqkQFkvsFEA
	FpsvI+tM2HzI1TR3f8I2J804LRr8Mykov2Wi06sVeiX0uCalAk3cjUTUw7ABn0IL
	u/bp2nzw2khoMGBbd78XdvVFVSByH7bHvHupSbQ0+K3gIDcaeqx0ehuWKM1WTkWy
	STk5ecA59dM5yGvnU8U5pSGmLW4l97D26r0gECt1OWvgm9z1cgqw3A1q7VbiqnOo
	aPrfSk5I7rqVFrYaAHe1ZvIWLPcWW+vb9LtZtF+LbC9jGhF6mKrZygAMP9H3TC+Z
	g9HbpTrH8epa1JHKRD7jUmRWA/vudrCM9IzJRuQ8PrKHC8Bd0I6yw7oYA==
X-ME-Sender: <xms:UtF2ZQunh2JJBOQA0kF0fjfcYHzM9uuN9SrB2nrLCxhTINxGuNFofA>
    <xme:UtF2Zdcd8KMn8vfjjennxoXf8pPrXmBK9oHQghqx_uDgKr8fC_tXAt-b3lycNFL7Z
    VfPcPdzqq0vTJTIKw>
X-ME-Received: <xmr:UtF2Zbw2oHN24kkl2TejL1Mow2mU80My9yZJMKsawMKw94HP1kcEweVt8L3Cjl9M5GpBGHV9INvDphznbu2w5vg8iEyGOQnezbJtev9uZhbIVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:UtF2ZTOil-77IovUoE1YnpzLabj0iCXjZmSrQplmsoshqtK5pGv9oQ>
    <xmx:UtF2ZQ-mkc_nKowdmaS9gPcnEgxpX7SMRTQglZERN3SMvLULzmTRKA>
    <xmx:UtF2ZbXK79T92tfDQD-WQ4AyvqbS32B-fJCh3ROFabzJdEQpvfVnuw>
    <xmx:UtF2ZfbxoP6YzSDhzNcgzDKAU247Ffa13mPzPwa464lkXAy7SwBZMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 04:07:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73453bf6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 09:05:51 +0000 (UTC)
Date: Mon, 11 Dec 2023 10:07:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/11] reftable: small set of fixes
Message-ID: <cover.1702285387.git.ps@pks.im>
References: <cover.1700549493.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pET5hpg3VaekS7HB"
Content-Disposition: inline
In-Reply-To: <cover.1700549493.git.ps@pks.im>


--pET5hpg3VaekS7HB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that addresses several
smallish issues in the reftable backend.

There's only a small set of changes compared to v2:

  - Patch 4: convert to use a `struct strbuf` instead of `snprintf()`.

  - Patch 5: improve commit message.

  - Patch 6: note that `stack_filename()` resets the `struct strbuf` in
    the commit message.

  - Patch 7: use the `struct filelock`'s lock path instead of the
    temporary buffer.

Thanks for your suggestions, Taylor and Eric!

Patrick

Patrick Steinhardt (11):
  reftable: wrap EXPECT macros in do/while
  reftable: handle interrupted reads
  reftable: handle interrupted writes
  reftable/stack: verify that `reftable_stack_add()` uses
    auto-compaction
  reftable/stack: perform auto-compaction with transactional interface
  reftable/stack: reuse buffers when reloading stack
  reftable/stack: fix stale lock when dying
  reftable/stack: fix use of unseeded randomness
  reftable/merged: reuse buffer to compute record keys
  reftable/block: introduce macro to initialize `struct block_iter`
  reftable/block: reuse buffer to compute record keys

 reftable/block.c          |  23 ++++----
 reftable/block.h          |   6 +++
 reftable/block_test.c     |   4 +-
 reftable/blocksource.c    |   2 +-
 reftable/iter.h           |   8 +--
 reftable/merged.c         |  31 +++++------
 reftable/merged.h         |   2 +
 reftable/reader.c         |   7 ++-
 reftable/readwrite_test.c |   6 +--
 reftable/stack.c          |  73 +++++++++++---------------
 reftable/stack_test.c     | 107 +++++++++++++++++++++++++++++++++++++-
 reftable/test_framework.h |  58 ++++++++++++---------
 12 files changed, 213 insertions(+), 114 deletions(-)

Range-diff against v2:
 1:  0ebbb02d32 =3D  1:  5b2a64ca9f reftable: wrap EXPECT macros in do/while
 2:  b404fdf066 =3D  2:  3e8e63ece5 reftable: handle interrupted reads
 3:  8c1d78b12b =3D  3:  1700d00d1c reftable: handle interrupted writes
 4:  8061b9d2fc !  4:  5e27d0a556 reftable/stack: verify that `reftable_sta=
ck_add()` uses auto-compaction
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +{
     +	struct reftable_write_options cfg =3D { 0 };
     +	struct reftable_stack *st =3D NULL;
    ++	struct strbuf refname =3D STRBUF_INIT;
     +	char *dir =3D get_tmp_dir(__LINE__);
     +	int err, i, n =3D 20;
     +
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +			.value_type =3D REFTABLE_REF_SYMREF,
     +			.value.symref =3D "master",
     +		};
    -+		char name[100];
     +
     +		/*
     +		 * Disable auto-compaction for all but the last runs. Like this
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +		 */
     +		st->disable_auto_compact =3D i !=3D n;
     +
    -+		snprintf(name, sizeof(name), "branch%04d", i);
    -+		ref.refname =3D name;
    ++		strbuf_reset(&refname);
    ++		strbuf_addf(&refname, "branch-%04d", i);
    ++		ref.refname =3D refname.buf;
     +
     +		err =3D reftable_stack_add(st, &write_test_ref, &ref);
     +		EXPECT_ERR(err);
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +	}
     +
     +	reftable_stack_destroy(st);
    ++	strbuf_release(&refname);
     +	clear_dir(dir);
     +}
     +
 5:  77b9ae8aa6 !  5:  dd180eba40 reftable/stack: perform auto-compaction w=
ith transactional interface
    @@ Commit message
    =20
         Whenever updating references or reflog entries in the reftable sta=
ck, we
         need to add a new table to the stack, thus growing the stack's len=
gth by
    -    one. It can thus happen quite fast that the stack grows very long,=
 which
    -    results in performance issues when trying to read records. But bes=
ides
    -    performance issues, this can also lead to exhaustion of file descr=
iptors
    -    very rapidly as every single table requires a separate descriptor =
when
    +    one. The stack can grow to become quite long rather quickly, leadi=
ng to
    +    performance issues when trying to read records. But besides perfor=
mance
    +    issues, this can also lead to exhaustion of file descriptors very
    +    rapidly as every single table requires a separate descriptor when
         opening the stack.
    =20
         While git-pack-refs(1) fixes this issue for us by merging the tabl=
es, it
 6:  f797feff8d !  6:  6ed9ba60db reftable/stack: reuse buffers when reload=
ing stack
    @@ Commit message
         of the allocated buffer outside of the loop.
    =20
         Refactor the code to instead reuse the buffers to reduce the numbe=
r of
    -    allocations we need to do.
    +    allocations we need to do. Note that we do not have to manually re=
set
    +    the buffer because `stack_filename()` does this for us already.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 7:  e82a68aecd !  7:  fbd9efa56d reftable/stack: fix stale lock when dying
    @@ reftable/stack.c: static int reftable_stack_init_addition(struct ref=
table_additi
      	}
      	if (st->config.default_permissions) {
     -		if (chmod(add->lock_file_name.buf, st->config.default_permissions) =
< 0) {
    -+		if (chmod(lock_file_name.buf, st->config.default_permissions) < 0) {
    ++		if (chmod(add->lock_file->filename.buf, st->config.default_permissi=
ons) < 0) {
      			err =3D REFTABLE_IO_ERROR;
      			goto done;
      		}
 8:  bab4fb93df =3D  8:  5598460b81 reftable/stack: fix use of unseeded ran=
domness
 9:  cbf77ec45a =3D  9:  79e0382603 reftable/merged: reuse buffer to comput=
e record keys
10:  c9a1405a9a =3D 10:  8574ad7635 reftable/block: introduce macro to init=
ialize `struct block_iter`
11:  02b11f3a80 =3D 11:  eeb6c35823 reftable/block: reuse buffer to compute=
 record keys

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
--=20
2.43.0


--pET5hpg3VaekS7HB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV20UwACgkQVbJhu7ck
PpRhng/+PgkWoJdYYzEQxHAIaico7nAdh/V0F5ByYNq4EOWww1TDtymXmVxKu48G
+wkHUhJhEQX+/+KIazwLCrwBbsW1ryf9J3lhMGkJAGEO2l212wakFkUgjYcHJfGE
kbzxqfMoiNtii/2nksVf7aanJvY2KL6sb6gdeDZL2CVnhjBPv1GdirXSSQElpFua
ZzMAtawVLUJE9s1ov2jpUS5B9acMdQRB/Z6x8nbZticOvVEzIF9Gn4o8HP/c7QJd
UxgctDOKFaE3RSpPThfpmH+1/awdVJNtpqPBeQ1C7H66P8oNEI5WNMwopdXXhXek
Babfw+97X25OXt3yKChMWZ0UrudVUB+EgVP3jJ9jBkBOK+VjHc3ilEqHjDIaarAG
YRHl12EvgiUqOqi6ccf1DnaKSXnajWMocQnmx7ri6keuGUGTteZfx0KufPcqa5uA
5nAqWl3U7TwSYEipD8BoZXIiXoT1iRP8yajuIB5fgG7A6Z6GgCuOSp11GZgbRbyh
WsIrWK03M0gxjyTp/esaq/q4Z4d+TzEV5R2AONECxjK1oDjKLfU5x7y1Rfc8Y21e
8Q1tphN9PQ/r6Ls6cQ6Py7xOXPIfardTCcmFkOQ2pBAIKdUDhNXNxCNzospxbBPf
CTdlU32p39yJI9gC+bb0+s0jpl/3W66g6jcK25vcTqdpV/Ceikg=
=GNcc
-----END PGP SIGNATURE-----

--pET5hpg3VaekS7HB--
