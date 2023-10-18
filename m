Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123B16421
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nwudKAvl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8TTyQWW"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17E3119
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 38D0A3200AFA;
	Wed, 18 Oct 2023 01:35:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Oct 2023 01:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607348; x=1697693748; bh=4s
	e48th+fXp69l0OQoA0fajrZdq8FXobl09GBlvnhlE=; b=nwudKAvl11+zyAmk3D
	XaGGyDxeYkKqXICuOCqcbzyRRR9EUt09Yd995kLInsLsx82AnZM08gw17iRNl0fx
	xofOD+9o7an9SNd9FQ1gasWzLGr/FzCTZz4uWII5ftrc8ZqAYf7Eu5ilLp32+j/B
	q09CVHOl4+6XIx3iaLeyMEB3/gailYAjKdwmRTfz+N48JaJxF1idKsgVBqUKosuP
	TcGWF2A3inX9C4iJUyLtwICV+iHRmBtAFp6e/1+tVU+n6f8U5ejLBUEpZLfjRCzO
	ToCVIMe4XVtNys/QPREjupDrqdynG1xmAZnCDjmmKk3rdxjejhHnQ4H6LA6GuSzA
	/QMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607348; x=1697693748; bh=4se48th+fXp69
	l0OQoA0fajrZdq8FXobl09GBlvnhlE=; b=C8TTyQWW2ikgvZJCcNNjndRWHbHtR
	T/xwJ0wNSnh95aCJ8Mab+EFvWA+Rznegf7OpPr/WScYVd5vhH4judR9AD2l7Av13
	OszVFm26moJqJ/hklCzGemAw9J28A8Vqi3CcFlNYeLzBm/5iF5piRF3Z+JMXdtN6
	8cX9r5m9x3GkZllkd67ogFycLBh95frpkiZFL2iJsxCE47wJoZDPdTxt66PbauIH
	HtI4Ndn9cgR2pdR8TnVA4LccN4Yv4wblW5oEDtgiHv29SutVKfNNsNg010oayT68
	R7ug6PAZT/+kvp3A0VAyYgg1ILeRHuW+TFvJ38eMJ7lZuvt4lFs06VhGw==
X-ME-Sender: <xms:tG4vZQQF4dycdJZsaDi7YpD8i8k37jWqYHpJj0k0O5GGJT3xvoobZg>
    <xme:tG4vZdzW9pVQoifU1f3b0etn7Z8Xf39jbkHePXqaJuaplkygTRLVB2GWwzjSFeSfp
    ZYa8UnwvhhkNpwMCQ>
X-ME-Received: <xmr:tG4vZd17U3GeqnpyoJgLAZsm1TYm_17BEc12eWlpa9gg_mJ6GAy1mHER_M0rstm6Z92cT1Jdwo847W70D_jyFLcb3qBm6c0g1azcvV268ydsblHr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:tG4vZUC3c1xNuskNlr8sou56AVouzRE7qIXymJIC8I2XTciLoG4TxQ>
    <xmx:tG4vZZhKLP-9y53g1SsTrx10lyHWYckdd3qIKl8ZaG8FHSG7cqwArg>
    <xmx:tG4vZQrv5oUXz5qJQFYABj5myxR0gHWnLWK65k2cKTJDWcLH3rgmQw>
    <xmx:tG4vZZJX78fx3JK5mIbfuMMZtg9ws4XqzFV4qVyi8mNX4rnSk8EgpQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67b4a5a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:47 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 10/11] t7900: assert the absence of refs via
 git-for-each-ref(1)
Message-ID: <b99d98b00a3b4ead2e88aaed23cad778087c69b8.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D4/Wmrc8sb+oIOZm"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--D4/Wmrc8sb+oIOZm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're asserting that a prefetch of remotes via git-maintenance(1)
doesn't write any references in refs/remotes by validating that the
directory ".git/refs/remotes" is missing. This is quite roundabout: we
don't care about the directory existing, we care about the references
not existing, and the way these are stored is on the behest of the
reference database.

Convert the test to instead check via git-for-each-ref(1) whether any
remote reference exist.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index e56f5980dc4..cefecee732f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -157,7 +157,8 @@ test_expect_success 'prefetch multiple remotes' '
 	fetchargs=3D"--prefetch --prune --no-tags --no-write-fetch-head --recurse=
-submodules=3Dno --quiet" &&
 	test_subcommand git fetch remote1 $fetchargs <run-prefetch.txt &&
 	test_subcommand git fetch remote2 $fetchargs <run-prefetch.txt &&
-	test_path_is_missing .git/refs/remotes &&
+	git for-each-ref refs/remotes >actual &&
+	test_must_be_empty actual &&
 	git log prefetch/remotes/remote1/one &&
 	git log prefetch/remotes/remote2/two &&
 	git fetch --all &&
--=20
2.42.0


--D4/Wmrc8sb+oIOZm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbrEACgkQVbJhu7ck
PpTd0BAAoBeZaTPKuaRFcYJoFeyAXEsHfJ9HnytaO50o6Ke2s4sPu9j8gdLpXybS
FmSSJnN35n2DXS/FsoNTkNvTlRUhPx91ifCQ1OmGuxhiAi2CROO2Chh8kzG0ybsm
Q3Xa0sA6Lwe4EMfxwP3qNVcX4cJNm1fbb46uyR5BxwfoQ6J8t9/Uh5ED2JYuVrXt
B0Dkxi4UA/7rHhtIJJqXcL7+1CS5RjpwhnrpqoQ2rgRKO+nPvu8FSSbilEonUVda
sI/bVfSlB0xevISLDMSagMKva0tYxPnBMc1B8qD6hQyeiYPkFkdDVJCA9FWKXYOD
N1reAajM8gU0v4oQ3y4qZrS9sYuWVDvQOTWJhtucHIAUaP0IkFLsHLFtUe32GxdA
YhMmBm/rRLlIK5StdkCojBc2862mchSeAqXONLiLQDs62OxD9iNDoHfApP9aJjXj
a46+30DQLXveZUWtya4RX8AkAYD9hy5OSpMSR/zwmeMy2O5SLeE2q8lhmFMDx3rO
hMF84EVMG8EoGsmgWcY4arup1cfCBkny1pIRC/tzzk7dh1g852UHZ/Ttkz/nmOqO
k/U7LRbgR+popXglGIIMb8aJqHhr2uUCnMqeulXxQ3izCtNLBCvndaBvedEFDOh0
J7m0BWp67kQOnj07FAf+1QdarWSYLjp99tCIPTyiTQBlhmrtR6A=
=uP6f
-----END PGP SIGNATURE-----

--D4/Wmrc8sb+oIOZm--
