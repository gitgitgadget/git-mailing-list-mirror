From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 06:45:44 -0400
Message-ID: <20121029104544.GA2424@odin.tremily.us>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us>
 <20121029053401.GB30186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=OXfL5xGRrasGEqWY
Cc: Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSmrH-00068Z-HS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512Ab2J2KqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 06:46:03 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:34762 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab2J2KqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 06:46:01 -0400
Received: from odin.tremily.us ([unknown] [72.68.87.154])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCN00A6JHW8WJ30@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 29 Oct 2012 05:45:50 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 83CCE6838B5; Mon,
 29 Oct 2012 06:45:44 -0400 (EDT)
Content-disposition: inline
In-reply-to: <20121029053401.GB30186@sigill.intra.peff.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208614>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2012 at 01:34:01AM -0400, Jeff King wrote:
> On Sun, Oct 28, 2012 at 06:34:31PM -0400, W. Trevor King wrote:
>=20
> > On Sun, Oct 28, 2012 at 02:59:33PM -0700, Shawn Pearce wrote:
> > > Looks like the Gerrit meaning is basically the same as =C3=86var's. G=
errit
> > > updates the parent project as if you had done:
> > >=20
> > >   $ git submodule foreach 'git checkout $(git config --file
> > > $toplevel/.gitmodules submodule.$name.branch) && git pull'
> > >   $ git commit -a -m "Updated submodules"
> > >   $ git push
> >=20
> > Ah, good, then we *are* all using the option for the same thing.
>=20
> That makes me more comfortable. Your patch adds support for setting the
> variable initially. Does it need any special magic for maintenance, or
> is it something that would always be updated by hand?

Everyone we've heard from so far interprets the setting as =E2=80=9Cpull fr=
om
$branch in the remote repository $url to update the submodule=E2=80=9D.  Wi=
th
Phil's export, that would become

  $ git submodule foreach 'git checkout "$submodule_branch" && git pull'
  $ git commit -a -m "Updated submodules"
  $ git push

As Nahor mentioned on the 23rd, there are a number of ways that the
upstream branch could disappear, but Git has no way to know what the
new branch setting should be.  This means that even if we make =E2=80=9Cpull
=66rom $branch=E2=80=9D interpretation official, we still couldn't do anyth=
ing
slick about updating it.  So, yes, it will be updated by hand.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQjl5WAAoJEEUbTsx0l5OM9cUP/1kH4/2c2RUbSRqe29y08SH0
qk/bsRumEFG4rZ0S6FLf27ozrfGl6dVzsNX9rVszJjLuvXrtTGLutZkxFNTSZdaz
vIndHUIAp7M8ppl1lqubFyRAE1VqKzHT2k3W2FdQ/uaCBAX2iStAAjyKmzuN8Yvb
SX68p6pnbb7S5jbUsyu2HYHVKdjKN1NIRk0PsYJ5/pgmqURRMoBMY/Aj4Tb2bbuP
JftQWUtJSggs4UUd+L2IpllyNrJcQJ2cyuXpklV8GPm7ivKEkGJBZdAxMLBS3gb/
4zjEQ6xzDeY8LFq04sBk5xGYL0gljmEqWHcvnlCwruZ48YYzhTzrshJOC/oyUiGl
HlYz3/uLMY0X0EBIQnrtB427JEbHEcMg0JihHxr+njfZUFxV4UDOwzoispoURJin
2qMWoSWMPClz90Mg/iQLhLhknbeu18TBU5RgJL7ChjbbO4zwFcilMKeB6tMWMZpm
PmIab5+bwahSznBvtfERMunO77YbL/3tRdLCLgfA0obUvNtMGHZ9hFIlkq7AHszM
s7DIcyCBfjh3oZiAvQ6Mv9XkGLbjUk1ggdsH+G1/s1mzfrNdhTt2T4in6gHYCLdl
F2YZzqD+wfgEx0tt1FUm3oZ877+Pzl58EOfzIEbMufvauM6WoDnxUwEdQPI3mvj3
saS9TyGOtNZkjoM2P8lQ
=soJm
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
