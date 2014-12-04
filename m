From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Disabling credential helper?
Date: Thu, 4 Dec 2014 00:42:31 +0000
Message-ID: <20141204004231.GA200195@vauxhall.crustytoothpaste.net>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
 <20141203012148.GB29427@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:42:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwKVJ-0007jY-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 01:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbaLDAmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 19:42:42 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:54957 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751030AbaLDAml (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 19:42:41 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 73B702808F;
	Thu,  4 Dec 2014 00:42:35 +0000 (UTC)
Mail-Followup-To: Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20141203012148.GB29427@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-1-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260717>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 08:21:48PM -0500, Jeff King wrote:
> We could teach the credential-helper code to do that (e.g., a helper
> returns "stop=3Dtrue" and we respect that). But I think you can do it
> reasonably well today by making the input process fail. Sadly setting
> GIT_ASKPASS to "false" just makes git complain and then try harder[1].

Yes, I did notice that.  I tried /bin/false at first, and was a bit
surprised it wasn't effective.

> But you can dissociate git from the terminal, like:
>=20
>   $ setsid -w git ls-remote https://github.com/private/repo
>   fatal: could not read Username for 'https://github.com': No such device=
 or address

I think this is a bit heavy-handed for my needs.  At work, we develop on
headless VMs, so we use SSH for pushing since we can forward the agent.
At home, I use Kerberos, so the prompt generally indicates I need to run
kinit.

In neither case do I actually want to enter a password, so the
environment variable will work fine, I think, since it sounds like it's
at least semi-supported and it works well in scripts and in
configuration files.

Also, having to patch the Perl git wrappers to use setsid would be more
inconvenience than it's worth.

> That might have other fallouts if you use process groups for anything. I
> have no problem with either an option to disable the terminal prompting,
> or teaching the credential-helper interface to allow helpers to stop
> lookup, either of which would be cleaner.

I'll probably submit a patch to disable the terminal prompting this
weekend.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUf633AAoJEL9TXYEfUvaL/JYP/36MNuXJmHTcX88N283UfqY4
1SKKgds2TVs1JY+Gnir2tj6XJ9Sr7gbA2Ss5Yc43/v314Ucm6GpgJqTuatnW47gV
YjbnUjLFFl6AXjWZwjKXJXRJyd1r9tgM7vlSoIC2uiy5z1y/NXuSlEWaiDsCJUki
70d5INLQhqnx7Q/BNYLjDRPK8YXfXRmrtLVDWQXeY5fXjAMpXDP0PDrZRCEdcU8M
qVH++VAkPJYU7d5+78K1gikQgku8DXwZUXT5CY1Vs8zk20NsWbirkLAWJuFTdIrz
KIPOq6RL9gtpkcBZjwd7PrRnu8gk+Io4vUGUAwB9nvBKzP2q5O235JARGbI2XeTn
6HvSylmAfA89qdEHUMtZb/qFqe0avIGpvnvHgfmhbN6qts9q4GK8apgY9CbWuDd4
sIyCuSUD4exyMWeqDTfBHnD8c/ujwwjSxGeCR6S+68O2PLfzO7pvd2dv9RSpJw11
ibVZ+B51wcj0ZkhbBNY5g8GXtYfqM17ETQ25qvnPx8mK3lmGGpkK/GXfnlRHkSWE
WD5HR0MHKHuujipe54vuMCLUJS3qhWKtXk34D+r22HV9FY+2+jdq3zpGoDNCIGVC
UpfFmBI0cb5Gg72tFg69JDDv7wi0lxiz0gQJJacR3DEjXQ/vwLe0XQ9KFxaTMg24
xtbXsyLjRZbmJfuJzQg2
=Neoq
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
