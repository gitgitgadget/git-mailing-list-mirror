From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 15:00:57 +0100
Message-ID: <20100121140057.GP12429@genesis.frugalware.org>
References: <hj7abm$5vc$1@ger.gmane.org>
 <7vocko3802.fsf@alter.siamese.dyndns.org>
 <4B577C3F.7040608@brooklynpenguin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 15:01:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXxb7-0002RJ-3w
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 15:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0AUOBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 09:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428Ab0AUOBF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 09:01:05 -0500
Received: from virgo.iok.hu ([212.40.97.103]:36619 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753072Ab0AUOBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 09:01:01 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 823CF58046;
	Thu, 21 Jan 2010 15:00:59 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3DE0544965;
	Thu, 21 Jan 2010 15:00:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 15A901240002; Thu, 21 Jan 2010 15:00:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B577C3F.7040608@brooklynpenguin.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137657>


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2010 at 04:57:19PM -0500, Tim Olsen <tim@brooklynpenguin.co=
m> wrote:
> It appears that a segfault still happens with your patch applied, but
> this time it is caught:
>=20
> tolsen@neurofunk:~/git/site-build-dav-sync-05 [git:build-dav-sync-05]$
> git merge origin/deployed
> error: merge-recursive died of signal 11
> Merge with strategy recursive failed.
> tolsen@neurofunk:~/git/site-build-dav-sync-05 [git:build-dav-sync-05]$
>=20
>=20
> > "common =3D NULL" means merged_common_ancestors->tree is NULL in the ca=
ller.
> > Somebody is passing a bogus commit in "ca" (aka common ancestors) list
> > when calling merge_recursive(), or forgetting to parse them before call=
ing
> > it.  In your debugger could you find out where it comes from and what it
> > has before this call into merge_trees() is made?  Specifically, what the
> > "ca" list at 0x7b3c00 contains, and how "merged_common_ancestors" at
> > 0x121e360 looks like. in this trace we see below:
>=20
> Here is the replay of the flow of execution from the first time we enter
> merge_recursive().  The repository has been modified slightly so the
> pointers are different this time but the segfault is still happening
> (I'll stop modifying the repository now ;-) .

Two ideas to help debugging:

- Can you try if this happens in a new repo as well? (If not, is the
  repo public?) If yes, can you write a script that shows your problem?
- Can you see if this happens with v1.6.0? If yes, can you bisect it?

Thanks.

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktYXhkACgkQe81tAgORUJYWLgCbBMNbIABftISKUminFpzNWaXz
tfkAn003koCMy+yRbn5nv9whkA73+78r
=g5dq
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--
