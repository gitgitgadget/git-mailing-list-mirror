From: martin f krafft <madduck@madduck.net>
Subject: pushing changes to a remote branch
Date: Tue, 10 Jul 2007 16:36:14 +0200
Message-ID: <20070710143614.GA29681@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GpC-0006Fe-1U
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbXGJOgS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXGJOgS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:36:18 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:33922 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbXGJOgR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:36:17 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id DDC49895D73
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:36:15 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13151-02 for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 16:36:15 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id AAA55895D72
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:36:15 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id DA0839F121
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 16:36:14 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B1C1F43FC; Tue, 10 Jul 2007 16:36:14 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52081>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi list,

I am using git-remote to clone a remote repository and track only
a select number of branches:

  git remote add -f -t vim -t ssh origin git://git.server.org/path/to/repo.=
git
  git branch -r
    origin/ssh
    origin/vim
  git merge ...

I now merge these into the local repo and decide that I need to make
a change to origin/vim. So I figure that it's probably easiest if
I just checkout the remote branch, make the change, commit it, push
it, return to the master branch, git-remote update and merge, but:

  git checkout origin/vim
    Note: moving to "origin/vim" which isn't a local branch
  echo change > newfile; git add newfile
  git commit -m'make change'
    Created commit 64b8b2e: make change
     1 files changed, 1 insertions(+), 0 deletions(-)
      create mode 100644 newfile
 =20
If I now checkout master and then return to origin/vim, the commit
is gone.

If I repeat all this and, instead of returning to master, I push the
commit to origin, git suggests success (the push looks normal).
However, I then cannot find the commit anymore. It's not available
locally, nor in origin/vim, nor in the local master branch or in
origin/master.

This is curious and I'd love to find out what's going on.

Much more, however, I am interested how I am supposed to push
commits back to select remote branches.

Using

  git push git://git.server.org/path/to/repo.git \
    7fbb0655:refs/heads/vim

does push commit 7fbb0655 to the vim branch in the remote
repository, but I should be able to do this using origin/vim, no?
How?

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"the worst part of being old is remembering when you was young."
                                -- alvin straight (the straight story)

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGk5leIgvIgzMMSnURAiNpAJ4m2wyeH0xP2cc6mj2lIgK3RwxwoACgsQkp
IIBgnARlGSNXqHxMXNZERlo=
=v6GJ
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
