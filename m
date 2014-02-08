From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git best strategy for two version development
Date: Sat, 8 Feb 2014 03:56:11 +0000
Message-ID: <20140208035610.GK635004@vauxhall.crustytoothpaste.net>
References: <52F59131.5000808@ist.utl.pt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RNGrj7vazCqBHNw7"
Cc: git@vger.kernel.org
To: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>
X-From: git-owner@vger.kernel.org Sat Feb 08 04:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBz29-00033o-E4
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 04:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaBHD4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 22:56:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51698 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbaBHD4U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Feb 2014 22:56:20 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3505:3fa4:e66:a69f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F32A428074;
	Sat,  8 Feb 2014 03:56:16 +0000 (UTC)
Mail-Followup-To: Carlos Pereira <jose.carlos.pereira@ist.utl.pt>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <52F59131.5000808@ist.utl.pt>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241818>


--RNGrj7vazCqBHNw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2014 at 02:06:41AM +0000, Carlos Pereira wrote:
> Hello,
>=20
> I am a git and CVS newbie, I bought and red most of the excellent
> Pro Git book by Scott Chacon, but I still have a doubt. I have a
> package that I distribute in two versions differing only in one
> library: version_A uses this library, version_B uses my own code to
> replace it. For strategic reasons I want to keep it this way for the
> time being. Both versions have the same documentation, the same data
> files, and 99% of the source code is the same (a few makefile
> changes, two additional files in version_B and some minor changes: a
> diff -r has only 170 lines). The question is what is the best
> strategy to manage a situation like this with git?
>=20
> Shall I maintain two different repositories? I don't think so...
>=20
> Apparently the best solution would be to maintain two long term
> branches, say mater_A and master_B, and merge all later developments
> in both branches, keeping the initial difference... Specifically:
>=20
> 1) do some new work in branch master_A, commit, etc.
> 2) checkout master_B and merge the new work in master_B, without
> merging the initial diff between the two versions.
>=20
> What is the better way to do that?

That's pretty much the way to do it.  If you check in master-A, then
create the master-B branch off of that, copying in the code from B and
checking it in, then when you merge from master-A to master-B, git will
basically do the right thing.  Changes you make on master-A that are
specific to that version will probably conflict, but they should be easy
to fix up.

I basically do this for a consulting project for a client: there's
generic code in master, and a special branch for the client.  Since most
changes don't touch the modified code, conflicts are infrequent, and I
can fix them up when they occur.  I also do it for my dotfiles, which
vary slightly between home and work.

You could also make the changes to master-B as a set of commits on top
of master-A, and always rebase master-B on master-A, but this isn't a
good solution if other people are going to be using your code.  It has
the benefits of keeping the history free of frequent merges, which may
or may not be important to you; it doesn't really bother me very much.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--RNGrj7vazCqBHNw7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS9araAAoJEL9TXYEfUvaLpr8P/jM0YsSFmqnU19AvrcG1yQKy
5ZGg7fy/WI8X6b3TLjRvgkiwuTnTIBA3oJuDizC6JpHu6vl0K43D41je6YP9dXvG
57Pml6Uo73Ac6Xrn1xSbIzdXNcHT3E6yvXM5LnJVstLi5LFelwopC4iVxQd2hXZz
dIiO6dsraCdenX35+FMzuIoaPpvkhWcR+2Qo8jUi2uKtVBzMnoYLxFZaoLEb8qre
Mf9dZkHXinv8eQDtSRg6fl1Z7r9hPuN693s/EK0ArvxXW13I6yiQFLpovQuDwnpj
NU0grydHoCyhTBewc0go/0F+7x8irhHBkJe34IjotIq04VmmDrMoLs/9T9CAePb1
rRD3ADw+q8pguDhjbL+23XtcCaeaDls/KEKK+L9gLCkDXgVvlZkS+M5RkA+fOCA6
BHrCBZazbVve/eObs5kdq6JZCx42JP8VnmiFj8aeuDmPt6EWhIQwwl/UtHDGCgd/
v0fohMpHF7R7FRZn1Ec2LyYuVTVx7qY6ITAHbWIWOgs9AqyYswrriY8XGCdhqPNh
U2bQX9dLUCa108aFVn8u+zBKSMl6EuV5iwmxcdvTLVtB/gGDEUsoEzW+0FYd2BeK
+l7ZrnGKUZpnhbyO0KeCpj1JYVM0dYUzDGwIn6SUEIPdcn2AousvB+cUS/1aeQXO
v30TUvp2oasK3VuGSDeo
=2dTR
-----END PGP SIGNATURE-----

--RNGrj7vazCqBHNw7--
