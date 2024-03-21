Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA758615A;
	Thu, 21 Mar 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034106; cv=none; b=HfgAWdxvNsaXQiJaPXVTXwTfEM++71j8YILjSCMz+Nxd0SVYHNAyqxBhYMFFKKaSYhq2GS+LLv6Z3f3llQDwwtuVoinc7MRG3gQG3Fo6LqsxbU90mJFa7VmOZRaCyJxVuzFEcqzA1FDpWmYb6hUieseiltWym3I8cQZPeYQI4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034106; c=relaxed/simple;
	bh=HwQQAkWF1fEVKxXYZtxg9fMrlewIJz+4/+Eu0OgdNrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSDgEfkAB+XEuj/5k8ISxQkjJUiSBjq0UEWT55yVitFfCVyTsgacjI+Zv1v91HU3iKApIcv1+oSTOVqnIfgg1yZsjCw3LfRcagX2mZjzQca2OPNXbmOatE9X9FvzeV0xN5tNcDdHRtQQLBuTfH0L+lhuriAXJEvJstVdccYjuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Usy3omwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gV9qOhru; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Usy3omwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gV9qOhru"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id D285A1800078;
	Thu, 21 Mar 2024 11:15:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 11:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711034102; x=1711120502; bh=kf0HUsBgvp
	WfadjJ/OkckWAxIEk8wbSjhZKHKHyrFg4=; b=Usy3omwe39opaA93Hv33gKy319
	qIvRfvB5bRINUxDSMcy+9fbMu+dByUwSkIhUrUI7pqgaW6zvy4Om+9QOgT+keo2o
	0d4ySfLW+TbG9cgM5sFjd1GWfcMdMvdWWlD+FE0rR8b2bVXB/+sEceHCU8f575Wr
	nLIZQjC0ZZ7Cnd7NZJuRP4GlcSPkJJtjvbMAU1kSbacK9ruodXsKxVssNAIIhvie
	JZLECKKAqN+sQjUnybkAUY8YfmbI1uM7jcJIWZgaHcJ4SWGLCimiUFtN7JUxymK0
	1bdQV9SM9GHaJp2KKl8fZ8yK+l2w9eSh5v3omnzET6Dn6+NVXaNh6hPxDZeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711034102; x=1711120502; bh=kf0HUsBgvpWfadjJ/OkckWAxIEk8
	wbSjhZKHKHyrFg4=; b=gV9qOhrubvK4PoWYs7mmkEVTMMjXDayHPnXhnyb78N2F
	k022+MW384rwIN8J2B2WUcifau5zC8wjQNWt+zooBNZrQ6PF53tm9yDkjNaLvtng
	P2liihng1WHbq70OuBvJWuns1A4C10TD3HM5j1NVaMqHc8PL+2mybiALCAPysZ2u
	5wcaacOhkzjnm7yWJLCKM3GUJj1mxvnBHoFMqz71qRfMgF2vf3/4imhQyNh6rSyw
	VDHuOHXeXT/Ujir3m/JeEEhOlQFf9sp74Xq8UTyeGPD+Si/S8s7OkqFOUlGBf++1
	OzkfSb89Ayu7DDpvtW6A60ygQwHw/w4ssT6QNVdWPA==
X-ME-Sender: <xms:9k78ZVsc26zDupzdAhZnO69-laW1pbpuc-yl79fSiU6hvXw_zvMDmw>
    <xme:9k78ZefwnspkpS2K9qrCeCeGlST-FPGgzhAFWRwdo4acMFR5l8KyHhORlWBYjRzUo
    2USdbVZkYl6r9NVig>
X-ME-Received: <xmr:9k78ZYx0cHAZE_wENPK15PVLSX1_u49av7HPk3MVDSx8QiZY9ZdmnT7JJioWrdp4_h_FaUd0IINgIOpQxcVyZNDcIBknlul02bLiIRX6QDyvLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoe
    hpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehlefhvdevleeitddtjeetheei
    uedtkeduveeludffffffffdvhfetgeeuffelfeenucffohhmrghinhepshhouhhrtggvfh
    horhhgvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:9k78ZcPTigYf4xlHDApZOaCdgXCf2XVPcGSx0-Fl1i28SK-HpMig5A>
    <xmx:9k78ZV8gZRHb3ZujEl84zrJ_NFSGIuNLRvuNp1L_rlrHqfdlJu-jdg>
    <xmx:9k78ZcW-nv2hnHcJTR9M8-rhOr21NUqxuTSbLDhrSjfs_mRe8OvNbw>
    <xmx:9k78ZWfJNcLMFTWY7dhSxKpFs_WQDCYXjnYw_awZVjPLBbpT-0p9yw>
    <xmx:9k78ZYlp4AA9hZSk7r9Di-vXZlVp47zO4HQm0Z51YXpR5nUJ48EkI9yveuY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 11:15:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab3dd12c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 15:14:54 +0000 (UTC)
Date: Thu, 21 Mar 2024 16:14:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Chuck Lever <chuck.lever@oracle.com>, git@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: t0032 fails on NFS mounts
Message-ID: <ZfxO8ApCDUbBHJyc@tanuki>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
 <20240313072052.GC125150@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/xz9JawEjrSgC+S"
Content-Disposition: inline
In-Reply-To: <20240313072052.GC125150@coredump.intra.peff.net>


--I/xz9JawEjrSgC+S
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

I think this is actually benign. I set a breakpoint in the respective
test right before double-checking our conditions, and curiously I got
back the following list of files:

    ./stack_test-1027.QJBpnd
    ./stack_test-1027.QJBpnd/0x000000000001-0x000000000003-dad7ac80.ref
    ./stack_test-1027.QJBpnd/.nfs000000000001729f00001e11
    ./stack_test-1027.QJBpnd/tables.list

Notice the ".nfs*" thing? This is a temporary file managed by the NFS
client that maintains delete-on-close behaviour because we have unlinked
the file while it was still open [1]. But of course we count that file
when executing `count_dir_entries()`, and thus we arrive at an
unexpected number of files.

I will send a patch to fix the test.

> PS That test seems to run ~20x slower on NFS versus directly on ext4.
>    I'd expect a little overhead, but that's quite a bit.

I'm not all that surprised here given that the reftable library is quite
prone to stat(3P)ing the "tables.list" file, and potentially re-reading
it. I kind of suspect that this is what's going on. An alternative
explanation might be that mmap'ing over NFS is really slow.

Anyway, I will have a deeper look at this and see where we spend all the
time.

Patrick

[1]: https://nfs.sourceforge.net/#faq_d2

--I/xz9JawEjrSgC+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8Tu8ACgkQVbJhu7ck
PpQEKA//dsf+RIUY7SkHxNbzDNgL1mrIxEi2KQx7BykCpQXhB2/SAirKdYwqexsF
xKN7k69cXPoufCg2W8zxpAZSLWPdXKf1/zcI90fjYuQ4B6G+5j1jLNKm0gVBgJN/
yM4hoZmz8D9ecfLAspwcbEObJqYOMwHSaus6tYWKDNIAjpflhmYb48RK7wp8awCm
7AfSDPBZQRlRsJubWwu5rMGPg1Ea+i/HNZpTsODVpXIPpvKZthAozqPqy3hCb4oh
eOWTNZfQk+4yENS9czYWjaT2SO2RVmheEXZx8QR2igP9QOzApp3O6pSGutbUhqWI
dJmVLOYRIWiunZW8ew/6P/nRYb4qMykCblEegBP1jc0axWGMrcUxPznHbHlAElMN
SxpMwtOnLWAEjuLHEJIdlLJUo9u5haKDCsrDipVZ96tQCuDBaCR8PypDyIvgfgiL
EBBkmh4vulUrNkzC044fF+sSu8YYEjNpVWP0Z31RkH1DL+O/BJ41sa9lziAODCAr
0S/GVMJYf+cYq67QytWq10Btlb0ZJgwpA64UfrTn7kTnOiEqolWe5hF01v+njGzQ
2Jw3dEGFoN94SCUHXiEXaH9GYyMYAmMieZcri/FyFZ6SlPMGe05DS4pruBJGSxfX
l5RwZicNpV3IsFAowcZ6lFlJee06WneoGOnCAPMVQbQ8fd7275E=
=Acwc
-----END PGP SIGNATURE-----

--I/xz9JawEjrSgC+S--
