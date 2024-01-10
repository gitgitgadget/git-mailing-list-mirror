Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95B3D3AC
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GKHFAHks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3dbJOcA"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A1CE13200B42;
	Wed, 10 Jan 2024 04:01:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 10 Jan 2024 04:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704877318; x=1704963718; bh=bdrLr5rn+L
	AiMM3toT2I+4GvvVDnK4O14dnvBBWAxfo=; b=GKHFAHksglmMAg64WqdZy1KJww
	RrJpkh/pmliXYO4hB18FqhEXqrH3mP3vHfJqgVW510lYm6SM4gkvZe2X3c9DOGus
	LKn/nFxaflOH7KP1g4YIDXtHNB7m1rbW8n17TOESqRGkWP+7G8RxeM7J9hQ0MIlG
	A6OmBEng7voSyv70jlsyc6oCX5ZAyGiz+EeuAh6f/1uCl9DzUcjCaFi6+2Oe6KYd
	dxWtCiD6J+o9SdXIfzF25RsPfk1hZN9c0xEKmm5TeXnP6R/g5ZpxRfGCKmUD1QsS
	nlAVmVQH9aVKGB7PB09KHQUJXyXukHCTuJTRYUuiO7GxiO0Bo47KMV89s1ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704877318; x=1704963718; bh=bdrLr5rn+LAiMM3toT2I+4GvvVDn
	K4O14dnvBBWAxfo=; b=T3dbJOcAPuhnLoVpfiR4s3CTt2izXChGy+FCeyyV+C5f
	M94Xd+mru4VzIMoAYZd3dKdrFq/GAKEbcfRauSbMUVNMenriwL20uVLOf/ICKZrK
	En3qTO5Bm2I2lMcSuESnNubCl9Rbv6g5A/HRBAPKGXqIjaI6bz6PtuOErT6sbxDR
	+ShgPLnNi2v36amQD2CQIM28uISIfFglzJw64vxOQvE/1c94tjk4F8RiVCgKFXyc
	cDtNp6iv7R59+dwBm81yEOJ2IkIjrEBCYcUOekxqRv9/LHZb+sjmmLWP33ahuAXs
	o2EM7YLt/jYKdRu0BqLLA1EAKmHkAHtfeiFwbR957w==
X-ME-Sender: <xms:Bl2eZaA-dgxE08-_ZARKcGn8SIw_q7VvmA4r4lc3mf4Gm-ZztVKvCQ>
    <xme:Bl2eZUiGEk4HQFyV3z6mEmC5-ynKuV8Z-8_FEgJLgq-xx87u9KubglkdYqulbnvZQ
    lDMp3NaZz1JSfGTIg>
X-ME-Received: <xmr:Bl2eZdk0SBRsfi6eog9Jzu94Q9HWBGSrS6VW3BqelxME1Sbl55uxCGtJVA8whqJP16NOfzQNMt-dXy_2kaEz9hTPQkPTM7v_0Cffb2L-HZdYrxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Bl2eZYziKK3zca0HRAl6ggW98aF6U6gYtqE0MAwxoCaKiINzW9BMvw>
    <xmx:Bl2eZfQBRvNe82ZrjnvYZhjLhbq3mQvaj5K7IdvfPidS8KgMqA425w>
    <xmx:Bl2eZTapZmD44NqgKHJbGipWm4kh8zC0GkfdBVxZJwESctpLudnb0Q>
    <xmx:Bl2eZWIzjYRMNtGI_G1Vxzdtf3592AsOUVOyZdZ0lq4mA3dwz87DiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 04:01:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3bdc065 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 08:59:17 +0000 (UTC)
Date: Wed, 10 Jan 2024 10:01:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/6] t5526: break test submodule differently
Message-ID: <ae08afc459229aaefdd166b5e55724b2a98c0d1f.1704877233.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgXYeaNGu1JfaOFD"
Content-Disposition: inline
In-Reply-To: <cover.1704877233.git.ps@pks.im>


--zgXYeaNGu1JfaOFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
recursive fetch with submodule in the case where the submodule is broken
due to whatever reason. The test to exercise that the fix works breaks
the submodule by deleting its `HEAD` reference, which will cause us to
not detect the directory as a Git repository.

While this is perfectly fine in theory, this way of breaking the repo
becomes problematic with the current efforts to introduce another refdb
backend into Git. The new reftable backend has a stub HEAD file that
always contains "ref: refs/heads/.invalid" so that tools continue to be
able to detect such a repository. But as the reftable backend will never
delete this file even when asked to delete `HEAD` the current way to
delete the `HEAD` reference will stop working.

Adapt the code to instead delete the objects database. Going back with
this new way to cause breakage confirms that it triggers the infinite
recursion just the same, and there are no equivalent ongoing efforts to
replace the object database with an alternate backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5526-fetch-submodules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7ab220fa31..5e566205ba 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken r=
epository' '
 	git -C dst fetch --recurse-submodules &&
=20
 	# Break the receiving submodule
-	test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg HEAD &&
+	rm -r dst/sub/.git/objects &&
=20
 	# NOTE: without the fix the following tests will recurse forever!
 	# They should terminate with an error.
--=20
2.43.GIT


--zgXYeaNGu1JfaOFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeXQIACgkQVbJhu7ck
PpS+kQ/+L94A72pClho3+iUqck20urYj76YTXmRg2u0aiH9cF06vVpWpKXU181BM
qOjMzkjLDdeUsnt1IFgSuFEQrBdHkVmq4JsloFHB1EhKpvWcRbLQEymibphGOPgO
DoJnt0f+N1kxHVyEjqJ8l1QahKwn+Py3u4hvsYZyIKjPJC9yF4C62nNFirYKehE7
2MJXDe+dWuzKTjxdXA6YH3NvlXK+BMa/CWs5wFO5qquXbnnozo9yPY/gfwwz9iRD
SfZD0em9Khf8gPmOjSbQkcnWXE07v+WthkiDbrFn4ooCs0j5dlzW8pADtgDsMePu
fQ6crHasrfQlEpTsXsBWu2ExBJVYK28nXbEOxO5RgdHJSNRGyjiOIDGH4TIdo05v
qkfPH8NpwoUMbr0MSll5OGEsQX1t8EPvrgy1VJBrYHOWtZCCjghdDwyRvKT3DsKs
saYyDWrW4NS022EBszhEOL9DUut6csBuLHRM1imOdNWh/KGGY8agUkBrgUjaKiSc
HfzLOi84sbbpNlRZ1MJQYrnspp/aQ10OglVG2ALDSg+1ip0oKkh5Qa6vicgj+Hd7
iA6uEKlG+J59VTBmLVVlZaU7P4w4YKfmApvDNv9QcUqTjr+UyUAGjx5/4hcLHCMB
rCACkBvls1G+sLAyH9z3ZQG4BNv854k0ox+PUy9cL+x7z0Jtv1Y=
=+6It
-----END PGP SIGNATURE-----

--zgXYeaNGu1JfaOFD--
