From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git branch diagram
Date: Mon, 21 Apr 2008 14:07:15 +0100
Message-ID: <20080421130715.GB14598@bit.office.eurotux.com>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com> <m3fxtgqcbr.fsf@localhost.localdomain> <1c5969370804210548q4b6aa30h8a8c0323b3fc51d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Cc: Jakub Narebski <jnareb@gmail.com>, Patrick.Higgins@cexp.com,
	git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 15:08:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnvkg-0000Mx-Hh
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 15:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbYDUNHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 09:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYDUNHX
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 09:07:23 -0400
Received: from os.eurotux.com ([216.75.63.6]:52451 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771AbYDUNHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 09:07:21 -0400
Received: (qmail 28622 invoked from network); 21 Apr 2008 13:07:19 -0000
Received: from adsl.eurotux.com (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 21 Apr 2008 13:07:19 -0000
Content-Disposition: inline
In-Reply-To: <1c5969370804210548q4b6aa30h8a8c0323b3fc51d4@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80024>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2008 at 08:48:46AM -0400, Matt Graham wrote:
> On Sun, Apr 20, 2008 at 8:30 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > <Patrick.Higgins@cexp.com> writes:
> >
> >  > In my diagram, I am assuming that most developers work in master,
> >  > and make branches for their own long-lived projects and experimental
> >  > things.
> >
> >  For example git itself, as a project, uses three long-lived branches:
> >  'maint', 'master' and 'next', uses 'pu' (proposed updates) branch as
> >  propagation / review mechanism for short-lived tipic branches.
>=20
> Jakub, could you explain the difference between maint and master?  And
> the difference between master and next?  Maint and next are clear, but
> how does master relate to those 2?

<quote from=3D"maintainer">
There are four branches in git.git repository that track the
source tree of git: "master", "maint", "next", and "pu".  I may
add more maintenance branches (e.g. "maint-1.5.4") if we have
hugely backward incompatible feature updates in the future to keep
an older release alive; I may not, but the distributed nature of
git means any volunteer can run a stable-tree like that herself.

The "master" branch is meant to contain what are very well
tested and ready to be used in a production setting.  There
could occasionally be minor breakages or brown paper bag bugs
but they are not expected to be anything major, and more
importantly quickly and trivially fixable.  Every now and
then, a "feature release" is cut from the tip of this branch and
they typically are named with three dotted decimal digits.  The
last such release was 1.5.5 done on Apr 7th this year.  You
can expect that the tip of the "master" branch is always more
stable than any of the released versions.

Whenever a feature release is made, "maint" branch is forked off
=66rom "master" at that point.  Obvious, safe and urgent fixes
after a feature release are applied to this branch and
maintenance releases are cut from it.  The maintenance releases
are named with four dotted decimal, named after the feature
release they are updates to; the last such release was 1.5.4.5.
New features never go to this branch.  This branch is also
merged into "master" to propagate the fixes forward.

A trivial and safe enhancement goes directly on top of "master".
A new development, either initiated by myself or more often by
somebody who found his or her own itch to scratch, does not
usually happen on "master", however.  Instead, a separate topic
branch is forked from the tip of "master", and it first is
tested in isolation; I may make minimum fixups at this point.
Usually there are a handful such topic branches that are running
ahead of "master" in git.git repository.  I do not publish the
tip of these branches in my public repository, however, partly
to keep the number of branches that downstream developers need
to worry about low, and primarily because I am lazy.

The quality of topic branches are judged primarily by the mailing list
discussions.  Some of them start out as "good idea but obviously is
broken in some areas (e.g. breaks the existing testsuite)" and then
with some more work (either by the original contributor's effort or
help from other people on the list) becomes "more or less done and can
now be tested by wider audience".  Luckily, most of them start out in
the latter, better shape.

The "next" branch is to merge and test topic branches in the
latter category.  In general, the branch always contains the tip
of "master".  It might not be quite rock-solid production ready,
but is expected to work more or less without major breakage.  I
usually use "next" version of git for my own work, so it cannot
be _that_ broken to prevent me from pushing the changes out.
The "next" branch is where new and exciting things take place.

The two branches "master" and "maint" are never rewound, and
"next" usually will not be either (this automatically means the
topics that have been merged into "next" are usually not
rebased, and you can find the tip of topic branches you are
interested in from the output of "git log next"). You should be
able to safely track them.

After a feature release is made from "master", however, "next"
will be rebuilt from the tip of "master" using the surviving
topics.  The commit that replaces the tip of the "next" will
have the identical tree, but it will have different ancestry
=66rom the tip of "master".  An announcement will be made to warn
people about such a rebasing.

The "pu" (proposed updates) branch bundles all the remainder of
topic branches.  The "pu" branch, and topic branches that are
only in "pu", are subject to rebasing in general.  By the above
definition of how "next" works, you can tell that this branch
will contain quite experimental and obviously broken stuff.

When a topic that was in "pu" proves to be in testable shape, it
graduates to "next".  I do this with:

        git checkout next
        git merge that-topic-branch

Sometimes, an idea that looked promising turns out to be not so
good and the topic can be dropped from "pu" in such a case.

A topic that is in "next" is expected to be tweaked and fixed to
perfection before it is merged to "master" (that's why "master"
can be expected to stay very stable).  Similarly to the above, I
do it with this:

        git checkout master
        git merge that-topic-branch
        git branch -d that-topic-branch

Note that being in "next" is not a guarantee to appear in the
next release (being in "master" is such a guarantee, unless it
is later found seriously broken and reverted), or even in any
future release.  There even were cases that topics needed
reverting a few commits in them before graduating to "master",
or a topic that already was in "next" were entirely reverted
=66rom "next" because fatal flaws were found in them later.

Starting from v1.5.0, "master" and "maint" have release notes
for the next release in Documentation/RelNotes-* files, so that
I do not have to run around summarizing what happened just
before the release.
</quote>

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD4DBQFIDJGDinSul6a7oB8RAsa+AJdCJ3k9LUAeUtCgDtwbzSuuJfhFAJ4zpMv4
PPcpOU6Q8fUBrogOkMj/0Q==
=iTwM
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
