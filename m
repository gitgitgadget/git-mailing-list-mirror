Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E961E879;
	Thu, 21 Mar 2024 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036226; cv=none; b=W7HI8o02voieIeUCnztyR1zEEFH4CfnMnykoydwgudVpuJaCI7EBHXwjA8uHoiVvqkjhJSdHwOl0x4cjBq41th1UqD+XeUSzrSqvdKikeQLXDftaUw9Jh6Nrm3rFfsRskY7aKzqzuVMUOWK0gKMc18wvqtKPQOqkUjk2zup5rwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036226; c=relaxed/simple;
	bh=pWYRj90+3IRpLoEC4I5WtrtlREcuOMGnXKqZLPWAOqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsUHUrVYdjDitF5NXvT5y6Zn04vDgXTokryxC9p2NOypxppmOhl8iX9VhUc+OsyQocOo7k/G2I12qJmXAntY2av0iMNKiatu19RnNXTV5HGL1yobnhAycVWzaDVAEy+S9QJiddSHRxcuczZTuegS/lWPkTXwSvsGWPjYw5vqwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOasO8TM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a8G4LAiG; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOasO8TM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a8G4LAiG"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id CCBD81C000D5;
	Thu, 21 Mar 2024 11:50:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 11:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711036222; x=1711122622; bh=rglaQrnqm1
	HhjpekC8jaG5f2LXu47KX36g+PZ9NDYd8=; b=dOasO8TMowc9sjQJcbxHEYxqlV
	0Rfm1iPbQL8YJigWdFnymLDwnsCS49UQjvT+1OI0OrKj3H4kAsjiLsgh85TivWTy
	Jdwd34MQYOv0Wf3dyU3kQv6U3/9nWGPeY6karZZZ+xdEb1ypPF5zP8KvFVp3OYKS
	hZf1Tq/7RvwJPKSMNownl509AnBi8MF8UP5x1rsXqgyLOQwWKfZGdescIa9kW7yt
	nTm53yIQh6FLpeNt8NJkSUbZwUh/fvk57c8/CKEt+78mmV0p8SuFrc+pd5E5hIBR
	3gghZrPIlKSGZYNtjL9Aai283yfwSIAqoNOzOQPztETXPp8ewcsC3aodUC6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711036222; x=1711122622; bh=rglaQrnqm1HhjpekC8jaG5f2LXu4
	7KX36g+PZ9NDYd8=; b=a8G4LAiGyMLJTiS75WtUeEMfdJ8WCkPbLW1Twa4uLk/e
	sW5yh/BjoPW1fzDnckgRX8kqvrhrwYHvCJufwnBdZqDIiXlTowcMZABfvyEN7cfv
	iE04rMpKkzrT6rxkInhwNp6FJgrc5Emd9pNqYwxy7gydvqML1fEw0R9NbIOCNk6S
	xTVmObKYhCgp4MLAvB3ugtuO+iyIzw+KzXrrAZe2c3hZe/GECzgpTVN+r/gkRJyh
	zfZLXxkkW66BQicD5bWNlIesvgaMXr35cPJ7Yy8JuMxMCiBzWtYrEubNcNBqE+aB
	X8f0zbgulP748OtkNk9w+Mu/MGyRrYDfsfPxu59iVA==
X-ME-Sender: <xms:Plf8ZRxy35m3oBnOiQf2Lt2qiJ4WquXuhGAwIXx8-BG3ZUJW3McLaw>
    <xme:Plf8ZRTabgaFD8hJHRTQp2DLPUTxMpeB6U1-BFeSgYPO3Vv5iNrZ_ZaJLaYZrLuQ5
    gcd6BCGu0JQL8FC4A>
X-ME-Received: <xmr:Plf8ZbUq8a4mLSapGGVxrGhpM4iRMOsk76Fys7hlH5yXKds8-WVrf_kOQZkw7uDivgRidQArclHV5JlfOHfkCVV7TTGBmTVnLpbnlCuTu3AM-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Plf8ZTg5zcL-6wmWTUMZ5_msBJtupMLE0U4GekxjzbGjmQOmLEVNtA>
    <xmx:Plf8ZTBxrd7F0sXYgFuuWwhVb57wrjrOxxMzWYF6YaCyu2JnPM9CnA>
    <xmx:Plf8ZcLtsBxt93hZPEpOuBbFD9irQTwEtoQbXQAVM3VMXDt5N12jNg>
    <xmx:Plf8ZSAZZwp3Mb6QOwPZMJ-D4g4t3X_TlQ7ijMqz8OtVSQW7h5Qzfw>
    <xmx:Plf8Ze7knMW08K8FTVK6FPQPXujk6U6RAkZ9q6t82lzn3tmvp1xErmT10Tk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 11:50:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5129d5b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 15:50:16 +0000 (UTC)
Date: Thu, 21 Mar 2024 16:50:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Chuck Lever' <chuck.lever@oracle.com>, git@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: t0032 fails on NFS mounts
Message-ID: <ZfxXOR9e7Mu7T3to@tanuki>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
 <0cb701da74a0$4e39ef60$eaadce20$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CV1N6EIPpqpQyrnU"
Content-Disposition: inline
In-Reply-To: <0cb701da74a0$4e39ef60$eaadce20$@nexbridge.com>


--CV1N6EIPpqpQyrnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 01:11:15PM -0400, rsbecker@nexbridge.com wrote:
> On Tuesday, March 12, 2024 11:10 AM, Chuck Lever wrote:
> >I've checked out "maint".
> >
> >Unit test t0032 fails when run on an NFS mount:
> >
> >[vagrant@cel t]$ ./t0032-reftable-unittest.sh not ok 1 - unittests
> >#
> >#		TMPDIR=3D$(pwd) && export TMPDIR &&
> >#		test-tool reftable
> >#
> ># failed 1 among 1 test(s)
> >1..1
> >[vagrant@cel t]$
> >
> >But not on XFS:
> >
> >[vagrant@cel t]$ ./t0032-reftable-unittest.sh ok 1 - unittests # passed =
all
> 1 test(s)
> >1..1
> >[vagrant@cel t]$ cd ..
> >[vagrant@cel git]$ ./git --version
> >git version 2.44.0
> >[vagrant@cel git]$
> >
> >v2.43.2 seems to work OK.
>=20
> I have seen a similar effect on a standard POSIX file system (NonStop) wh=
en
> run in a special platform container (Pathway). It does not happen for me
> when run from bash directly. This may be something other than an NFS effe=
ct,
> or unrelated to what I observed. I'll be monitoring this sub-test for
> repeats.

Interesting. Do you know at what point in time this happened? Was it for
one of the releases or any of the in-between states? Also, does Pathway
mess with the stat(3P) info somehow?

Patrick

--CV1N6EIPpqpQyrnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8VzkACgkQVbJhu7ck
PpS+kA//bmQvJu38h54ksVp5FmVlmEtn+xeMoFSAy1b/xXNq+KXVgf2Vx45NLC/7
AwQoa47+l7Db1/TJf7Cu827GjKzqKi8754/X9L5Uq6d8LGf8i6wCBvdxKZJbKDsL
bzyuSOMVvVDZNdFzQFtIem9+vdpzV/cjZ7We0yd1zUt6CZaoWRsneUZ07Fdsys2O
/icYIs5c5oIrCri01ICkyijr9idiTNuZWC0W/FqdpeWYk8NDJM9Qz544KUP5K4ya
PdsKx0wdJ+2lsstYyiM3YTyRjMROh/2IuSdPlfbi1tS1CdPikhm4J19axN+LBxUb
XJFt1g1FZtN3COqfiuloUJZm6vjuyvuS/K7DisGH+0n1SiL6p2CoW8ppeFkJU9Ak
rwGBStS+KB6LsqicOdhBba/6u5miyh4rugchum3C7ap90DDoNW0LuK1CWLHiR3qY
WAY6ZrnfuKSiog3ppdVvt3GfSZVqpBQjYeXZprGCf9IoA8OQSFZ6Nkg62r/CbIBM
IHY2Iqlv6CAXVSG0klJiBZSn6qvqO7p3nuU3fq6ULAG3uG/m2bFX1GsHxJ4vePfc
qCezKRdvVbDpflfNlGgovT0lCR6b8fnp+rLnWLkCiHRzjaxJSxPCx2IYI9QJar6W
d4Rzd7NPYmCG/ebDTt9TY66bOh7xJhSDdvz2oWUa19diUgcrrx8=
=YNIH
-----END PGP SIGNATURE-----

--CV1N6EIPpqpQyrnU--
