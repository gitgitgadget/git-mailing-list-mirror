From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 02:38:07 -0800
Organization: Slide, Inc.
Message-ID: <1228819087.18611.73.camel@starfruit.local>
References: <1228815240.18611.48.camel@starfruit.local>
	 <20081209191704.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YmHBXQy4VEaaI0wmY8gw"
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:39:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA007-0000ie-4e
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYLIKiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbYLIKiL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:38:11 -0500
Received: from mx0.slide.com ([208.76.68.7]:36153 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbYLIKiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=A
	Vz6IyfFMf0HyK4I0M5oqVltpeXm/rPI4ksQXBxRWAc=; b=iNZS+zt7V+kKlheY9
	VYKUqt/+Hc8bvLLEQCqg4Q6lokQ9nwt6dbecaVtumbReWO/n47mn05zRqtZlfR1Q
	JPep0Ky5NvCFRrhHzEUueuHYqYDTMDxRSS47czLvjQ6UN661wRftRcvqOEhOTWRX
	AjF26PR9qYKQNLIgv1nNpvvMxg=
Received: from nat3.slide.com ([208.76.69.126]:49557 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1L9zyj-0005fO-Kf; Tue, 09 Dec 2008 02:38:09 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 95E07A6F0002;
	Tue,  9 Dec 2008 02:38:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.455
X-Spam-Level: 
X-Spam-Status: No, score=-2.455 tagged_above=-10 required=6.6
	tests=[AWL=0.044, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6CsefZmgZ1sl; Tue,  9 Dec 2008 02:38:09 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id 14789A6F0001;
	Tue,  9 Dec 2008 02:38:09 -0800 (PST)
In-Reply-To: <20081209191704.6117@nanako3.lavabit.com>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102624>


--=-YmHBXQy4VEaaI0wmY8gw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 19:17 +0900, Nanako Shiraishi wrote:
> Quoting "R. Tyler Ballance" <tyler@slide.com>:
>=20
> > The most common use-case involves a user merging a project branch into =
a
> > stabilization branch (`git checkout stable && git pull . project`) in
> > such a way that no merge commit is generated. Of course, without
> > thinking they'll push these changes up to the centralized repository.
> > Not 15 minutes later they realize "ruh roh! I didn't want to do that"
>=20
> Why does the user not want to fast-forward, if the merge she wants to do =
is actually a fast-forward?

I agree with you, this is more about preventing coworkers who are too
lazy to understand the entirety of what they're doing from hurting the
workflow of "the rest of us". It's a technically solution to a people
problem (I understand technology far more than people ;))

Consider the following scenarion:
  % git checkout -b project=EF=BB=BF
=EF=BB=BF  % <work>
=EF=BB=BF  % git commit -am "A"=EF=BB=BF
=EF=BB=BF  % <work>
=EF=BB=BF  % git commit -am "B"=EF=BB=BF
=EF=BB=BF  % <work>
=EF=BB=BF  % git commit -am "C"=EF=BB=BF
=EF=BB=BF  % <work>
=EF=BB=BF  % git commit -am "D"
=EF=BB=BF=EF=BB=BF  % git checkout stable
=EF=BB=BF=EF=BB=BF  % git pull . project
=EF=BB=BF=EF=BB=BF  % <fast-forward>
=EF=BB=BF=EF=BB=BF  % git push origin stable
=EF=BB=BF=EF=BB=BF
At this point, QA is involved and what can happen is that QA realizes
that this code is *not* stable and *never* should have been brought into
the stable branch.

Now we have two options "block" the stable branch until LazyDeveloper
makes the appropriate changes to stabilize the branch again *OR* back
out LazyDeveloper's changes (A, B, C, D) and beat them up in the
alleyway :)

Given the nature of our work, we have a stable branch per-team, and one
funneling stable branch for the entire company (master), that branch
being used to push the live web site with.=20

The first option (block) is not feasible as it will block the 40+ other
developers from pushing code until LazyDeveloper sufficiently gets their
crap together.

The second option is why I want to force --no-ff on *all* pulls if
possible. With --no-ff we can simply `git revert -sn <hash> -m 1 && git
commit -a` in order to back out A, B, C, D. With a true fast-forward,
we've had to use git-rev-list(1) trickery and some bash scriptery to
properly revert a series of commits from a given time frame from a given
developer.


> If you forbid fast-forward merges, when they merge their successful
> experiment back to the original topic, it will leave an unwanted merge
> in the history.

I'm less concerned at this point, the company switched entirely to Git
two weeks ago, with the history containing possible unwanted merges. I'm
more concerned however with LazyDeveloper inadvertently polluting stable
branches as LazyDeveloper does not yet fully grasp the concepts that Git
offers

>=20
> In other words, I do not think --no-ff is a right solution for the proble=
m you are trying to solve.  Perhaps you would need a hook that prevents a m=
erge from certain direction from taking place instead?

If you do have a better solution to this problem (I dislike git push -f
origin[1]) I'm all ears, I'm more concerned with the end result at this
point ;)

Cheers


[1] We've stressed with our developers as much as possible that the
"origin" repository is to remain" pristine", that every action should be
"auditable" insofar that if you rollback a change, we want to see a
Revert commit, merges should create merge commits to where we can replay
or unwind the revision history correctly at any point in time or slice
of time. I *really* don't want "origin" to "lose commits".
--=20
-R. Tyler Ballance
Slide, Inc.

--=-YmHBXQy4VEaaI0wmY8gw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+So8ACgkQFCbH3D9R4W9cKgCfY7HTTkAHZoaKwuW3rC8HbWEB
+LsAnil45otwPXi0CxZ2FKYMboYcYw3i
=CuoK
-----END PGP SIGNATURE-----

--=-YmHBXQy4VEaaI0wmY8gw--
