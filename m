From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 16:58:40 +0200
Message-ID: <200807111658.40626.toralf.foerster@gmx.de>
References: <200807102057.15063.toralf.foerster@gmx.de> <200807111539.06606.toralf.foerster@gmx.de> <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1471996.cj8k3yTmsA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:59:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHK62-0007iP-8j
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbYGKO6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 10:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbYGKO6o
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:58:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:60333 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752260AbYGKO6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 10:58:43 -0400
Received: (qmail invoked by alias); 11 Jul 2008 14:58:42 -0000
Received: from d036167.adsl.hansenet.de (EHLO d036167.adsl.hansenet.de) [80.171.36.167]
  by mail.gmx.net (mp055) with SMTP; 11 Jul 2008 16:58:42 +0200
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX18YV5Mt6fAYz2QIGPUt8NxKC2j9mcm/DxFPCeyElg
	S6dR7jNuWis5CH
User-Agent: KMail/1.9.9
In-Reply-To: <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88126>

--nextPart1471996.cj8k3yTmsA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

At Friday 11 July 2008 16:44:23 Dmitry Potapov wrote :
> On Fri, Jul 11, 2008 at 5:39 PM, Toralf F=F6rster <toralf.foerster@gmx.de=
> wrote:
> >
> > Ok, following the thread I understand why this feature isn't wanted by =
all. But
> > for the given example (where I only pulled from another git tree) this =
could
> > work, isn't it : ?
> >
> > tfoerste@n22 ~/devel/linux-2.6 $ git-log v2.6.26-rc9.. | perl -e '@c =
=3D grep { /^commit/ } <>; print map { $#c - $i++ . "\t" . $_ } @c'
>=20
> No, it does not. Running your script, I have
>=20
> ...
> 56      commit 803a9067e19714ea7b7da760fe92f0d53bfa6994
> ...
>=20
> Now, let's see what git-describe thinks about it
> $ git describe 803a9067e19714ea7b7da760fe92f0d53bfa6994
> v2.6.26-rc9-38-g803a906
>=20
> Your script is obviously incorrect. It is written in the assumption that
> history is linear, but it is not. Even if you pull only from one repo,
> this repo still contains *many* branches. Along any branch, you may have
> the same number.
>=20
> Dmitry
>=20

Yes,

$> git-log v2.6.26-rc9.. --pretty=3Dshort | grep "^commit" | cut -f2 -d' ' =
| xargs -n 1 git describe | grep '\-56\-'

I used eventually to get the commit id for the (broken) UML kernel 2.6.26-r=
c9-56

=2D-=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

--nextPart1471996.cj8k3yTmsA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkh3dSAACgkQhyrlCH22naMivwCfW5yyLp1BhLabTdOfWMJWGWmN
d3wAoKfRUZmuHvcUuCk/vzfSWN+9croC
=re3i
-----END PGP SIGNATURE-----

--nextPart1471996.cj8k3yTmsA--
