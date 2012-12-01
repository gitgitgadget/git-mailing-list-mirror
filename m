From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 13:16:43 -0500
Message-ID: <20121201181643.GF4823@odin.tremily.us>
References: <20121201163004.GB4823@odin.tremily.us> <50BA3D7D.8040707@web.de>
 <20121201174920.GE4823@odin.tremily.us> <50BA4695.7030008@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=juZjCTNxrMaZdGZC
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 19:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tercj-0003nk-US
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 19:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab2LASQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 13:16:54 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:58895 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab2LASQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 13:16:54 -0500
Received: from odin.tremily.us ([unknown] [72.68.81.98])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED007LO6RWI1C0@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 12:16:46 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0416D6E3D84; Sat,
 01 Dec 2012 13:16:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354385804; bh=bUbl4CPRe9+ZOlOQ6Kw+xiVSzao6NtW8ZuAJZAEPVqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qfy4ZRS+J6pJDxPk8ECoPp3hMsT0BmFAIvnwrvwo6AMrPjYCX2TYiTjqxhP5UiZ+E
 RrmEt4n7w0yWYuhEsCGzRnLeQwRpVQ2o4BkLOyZ1c1AmQvlbmbr60goJMztjtkcmFj
 gcslO6vQ1iUcWqbii5EyO7LCWJvicl5k9qVcQVuE=
Content-disposition: inline
In-reply-to: <50BA4695.7030008@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210985>


--juZjCTNxrMaZdGZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 01, 2012 at 07:04:05PM +0100, Jens Lehmann wrote:
> Am 01.12.2012 18:49, schrieb W. Trevor King:
> > I think removing `init` will cause some compatibility issues anyway,
> > so I was re-imaging how you do it.  I don't think update=3D'none' and
> > "don't populate my submodule" are distinct ideas, while a locally
> > configured url=3D"somwhere" and "please populate my submodule" are (with
> > the blank-url case defaulting to the superproject itself).
>=20
> Why would we want to remove "init"? It still has to copy the "url"
> setting (and it would be a compatibility nightmare if we would change
> that, imagine different git versions used on the same work tree).

In my init-less rewrite, it doesn't have to copy the url setting.
People using older versions of Git would need to run `init` using
their old version.  Having the url defined in .git/config won't break
my init-less submodule commands, it just means that the value in
=2Egitmodules will be masked.

> >> What real world problems do we have with the current init/sync that
> >> this approach would solve?
> >=20
> > I don't have any, but in my `update --remote` series I'm adding two
> > new config options that are handled differently (define in
> > .gitmodules, override in superproject .git/config) than existing
> > submodules options.
>=20
> No, they're not. They are just handled differently than "url" and
> "update", but will behave just like "fetchRecurseSubmodules" and
> "ignore" do since day one. And as I explained in another mail I
> think "url" is special and "update" should be change to behave like
> the other two some day.

I somehow missed those earlier.  Thanks for correcting my tunnel
vision.  This makes me much happier about postponing the init-removal.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--juZjCTNxrMaZdGZC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQukmIAAoJEEUbTsx0l5OMdZwP/RPXppUME0MEm2Yaj3DLDC6c
R1iUF3lbASnk5TdGV7lFleVItPcwGgrYg70JqNVmbchx2FzRiq67jpEB+7Z80YV4
TnPoHAT2LRPgcn9v6fp8UmQ3fm3WKp4JP0dCFh227CC1IRX/TRabKHFcy+B9L0HG
qFvFsyNObw9qAl+R30I0P+2F6Bb+02rdHUWk9jQewjwIakyZJW+GnLYrntMUxuDW
uDXlYOO5xlImhp8oi2q9xr/H171CSgMLUNZJ88qtjZCXqmlXByhagT1xx0jVac0y
PcDcywStqVWFiTtpzOg2bIr1uBzYp6tSllu+KDBN7dnm5ElxZvzklG93mxk47G9N
lRD+rnzvrbgkWLmRR3RMO75jqgGCDcchAifxTsu999rQe2bhTWGbvHyWXIGphUWx
eJXI+9XMXpM2Guhbndj/ex9EoyQ6XoIxOxu0idfLwpD1j/wa1D21CN8FzY1P2tcK
y8WNIYzDXj1lRgVpU4kstQgyE+P2JLoLOQDe8kYxJvP+FvLAUKXkY9RusvtESc1e
BpA/R0afuIENQT+71v1tl3j5wysY4rDpGYbJCYggLgjiWsfZLRXYZqVltMqxuYx5
VQPc4EWdqMwUvOpaH7jWAC1izFNwhLr/1Ei2NEGuBqTWEWWkRc05YDhSVuH2lp0I
QJwlCdoo5H8lDMm1HFI/
=opKZ
-----END PGP SIGNATURE-----

--juZjCTNxrMaZdGZC--
