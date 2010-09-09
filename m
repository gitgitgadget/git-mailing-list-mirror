From: martin f krafft <madduck@madduck.net>
Subject: Find the next tag on a given branch
Date: Thu, 9 Sep 2010 07:28:41 +0200
Message-ID: <20100909052841.GA16722@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 08:15:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtaQ1-0005l4-Do
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 08:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0IIGPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 02:15:17 -0400
Received: from clegg.madduck.net ([193.242.105.96]:52962 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab0IIGPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 02:15:15 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2010 02:15:15 EDT
Received: from fishbowl.rw.madduck.net (vpn-89-206-65-79.uzh.ch [89.206.65.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 070721D40F4
	for <git@vger.kernel.org>; Thu,  9 Sep 2010 08:06:11 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 6FAFD200F4; Thu,  9 Sep 2010 07:28:41 +0200 (CEST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.35-trunk-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155845>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I want to find the next tag (the tag following a commit), but
require that it lie on a given branch. Alternatively, a filter
pattern might work too.

My challenge is to answer the question:

  "Which is the first Debian release including a given commit"

The way Debian packages are (mostly) maintained in Git is that
there are at least an upstream and a Debian branch (usually
"master"). master branched off upstream, and upstream is merged into
master at regular intervals. Whenever a Debian release is made, the
corresponding branch is tagged.

If I run

  git describe --contains mycommitish

it prints the next tag, which is usually upstream's tag, which is
not quite what I want (it's usually enough for me to figure it out,
but this is Git and so I should be able to do even better! ;\) )

I would like to have it continue the search until it reaches the
master branch. For instance, a command like

  git describe --contains mycommit --on-branch master

would basically search into the future (breadth-first?) until it
landed on the specified branch, and then continue the normal search
routine (and find the commit on another branch actually, the
important point is that it only started to search for tags once it
reached the specified branch).

The alternative is

  git describe --contains mycommit --pattern=3D'debian/*'

which would keep searching for tags until it found a tag/ref-name
that matched the specified glob.

Is this already possible somehow? Am I simply looking at the wrong
tools?

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
i don't want to get myself into a hot babe situation.
                         -- jonathan mcdowll, #debian-uk, 6 jul 2009
=20
spamtraps: madduck.bogus@madduck.net

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkyIcIkACgkQIgvIgzMMSnXLRQCgk8pri8Gddkd0hdbNp8QKASV8
3VoAoKJCYCFTf2LWDqEinLwhqzKJCcEl
=zkct
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
