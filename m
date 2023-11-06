Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF517721
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="wVhRA8EI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CAsAjJ9L"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB9FA
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 02:45:56 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id EA58A5C0144
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 05:45:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Nov 2023 05:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699267555; x=1699353955; bh=JO
	ITV44VHCkIkJu9VyPQ1mAWTEnS9PnW7xh+xuIY4iA=; b=wVhRA8EIvSPg/7qrPY
	rMUGON8FtD5dIlf3tuCjRFjWH9rXmq1cbEvTZwGxC4N7KK9ReLtMGauRlcaks5cD
	r4hw/r0ZR1U7NuEf7dxAKOfANyoUVr1H9PlRKiyuJzE38tBtXchD8+kpRaCivBbC
	TbcqJuUiRdVRyE6CCarKxCHt+uVSQ+pBV8w0hp7tOH7osfjykgdO3Ut4Pdife1uW
	shQHEuU77VIaawbQ1h6lb9VJJ3bj2twInLaPpC+MS2lrdM2HEXUdNiPaoiDZwNLm
	Hf+sAf44Yp/LM/7BNRwXdeA5/9YuMd6sRu/cGA2zrTj//a/ZPOHQkXiY6C3g2kRw
	pcAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699267555; x=1699353955; bh=JOITV44VHCkIk
	Ju9VyPQ1mAWTEnS9PnW7xh+xuIY4iA=; b=CAsAjJ9LyTRlTo0Ivn8zmqoNzv4AU
	xZMhv6W50888NQL5PoexZwcKBddyjIofObu+3iqxeLSAryV1etCYIf2Q7lydHNBN
	ogoyl/+qiIomc3qiGqCi7vP82i3SYgHgqbdzS4O0mFoUrX+inqIFAHjU0Fb8VoZD
	m+VxEtITWrYDq97kaa31oEokCw7apDt2BS6wu53NB29Qfn15LDzwhcAxmi4eE+YA
	pmvLtIJ2FLtJ42eo6HQ/vOO5zwG3fACtQpckHwy/NdVDPQd75vclzW60YaYdsFrf
	mIAlx61kYlUdwWLf5bNzcdmZpRZm3RO4OldDlZqccQwvjGmYtRHvy4icg==
X-ME-Sender: <xms:48NIZVUiUfy16DFA6CQpcqe5jXdHA2Thf7aLf1CYpf8dPRlTnHULHQ>
    <xme:48NIZVkYtvePkXFxrYNct5DVpaSLQDoH7V_LtLJUaRbLpsVmw_WQIAX4gKX-ulRwo
    OgxKNCwQobRq1WDRA>
X-ME-Received: <xmr:48NIZRas1KnSC2Ny9WLvfK65BZFvA8jZ_4zFCAUBIgvEwgMmA-72GIib5g10PR2H67PuMFfx_F00a5EgT0eFkZsatwt-Bkz2qIrMPnhtHgIOWOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:48NIZYV1VF9IE4LFonx7ZjbAs3oz4qBDOA0jZqyy1redRvMugAh9Ow>
    <xmx:48NIZflLa2EyR7Op5uXAAlUC3k_uqQcL7-q9ce7Yq23fwF7pqSCMPg>
    <xmx:48NIZVerY1k76g-RknMmMB2u9tUVbDPL2h__eWBfzW84PqmzQEwPdw>
    <xmx:48NIZVSdOUPitCttLB-tP2d-slPv2zZJE9H3Qfycxi6N8JI_CLhr0g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 6 Nov 2023 05:45:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f1d7b8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 6 Nov 2023 10:45:34 +0000 (UTC)
Date: Mon, 6 Nov 2023 11:45:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/4] test-bloom: stop setting up Git directory twice
Message-ID: <fb1cc73ed3395ba3de72aba70d7679dd85ebb034.1699267422.git.ps@pks.im>
References: <cover.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o8T7wPIuP867dizT"
Content-Disposition: inline
In-Reply-To: <cover.1699267422.git.ps@pks.im>


--o8T7wPIuP867dizT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're setting up the Git directory twice in the `test-tool bloom`
helper, once at the beginning of `cmd_bloom()` and once in the local
subcommand implementation `get_bloom_filter_for_commit()`. This can lead
to memory leaks as we'll overwrite variables of `the_repository` with
newly allocated data structures. On top of that it's simply unnecessary.

Fix this by only setting up the Git directory once.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-bloom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index aabe31d724b..1281e66876f 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -40,7 +40,6 @@ static void get_bloom_filter_for_commit(const struct obje=
ct_id *commit_oid)
 {
 	struct commit *c;
 	struct bloom_filter *filter;
-	setup_git_directory();
 	c =3D lookup_commit(the_repository, commit_oid);
 	filter =3D get_or_compute_bloom_filter(the_repository, c, 1,
 					     &settings,
--=20
2.42.0


--o8T7wPIuP867dizT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVIw+AACgkQVbJhu7ck
PpQGgw/5AVu3A6S0qPGJ3ne7C406OC6UdPPJgcG+yrob0RMP8Wt95NV2Fi9XiagT
EPmedqZZ5yHIC526S1kPYxxWKo/ZGHWiQ6mDLQ6fBBn+sUZvVwLZRz5VxtbNKw0v
+7TuRJSPw5bFKb/UO5nBm6uqkIn1hqq9hDpNE6K5RqD+EgfsMnN2Bl2ZIWpLAmbb
gHiWzgHzTgYLZJKcqqeCn7SxegDTUnCJnhUK2JqUqd2sH1Pb/Tjh4wmd32icl413
kMhfQi3ickyVtoZ9X6HXDxKXRrOTEW9kZDhEtX4VOybRiRW0UwbpNDYcTBNi3AKc
vltI7gaLiQUBD59TfqxH433Fe1z6nIH7JNCmwgZsVQWreZSwIWYLJ1b/eHeBth55
NF2+jqwPfASXgIAhk7TCxJTT1qEzt0SVxb+NxCMlpi+/BWNmROlcDcyCHnNtfXMI
FWzX3rBldJjCqfV4bdpuww9bexy1zGj3IGggdTBkF9hDXtDMu+JvnELi64l06VRp
a7c5joju4EJUqkfVJRMwDNWKSuEfb7b3+rXU6d3eukKsWIpB5VlDaCFImuJbLwJL
IFRCA3UP38113QkcaAX6HguAKhqVZGKcL5cu9ipY2KVXpcaSaLLOifn5hW/ydUIJ
Qze2cpBDImNwHXZskMeBCVRiULLxbGYevLf5m2a6rG1klEXdu68=
=5ayd
-----END PGP SIGNATURE-----

--o8T7wPIuP867dizT--
