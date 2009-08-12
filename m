From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [msysGit] Re: Using VC build git
Date: Wed, 12 Aug 2009 09:13:13 +0200
Message-ID: <4A826B89.20108@storm-olsen.com>
References: <1976ea660908100656u57407131h83761329468607a8@mail.gmail.com> <alpine.DEB.1.00.0908101606220.8324@intel-tinevez-2-302> <alpine.DEB.1.00.0908101609170.8324@intel-tinevez-2-302> <1976ea660908101826q26faa37ao7920d5cf9d4f53fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0096746894E98E209A85ECB4"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb81d-0000Oh-9b
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944AbZHLHNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZHLHNT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:13:19 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:44646 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZHLHNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:13:18 -0400
Received: by ewy10 with SMTP id 10so4332014ewy.37
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 00:13:18 -0700 (PDT)
Received: by 10.211.195.15 with SMTP id x15mr2018186ebp.59.1250061198352;
        Wed, 12 Aug 2009 00:13:18 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm1940761eyg.35.2009.08.12.00.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 00:13:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Lightning/0.9 Thunderbird/2.0.0.22 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <1976ea660908101826q26faa37ao7920d5cf9d4f53fd@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125674>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0096746894E98E209A85ECB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

[Please do *not* do top-posting! Both git and msysgit mailing lists=20
use bottom-posting]

Frank Li said the following on 11.08.2009 03:26:
> Thank you take care my patch.
> I can fix all problems.

Good! Many people want to see git build with MSVC, if only to use a=20
compiler better at optimizing code on Windows. (And the debugger, of=20
course)


> This patch is base on v1.6.4 release.  My working branch is vc_build
> at git://repo.or.cz/tgit.git.

Ok. Dscho wondered why it wasn't a proper fork of the main git.git=20
repo, so it *should* really have been
     git://repo.or.cz/git/tgit.git
                      ^^^^ <-- Notice the fork relationship?

It would save some valuable space on the server, show relations, make=20
it easier to find, etc.


> That is actually prototype to approve VC can build git.
> The code style is not big problem. I will fix it.

You will experience that for the git community coding style is very=20
important (for good reason), so expect many rounds of rewriting your=20
patches, until they all shine like diamonds.

> VC build will reuse many msysgit works because msysgit really do many
> work at windows porting.

Sure, but I think it rarely will involve your patches changing the=20
code in MinGW at all. Try your outmost to keep your patches separated=20
from anything else. If in doubt, please ask us on the msysgit mailing=20
list, and we will guide you.


> I think the below is most important problem.
>=20
> 1.  Where are vcbuild directory put, is it okay under contrib ?
> 2.  How to handle external library, such as zlib? Can use submodule?

For point 2: If we cannot compile we don't accept it, is the basic=20
rule. This means that if you think the people building git with MSVC=20
cannot install some dependencies themselves, you need to provide the=20
full sources yourself, and make sure that the code compiles without=20
changes. So, in this case if would mean to include the sources for=20
zlib, and setup the vcproj to compile this code into the executable,=20
instead of linking with a precompiled lib.

In this case, however, I think you should rely on the developer=20
providing this library themselves, and not add it to the git project.=20
The zlib project is ~750KB of code itself..

--
=2Emarius


--------------enig0096746894E98E209A85ECB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFKgmuJKzzXl/njVP8RAmIdAJ42LS5g91v26AdUY0TXa5F6+1/dKwCglmpK
5AihKfPssAmw1NmuNGsI4ew=
=/rDI
-----END PGP SIGNATURE-----

--------------enig0096746894E98E209A85ECB4--
