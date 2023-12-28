Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FD3C0B
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQpnwv0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o6Im1uIS"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 681CD5C003B;
	Thu, 28 Dec 2023 01:27:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Dec 2023 01:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744857; x=1703831257; bh=LGS65O0evW
	0UkviqATnbY7DZf9s1J627nudWJVhjg/I=; b=mQpnwv0kOGQZxX48N2q1kpZ12r
	4uLxnkx1qWzAIbHWaOorCTvl4ZpW+B4qq9FG/LbD8Rg1lEnmrSZymSEBMSV+78Ji
	goQWsv13cVLWtGuHYiqEFLDIZA8rw1jeiWV593xRpAhWuF+h0Qedw/+iwSruDBYb
	hKh03l32aKhClMm6Lj7O1bykWItFO3TZw382E3tRHlL0Lnxp7QCMoyA08boUhHZf
	xGbc8+bMg+FyP/c5oH2fi1jOT0czg/8rnqTe/4e4vSv9UoxzoIGZ/DYTO4MdbaGb
	0ZxGEWFeTnQpPkgxD9zOQozgxyoWmKb0aPv7ZUxL4C9d2nDcZp0J6u/nax2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744857; x=1703831257; bh=LGS65O0evW0UkviqATnbY7DZf9s1
	J627nudWJVhjg/I=; b=o6Im1uISqSLwRBLODh3akWnpijRO+M4APf/1RdNv0eNI
	TlOe3tsG1DByBQiAT2ABvnfUMFGueY0ndBKnRiFpwtZpHs7R23laa8q069HkZ/7I
	pwyndCIipthunZuCDv1dN9XGd6LAvd/RHkl1zLHnXNJxG20bpxduUtDpsanhn3Vh
	SYDTlzYHyZXDa/KeKtADtMuAtqeChUtafPIj8YxGUMXn13Zm1HF5hWxE2N2wxBHf
	IaUWyBoVUE/pgIrvUelWfOpAeKhXZjSaDCgQgovhIKrKMCnVpU4QM1wnUCM5lT8d
	rrIzbg9qHKc6a4WjndDocLH7um5VLvn2QnqdhW35Qw==
X-ME-Sender: <xms:WRWNZRhKmNz9lzzG7kplVgDrghOWwlo9lPX_0wij3yAmdg08xavUVA>
    <xme:WRWNZWA4fyU6aomNW-xByz5sZUqhG5IE2mQU_8VFGX2OdX076KIfpB_LQLOrCrtvf
    6mWr5EX-U5gMAjcyg>
X-ME-Received: <xmr:WRWNZRGZsXOhB0hpCvUwFbwY7o5U3uxBVHFjkfwPscVpBC_-n7hHnDXrxAOIcGiDRNMiQA5qFg8D7BhObl-1NjEGQT43dMCUYD1htb6R_LsniA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WRWNZWTesvAznDY-fERBjYdhf5IzpvTdx0m3OyFxVQgw87wBK2bKMA>
    <xmx:WRWNZexMaigLEBOOnh-TjWv4rASahGCC782rvJy8oFMaInN27l4_AQ>
    <xmx:WRWNZc5k1ciiKPXuumJKZMwqGYqQKkFYUarpY_a7EnmKw58nyF3plg>
    <xmx:WRWNZTrS-XoOxzSahVC__pmUGLvuBDPI31y8fSh4lyhpBduybj4QAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d540bc50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:21 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/8] reftable: fixes and optimizations (pt.2)
Message-ID: <cover.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ApRt7Qy+GuBwAOv"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--2ApRt7Qy+GuBwAOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that contains additional
fixes and optimizations for the reftable library. Changes compared to
v1:

  - Added a patch to not auto-compact twice in `reftable_stack_add()`,
    reported by Han-Wen.

  - Fixed an issue I've previously introduced while rebasing the patch
    series.

  - Fixed a missing header, as reported by Junio.

Due to the added patch that avoids double auto-compaction this patch
series now depends on 637e34a783 (Merge branch 'ps/reftable-fixes',
2023-12-27).

Patrick

Patrick Steinhardt (8):
  reftable/stack: do not overwrite errors when compacting
  reftable/stack: do not auto-compact twice in `reftable_stack_add()`
  reftable/writer: fix index corruption when writing multiple indices
  reftable/record: constify some parts of the interface
  reftable/record: store "val1" hashes as static arrays
  reftable/record: store "val2" hashes as static arrays
  reftable/merged: really reuse buffers to compute record keys
  reftable/merged: transfer ownership of records when iterating

 reftable/block_test.c      |   4 +-
 reftable/merged.c          |   8 +--
 reftable/merged_test.c     |  16 +++---
 reftable/readwrite_test.c  | 102 +++++++++++++++++++++++++++++++------
 reftable/record.c          |  17 ++-----
 reftable/record_test.c     |   5 --
 reftable/reftable-record.h |  11 ++--
 reftable/stack.c           |  23 +++------
 reftable/stack_test.c      |   2 -
 reftable/writer.c          |   4 +-
 10 files changed, 117 insertions(+), 75 deletions(-)

Range-diff against v1:
1:  573fb2c4fb =3D 1:  22a57020c6 reftable/stack: do not overwrite errors w=
hen compacting
-:  ---------- > 2:  a08f7efc99 reftable/stack: do not auto-compact twice i=
n `reftable_stack_add()`
2:  86ee79c48d =3D 3:  c00e08d97f reftable/writer: fix index corruption whe=
n writing multiple indices
3:  3ad4a0e5b9 =3D 4:  3416268087 reftable/record: constify some parts of t=
he interface
4:  06c9eab678 ! 5:  46ca3a37f8 reftable/record: store "val1" hashes as sta=
tic arrays
    @@ reftable/readwrite_test.c: static void test_write_object_id_length(v=
oid)
      	};
      	int err;
      	int i;
    +@@ reftable/readwrite_test.c: static void test_write_multiple_indices(=
void)
    + 	writer =3D reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
    + 	reftable_writer_set_limits(writer, 1, 1);
    + 	for (i =3D 0; i < 100; i++) {
    +-		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
    + 		struct reftable_ref_record ref =3D {
    + 			.update_index =3D 1,
    + 			.value_type =3D REFTABLE_REF_VAL1,
    +-			.value.val1 =3D hash,
    ++			.value.val1 =3D {i},
    + 		};
    +=20
    + 		strbuf_reset(&buf);
    =20
      ## reftable/record.c ##
     @@ reftable/record.c: static void reftable_ref_record_copy_from(void *=
rec, const void *src_rec,
    @@ reftable/record_test.c: static void test_reftable_ref_record_roundtr=
ip(void)
      		case REFTABLE_REF_VAL2:
    =20
      ## reftable/reftable-record.h ##
    +@@ reftable/reftable-record.h: license that can be found in the LICENS=
E file or at
    + #ifndef REFTABLE_RECORD_H
    + #define REFTABLE_RECORD_H
    +=20
    ++#include "hash-ll.h"
    + #include <stdint.h>
    +=20
    + /*
     @@ reftable/reftable-record.h: struct reftable_ref_record {
      #define REFTABLE_NR_REF_VALUETYPES 4
      	} value_type;
5:  49f13c123f =3D 6:  c8a36917b1 reftable/record: store "val2" hashes as s=
tatic arrays
6:  32b7ddee28 =3D 7:  6313f8affd reftable/merged: really reuse buffers to =
compute record keys
7:  3dbabea22a =3D 8:  25a3919e58 reftable/merged: transfer ownership of re=
cords when iterating

--=20
2.43.GIT


--2ApRt7Qy+GuBwAOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFVMACgkQVbJhu7ck
PpRiDw/9Hk4NqTxLY+x95iqn7IGcvNJzW6MRDmBhtHLtTiy4QeXhZhSniuXv1gTa
VK7rr1U/ptdw+kY+otY6zdVThxhfaGYTe4OLg+Mp5SS812kqdMOyLDdqi2Ci8/QS
4HBkVFDHwgUR7JVhhuERTZpuRHVTPkWgI7Zms1l7X+v/yYVk/JtT+iHq3yo62Ofl
zyBcxVs87SNJAkqFkBJd2pZ5vBr+09epQwnwTIVtPprSfGV5DaMCOS54ROo5Dxy2
s4/PXVhFoOdwkzzjFqDKhy+7IyBU0mIHSFj+B9T4Oog8e2yeDP0TCL4VyJ1y2bfY
UxxFWlYSCllwmeHhoEPBv5uL8Eim6m6yrqgWf55quIC8ckb9qcBMjkEo8YiCwCwF
GJSPbuU04RPOwxWgCzTAgkCnlQioD7EAdBRRB7pJgqiuTz+2s6dpUfBP3vP77ILZ
oCHoeNLe9vU+DuAuofgCWzagQtcdRW1X6g/pERP1LkqJ0we0Yxjf9UIQeAVH64e7
PvgI0uRcW7uVUwJFZ9fAtelKVc+k2i8+xPmO4FnfSRjZESLRZYG5ipAEsaJRATQN
Rb1EBVKDEdigwQzcFR8QhxuU9UOKYuzR26N8vRIHejCyRaNmor2I4jG3IBtsMZhn
XzkoW2sRgf3LnHRJ71iocp4L5qawmAKipy/1rCwy1sHb8uHIFaY=
=k1/w
-----END PGP SIGNATURE-----

--2ApRt7Qy+GuBwAOv--
