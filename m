From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Tracking the untracked
Date: Wed, 6 May 2009 15:22:49 +0200
Message-ID: <200905061522.56981.trast@student.ethz.ch>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1650198.JvAZz1ZEX5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 15:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1h6M-0006nO-B2
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 15:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210AbZEFNXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 09:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbZEFNXs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 09:23:48 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:18837 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbZEFNXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 09:23:48 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 15:23:46 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 May 2009 15:23:46 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
X-OriginalArrivalTime: 06 May 2009 13:23:46.0708 (UTC) FILETIME=[E2A5A540:01C9CE4D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118339>

--nextPart1650198.JvAZz1ZEX5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Geoff Russell wrote:
> Bug or feature? I don't know.

=46eature.

> On the master branch I have some untracked files e.g., object modules,
> executables.
>=20
> I create a branch B1 and add+commit the untracked files.
>=20
> When I switch back to the master (git checkout master), the untracked
> files are no longer where I left them.
[...]
> One solution would be to have a class of files that is "unversioned
> but tracked".

Note that "versioned" and "tracked" mean the same thing in Git --
both denote the class of files it cares about.

Your build products became tracked (w.r.t. the then-state of the
repository, on branch B1) the second you added them to the index with
'git add'.  Git then cares about them, and among many other things
will look at them whenever you change branches.  Since they're not
present in the target branch 'master', they are removed from the work
tree.

> Basically, I'm trying to find a way of having a huge bunch of stuff in
> my repository and
> tracked, but which doesn't get pushed to the central program repository .=
=2E which
> has always just been source for us .. I figured I could stick it on a
> branch which doesn't get pushed.
> But that doesn't work for the reason mentioned.

Most people just put their build products in .gitignore so that they
stop showing up under "untracked files" in 'git status'.  (They'll
still be untracked!)

Of course this means the object files for source that actually changed
between the branches have to be rebuilt.  However, Git takes great
care to not touch any source files that are the same, so that the
builds are usually quite fast even after a branch switch.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1650198.JvAZz1ZEX5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkoBjzAACgkQqUud07tmzP1XHgCeLk/xYLsxplzoUOTrAZZgSWRV
/GgAnj9oj8jkP8JjDaG/IACopHG/SQWU
=hLbv
-----END PGP SIGNATURE-----

--nextPart1650198.JvAZz1ZEX5--
