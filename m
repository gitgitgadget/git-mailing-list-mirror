Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEA416416
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ilJNTW5O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oybTNi+u"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F0101
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:50 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id ED8343200905;
	Tue, 31 Oct 2023 04:16:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 31 Oct 2023 04:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740209; x=1698826609; bh=tN
	uoL2m1MK9WCTiJcmvgSQA4ZV6iS9p9QUld3mXh+fM=; b=ilJNTW5O83Sdu9McEr
	MSV1bnKLkdQsKnv8OiRUn0Nk76P7fcJxRnlTEBfjd+V30OvzMfHm15tPobDbn02d
	2tkp/N5OUu4MxwSQKhq6NHHQeVZVEKCybUfF2jQNUKVNz55lFiwMop28Aa8awnTW
	bxJxro9AH4N5BxPALUhJJvgU/HmAIjGY/0fn6PDFyzPpvZU6JqU7wZeuqMuHADbo
	ZXOP1zjTW4jGSs9g1jb+moiy3S6mvD5Rwhz5EUGqsvqTgPoNVzNktfNI8wVsGGTw
	0HV9b+sns8mNHyAZX8i0HFIFD7cUavwM2JyXj1xQ9OCL/L8Q1w3OxmH0cfGAGx/r
	KOMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740209; x=1698826609; bh=tNuoL2m1MK9WC
	TiJcmvgSQA4ZV6iS9p9QUld3mXh+fM=; b=oybTNi+u+KRTRqiZdGgotZj5kMlbl
	BgpKWTuFodZniY1SAPYs9Zy8EvM8met7qVkFtP7rNK8PXV2/rg8Ia8ZXTOh8n9lW
	Eglz4JDfjbD3opffSYcqQxr/TEnZ8hqwf61/uYqJxEFH5id97gbu8Mf0vbeaCO43
	IFbhTeTd2A6OfQsTbeLQFmmzcgfR+kSQJyajiNhNT+SbG9xZ67kqXougyskel/uI
	7jA5NRkAYs6viOFDSXu4iVeg+haPiLJZgEBwEJWYRwe6k21+lmZUT5ZpMKoAJohM
	fK3XNnJb8UkPhkbv8UCeo/sqdRFQkQLd7o+wlUgOj2bkKfXaViNmdyosg==
X-ME-Sender: <xms:8bdAZeZT_gn2A1bgpSDO8jjUxCXyqObd6dDITpN2-8KcDve_cuP1-A>
    <xme:8bdAZRZ5qNSrMYHOXrkRJXbb1qHIc9TwBIc3vqTxum7TZy13GB6zsVuLPHPllNQ-j
    8_n0jNDMBR7wfyDtA>
X-ME-Received: <xmr:8bdAZY-qLZScoZJj8ccmBKIluv2AEL3t36dAVhr6xSpU6oYUl5XJP_aVVgqDqUs0ksqlKBSOsP2eIqX13x2JqrABz6KogQrxe_AshYp9G4YIHOOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:8bdAZQqFZaGoixMOG4S7kLNLCNzzElZWJgdTWqgxgUiOOWe7UAyZhg>
    <xmx:8bdAZZplPHsAzp2DP9yV8oklS-N9WV2HL0XFqBxhs3-tnBDwgMwZTg>
    <xmx:8bdAZeQ63nKLvu1ZaIesIpokhbZsqxy2swMw2--JcPFviqXhxtUxfA>
    <xmx:8bdAZQWZ1dleGquBnGqKXcvjmlDjWIBcIsmJRBnBDsFyp8BBdp91kg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ece1f67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:40 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 09/12] builtin/show-ref: ensure mutual exclusiveness of
 subcommands
Message-ID: <a095decd7783fa55299903608d306f09388d1d86.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y6j95a11wQOz5eAq"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--Y6j95a11wQOz5eAq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-show-ref(1) command has three different modes, of which one is
implicit and the other two can be chosen explicitly by passing a flag.
But while these modes are standalone and cause us to execute completely
separate code paths, we gladly accept the case where a user asks for
both `--exclude-existing` and `--verify` at the same time even though it
is not obvious what will happen. Spoiler: we ignore `--verify` and
execute the `--exclude-existing` mode.

Let's explicitly detect this invalid usage and die in case both modes
were requested.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c  | 4 ++++
 t/t1403-show-ref.sh | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 36ac10551da..6685495dd2c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -275,6 +275,10 @@ int cmd_show_ref(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
+	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
+		die(_("only one of '%s' or '%s' can be given"),
+		    "--exclude-existing", "--verify");
+
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 9252a581abf..f1e0388324e 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -196,4 +196,13 @@ test_expect_success 'show-ref --verify with dangling r=
ef' '
 	)
 '
=20
+test_expect_success 'show-ref sub-modes are mutually exclusive' '
+	cat >expect <<-EOF &&
+	fatal: only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} can=
 be given
+	EOF
+
+	test_must_fail git show-ref --verify --exclude-existing 2>err &&
+	test_cmp expect err
+'
+
 test_done
--=20
2.42.0


--Y6j95a11wQOz5eAq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt+0ACgkQVbJhu7ck
PpR4mw/+MM0nPuS5LLjWW7wSjiSuez6jDh0SiSmNektKDizJnWETOP0KHTMZP4zf
nkjB/hxZMXYNUkiEjqbi+EuO1amnsk/uMKKitwjWXn53k4uhFHAtdaJ0dIOg7c5x
+v5XHJFBX+L4X+tGxSEMFej+4elsTWnNoA0HG9tZPxYEiW7BekoicK9P39pSzgWa
FH4KA/y45QVa29cy6ZLrr3NRuIX2++Ws31L6kq7AV2eeAoreqIczzdgVPQIikTPZ
l3HL8wj0Ye4QOjEoEM6L7y389X1KzJHRM6hEy1sL8yXI9HpspaSkiRYhgIWMjJCo
NlF1xhebSmeG9Hn2DR5K4xo8hvb4tqUEKcfJGS490VEoqADtNBEvPDuuJpgnjZ5l
cbWbjmMSX4l3P5NR8d4PP7pMUNHNUJdOnUJKcTLwt3jxyzXd0rnqStmcpYT6Se9B
J7Jmj7ErLNuJXdzHwF0tIKaibdOlrA9WqMgtMZNfFFOOln54Mg4wz0Ut9iGf+P45
EWXftfbHP/tXaTValowvPQNSkTAXl0sSTtqZKAATuY/BlZyYoKQVtYDbyHhiBeGg
6JzR+xvvjETUQLpyc+FgrXjvhWqb6PXSDp2XJoPPngWE2CE3pAkW7+SOfB0uQlxT
tNio38FC1uZHEkl2UXDg8zyoK0ALI92D1ItAbgKyHMa5LgW5ql4=
=sRQA
-----END PGP SIGNATURE-----

--Y6j95a11wQOz5eAq--
