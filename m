Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052392AB2C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LSu/kLLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d1JEESUT"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13FD9D
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:57:05 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id DD96132009FB;
	Thu, 26 Oct 2023 05:57:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Oct 2023 05:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314224; x=1698400624; bh=3O
	8z3KuuDmwSmlLeG4kB6BOGHumzN+SakJtG5c6mPxw=; b=LSu/kLLjGJTm6ny43k
	vEcoHYLxKn3li6JyxmKKpinkF4c8s4HAyOeNtIwCDJPerNTsMvkmol8iMwuKlX9b
	r8svnscJb02mrZFK9wHGIsqmWuj4zokG4oABgFwI1pQKBrJucHx65rFW0SHEXXRc
	c8s7nnTw8KkYOzZh0MbuljjeGskPCx0LKxOK7VVrWvLkYM7CTUpugkjPh6SQOc0K
	9vtTw6Q65zFuigoFaq6cpwRgFM3cnFExBJndRIH/zjwhZzH84dmcHeKnwmq7bQdn
	TncmbCImlMXqSQJjt/DO8isV9zeEnMykoIXKu32YUpYsDTMpruq+JrYgBkNr+F8C
	g/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314224; x=1698400624; bh=3O8z3KuuDmwSm
	lLeG4kB6BOGHumzN+SakJtG5c6mPxw=; b=d1JEESUTEnucBLVo8LnnMT7ve4fgu
	FbnvNfzaDMyXjRxy0GezwTWNdml8JsGXDSEe2IkVKV9CgkjNNlMCFGorzaQBCOU3
	PpOEPRzvRSXnNQLii/8y/UM+/nXPRTaR2X8F44Z6GR6aEuXD/V0SdRWIJFsYBhJg
	AszPGixZliO0x2h0evUgnf29/RhdyXkpdJl4hyFccabFp/Y1tWwXw5cSvxGdH21P
	Y6kN+ULP31PhJ7/uOLWHhxJjV1judeh1Az3nTf/nprOZXLMaWlxryg/V4Eua5U/s
	ibg3HQSPqzD90BtYmGWKRGja7ZvRrAoZ+zmJfTDaW+8v1aWWThnT7wqBQ==
X-ME-Sender: <xms:8Dc6ZRWJTNBg037JF86xgkezN8FNZQ-kYvd3N6jbvaSohRUm29T0Eg>
    <xme:8Dc6ZRlYEVEmngzUZF1oqzoXX9iS88124wrs-sFEcMuW_EWdl20KiW0jgkwN6c6wd
    6dYYFs4IRn1s0dmeg>
X-ME-Received: <xmr:8Dc6ZdZQ9fUTZeDvm11bM8GhHjX-uNyzl2N477KSBF1Xwl3tjl8Spbn-pJljw-C1ipwqaLmg5RBNA-L3oKlQfuPsyzf93l-uP4Gl-v4_qpHJHOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:8Dc6ZUUbP34CvzxOkidXOpA7tALf9GcuA8EXjbuFTUrXOb-KJP7TrQ>
    <xmx:8Dc6ZblePqmv_zIfQumhtQ2U8wT70KAUToAfTGMF0mDpUgJf1u8hmA>
    <xmx:8Dc6ZRcnG1paF2bxFWP1Zxv3WyHklOhahc1tv3xsNQVOEELUzS1IHw>
    <xmx:8Dc6ZQwqZ-JaFTvhX9LJQ3T5tzZWVyQenmugJxengPMfyqd-UrBcHA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:57:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 210335e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:54 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:57:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 10/12] builtin/show-ref: explicitly spell out different
 modes in synopsis
Message-ID: <b78ccc5f69297fec7807c077ccdcf722ee12edf3.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gPZfI4gGQU9CvpwY"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--gPZfI4gGQU9CvpwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The synopsis treats the `--verify` and the implicit mode the same. They
are slightly different though:

    - They accept different sets of flags.

    - The implicit mode accepts patterns while the `--verify` mode
      accepts references.

Split up the synopsis for these two modes such that we can disambiguate
those differences.

While at it, drop "--quiet" from the pattern mode's synopsis. It does
not make a lot of sense to list patterns, but squelch the listing output
itself. The description for "--quiet" is adapted accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-show-ref.txt | 9 ++++++---
 builtin/show-ref.c             | 5 ++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2fe274b8faa..22f5ebc6a92 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,9 +8,12 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
+'git show-ref' [--head] [-d | --dereference]
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
+'git show-ref' --verify [-q | --quiet] [-d | --dereference]
+	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
+	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=3D<pattern>]
=20
 DESCRIPTION
@@ -70,8 +73,8 @@ OPTIONS
 -q::
 --quiet::
=20
-	Do not print any results to stdout. When combined with `--verify`, this
-	can be used to silently check if a reference exists.
+	Do not print any results to stdout. Can be used with `--verify` to
+	silently check if a reference exists.
=20
 --exclude-existing[=3D<pattern>]::
=20
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1768aef77b3..d4561d7ce1f 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -11,9 +11,12 @@
 #include "parse-options.h"
=20
 static const char * const show_ref_usage[] =3D {
-	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference]\=
n"
+	N_("git show-ref [--head] [-d | --dereference]\n"
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]\n"
 	   "             [--heads] [--] [<pattern>...]"),
+	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
+	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
+	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=3D<pattern>]"),
 	NULL
 };
--=20
2.42.0


--gPZfI4gGQU9CvpwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N+wACgkQVbJhu7ck
PpSDYQ//SLjr9Lq2Wt1PIN5E9H+EynteVzcUmY9WsdiCMVcGFiZvO3e8Jf5bX4A2
vw0FW3frXkttl/LZSc/vMY/KvxUgiK4x0iBwz85OPMACD6SWEFOBnCoPdp1eLR4o
sC1sKno8HunHdgHdIkMR9pBJfOZZe6bgkhZZLqopekEp5jfvZ1bLgyp2DmN4ACn0
v+9uviyTD1n53ITxDm9I/sNHOHUJm/F/v0JClI2Y8Rm93Xmd9D4yyVG1pk0KzaTO
zkk37776pofXa0s/RYQDuD7IA7FiZ1+o8fVk30A7zm89NEXbDVMT0cz0pT4zLMFB
eJ0PxoBbJoVqqz/ktJEgh4J8uebMfn7hd9uT90BDDTU+gd7A5wRMURaw2YKxgY2h
s6b+apLaLXanPYkIy7QfVzFHiNEj3Xi8sSDl+BQmMG2ld6yO85RYr1qdP/+sH/2s
diskDuVMpx0+DtPvPHfhspFWdhK79tuKeOttypJZTaJqiS4vi3bgzJbPkcVo5bCh
XCShALtrpQMSdRgOUS6Qq6MMenk/rcKKBRYDelKWJj4UrKrX6bLAq3FHv6CAuKjm
U8oCVJXufjXAFg1xiLrkvCnwUUZ7Grj5oN4i6Q8R7yXptPlm4lD0fWW+L/agATtl
LmxYswf1RAtdjEV2RtM+4Wbh/yJ5ujzHVRotWLLNYt04xM9u974=
=LUn5
-----END PGP SIGNATURE-----

--gPZfI4gGQU9CvpwY--
