Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35615C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 07:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiAXHNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 02:13:20 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36759 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241702AbiAXHNS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Jan 2022 02:13:18 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D27D45C00F4;
        Mon, 24 Jan 2022 02:13:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 24 Jan 2022 02:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=nV/Txd7BtC6Yn3wdJcCwNq/UbSXVVOYpWEcz6c
        Z4JIs=; b=YDW4ZxLbIW+JWbu5PUJ/7agFhDtaZa6F6AVXooi1aoXc+4VFh7uyPN
        QnIFwdVJOI0sqxTy8hc2CXaV4MuIbErbLSrqu995/riPXO0xwMiIiH/efz0njI8P
        U3n51lcTCOqX/sligWSg80rjZvOkfQUHizuJdpjDlTVKTGzBNh/6a88iC8MozIXT
        elS9rs3hNeXggQinC5FmzP8l3mVfjeF4rQwPfPmisnwWBx1grbc1V6K3KuvW7rZa
        hTJGuUjfRu2uIuxuLWHubOwC73yuXKO9SKMdxq5/hNGlZcW+ljS7Uc3Mhv60JHTG
        6YxiTIFV0KeM3Ml1aKr0xFMe2wmbkuHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nV/Txd7BtC6Yn3wdJ
        cCwNq/UbSXVVOYpWEcz6cZ4JIs=; b=VXCL9uqS2o+t9Ag0FSTuQADk17A2Izwn8
        AchKzCWKpw4I4GowU9k/RG2LMss6D3imI54hvKVbbyNFbbI0ry7P1XNQm6KKAvI6
        fvp5CeLSPh67onEn09T/+Exv2YazQWyaeYCAvo8h8g3rbj5F8pNs1GfwcUjKYMFa
        CebjBZdGeRFXVTJh+qzxd0Hq64IKf6i2Nuv7CpNwPvFz3GNnag7H62AgZCc7e8p9
        5DPuQmJmS8Y28oMAtFjmw5fiyvY2nRHlsGwCTNiesmVTYrTQg1fh6Vf1/X6IDOcP
        1pr/FYFwvoWyNnS3c908edEUK9RbZVB7vVbEa7o+TrPqv72J5uTDw==
X-ME-Sender: <xms:i1HuYZXwFySM7xB9zF-kmpt4X_Pucf5DOoD4cvGWk47Bz92HDptP-Q>
    <xme:i1HuYZlpqSeRXNQ0DzlHniMfbhkP_I1rcmdJI44zsoPdMCE0LdBe8FmqmcpP_qCZs
    jgvgoZucom73NbbQg>
X-ME-Received: <xmr:i1HuYVbEbRZcIvQk92oB9NINK8bmulIykdhYnBOU1qvPKVTZo1zfXVhp2mmlRuicZSDZj9feRgsmy773yq0IlwIxOdBGYqptGn9Qp0wQCHOx9rUF4UAOUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdehgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefhueekffevvddtheekiedvkefglefgtdetieetjeelgedtuefhffekueefteefgeen
    ucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:i1HuYcVITQOc-D6cCsypkfMBDiodkSAY5mwEu4teV_hpsMjyGIVg1Q>
    <xmx:i1HuYTm-KP9qKEJcmi6eI41HT1QV47APFhKO9Jg6Zi1HMPOmWxw7oA>
    <xmx:i1HuYZfQsopgz69jmrqWP0SVk4sXNJ81t2Us25pxuC1GWQtnyAPeXA>
    <xmx:i1HuYcDjWhV2r6ATA4hVHp_tUPouEITqmihazeUxMW9acAQnkpLQBQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 02:13:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 16134b43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Jan 2022 07:13:08 +0000 (UTC)
Date:   Mon, 24 Jan 2022 08:13:07 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: Re: [PATCH v2 0/6] refs: excessive hook execution with packed refs
Message-ID: <Ye5Rgx71QSpkIgT7@ncase>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
 <xmqqiluv6vim.fsf@gitster.g>
 <CAFQ2z_P_SiaDbSQdAt5mSp79BnC0-k5B+X09oCVh+w--BO4_6w@mail.gmail.com>
 <YeUYNhJemN/hRG+6@ncase>
 <CAFQ2z_M+2D-5qPXN=0FEveZ36Yq0rps3HxRkgCmiupq1DD7Kig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVVj/ReVtPrxVvyS"
Content-Disposition: inline
In-Reply-To: <CAFQ2z_M+2D-5qPXN=0FEveZ36Yq0rps3HxRkgCmiupq1DD7Kig@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aVVj/ReVtPrxVvyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 17, 2022 at 12:37:39PM +0100, Han-Wen Nienhuys wrote:
> On Mon, Jan 17, 2022 at 8:18 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > It might make sense to not introduce a new flag namespace, but use
> > > update->flags instead. You'd have to add your new flag after
> > > REF_SKIP_REFNAME_VERIFICATION.
> > > Bonus is that you can unittest the new flag using the existing
> > > ref-store helper without extra work. (check that a transaction with &
> > > without the flag works as expected.)
> > >
> > > other than that, looks OK to me.
> >
> > Thanks for your feedback!
> >
> > In fact the first version I had locally did exactly that. But I found
> > the end version result harder to reason about, most importantly because
> > it's not a 100% clear to the reader whether all callsites which delete
> > refs in the packed-backend via the files-backend are adapted or whether
> > any of the callsites was missing. By having the flag in a central place
> > it's immediately clear that the hook won't be run at all, which is
> > exactly what we want here.
>=20
> If you do it like this, can you find the callsites that take update
> flags (but not transaction flags), and update the signature to say
> "update_flags" rather than "flags", and document appropriately?

All functions which accept "flags" document that they pass the parameter
directly to `ref_transaction_{update,create,delete,verify}` already. And
in the context of those latter functions it cannot possibly be related
to the flags passed to `refs_store_transaction_begin()` because they
already get a transaction as parameter and thus don't have to create
a new one.

So we could apply below patch, and I'm happy to polish and add it to the
series. But it feels to me like it adds churn while only stating things
that are documented already. It could only be me though given that I'm
obviously biased, so please feel free to disagree.

Patrick

-- >8 --

=46rom 91c77a69b6326b1b6cc743ebba6fb0970f0d01c2 Mon Sep 17 00:00:00 2001
Message-Id: <91c77a69b6326b1b6cc743ebba6fb0970f0d01c2.1643008212.git.ps@pks=
=2Eim>
=46rom: Patrick Steinhardt <ps@pks.im>
Date: Mon, 24 Jan 2022 08:09:45 +0100
Subject: [PATCH] refs: rename generic `flags` field to `update_flags` for
 clarity

---
 refs.c | 50 +++++++++++++++++++++++++-------------------------
 refs.h | 20 ++++++++++----------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/refs.c b/refs.c
index 526bf5ed97..c15e8bd58d 100644
--- a/refs.c
+++ b/refs.c
@@ -795,7 +795,7 @@ long get_files_ref_lock_timeout_ms(void)
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
 		    const struct object_id *old_oid,
-		    unsigned int flags)
+		    unsigned int update_flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err =3D STRBUF_INIT;
@@ -803,7 +803,7 @@ int refs_delete_ref(struct ref_store *refs, const char =
*msg,
 	transaction =3D ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
-				   flags, msg, &err) ||
+				   update_flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -816,10 +816,10 @@ int refs_delete_ref(struct ref_store *refs, const cha=
r *msg,
 }
=20
 int delete_ref(const char *msg, const char *refname,
-	       const struct object_id *old_oid, unsigned int flags)
+	       const struct object_id *old_oid, unsigned int update_flags)
 {
 	return refs_delete_ref(get_main_ref_store(the_repository), msg, refname,
-			       old_oid, flags);
+			       old_oid, update_flags);
 }
=20
 static void copy_reflog_msg(struct strbuf *sb, const char *msg)
@@ -1080,12 +1080,12 @@ int ref_transaction_update(struct ref_transaction *=
transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err)
 {
 	assert(err);
=20
-	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	if (!(update_flags & REF_SKIP_REFNAME_VERIFICATION) &&
 	    ((new_oid && !is_null_oid(new_oid)) ?
 		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
 			   !refname_is_safe(refname))) {
@@ -1094,19 +1094,19 @@ int ref_transaction_update(struct ref_transaction *=
transaction,
 		return -1;
 	}
=20
-	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
-		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
+	if (update_flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
+		BUG("illegal flags 0x%x passed to ref_transaction_update()", update_flag=
s);
=20
 	/*
 	 * Clear flags outside the allowed set; this should be a noop because
 	 * of the BUG() check above, but it works around a -Wnonnull warning
 	 * with some versions of "gcc -O3".
 	 */
-	flags &=3D REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
+	update_flags &=3D REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
=20
-	flags |=3D (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
+	update_flags |=3D (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD =
: 0);
=20
-	ref_transaction_add_update(transaction, refname, flags,
+	ref_transaction_add_update(transaction, refname, update_flags,
 				   new_oid, old_oid, msg);
 	return 0;
 }
@@ -1114,44 +1114,44 @@ int ref_transaction_update(struct ref_transaction *=
transaction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err)
 {
 	if (!new_oid || is_null_oid(new_oid))
 		BUG("create called without valid new_oid");
 	return ref_transaction_update(transaction, refname, new_oid,
-				      null_oid(), flags, msg, err);
+				      null_oid(), update_flags, msg, err);
 }
=20
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err)
 {
 	if (old_oid && is_null_oid(old_oid))
 		BUG("delete called with old_oid set to zeros");
 	return ref_transaction_update(transaction, refname,
 				      null_oid(), old_oid,
-				      flags, msg, err);
+				      update_flags, msg, err);
 }
=20
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags,
+			   unsigned int update_flags,
 			   struct strbuf *err)
 {
 	if (!old_oid)
 		BUG("verify called with old_oid set to NULL");
 	return ref_transaction_update(transaction, refname,
 				      NULL, old_oid,
-				      flags, NULL, err);
+				      update_flags, NULL, err);
 }
=20
 int refs_update_ref(struct ref_store *refs, const char *msg,
 		    const char *refname, const struct object_id *new_oid,
-		    const struct object_id *old_oid, unsigned int flags,
+		    const struct object_id *old_oid, unsigned int update_flags,
 		    enum action_on_err onerr)
 {
 	struct ref_transaction *t =3D NULL;
@@ -1160,7 +1160,7 @@ int refs_update_ref(struct ref_store *refs, const cha=
r *msg,
=20
 	t =3D ref_store_transaction_begin(refs, 0, &err);
 	if (!t ||
-	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
+	    ref_transaction_update(t, refname, new_oid, old_oid, update_flags, ms=
g,
 				   &err) ||
 	    ref_transaction_commit(t, &err)) {
 		ret =3D 1;
@@ -1191,10 +1191,10 @@ int refs_update_ref(struct ref_store *refs, const c=
har *msg,
 int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid,
 	       const struct object_id *old_oid,
-	       unsigned int flags, enum action_on_err onerr)
+	       unsigned int update_flags, enum action_on_err onerr)
 {
 	return refs_update_ref(get_main_ref_store(the_repository), msg, refname, =
new_oid,
-			       old_oid, flags, onerr);
+			       old_oid, update_flags, onerr);
 }
=20
 char *refs_shorten_unambiguous_ref(struct ref_store *refs,
@@ -2435,21 +2435,21 @@ int initial_ref_transaction_commit(struct ref_trans=
action *transaction,
 }
=20
 int refs_delete_refs(struct ref_store *refs, const char *logmsg,
-		     struct string_list *refnames, unsigned int flags)
+		     struct string_list *refnames, unsigned int update_flags)
 {
 	char *msg;
 	int retval;
=20
 	msg =3D normalize_reflog_message(logmsg);
-	retval =3D refs->be->delete_refs(refs, msg, refnames, flags);
+	retval =3D refs->be->delete_refs(refs, msg, refnames, update_flags);
 	free(msg);
 	return retval;
 }
=20
 int delete_refs(const char *msg, struct string_list *refnames,
-		unsigned int flags)
+		unsigned int update_flags)
 {
-	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames=
, flags);
+	return refs_delete_refs(get_main_ref_store(the_repository), msg, refnames=
, update_flags);
 }
=20
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
diff --git a/refs.h b/refs.h
index d4056f9fe2..5131db7e48 100644
--- a/refs.h
+++ b/refs.h
@@ -442,9 +442,9 @@ int reflog_exists(const char *refname);
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
 		    const struct object_id *old_oid,
-		    unsigned int flags);
+		    unsigned int update_flags);
 int delete_ref(const char *msg, const char *refname,
-	       const struct object_id *old_oid, unsigned int flags);
+	       const struct object_id *old_oid, unsigned int update_flags);
=20
 /*
  * Delete the specified references. If there are any problems, emit
@@ -453,9 +453,9 @@ int delete_ref(const char *msg, const char *refname,
  * ref_transaction_delete().
  */
 int refs_delete_refs(struct ref_store *refs, const char *msg,
-		     struct string_list *refnames, unsigned int flags);
+		     struct string_list *refnames, unsigned int update_flags);
 int delete_refs(const char *msg, struct string_list *refnames,
-		unsigned int flags);
+		unsigned int update_flags);
=20
 /** Delete a reflog */
 int refs_delete_reflog(struct ref_store *refs, const char *refname);
@@ -680,7 +680,7 @@ int ref_transaction_update(struct ref_transaction *tran=
saction,
 			   const char *refname,
 			   const struct object_id *new_oid,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err);
=20
 /*
@@ -695,7 +695,7 @@ int ref_transaction_update(struct ref_transaction *tran=
saction,
 int ref_transaction_create(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *new_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err);
=20
 /*
@@ -709,7 +709,7 @@ int ref_transaction_create(struct ref_transaction *tran=
saction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags, const char *msg,
+			   unsigned int update_flags, const char *msg,
 			   struct strbuf *err);
=20
 /*
@@ -723,7 +723,7 @@ int ref_transaction_delete(struct ref_transaction *tran=
saction,
 int ref_transaction_verify(struct ref_transaction *transaction,
 			   const char *refname,
 			   const struct object_id *old_oid,
-			   unsigned int flags,
+			   unsigned int update_flags,
 			   struct strbuf *err);
=20
 /* Naming conflict (for example, the ref names A and A/B conflict). */
@@ -796,10 +796,10 @@ void ref_transaction_free(struct ref_transaction *tra=
nsaction);
  */
 int refs_update_ref(struct ref_store *refs, const char *msg, const char *r=
efname,
 		    const struct object_id *new_oid, const struct object_id *old_oid,
-		    unsigned int flags, enum action_on_err onerr);
+		    unsigned int update_flags, enum action_on_err onerr);
 int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
-	       unsigned int flags, enum action_on_err onerr);
+	       unsigned int update_flags, enum action_on_err onerr);
=20
 int parse_hide_refs_config(const char *var, const char *value, const char =
*);
=20
--=20
2.34.1


--aVVj/ReVtPrxVvyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHuUYIACgkQVbJhu7ck
PpRNEBAAiuzK3TpMH3V8V2bzYCejbF5UBvqoj3sGjjXU4/pIE7ngpzhgIsBu7ZJW
5Bii0fLyx7ZsDq2abRqJLqtd8ZQZApPGFGBSRhUK+ztU0K42raoVDSoVU5AnFQw2
yBeFDIf8mVyXczQM+8lW1Hx1z174cIn5GJ7NUYTB89FoFoBwtEN/ioLpUEtShmlp
ccDvxrVeNWWtTHfSrNpXHKeac1V/5tjA41XIps5zZLzqOTnnYSayQgNoP//RFIB2
SepsqTTTB65etAkmV4XR8emkvYU2L8pDRZemUpmpx5s+9qiRlt4XBu6cPh/lvu9Q
eJBw4G33p5xWh/Y+6EEy/mKAgjSCl7n2sC7LJ39l9z5oczpwmDn1aRmOQVEEbxWx
OymGDzUyJt7Ss7O5kMGkYxj5/bkyioRaDEPwFexGcoBCVW6Nk4mhMxFKN89RdO5Q
oSb/oAvpKhg9rGB/3csJj//w29Ue1YRYdkxnBFWet1PhJHv2b8MA5dk/ScpnMrbK
y8/bnUkUKuNjraIRJ5Tt6zpa1lPuvkQf/oQ7kCHHKP+soeifCptMSqrpoohnakgD
tZQiZqY4fLCY8MiS4j0nVxjHkLsNJMKyv9ELVx9gGKmbf8pB+z5dpk4EJouPZG/G
7ADiuNCz+IgHN6ZEbVG25ckPCvwiupduOlj31JB5Bn2PCh4ER34=
=bRRM
-----END PGP SIGNATURE-----

--aVVj/ReVtPrxVvyS--
