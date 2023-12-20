Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF381F5F5
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCgfdUqE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONkXRfTy"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6BC935C01DF
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 20 Dec 2023 04:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703063828; x=1703150228; bh=2RrOEu2ZE8
	ZgV2dcYO0vKb6laIFK3q5kveNwGJTZaWo=; b=VCgfdUqEPLERYTJv1T+BQ1t88j
	Xpa7nRAnvHmi2mzANlpvEp3Rw5HlvdqWxmzTMrFlWx+OqHmdFUaDmhdKzxqvwgZW
	sd480p/Nc+PX0FrdmGbMqkWTrxqeDCV52IhJ+aOFC8rCLakH2o+hDOSnw64D4UzR
	Lb0wilopmKCX/mWD2+9JxVP46WZbGjshozEiakZsolUlt14MUH+UvRPz8zntEylt
	iWbrQI4/A9/v1+AEUdE1YGtxqVjuZKalhCS+Eh9Yw8vA5JiXIZRXElZ1Nyof25D2
	uiXTGUeqwBO8rfkNy1JURhDErdp5YYdfdkqqE43vVw7cF16M3VbH2XvZWOVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703063828; x=1703150228; bh=2RrOEu2ZE8ZgV2dcYO0vKb6laIFK
	3q5kveNwGJTZaWo=; b=ONkXRfTy5PD5xTPR54FuqQv2+Vn5K1WlM7mRc0KoE0I0
	UX55cXWrzXoW5s/ovC5HWnmjcH8IWtxLMUJbPOAaLznZ29v/Q7ZTcZ1YYWdnL0D7
	qgw/ICnwIVM0M+r1rAShQk8V3Vnpq0yCUhKcuyd+2eOAtkbw6Er2yN4cGWLzT95P
	pyTmacEw6ozPpiCBmaNdAMwVnRj5J0msFlz1egp1svmQs01bp9uk1u6Ox961l5cD
	BfRyOPkhe6Dv1kzN55PX5aeQoWVKp6m5Jq4SkEnh3+8o8aIeExbOYnbdpaK2laKf
	mGHGrOKrCvCkqs7dmjS/KxdEYVXBiKx/9qzEbNoSVw==
X-ME-Sender: <xms:FLGCZcWPT4YcoOGNj1YAq9nI87m5BLbH12IhJkxAiKoXLt54sCX4LA>
    <xme:FLGCZQlRnVL1mKqJGHW5P4IYamJoBn5J5FhSU33rsQ4fdcbHaoldWToIwnahNXdUC
    9KecvpdfeHg5i03LA>
X-ME-Received: <xmr:FLGCZQbvdf3WRLFcxTZfnCcZfoI9wVZHbtEAE-YDSCarjBwtaHNn2nH_2iPNjkXqkXsiWdMbkB1bK8GvQvCVzYh5LUKOXIgQm1SOqN8t0KQRHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FLGCZbWVYbKP1jp_zypVyz2ZO1CrFjrM5YHQZW1qOF0EDa1OP6JWnA>
    <xmx:FLGCZWkgLdUtGlGcGNQCPWw3GX6lqsiUeN9wbmkSxvrSH3Vy3Fsq_g>
    <xmx:FLGCZQe_B7-vaUgIbOrWIsgRzeJLLYxz88WtSdHh2LSzcjAzjPvCRQ>
    <xmx:FLGCZQQ8rRgueIsToJp8NNjP7T9uIdN6pso6ujYGq6tM2foElURF1w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:17:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09cd5230 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:15:12 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:17:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/7] reftable/stack: do not overwrite errors when compacting
Message-ID: <573fb2c4fb6c97d4279058cce6aab877c27e77bc.1703063544.git.ps@pks.im>
References: <cover.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aNHspFcglaeXjbDq"
Content-Disposition: inline
In-Reply-To: <cover.1703063544.git.ps@pks.im>


--aNHspFcglaeXjbDq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to compact multiple stacks we iterate through the merged ref
and log records. When there is any error either when reading the records
=66rom the old merged table or when writing the records to the new table
then we break out of the respective loops. When breaking out of the loop
for the ref records though the error code will be overwritten, which may
cause us to inadvertently skip over bad ref records. In the worst case,
this can lead to a compacted stack that is missing records.

Fix the code by using `goto done` instead so that any potential error
codes are properly returned to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 16bab82063..8729508dc3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -801,18 +801,16 @@ static int stack_write_compact(struct reftable_stack =
*st,
 			err =3D 0;
 			break;
 		}
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
=20
 		if (first =3D=3D 0 && reftable_ref_record_is_deletion(&ref)) {
 			continue;
 		}
=20
 		err =3D reftable_writer_add_ref(wr, &ref);
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		entries++;
 	}
 	reftable_iterator_destroy(&it);
@@ -827,9 +825,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 			err =3D 0;
 			break;
 		}
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		if (first =3D=3D 0 && reftable_log_record_is_deletion(&log)) {
 			continue;
 		}
@@ -845,9 +842,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 		}
=20
 		err =3D reftable_writer_add_log(wr, &log);
-		if (err < 0) {
-			break;
-		}
+		if (err < 0)
+			goto done;
 		entries++;
 	}
=20
--=20
2.43.GIT


--aNHspFcglaeXjbDq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsRAACgkQVbJhu7ck
PpRYJA//fQ2jyfV7xxaRmn4xNVLcWPEzakfo8/c6C/VxpGcmv/YUP55eTtUWm0HT
fodeRnzuBzGmECGY2XPzNSixOPChODi5CnFJpJp//mGWoPFDoMGFCb3jVnFGx1uh
JzcMj5d3nMvTOyqSJyyMrdleu3jS/dmomPHWLspQQtflbN+zp5BdRdIx4ZyyrYPo
awN+/Dijw7LIEtyEF8PVawz9fEqjYCQf5e6uGmrZ7bP8mm6hfiRsvZcZ6JadvU7j
Rbfsm5i84AJNACeWy06OPGuLmPBYKegUJ2OCNEECHc+EtSr3PjGeLUsmENFeTpm5
x8Omrjff3mv7T9z6HtFPmcRPvNkx1wPJlMSj6q2vMNnQVgFhUKNZF/MKcxkBGoDN
9Rmqj7j5C9nkRbFTDtkDsvqn9xO8iKclO1mbL0ZfZtkJlEgFfy5wmcAIvsSzlFrJ
p8ftAa3+4gI0MAv7Ra8cplZo+QgsF1qZNqASp5nGybXK5dEl4tFQCcYa+z0QIxJu
DdMv4tBT2gOPdIfFHAxzn85T7vpjedBv/eckmKNAyK7NIqDdz5lunJJwZsXOUmaf
2Leb7wPyloM26sNgXnAxIwMMQ+NrHm7hP5vK0BFqOTVRPtcpOe9FCtAAs7mDawl0
8mcvERRhrv0d1e7F4RRUQ8x5leJVb5XYeBYom/a+sQau9Cu2HVw=
=vuWY
-----END PGP SIGNATURE-----

--aNHspFcglaeXjbDq--
