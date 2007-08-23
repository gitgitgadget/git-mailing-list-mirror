From: martin f krafft <madduck@madduck.net>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 08:23:42 +0200
Message-ID: <20070823062342.GA29172@piper.oerlikon.madduck.net>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> <7v8x83i5ma.fsf@gitster.siamese.dyndns.org> <20070823060052.GA25153@piper.oerlikon.madduck.net> <85mywiixtp.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Cc: Junio C Hamano <gitster@pobox.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>,
	David Kastrup <dak@gnu.org>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO675-0005k3-7P
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbXHWGXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXHWGXq
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:23:46 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:56411 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXHWGXp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 02:23:45 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id EE68A895F78;
	Thu, 23 Aug 2007 08:23:43 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15509-08; Thu, 23 Aug 2007 08:23:43 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 7B66E895F73;
	Thu, 23 Aug 2007 08:23:43 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id BDEC99F16A;
	Thu, 23 Aug 2007 08:23:42 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 81C4043F4; Thu, 23 Aug 2007 08:23:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85mywiixtp.fsf@lola.goethe.zz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56460>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach David Kastrup <dak@gnu.org> [2007.08.23.0812 +0200]:
> The modes are recorded in patches and push/pull, so if you have
> several people working with different permissions/umasks, you get
> wagonloads of unnecessary patches and get your local permissions
> messed up by other contributors.
>=20
> For colloborative work, you _really_ don't want to have _personal_
> preferences distributed.

How about a patch that

  (a) ensures that modes of existing files are preserved
      across checkouts and merges?
  (b) for files it creates (e.g. checkout of a branch introducing
      a file), it consults the default for this file tracked in the
      archive and uses that.
  (c) in order to change the mode recorded for a file, a user has to
      tell git-add to specifically record the mode change in the
      index.

There should be a tri-state policy: mode-from-archive vs. umask, and
umask could be according to core.umask or if that's set to user,
then the user's umask.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"the only difference between shakespeare and you
 was the size of his idiom list -- not the size of his vocabulary."
                                                      -- alan perlis
=20
spamtraps: madduck.bogus@madduck.net

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzSfuIgvIgzMMSnURAj8fAKDTCIjr5KEN+wPdsH15aq02/WIfQwCg4E37
qGqhySuS6IXUyHrH8JErlO4=
=6K7w
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
