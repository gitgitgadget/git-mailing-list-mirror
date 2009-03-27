From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How to merge by subtree while preserving history?
Date: Fri, 27 Mar 2009 08:38:47 +0100
Message-ID: <20090327073847.GE27459@genesis.frugalware.org>
References: <A5C2B218-4E4F-4C05-959D-5B6E9C619DDB@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vR/vnstCraLpx+OT"
Cc: git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 08:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln6fv-0002uv-8s
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 08:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbZC0Hiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 03:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbZC0Hix
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 03:38:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:50260 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbZC0Hiw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 03:38:52 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D4285581C4;
	Fri, 27 Mar 2009 08:38:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C0CCA44783;
	Fri, 27 Mar 2009 08:38:46 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1F420153C002; Fri, 27 Mar 2009 08:38:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <A5C2B218-4E4F-4C05-959D-5B6E9C619DDB@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114867>


--vR/vnstCraLpx+OT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2009 at 06:59:51PM -0400, David Reitter <david.reitter@gmai=
l.com> wrote:
> I have two separately developed projects (foo, bar) which I'd like to =20
> merge; the contents of foo should, initially, go in a subdirectory of =20
> bar.
>=20
> I'm aware of two methods:  moving (renaming) everything within foo =20
> into foo-dir, and then just pulling foo into bar.

The result of the two methods are the same.

> This works beautifully, except that the big rename causes havoc w.r.t. =
=20
> to the files histories, i.e. git-log needs a "--follow" argument now, =20
> and "diff-tree" can't track changes when given the new file name.  No =20
> good.
>=20
> I've also tried the method described in [1], but it seems that all =20
> history is lost here (the text could point this out..)

Of course it is not lost. :)

Example:

commit f8c62880ef22b74ea6df47bb349ff0743d2a93f9
Merge: f474c52... 52b8ea9...
Author: Junio C Hamano <gitster@pobox.com>
Date:   Sun Mar 1 22:20:52 2009 -0800

    Merge git://git.kernel.org/pub/scm/gitk/gitk

Now do a 'git log f474c52..52b8ea9' and you'll see the merged commits.

But you are right about that 'git log -- path' will find the merge
commits only (which is right, as the tree objects are not modified when
merging, just the resulting tree has the original tree in a
subdirectory).

If this is a one-time operation then I would just use git filter-branch
to move the code to a subdir.

--vR/vnstCraLpx+OT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknMgocACgkQe81tAgORUJYf5gCfSoVCb7CcnjKmF0qefbn5iMPw
ytEAnR6aQxzgfDur0ezBdf1W7k/nyy/S
=Wmkg
-----END PGP SIGNATURE-----

--vR/vnstCraLpx+OT--
