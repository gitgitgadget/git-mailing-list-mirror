From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [rfc] git submodules howto
Date: Tue, 18 Sep 2007 12:55:38 +0200
Message-ID: <20070918105538.GL19019@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 12:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXak9-0004Uy-Em
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbXIRKzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbXIRKzp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:55:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40016 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbXIRKzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:55:44 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXak2-0001xN-Rw
	from <vmiklos@frugalware.org>
	for <git@vger.kernel.org>; Tue, 18 Sep 2007 12:55:42 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 502931678012; Tue, 18 Sep 2007 12:55:37 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58576>


--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

i saw several "is there any step by step howto on how to use git
submodules?" question on irc, and as far as i think there is none
available at the moment

here is how i use it at the moment:

$ mkdir lib
$ cd lib
$ git init
Initialized empty Git repository in .git/
$ echo "libmakefile" > Makefile
$ dg add Makefile
$ git commit -m "libmakefile"
Created initial commit 57c1dce: libmakefile
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
$ cd ..
$ mkdir main
$ cd main
$ git init
Initialized empty Git repository in .git/
$ echo "main makefile" > Makefile
$ git add Makefile
$ git commit -m "main makefile"
Created initial commit 8935291: main makefile
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 Makefile
$ git submodule add ../lib lib
Initialized empty Git repository in /home/vmiklos/scm/git/sub/main/lib/.git/
0 blocks
$ git commit -m "added lib submodule"
Created commit 9dbfedf: added lib submodule
 2 files changed, 4 insertions(+), 0 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 lib
$ cd ..
$ git clone main cloned
Initialized empty Git repository in /home/vmiklos/scm/git/sub/cloned/.git/
0 blocks
$ cd cloned
$ git submodule init
Submodule 'lib' (/home/vmiklos/scm/git/sub/lib/.git) registered for path 'lib'
$ git submodule update
Initialized empty Git repository in /home/vmiklos/scm/git/sub/cloned/lib/.git/
0 blocks
Submodule path 'lib': checked out '57c1dce0e083e9ee50d06111d6aa1523116c2e15'
$ cat Makefile
main makefile
$ cat lib/Makefile
libmakefile

my questions:

1) is this correct? :) i use it and it seem to do what i except, but
maybe it's not correct

2) does this worth adding to the documentation? maybe to a .txt under
Documentation/howto? or to git-submodule.txt?

thanks,
- VMiklos

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG766qe81tAgORUJYRAhHZAJ9otaAajJjAj9BAW2e1t2VmmoWu5gCfUfs5
ZXiG3Wqy4uoWgy38HS/h/JM=
=jjE1
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
