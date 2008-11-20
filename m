From: martin f krafft <madduck@debian.org>
Subject: Re: [TopGit PATCH] Use the topological order when exporting
	explicitly listed branches.
Date: Thu, 20 Nov 2008 11:54:32 +0100
Organization: The Debian project
Message-ID: <20081120105432.GB21374@piper.oerlikon.madduck.net>
References: <1227173902-21180-1-git-send-email-madduck@debian.org> <20081120102005.GB10491@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Cc: git@vger.kernel.org, Niko Tyni <506284-submitter@bugs.debian.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 20 11:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L37Cg-0003Pn-Go
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 11:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbYKTKyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 05:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYKTKyq
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 05:54:46 -0500
Received: from clegg.madduck.net ([193.242.105.96]:55157 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbYKTKyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 05:54:45 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 91F5E1D40A9;
	Thu, 20 Nov 2008 11:54:34 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 8D8279F34F;
	Thu, 20 Nov 2008 11:54:32 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1D04545F4; Thu, 20 Nov 2008 11:54:32 +0100 (CET)
Mail-Followup-To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Niko Tyni <506284-submitter@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20081120102005.GB10491@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101403>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.11.20.1120 +0100]:
> The point of -b is to export only the specified branches, assuming you
> already exported the dependencies before. If you just want to export a
> branch with all its dependencies, why not just switch to it and call
> plain tg export?

Ah, I see. I think then I probably failed to communicate what I had
in mind with -b, which was mainly to avoid use of a temporary
branch where to collapse all commits before creating a series.

I don't see the point of being able to export patches into a quilt
series without their dependencies. If needed, one could use tg-patch
for that. The only difference between tg-export -b and tg-patch is
that the former can do multiple patches in one go, and it writes
a series file. Since that series is not guaranteed to be applicable,
I think one could just not bother.

Thinking about it a bit more, I think tg-export should be modified
such that it can always take -b/--branches, which defaults to the
current branch. No matter what the driver, it always prepends the
dependencies to the list. Then, the list is passed to the export
driver. 'collapse' creates a branch as it does right now, and
'quilt' creates a series as it does right now.

I have most of this implemented in a branch which I'll gladly
publish as soon as I figured out some remaining corner cases.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"zum christentum wird man nicht geboren,
 man mu=DF dazu nur krank genug sein."
                                                 - friedrich nietzsche

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkklQeEACgkQIgvIgzMMSnVq0gCgsyHuZVmYRhFhdD0Gl1dUpngj
aZ4Ani7MvGYulxL+jmnh/+7zkIVhd+J9
=cTul
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
