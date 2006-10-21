From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 16:08:18 +0200
Message-ID: <200610211608.18895.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 16:08:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbHWL-0005Em-FX
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 16:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993074AbWJUOIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 10:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993077AbWJUOIN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 10:08:13 -0400
Received: from hu-out-0506.google.com ([72.14.214.226]:57675 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993074AbWJUOIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 10:08:12 -0400
Received: by hu-out-0506.google.com with SMTP id 28so547220hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 07:08:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l7yXv+c+Q6VXULrBpBuW9ftRQ7efVq5uQjRgb/PhQCiSSWb2gRAnxAJ3c906YB8jy9Levh9i/eLpQZBcObR8a4ft696QEZSnN9mw4iklJBXKQv+GBaDHOADYu36M8Clj74rNl5q3SbGYq/3jzlqmeIW9M3F9iEP4C+uaeo3q+as=
Received: by 10.67.105.19 with SMTP id h19mr3793277ugm;
        Sat, 21 Oct 2006 07:08:10 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 30sm2662730ugf.2006.10.21.07.08.09;
        Sat, 21 Oct 2006 07:08:09 -0700 (PDT)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021130111.GL75501@over-yonder.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29614>

Dnia sobota 21. pa=BCdziernika 2006 15:01, Matthew D. Fuller napisa=B3:
> On Fri, Oct 20, 2006 at 02:48:52PM -0700 I heard the voice of
> Carl Worth, and lo! it spake thus:
> >=20
> > The entire discussion is about how to name things in a distributed
> > system.
>=20
> I think we're getting into scratched-record-mode on this.
>=20
>=20
> Git: Revnos aren't globally unique or persistent.
>=20
> Bzr: Yes, we know.
>=20
> G: Therefore they're useless.
>=20
> B: No, they're very useful in [situation] and [situation], and we dea=
l
>    with [situation] all the time, and they work great for that.
>=20
> G: But they fall apart totally in [situation].

G: But revnos force centralized/star-topology development. And even in
   [situation] have [disadvantages].

> B: Yes, so use revids there.
>=20
> G: So use revids everywhere.
>=20
> B: Revnos are handier tools for [situation] and [situation] for
>    [reason] and [reason].

G: Shortened sha1 commit-ids are almost as handy.

> *brrrrrrrrrrrrrrrrip!!!*    *skip back to start*

There _are_ terminology conflicts. For example bzr "branch" is roughly=20
equivalent to one-branch git "repository"; bzr "repository" is just=20
collection of branches sharing common storage, which is similar to set=20
of git "repositories" with .git/objects/ linked to common object=20
repository (storage area) or appropriately set alternates file=20
(although that is not common usage in git, and for example you would=20
have to be carefull with running git-prune); bzr "lightweight checkout"=
=20
is equivalent to nonexistent "lazy clone"/"remote alternates" discussed=
=20
on git mailing list but not implemented because of performance=20
concerns; bzr "normal checkout" is I think similar to git "shared=20
clone" (but shared clone is limited to repositories on the same=20
filesystem); bzr "heavyweight checkout" is roughly equivalent to=20
one-branch-only "clone" in git or cg (cg =3D Cogito).

And there are differences in opinion. For example "simple namespace for=
=20
revisions" which is important for bzr, is superficially simple for git=20
(as it works only for centralized approach, and for leaf repositories=20
you have to have access to central repository to get final revnos); on=20
the other hand "not simpleness" of git's sha1 identifiers is not that=20
complicated in everydays work, as one usually use branch and tag names,=
=20
<ref>~<n> and <ref1>..<ref2> syntax, sometimes shortened sha1 names and=
=20
full sha1 names only rarely. For bzr it is more important to tell from=20
revno which commit on branch was earlier, for git it is more important=20
that commitids never ever change; we can use git commands to check=20
which commit was earlier. For bzr plugins are important, for git it is=20
important to be easy to add new commands, using scripts for fast=20
prototyping.

> > It may be that the centralization bias
>=20
> I think it's more accurately describable as a branch-identity bias.
> The git claim seems to be that the two statements are identical, but =
I
> have some trouble swallowing that.

When two clones of the same repository (in git terminology), or two=20
"branches" (in bzr terminology), used by different people, cannot be=20
totally equivalent that is centralization bias. By equivalent I mean=20
that "old history" is exactly the same (the same diagram, the same
identifiers - make it usually used identifiers).
=20
The fact that you have two different commands, "merge" vs "pull"
for using in one mother/mainline "branch" vs other "branches" tells
us that there is bias towards centralization.

> > I'm still not sure exactly what a bzr branch is, but it's clearly
> > something different from a git branch,
>=20
> The term is somewhat overloaded, which is why it's causing you troubl=
e
> (and did me).  It refers both to the conceptual entity ("a line of
> development" roughly, much like what 'branch' means in git and VCS in
> general), and to the physical location (directory, URL) where that
> branch is stored, and where it'll often have a working tree.  Branche=
s
> are always referred to by location, never by name.

I'd rather use other name then. Perhaps "forks" for physical "branch",
i.e. branch metadata (like revno to revid mapping) + object repository=20
or pointer to it + optionally working area/working files.=20

[...]
> > (since pull seems the only way to synch up without infinite new
> > merge commits being added back and forth).
>=20
> The infinite-merge-commits case doesn't happen in bzr-land because we
> generally don't merge other branches except when the branch owner say=
s
> "Hey, I've got something for you to merge".  If you were to setup a
> script to merge two branches back and forth until they were 'equal',
> yes, it'd churn away until you filled up your disk with the N bytes o=
f
> metadata every new revision uses up.

And you say that bzr is not biased towards centralization? In git you=20
can just pull (fetch) to check if there were any changes, and if there=20
were not you don't get useless marker-merges.


Take for example two simple git scenarios:
1. Single branch repository. We have two clones of the same repository,=
=20
both with only one branch, 'master', both working on this branch, and=20
both considered equal. If only one person worked on branch, "pull"=20
would result in fast-forward. If both worked on branch, "pull" would=20
result in merge. This is the "diamond" example by Pasky, which=20
explained why git doesn't treat first parent like special - because of=20
fast forward. Bzr treats first parent/mainline/"the branch" special=20
therefore it generates superficial merge commits if we preserve revnos;=
=20
BTW doesn't "pull" clobber your changes?

2. But the preferred git workflow is to have two branches in each of tw=
o=20
clones. The 'origin' branch where you fetch changes from other=20
repository (so called "tracking branch") and you don't commit your=20
changes to (by convention, as git doesn't protect the branch from=20
commiting to, although it would refuse to fetch in non fast-forward=20
case unless forced). You put your work in the 'master' branch, and you=20
merge 'origin' branch into 'master'. This allows for example fetching=20
changes to 'origin' but _not_ merging them immediately into 'master',
for example if you are in the middle of some larger work byt want to=20
check what other side did to not to create conflict if not neccessary.

--=20
Jakub Narebski
Poland
