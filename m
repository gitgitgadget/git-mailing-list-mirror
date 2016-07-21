Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533B5203C3
	for <e@80x24.org>; Thu, 21 Jul 2016 01:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbcGUBCR (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:02:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59982 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752613AbcGUBCP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2016 21:02:15 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 73871282AF;
	Thu, 21 Jul 2016 01:02:13 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1469062933;
	bh=U3DC6EfHZaOrLKPNfbcF8kC++H9siJ1WXn+eK6m4hZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nu+LU2XrjLZI0Q+m3Z6Tj4Pd7ZY3YlU2XyDP5MxYY+ph9MeIbovCPO0d1eOB6fhh/
	 /RQTF+wj2vizLJT15WVeYKvdGO360IUp1bWPFM8Ro9Fr8RSElljwFMhLWkCjwPPmMq
	 lNGTHxctQWq0wZHnSdMfDpQBzX/1e0zgURvCVPECrMrCpopt2PCPeASI07ASrtTt9m
	 BcebZa5lP2sh8rsyy59pAV8svlVwEWRMpDqOX7PR34wsLROsrVTFqUWIiUASvP01SO
	 JTPPmX9SZu/ggBOHyWkja+LpBbtmEI+3sLizrrQOnPcRoEMiCr469NwUYE1sbw5j+b
	 5mePRDR6i3fZJgJEe9MdnfNG9lg752HPhMFz0r+azqs+b3eonrFjR3R2PD7Alb0yA5
	 xb3lz1sPS0Bucpffiu/MUDvROmlD+gN0ZEdqBbtGXXE94Hd9idVN8YrZwsuV8CBP0D
	 fS3npZr6g79BCKYQETJz4m5Neps7JnoauJbZYibh9So+SdFZBMP
Date:	Thu, 21 Jul 2016 01:02:07 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] config.mak.uname: set PERL_PATH for FreeBSD 5.0+
Message-ID: <20160721010206.GA215655@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
References: <20160720025630.GA71874@plume>
 <alpine.DEB.2.20.1607201322350.14111@virtualbox>
 <20160720180702.GA13404@starla>
 <CAPc5daXuZZuhaTW-hb6FOo6p+gzvrd-rx-FDvo4VzCOH+HpSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <CAPc5daXuZZuhaTW-hb6FOo6p+gzvrd-rx-FDvo4VzCOH+HpSJg@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 11:10:40AM -0700, Junio C Hamano wrote:
> On Wed, Jul 20, 2016 at 11:07 AM, Eric Wong <e@80x24.org> wrote:
> > Also, my use of a numeric comparison may be more future-proof
> > in case FreeBSD decides to have /usr/bin/perl again.
> >
> > I also wonder why we don't use `which` to search for somewhat
> > standard path components, instead.  Something like:
>=20
> Because historically output from "which" was not meant to be
> machine parseable (some implementation said 'perl is /usr/bin/perl')

The POSIXy way to write which is "command -v", which may or may not be
more portable.  It does have the desired output, though.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXkB8OAAoJEL9TXYEfUvaL3eQP/1egx/thQxPt0ax4VegZJSN2
KLpO7Vc4HG+FYTgaxzsX0yTEDWtDCe44eOuhdzon/7TdLJAOw+8f/KfG8m/EC5gX
9mDHZxWJBPeIoISJxPPEx/FpC2N1F2kzdRIrGY4AW+hOhzf4m8t/cXAn7QEx+RAZ
6ozr/zdf342hYTlj0ekNRYL6eKbK3R5V41ubk0Zreqx1RmtXdIHCdh9RF7A+HqhO
8vZttvIpqR5hmWPre+y+2tkEBqSGfpJpc4iJUyVC4ZQ2vMdRxqnB7Rei/CHSzMCZ
cjVmrvzO2SCmOldhhDXa0pKPrjEaDcsWu391SycbVY7xLi0Xz0fdnf59QEKcEBWx
p43OGD2dWtZGMcoFS7l0cJlvf2BNkM/ifL9zvA7P6kmwQyCSa6/uXx/SJPm4YI6W
YwGlLOYEedlRrCvP58Cvg09tJ3T6xXbnWJUAQqvFuvGkY3yv4EKX4YQGGztO+j+X
k0T49MJRPsX+e5IyT4Uyl5Q8ldnc1KuyMq6uJyCGXDLK1jj1bGN4WfT1NHYt6nyH
LCKBgt1a4Xr9MZ6aCz2njb/MstEb+o47pcavZN9NoeXwngWZJ39xLxjGmdM4DuG3
gkWkVt6H/GdCacJIcIqPLNAkDs/LcNmFITuiVupcDJdkoS/FtR4F4fz94dAu6kQd
SzeCmtEOXFEvpXryOB0x
=ZTR2
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
