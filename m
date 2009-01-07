From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git rebase orthodontics
Date: Wed, 7 Jan 2009 17:31:04 +0100
Message-ID: <200901071731.20343.trast@student.ethz.ch>
References: <87sknvxje8.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3988730.UvYqhVsf67";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Jan 07 17:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKbKc-0006Bp-Jm
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 17:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbZAGQbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 11:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbZAGQbI
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 11:31:08 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:58266 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbZAGQbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 11:31:07 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 17:31:04 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 7 Jan 2009 17:31:03 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <87sknvxje8.fsf@jidanni.org>
X-OriginalArrivalTime: 07 Jan 2009 16:31:03.0589 (UTC) FILETIME=[55315D50:01C970E5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104811>

--nextPart3988730.UvYqhVsf67
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jidanni@jidanni.org wrote:
> wherein he discovers there are no guard rails

Good thing you learned this before getting to git-reset.

> $ EDITOR=3Dcat git rebase --interactive master
> pick 07aef4a This is a commit with No files, wow. bla.
> # Rebase 3ad166e..07aef4a onto 3ad166e ...
> Successfully rebased and updated refs/heads/jidanni.
> (But it didn't. git show shows no change. ls -l shows
> refs/heads/jidanni was not touched.
> OK, it seems like all I am doing is changing
>               A jidanni
>              /
> D---E---F---G master
> into the same thing, a noop. But shouldn't it warn and quit, instead
> of rewarding me with the success message?

You asked for an interactive rebase of the range master..jidanni,
which consists of A, so it gave you an editor offering 'pick A' and
the chance to change that.

Non-interactive rebase indeed checks if you attempt to rebase, but are
already up to date.  Interactive doesn't; the assumption is that
interactive rebases aren't used "blindly" to update.  (Rebasing
changes committer and commit time, so there is a difference between
not rebasing at all, and merely ending up with the same history.)

> Let's try it the other way
> around:
> $ git checkout master
> $ git rebase --interactive jidanni #Wherein one sees:
> noop
> # Rebase 07aef4a..3ad166e onto 07aef4a
> Successfully rebased and updated refs/heads/master.
> OK, now I have achieved
> D---E---F---G---A master, jidanni
> Observations:
> When I tried a noop, it didn't say noop in the editor.
> When I tried a yesop, it did say noop in the editor.

The 'noop' means that there are no commits in the range you asked to
rebase, which is jidanni..master.  It's telling you that it is going
to update the branch pointer, but not carry over any of the commits.
This can happen even if jidanni..master is nonempty, but all commits
in it are already contained in jidanni.

> In both cases it gave the same success message.

It successfully did what you told it to do.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart3988730.UvYqhVsf67
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklk2NgACgkQqUud07tmzP2k5QCggZkdFqZsWULtpLJ6We09zj7x
E4kAnj0ua783dAztMgqoFA/PdLEt/KyH
=/pLD
-----END PGP SIGNATURE-----

--nextPart3988730.UvYqhVsf67--
