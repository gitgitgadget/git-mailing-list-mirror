From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into
 modules
Date: Tue, 23 Aug 2011 22:35:35 +0200
Message-ID: <1314131735.3120.3.camel@kheops>
References: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Wusn5pG37YiOTaFtJZaO"
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	"Alejandro R. Sedeno" <asedeno@mit.edu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvxhK-0000Az-Cv
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab1HWUfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 16:35:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57480 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab1HWUfl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 16:35:41 -0400
Received: by fxh19 with SMTP id 19so521016fxh.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 13:35:40 -0700 (PDT)
Received: by 10.223.57.12 with SMTP id a12mr6001222fah.97.1314131739851;
        Tue, 23 Aug 2011 13:35:39 -0700 (PDT)
Received: from [192.168.0.7] ([85.69.155.32])
        by mx.google.com with ESMTPS id l22sm260114fam.13.2011.08.23.13.35.37
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 13:35:38 -0700 (PDT)
In-Reply-To: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179969>


--=-Wusn5pG37YiOTaFtJZaO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just wanted to know what is the current status of splitting gitweb
sources into modules.

Regards.

On Tue, 2011-05-03 at 16:04 +0200, Jakub Narebski wrote:
> Gitweb is currently next to largest file (after gitk) in git sources,
> more than 225KB with more than 7,000 lines.  Therefore adding any
> large feature that would require large amount of code added, like
> gitweb caching by J.H. and my rewrite of it, or "gitweb admin/write"
> [failed] GSoC 2010 project by Pavan Kumar Sunkara, would require for
> new code to be added as a separate module.  Otherwise gitweb would
> fast become unmaintainable.
>=20
> Note that there is already patch series sent which as one of side
> effects splits the JavaScript side of gitweb into many smaller
> self-contained files:
>=20
>   [PATCH 03/13] gitweb: Split JavaScript for maintability, combining on b=
uild
>   http://thread.gmane.org/gmane.comp.version-control.git/172384/focus=3D1=
72385
>=20
> Not in all cases splitting gitweb upfront would be required.  At least
> in the case of gitweb caching it doesn't.  What must be done however
> is preparing the infrastructure for modular gitweb sources; to
> properly test such infrastructure we need at least one split gitweb
> module.  With patch series preparing for splitting or true splitting of
> gitweb sent upfront the future patch series that implements
> code-extensive feature (like e.g. output caching) would be smaller and
> easier to review.
>=20
>=20
> This series is intended to bring such infrastructure to gitweb, to
> prepare way for adding output caching to gitweb. Alternatively it can
> be thought as beginning of splitting gitweb into smaller submodules,
> for better maintainability.
>=20
> This patch series was sent to git mailing list as
>=20
>   [PATCH 0/2] gitweb: Begin splitting gitweb
>   http://thread.gmane.org/gmane.comp.version-control.git/165824
>=20
> In the above mentioned first version of this series, the first patch
> that prepared the way for splitting gitweb was in three versions: A, B
> and C.  In this second version of this series the first patch in
> series most closely resembles version C in v1 series.
>=20
> In this version gitweb uses _both_ 'use lib __DIR__."/lib";' and
> 'use lib "++GITWEBLIBDIR++";', in correct order (as compared to
> version C of v1 series), so that __DIR__."/lib" is checked first,
> i.e. modules installed alongside gitweb.cgi win.
>=20
> Pull request:
> ~~~~~~~~~~~~~
> This series is available in the git repository at:
>   git://repo.or.cz/git/jnareb-git.git gitweb/split
>   git://github.com/jnareb/git.git gitweb/split
>=20
> Well, those patches has a few minor cosmetic fixups...
>=20
> Table of contents:
> ~~~~~~~~~~~~~~~~~~
> * [PATCHv2 1/2] gitweb: Prepare for splitting gitweb
>   [PATCHv2 2/2] gitweb: Create Gitweb::Util module
>=20
>   First patch implements infrastructure, second proof of concept patch us=
es
>   this infrastructure, testing it ("make -C gitweb test-installed").
>=20
> Shortlog:
> ~~~~~~~~~
> Jakub Narebski (1):
>   gitweb: Prepare for splitting gitweb
>=20
> Pavan Kumar Sunkara (1):
>   gitweb: Create Gitweb::Util module
>=20
> Diffstat:
> ~~~~~~~~~
>  gitweb/INSTALL            |    7 ++
>  gitweb/Makefile           |   23 ++++++-
>  gitweb/gitweb.perl        |  151 ++++-----------------------------------
>  gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 219 insertions(+), 139 deletions(-)
>  create mode 100755 gitweb/lib/Gitweb/Util.pm
>=20

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-Wusn5pG37YiOTaFtJZaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOVA8MAAoJECLlHVUnhaoWqy4IAIjrXrqR89A/jd0PKMSi0C7w
/gbt4eknv+th1ag4VqXCQG69unrl3UUT8g55E0+W4h05QRejBRAdjaf2YnlVWk+k
cItGpfgB74tkQg0i4xauY5tI7wEDKBK6VRbbWpZVJUjO2HJYRAnNxO65ZnKZt6ha
Su/u8pc4kA+uq5opsaIEYN9TbamGbS4oQ7cEHiTULN1Y1liQhRGv+Yepy5eYWLSJ
W6v486lOoGpItRXTc85VpnRAnSCKm7PMJ/L9gHt4YSYfyhjpqifR5TcqpBvzK+AY
e/KLLy5yTa28PUO6k2GYs8HCbn+EGTv8VaLDwXLUJrjIho3s3wJD8sj9sn+/Cfg=
=blAx
-----END PGP SIGNATURE-----

--=-Wusn5pG37YiOTaFtJZaO--
