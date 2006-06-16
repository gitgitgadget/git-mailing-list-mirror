From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 15:19:22 -0700
Message-ID: <1150496362.6983.34.camel@neko.keithp.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bYiSboa78REY1Fu5U5+5"
Cc: keithp@keithp.com, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 00:20:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrMfW-0000mm-EP
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWFPWTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWFPWTs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:19:48 -0400
Received: from home.keithp.com ([63.227.221.253]:20486 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751087AbWFPWTr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 18:19:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 85D2C13001F;
	Fri, 16 Jun 2006 15:19:46 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27624-01; Fri, 16 Jun 2006 15:19:45 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id CEEB213001E; Fri, 16 Jun 2006 15:19:44 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 55A5C14001;
	Fri, 16 Jun 2006 15:19:44 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 4BCBC542B2; Fri, 16 Jun 2006 15:19:23 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21979>


--=-bYiSboa78REY1Fu5U5+5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-16 at 17:44 -0400, Jon Smirl wrote:
> I'm getting thousands of messages about unnamed branches and even
> 'unnamed branch from master-UNNAMED-BRANCH'.
>=20
> How do you get unnamed branches into CVS, are these check-in errors or
> are people actually working on unnamed branches? Or is parsecvs not
> finding all of the branch info?

branch names rely on a special 'branch tag' in the "symbols" section of
the CVS file, but actual branches are flagged directly in the revision
list. I don't know how it happens, but ,v files often end up with
branches in the revision tree which haven't an associated tag. Go
figure.

For example, in the top level mozilla/Makefile.in,v file, you'll see a
branch from version 1.36 with an initial commit 1.36.2.1. Using the
wacky CVS branch revision numbering scheme, there should be an
associated tag for version 1.36.0.2 (yes, the last two digits are
flipped). But, none is present in the file.

The reverse situation also occurs, with tags for branches that have no
revisions in the file. This case makes sense -- until you make a change
in a file along a branch, there will be no other record in the file of
where the branch came from.

I'd love to figure out a better mechanism for merging these nameless
branches into the resulting repository, but I don't know how to
correlate unnamed branches in one file with unnamed branches in other
files.

The current scheme of making up a fixed name and hoping that there
aren't multiple unmamed branches from the same root is probably fraught
with peril.

--=20
keith.packard@intel.com

--=-bYiSboa78REY1Fu5U5+5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEky5qQp8BWwlsTdMRAvI1AJ4nXKyzeupTDarXI+yM0zvuHaCoTQCdEBYC
Kl7lEHIJgi5Tk24quc9FZyM=
=FA7H
-----END PGP SIGNATURE-----

--=-bYiSboa78REY1Fu5U5+5--
