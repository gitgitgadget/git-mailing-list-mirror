From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git reset --merge misdocumented?
Date: Sat, 31 Jan 2009 00:20:18 +0100
Message-ID: <200901310020.23851.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901290210540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2753141.iB9DpZJ8XD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT2gV-0001c6-Vu
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 00:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbZA3XU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756458AbZA3XU1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 18:20:27 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:28702 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756428AbZA3XU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 18:20:26 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 31 Jan 2009 00:20:24 +0100
Received: from thomas.localnet ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 31 Jan 2009 00:20:24 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901290210540.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 30 Jan 2009 23:20:24.0559 (UTC) FILETIME=[542C37F0:01C98331]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107885>

--nextPart2753141.iB9DpZJ8XD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> from the man page I thought that --merge would be just another way to say=
=20
> "git read-tree -u -m".

Isn't that idea from the commit message?  I can't find any mention of
read-tree in next's idea of the manpage.

> In particular, the man page says _nothing_ about resetting HEAD to=20
> something else.

It says

  --merge::
          Resets the index to match the tree recorded by the named commit,
          and updates the files that are different between the named commit
          and the current commit in the working tree.

so while the exact way of "updating" is not specified, it does mention
that you can move between commits, and that it will do something with
the difference across the move.

The example further down really cleared up the idea for me:

  Undo a merge or pull inside a dirty work tree::
  +
  ------------
  $ git pull                         <1>
  Auto-merging nitfol
  Merge made by recursive.
   nitfol                |   20 +++++----
   ...
  $ git reset --merge ORIG_HEAD      <2>
  ------------

I've never used 'read-tree -u -m' except in voodoo scripting, but I'd
have done the same with 'git stash && git reset --hard ORIG_HEAD &&
git stash pop' before.  The original commit message even mentions this
equivalence.

So I'm not sure what exactly needs changing there?

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2753141.iB9DpZJ8XD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmDizcACgkQqUud07tmzP2L8wCfU4bAiNq0+r862zdJIyhvI+/a
hMkAoJ+NBnWhikQygVTqP+Niab701jEk
=Q2b6
-----END PGP SIGNATURE-----

--nextPart2753141.iB9DpZJ8XD--
