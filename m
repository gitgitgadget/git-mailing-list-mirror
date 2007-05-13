From: Martin Eisenhardt <list-receive@mneisen.org>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Sun, 13 May 2007 19:49:34 +0200
Organization: mneisen.org
Message-ID: <200705131949.38051.list-receive@mneisen.org>
References: <vpq7irfengj.fsf@bauges.imag.fr> <20070513171707.GA14024@muzzle>
Reply-To: Martin Eisenhardt <martin.eisenhardt@mneisen.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2254443.8RMoQptcN9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, Matthieu.Moy@imag.fr
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 13 19:50:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnICz-0001DJ-7V
	for gcvg-git@gmane.org; Sun, 13 May 2007 19:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120AbXEMRtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 13:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758392AbXEMRtm
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 13:49:42 -0400
Received: from node-0.mneisen.org ([88.198.37.77]:60595 "EHLO mail.mneisen.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758347AbXEMRtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 13:49:41 -0400
Received: from dinoso.local (pD9E52E13.dip.t-dialin.net [217.229.46.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mneisen.org (Postfix) with ESMTP id AD9A9580A244D;
	Sun, 13 May 2007 19:49:39 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070513171707.GA14024@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47157>

--nextPart2254443.8RMoQptcN9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Eric,
hi Matthieu,
hi list,

On Sunday 13 May 2007 19:17:07 Eric Wong wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > I'm using git-svn, which usually works fine, but I occasionally get
> > this:
> >
> > $ git-svn dcommit
> >         A       file1
> >         A       file2
> > Network connection closed unexpectedly: Connection closed unexpectedly =
at
> > /path/to/git-svn line 401 $

I ran into that one, too ... :-(

> > The failure seems to depend on the commit's I'm pushing, since this is
> > reproducible when running several times "dcommit" for the same commit,
> > but the same command also usually works fine on the same repositories
> > (same git repo, same svn target).

I assume that the dcommit runs fine for *other* commits but not for that on=
e=20
that produced the error cited above.

In my case, it was simply a problem on my side: I had tried to add a file,=
=20
that already existed in the repository - and subversion rejected the commit=
=2E=20
Of course, it would be nice if git-svn could simply tell the user about his=
=20
error, i.e., simply copy the output of libsvn or whatever it is using to=20
connect to the subversion repo.

Another case where I stumbled upon said error message was when I added an=20
empty (sub)directory to a project in subversion and then used git to track=
=20
that project. Since git cannot track an empty directory, it did not appear =
in=20
my git working copy. When I mkdir'd the directory locally (in my git wc) an=
d=20
then tried to add files within that repository, I got exactly the same erro=
r=20
as Matthieu.

>
> Does the patch in
>   http://permalink.gmane.org/gmane.comp.version-control.git/47126
> help?

Not in my case, although this patch resolved the other issue, thanks again=
=20
btw!

Kind regards
Martin Eisenhardt

--nextPart2254443.8RMoQptcN9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGR0+yMNkO5Mfxwc8RAhGxAKCjsmblsr/omVVukkhUDQlMggBrtgCgh4L2
+/1xQ4hl772hGwXwiLAt1dU=
=aOZd
-----END PGP SIGNATURE-----

--nextPart2254443.8RMoQptcN9--
