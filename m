From: Mike Stump <mikestump@comcast.net>
Subject: Re: cherry picking and merge
Date: Wed, 6 Aug 2014 11:41:32 -0700
Message-ID: <B8B80DE2-EC29-48FE-862F-D7A68DE6B243@comcast.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com> <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com> <13DDD21A-F683-4116-9E07-F0D8AEF06A66@comcast.net> <40F24BA38E03454A9BA152F6AFDE56C4@PhilipOakley> <53E24D07.9010105@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>
To: =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF6A7-0007Ok-Iz
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587AbaHFSmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 14:42:06 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:60897 "EHLO
	qmta08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756311AbaHFSmF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 14:42:05 -0400
Received: from omta24.emeryville.ca.mail.comcast.net ([76.96.30.92])
	by qmta08.emeryville.ca.mail.comcast.net with comcast
	id bW2r1o0011zF43QA8Wi4vH; Wed, 06 Aug 2014 18:42:04 +0000
Received: from [IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d] ([IPv6:2001:558:6045:a4:40c6:7199:cd03:b02d])
	by omta24.emeryville.ca.mail.comcast.net with comcast
	id bWi21o01C2ztT3H8kWi3AY; Wed, 06 Aug 2014 18:42:04 +0000
In-Reply-To: <53E24D07.9010105@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1407350524;
	bh=T8KUjXIsDcdinLEbnGQq2T8ATIoZQKx2c2qPtK6kMkk=;
	h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
	 Message-Id:To;
	b=juKhYMCkuOhSqDWGHU/leepgjmDWUpiqRXlO4v01Sokxk3E2L4vIQIdH1q4fOb4y0
	 rkxx5RXZp91aHtePTK5ozx+W31P97aAnpYOQ5FPhPi+5WzKSlei+UwoqaUDsY1RgyJ
	 ivGeyU9Ybyb2U8P+WRLqPQdiGxdERnAo/6spXdDHHRCohQl0BVKRlwasLo1ms+2/rC
	 qNpw533bjQPCXwFqQDpoBBehu7mm1TsTOKPSRFALxZxLD6YbR0AUuu90zfcrgcfrvp
	 6EjVCf+ktK3aY52rP0ZZ5DD4WFIrAyAPBDkD+fEYq3fC32+LDh4ByKlf0UcX2daH8H
	 sjgA9g7nNn6Ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254889>

On Aug 6, 2014, at 8:43 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
>>> I gave a solution for git using branches and it works just fine.  I=
t
>>> retains the simple 3-point merge as well.
>=20
> It works for this simple case, but I think it has unfortunate potenti=
al
> to go silently wrong.

That just means that you want to have two commands.  One for the people=
 that when the remove a patch, they want it gone.  The other for people=
 that when they remove a patch, they want it to magically reappear.  I=E2=
=80=99m of the former class of individuals.  Now, I would argue that th=
at is the wrong solution of course.  See below for uncherry-pick.

Now, if I needed a solution to the one problem that was mentioned, I wo=
uld then request an uncherry-pick command to undo the cherry-pick.  The=
 semantics of it are, the patch is removed from the tree, and when merg=
ed, that patch isn=E2=80=99t removed from the source.  See, we then ret=
ain the useful property that everything that should work does, and the =
system is predictable because it then does exactly what the user said t=
o do.  Conceptually of course, it doesn=E2=80=99t have anything to do w=
ith cherry, if you merge a branch accidentally, and then remove it, and=
 merge it, I think you still wind up with the work being removed.  Conc=
eptually, it is just an undo a change, cherry, merge, file rename, what=
ever.

Now, why is this preferable?  Because the advanced user gets to explain=
 what they want to git, and then git does what they want.  It also work=
s for beginning users, it does what they ask it to do.  If you are afra=
id you know better what command that they really wanted to use instead =
of the command they are using, you can prompt them and ask, did you mea=
n this or that?  After 20 times being asked, it would get old and then =
even a new user would just issue the commands they want.  I=E2=80=99m n=
ot in favor of that, I=E2=80=99d prefer that the system just do what th=
ey tell it to do.

> Also, it prevents fully removing (commits, not only refs) the branch
> you cherry-picked from.  The commit you cherry picked may no longer
> be (or may no longer should be) in the repository.

I=E2=80=99m picking from trunk, when it goes, I go.  :-)

> Also, this could be avoided by using feature branches and merging
> instead of committing to one branch and cherry-picking to other
> branches.

If the problem remains unfixed, at least the documentation should be ch=
anged to say cherry will mess up merge.  If you never merge, never a pr=
oblem.  For me, I would read that, and say, well, trivially, cherry isn=
=E2=80=99t for me (til they fix the bug that causes it to mess up merge=
s).  I can=E2=80=99t see anything on http://git-scm.com/docs/git-cherry=
-pick which says it will mess up merges.