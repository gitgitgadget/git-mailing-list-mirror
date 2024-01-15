Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66312BB00
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IiVL3DKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKSpicBC"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id EAE165C014E;
	Mon, 15 Jan 2024 05:36:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 15 Jan 2024 05:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705314965; x=1705401365; bh=NMggkPHpcr
	wZ5mqgaV0NugbexY7ZTVt6sQ/Hw/6hP8w=; b=IiVL3DKG6k6o+aATvuYQP6tC1N
	fjPr1EktwNbUUgaXn2OUgCAFbgomS1tKY2xdx+llO1Yt4oErFR8nwpSzAi22cCjw
	n4lbYpgDb45pc5N3GRHkIFfJ/OZajt6BdY2yMfX20vjMygBhkZ6rI54mGqN8Vqkl
	Ghpv/TgEiySgXSXIIhEcWBLIYOFQz6ltNoxCQWaUO6kUeWM3u1DZR6VU/Hd4rlmv
	mqAfXDQNXXLD61+Ul1EjJXWy/Qh6lY35XTm8tymGhPed/sVYo3KIY8BMr72/5gZ1
	dgXWHclpwG1SbDaCXrCGMWWOOaXTjrkKitE1ePDTOJQEDettzvu8GJXlQNRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705314965; x=1705401365; bh=NMggkPHpcrwZ5mqgaV0NugbexY7Z
	TVt6sQ/Hw/6hP8w=; b=NKSpicBCfvIaHik/2AByqD/pheDWmEj3eOus8OIFoXYi
	EJMldqtrK+xHyu/2MGQAFjQ/SSy+xGBaB0dVb/XsTkISmCL6/dQu5vCX3XXRAZkP
	+W5Qg9nZ6GVcTuTAihga7Ep2Yjh7UM45uTK+EANDNzHvuU/oWNgelvd59MgIGjNp
	/hUE/PE+85s2UqkuHh6QmhxqLko2/8KKrgZtsedmmZmnD7h3o8YiLpbQGs89aePy
	GazH/jk04zcEbTHdg967XOht7b1wCMENApOKOi1JY/yJZBco/qncg40b8jp3lV2P
	9HJwYMEwp6CG5a1MvGpY60ZAvZ+0rwcOghpOJGzSlg==
X-ME-Sender: <xms:lQqlZU2INOcGbQfE-mogGQNuubBIRjVhPZMhpABuJiZcfWpUUGz96Q>
    <xme:lQqlZfFSxViuceJ1UNZZidER7nF9wlk4JtpWJHi--tla75kgOq7h3fLentK98S8Rz
    1XhO0DsgxECEV8oEQ>
X-ME-Received: <xmr:lQqlZc4uFYBkfTce2ILAHmsBERXZIGeYeQzOH2ERWlrBWk_ulU25ntQMl5Otx2JwuLBF0T1UbCYb4cRVj3zEo-jW1JshGCDJhzsZgdpS2EqdsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lQqlZd1t3Z-2E5x1wmQfo3IIF2lEHHTFawLQSoD19HNbz11yQ5OueQ>
    <xmx:lQqlZXEZ_CtsmMRgJPzADreTlYgxhFQ33nhxY-ZGvIWmwZAdiI8sLg>
    <xmx:lQqlZW_3RCytj0JoDOiy0rIGuTdo9XJW_S-NP26GkQiSf2V4-8vplw>
    <xmx:lQqlZbjEJ99IbRfaRtZbr1jsI4AM2hAjwCmUdEM4DA8KNSmazpAIdw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:36:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16b558e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 10:33:14 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:36:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] t9902: verify that completion does not print anything
Message-ID: <84b3546a8d8961ce77a2d55e67b91c9d61bbf351.1705314554.git.ps@pks.im>
References: <cover.1704969119.git.ps@pks.im>
 <cover.1705314554.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KcqAoNnpSMt1qdbF"
Content-Disposition: inline
In-Reply-To: <cover.1705314554.git.ps@pks.im>


--KcqAoNnpSMt1qdbF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Bash completion script must not print anything to either stdout or
stderr. Instead, it is only expected to populate certain variables.
Tighten our `test_completion ()` test helper to verify this requirement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t9902-completion.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index aa9a614de3..95ec762a74 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -5,6 +5,12 @@
=20
 test_description=3D'test bash completion'
=20
+# The Bash completion scripts must not print anything to either stdout or
+# stderr, which we try to verify. When tracing is enabled without support =
for
+# BASH_XTRACEFD this assertion will fail, so we have to mark the test as
+# untraceable with such ancient Bash versions.
+test_untraceable=3DUnfortunatelyYes
+
 . ./lib-bash.sh
=20
 complete ()
@@ -87,9 +93,11 @@ test_completion ()
 	else
 		sed -e 's/Z$//' |sort >expected
 	fi &&
-	run_completion "$1" &&
+	run_completion "$1" >"$TRASH_DIRECTORY"/bash-completion-output 2>&1 &&
 	sort out >out_sorted &&
-	test_cmp expected out_sorted
+	test_cmp expected out_sorted &&
+	test_must_be_empty "$TRASH_DIRECTORY"/bash-completion-output &&
+	rm "$TRASH_DIRECTORY"/bash-completion-output
 }
=20
 # Test __gitcomp.
--=20
2.43.GIT


--KcqAoNnpSMt1qdbF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlCpEACgkQVbJhu7ck
PpTWGg//bY677tbLHNj8dlJ5RPXg+A42hLaicwAJkZ+3orh8gE+aE3BK2cny3HKc
eshksqgEuLlCIQc7jzEOstLg/da7DgwIsi3gVZ2DK35Cd+kkwb5yy2sERh1zrdsM
a8fCS/CLhetZIPz1QzqehuqnXhozRQPUNDPHSPr0L716bsotFesgWNOm9u0CAqau
fYUevd5/EIcAvNd8VyCNIUAdrNVaXMi9tWBT/ZY3pFFjGYbnQytgO+911SyB7kTy
uIIs9Nib2BlDVTI07yi3BBYeCRAIw5Aj+jkuwoXM+Ddr86t6yLnexz2379V1TUZU
yy7QbQo4oUoAZjFvxChjRxG4KqmiNI1hi20+2jfHqJYDAxWl7N9wtF3bOxCQwO9r
LnDX3fJln1eAmSA0TwCKs1A1OPiuVVhde/p6xXHjw3lWECsdX6mTcnF/YSzkkrJk
n5xRKbR6BnC+N+hWr1dx3r9T2z4+hdWJsaqAk8snZ5JAmYXLO5FD56lwXkapmpo2
iyNdNt54H5KFL9BlVZ/3BsgzRsnPZgEIxZWYxwRgPY/uF8lv72GCO8N46KPdnAF/
hmmcHCN+7BacS5eYPhHWaqzBVyRNHg8mAqn0ufSi6ok1riqbnjkXj1t7gKNAbmA+
1Ily33ods+5sUEOG4pgj9+SVqmJjY2OiN19FHhO+rZut9ZQAbbg=
=tiXW
-----END PGP SIGNATURE-----

--KcqAoNnpSMt1qdbF--
