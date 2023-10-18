Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7C8F44
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bS+nkoZ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PH/Kmw48"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B0F7
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EF6A13200B2A;
	Wed, 18 Oct 2023 01:35:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 18 Oct 2023 01:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607314; x=1697693714; bh=j+
	luhR9k8S2QLA2WSwZFzg4jfwdmM9Z0X+KbQphrQh8=; b=bS+nkoZ+mAcl3qpWjq
	2fQify2hz5zULFC6Cyh7Elg5fv13cbcRIFo9ZMiwTm7671gOKLp+7fj4Z4iXf1F9
	ggx3K45YHIkQ6105lvXBxBySynN4E51+PenA1KBR259K+5QM8ArA5jVd+V4o76lP
	iFsfWfFKQ+pAeoHFrES+HAhEfxuRRJzdv+arKxXj1EYOX4b040t7Nm36a1tqBsjW
	oZysCEN3culQyZUswp7Q8FVv0SlYxEs7659X1YUwy9/L7fbXXWO8atLNr+vzOuX/
	BOhAtbglghBcsNzp8CCcV8YPmc8jQo7QEHcGo9l0eWwTTDuKnnQ2Gs2JSlbTQIHh
	yXzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607314; x=1697693714; bh=j+luhR9k8S2QL
	A2WSwZFzg4jfwdmM9Z0X+KbQphrQh8=; b=PH/Kmw48YB8uAmLXsWs/5jrorcH5T
	zEl5y98RnkNm8FleoaAg0Z5z05G73QYAJCoak5OmoCy9mmHk9an8Z/WQi8U2rU3I
	Fee67K9D5RUsAk+axRK3YRAl39i6NQYi0qfqopJjdSiiPe2OO/W/rDkMdOYcrMqm
	7ohKT8rlme8n26zPBoE0oMOgXzpid18oXizLee1h6cNuft6/yqc44DgjCtblnj2a
	v82glkqQwSq9p1nK/UywELmLP3haA0NGptasm1KXhp6zDqPhsYy60E2WNTW9XBbG
	KWSZxTDNCs9HuiMtQLfLWcibBbyAH3fGQQfai3rQNBEbGDyHiPb6Ar9BA==
X-ME-Sender: <xms:km4vZfxemSHx-vw-Tm0B8a_LFKakcOeXyhB5k3-1BcRNQ9rMLG1fvQ>
    <xme:km4vZXT16XmtJ8v0JQ7vm9a13GJedoCkZlc_5FpGLfqhuhHf2L0rKis8YwBB3v8vR
    6OqzOhfzU8l1lbBoQ>
X-ME-Received: <xmr:km4vZZUSdPF8WbyH_YuYx16mw7E2xZoIo6ca56R6fV246MSov2cn1PRoubU8FJ327cJvB_8p5t8aPnMuww-yde53Ha5viSuqynJcDj1ePAem2FMF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:km4vZZgzXbPQk12Xyq2FybreSmItozFmOyo_w20LkD2xrbAqpjuBaA>
    <xmx:km4vZRBMbbdBYcE7Beyv72jmIAwf2yIfXRQLaYll8t8gdHXO5-BWSA>
    <xmx:km4vZSJfhssfCsLjAQ2ddN24tOwXYfzc_3WLknlV0EIMnQnDVhQJoA>
    <xmx:km4vZUoNV5q3-rx2ViqP5KT4pJJaOf5oxmIzMpiTzLnIwMe15qbRqA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3e11c00 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:12 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 02/11] t: allow skipping expected object ID in `ref-store
 update-ref`
Message-ID: <1f615d62f99e9ab47d37500f05b29615bafffba2.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M+8SCMlIRz/+LApy"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--M+8SCMlIRz/+LApy
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
index 7400f560ab6..7dc83137584 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -322,16 +322,19 @@ static int cmd_update_ref(struct ref_store *refs, con=
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


--M+8SCMlIRz/+LApy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbo8ACgkQVbJhu7ck
PpSd3g/+Obmj5Y44wUx77psfzIwKwi0AanyVA0JywKQ5OrbcBCncgxZYjlzEm7AB
1rKtPtIZJ18XHaSnxVourJBUdz/tNmCQX5w+WjwqrOK++lcdZfVKXG+oCYxcCT5P
892d6VMatqv3BtHQDpesduN06J31qP1XJ+gCrOrZ4q8xdSsSba4dfu2BMxZc+mpL
BgqSCPDxVNlSHRMIGoguuYwMQNddvgb6QNTbwt3gxh1cg+P2NmGVLu6Fkx98rNH7
LC/G5wuMYT9alwGeBRQHc294N7lXAdGkdD4LTOBMPV+B9l/86XGPMXwg8B70Wncd
RcwfaZpFqxtzQL6QKBh1ZDNsCoIGaSV83C4B9iq6ER0OxdmyFT6k8Ym6DfpL29rd
lKFFXv2e2p0Xj5auuTgtheQed7QFsQnvi/17BTQwQNP2uLBM38PmqGc//hMwA1v+
RozC4l5+yYA539HEUbFNfQQho0xISt0iqSW/LRvm/VvtgHNAn0cWa+nchwwTEfvC
g7NV1hG9lwGW8mUIA6wBkDJUZQwUbNcGtU8WJ8aNvI1ufpMq9YxNAdmNSL4JdBsT
PMvzIDUSsDoNGRiOnbrT8oS4cWF7UuLf+BUYO+ur6MY98PyLXaUtqXdqUhKYiA95
OYHrD8eGPb/4km2l49LjYT/IMI2LYaksMrOFyLKwnEKAIBdqh9M=
=K/ds
-----END PGP SIGNATURE-----

--M+8SCMlIRz/+LApy--
