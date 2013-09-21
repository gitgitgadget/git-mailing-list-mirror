From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC 0/7] Support for Ruby
Date: Sat, 21 Sep 2013 23:56:48 +0000
Message-ID: <20130921235647.GC235845@vauxhall.crustytoothpaste.net>
References: <1379789295-18519-1-git-send-email-felipe.contreras@gmail.com>
 <20130921212904.GA235845@vauxhall.crustytoothpaste.net>
 <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 01:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNX2p-0004ch-0A
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 01:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab3IUX4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 19:56:55 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:60447 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027Ab3IUX4y (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Sep 2013 19:56:54 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 99A8E80001;
	Sat, 21 Sep 2013 23:56:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMP44s3Shdg40go-WyGV8QKwEGoXg8hvEe8tetMyxvx5Sb7evw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-rc7-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235151>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2013 at 05:52:05PM -0500, Felipe Contreras wrote:
> On Sat, Sep 21, 2013 at 4:29 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > As Junio has also pointed out in the past, there are people who aren't
> > able to use Ruby in the same way that they are Perl and Python.  If it's
> > announced now, Git 2.0 might be a good time to start accepting Ruby
> > scripts, as that will give people time to plan for its inclusion.
>=20
> Yes, and there are people who aren't able to use Perl/Python in the
> same way they use Ruby. That's why I tried to show why Ruby makes a
> perfect choice.

I'm not arguing against Ruby.  As I said, it's a nice language.  I'm
just saying that Ruby is not as common as Perl and Python.  For example,
in Debian, Perl is Essential (cannot be removed), Python is priority
standard, and Ruby is priority optional.

I think it's a bad idea to introduce an entirely new runtime, especially
one known to occasionally blow up on less-common architectures, without
some advance notice.  For example, at work I would not be able to deploy
a git using Ruby immediately because Git is an RPM and Ruby is compiled
=66rom source, if it is even present at all.

Also, the only Python script that is shipped with Git is git-p4, which
is essentially optional, since most git users probably do not use
Perforce.  Otherwise, all the scripts in git are shell or Perl.  So this
would be adding a significant additional dependency to core git, one
which is likely not installed on many systems.  Of the systems in the
Debian popularity contest, 41% have git installed and 23% have ruby1.8
installed, with only 16% having the default ruby installed.

> Now, if anybody has ideas into how the bindings could be more object
> oriented, I'm all ears, but unfortunately what I foresee is that
> nobody will consider this proposal seriously.

My concern is that the Ruby code will end up not being idiomatic, and
people will view it as bizarre and unmaintainable.

for_each_ref could end up being something like REPOSITORY.refs.each,
which would be more idiomatic.  repository.refs would probably be an
Enumerator in that case.  If the decision is made to incorporate Ruby
code, I'm happy to submit some patches to help provide a sane interface,
even though I'm not that familiar with Ruby.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSPjI/AAoJEL9TXYEfUvaLbM8P/i5bzqdq+BBRRojwrrC0WAy5
QyqxdncKSRtD9BMV1RZMeiDaZ0sgvmzV/eBKxuZOEsPNRVyPqPe2S7hJmmM18ZdG
fySb3BTQ6e3DrWYqOjwpUjPgLUZrBwefO302ZA1RldkDL4wXri90JBmpeef/i5UP
MBLntHSymp/R2dzPItamjlRa90FwnMhdIPpxwb0EbM5RkGXYoct5yOfbFYDIoxfd
hJq8k96F2F7Tz89CQRHELCVbH9TcVgrdu200+q/tbpDhK0KF1vHKhg8iXRNA5E8E
BnRqnlAqZvQYh99ne8ICXBdKoi+9p8i4pJbFAFAPKdMNV2+LlCC0J8jbznq9KAnB
wA5J39fOUnqP6142l6xh8M0PrjYzbxUU4+iTprN3Q9e2hOkiYNsZKeGBKphT2NSb
9i/bfn6AGrOsvz5K7opbD3g7uTq2teoyMKEMbsawIytuQwuQ8KGRKhgaxxKSk8CR
dDrYEjBzk2ztEmrjQGNhtzrE0zvJOFFlWKSon965sM7WyHMLF+8rPCsupDYajBfL
FxEA95wxYNBZGyMoc4BbGnqKvkRvLYA8E90DrgGfeqSyVrJwib6Jxp1pPzjR5Sgw
Jsgw01oxhZV7hT3hnj0xNfP9GjgGiXKfNVWrFR+vYdCo2ZjmUkHgkhxD8AJeyUyy
ugWtRxGvAmULUWALWuKQ
=3GjO
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
