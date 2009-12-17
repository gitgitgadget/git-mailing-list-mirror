From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How do I show only log messages for commits on a specific
 branch?
Date: Thu, 17 Dec 2009 01:20:24 +0100
Message-ID: <20091217002024.GM25474@genesis.frugalware.org>
References: <20091216101647.GB27373@bc-bd.org>
 <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
 <20091216232641.GK25474@genesis.frugalware.org>
 <51419b2c0912161559x4de94464pe06df2845dbe3b78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n83H03bbH672hrlY"
Cc: bd@bc-bd.org, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 01:20:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL46c-0007Sb-7B
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 01:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762877AbZLQAU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 19:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762857AbZLQAU2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 19:20:28 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34104 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758220AbZLQAU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 19:20:28 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C258E58055;
	Thu, 17 Dec 2009 01:20:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AA08B44965;
	Thu, 17 Dec 2009 01:20:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E3AEE1240014; Thu, 17 Dec 2009 01:20:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <51419b2c0912161559x4de94464pe06df2845dbe3b78@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135348>


--n83H03bbH672hrlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2009 at 04:59:54PM -0700, Elijah Newren <newren@gmail.com> =
wrote:
> Did you try it with a 'new' branch in your repository that started at
> the beginning of history rather than at some commit?  "git log new"
> and "git log new@{30.years.ago}..new" are not the same for me with
> git-1.6.5.5:
>=20
> $ git init repo
> $ cd repo
> $ echo content> foo && git add foo && git commit -mone foo
> $ echo more content >> foo && git commit -mtwo foo
> $ git checkout -b new master~1
> $ echo stuff >> foo && git commit -mthree foo
> $ git log new@{30.years.ago}..new

Aah, thanks. Then you can just avoid the warning using

git log $(git reflog show new|sed -n 's/ .*//;$ p')..new

> Are you sure?  I'm more inclined to believe he'd like to see all the
> commits that have been added to the "new" branch since he created it
> (which may be the same as what you say, but not necessarily).  Of
> course, neither my assumption or yours match what he actually asked
> for (though I think what he asked for isn't possible and is merely an
> means to the end he really wants).

No, I'm not sure about what he thought, but I hope he will clarify. :)

--n83H03bbH672hrlY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkspeUgACgkQe81tAgORUJadvgCfWHthLw2gjTinztfh+edaHPi3
EZgAn1Dt+tCUxvBT6PJmfuOvKm/6qYcR
=77t5
-----END PGP SIGNATURE-----

--n83H03bbH672hrlY--
