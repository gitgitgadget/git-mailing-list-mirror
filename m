Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71215AF7
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dae/S8zH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpGdIiQF"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097E812D
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 63ED83200B45;
	Wed, 18 Oct 2023 01:35:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 18 Oct 2023 01:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607344; x=1697693744; bh=Nc
	OpWIcB/RfVHGmvTqxuzGFNAlgYiAiNnUP4EjFEuFY=; b=dae/S8zHqqQ0BvIffr
	fHQpmaemaoFGhjNvMcwNVUrmYspz4kHrnZeZTWg/sz4k/X9Bb8L/s+JQZ8XXIHDS
	iQSpv2dIZRjV+cQOyuhAp8Kfo9HRnL7Aw3ie2lu2/F4jp8vjHcBn2zguNd6odCby
	sUwoVkhwS56Sz6dPPvaSNA4CmxRVa2V9MLPTTBLdX1srXOr+rntYkgHR6fEfJocA
	eM0APxsBnSi6Hjqoq/8tbo/GWi/iQYVVkU3rZVk6W5FEE/+Cvmn1N8kjAqI8yphT
	Pr3U0WE+Hlwvym1i1H7Dzqr8lE37J7ZsFaoGgqHJaH6FVFgK5pc03hiEzHnS2sbd
	+h+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607344; x=1697693744; bh=NcOpWIcB/RfVH
	GmvTqxuzGFNAlgYiAiNnUP4EjFEuFY=; b=cpGdIiQF/7Rl87zhj+08rpW0rpIQ/
	OR/B+Liv4vAFeHlvOFX107AAaSj4dlkdMGb6SCbVlLc7Ok0Kz8VUbS/puTHRWfnc
	H3PfAb9epCARJq1Pojv6wSrIAmk7oES1y7PM6BHaKJp9Gu9JvB28sNKa1kgXYXN+
	a9TSvUCFJuSRjNswW/c1Q8XX2ysvx5V0sZOx4hrsmo3LmoKsgUGjTHaT1DW8gslw
	HEEaQGpgwPdMAVcjy7a9dIysLTy7auGicSwJB4PVXmE3nvGF9nklMS4AsqwDRHaG
	1TyWevRWNz99UMS7UWWuGwIIh86gw3GfMv/+M3DghaGLQoEG3yI3WyPjQ==
X-ME-Sender: <xms:sG4vZcHSqvwpDCAwC6xsff7vjre7hy9gw-Qw88kT-D6SeVDxxBLqhg>
    <xme:sG4vZVU-9_1Z7mpCWBCYYp5J2bZlfeigopPNRqqigy_0HFJpW_ZUPncrOWZLxlZPh
    TV0W9LK9jH8MUC7qQ>
X-ME-Received: <xmr:sG4vZWJAAmgiSYCY9Jh4HiU5bj_fDa-6nEPKxBXNAvBNKUYtvMh34udHmAW3G71f4jwLkizP9b69TESJFz3q4zY8cUY1AbtF-NS40WVfryPLWpSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:sG4vZeHhCOovDuiwRAz3HxfBVgY_D1hsT20HYIokEOcGOgdRGfDgMg>
    <xmx:sG4vZSUXaDaZb0xgo3m6ewIYvIALSi935LKoFU5-P3HBVf_q0DDQZQ>
    <xmx:sG4vZRO1H5wmc3noNlK8icMZFmlWqZSc4xXNkx8u1AgmvQhom0cQWA>
    <xmx:sG4vZbdHviLeOnBZp-cHGqcDbP5x7nf5qchayUzvpMRjJZcRraABcA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d4d6f2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:42 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 09/11] t7300: assert exact states of repo
Message-ID: <153b5b199c8d1d5893c3ccec777609ab561cfa3b.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHEpTI2XC4s034yo"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--oHEpTI2XC4s034yo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t7300 verify that git-clean(1) doesn't touch
repositories that are embedded into the main repository. This is done by
asserting a small set of substructures that are assumed to always exist,
like the "refs/", "objects/" or "HEAD". This has the downside that we
need to assume a specific repository structure that may be subject to
change when new backends for the refdb land. At the same time, we don't
thoroughly assert that git-clean(1) really didn't end up cleaning any
files in the repository either.

Convert the tests to instead assert that all files continue to exist
after git-clean(1) by comparing a file listing via find(1) before and
after executing clean. This makes our actual assertions stricter while
having to care less about the repository's actual on-disk format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0ef7b784573..d7d9202f37f 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -517,8 +517,12 @@ test_expect_success 'nested (empty) git should be kept=
' '
 	git init empty_repo &&
 	mkdir to_clean &&
 	>to_clean/should_clean.this &&
+	# Note that we put the expect file in the .git directory so that it
+	# does not get cleaned.
+	find empty_repo | sort >.git/expect &&
 	git clean -f -d &&
-	test_path_is_file empty_repo/.git/HEAD &&
+	find empty_repo | sort >actual &&
+	test_cmp .git/expect actual &&
 	test_path_is_missing to_clean
 '
=20
@@ -559,10 +563,10 @@ test_expect_success 'giving path in nested git work t=
ree will NOT remove it' '
 		mkdir -p bar/baz &&
 		test_commit msg bar/baz/hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/bar/baz &&
-	test_path_is_file repo/.git/HEAD &&
-	test_path_is_dir repo/bar/ &&
-	test_path_is_file repo/bar/baz/hello.world
+	find repo | sort >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'giving path to nested .git will not remove it' '
@@ -573,10 +577,10 @@ test_expect_success 'giving path to nested .git will =
not remove it' '
 		git init &&
 		test_commit msg hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
-	test_path_is_dir repo/.git/refs &&
-	test_path_is_dir repo/.git/objects &&
+	find repo | sort >actual &&
+	test_cmp expect actual &&
 	test_path_is_dir untracked/
 '
=20
@@ -588,9 +592,10 @@ test_expect_success 'giving path to nested .git/ will =
NOT remove contents' '
 		git init &&
 		test_commit msg hello.world
 	) &&
+	find repo | sort >expect &&
 	git clean -f -d repo/.git/ &&
-	test_path_is_dir repo/.git &&
-	test_path_is_file repo/.git/HEAD &&
+	find repo | sort >actual &&
+	test_cmp expect actual &&
 	test_path_is_dir untracked/
 '
=20
--=20
2.42.0


--oHEpTI2XC4s034yo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbq0ACgkQVbJhu7ck
PpR0BQ/+M7oLPzJN3QIkmOKKmykVa5KvFSouOhUEUzZXOCua9s+YiOCrUtEdcK7R
MuKFbgthM4IYl5BYR2VeCRFMSkmpnBaYXqfAysyffeVKKIIBKiraE9CAcq8qyEkp
TGyU+j3PB/PbT7YBLVIC1ZW9a9/2GN1k+Xc0QKksGF3BpYt1aObes8+FhJETLff2
/pYi9mVA5tv6GFo9gQ4nOSo236HBX7jIb0Eh9r8xBLTySwRifkn09v+//+4V0I3H
rB1NCTICc3ltxJ7zlPHgqD2TL0oNKliQVR8yRPF3ecIPjJXTazZt52liqKIX58i8
MhMlIfPopUi/ILfJfhvYgLeqFsg9vSElTPbnbXKc7GEBX5muTkVn+AgZY+o+ndg1
jMtTx9icuRtL8eD3rpcZhHowFnOozJhZkJhHIV2M8c0zJBpakN1mUJ9FJ9wc6cRE
aOzP67TYZU7smeVVlkY8oBvxZssr9pkgWYKSmzculayVnx8UtK2EXjraXaFDUxkI
It2QgmpmW1sG4oNSb5YxspVj3NThpa2vYqgf1mhtb3J66cock/IaXBwHX3lWCWQL
bnhO5oSZsq030VS+aoVTv7LQvWiw1V37C37UlmwG8JMi/nBp56MssAFBEkJeVOkC
JQKG5IGI+7dDcH5EX5wOXoo3tO9FWRDdMyDbNC9N+7aN6nbNueU=
=5Ox1
-----END PGP SIGNATURE-----

--oHEpTI2XC4s034yo--
