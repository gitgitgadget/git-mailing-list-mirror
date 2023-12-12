Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lq0pTI2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="caFZAxln"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15ABF
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:18:56 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id AD2283200AB5;
	Tue, 12 Dec 2023 02:18:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Dec 2023 02:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702365535; x=1702451935; bh=zg5jK5ENLK
	ikWkpEIKkASgSUD0I+VfOR8qPLyKGmINM=; b=lq0pTI2Oss3GjiWRxleu9SK0rB
	HBZrTm1+HSILdtJOaYVEVHO+xL1QEAQzY425szNJCtE96nQAGm/VgRp6ub/TpYV9
	FOYkTf9Ae7WE278OsXDaRHsZhi9PZEg9cAGhrPOdwhtWguxo44wtje1oSCCmNpz8
	TB92Bmv1W1Q3GRQaL2ezg94lnBnz8eMJyLffhUWGc8InQ3aowFoaVK4RZbIzDHTK
	KUolmLdFcSf1rc85TcvNTybKBNynhBVk6uB97Wd8V/yZBsd0a9f8UZZ7mlJyIwRk
	ZD1ozMmN3Rz1uoFCgkVxkHdxBrop32DjQVgrVnP2e6VA9gnkBfrT+YijG/zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702365535; x=1702451935; bh=zg5jK5ENLKikWkpEIKkASgSUD0I+
	VfOR8qPLyKGmINM=; b=caFZAxlnMpSHkUXZ1W2WA5Ob235JOAx3APb5xtzaNcmy
	7TWSXLQePZDnfoMOGtLDHOtnYvXNQ4tPX1TDc2UeVABl/SlJSv9vfX6+C5Y7diVJ
	nUHx1ErfJHUqES0NTFhrSULkodb7sUg3MkaHj5cCYS76+jXoyekk7jN9RlSqD7IX
	w1h6jtE41ObwyrhMoTv7bwajrROKLjkKQ9xwmf0lLf5rr6oZANJB+pnNJueD8SE4
	dSffKCX/mgoWLbSVEekI1pHbto4e0t7tnRVX9IStYNpFxxOb3ZmagwrwdzRtpW2e
	1cikJ/biIl3Ib2Oaavv1+Ph2ucBffSXdSZDoVPl0gA==
X-ME-Sender: <xms:Xwl4ZYoWAYToTpLfIuT3Im76kqa1ckkBMPw9lSxl1bfGMLO9uyRmtg>
    <xme:Xwl4Zeqw5Omqe2TTpMGOE0kmOq7g1Tzmc1gVh7BQ2OI1azGstdxbc59lPBXPT5wbR
    6aB6l8UHc2iWhBDOg>
X-ME-Received: <xmr:Xwl4ZdPnaQiTWs6qFjIcMyz0NtcbXTYyUD66QJAVaH3-3DDgSS6fJ0d2GV_SnWZcbQmMluC0KxD8CCSPIyLCAH7OuXQsXUmIYpHNfOXaeezY-VI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Xwl4Zf6yxrAHs2kNdcshnudKF_Z0NT5cR0Wrd1Vaxl_9T0KJc46HEw>
    <xmx:Xwl4ZX4u1ksbZW3ormMhlIysCwbQWXnhq9rXzhAUNQB1mzJL6UAbWQ>
    <xmx:Xwl4ZfibBVkxzx4e8bAIJMnvd6-KoNpxOfxVN1G8aFlqXgDEeBAWUg>
    <xmx:Xwl4ZRTg1e70WWdTkg-7harbc-43Y31qn3KvNbCzwZZM3UJtBIdIcQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 02:18:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f5edc6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Dec 2023 07:17:16 +0000 (UTC)
Date: Tue, 12 Dec 2023 08:18:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/4] refs: propagate errno when reading special refs fails
Message-ID: <24032a62e54fb37dad46c3ede7151efc8a7a8818.1702365291.git.ps@pks.im>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzs1TlRac3EWuJLD"
Content-Disposition: inline
In-Reply-To: <cover.1702365291.git.ps@pks.im>


--xzs1TlRac3EWuJLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some refs in Git are more special than others due to reasons explained
in the next commit. These refs are read via `refs_read_special_head()`,
but this function doesn't behave the same as when we try to read a
normal ref. Most importantly, we do not propagate `failure_errno` in the
case where the reference does not exist, which is behaviour that we rely
on in many parts of Git.

Fix this bug by propagating errno when `strbuf_read_file()` fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c              |  4 +++-
 t/t1403-show-ref.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index fcae5dddc6..00e72a2abf 100644
--- a/refs.c
+++ b/refs.c
@@ -1806,8 +1806,10 @@ static int refs_read_special_head(struct ref_store *=
ref_store,
 	int result =3D -1;
 	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
=20
-	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
+	if (strbuf_read_file(&content, full_path.buf, 0) < 0) {
+		*failure_errno =3D errno;
 		goto done;
+	}
=20
 	result =3D parse_loose_ref_contents(content.buf, oid, referent, type,
 					  failure_errno);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..66e6e77fa9 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -266,4 +266,14 @@ test_expect_success '--exists with directory fails wit=
h generic error' '
 	test_cmp expect err
 '
=20
+test_expect_success '--exists with non-existent special ref' '
+	test_expect_code 2 git show-ref --exists FETCH_HEAD
+'
+
+test_expect_success '--exists with existing special ref' '
+	test_when_finished "rm .git/FETCH_HEAD" &&
+	git rev-parse HEAD >.git/FETCH_HEAD &&
+	git show-ref --exists FETCH_HEAD
+'
+
 test_done
--=20
2.43.GIT


--xzs1TlRac3EWuJLD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV4CVsACgkQVbJhu7ck
PpT1fA/+NzxxObMa3v1RdnAXZJ4ZKo99cXY/bs2ZI6EcxkpsX0A/AKoUlGH9gkL7
k9h4htDdcGJqCPhceuawCMVCDS5rKRRHy3LiKa0/zw4tQgeI1ZTSQcf0vQ8L5P6U
UzjjIqIn/Y2pEtysy+Dl+z/euzXKvlw2YNaoFp6E9jIZf5j1BSH5vLQdrJALQV+0
djA3PE/IjhYnUy9gAEiLfyB9lgu5ZcC2WehLFuz/vbcSSN6tPLWQrl/WWUFQ6xbc
crQDGweOIzKIORw+Hz4TvuSWQc1Y1pJJM1W6AbPuo4OJGhBl5obKxCDECGBEqcxC
gFwVWiJhSCwmzWPeTv+2T+wQcU4H8isaUdd66xbttj5B4o6aewhxZ+pit0sHzwXA
qVinDTXZzMjzaHNgXIcTD65add/h9f2BjbsdyRfJPszxYv9Je1GO4b63XTKJp/J+
K5ecnWBqJZDTBr3cYtut552X8F34/Cr+82Im37fzWCWPZE3c5tfckDfgpF6mRpTK
yXguwbL8DT6F2iSAcojyPmxA8d+/TJXkoGzdPygChdL4HHvc8M0g4OWLO5HUSEFu
QBzCLrYOqRdqC2WEBXL+4D6eTckXDhAMWz7zsiucCXMxZxLkWE/Uti3bKTSvijrn
QDsrT7K+EsXDTUpzgEYeXChtEJ0nONu3qzcDWorvwLq1qxljBQ8=
=BEt8
-----END PGP SIGNATURE-----

--xzs1TlRac3EWuJLD--
