From: martin f krafft <madduck@madduck.net>
Subject: git-push [--all] and tags
Date: Sat, 6 Oct 2007 17:05:06 +0100
Message-ID: <20071006160506.GA28238@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 06 18:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeCA1-00015O-Vo
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 18:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762590AbXJFQFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 12:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761633AbXJFQFN
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 12:05:13 -0400
Received: from clegg.madduck.net ([82.197.162.59]:32776 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761288AbXJFQFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 12:05:11 -0400
Received: from lapse.madduck.net (absinthe.ifi.unizh.ch [130.60.75.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id B4882BEAB
	for <git@vger.kernel.org>; Sat,  6 Oct 2007 18:05:06 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 426BC3FEFB; Sat,  6 Oct 2007 17:05:05 +0100 (BST)
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4482/Sat Oct  6 00:43:49 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60148>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello people,

`git-push --all --tags` does not work because git-push ends up
calling git-send-pack --all refs/tags/*, which the latter does not
deal with.

Looking at the code, it seems that previously, --all would push
everything, not just refs/heads/*. What's the reason that this was
changed? Why aren't tags considered part of --all?

If I wanted to fix this, so that --all pushes heads and --all --tags
pushes heads and tags, I could do so in two ways:

  1. instead of --all, pass refs/heads/* to git-send-pack
  2. add --tags to git-send-pack

which of these two would you prefer and why?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"imagine if every thursday your shoes exploded if you
 tied them the usual way. this happens to us all the time
 with computers, and nobody thinks of complaining."
                                                        -- jeff raskin
=20
spamtraps: madduck.bogus@madduck.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHB7IyIgvIgzMMSnURAluCAKCCf7iS/449DNvyFYHHq+fMSNJx5ACgvLAa
miYjRBXHQDlZx1QuYBq5qvM=
=ycu0
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
