Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAJACN6I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8za/6Lu"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC015114
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 05:36:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 333755C0194;
	Thu, 14 Dec 2023 08:36:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 08:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702561018; x=1702647418; bh=kHCmtBRXOo
	gZtGHghCONnaGhwhgLaxUxLgxcAfvE7d0=; b=PAJACN6IatT060YGclb0Lha58v
	I2Ok7bbPlOoWkn5UaXB+4OizfKvl4A+XE7RJybaLTkw44YfIjb2tujiHt5dNKnky
	qW6GiZ2GGrL/WO0FsD4jPkp21hjRvOO7H8G0JEaDljCWTlwhwsAKr1cu4pVsb9ZL
	Y8RGJ1c9Ngk8kkGCtjKlan7LMx5T1IhSlhUFniYfCoKO8+dkx5LXc+zL6KaF9QeG
	Sli9ABnL1083LTIGh40NmTdk30kWtL4vCW7CTm2sSqRzzoG5pG435XHRp5y7jZXp
	2c5fqExMBDhPZQhrA/DJyxu39N+cyvAi4NTepQp/ZfIgoK6ayzn8ptXi7syA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702561018; x=1702647418; bh=kHCmtBRXOogZtGHghCONnaGhwhgL
	axUxLgxcAfvE7d0=; b=N8za/6LuCWmRaQdEw6lrLe0QU5zSUWYUGVb3mm8EmLoK
	vbnlTqzsqph0WY+4iHuo9Il1QlDKmGEHh/RmC3PhOxhZolbRE9gF0z5glq3IZZFS
	M9cki/eASPpwyPDq6swhJQyma/z248syQAnio3AP7f+9xVhriAQvzdmfgTcPW39S
	f5qzEdpXn57bbuBvM/EPAJKsKd4QVHNnsWdidNfSzRpzIKQhhP6aeSg9JH0tnXLm
	kPhnGL1H5heSqjgHspo+p9MoNLSgiw9Twu7bmQNB9rmg/DspE7kx1pla90dYbwgm
	NPQrbld0L85lkSjljHZS6MQVNIzsZW8YnAOuYRvbLg==
X-ME-Sender: <xms:-QR7ZTy3tNLQyQLYhDZSXQ62wMQKtiDWZhBL9im1wDuDaanbor4V7A>
    <xme:-QR7ZbQI2E49lCLuGyuLo_yqQuxaTl8Jktp4Kh1xsMGQw0_GxvGrZC1pWdZCwZ3Gm
    9_MtoQU1HWjbNIkOg>
X-ME-Received: <xmr:-QR7ZdXEHb8lt5-aC0mX6jMUiC4ICwrcdzqkfzMKpFDZTX_MKyfsP0ZSs9PdkyBaab-87nTTueeMbXSqWRsX1YOdLaRASy67uabEYEYiZSmOEV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-QR7ZdiYw42g4J3imYss9cf7U75c15qfFOii_ZPTtgkkD9cMPXig9w>
    <xmx:-QR7ZVDo_Yqirskk48tMG8kmz1JHVl7n5UjEtL_gYr8tgXp3LRvk8w>
    <xmx:-QR7ZWJmeleK8YWxeMTm9xX8X1rpH_KXeyPuOBhmBVolxdtwYEjDzA>
    <xmx:-gR7ZYOvX55s6M85p_t9sy5_uZOyYCV7QDZs9oj4VHVkco-_JSwR8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 08:36:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0be002b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 13:35:12 +0000 (UTC)
Date: Thu, 14 Dec 2023 14:36:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 0/4] refs: improve handling of special refs
Message-ID: <cover.1702560829.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TjMWxYxzcbVLGKrA"
Content-Disposition: inline
In-Reply-To: <cover.1701243201.git.ps@pks.im>


--TjMWxYxzcbVLGKrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to improve handling of
special refs.

Changes combpared to v2:

  - Patch 1: We're now more careful around missing and symbolic refs.

  - Patch 3: Document in the commit message that the extended list of
    special refs is not intended to stay like this forever.

Thanks for your reviews and the discussion!

Patrick

Patrick Steinhardt (4):
  wt-status: read HEAD and ORIG_HEAD via the refdb
  refs: propagate errno when reading special refs fails
  refs: complete list of special refs
  bisect: consistently write BISECT_EXPECTED_REV via the refdb

 bisect.c                    | 25 +++-------------
 builtin/bisect.c            |  8 ++---
 refs.c                      | 59 +++++++++++++++++++++++++++++++++++--
 t/t1403-show-ref.sh         | 10 +++++++
 t/t6030-bisect-porcelain.sh |  2 +-
 wt-status.c                 | 22 +++++++++-----
 6 files changed, 87 insertions(+), 39 deletions(-)

Range-diff against v2:
1:  1db3eb3945 ! 1:  aea9410bd9 wt-status: read HEAD and ORIG_HEAD via the =
refdb
    @@ Commit message
         via the refdb layer so that we'll also be compatible with alternate
         reference backends.
    =20
    -    Note that we pass `RESOLVE_REF_NO_RECURSE` to `read_ref_full()`. T=
his is
    -    because we didn't resolve symrefs before either, and in practice n=
one of
    -    the refs in "rebase-merge/" would be symbolic. We thus don't want =
to
    -    resolve symrefs with the new code either to retain the old behavio=
ur.
    +    There are some subtleties involved here:
    +
    +      - We pass `RESOLVE_REF_READING` so that a missing ref will cause
    +        `read_ref_full()` to return an error.
    +
    +      - We pass `RESOLVE_REF_NO_RECURSE` so that we do not try to reso=
lve
    +        symrefs. The old code didn't resolve symrefs either, and we on=
ly
    +        ever write object IDs into the refs in "rebase-merge/".
    +
    +      - In the same spirit we verify that successfully-read refs are n=
ot
    +        symbolic refs.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ wt-status.c: static char *read_line_from_git_path(const char *filena=
me)
     -	char *head, *orig_head, *rebase_amend, *rebase_orig_head;
     +	struct object_id head_oid, orig_head_oid;
     +	char *rebase_amend, *rebase_orig_head;
    ++	int head_flags, orig_head_flags;
     =20
      	if ((!s->amend && !s->nowarn && !s->workdir_dirty) ||
      	    !s->branch || strcmp(s->branch, "HEAD"))
    @@ wt-status.c: static char *read_line_from_git_path(const char *filena=
me)
     =20
     -	head =3D read_line_from_git_path("HEAD");
     -	orig_head =3D read_line_from_git_path("ORIG_HEAD");
    -+	if (read_ref_full("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL) ||
    -+	    read_ref_full("ORIG_HEAD", RESOLVE_REF_NO_RECURSE, &orig_head_oi=
d, NULL))
    ++	if (read_ref_full("HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECUR=
SE,
    ++			  &head_oid, &head_flags) ||
    ++	    read_ref_full("ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_=
RECURSE,
    ++			  &orig_head_oid, &orig_head_flags))
    ++		return 0;
    ++	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
     +		return 0;
     +
      	rebase_amend =3D read_line_from_git_path("rebase-merge/amend");
2:  24032a62e5 =3D 2:  455ab69177 refs: propagate errno when reading specia=
l refs fails
3:  3dd9089fd5 ! 3:  81ac092281 refs: complete list of special refs
    @@ Commit message
    =20
         We're already mostly good with regard to the first item, except for
         `BISECT_EXPECTED_REV` which will be addressed in a subsequent comm=
it.
    -    But the current list of special refs is missing a lot of refs that
    -    really should be treated specially. Right now, we only treat
    -    `FETCH_HEAD` and `MERGE_HEAD` specially here.
    +    But the current list of special refs is missing some refs that rea=
lly
    +    should be treated specially. Right now, we only treat `FETCH_HEAD`=
 and
    +    `MERGE_HEAD` specially here.
    =20
         Introduce a new function `is_special_ref()` that contains all curr=
ent
         instances of special refs to fix the reading path.
    =20
    +    Note that this is only a temporary measure where we record and rec=
tify
    +    the current state. Ideally, the list of special refs should in the=
 end
    +    only contain `FETCH_HEAD` and `MERGE_HEAD` again because they both=
 may
    +    reference multiple objects and can contain annotations, so they in=
deed
    +    are special.
    +
         Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
4:  4a4447a3f5 =3D 4:  3244678161 bisect: consistently write BISECT_EXPECTE=
D_REV via the refdb

base-commit: 1a87c842ece327d03d08096395969aca5e0a6996
--=20
2.43.GIT


--TjMWxYxzcbVLGKrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV7BPQACgkQVbJhu7ck
PpSGCw//QKq6Z6szfsD/VPWsuDG6pMJW07iiSn37DnCaIxGuq27070BX6IERyTN3
juQCBBqSfWHJAvyh/gj6/2wrHHnZQk7XlWodxo7nnPpBDIS85qd/aZT3yhFW5yD5
XZ/VkN0mJy4q3QaTNE7nGZBoGKTQXG0h/9jxeRj0ttDDk24QPEEO6HJdKhfNFJPg
Zl4A3I2hYnDLuGuUs23LLg8tAyI7y9lxYegUnCvzqneaplIbeWNSa3iWSlaNTOKu
ZpXD5WQfLyJegkKGRm2hIMQeEe5weMMnRQm3ckBJaGVN4PhToH6V+REYV8yM6hqO
pR9JxgWkaFBKAjA1x62gCzqin7UzC2yULX043I5rHK1m9XjLeDzQvTxqLQb3VwPj
hvbIh1AzFgv5qmwDMJoxpXCub4gIyMBFovyA2h/6ipDl7v/tzvsYKKZ6QWYBHuDc
SH0B9kJR3VWEono1Wg06Ux3syFlGEO4NBbZRzQgAZjGmAcdgmXGPu3J1JG2f2IsK
cFBKCOsgomSNMlCfCIoWWzlaxkjXQOmmRb3ZvhgudmaTVlkQBuZOCPI7siDU4+yZ
iP77FlZLavt+3mDskfDd7rooA3PymXNES/qpi/4SygEcCSmPMMRBxcdwOH+YsFG5
IiEu9tZjGE4H563QvOU16n6pXNbOVam1zLMJx0prf5VpH4R+7P0=
=lYDv
-----END PGP SIGNATURE-----

--TjMWxYxzcbVLGKrA--
