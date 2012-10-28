From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Sun, 28 Oct 2012 18:34:31 -0400
Message-ID: <20121028223431.GF26675@odin.tremily.us>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=27ZtN5FSuKKSZcBU
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 23:35:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSbRb-0004Tk-RV
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 23:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257Ab2J1Wer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 18:34:47 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:53628 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661Ab2J1Weq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 18:34:46 -0400
Received: from odin.tremily.us ([unknown] [72.68.106.55])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCM005BMK1KGU80@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 28 Oct 2012 17:34:33 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EE69268272D; Sun,
 28 Oct 2012 18:34:31 -0400 (EDT)
Content-disposition: inline
In-reply-to: <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208574>


--27ZtN5FSuKKSZcBU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 28, 2012 at 02:59:33PM -0700, Shawn Pearce wrote:
> Looks like the Gerrit meaning is basically the same as =C6var's. Gerrit
> updates the parent project as if you had done:
>=20
>   $ git submodule foreach 'git checkout $(git config --file
> $toplevel/.gitmodules submodule.$name.branch) && git pull'
>   $ git commit -a -m "Updated submodules"
>   $ git push

Ah, good, then we *are* all using the option for the same thing.

> On Tue, Oct 23, 2012 at 2:57 PM, W. Trevor King <wking@tremily.us> wrote:
> > I'm not clear on what that means, but they accept special values like
> > '.', so their usage is not compatible with =C6var's proposal.
>=20
> "." is a special value to mean use the parent project's branch name.
> So its more like this:
>=20
>   $ git submodule foreach 'git checkout $(git --git-dir $toplevel/.git
> read-ref HEAD | sed s,^refs/heads/,,) && git pull'
>   $ git commit -a -m "Updated submodules"
>   $ git push
>=20
> We use "." in Gerrit to make branching an entire forest of projects
> easier. Setting up dev-fix-yy in the parent project will automatically
> track dev-fix-yy in each submodule.

Ok.  If we wanted "." expansion to be a general submodule thing, it
would add a special case to Phil's submodule_<var-name> export.  I
don't think such a special case would be worth the mental overhead,
but obviously the Gerrit folks think it is.  I don't care either way
on this one.

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--27ZtN5FSuKKSZcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQjbL1AAoJEEUbTsx0l5OMpZYQALXkyLw7knO5LN5x+qvxE1EJ
EHouAy7ad0YKuVZzn5BLOiqR97CN3Fynp87R1dq/s+d2qP4nroUYxZHewmbIIzcM
EYI3f895kZE3pe2jVlU/p6YDIodpRPpIL31JLv9akJUmSCT2ztz4SELiqA2+7Xx5
gYx0TQ3V0GFUpz5CYFiyIL2AbpU+sEOjgS4jBi6qlW6VzE/h2yhxCtVYYm9eOyE6
232xlUeUL1jPoICimvajTCzUzTPclD9SgqzcXsVNkUQNmEBWQ9DY77k21NhREHuC
q9FzrS71QsCh4WLXhKrsP7nveFL07NVFQ11JpOtZ+yJEr6Wbtng9dslQIy1GLaXJ
MIuuAC8wgFWdXankRrqsYQ+dLVU4RaCRy4GVW/oeliQ5i1S59qFxqCdzlM5GKItG
NVST5JdsM/cQzfD9Nq4HabvK6j4+v7wwvaslH9pLK5oYlK7tJrTMxW06oKsGbtlV
cW/9lq1R3yWjR4NY7FCjlK4wCxQmUWZS0zTl4zbXdF9JFojAD7xd2PTG6aHkEcs8
sSGkGTb8hrn7XTNU/NktrDVQ3HnW6hzthUIRtIIqNKG7Da6kdWc5nluxdPJVKLS6
FLi1flcOXHXiHjW0inFvQ0KnklnhytKpbaZMweeTKd2vse/YVuw8q9qHA5BUHx26
g0LPrYoxgBxHUMiu+GT8
=Fjij
-----END PGP SIGNATURE-----

--27ZtN5FSuKKSZcBU--
