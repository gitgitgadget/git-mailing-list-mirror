From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subproject status
Date: Mon, 26 Mar 2007 11:39:06 +0200
Message-ID: <20070326093906.GF22773@admingilde.org>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 11:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVlfV-0007ze-PR
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 11:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbXCZJjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 05:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbXCZJjK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 05:39:10 -0400
Received: from mail.admingilde.org ([213.95.32.147]:58322 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbXCZJjI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 05:39:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HVlfP-0004Ud-18; Mon, 26 Mar 2007 11:39:07 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703251304280.6485@iabervon.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43138>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Mar 25, 2007 at 01:37:25PM -0400, Daniel Barkalow wrote:
> I remember that last time I checked, there were a number of designs for=
=20
> subprojects and at least a couple of implementations, but none that was=
=20
> complete to the point of being mergeable. Are there any subproject=20
> implementations available that haven't run into unsolveable problems? I'm=
=20
> presently only looking at stuff that totals to a reasonable single projec=
t=20
> size and rate of growth, so I'm not worried about the large-scale storage=
=20
> requirement issue.

You can try to play with my prototype:
git.admingilde.org/tali/git.git, branch module2
(to get an example of how to use it, look at the test script in
t/t7500-submodule.sh).

The core operations should work, but not all the user interface is
adapted to support submodules.  E.g. git-status will not show if a
submodule has dirty changes, it will only show submodule changes which
are already commited to the submodule but not yet to the supermodule.
But at least simple merges do work with submodules.

I abondoned this branch (no further work, only occasionally pulling in
updates from upstream git.git) as it has scalability problems with
large projects.
At the moment I'm working on the module3 branch, which tries to address
the scalability problem by separating the object store.  This is still
in the phase of early prototyping, just to see if it can work.
But I am already at the point that I am confident to be able to finish
it this way.

The objects created by the module2 and module3 branches are the same,
module3 only moves those belonging to the submodule to another location.
So If you start using module2 branch now you should be able to upgrade
later.  But to be extra sure, we should have some discussion about the
object format here.  (There is nothing new here, really: Just one more
tree entry file mode which says that this is not a file or directory
entry, but a submodule, represented by one commit.)

--=20
Martin Waitz

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGB5S6j/Eaxd/oD7IRAiJNAJ4nYoI7l+nebaSGYQpNUbdxQmwlOACdGd6G
HxBlFs9lMlZKWPkvw37wStY=
=LlDk
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
