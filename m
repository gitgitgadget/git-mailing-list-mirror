Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C35747D
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tFYVryPP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1sGANEn"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A3012D
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 01:47:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 246B23200936;
	Thu,  2 Nov 2023 04:47:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Nov 2023 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698914824; x=1699001224; bh=K8
	W2Lfzuhrw+qGswr60etb591NieXmElb0DQVdVXyJg=; b=tFYVryPPvipXYGa5C0
	N9UeZ2hNO6vy8MH5XWip5HU0l3Rho+sSXECgUy85+9ttd7VNq5jLqgKsWwWwLIHd
	PjTWiYRnO9ww+YR/3eSvhVbnmLhtqbLyAmGPkS4G90eDZ8vnDZhot9CTzZgxRnAn
	Mbsu5HDmR4fFrHjKHQtEKWdELytVAx8kHtawJ3TdlLdsMR17EUHRgbAbDWcPyghp
	1jFP6tM9SEu4fs5IZtVJ+2rGu9wwsQtL7G8w6KvHJCzesEtQNOJVaMyBgGQ8gcG2
	/Qd8yGdn4QG5SCZ0ewHpLxyE8AiufpNpwcukc0OSH3Xb4JGWaHRJL9/HjaZZZt7q
	MfNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698914824; x=1699001224; bh=K8W2Lfzuhrw+q
	Gswr60etb591NieXmElb0DQVdVXyJg=; b=a1sGANEnZ73vKpfXoT2ZKN+iBwDdv
	Km0wu0CTTZVdAjqCpVDvJ+2J+cSMpwAciYGnGM+Hu4QJ1200UTD7Vpb1c5lXM09W
	p7pxLMmYUBe9+8IgSNcq0Znos2SESLq54oTzMRciYq6g0g6aQKe/VHJnYtwiQ5Up
	GYx20vQm1Dxb/S5PNkY0Q6dUtyPXCmRxCiTGbGWIWOMPLU/2uHbg3UxUkwPFCBTR
	uRVjPBCkD+QOLZBugEjemU52ReY921JcDv1vIw6wUBpkGxxv3gQueipLVJdCjPjR
	40NC1Nqfp50d3WkmyuXl5hX1rxedcFDrTMGws36TMOrQLrtG1audEEKrQ==
X-ME-Sender: <xms:CGJDZW--_SEIGdl6dQ9If9-IyrV26_-XPtkjHOa0oUskE4XuYKg_Pg>
    <xme:CGJDZWvra4pjIa3ZuXOBW8I5EgKrL5Xj0XzOKB_4AUgHz4ilTXLWg5m12jrT-1UAs
    ansLtqbzMzaLW5nog>
X-ME-Received: <xmr:CGJDZcC2ea1YK_xlemJnxTV9WmHzEm3YKG8izTdYWErHDQWzZdXsvwvdta0B-ukWpHvOJneyDEqfgrIkD2bkTuRFpVZ93wx9Y0JdMo2P1WbG9v8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddthedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:CGJDZee75nS2rlh1HTRlb7wonzxmXprr1fR10PvEf2lAvBBI5c73Tg>
    <xmx:CGJDZbNPR9rulzKY6AbQ0AGlVNixGCV4FH8siN8hQOYcfn0AkwO_XA>
    <xmx:CGJDZYld4jWFwp90gPGeiGp5R6SDY25RaWcRMg9vuFO_Wejqe6WR4g>
    <xmx:CGJDZUqLuwvsdJ-KyTNqpkCD94BCK5-YOmGk-avRkDW2xWMiGy7egg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Nov 2023 04:47:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c9c9df4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Nov 2023 08:46:52 +0000 (UTC)
Date: Thu, 2 Nov 2023 09:47:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/9] t4207: delete replace references via git-update-ref(1)
Message-ID: <3213d45b5372a225d16971ebc9dcb5dc2b1005c6.1698914571.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
 <cover.1698914571.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aC7YHLIOtt4zS1AB"
Content-Disposition: inline
In-Reply-To: <cover.1698914571.git.ps@pks.im>


--aC7YHLIOtt4zS1AB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t4207 we set up a set of replace objects via git-replace(1). Because
these references should not be impacting subsequent tests we also set up
some cleanup logic that deletes the replacement references via a call to
`rm -rf`. This reaches into the internal implementation details of the
reference backend and will thus break when we grow an alternative refdb
implementation.

Refactor the tests to delete the replacement refs via Git commands so
that we become independent of the actual refdb that's in use. As we
don't have a nice way to delete all replacements or all references in a
certain namespace, we opt for a combination of git-for-each-ref(1) and
git-update-ref(1)'s `--stdin` mode.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4207-log-decoration-colors.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colo=
rs.sh
index 21986a866df..73ea9e51550 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -70,8 +70,14 @@ ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${=
c_reset} A
 	cmp_filtered_decorations
 '
=20
+remove_replace_refs () {
+	git for-each-ref 'refs/replace*/**' --format=3D'delete %(refname)' >in &&
+	git update-ref --stdin <in &&
+	rm in
+}
+
 test_expect_success 'test coloring with replace-objects' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished remove_replace_refs &&
 	test_commit C &&
 	test_commit D &&
=20
@@ -99,7 +105,7 @@ EOF
 '
=20
 test_expect_success 'test coloring with grafted commit' '
-	test_when_finished rm -rf .git/refs/replace* &&
+	test_when_finished remove_replace_refs &&
=20
 	git replace --graft HEAD HEAD~2 &&
=20
--=20
2.42.0


--aC7YHLIOtt4zS1AB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVDYgUACgkQVbJhu7ck
PpQsxA//RohcEagS0IPjpKPaFlw8NW5TnAJiPQ5gQJy2khKx/CEivBeTOgdFJBn/
zHMEhc8HwUwA7IUrzBfew8IK/QIIR0ywYgqFekBwEuUhifO1z2sGn24XpfsYUUba
k1//+jFjZwCY5WRZPqjWug/VLZ2yeGC5fcemflhEu+Mr970qV6hVguoE+8AzR0Px
xzEfeJzFFNm6hxKq1tn2bfIFwwAbsO1TWqk+ehdk1lnu70q4tt1KhHjwjVgTYisP
uoHKbyqyuA9Agwey6+VPpfkS4yCznjT3V1Egrw0/851JZhOVUFDG0kAQDXewyfoB
UOxhwYYKnhOnLlq587Cf/hxi6DZKNKFcf39XG7W5QjAgdNuYyfT0Mx/YjCUlH976
No3Asflb7RZgLgJgzXJR9ovlTug34gwqWVJF+VLoQN+1yapJmRGwN5h6fPW5UQ2h
fplaxVjvmTsIscnnYHTeUneIcSUuuIXJwl39L70Uy3XDG8PyHXCoh95k6cDMgrDL
4FglLo1yV4ij2bM7iOFzW++XfrlpeP707kCUeokI+dK1Qy13vckZBLxaOOs/PYby
mfwhwwpyODR0VTNQ2CUuyLd4OjbhP1t/eTNrzpIrTU4M0AdK6/91GpyYAXVE0enF
+08yOu3mHEk8uyRQkVbnsH+LQodtD04GnG7DIVBfKqR0fjCorBk=
=jDiq
-----END PGP SIGNATURE-----

--aC7YHLIOtt4zS1AB--
