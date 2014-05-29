From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Thu, 29 May 2014 12:19:26 +0000
Message-ID: <20140529121926.GA47385@vauxhall.crustytoothpaste.net>
References: <1401307055-11603-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 29 14:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpzJ5-0006pU-TK
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563AbaE2MTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 08:19:33 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48022 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756105AbaE2MTc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2014 08:19:32 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:a4b2:6cd7:504e:d077])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5F6D428087;
	Thu, 29 May 2014 12:19:30 +0000 (UTC)
Mail-Followup-To: David Turner <dturner@twopensource.com>,
	git@vger.kernel.org, mhagger@alum.mit.edu, gitster@pobox.com,
	David Turner <dturner@twitter.com>
Content-Disposition: inline
In-Reply-To: <1401307055-11603-1-git-send-email-dturner@twitter.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250364>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2014 at 03:57:35PM -0400, David Turner wrote:
> +ifdef NO_SSE
> +	BASIC_CFLAGS +=3D -DNO_SSE

This is not a great name.  This implies the system does not have SSE
(SSE 1), but in fact what you're concerned about is SSE 4.  This will be
confusing for users of older x86-64 processors, where SSE and SSE 2 are
architecturally guaranteed even though SSE 4 is not present.

> +else
> +	BASIC_CFLAGS +=3D -msse4
> +endif

You probably also want to autodetect when the system is not x86(-64)?
and turn this off.  I doubt PowerPC/SPARC/ARM users are going to want to
have to disable it manually.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJThyXOAAoJEL9TXYEfUvaLkT4P/i9sSHBF9SDMvHRyAnzMK0pB
OAjhiSeQ67x6MtedtYCHy54ezGLlLKY0NVfpyiFrKLhfLpneyyfdcRx4JDfgFyp2
qQJv0Wc+DQARinFnaLtIw8TJj0bzyWQTk4yPK6Ybo5QvW/P2T9Jzd7nSJNHHl+oB
Tg+tx6py9AHl/ro9gAnR9Da8yC8dcXGhT1zOTwYDjGocjLRa9J61JZ65iwsJ+jZx
v6o57n1BNnVCKGll8wHt0MjeeBSsHdgz+wQNt/Sw8v/iyR5Vjofuq0P2qxbym3bD
CZ87wD46TBGwG8jAiG/bzopmBHglMwJ/g4BLHRGaW1qwH9CL/Yc8TzJfQ7l9rcVx
14ecmH9fQkmL20hNQi234VqqwEAt2OtZBA6YT83qp8VF/hT2w+O59AaDYNqF2c33
EVeY9ECqYR1F+ipWC0f0e6py4KNOCXlcPSTZeIrp70HckS7LvBMv+bzFd0n/gdER
RyJNVo2ZPhXm76KdDNDnbDv+A9/7b6C3TDM3HbdYLTk9Z68OU9heNycFYqQN7jPR
UTUnwd+cG+RS4W3y05sbe0qccrfR5cwA9LoN80SDlibfmwtelCF59ZAZ7SF50d0y
YTrfU02bZBbONL9oM3kRNKxl7BWQZq2jWkKHYRisWnM3FHP9Qx6BuEkW8wR38Zk3
I7GnmeysYWbsV/33X6w3
=oAHt
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
