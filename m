From: martin f krafft <madduck@madduck.net>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 12:08:17 +0100
Message-ID: <20070924110817.GA15797@lapse.madduck.net>
References: <1190585633.29937.44.camel@localhost> <7v4phlc668.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Cc: Hanspeter Kunz <hp@edelkunz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 13:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZlmn-0003kM-OX
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 13:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbXIXLH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 07:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753935AbXIXLH1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 07:07:27 -0400
Received: from clegg.madduck.net ([82.197.162.59]:60777 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbXIXLH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 07:07:26 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id C4895BF26;
	Mon, 24 Sep 2007 13:07:07 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 0B8B23FD5E; Mon, 24 Sep 2007 12:08:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v4phlc668.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4376/Mon Sep 24 04:15:24 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59038>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.09.24.0029 +0100]:
> Was the commit authored by yourself?

Sorry for barking in here, but Hanspeter tried to submit a patch to
me and that's when this issue arose.

Yes, he is the author of the commit, as in: user.name and user.email
are the same for the commit and for the email, and this seems to be
the reason the commit header is left out of the email, causing
git-am to use the RFC822 From header instead:

  - patch by Jane, email sent From Jane: no separate From header
  - patch by Jane, email sent From Joe: separate From Jane header=20

But information *does* get lost, namely the date. If I send a patch
by email and it gets merged by the recipient, the date of the commit
will be the date of the email, not the date of original commit, or
when it was merged.

To be honest, I have no real preference on this, but it just seems
strange that out of three dates:

  - original commit
  - email sent
  - commit merged

git-send-email/git-am cause the second to be used, which is the
one that makes the *least* sense IMHO.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"i dislike arguments of any kind. they are always vulgar, and often
 convincing."
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG95qhIgvIgzMMSnURAu0gAJ92fpTNT4KlRHXJ6YDiRxb0MiuEYACgisPX
ypA/ZiBk0q9JwTVdFX/IdWE=
=JTtL
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
