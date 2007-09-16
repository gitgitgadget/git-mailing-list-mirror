From: martin f krafft <madduck@madduck.net>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 08:14:11 +0200
Message-ID: <20070916061411.GC24124@piper.oerlikon.madduck.net>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 08:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWnOx-0005lh-Ef
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 08:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbXIPGOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbXIPGOg
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 02:14:36 -0400
Received: from clegg.madduck.net ([82.197.162.59]:47723 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXIPGOf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 02:14:35 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 2178EBA3DD;
	Sun, 16 Sep 2007 08:14:12 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 0A8929F161;
	Sun, 16 Sep 2007 08:14:12 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id CE428B3106; Sun, 16 Sep 2007 08:14:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709152310380.28586@racer.site>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4288/Sun Sep 16 07:22:35 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58297>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.16.00=
14 +0200]:
> While at it, you should invent a fallback what to do when the
> owner is not present on the system you check out on.  And
> a fallback when checking out on a filesystem that does not support
> owners.

Like rsync, git would use numerical UIDs (which are always present)
by default, but could be told to try to map account names.

If the filesystem does not support owners, chown() would not exist.
I actually tend to think of things the other way around: instead of
a fallback when chown() does not work (what would such a fallback be
other than not chown()ing?), it would only try chown() if such
functionality existed.

> And a fallback when a non-root user uses it.

That's easy, Unix already provides you with that "fallback": pack up
/etc in a tar and unpack it as a normal user...

> Oh, and while you're at it (you said that it would be nice not to
> restrict git in any way: "it is a content tracker") support the
> Windows style "Group-or-User-or-something:[FRW]" ACLs.

Provided we find a way to implement this in an extensible manner,
this should not be hard to do. I can't do it since I don't have
access to a Windows machine.

Your statement does catch me off-guard though. Does git now
officially target Windows?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
if you find a spelling mistake in the above, you get to keep it.
=20
spamtraps: madduck.bogus@madduck.net

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7MmzIgvIgzMMSnURAsg6AKCkwDMh8Q2hXirIE0CpAZtCLpYHCwCfY491
PeMr6cNHsbzAY03YEMbl7fg=
=E9og
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
