From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 15:21:18 +0100
Message-ID: <20080613142118.GA20027@bit.office.eurotux.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com> <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7AAQ-0004Xc-Jz
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbYFMOVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYFMOVU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:21:20 -0400
Received: from os.eurotux.com ([216.75.63.6]:52997 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYFMOVT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:21:19 -0400
Received: (qmail 30924 invoked from network); 13 Jun 2008 14:21:17 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 13 Jun 2008 14:21:17 -0000
Content-Disposition: inline
In-Reply-To: <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84880>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2008 at 09:38:18AM -0400, Denis Bueno wrote:
> On Fri, Jun 13, 2008 at 09:26, Denis Bueno <dbueno@gmail.com> wrote:
> > That line simply calls perl by the $PERL variable, which is set at the
> > top of the script, like so:
> >
> >    PERL=3D'/usr/bin/env perl'
> >
> > If I change this line to point to my perl directly, it works.  On a
> > hunch, I changed it to:
> >
> >    PERL=3D"/usr/bin/env perl"  # note the double-quotes
>=20
> [snip lies]
>=20
> Apparently I didn't test this thoroughly enough, and I was wrong.
> Changing the quotes has no effect.

That makes more sense.

Try changing the following line instead:
	"$PERL" -p -e "$script" "$1.tmp"  > "$1"
to
	$PERL -p -e "$script" "$1.tmp"  > "$1"

about line 6121 of the git-instaweb script.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSgl4ACgkQinSul6a7oB9lbQCfeuCtiuGR2R8/UBYQaLyg+z7U
vRYAoJzNSJjBGPq1mu7oShXBJ7LoSKdT
=dDUq
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
