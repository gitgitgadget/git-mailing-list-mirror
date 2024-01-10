Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18A364A9
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iFEYJU20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1iTWK/yw"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 18B8E3200A01;
	Wed, 10 Jan 2024 01:58:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 01:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704869929; x=1704956329; bh=+QcBTNsFe0
	0WnvkRzikuzt2rmTtaktv6GH3nX2XIlms=; b=iFEYJU209di9C4MKnZHfBDsyYI
	9jqW85q+NM51HlaDAV8pG/tKlpzU3rYEQ3n3aMW+mDC8bMpxCEi6j2iIq7aoblq0
	oXuFnmbuRi41MuUgeqAqxpyp/++/u0lqw8hwNXt1XrcGoWxFw0xZTAWROZEbEHh6
	V8wMIMSsLoA6xiy30shytiwyI/s3mqTPKUB0o4xsxUteL8Em5dg3WSgluzRcO6mt
	NRwGByxQ0LRqT69ybwh4xINtPxFXXY65tDrNn83T48XQY+B1rj+eYRSTpOHcGE0i
	lWrYZDssheakGzD101TsFHQDBMnBcKEz6jCzkwyl3nEv9j2AMNqeYT0Iv1PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704869929; x=1704956329; bh=+QcBTNsFe00WnvkRzikuzt2rmTta
	ktv6GH3nX2XIlms=; b=1iTWK/ywxN0a/rrcy/E5pGXgQvazRM+Y8i5nfjZdmWox
	fUx3vFUA51t16qFDrUIl+4y6eiikREY8uGaR+QYjpD5AAWjr0bQJNLKJnNhzIAW1
	HDnOooGXB/7C7CjJhuOPEinMXv9csMj5dDN9O1alNUjHas7485dGfm1YhBSTPHOF
	42RLczxc2NJCWn8VgUKbWINZ035PRru+DUmcHlnd5U4ZuL0Ux0ewIzcU15HCN8WK
	IwZhBBk3IJ8dKcJWtTQ5rqceTyx/3bP0yiovrk+rWjD+1kg6yuUDbzunZrRneK7w
	t8Rlw0eXAZPxtfUYnIPPUCr93Rc38Jhf41MiutG+DA==
X-ME-Sender: <xms:KUCeZXCYCDpxsRZjQ6mRal_7tzPvLaNH_lckYzzFDO9psttwkWzBKA>
    <xme:KUCeZdij011XmAnyUynNx92tP0qGyMtpX-a5Zz_OkldBTw_G0_ePfD0hYdnIM71vm
    Rhrk366jXo-RiTz5w>
X-ME-Received: <xmr:KUCeZSkr0WqaV5vu7lYO3sxUbX2iaKILzRDleBRGr4Glr3f-L3qOr_je3c1Ij7mF-B8u_f42GwSQ0Cpv-MaxuGJpvMIk_Yzxdx0LsZQW309NWjM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeitddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigf
    fgtefhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:KUCeZZyihQSpKs9fFPT4Cg4bMDQins38OF-45oaJCzv4GxITRzNBpg>
    <xmx:KUCeZcQoEmmmRyHGxO1v8T75kQMZh--p4zTW7IeBg03opctGPatJ0g>
    <xmx:KUCeZcYP8hpmp16S5t4Qknelo0Ct_A6MQ6FD1CgAc5B-kIekhtYbow>
    <xmx:KUCeZV4k_4olEi_0ndvkl-XHwMCWeQBObThKXz9K-umEPR-G4SwtkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 01:58:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4003879 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jan 2024 06:56:06 +0000 (UTC)
Date: Wed, 10 Jan 2024 07:58:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: ps/reftable-optimize-io (was: What's cooking in git.git (Jan
 2024, #03; Tue, 9))
Message-ID: <ZZ5AJL4di1TAC-up@tanuki>
References: <xmqqsf36dotl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfSCIDJCeI5wpliq"
Content-Disposition: inline
In-Reply-To: <xmqqsf36dotl.fsf@gitster.g>


--tfSCIDJCeI5wpliq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 04:17:26PM -0800, Junio C Hamano wrote:
> * ps/reftable-optimize-io (2024-01-08) 4 commits
>  - reftable/blocksource: use mmap to read tables
>  - reftable/stack: use stat info to avoid re-reading stack list
>  - reftable/stack: refactor reloading to use file descriptor
>  - reftable/stack: refactor stack reloading to have common exit path
>=20
>  Low-level I/O optimization for reftable.
>=20
>  Will merge to 'next'?
>  source: <cover.1704714575.git.ps@pks.im>

Let's wait a few days for reviews. I don't expect there to be a ton of
reviews from the usual contributors due to the still-limited knowledge
around reftables in our community. But I have been trying to rope in
fellow team members at GitLab to get their feet wet with reviewing
topics on the Git mailing list directly so that there is at least some
more pairs of eyes for the reftable-related topics (and eventually more
people who start to contribute to Git regularly).

Also, the optimizations I'm doing in the reftable library are generally
not part of the critical path to get the backend itself upstream, so I
don't mind waiting a bit longer for those to land.

Patrick

--tfSCIDJCeI5wpliq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWeQCQACgkQVbJhu7ck
PpTblw/+KMRHo2ZtTg8V8xsl+fcAWZQzJGHGvN/BYLVbBhgW0B4uoSvBCO4z196x
z64+QjH2nNWAF1F7x4Jyxy82EZcdQT8kw7qTv0jTxddmGYBbjFNBc7oh+TorUsES
w5/DrUHEKAVPQ1XQrYL5u1NJrjOdHSIfIfHK3NPPzFlYiWxR7ljpv7IY9oEzCt7y
ujzAmsisHbR1JQmUS8jeLFHx70Mmvfi055DZlV3zhhcqZ6pVj8OAmA34muCHTClV
xZJotILxDlDMgqyR2Gi30GV+whg+0AgDy7bO6ghnc38fVGaWCr0ZfGi/DOovm2xN
P9zHAYrn4v5GfxFnzwzgdPsvDlD7dibRUEMgxeltnqLpzCtO1lFCB7L19BIixwD8
tS6wxVckXtQX7vWKFye2s2nTcy2Mj2JQWQOnYL9bIhgzU2bGiyQWp8PABLsxfZ2b
1vEyjmORlJu9ZtpsBo96Pylom9eXYXWsLrrkKGhmYpTy4d7APDS7dClYNsGpqBX+
dQwikmDAP5wYZY195ujj+pTi/l5r02rd+aCLiQ8M8zgqhBXJz+e6HCFgPqT4HqG2
Dk+B8IeB1BUZjhacpMS2EUKYSZ7JRJWtrvUHiWZ8sA0JLqnBmstU0Vi+nwy6Uamv
1Eojn5LaCGVQXCVzNiGRdwzln2y43wXIxbN3XUH0upFx84VBvTc=
=8K3p
-----END PGP SIGNATURE-----

--tfSCIDJCeI5wpliq--
