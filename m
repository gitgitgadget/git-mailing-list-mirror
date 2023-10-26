Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D612D02C
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/C2gXBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S8XKkgDF"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7C1AC
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 02:56:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 9A34B32007CF;
	Thu, 26 Oct 2023 05:56:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 26 Oct 2023 05:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698314196; x=1698400596; bh=jF
	7JYayKS5xis4M1MmJCAK+0N/nnCO07b9MkD8cu1x8=; b=I/C2gXBCDLoen+N1Pq
	QOZfQ0feHyFTHILV6Pok1bsvusQi9vxRFUXKOJEju6H4dhMVr2iQRKjO98pA2VlN
	hK3gkR3636xvcfGce3uCWYT0UY7jXyQ7qS90hLKvViXIK9VFHRg7dBDkzvolTuI5
	mZXlFTyARHu3dzMzUmRauBJtO5BZfUXJ7sSewjssthdY3gViaW15w+0qRzCOg1kb
	UYcTi1EWjk9xQyDoUX9YSEh/ypRoYzNElBmxOoejJVPjkUCpblEpgJk3RD/e88jd
	NzrBsoT9XccHiLLWe0MQxFPiBR4jMgVRSisz1y7pgUZWMOMizaqR/hurMaGrfp1k
	F7NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698314196; x=1698400596; bh=jF7JYayKS5xis
	4M1MmJCAK+0N/nnCO07b9MkD8cu1x8=; b=S8XKkgDFl9WSfDY+GiKWaIwG3chIZ
	lnFW0YU6aYTyvS2v+blC8igNwTwkBDhNDsKnTFPEy0zXfsVkmbwX1xd0I6WyJZzs
	JJgVFiVQC2ZN2LcZJuUJF+5NXh/DrDQv4oLqrpK5GKj+9VqzToC7Y96rh2GOy2PN
	O/9289gUJA485q3yWjtRDardMm5qciAGpF2LxOnGPZipEJvLlfGnWponqamHkFd2
	Vazn60ASTv7lUcXFdpAOuPYfwr+F+I1/SQTZ4Czi1RYl0MVK8N/AaBG5ts4OEoFy
	F9y4/fkjbs/hqiYwBkAXZ5h/cebsV6cxR03ndMU1t3H/pk0JtaTTT5Rqg==
X-ME-Sender: <xms:0zc6ZSyu58O6s7CvpJCQBBUxmDUPjZejbvIekFdsJGt7MDQT661xtA>
    <xme:0zc6ZeTMppDDWc1J8opxwQl1OYfqsQ-1lMHDnRPTgYunz9kKZdyTluIx5DCuFT6Av
    ZUdfX-g1dz2F4VEFg>
X-ME-Received: <xmr:0zc6ZUVtqgTWH481Ati-7EZQF08UwXPmesV9sidi2GQVdtk2KecWyX2MAqTXsME1RHCyO42GKU2eEPb6YyH7WOXaEGeskKjokxTgcYsBjh4Fzls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:1Dc6ZYjwO_FRe6fC9hGXl7bbJlTS9r5K9NFDFoGziIzQzqqrzcbD4Q>
    <xmx:1Dc6ZUBeQ3p4fv3ubU4BRYRnWljrKxFFcWH_DgUp2ExUj5-Afq43vA>
    <xmx:1Dc6ZZI9Q3kerRI2bgcRecPACDSdHitewUNf5id-W_5ba5-TWqhBOA>
    <xmx:1Dc6ZXPzQ7a78z44Zx7l76492ysWyuPFd20SS458tRvQpQz1A7d7Uw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 05:56:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c520dbbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Oct 2023 09:56:26 +0000 (UTC)
Date: Thu, 26 Oct 2023 11:56:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2 04/12] builtin/show-ref: fix dead code when passing
 patterns
Message-ID: <87afcee830caab2782ce693c1f961df6fea6e7b5.1698314128.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="soEP+UeU5gYwk85E"
Content-Disposition: inline
In-Reply-To: <cover.1698314128.git.ps@pks.im>


--soEP+UeU5gYwk85E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing patterns to `git show-ref` we have some code that will
cause us to die if `verify && !quiet` is true. But because `verify`
indicates a different subcommand of git-show-ref(1) that causes us to
execute `cmd_show_ref__verify()` and not `cmd_show_ref__patterns()`, the
condition cannot ever be true.

Let's remove this dead code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/show-ref.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index e55c38af478..f95418d3d16 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -183,11 +183,8 @@ static int cmd_show_ref__patterns(const char **pattern=
s)
 	} else {
 		for_each_ref(show_ref, &show_ref_data);
 	}
-	if (!found_match) {
-		if (verify && !quiet)
-			die("No match");
+	if (!found_match)
 		return 1;
-	}
=20
 	return 0;
 }
--=20
2.42.0


--soEP+UeU5gYwk85E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU6N9AACgkQVbJhu7ck
PpTBog//Twe41m9qj29RgGDaJTVYiCGoFWrlT4G3W3QlL32VbkjdKepkGJ7CQo66
6KBgdzm7YxJCrWaNOYcq4t+lbuTNWsAQYE1SMri3Jn6pttIK38R3fsoIrbbOFVge
McjPyDgJoXwT/WzS/6zNo3zY0wzw3d3UTXzDqeoxMZiTj5vlWYor75nvdT5wFuLT
pYqTtbpHKSpBLqIRNsp3mhNgS6BD04w7yjBQ2v3pjuZp8m30RGY54K8P3V2jA7kx
1DGGcdD6cVlsBTqTK9h+MddWVZ/DL9p51QgLfsMiVrQA3AKQsl/SAaW8JZ6qz34X
VYrhbSVtw9kc5XoRon8+y/YXbuOs8kFoGa2QkFrneVjMLvWYoy82o5Pi+5UiJVzz
B52qRP9vo6r3NrRl/N/batZzoKVeFk8N8fLH1JDYDqE1xy+kZlOa8IawVRtJyW5I
ex7FVkibrCmdK8HSme5l6KtLjlWIBc09klaxMAUDWb6ZLqFABJMRy0kXc/IJtX/b
4halQ8G4yA2E38+EFHysUe4p1fWr9bHQ9HXPriCd3GkU89kjmNAUiyd6mI4MFPQR
FF8yRWyHRZB7+lB/hetpO6V8HfMHPwYWYSaHgADXCmbrSH9hiSRbOCqWveqAgguG
88iDQJm6LH+hsZ6ZAYgVxmM0RV9KE4bJQu3EalN9IpZKbybwKrU=
=Slq9
-----END PGP SIGNATURE-----

--soEP+UeU5gYwk85E--
