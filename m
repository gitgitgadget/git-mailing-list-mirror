From: martin f krafft <madduck@madduck.net>
Subject: git submodule init and redundant data in .gitmodules/.git/config
Date: Wed, 15 Aug 2007 18:20:05 +0200
Message-ID: <20070815162005.GA18463@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 18:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILLbX-0006R7-R5
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 18:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759121AbXHOQUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 12:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbXHOQUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 12:20:16 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:54702 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759188AbXHOQUO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 12:20:14 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id B9DC4895D90
	for <git@vger.kernel.org>; Wed, 15 Aug 2007 18:20:06 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16701-10 for <git@vger.kernel.org>;
	Wed, 15 Aug 2007 18:20:06 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 87422895D8A
	for <git@vger.kernel.org>; Wed, 15 Aug 2007 18:20:06 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C6FCB9F171
	for <git@vger.kernel.org>; Wed, 15 Aug 2007 18:20:05 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 9B86E43F9; Wed, 15 Aug 2007 18:20:05 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55918>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am starting to learn submodules and hit the first state of
confusion when I encountered git-submodule init:

After git-submodule add, I find in my repository a .gitmodules file
as well as the newly-cloned submodule. I can call git-submodule
status on it to get the HEAD hash. The .gitmodules file has a stanza
for each submodule, linking remote url to local path, e.g.:

  [submodule "foo"]
    path =3D foo
    url =3D ../foo.git

The manpage then talks about git-submodule init:

    init
      Initialize the submodules, i.e. register in .git/config each
      submodule name and url found in .gitmodules. The key used in
      .git/config is submodule.$name.url. This command does not
      alter existing information in .git/config.

When I run git-submodule init, the following stanza gets added to
=2Egit/config:

  [submodule "foo"]
    url =3D ../foo.git

Unless I call init, I cannot use git-submodule update.

But looking at the two stanzas, it strikes me that the remote url of
the submodule is duplicated and detached, creating redundant data
which may become desynchronised.

Why is this?

What is the reason for git-submodule init and moving the data to
=2Egit/config?

Thanks,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"it is only the modern that ever becomes old-fashioned."=20
                                                        -- oscar wilde
=20
spamtraps: madduck.bogus@madduck.net

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGwye1IgvIgzMMSnURAkhXAKDTtuLKBLYbfdCYKKvmCja6LMgKggCfSk08
QX0BhO94YrRcBTYs6zYSySM=
=iRQk
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
