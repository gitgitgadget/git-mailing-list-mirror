Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PhGI/e3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HSuAWmvR"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75DCB
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:19:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C1E4C3200AC4;
	Tue, 12 Dec 2023 02:18:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 02:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702365539; x=1702451939; bh=WwP8CMaFHh
	nhU+nhL0FNVUUXaurPeUYe4TLb8Xjcbko=; b=PhGI/e3+MZfs7tqDFtwVR7c4d3
	Txzw8Uzlszh8rA9hQD727Jj+QQDkNOt+kU1494UbWOmKM/pej1M9izi6moPcV2Li
	NW368hVgD/sFzHC/YoFgKsk6O6u3+kMv6Z7I8Z47zwKJPkV3Ph0N2SAz5YimEuLt
	jQl3lZlKTiykzPZLfywkZpumAOyg9UfHxxhwJSNX2bArWXA5gyS62FrEGJvE4aJU
	Tg0iL7ip7TfwY5+ZV1abeyCHNrBRXvu7ZSy+HZ2scv9vDvi6lTo6wmohcIRMCJ8k
	zkBL+XQ6uRN8yNBZD+EdoeWMNBY1PKk+YzBBYHWb/uEBuyLLFdzwMQCHGAYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702365539; x=1702451939; bh=WwP8CMaFHhnhU+nhL0FNVUUXaurP
	eUYe4TLb8Xjcbko=; b=HSuAWmvRC3Ast9570ZTUbfyuC0SYR4Gn41eV2gTo7EZ/
	Mu/qoIoSrqrH6ztGjSef9cCuzSAisO/sST7cWPBZEcHfTP7l8sLIW726/RqsjSTT
	G3bK7GzuoorBXy5wJUcXfQDssQi/GFWR751MC+BYuz1M4GS+dXBGONzNC8bX6dAn
	oXKSo5Q+cMTWGjqKyjEqNuZyXNTUOZi0i9j/drW8234p5TOm1DAzuA9DdcETz0xU
	kstd9VvydbwUEYJa2DlDvE5cX0fbURBcpMb53RP2qSAwRQ6LfrhskMUt3BoUA9mq
	CKtFP08C8HMDxw8FA8gkI4Od43T0txDJJqNuw5H7bw==
X-ME-Sender: <xms:Ywl4ZU6ze5zwZg892xnYWfXo_7dmwwNAppOoMAzBtygrkdjYOOpILQ>
    <xme:Ywl4ZV6IoftQpQMbtmK4WulFNU5w4vZGpT3wwYSntjpEv2dvWU3ckNrldeWIzhPwq
    RzhJxI6IXJhc8Ykpg>
X-ME-Received: <xmr:Ywl4ZTfcU3Zngbvo6A7s2RGuZqt13oPUtOW-0rw4xEqd-Pv8svx1tP2srfWvwCqefeFqGEayhuSX3K1UwZGQGWrI9udWaA8SZDEPoHd1vgZsgJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Ywl4ZZKZJbOBHNAdJav5K_GJQFeHNhOcKl59I0YKYCNeBh04vqbVew>
    <xmx:Ywl4ZYJT13lZYnASqXLXznregchgPbbstV49IAWDfekDNVY8RAQsCg>
    <xmx:Ywl4Zaz2c46MWONJ_zpDdAPFPtCJwMHDB1bfGr308qp5oGIqSGCEmg>
    <xmx:Ywl4ZSiFq21VS0rhBEL0F_817n9f4ZIf-7ldk70opqWk8Xjxk8jcTA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 02:18:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd4dbb52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 07:17:20 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:18:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/4] refs: complete list of special refs
Message-ID: <3dd9089fd59ca27759dc445664811d52273c8e94.1702365291.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R1wUaE3Afj/ayo9F"
Content-Disposition: inline
In-Reply-To: <cover.1702365291.git.ps@pks.im>


--R1wUaE3Afj/ayo9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have some references that are more special than others. The reason
for them being special is that they either do not follow the usual
format of references, or that they are written to the filesystem
directly by the respective owning subsystem and thus circumvent the
reference backend.

This works perfectly fine right now because the reffiles backend will
know how to read those refs just fine. But with the prospect of gaining
a new reference backend implementation we need to be a lot more careful
here:

  - We need to make sure that we are consistent about how those refs are
    written. They must either always be written via the filesystem, or
    they must always be written via the reference backend. Any mixture
    will lead to inconsistent state.

  - We need to make sure that such special refs are always handled
    specially when reading them.

We're already mostly good with regard to the first item, except for
`BISECT_EXPECTED_REV` which will be addressed in a subsequent commit.
But the current list of special refs is missing a lot of refs that
really should be treated specially. Right now, we only treat
`FETCH_HEAD` and `MERGE_HEAD` specially here.

Introduce a new function `is_special_ref()` that contains all current
instances of special refs to fix the reading path.

Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 00e72a2abf..8fe34d51e4 100644
--- a/refs.c
+++ b/refs.c
@@ -1820,15 +1820,65 @@ static int refs_read_special_head(struct ref_store =
*ref_store,
 	return result;
 }
=20
+static int is_special_ref(const char *refname)
+{
+	/*
+	 * Special references get written and read directly via the filesystem
+	 * by the subsystems that create them. Thus, they must not go through
+	 * the reference backend but must instead be read directly. It is
+	 * arguable whether this behaviour is sensible, or whether it's simply
+	 * a leaky abstraction enabled by us only having a single reference
+	 * backend implementation. But at least for a subset of references it
+	 * indeed does make sense to treat them specially:
+	 *
+	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
+	 *   carries additional metadata like where it came from.
+	 *
+	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
+	 *   heads.
+	 *
+	 * There are some exceptions that you might expect to see on this list
+	 * but which are handled exclusively via the reference backend:
+	 *
+	 * - CHERRY_PICK_HEAD
+	 *
+	 * - HEAD
+	 *
+	 * - ORIG_HEAD
+	 *
+	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
+	 *   rebases, including some reference-like files. These are
+	 *   exclusively read and written via the filesystem and never go
+	 *   through the refdb.
+	 *
+	 * Writing or deleting references must consistently go either through
+	 * the filesystem (special refs) or through the reference backend
+	 * (normal ones).
+	 */
+	static const char * const special_refs[] =3D {
+		"AUTO_MERGE",
+		"BISECT_EXPECTED_REV",
+		"FETCH_HEAD",
+		"MERGE_AUTOSTASH",
+		"MERGE_HEAD",
+	};
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
+		if (!strcmp(refname, special_refs[i]))
+			return 1;
+
+	return 0;
+}
+
 int refs_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		      struct object_id *oid, struct strbuf *referent,
 		      unsigned int *type, int *failure_errno)
 {
 	assert(failure_errno);
-	if (!strcmp(refname, "FETCH_HEAD") || !strcmp(refname, "MERGE_HEAD")) {
+	if (is_special_ref(refname))
 		return refs_read_special_head(ref_store, refname, oid, referent,
 					      type, failure_errno);
-	}
=20
 	return ref_store->be->read_raw_ref(ref_store, refname, oid, referent,
 					   type, failure_errno);
--=20
2.43.GIT


--R1wUaE3Afj/ayo9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4CWAACgkQVbJhu7ck
PpR2ChAAlGSZ5GuQlSLySaPgqGcsxr/5w3OVIBGKTECkKzCUV6TRV7aGQIrfVQs/
VnJjKk9A3Hfa8b/CVfimO9/SKeszeVGJAkT0wPnlpTMl1y/dHFSXG/lTaKznSAYE
BOCyd+IPKBmXWAY4wAJx3H0yQ6ZZy+YtAP4BV7h9unL6PIEGjV/xCvyIXbZ0BpiJ
ACQpksigXDGMnQ+/dMooUkoORjctYvVGmW5H88KLZHNlcMU9Z3iHBAiXxiQjTsLC
QKNgEorgLV+StE0hbyjc/hM36JAM4YXKGL+R/wS6vZ8Tvta2ScmcNaTdi+9T919h
xveLZnmr9aOH/yjbEotllfVtuunP6CW07WDRX4vQJ/v5Se/6spq/g3Q2jALq2avP
jorI75wt7In5CbxC0ys16SgtC9zRbESbCf0fm3UPVJVGS+BVZNnRcRRBPysAc2a+
mxn35ydPyFedXDFUkVC3ShzIbY30WS3JccITjo936MzXG0RbCfTQ3+V41Ns2HH9F
c8bpgvcfj9c9adoP2GOdBJi2rNb+PMLprek6AK2WvyHs2BIeY0+gggnKpn1LjCxn
dsw3PVXtTqnt7/GP+Nik8n6CREKFy/YiO0BoEig7ITzNzvHfs95T3gzKNUp8spud
yWCEq8oWvOqkAlr/9LVZOXZ5dDohDAAIoE0w+xinffV2H0a1SvE=
=07eT
-----END PGP SIGNATURE-----

--R1wUaE3Afj/ayo9F--
