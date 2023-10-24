Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A99D2943C
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OhMwukcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CROktDWb"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99A10A
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:04:59 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 14CCC3200A85;
	Tue, 24 Oct 2023 10:04:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 24 Oct 2023 10:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698156297; x=1698242697; bh=C+
	5vwRVeS/TbtoQbcWTS8+eNESagAiXw5WXz8u88Bkk=; b=OhMwukcKbqdwN7LC44
	wAINEf9n4GsF77srKLyfWGDqw9mwtE5vlM4A2BrTaSo/98vTwPnP/Jtgl8EZyZgD
	1PJD1d0LYmtoN7bf8AhHiKJJK3K/kq0BOVyVIKI13idpEb19CP/Wr9IPZFpTKdPZ
	t1BE8kXve9FVdpFvuZXjPNXyvQktTxdLWX/bYkvrDouG9I8oRfKTa1TGqsmUGiXj
	vAa3qoa6p3Y9680WePnxJtgk57l2W0TvnNls7bD+BoKHqujgeGyapwdWqL0/5HqJ
	PS8Qx91IcKE+bYya9ZLnLDa4isWYXNLdp8m6yyKS12J+NzWTrfU9h088RfAkjyL/
	Kb8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698156297; x=1698242697; bh=C+5vwRVeS/Tbt
	oQbcWTS8+eNESagAiXw5WXz8u88Bkk=; b=CROktDWb3nfg4eoxcBR9HHL2M52zN
	HE2le4Bi4/M6JtgDNT+ew5D9xGT8Cr6BcUqaG/nLihdVNFuLWGwdN1gl0dm4OVva
	gIe+WW6pU9aqccFDoOvkgGGd2PV13GTpGAdI2w//rxoxrvhZvY5Du+53GiG3C8b8
	LQGWObS/Ye957jGgDdu9xGWOcAC0hBGTJCbq/vmhVF3HXrrq0YdHn/1nRcUoCJ3h
	2lUv6LUyQNBqqUoI2pxNym59ocNwVF9ezUGGEtlAxNjKOq/1Wu9MLsILcUUqDqkk
	61aZUj+zaLyhCJjrcuGnrj32Q1dPH/tVMUcn1/s9G+Wc2zXu+i3HpWaSQ==
X-ME-Sender: <xms:Cc83ZeB1LjSJGVfIt-hFCCcHHLnrT116hq2mD31cROJKDz7ycCQdyA>
    <xme:Cc83ZYiMJSjOihb9brlpNY7JcY6Ikr6cqMlK63dJV6ESo7q3Y2gAU5AfbvkNpQpRf
    WlwNVNvhZ6A_V2EiA>
X-ME-Received: <xmr:Cc83ZRle_0iW90H5fHm1moHAMDC4R1LKk_5tinP-d37wJfZoljIbbyKgfW5NkSQWeYddwzPX48SIVuCnKNUT4gryQ2SbnrW6hejrNWOZ7eHlZWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Cc83ZczyNDVbrMkazplEVPiNKiG8ep7c6atnLDieoaH2CbiLcNIgxw>
    <xmx:Cc83ZTRtAjJrbZEoQ79Nq0zwDk2lwJjIE7xM40d2KMxrc3QSNaJIAg>
    <xmx:Cc83ZXbT-70m8X_MHSaiWxRJ0ymKKa6kaQO92TXl8Z_NARaq4YGoRQ>
    <xmx:Cc83ZdfxgqVGJvP57wShVgTfhmNOVPabQmJBMZuIOsvAEdkeYAQnxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 10:04:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92f25b94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 14:04:50 +0000 (UTC)
Date: Tue, 24 Oct 2023 16:04:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/9] t: allow skipping expected object ID in `ref-store
 update-ref`
Message-ID: <c868198f8c1e0ddeb6577efdf741623584653633.1698156169.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698156169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Dvdfm1OG5YY/mDd"
Content-Disposition: inline
In-Reply-To: <cover.1698156169.git.ps@pks.im>


--9Dvdfm1OG5YY/mDd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We require the caller to pass both the old and new expected object ID to
our `test-tool ref-store update-ref` helper. When trying to update a
symbolic reference though it's impossible to specify the expected object
ID, which means that the test would instead have to force-update the
reference. This is currently impossible though.

Update the helper to optionally skip verification of the old object ID
in case the test passes in an empty old object ID as input.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 48552e6a9e0..702ec1f128a 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -298,16 +298,19 @@ static int cmd_update_ref(struct ref_store *refs, con=
st char **argv)
 	const char *new_sha1_buf =3D notnull(*argv++, "new-sha1");
 	const char *old_sha1_buf =3D notnull(*argv++, "old-sha1");
 	unsigned int flags =3D arg_flags(*argv++, "flags", transaction_flags);
-	struct object_id old_oid;
+	struct object_id old_oid, *old_oid_ptr =3D NULL;
 	struct object_id new_oid;
=20
-	if (get_oid_hex(old_sha1_buf, &old_oid))
-		die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
+	if (*old_sha1_buf) {
+		if (get_oid_hex(old_sha1_buf, &old_oid))
+			die("cannot parse %s as %s", old_sha1_buf, the_hash_algo->name);
+		old_oid_ptr =3D &old_oid;
+	}
 	if (get_oid_hex(new_sha1_buf, &new_oid))
 		die("cannot parse %s as %s", new_sha1_buf, the_hash_algo->name);
=20
 	return refs_update_ref(refs, msg, refname,
-			       &new_oid, &old_oid,
+			       &new_oid, old_oid_ptr,
 			       flags, UPDATE_REFS_DIE_ON_ERR);
 }
=20
--=20
2.42.0


--9Dvdfm1OG5YY/mDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3zwQACgkQVbJhu7ck
PpRnrw//QNHKQydm7KBtdK7y2mPBZ+CHWV1RwELDLpTV4khFZVoD+sycr2EiZ0dk
aR3upc+UtHpVoheXt4mHnzLKcEocVC3navECeHRpfypUHpavEVb8hknt+RuBCcml
3fZGLfSd/04wbdISViJObo1DoD229Uz8Hmr1Z8i6TDS/u2MUpN3aEzsiHXZuhKIe
rG/GL2WuvoT+/tIIZz8ja0t7FWINQNhuYUafquuqduGWeJQR7nNO+kcwOEhmJ3Ss
wysYBcBdETdSkpSA9F+LEnXKSmjXAiZUYYmNeCaTJ/5fw17NGY2j82vLTJ0Dkizl
jWh8R4dnPAA7IFEu1HITueLgRNz7f+QD/9kULi4HABG/UMr0nn5w7rmZnV9CER0G
RgzsTkwIW5a2cEPpjLrN62qQAaN4p/YhiVEQim1F/mAJ8EoU8UfewQWlcKp/CBzN
2ikej8bOeoHG/ZKACA+GcYp+G8BdQkbuzYEfHqB3VlOWHv2YWxHe/edc9yrPyYzo
3b9tR8tvNIz/Jx32yHzWBIoHmQhRx7R4A3zFVEXSje33C4twN369fQ9H2ZD4B7Db
eDp2FPluWKd0KmML1oMpKN9VLVmIp+DRNtyRT6qvgtQM8SxaqRDb5DZu5WC4nu7M
IdFDEOV4vAH2oTNW40CFNX/wumiENRQolk6M0ODya62AE/jb9rk=
=Nl+q
-----END PGP SIGNATURE-----

--9Dvdfm1OG5YY/mDd--
