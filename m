From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 11:42:48 -0200
Message-ID: <20060216134248.GC4271@duckman.conectiva>
References: <20060216073826.GA12055@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 14:37:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9jJl-0003uc-Qb
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 14:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWBPNhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 08:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWBPNhG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 08:37:06 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:6883 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161099AbWBPNhE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 08:37:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by perninha.conectiva.com.br (Postfix) with ESMTP id 73E0136D72;
	Thu, 16 Feb 2006 11:37:03 -0200 (BRST)
Received: from perninha.conectiva.com.br ([127.0.0.1])
 by localhost (perninha.conectiva.com.br [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25523-02; Thu, 16 Feb 2006 11:37:02 -0200 (BRST)
Received: from duckman.conectiva.com.br (duckman.conectiva [10.0.2.193])
	by perninha.conectiva.com.br (Postfix) with ESMTP id ED26E36D71;
	Thu, 16 Feb 2006 11:37:01 -0200 (BRST)
Received: by duckman.conectiva.com.br (Postfix, from userid 500)
	id 644D03FB7; Thu, 16 Feb 2006 11:42:49 -0200 (BRST)
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20060216073826.GA12055@hand.yhbt.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new at conectiva.com.br
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16300>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2006 at 11:38:26PM -0800, Eric Wong wrote:
> Hello, I've written a simple tool for interoperating between git and
> svn.  I wrote this so I could use git to work on projects where other
> developers use Subversion.  I really hate using svn, but some projects I
> work on require it, and svk isn't nearly as fast nor simple as git.

Great, I was doing some testing with git-svnimport for this, but I missed
a tool to automatically commit to svn what I have in my GIT tree.

>=20
> git-svn does not replace git-svnimport, git-svnimport handles branches
> and tags automatically, but is too inflexible about repository layouts
> to be useful for a good number of projects I follow, and of course
> git-svnimport can't commit to Subversion repositories :)

I am already using git-svnimport to keep a "mirror" of some subversion
repositories, here (automatically udpated on crontab). Do you plan to
allow "integration" with repositories that are just clones of
git-svnimport'ed repositories?

I plan to keep using git-svnimport and the standard git tools to work
using the "svn mirror on git" as the main repository, but I plan to use
"git-svn commit" to commit to the SVN repositories. I want this "commit
tool" to not affect the current repository in any way, just like git-push:
only send the commits to the remote repository and don't change anything
in the local repository.

However, it seems that "git-svn commit" does some tasks assuming we
are on a "git-svn aware" repository (e.g. the "resyncing" just after
the commit). Would you accept patches to allow using "git-svn commit"
to commit changes from any GIT repository (i.e. not "svn-git aware"
repositories) to any SVN repository, just like "git-push" would work
for a GIT repository?

However, I am not sure if the easier way would be changing git-svn to
do this for me or writing a different script just for this task.

>=20
> git-svn only cares about a single branch/trunk in SVN[1], but you can
> use as many branches in git as you want.  This makes it much easier to
> use and allows it to handle just about any repository layout, not just
> those recommended in the SVN book/developers.
>=20
> Although importing changesets from SVN is mostly a linear affair,
> committing to SVN is the opposite.  You may commit git tree objects in
> any order you want.  It simply clobbers the existing svn tree as
> 'git-checkout -f' would, but tags file renames/copies carefully so users
> on the SVN side can see them.  You can even do some wacky things with
> patch reordering.

Good, this is what I expect to be able to do when commiting to svn.

--=20
Eduardo

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9IFYcaRJ66w1lWgRAv+9AJ4+MAYpcPiOoU1YX1om8TVHx+A3iwCeIa2S
TZfC+0gvl4i6CrAWZQzU/pg=
=gXwk
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
