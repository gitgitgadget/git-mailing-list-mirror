From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: gitweb not friendly to firefox revived
Date: Tue, 3 Aug 2010 23:07:30 +0200
Message-ID: <20100803210730.GA1254@pengutronix.de>
References: <20100801195138.GA1980@pengutronix.de> <m3lj8qozan.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de,
	Stephen Boyd <bebarino@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 23:07:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgOi4-00079L-NE
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0HCVHd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 17:07:33 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47487 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0HCVHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 17:07:32 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1OgOhu-0004QC-MI; Tue, 03 Aug 2010 23:07:30 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1OgOhu-0005Ho-H4; Tue, 03 Aug 2010 23:07:30 +0200
Content-Disposition: inline
In-Reply-To: <m3lj8qozan.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152539>

On Sun, Aug 01, 2010 at 01:26:16PM -0700, Jakub Narebski wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> > Hello,
> >=20
> > gitweb (at least) doesn't quote author names enough.
> >=20
> > Firefox barfs for me at looking at
> >=20
> > 	http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3D=
v2.6.16.10
> >=20
> > with an error:
> >=20
> > 	XML Parsing Error: not well-formed Location:
> > http://git.pengutronix.de/?p=3Dukl/linux-2.6.git;a=3Dshortlog;h=3Dv=
2.6.16.10
> > Line Number 112, Column 81:
> > <td class=3D"author"><a title=3D"Search for commits authored by YOS=
HIFUJI Hideaki / ?$B5HF#1QL@?(B" class=3D"list" href=3D"/?p=3Dukl/linux=
-2.6.git;a=3Dsearch;h=3Dv2.6.16.10;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF%2=
31QL@%1B(B;st=3Dauthor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL@?=
(B">YOSHIFUJI Hideaki...  </span></a></td><td><a class=3D"list subject"=
 title=3D"[PATCH] IPV6: XFRM: Fix decoding session with preceding exten=
sion header(s)." href=3D"/?p=3Dukl/linux-2.6.git;a=3Dcommit;h=3Dfa39df2=
ff7f6102f1f37d3cf1f68243534d56253">[PATCH] IPV6: XFRM: Fix decoding ses=
sion with preceding... </a></td>
> > -------------------------------------------------------------------=
-------------^
> >=20
> > This is with git 1.7.1 and Iceweasel (aka. Firefox) 3.5.10.
> >=20
> > Making
> >=20
> > 	title=3D>"Search for commits $performed by $author"
> >=20
> > in line 1694 of Debian's /usr/lib/cgi-bin/gitweb.cgi from the git 1=
=2E7.1
> > package read
> >=20
> > 	title=3D>esc_html("Search for commits $performed by $author")
> >=20
> > this problem goes away.  (Still my browser barfs when clicking at t=
he name.)
> >=20
> > I'm not sure if this is the right way to fix this and I'm too tired=
 now
> > to do a complete patch, so I let this for someone else.
>=20
> Actually gitweb leaves quoting of tag attributes to CGI module:
>=20
>   return $cgi->a({-href =3D> href(action=3D>"search", hash=3D>$hash,
>                                 searchtext=3D>$author, searchtype=3D>=
$searchtype),
>                   -class =3D> "list",
>                   -title =3D> "Search for commits $performed by $auth=
or"},
>                  $displaytext);
>=20
> I am worrying (perhaps unnecessary) that using esc_html would result
> in double escaping.  But it looks like the problem is with Unicode,
> so perhaps using
>=20
>   	title =3D> to_utf8("Search for commits $performed by $author")
>=20
> in place of
>=20
>   	title=3D>esc_html("Search for commits $performed by $author")
>=20
> would be a better fix?  Does this fix work for you?
No, this doesn't help.  Firefox still barfs with to_utf8.

With esc_html the code generated is:

<a title=3D"Search for commits authored by YOSHIFUJI Hideaki / <span cl=
ass=3D"cntrl">\e</span>$B5HF#1QL@<span class=3D"cntrl">\e</span>(B" cla=
ss=3D"list" href=3D"/?p=3D.git;a=3Dsearch;h=3Df66ab685594d49e570b2176cf=
a20b03360e9a6e9;s=3DYOSHIFUJI+Hideaki+/+%1B%24B5HF%231QL@%1B(B;st=3Daut=
hor"><span title=3D"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B">YOSHIFUJI Hidea=
ki...  </span></a>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
