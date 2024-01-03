Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54717998
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NPZh+oNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ltzz9qel"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4BDD25C019A;
	Wed,  3 Jan 2024 01:22:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 01:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704262933; x=1704349333; bh=OWb/LKHNxU
	hBEsaFbJkRcMU8i7jJwRwufCiKMNc20p0=; b=NPZh+oNlkCk1iB/zA8ce25Xqcm
	es5Xr/BG7Ms8hEvga3evHArJ8fl+WkfS2/F4NUL1Bt9UA6CbQlYYzenNFPvK3zeT
	zPnhSdY6LScZyIlZ83ESEu1uQLqA+JTFFyREwe8ugLnLrEnBTkQ+UVcjXrR5E4dm
	Op4E7B9EmAgoDe5VTX5/rWfvYCjuKAlY7n0fsqCHtWBuFtsLBqM5Vn5cm82EVtio
	2i7cLO/vU1mD4Qw5qb/FPdqvpF4nMiEt3tDweeAoFxgP1w3IPVsTZpANcRAsL+GE
	wr8LVpD1ysKHHIe0zDKX6Zo35XgOxkoPRNViacO/AmqJPgNv7UjRCA/Oy2qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704262933; x=1704349333; bh=OWb/LKHNxUhBEsaFbJkRcMU8i7jJ
	wRwufCiKMNc20p0=; b=ltzz9qelZ51AYqXtVVrhGdvZQNbkl6bJNPx6lsYgQ2Nb
	9fSNtY/6K80OHgmqQO6Apuv737UWp1WocEg8Bz7kLRxpBcLfZq0d0SN0+LVZsv5A
	guFr6mevXEVtnRnzvL0iSZdz9YaICxXHXBTp2U4Uh2AmpfWOXzSsyAcinyDrKH3D
	GQWp6QP7bgZ9CfbHIWfEHn9kFNrEUYk8+KdX8cZO5vvuRjPsxUA4pSc4+Wpq3RPK
	wryK3J4dl5fl44K+zuaoC9UuBUhh1+VeZqQHCxkkpPnAORdHppc38K4t59ebVCJF
	7xYSLstSsEKXgwjBhw8IW8Z1rApwniqIENu8A1/N6w==
X-ME-Sender: <xms:Ff2UZZ6lCdfW60G-lCT7-uIzQkSmm4hKpDRQvu7w0JARdtNl8fb8eg>
    <xme:Ff2UZW6UhTMAjK7CFHsawyxZwzfVVbrGGabAxmjqazug9T0wVTZaQJSAfd6RAr7CU
    LDPrH7nOKgNBZKCeQ>
X-ME-Received: <xmr:Ff2UZQdfAyS094rnccHpdS4177pNvdWF6-DzncTnabaqjTYuwAMxegH_BVRGqROLwn0YZNQVIySvDt_OE1bxcZqa2dwTpvR8wzQODX8nprv5NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Ff2UZSIsJ06XwrHjDMtWQNA9p6zWNBy6_CgTeIvEdq_YjSDyTWb2ew>
    <xmx:Ff2UZdIa8N-IFtlaQXXPyDFwrihaDvv_T5P7P_9aoSsoLXgf3TcOBg>
    <xmx:Ff2UZbyz0md8rCGz-BitTfb30wr19dVnuuVs3XTFyqVgXoTgPf3ryA>
    <xmx:Ff2UZbjZtgF0uYXhXf0cna1pwn-lZsiTQIY_rQcoVBFUGSuSCuyIUw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 01:22:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 283d0736 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 06:19:45 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:22:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] reftable: fixes and optimizations (pt.2)
Message-ID: <cover.1704262787.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RD10emaqQqoeRaXJ"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--RD10emaqQqoeRaXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that contains additional
fixes and optimizations for the reftable library.

The only changes in this iteration are improvements to the commit
messages to hopefully make them easier to understand. Thanks Junio for
your suggestions!

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

Range-diff against v2:
1:  22a57020c6 =3D 1:  1dc8ddf04a reftable/stack: do not overwrite errors w=
hen compacting
2:  a08f7efc99 =3D 2:  eccc34a4b6 reftable/stack: do not auto-compact twice=
 in `reftable_stack_add()`
3:  c00e08d97f =3D 3:  15e12b8f29 reftable/writer: fix index corruption whe=
n writing multiple indices
4:  3416268087 =3D 4:  017e8943c7 reftable/record: constify some parts of t=
he interface
5:  46ca3a37f8 ! 5:  f1d2190489 reftable/record: store "val1" hashes as sta=
tic arrays
    @@ Metadata
      ## Commit message ##
         reftable/record: store "val1" hashes as static arrays
    =20
    -    When reading ref records of type "val1" we store its object ID in =
an
    +    When reading ref records of type "val1", we store its object ID in=
 an
         allocated array. This results in an additional allocation for every
         single ref record we read, which is rather inefficient especially =
when
         iterating over refs.
    =20
    -    Refactor the code to instead use a static array of `GIT_MAX_RAWSZ`
    +    Refactor the code to instead use an embedded array of `GIT_MAX_RAW=
SZ`
         bytes. While this means that `struct ref_record` is bigger now, we
         typically do not store all refs in an array anyway and instead only
         handle a limited number of records at the same point in time.
6:  c8a36917b1 =3D 6:  6ec02d6775 reftable/record: store "val2" hashes as s=
tatic arrays
7:  6313f8affd ! 7:  845dec2390 reftable/merged: really reuse buffers to co=
mpute record keys
    @@ Commit message
         reftable/merged: really reuse buffers to compute record keys
    =20
         In 829231dc20 (reftable/merged: reuse buffer to compute record key=
s,
    -    2023-12-11), we have refactored the merged iterator to reuse a set=
 of
    -    buffers that it would otherwise have to reallocate on every single
    -    iteration. Unfortunately, there was a brown-paper-bag-style bug he=
re as
    -    we continue to release these buffers after the iteration, and thus=
 we
    -    have essentially gained nothing.
    +    2023-12-11), we have refactored the merged iterator to reuse a pai=
r of
    +    long-living strbufs by relying on the fact that `reftable_record_k=
ey()`
    +    tries to reuse already allocated strbufs by calling `strbuf_reset(=
)`,
    +    which should give us significantly fewer reallocations compared to=
 the
    +    old code that used on-stack strbufs that are allocated for each and
    +    every iteration. Unfortunately, we called `strbuf_release()` on th=
ese
    +    long-living strbufs that we meant to reuse on each iteration, defe=
ating
    +    the optimization.
    =20
         Fix this performance issue by not releasing those buffers on itera=
tion
         anymore, where we instead rely on `merged_iter_close()` to release=
 the
8:  25a3919e58 ! 8:  eea0e161ad reftable/merged: transfer ownership of reco=
rds when iterating
    @@ Metadata
      ## Commit message ##
         reftable/merged: transfer ownership of records when iterating
    =20
    -    When iterating over recods with the merged iterator we put the rec=
ords
    +    When iterating over records with the merged iterator we put the re=
cords
         into a priority queue before yielding them to the caller. This mea=
ns
         that we need to allocate the contents of these records before we c=
an
         pass them over to the caller.

base-commit: a26002b62827b89a19b1084bd75d9371d565d03c
--=20
2.43.GIT


--RD10emaqQqoeRaXJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWU/RAACgkQVbJhu7ck
PpTzhg/42qCx1wtnCoKsIzGA8vs6DOWZg5JxtnlPt+4FZoGflS69ZK2q+Qe/WQi4
1ODO9kHXWYW4zb0fVwpDaSxeuGruHQNicGKlhHmjenjziqvKZxrfGUtf214eGdT8
8/7nkmqnRlFjdno6wNPjOG4+yHzQSQeXtF34jff/evK8hyC+hOeY7+BkFQrQ4AQh
gnkBT7fu33S2yzTM86HLzl5+NBRZe2gAGcZ/CpANrXVH9mGAJS3cXLa2A/a9d6Eh
jWxlPrgW0oCPKRK7voIXROU9f+L3YBJoLjX9wFvFMOz2bDofj9K3PfuuEQZtg9ov
M3gUXi3ZHDWRtR7Z14yISrjpYcG7ywbSqt3wvWYx7WTFpz/A58G8XNXC+DCjSRtG
7Nr2TKZ4o2bdiiN5f8adS7/nPo+VaoA7H+KBglOBCkgX9eIO+tQkON3RpD/rvha5
UD+GKex7s8qrK32YWF7oYSm263vTW7O1Q0JoMI9tMYMPq1G2wVB6XXH3/6N+mQkU
TArTf4lKP8AcxCNyoadJ31u8sNdR06odHfUVOi/KnbTlx3KLizV8uGwIDVnDX1Su
ORqgHkxaw9mvCjc1h6EcbAU9dr97Fz9oMczaYiT6+7JL2fWe6ukVL5zyuPNyR1sI
UxDchwc0BEqQyp0tBJ+ortqEZheMnGq7uKKmDb5uDlYfwrTpWQ==
=Z7H9
-----END PGP SIGNATURE-----

--RD10emaqQqoeRaXJ--
