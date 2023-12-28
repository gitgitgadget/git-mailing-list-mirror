Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4263C5
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 06:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ubbrn7Za";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lWH1/1JI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E4A065C010E;
	Thu, 28 Dec 2023 01:27:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 01:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703744863; x=1703831263; bh=zMVDAjSy4+
	GwA5SiHU6w4XlD+kYIrOWe6A88bZoeHtQ=; b=ubbrn7Za+2hPZMSFTmYfRcQ5Wv
	IablxBZMSs9qOG56KDz59MTrAXleLPh2QrT5dV8jO7iCKWSnhkdXE+Ad67ZiZsPV
	pAwOR7uhk68gfChm+U/dvdVELIwIMFYs0y9qW2ZpTdSDRfG0IEOhadwkCIUsrCog
	uaGk4iRPk2fPRiEeSXoNEdS8/R0Q9tEnipi0LXcTHv7t2DDCQARL0z5JaMPScKdh
	Z3g3KxUO684PZBsvOtbA5KVf+KHcanE/pR55n1DncOlZGIzWym+DxcGadzr24Tdr
	ymxZyPq0D8+4DCYeGjbueDEnM8l52xLzWauge0jA3l47+sATo4ehLRxBBuLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703744863; x=1703831263; bh=zMVDAjSy4+GwA5SiHU6w4XlD+kYI
	rOWe6A88bZoeHtQ=; b=lWH1/1JI1Ijz8l/TRCXTFDwK9CZzPqOZ2uqW1hRD31Jl
	G62RPen+0Yh6KuPVYc2ayp/WWdvmO2ojZvl+c/Uk56m6l4EJDIcyFVX8AGtKlP5m
	qpvtW4ppvoc1UIodDleMInWutdG5jDhlv/29yT+FD8c9Um2C8h5BafQzpEek6OZU
	HCeA55BRrrwOkAPwFlcUUalcGFPYMJ4IyxWeCTSkWOfxXAYC+2SuPgXWMdZzBg+l
	/e5zSSgSlC+1LPhznrrQ5EC/in2zjPhllYKx/YmpCtAjzgi/XRLrXNWR+EIpCEBY
	baUCw+5eGN85/NC8cI2TDVxpZutVMfUMyt7zfaU68w==
X-ME-Sender: <xms:XxWNZaBz9V0d5ADXFkgD48voUt6vz67cq3zco-tStlIti1KQGG880g>
    <xme:XxWNZUgX2iYT6dZF5tPlsi9GVNFUVzXHeobkywuV0DJj2gMuhyB8U4buH-oq2M1ge
    hc1YC8rcpSGmFwIUQ>
X-ME-Received: <xmr:XxWNZdnxhlnO613qTNHxPvl3kDohwRXAvsNUYrkS1zjxXU1NZax_FdUpPxMgrpPs-pIL0OKAQ0oYV2hSHoiGtk9Cbh--trOm9xmmGtZ9AaTfqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XxWNZYxbrcL7cXpE298kyAlfRSD0dQsKnHDWXzZNKGl02jDHuhhQ8A>
    <xmx:XxWNZfSGY626rd0Kn3B8utjoa1TUtuaS5X9Py5mTkqQpXRaoJqFvyw>
    <xmx:XxWNZTZKdsAiZ9Frg9X2GWySbrHRsg3fhslyl0Rp1SWzU8KXh7D-Ig>
    <xmx:XxWNZWLMxw7zHxVkaehr9L9sKjNEn3kBFHAhWf6BhiVL98Elhhvcvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 01:27:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fd2e268 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 06:25:29 +0000 (UTC)
Date: Thu, 28 Dec 2023 07:27:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] reftable/stack: do not auto-compact twice in
 `reftable_stack_add()`
Message-ID: <a08f7efc992538e88803b157c142a55df65a1a81.1703743174.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1703743174.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxJEY1oMf25UPscQ"
Content-Disposition: inline
In-Reply-To: <cover.1703743174.git.ps@pks.im>


--gxJEY1oMf25UPscQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5c086453ff (reftable/stack: perform auto-compaction with
transactional interface, 2023-12-11), we fixed a bug where the
transactional interface to add changes to a reftable stack did not
perform auto-compaction by calling `reftable_stack_auto_compact()` in
`reftable_stack_addition_commit()`. While correct, this change may now
cause us to perform auto-compaction twice in the non-transactional
interface `reftable_stack_add()`:

  - It performs auto-compaction by itself.

  - It now transitively performs auto-compaction via the transactional
    interface.

Remove the first instance so that we only end up doing auto-compaction
once.

Reported-by: Han-Wen Nienhuys <hanwenn@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 8729508dc3..7ffeb3ee10 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -425,9 +425,6 @@ int reftable_stack_add(struct reftable_stack *st,
 		return err;
 	}
=20
-	if (!st->disable_auto_compact)
-		return reftable_stack_auto_compact(st);
-
 	return 0;
 }
=20
--=20
2.43.GIT


--gxJEY1oMf25UPscQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNFVwACgkQVbJhu7ck
PpR94Q//UrkD0OmctgC5R6bRsyITlmnG/Ow6x1M6QdUAaFllSctJhF0YIN6jeNKx
xfAfO4d9rOg6Iv3Dx3adcgWOp7HRN9P8QAt5b1XaAZIZZhyIo+MM1ub7fV/wb5wB
cT+8gI66ehkgkz7KK3Aa/zBhmFr/Cim8gVB8aROHN6fhw2/bbzzqNmdG3+9JA8H1
IReGahtUsgqvlm9R/cCqEKe/t9imAX4Hr7cGJhNH3n19YEby3w6upaCqGFmeyRjZ
Ofb/BQ3Y3UlMz3QI8GNC7hp/X/gfqe6J5xlptTDwRQ0dCR9RNVSiZkGD13WUP4fd
+qb9b3AoQlyWFN+AHBrEEWklppQL98FBMU6z1LoTSTKQNP8Wl8AKA4BJgHxYHGcC
Z8LwomvJv1fmPBHLyRmehWaiBWl+dP09BnhjkGPUDzZvWmIShQbmLgPIq7qOtEgx
T3MhCNvDUPhS58TmUQEWJtNUzwLLmCHMT6F5vM9G2nvK6Gahqv37rxImUgZx3AxK
2mnLv4qmg9Qy62BZe7NwokBJKugBAb0V9ADlyOGKjKHFXvB+cXhYIjhYqjVktzU9
eE6KwyvWQ3zcg/ZFHJ+qQRlvDI98cqJsmeGKrtu3uZXF/W/QV/ptQKYbw4OGXPCa
Kef46WE2SGVLbqgWrzmxp2x9jdSSBzrhFX1cWDkOsJhTBlIQWxI=
=+juT
-----END PGP SIGNATURE-----

--gxJEY1oMf25UPscQ--
