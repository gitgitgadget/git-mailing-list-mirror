Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0E15ACE
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XAYvf+Ul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YNdyU6jr"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469C9A4
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:58:46 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id A2BA55C0117;
	Tue, 14 Nov 2023 03:58:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 14 Nov 2023 03:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699952325; x=1700038725; bh=VL
	O1zHZx036srSc7DVRFwaPRXgE5IgC/eKk1JRsFr/0=; b=XAYvf+UlHiXnaccY2r
	YFKF7iZ2YjuCFVTf/aMwmQalxwJ47jcI7oaYexH3xB39m8FWOp62fbxqKDeLxXed
	N/IX89w/fSZTEjEi18QwO3Y0wz+lXT7DeJfDcbgGkz20tKQD3+yqb4dnmJT+Pxet
	+JdL3eqaJOcO+V17/WUgsX5t8vWQOgniHuR6xccWziOgidJf3aJuq1Fpq1NK8PE1
	rbidJ6K0oJ6kEXfXOY6zEmRUDdtOH8MuzJCLfEknyXvy7rpYj1nSQchdFiUNzKUa
	6Ig0a0t3ajlPSh7ZoI13hQqTjomWC92q2F5ycjsSxmlEtwHlvdcPFHCDlK09Y5Nu
	TUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699952325; x=1700038725; bh=VLO1zHZx036sr
	Sc7DVRFwaPRXgE5IgC/eKk1JRsFr/0=; b=YNdyU6jrnRU+nAVkpdshUM/JEbbiT
	yI+PRW6SKtbQai+zCoUS3PcWpJinbeAdZsZ+XADSRdN/rNq8ciTnuC9eWfwpwWJ7
	cafK7sG5PkcUQXRTM3Pqzd3Ag3Yp7wodPuIfIcqZ+bLLKkMJuCGlj5tx/v1/yHA0
	zpo4fYtqgDGXZexuWLpjQHyYYZgh4+Rd/Df6hkQnrMG/qGen7Jt+Je4xcJvukDOQ
	RF6g29mro9Qao0Pw8ehIZf8NlMpK7YVLAccbKL3Rhpz0D/zQsynpqEBER6f8QwKi
	QEdy0lBrgWtyR1cYeErH1DsNzmbrhRoikTKKLIE3jEmJVOQvKUseHotnQ==
X-ME-Sender: <xms:xTZTZR8pyv0RblrXKv3elAY925q5mPDGrhZfgx-1eGgjSnYqpOYSyg>
    <xme:xTZTZVt4j8ItoRFCCLTElVyq3FOyYgfkSXBRo6EK7Glvgt_FXPeU1NTtZCMlcV8S0
    HaMKEy_dWaYUYZUkA>
X-ME-Received: <xmr:xTZTZfBYfJIWZ84fD-KmsNlKn9BHzximKFC1mUWy1gjMBmKLUCIJ5Bpwu3bUPyQdxACNT-Z1Ls8i3vcQQ9osO556NC9Ryd8nc9jZoHUmltXQckk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:xTZTZVfq_Hh7vmgvXO7WHybvzN0f5CuWB5J9Mr8xVhITiwRt54lpWA>
    <xmx:xTZTZWO1sXRnL9nfPPbbv2SUlkDAv9hJVygV2404NOdJradmLGM23A>
    <xmx:xTZTZXnJy-pqIdlv5L_ScA3tnWds6N6ffoUf7HnEeldVEOu1yMjANw>
    <xmx:xTZTZY1JELH1hCUOReWEY92xfTFXajUIiaNHiZh_wnX1WczPxbn0VQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:58:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc10b4ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:58:06 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:58:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: David Turner <novalis@novalis.org>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 2/4] refs/files: use transactions to delete references
Message-ID: <2cfa0245fb089ed9d85cd44dad38c7f261e2200a.1699951815.git.ps@pks.im>
References: <cover.1699951815.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VDRTQsY2iOnLHgbJ"
Content-Disposition: inline
In-Reply-To: <cover.1699951815.git.ps@pks.im>


--VDRTQsY2iOnLHgbJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the `files_delete_refs()` callback function of the files backend we
implement deletion of references. This is done in two steps:

    1. We lock the packed-refs file and delete all references from it in
       a single transaction.

    2. We delete all loose references via separate calls to
       `refs_delete_ref()`.

These steps essentially duplicate the logic around locking and deletion
order that we already have in the transactional interfaces, where we do
know to lock and evict references from the packed-refs file. Despite the
fact that we duplicate the logic, it's also less efficient than if we
used a single generic transaction:

    - The transactional interface knows to skip locking of the packed
      refs in case they don't contain any of the refs which are about to
      be deleted.

    - We end up creating N+1 separate reference transactions, one for
      the packed-refs file and N for the individual loose references.

Refactor the code to instead delete references via a single transaction.
As we don't assert the expected old object ID this is equivalent to the
previous behaviour, and we already do the same in the packed-refs
backend.

Despite the fact that the result is simpler to reason about, this change
also results in improved performance. The following benchmarks have been
executed in linux.git:

```
$ hyperfine -n '{rev}, packed=3D{packed} refcount=3D{refcount}' \
    -L packed true,false -L refcount 1,1000 -L rev master,pks-ref-store-gen=
eric-delete-refs \
    --setup 'git -C /home/pks/Development/git switch --detach {rev} && make=
 -C /home/pks/Development/git -j17' \
    --prepare 'printf "create refs/heads/new-branch-%d HEAD\n" $(seq {refco=
unt}) | git -C /home/pks/Reproduction/linux.git update-ref --stdin && if te=
st {packed} =3D true; then git pack-refs --all; fi' \
    --warmup=3D10 \
    '/home/pks/Development/git/bin-wrappers/git -C /home/pks/Reproduction/l=
inux.git branch -d new-branch-{1..{refcount}}'

Benchmark 1: master packed=3Dtrue refcount=3D1
  Time (mean =C2=B1 =CF=83):       7.8 ms =C2=B1   1.6 ms    [User: 3.4 ms,=
 System: 4.4 ms]
  Range (min =E2=80=A6 max):     5.5 ms =E2=80=A6  11.0 ms    120 runs

Benchmark 2: master packed=3Dfalse refcount=3D1
  Time (mean =C2=B1 =CF=83):       7.0 ms =C2=B1   1.1 ms    [User: 3.2 ms,=
 System: 3.8 ms]
  Range (min =E2=80=A6 max):     5.7 ms =E2=80=A6   9.8 ms    180 runs

Benchmark 3: master packed=3Dtrue refcount=3D1000
  Time (mean =C2=B1 =CF=83):     283.8 ms =C2=B1   5.2 ms    [User: 45.7 ms=
, System: 231.5 ms]
  Range (min =E2=80=A6 max):   276.7 ms =E2=80=A6 291.6 ms    10 runs

Benchmark 4: master packed=3Dfalse refcount=3D1000
  Time (mean =C2=B1 =CF=83):     284.4 ms =C2=B1   5.3 ms    [User: 44.2 ms=
, System: 233.6 ms]
  Range (min =E2=80=A6 max):   277.1 ms =E2=80=A6 293.3 ms    10 runs

Benchmark 5: generic-delete-refs packed=3Dtrue refcount=3D1
  Time (mean =C2=B1 =CF=83):       6.2 ms =C2=B1   1.8 ms    [User: 2.3 ms,=
 System: 3.9 ms]
  Range (min =E2=80=A6 max):     4.1 ms =E2=80=A6  12.2 ms    142 runs

Benchmark 6: generic-delete-refs packed=3Dfalse refcount=3D1
  Time (mean =C2=B1 =CF=83):       7.1 ms =C2=B1   1.4 ms    [User: 2.8 ms,=
 System: 4.3 ms]
  Range (min =E2=80=A6 max):     4.2 ms =E2=80=A6  10.8 ms    157 runs

Benchmark 7: generic-delete-refs packed=3Dtrue refcount=3D1000
  Time (mean =C2=B1 =CF=83):     198.9 ms =C2=B1   1.7 ms    [User: 29.5 ms=
, System: 165.7 ms]
  Range (min =E2=80=A6 max):   196.1 ms =E2=80=A6 201.4 ms    10 runs

Benchmark 8: generic-delete-refs packed=3Dfalse refcount=3D1000
  Time (mean =C2=B1 =CF=83):     199.7 ms =C2=B1   7.8 ms    [User: 32.2 ms=
, System: 163.2 ms]
  Range (min =E2=80=A6 max):   193.8 ms =E2=80=A6 220.7 ms    10 runs

Summary
  generic-delete-refs packed=3Dtrue refcount=3D1 ran
    1.14 =C2=B1 0.37 times faster than master packed=3Dfalse refcount=3D1
    1.15 =C2=B1 0.40 times faster than generic-delete-refs packed=3Dfalse r=
efcount=3D1
    1.26 =C2=B1 0.44 times faster than master packed=3Dtrue refcount=3D1
   32.24 =C2=B1 9.17 times faster than generic-delete-refs packed=3Dtrue re=
fcount=3D1000
   32.36 =C2=B1 9.29 times faster than generic-delete-refs packed=3Dfalse r=
efcount=3D1000
   46.00 =C2=B1 13.10 times faster than master packed=3Dtrue refcount=3D1000
   46.10 =C2=B1 13.13 times faster than master packed=3Dfalse refcount=3D10=
00
```

Especially in the case where we have many references we can see a clear
performance speedup of nearly 30%.

This is in contrast to the stated objecive in a27dcf89b68 (refs: make
delete_refs() virtual, 2016-09-04), where the virtual `delete_refs()`
function was introduced with the intent to speed things up rather than
making things slower. So it seems like we have outlived the need for a
virtual function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 66 +++++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index db5c0c7a72..778d3a96ba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1268,49 +1268,51 @@ static int files_pack_refs(struct ref_store *ref_st=
ore,
 static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct ref_transaction *transaction;
 	struct strbuf err =3D STRBUF_INIT;
-	int i, result =3D 0;
+	struct string_list_item *item;
+	int ret =3D 0, failures =3D 0;
=20
 	if (!refnames->nr)
 		return 0;
=20
-	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
-		goto error;
-
-	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
-		goto error;
+	/*
+	 * Since we don't check the references' old_oids, the
+	 * individual updates can't fail, so we can pack all of the
+	 * updates into a single transaction.
+	 */
+	transaction =3D ref_store_transaction_begin(ref_store, &err);
+	if (!transaction) {
+		ret =3D error("%s", err.buf);
+		goto out;
 	}
=20
-	packed_refs_unlock(refs->packed_ref_store);
-
-	for (i =3D 0; i < refnames->nr; i++) {
-		const char *refname =3D refnames->items[i].string;
-
-		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
-			result |=3D error(_("could not remove reference %s"), refname);
+	for_each_string_list_item(item, refnames) {
+		ret =3D ref_transaction_delete(transaction, item->string,
+					     NULL, flags, msg, &err);
+		if (ret) {
+			warning(_("could not delete reference %s: %s"),
+				item->string, err.buf);
+			strbuf_reset(&err);
+			failures =3D 1;
+		}
 	}
=20
-	strbuf_release(&err);
-	return result;
-
-error:
-	/*
-	 * If we failed to rewrite the packed-refs file, then it is
-	 * unsafe to try to remove loose refs, because doing so might
-	 * expose an obsolete packed value for a reference that might
-	 * even point at an object that has been garbage collected.
-	 */
-	if (refnames->nr =3D=3D 1)
-		error(_("could not delete reference %s: %s"),
-		      refnames->items[0].string, err.buf);
-	else
-		error(_("could not delete references: %s"), err.buf);
+	ret =3D ref_transaction_commit(transaction, &err);
+	if (ret) {
+		if (refnames->nr =3D=3D 1)
+			error(_("could not delete reference %s: %s"),
+			      refnames->items[0].string, err.buf);
+		else
+			error(_("could not delete references: %s"), err.buf);
+	}
=20
+out:
+	if (!ret && failures)
+		ret =3D -1;
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	return -1;
+	return ret;
 }
=20
 /*
--=20
2.42.0


--VDRTQsY2iOnLHgbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTNsEACgkQVbJhu7ck
PpT7txAAlZm9fPwKR+O8bNwJElfdndlAsyMnSnSCW3GtcYQivvxpdIYJzKt9OnFL
dCWXEp/FyT02vrmsg+k9JIPVnF4Oo1fsuzKCOVwgsQ19q8jj/F1uFMyPdN5Fc+i6
4+cE7y97mYimGxPaJBM3yT/lAg/S10j7Z1/x3Y2Qh3ueps+FVpLdvQ/sBz1k2s1r
w7WmlddRIhCs5grKbeDuSqcvWAPcka2NxG369VcaFe9lmK6/00g98AVh3dnEaSpT
W9ce24dd4YzHEVVL/qHkV83OM92p+17lueYBS4gS2VQJbHOqPjs6fLltlBd0LXwM
F+O3sJSPz06Rto6RMxlscvCeSfhpLJlJWIFA6+GYyDBWaIduqBCJRCGXY0ctm6FH
tuNR8ZaUDc9CbsNWbvJfYZLX2lS17Q93OvxJ3ZGRuhsEyG+hss+eufjcdyewHzyY
aISNZ8W7aNlC32gUxZ2QedFqeeipzjpFioN8h0HqCWx9HxIGcKqAsZ6gS3d7I4Qp
xOR3erouKbZBvhmQawlI9riYdc2G+KgWU2TVdqXDpAWMWvooTijIB8OSaXUbV/fO
79RP1P9nJN3riPL+SZ1Gn9BQqafGDzml6ZeXKjlHI2P09Xk6o0cX9tdk5tSIXoLR
qIRzlDzfM7KN5HYNk96yy/e5qpMwvbKPeKGwYjMr4Nl6SquEGLU=
=wCt5
-----END PGP SIGNATURE-----

--VDRTQsY2iOnLHgbJ--
