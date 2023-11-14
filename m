Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87016414
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uh5WLVyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BO8W5zAt"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BDCA4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:58:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E345A5C0117;
	Tue, 14 Nov 2023 03:58:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Nov 2023 03:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699952329; x=1700038729; bh=Iu
	BiEhzXwNi4SZqlBHKdppXpLLO9BAJWCDEc3r6ODs4=; b=Uh5WLVynVlkDY2BdHq
	VStlYcZHWFO7rVfcKrAPkEiqncfPWL/FCZ22yi4Y4OuopS1FY/qA1GoYijx7e12N
	Mnn6Igjby7qMZ6jUICV2a/q2QUqrrif1MVnqukAzDsjpG/WhOVjpbJ07WE6aXQ5j
	TI/gnStLYbtrmFzwfcsQCGsmLdMzn40LsgFHUOhH6LQHCy+Vfns2M3Xxs/KQdsw3
	9FacoWICzJmASRsA/Y6tjtMmybDWtLxqdO7XxXNsfGvKLItPBuohTfiagd6/j/OK
	dGPrr/V/x2AhdIy+VfYF8/ssWzu1FFTSfmAdSGDegcm0CyXpENNRylrbdBX8Jdtc
	2x2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699952329; x=1700038729; bh=IuBiEhzXwNi4S
	ZqlBHKdppXpLLO9BAJWCDEc3r6ODs4=; b=BO8W5zAtlwQkSVuLqzm436MYjOR8y
	gIu+Fl02TL1UgiVd8lUMaYu+n7M+cLXTBp3mrk3tkCMGDKA6cYsL4efLgOCI/5JG
	OdUfIiy/dSFCqP4QkAaow5gSYZ5tdi1vaLrnh/sRXWaCGee1nH2fQ3e/JlcZg1X5
	9/hCHmaGRx+AWjETusZuyzPaPxKcR+k80oAG94BcxxXnCRWCkR+tCBwks0d+husF
	ic1fDlWxU/oxyOfdQafbxZyZJu6d+mw8E8Q6Ymu3sjQTP3O+V8j+4pZVsoyKUzQr
	f078y9yd0ySkzvUEuRNPa+180ptzh+0Kh35b85xqJqymShEztzztTvznA==
X-ME-Sender: <xms:yTZTZcvCDc1-Cu7DCI2wRGqcPFtIFbpkWKrGIhmVvorxL582E_C9xw>
    <xme:yTZTZZdu-JAs6IXHLZH6KKrV3kHHjEt3BnhJhQ9534_5evILP_qaAeoDHdPIaT_lF
    JRuIOnYsgsXA20SjQ>
X-ME-Received: <xmr:yTZTZXwYt8mdsNmIrDqzSmcEJHJiN5S_E5C-pw-xvWoTIk4fO_hNBxRbLE4oJco8tMwesPcC0zeJ_a7yxHfbZdPTdSxu3f7INmrrFvz7NnDYdbo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:yTZTZfNAKMIGDkVsc1pPpaSrbZSno5SiMR6XOV8Rd52d7vLgSjSuSw>
    <xmx:yTZTZc-9xauPZcsOAJgOX4VMGyf4uWywV5U-qMx4tmD_oVCAAebOXw>
    <xmx:yTZTZXVndMlX-LtUhS3A9MhqrDNm0jF7RcXKVHq-RCDdY9iq0bzkBQ>
    <xmx:yTZTZalX_XLVrnlKfnygtmWF9YRDcPJZXLV0CH_9V5i5ECIRpi7ezg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:58:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2a66564 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:58:10 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:58:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: David Turner <novalis@novalis.org>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 3/4] refs: deduplicate code to delete references
Message-ID: <bb9f45543daf32e6485a57781e1a71e9503936f8.1699951815.git.ps@pks.im>
References: <cover.1699951815.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Rb09e/IROKbvh+P"
Content-Disposition: inline
In-Reply-To: <cover.1699951815.git.ps@pks.im>


--2Rb09e/IROKbvh+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both the files and the packed-refs reference backends now use the same
generic transactions-based code to delete references. Let's pull these
implementations up into `refs_delete_refs()` to deduplicate the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                | 48 ++++++++++++++++++++++++++++++++++++++++---
 refs/files-backend.c  | 46 +----------------------------------------
 refs/packed-backend.c | 45 +---------------------------------------
 3 files changed, 47 insertions(+), 92 deletions(-)

diff --git a/refs.c b/refs.c
index fcae5dddc6..16bfa21df7 100644
--- a/refs.c
+++ b/refs.c
@@ -2599,13 +2599,55 @@ void ref_transaction_for_each_queued_update(struct =
ref_transaction *transaction,
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
+	struct ref_transaction *transaction;
+	struct strbuf err =3D STRBUF_INIT;
+	struct string_list_item *item;
+	int ret =3D 0, failures =3D 0;
 	char *msg;
-	int retval;
+
+	if (!refnames->nr)
+		return 0;
=20
 	msg =3D normalize_reflog_message(logmsg);
-	retval =3D refs->be->delete_refs(refs, msg, refnames, flags);
+
+	/*
+	 * Since we don't check the references' old_oids, the
+	 * individual updates can't fail, so we can pack all of the
+	 * updates into a single transaction.
+	 */
+	transaction =3D ref_store_transaction_begin(refs, &err);
+	if (!transaction) {
+		ret =3D error("%s", err.buf);
+		goto out;
+	}
+
+	for_each_string_list_item(item, refnames) {
+		ret =3D ref_transaction_delete(transaction, item->string,
+					     NULL, flags, msg, &err);
+		if (ret) {
+			warning(_("could not delete reference %s: %s"),
+				item->string, err.buf);
+			strbuf_reset(&err);
+			failures =3D 1;
+		}
+	}
+
+	ret =3D ref_transaction_commit(transaction, &err);
+	if (ret) {
+		if (refnames->nr =3D=3D 1)
+			error(_("could not delete reference %s: %s"),
+			      refnames->items[0].string, err.buf);
+		else
+			error(_("could not delete references: %s"), err.buf);
+	}
+
+out:
+	if (!ret && failures)
+		ret =3D -1;
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	free(msg);
-	return retval;
+	return ret;
 }
=20
 int delete_refs(const char *msg, struct string_list *refnames,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 778d3a96ba..8d28810e67 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1268,51 +1268,7 @@ static int files_pack_refs(struct ref_store *ref_sto=
re,
 static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct ref_transaction *transaction;
-	struct strbuf err =3D STRBUF_INIT;
-	struct string_list_item *item;
-	int ret =3D 0, failures =3D 0;
-
-	if (!refnames->nr)
-		return 0;
-
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-	transaction =3D ref_store_transaction_begin(ref_store, &err);
-	if (!transaction) {
-		ret =3D error("%s", err.buf);
-		goto out;
-	}
-
-	for_each_string_list_item(item, refnames) {
-		ret =3D ref_transaction_delete(transaction, item->string,
-					     NULL, flags, msg, &err);
-		if (ret) {
-			warning(_("could not delete reference %s: %s"),
-				item->string, err.buf);
-			strbuf_reset(&err);
-			failures =3D 1;
-		}
-	}
-
-	ret =3D ref_transaction_commit(transaction, &err);
-	if (ret) {
-		if (refnames->nr =3D=3D 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
-	}
-
-out:
-	if (!ret && failures)
-		ret =3D -1;
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return ret;
+	return refs_delete_refs(ref_store, msg, refnames, flags);
 }
=20
 /*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 59c78d7941..1589577005 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1691,50 +1691,7 @@ static int packed_initial_transaction_commit(struct =
ref_store *ref_store UNUSED,
 static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct packed_ref_store *refs =3D
-		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
-	struct strbuf err =3D STRBUF_INIT;
-	struct ref_transaction *transaction;
-	struct string_list_item *item;
-	int ret;
-
-	(void)refs; /* We need the check above, but don't use the variable */
-
-	if (!refnames->nr)
-		return 0;
-
-	/*
-	 * Since we don't check the references' old_oids, the
-	 * individual updates can't fail, so we can pack all of the
-	 * updates into a single transaction.
-	 */
-
-	transaction =3D ref_store_transaction_begin(ref_store, &err);
-	if (!transaction)
-		return -1;
-
-	for_each_string_list_item(item, refnames) {
-		if (ref_transaction_delete(transaction, item->string, NULL,
-					   flags, msg, &err)) {
-			warning(_("could not delete reference %s: %s"),
-				item->string, err.buf);
-			strbuf_reset(&err);
-		}
-	}
-
-	ret =3D ref_transaction_commit(transaction, &err);
-
-	if (ret) {
-		if (refnames->nr =3D=3D 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
-	}
-
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return ret;
+	return refs_delete_refs(ref_store, msg, refnames, flags);
 }
=20
 static int packed_pack_refs(struct ref_store *ref_store UNUSED,
--=20
2.42.0


--2Rb09e/IROKbvh+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTNsUACgkQVbJhu7ck
PpQEAhAAg+gEd1VYO1699D+ZWF7GMTsvN0MaXgmzZQ+DrZweB6hGerIbbCNQXDeg
oBusao05XStEf/Q1tdCyjbufke/2rWwrvj5qnDbQL14RxM2nifXj6rW03mPltxC3
iSBbquRYyomDuGa2PPvh/FS2iUIUnpPFVJUm2QCYJYzA24FNgWf5OaW2WzMT1HNr
tS0tyVADlnrRaC72vahQLqcpNZalCix7lPYmcYZc8iRQZzBINQZUbd2vB7UlpW6F
EGx9FplAUSyL59sCZetwKLMs6+MAyn5EdNRcDzwc5LFCthofGEobtl5mirGRF+oP
XDGYPGs2I/Hye6FD+5Y9MtcCcApxV9KgHvN+w8O6P9XFg3YxI78sB3MNb4R9d7Ut
Zk5kIbrWK66Kyb77xscADdbawUCIAPfK+deu5+7E70cMP+3A9RLY5nCGAWSoyz+H
2Dv7m1croXS/+s9iiroZAzdWQ4M6ReBfE6qF8iT+A6no8pt6lfji1npoIt/n/MOq
o9yedPtt1YoFRmLSvb2lpm5MGfsOXe33VOITUeqtOVjsFzUsO4GNQyetduz+PeWV
GJ8VMN9z8kF+DWuXiqUmNitayx9y4D7lSbu3zRMTW15wfTB1YLYd5jxzwuTwmnLS
XfjdGYKuygGjSrUokR2VGkuTFQfJfurzE3DI+Da6CUOfolXLNTM=
=awzX
-----END PGP SIGNATURE-----

--2Rb09e/IROKbvh+P--
