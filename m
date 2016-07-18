Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272AC2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 22:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbcGRWpA (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 18:45:00 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59476 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751654AbcGRWo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2016 18:44:58 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BAF2C282AF;
	Mon, 18 Jul 2016 22:44:56 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468881896;
	bh=OoGNz1d1vBelDANxT4EofkYbeL10u5HUBKrav/ybB9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aycyhH/zI2uq8Q6BIZGZJojULehMfGAs9yqjrcc1ofBedBlpgde99OKBKHdljoyof
	 oItRwtqNal+qcThJIr/CpUbpIdePH4G4vn5xNRnWsXiD1ZPD3p73mMpSz5gC8ImLSv
	 Jctbb17XPAwOkSsNUMRBucevyFHNFMlzQwADIXR/T+m1lkHc+YNYqi6ECvIxP34MdB
	 N+/57oyMxw+QK6MedQNxc0O6+kDnfb3fO9HoqDDXzfyEROFrPLf4anpQFtCr9zRwOE
	 4Opx/8twCOHu6tcxCkZiutOFr23ngJlCvfRl67t8LKJ7SKBaVXbvjuORbXZ0pczfxC
	 d/JYDj3MbdfPSbC8T1R7r9DcJ2SzntmXH+fERHE0BSvb/FzhmF6bqFYAPQkfuFJi6s
	 Ao0dB+Vc2kvxQZ5AZZJ/xBHrHk8XO/Kqntxm+2VmMQ5JViu3zAWkFf5RUR+Hfttwac
	 orBCTlAglEPejleY2YRJmJHUWNcIpPZITMyOsPLwDSdlL8RbS6g
Date:	Mon, 18 Jul 2016 22:44:50 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160718224450.GF6644@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.20.1607180853300.28832@virtualbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607180853300.28832@virtualbox>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 09:00:06AM +0200, Johannes Schindelin wrote:
> Hi Brian,
>=20
> On Sun, 17 Jul 2016, brian m. carlson wrote:
>=20
> > On Sun, Jul 17, 2016 at 10:01:38AM +0200, Johannes Schindelin wrote:
> > > Out of curiosity: have you considered something like padding the SHA-=
1s
> > > with, say 0xa1, to the size of the new hash and using that padding to
> > > distinguish between old vs new hash?
> >=20
> > I'm going to end up having to do something similar because of the issue
> > of submodules.  Submodules may still be SHA-1, while the main repo may
> > be a newer hash.  I was going to zero-pad, however.
>=20
> I thought about zero-padding, but there are plenty of
> is_null_sha1()/is_null_oid() calls around. Of course, I assumed
> left-padding. But you may have thought of right-padding instead? That
> would make short name handling much easier, too.

I was going to right-pad.

> FWIW it never crossed my mind to allow different same-sized hash
> algorithms. So I never thought we'd need a way to distinguish, say,
> BLAKE2b-256 from SHA-256.
>=20
> Is there a good reason to add the maintenance burden of several 256-bit
> hash algorithms, apart from speed (which in my mind should decide which
> one to use, always, rather than letting the user choose)? It would also
> complicate transport even further, let alone subtree merges from
> differently-hashed repositories.

There are really three candidates:

* SHA-256 (the SHA-2 algorithm): While this looks good right now,
  cryptanalysis is advancing.  This is not a good choice for a long-term
  solution.
* SHA3-256 (the SHA-3 algorithm): This is the conservative choice.  It's
  also faster than SHA-256 on 64-bit systems.  It has a very
  conservative security margin and is a good long-term choice.
* BLAKE2b-256: This is the blisteringly fast choice.  It outperforms
  SHA-1 and even MD5 on 64-bit systems.  This algorithm was designed so
  that nobody would have a reason to use an insecure algorithm.  It will
  probably be secure for some time, but maybe not as long as SHA3-256.

I'm only considering 256-bit hashes, because anything longer won't fit
on an 80-column terminal in hex form.

The reason I had considered implementing both SHA3-256 and BLAKE2b-256
is that I want there to be no reason not to upgrade.  People who need a
FIPS-approved algorithm or want a long-term, conservative choice should
use SHA3-256.  People who want even better performance than current Git
would use BLAKE2b-256.

Performance comparison (my implementations):
SHA-1:     437 MiB/s
SHA-256:   196 MiB/s
SHA3-256:  273 MiB/s
BLAKE2b:   649 MiB/s

I hadn't thought about subtree merges, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXjVviAAoJEL9TXYEfUvaLeDcP/jjIjJ8/IU9hTsG6qe10xsJX
E52kmSl/9Pb8r6bHVTw1dOb0at8F/oGwX2FaB+KQtxeYR4+y3U/vSzoxI5GtJEtF
8ogWqaFQbRSIgJlMgQr99AOLh8mKVQiepZE1kEJwSaBsUwXFtWWXIXm2EGXJykmA
Wnny/yzy5sJ8ePbUGb/EklWjedgRDV63/A2XOZwygbQ2jPSPBgfxlpJrPjTuW60x
GKTWCI/Cg33GKiKITJEsnKLd9OBWI0avLxicrAulgIEl0Ayp1dkSc+vBuXVazgXI
ae9FxPRLNOUQJrmUbtNNi+KZAmhzfnJeFb4eESQryYM/VTaSzr/TKksTojzCmeRu
eoMPuDhn4+j/P4d7/q3XJf4j7P9YSnxLMkWUjGiAOt1VxbWnk14gzPSV22Wdp4um
Dz5uE+XPW7uJ57IfWF87t20OIqHp/0U8SEl3xNsKg/bI94L4TEPPOWpXVahsOeU8
wKwG2RMvX0NJlyf78x88jYc8I7WGakFoEXnrj2HqRVxUTfCeMvQ3DZYjgaA5D7lk
nTdPWxSJ1iH0VDMWZzEHuc5RjP0t1gI3ddG39Huhu201QWJDolml0fqd2DzAHfkI
oWB9EOx02G4smbjtvVjJWiervd7wuOgGZW4zti4m8hAlo4DlK3WCkwFbynvzyDRr
ChFU6PuM4hW3DkrbqNzy
=fuJg
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
