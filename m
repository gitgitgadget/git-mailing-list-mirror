Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FA19F;
	Fri, 15 Mar 2024 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462942; cv=none; b=pOfn+E1aw67IRwnjWt3K33x6rAmREKuyKXNhwQxyJXXC47QWPGeZnF47kkB3z8Un2Bkc0PKYePPESAqfM7B8/uV+oSWiSYCgj9ONYdj1nkRonjJRcKVhzrQxcg0/h7cMNYblMuJlY0dD7jsCoD3vdboG/s1NHnIyMugqlZM7qvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462942; c=relaxed/simple;
	bh=WjKIaA8fp2tbnc3Q74adorv/6ztthMDt0+pRhHyOYc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dL/znYJgC7pO4TPRWuVq3pm92tZVL21Oy0joqgzEwnxOl5mpMGAQHy4S03M8eOhYnyZigUj9vLt0w1NXBJYZry4lykN3p1YGZFmf/0xFoG05sB1OAWuYQMIjO99bt0T+Hn3uVsyaFwzd7Iy2E8Qeev8weQM3YnkWNaQ/Lwx/VBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aNQbERd4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwXRsBq8; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aNQbERd4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwXRsBq8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id A5AA63200922;
	Thu, 14 Mar 2024 20:35:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 14 Mar 2024 20:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710462937; x=1710549337; bh=yMBJ78rg8k
	xuZAQeB+h9BcCGV0f5xPo5vtJtq0EnVf8=; b=aNQbERd43lyYVtmZRsihSXQu9B
	jX/Tk3nQMHqHt6Pa3/I11J0N5ZW+T3ye8gSlOZ9pkSgwT+6kko6CoGyArs5osZaS
	E4Zv/58Zu6en8O5yz+hR2/wUAUyveI5AlLX9APp2O28aOrzrFuiMEM+I3niXPPPp
	E42KmFgZuCADlklfPIWfZyV8B23nBp7REh6p1BtgMRa2Wne3Kt8hmI/OLwzP8a3H
	2+boifLnpw16RrHUNmIN3lqvGbdNrwfxSB+2ZnyHpShkUR2NIX2N/7UhugB4Qatg
	4PBvuKAdIhsOZL9YiFZI1/qFMXmLVBpGJAsrrtnlDh4V6dYRNo5cGiL9A5EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710462937; x=1710549337; bh=yMBJ78rg8kxuZAQeB+h9BcCGV0f5
	xPo5vtJtq0EnVf8=; b=LwXRsBq8bEMKgTUicnsLJYSmNDkMUQySXY4tRBXxt8Dk
	5o7PeZrcY226gtXMqz6DznY5hc/EBp59L29vLgiYtYJ8Zw6jzMUwvcUPBueNQF+2
	2i2YHfZT6hbfEZq4A8Xh+YcSxITf7Ckxd1GrqyChGFH6gv/X5P0a4dsKERELw6g5
	ei1oFAGKAxhX78ApvvSp+/aDOzXzmGVabTnpjM7tZDtTZ0DWSdOFPZcX7yRfqI+w
	+uCyhBwrm0J+M/f1ZtcasYYpLkqkQgq5l9E5bwlS4prYHssIGjf+YHEf6dFQXyu0
	Wx8Iq4lgu1TOwVfPIFMJLT6RS38vgJqgRX1kEbpSlQ==
X-ME-Sender: <xms:2JfzZcypYRcndCbKBqpDZGQC-gIqBdXmYLUpAyQW3OxzyJF_lbn71g>
    <xme:2JfzZQSwKGuYE_sTpIteo9hxmIGZiGwQEVUf83iO9jt1C5Fx68YY2An2Tw7jpvnq3
    yVjZHh-tng9hAA6ug>
X-ME-Received: <xmr:2JfzZeXhhuF97iuM8u1Itl2s4mmiBYH14gwWdPWmNuQgwDSi3YfCzMxzJYXrhGMqe7F-rtbfABMwKxa1zNOhqkVHbLcsRgqY4ACUj1AK4YFW94U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:2JfzZahYYU-u4FqvVn8S2i6XVj8KJEG0wvz4IjtOPqCdbFRnNDY-BA>
    <xmx:2JfzZeBzPemH5fTQTT7W6118Sn3l-0zygZspvPLuNuqjpIZ6UXMUSg>
    <xmx:2JfzZbIyrBipdMevk0BHOji4xkDpmRf0z64O1qcIbhoObqpeNkAqzw>
    <xmx:2JfzZVATk8Ft7r7wSAPWdbHV0dp6xJ-7xH5L0jU9LrUVlvukihrowg>
    <xmx:2ZfzZR-8dRx-Gh46TBRu7I8rgqE8uzLb2bkWJ0Hfyz3Idpge7ore1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 20:35:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dbc1f58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Mar 2024 00:30:48 +0000 (UTC)
Date: Fri, 15 Mar 2024 01:35:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Chuck Lever <chuck.lever@oracle.com>, git@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: t0032 fails on NFS mounts
Message-ID: <ZfOXz81cpGZvq6Pq@tanuki>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
 <20240313072052.GC125150@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEkf0p8qSI8kbnth"
Content-Disposition: inline
In-Reply-To: <20240313072052.GC125150@coredump.intra.peff.net>


--kEkf0p8qSI8kbnth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 03:20:52AM -0400, Jeff King wrote:
> +cc Patrick for reftable
>=20
> On Tue, Mar 12, 2024 at 11:10:29AM -0400, Chuck Lever wrote:
>=20
> > Unit test t0032 fails when run on an NFS mount:
> >=20
> > [vagrant@cel t]$ ./t0032-reftable-unittest.sh=20
> > not ok 1 - unittests
> > #=09
> > #		TMPDIR=3D$(pwd) && export TMPDIR &&
> > #		test-tool reftable
> > #=09
> > # failed 1 among 1 test(s)
> > 1..1
>=20
> The output for this test script is particularly unhelpful because it's
> not using our test harness at all, but just running a bunch of internal
> tests using a single program.
>=20
> Running with "-v" should give more details about what's failing.
>=20
> I set up a basic loopback server like:
>=20
>   mkdir /mnt/{server,client}
>   exportfs -o rw,sync 127.0.0.1:/mnt/server
>   mount -t nfs 127.0.0.1:/mnt/server /mnt/client
>=20
> and then ran:
>=20
>   ./t0032-reftable-unittest.sh --root=3D/mnt/client -v
>=20
> Looks like it fails at:
>=20
>   running test_reftable_stack_compaction_concurrent_clean
>   reftable/stack_test.c: 1063: failed assertion count_dir_entries(dir) =
=3D=3D 2
>   Aborted
>=20
> > v2.43.2 seems to work OK.
>=20
> For me, too. Bisecting shows the problem appearing in 4f36b8597c
> (reftable/stack: fix race in up-to-date check, 2024-01-18).
>=20
> -Peff
>=20
> PS That test seems to run ~20x slower on NFS versus directly on ext4.
>    I'd expect a little overhead, but that's quite a bit.

Unless somebody else beats me to it I'll investigate this next week when
I'm back in the office. Thanks for the report and for digging into this
issue!

Patrick

--kEkf0p8qSI8kbnth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXzl8oACgkQVbJhu7ck
PpSL2g//WacKeoCja0fkBqNLavOycWG8HVXvhBGsmtUo3fc2g7nUbaFLtW/vbPoN
NPdx+cZa+Da2AtGLbaniY3NTM+/8m6BLd767Hme3N+ZeWgfLDaFIjttUPVB/VEsB
ao7NRZa3o2upCKX6sxgmqV2ppRRfbYMZO0FPR54vrSqWG9t24uYU9vyl+RLW2+f8
bE42ta1c5hcRSvbSUg2IyyPdokwsh/mdQEpN3h480p+/iLr2hhhzsi7a1QNit6qa
hKcqzcjWvbAj4qy35HliFQSJA2F/Gv4QD3bSWVXn3EXTpaMwIkD8PKeVk7ObXcmA
UNq0qolQXUD5NQbGiAeXOpepoiwpVTV/7mUup/z1p4neHEkFK52IpRFIymRCTGiX
sLitPQvbY6KyBuTivJEH49znZbAiL/YNK8snK0hqPviR3c/OlZSb55BT6Z9ooWep
2o9g873bAHBNuhuWJkXNOozsgYH4m4soYc4eoVJzoa6uUz+gOmG0vws/owCKeDfX
Tg2lsH1MSdyuVL1LBg1M4wLMW8dmBlIhvqVtvjT/oCnpFgORKpAAQpFBopVhrhBI
WodPUpZ7XdAUAvuTmxp8wtp/QIjngNthSn/K/YW1J9rjeocWxZbJFlS5vbEc3/b4
5STBHj71eiFWsmBsz3lkO/QAQ3ElJPl/5zTTMF2sA9ue8qkQ1EE=
=UGq0
-----END PGP SIGNATURE-----

--kEkf0p8qSI8kbnth--
