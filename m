From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Tue, 23 Jun 2009 15:58:28 -0700
Message-ID: <20090623225828.GD734@starfruit.corp.slide.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com> <94a0d4530905291558u564b4648ted79900b405f91b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 01:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJExb-0002OD-Lj
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 00:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753AbZFWW7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756168AbZFWW7Q
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 18:59:16 -0400
Received: from mx0.slide.com ([208.76.68.7]:39882 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737AbZFWW7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 18:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=j
	Hg92QpBbjJeV3Gp58tiekvPowzfvBvr/wWC9IuukOA=; b=jbTnQhrCYk/jwcGt7
	8M1HyG50QYmYvf0Yuwn8rMzcM97h1WyBLJuoNU+NS4ZFG7PUaDnlEqOSXT5l7VRD
	sIuJvqFINl1DHM+vJSoAyaz+xZ3OfAc+orfCNMV9k+aKa6+9wP/g913Ezm28wazL
	nMKRNjcKDwj6fTTE4oJfsjYhqw=
Received: from nat3.slide.com ([208.76.69.126]:35896 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1MJExT-0005P4-1C; Tue, 23 Jun 2009 15:59:19 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 01F4FA6F0002;
	Tue, 23 Jun 2009 15:59:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cx+Yk0mh7bla; Tue, 23 Jun 2009 15:59:18 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 9D82CA6F0001;
	Tue, 23 Jun 2009 15:59:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530905291558u564b4648ted79900b405f91b4@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122114>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Felipe, reply inline..

On Sat, 30 May 2009, Felipe Contreras wrote:

> On Fri, May 29, 2009 at 9:41 PM, R. Tyler Ballance <tyler@slide.com> wrot=
e:
> > I've noticed that keeping submodules updated is an absolute pain,
> > particularly with a large multiuser setup with *lots* of branches.
> >
> >
> > What will tend to happen is that the submodule reference will be updated
> > in the master branch (we use a centralized model) and then committed
> > (imagine the commit reference was incremented from A-B).
> >
> > Other developers with other branches will then periodically merge master
> > into their project/topic branches but will either neglect to run
> > `git submodule update` or our bootstrap script (which also executes the
> > submodule update command). At this point they'll have outstanding
> > changes of their own, and the submodule will be marked as "modified" as
> > well. Usually what will then happen is they'll `git commit -a` without
> > thinking and the submodule's reference will be changed (typically from
> > B->A, undoing the previous change).
> >
> >
> > Are there any saner ways of managing this? I've been trying to get the
> > `git submodule update` command to run with as many hooks as possible
> > (pre-commit, post-update) to make sure that developers aren't
> > inadvertantly breaking things, but nothing seems to ensure that
> > *everybody* is up to date and that *everybody* doesn't inadvertantly
> > commit changes to the submodule?
>=20
> Have you tried repo?
> http://source.android.com/download/using-repo

No I've not tried repo, and the likelihood of getting our now 100+ user
organization to switch over is highly unlikely.

Since I originally posted to this thread, I've had to entirely *remove*
the submodule from the super-project and just dump the code in (boo,
hiss) since it just caused too much damn trouble.

I'm going to give a newer version of Git a try and hope that everythin
is better now, since the need has arisen for a git submodule again and=20
things will get gnarly if I have to do another source dump.

:(

-R. Tyler Ballance
Slide, Inc.

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkpBXhQACgkQFCbH3D9R4W9xjgCeMnTZoEATCaxARWlCr5FfVU0r
A9QAn3qmOk7zRllNMyWMrKyzQE1MA7aX
=YZfg
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
