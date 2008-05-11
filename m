From: martin f krafft <madduck@madduck.net>
Subject: Re: git-svn: expand svn:keywords, or how else to deal with them?
Date: Sun, 11 May 2008 11:39:51 +0100
Message-ID: <20080511103951.GA30508@lapse.madduck.net>
References: <20080509101919.GA25037@lapse.madduck.net> <20080511084558.GC23929@untitled>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: Eric Wong <normalperson@yhbt.net>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 11 12:41:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv8zc-0005ZV-VX
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 12:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYEKKkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 06:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbYEKKkJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 06:40:09 -0400
Received: from clegg.madduck.net ([82.197.162.59]:36315 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbYEKKkH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 06:40:07 -0400
Received: from lapse.madduck.net (chiu.ifi.unizh.ch [130.60.75.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id D87D3A80AA;
	Sun, 11 May 2008 12:39:52 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 9E7794FD40; Sun, 11 May 2008 11:39:51 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <20080511084558.GC23929@untitled>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7085/Sun May 11 11:43:17 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81754>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2008.05.11.0945 +0100]:
> I'm mainly uncomfortable with how it'll interact with dcommit
> usage, but since your use case seems to be fetch-only; you may
> just disable dcommit if keyword expansion is enabled if it's too
> painful to figure out the unexpansion...

Unfortunately, it's not fetch-only, I have commit rights upstream
and I use them quite often.

I understand your reasoning and am not too keen on implementing this
hack either. However, the other ways of dealing with it are
horrific. Right now, for each release, I have to do:

  git checkout -b build-$VERSION
  # undo all changes, basically get pristine upstream
  zcat ../mypkg_1.0-1.diff.gz | git apply -R
  # reapply all my Debian changes
  git diff upstream debian | git apply
  git commit ...

this gets unmanageable when I am using more than just the debian
branch, but also feature branches, e.g. debian/fhs-compatibility
etc...

You wouldn't happen to have a better idea of how to deal with this?
:)

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
don't hate yourself in the morning -- sleep till noon.
=20
spamtraps: madduck.bogus@madduck.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIJsz3IgvIgzMMSnURAiMmAKDZvRTy8oQ2jWhszhj4CKkbiiiKKQCgiI40
7+646wkwghNBZuhhcONInhY=
=ojod
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
