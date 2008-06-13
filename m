From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 16:13:07 +0100
Message-ID: <20080613151307.GA21917@bit.office.eurotux.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com> <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com> <20080613142118.GA20027@bit.office.eurotux.com> <6dbd4d000806130739r633cb34cx9edbe48724d6a325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 17:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Aya-00011Y-L3
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 17:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbYFMPNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 11:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755523AbYFMPNH
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 11:13:07 -0400
Received: from os.eurotux.com ([216.75.63.6]:58509 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549AbYFMPNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 11:13:06 -0400
Received: (qmail 4006 invoked from network); 13 Jun 2008 15:13:05 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 13 Jun 2008 15:13:05 -0000
Content-Disposition: inline
In-Reply-To: <6dbd4d000806130739r633cb34cx9edbe48724d6a325@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84890>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2008 at 10:39:11AM -0400, Denis Bueno wrote:
> On Fri, Jun 13, 2008 at 10:21, Luciano Rocha <luciano@eurotux.com> wrote:
> > Try changing the following line instead:
> >        "$PERL" -p -e "$script" "$1.tmp"  > "$1"
> > to
> >        $PERL -p -e "$script" "$1.tmp"  > "$1"
> >
> > about line 6121 of the git-instaweb script.
>=20
> This is line 6033 for me; however, this change makes it work!  (I
> verified my changing this line; trying it; then changing it back to
> the double-quotes version, and verifying it breaks.)
>=20
> Why?

"$PERL" means the content of the variable is used as the command to
execute.

$PERL, on the other hand, goes through a round of word splitting, that
in your case results in the command "/usr/bin/env", with the arguments
"perl", "-p", ...

Thus, if it is possible to use /usr/bin/env, the current "$PERL"
incantation is incorrect.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhSjoMACgkQinSul6a7oB8xNQCfTrawk97jvi8tkfLFLgv6yw4m
HI8AoJ3Iuf8RUfOcrNR5NjFsdx2s8BMT
=zASC
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
