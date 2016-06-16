From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Easiest way to clone over an existing directory?
Date: Thu, 16 Jun 2016 02:44:34 +0000
Message-ID: <20160616024434.GB371617@vauxhall.crustytoothpaste.net>
References: <20160615155133.GA13168@x>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 04:44:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDNIY-00034T-9A
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 04:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbcFPCop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 22:44:45 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:48440 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753172AbcFPCop (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 22:44:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CD44C282AA;
	Thu, 16 Jun 2016 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466045080;
	bh=F527nrKvcMsQRrhI/rEFjRJ4Eo4dUi7hM5prK1p0RdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=032wF/3AnkU6+jp9/SkKAAJC6mpOt7ltkKooSAIKdqkM9dRLnN30gFsKT6o7NefWY
	 4B0COgs/5hY9WIhbeX6eJF51ziiqg3xgpSZW4sg5LXcMLit9jCaa6OpghNt+J/Tr1f
	 gJOH/lGNpIbQmk7Gbi5FPc00Yj/Rr39F0izalhNjDjYNvnGs9HxGqRgskIY/cF1jbr
	 02E4y43Bf6ORHDqOpSxSrGGUi2H3q4xIAQ8rGfazUTHxkqIM8gr+jUM/dN1OJOnMXy
	 FbwAQ01eQvqh6F4EDUBCPwRwfx8kyCX6crpV/rIkbLhvyDq8/GP9rTjfnyacVIVFfw
	 lHjsEmRt+uQZSo+7BS/kHqlIrdXoeRfRPZMAG8QAn3uz/1HpsKAbcb+F7X4v39bOW9
	 4eu/sq/Q22Z334unu1OPjkuLqSFRnIjEfCe6L5o7xCjP3RGRRstjI8q4jIsMG4+FKq
	 viXCvHtsVjSjXmBjuuHwKTUIjDAqeNLJSbJjiRPuGyVSobRj/gn
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20160615155133.GA13168@x>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297406>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2016 at 08:51:34AM -0700, Josh Triplett wrote:
> Currently, every time I set up a new system, I run the following:
>=20
> git clone $MY_HOMEDIR
> mv home/.git .
> rm -r home
> git checkout -f
>=20
> This seems like an odd dance to go through.  But I can't just git clone
> into ~ directly, because git clone will not clone into an existing
> non-empty directory.
>=20
> (I could use "git clone -n" to avoid the unnecessary checkout, but the
> files are small, and it wouldn't remove the need to rmdir so the number
> of commands would remain the same.)
>=20
> Does some better way exist to handle this?  And if not, would it make
> sense for git clone to have an option to clone into an existing
> directory (which should also avoid setting junk_work_tree)?

My typical technique is something like the following:

  git init
  git remote add origin https://git.crustytoothpaste.net/git/bmc/homedir.git
  git pull origin master

I'm not sure if that's the officially sanctioned way to do it, but it
does work reliably.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.12 (GNU/Linux)

iQIcBAEBCgAGBQJXYhKSAAoJEL9TXYEfUvaLyh0P/1tdigIM5PiSJR4dFybETBNH
LAFe8+jOR1pz8S86gwA3TlrDusqckx6+r5HL9Ia1UcxXDucXZ1Kg/Oc2q/uAbjVw
WnD2yN8EF7JAz7cWnbZO6k5bGpmSIzqRoTl+y6gryFw2RiJTxe3P41MZHJwnyrQm
dmqe4b3d8vfZYC/CnsH4mhzWLfJKnktojd7cSyAtF1OnM3yVs1//Wl7yAA9frAFd
URKGbVxdu/xihnzsGh/Bl2wOKZgLjiHR+yfo+1yhqNew0MIaFb84bj2iOQv2MOp7
GX9cEh2V0vD3ZCoVr4hTGv1rpZBtxcBft9MpXuxcLE+llxIvvpNZKm8uGjyNV+GO
ySKFpQz5ppo2cn4q726bEnSjv3oY85tmjzkmsIaFFqlPCEtJcxdmKBZHGUxok/2p
wsc+gb+z2taBfwccMIWNvJqt9WhxKi5pTzX1aMUJz9lc7ohxcCZV7vxcYcn0G0Bj
mJ91Mn4OJeJQrJl1ujmQGL1tWiiFZRGmaZRz37/N+ryt3WQrrRWpKZ04bKfImcd2
QhbKfW98eNwwIyqqtG77XDDFruBCZE/aShu7TX3pa1gjtGpidqQVo0IZe5VHRu8j
ZPRPN0gxRlqg355odBoUgymyJvr+g7r2ToGmS1nJyCmM/G1ecKXpflGyUwhqJLbN
Bb058c6W4QjwGxfjgmy6
=pxJZ
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
