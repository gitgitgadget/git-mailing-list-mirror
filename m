From: Jan Hudec <bulb@ucw.cz>
Subject: Re: gitk doesn't start due to cygwin wish not following symlinks?
Date: Fri, 6 Jul 2007 11:33:55 +0200
Message-ID: <20070706093355.GD3991@efreet.light.src>
References: <fa0b6e200707031202g4a1248d8na22fbf99b215804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Cc: git@vger.kernel.org
To: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 11:34:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6kCR-0007zK-8g
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 11:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757822AbXGFJeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 05:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756590AbXGFJeA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 05:34:00 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:59479 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757326AbXGFJd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 05:33:59 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A3D3F57485;
	Fri,  6 Jul 2007 11:33:58 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 0xRO0ULwIXpa; Fri,  6 Jul 2007 11:33:56 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C6CCE57482;
	Fri,  6 Jul 2007 11:33:55 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I6kCJ-0006Xf-8G; Fri, 06 Jul 2007 11:33:55 +0200
Content-Disposition: inline
In-Reply-To: <fa0b6e200707031202g4a1248d8na22fbf99b215804@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51738>


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2007 at 21:02:35 +0200, Kees-Jan Dijkzeul wrote:
> Hi,
>
> I'm using "stow" to manage several versions of git on my cygwin
> system. As a result, my /usr/local/bin contains a bunch of symlinks to
> the actual binaries in /usr/local/stow/git-1.5.2.2/bin.
>
> This works like a charm, except that gitk won't start up, claiming, in
> turn, that it is unable to start git itself. After some investigation,
> I found that the "wish" that is supplied with cygwin isn't a true
> cygwin one, and hence doesn't understand cygwin style simlinks, and
> thus cannot start the /usr/local/bin/git symlink. It needs the true
> binary.
>
> So for now, I've worked around this by updating the first few lines of
> the gitk script to read:
>
>   #!/bin/sh
>   # Tcl ignores the next line -*- tcl -*- \
>   export PATH=3D$PATH:/usr/local/stow/git-1.5.2.2/bin
>   # Tcl ignores the next line also \
>   exec wish "$0" -- "$@"
>
> This works for me, but is admittedly butt-ugly. Any tips on how to
> handle this kind of situation?

Ask cygwin folks to teach their wish their symlinks?

You could also try putting a git.bat somewhere in path, that would set the
path and run true git from /usr/local/stow/git-1.5.2.2/bin.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGjgyDRel1vVwhjGURAmjqAKC+aeNVHw5XyzK/WQvJfGglrR2A0ACguXmZ
/5DhZhv10mF1QmLJqjOsDi0=
=2nqg
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
