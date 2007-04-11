From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 01:54:50 +0200
Message-ID: <20070411235447.GO21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmeQ-0006C5-2N
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXDKXyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbXDKXyz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:54:55 -0400
Received: from mail.admingilde.org ([213.95.32.147]:43034 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbXDKXyy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:54:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HbmeI-0001gm-UG; Thu, 12 Apr 2007 01:54:51 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44280>


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 08:16:10AM -0700, Linus Torvalds wrote:
> Branches in submodules actually in many ways are *more* important than=20
> branches in supermodules - it's just that with the CVS mentality, you=20
> would never actually see that, because CVS obviously doesn't really=20
> support such a notion.

I fully agree with you about the importance of submodule branches.
In fact, I want to make them even more important and useable!

And by the way, I long forgot about CVS ;-)


> So I'd argue that branches in submodules give you:
>=20
>  - you can develop the submodule *independently* of the supermodule, but=
=20
>    still be able to easily merge back and forth.
>=20
>    Quite often, the submodule would be developed entirely _outside_ of th=
e=20
>    supermodule, and the "branch" that gets the most development would thus
>    actually be the "vendor branch", entirely outside the supermodule. Cal=
l=20
>    that the "main" branch or whatever, inside the supermodule it would=20
>    often be something like the remote "remotes/origin/master" branch.
>=20
>    So inside the supermodule, the HEAD would generally point to something=
=20
>    that is *not* necessarily the "main development" branch, because the=
=20
>    supermodule maintainer would quite logically and often have his own=20
>    modifications to the original project on that branch. It migth be a=20
>    detached branch, or just a local branch inside the submodule.

I fully agree.

>  - branches inside submodules are *also* very useful even inside the=20
>    supermodule, ie they again allow topic work to be fetched into the
>    submodule *without* having to actually be part of the supermodule,
>    or as a way to track a certain experimental branch of the supermodule.
>=20
>    I suspect that most supermodule usage is as an "integrator" branch,=20
>    which means that the supermodule tends to follow the "main=20
>    development", and the whole point of the supermodule is largely to hav=
e=20
>    a collection of "stable things that work together".=20
>=20
>    In contrast, branches within submodules are useful for doing all the=
=20
>    development that is *not* yet ready to be committed to the supermodule=
,=20
>    exactly because it's not yet been tested in the full "make World" kind=
=20
>    of situation.

I fully agree.
You are just so much better in describing things than I am...

> > Whenever you do a checkout in the supermodule you also have to update
> > the submodule and this update has to change the same thing which is read
> > above.
>=20
> I suspect (but will not guarantee) that the right approach is that a=20
> supermodule checkout usually just uses a "detached HEAD" setup. Within th=
e=20
> context of the supermodule, only the actual commit SHA1 matters, not what=
=20
> branch it was developed on (side note: I haven't decided if we should=20
> allow the SHA1 to be a signed tag object too - the current patches=20
> obviously don't care since they never follow the SHA1 anyway, and it migh=
t=20
> be a good idea).

If you use a detached HEAD then you can no longer switch back to it
once you used some other (independent) branch (for testing or whatever).
This is my main argument: If you just update some 'special'
refs/heads/from-supermodule (or whatever, maybe get it from
=2Egitmodules/config) you can still switch between branches, making them
more useful IMHO.

If we create some other way to easily get to the commit referenced by
the index of the supermodule then a detached HEAD is ok for me, too.
But why create two things (this not-yet-existing way to get the
supermodule index entry, plus submodules HEAD) for the same thing?
Why not simply create a new refs/heads/whatever?
This is easy and everybody knows how to work with it.

> So I strongly suspect (and that is what the patch series embodies) that a=
s=20
> far as the supermodule is concerned, it should *not* matter at all what=
=20
> branch the subproject was on. The subproject can use branches for=20
> development, and the supermodule really doesn't care what the local=20
> branchname was when a commit was made - because branch-names are *local*=
=20
> things, and a branch that is called "experimental" in one environment=20
> might be called "master" in another.

Fully agree.

Please don't confuse my "I always want to use one dedicated branch" with
"I always want to use one special branch from the submodule project".
This refs/heads/whatever I am talking about is _purely_ for ease of
use of the submodule inside the supermodule.  It is in no way linked
to the branchnames that are used by the submodule project.
Well, besides that you can merge back and forth between them, of course.

> So once the commit hits the superproject, the branch identities just go=
=20
> away (only as far as the superproject is concerned, of course - the=20
> subproject still stays with whatever branches it has), and the only thing=
=20
> that matters is the commit SHA1.

Fully agree.

> > Updating the branch which HEAD points to is dangerous.
>=20
> I would strongly suggest that the *superproject* never really change the=
=20
> status of the subproject HEAD, except it updates it for "pull/reset", and=
=20
> then it just would use whatever the subproject decided to use.
>=20
> The subproject HEAD policy would be entirely under the control of the=20
> subproject. If the subproject wants to use a branch to track the=20
> superproject, go wild: have a real branch that is called "my-integration"=
=20
> and make HEAD a symref to that (and thus any work in the superproject wil=
l=20
> update that branch - something that is visible when you pull directly fro=
m=20
> that subproject!)

So you now have this nice "my-integration" branch lying next to other
independent (not-supermodule-related) branches.
If you want to _switch_ to one of these unrelated branches you obviously
have to change HEAD, and suddenly your unrelated branches are
considered to be part of the supermodule (ok, not yet part of its
index of course, but now all supermodule operations would work on
this unrelated branch).

I want to preserve these unrelated branches and see them as a strong
feature.  Branches in submodules should be independent from the
supermodule _because_ the supermodule has no notion of which branch
is used.

> But quite often, I suspect that a subproject would just use a detached=20
> HEAD. The subproject may have branches of its own, of course, but you can=
=20
> think of HEAD as not being connected to any of it's "own" branches, but=
=20
> simply being the "superproject branch". That's a fairly accurate picture=
=20
> of reality, and using "detached HEAD" sounds like a very natural thing to=
=20
> do in that situation.

Only that you loose your nice detached HEAD view once you start using
those nice branches inside your submodule.

> So I really think you can do both, and I think using HEAD inside the=20
> superproject gives you exactly that flexibility - you can decide on a=20
> per-subproject basis whether HEAD should track a real local branch in a=
=20
> subproject, or whether it should be detached.
>=20
> (Side note: if you do *not* use detatched HEAD, I suspect the .gitmodules=
=20
> file could also contain the branchname to be used for the subproject=20
> tracking, but I think that's a detail, and quite debatable)
>=20
> > So my advice is:
> > Always read and write one dedicated branch (hardcoded "master" or
> > configurable) when the supermodule wants to access a submodule.
>=20
> So the main reasons I don't think that is a good idea are:
>=20
>  - it's less flexible: see above on why you might want to use a dedicated=
=20
>    branch *or* just detached HEAD, and why you might want to choose your=
=20
>    own name for the dedicated branch.

In terms of flexibility it is important what you can do with the
submodule.  Being able to use branches just like in a normal
repository ("switch the branch to go to an other, unrelated branch")
is a plus for me.

A detached HEAD does not give the same level of flexibility as a real
head.

>  - it's also going to be quite confusing when the superproject sees=20
>    something *else* than what is actually checked out.

Well, the user explicitly expressed his intent to switch to another
branch!  In a normal repository you are not confused about the working
directory not being in sync with "master", and we always prominently state
which branch you are on.  Of course this has to be clear for submodules,
too.  So if you do git-status in the supermodule it should print some
"submodule is on different branch"-dirty marker.

At least I had some situations where I wanted to use something like
this: use some experimental brach which should not be directly touched
by the supermodule.  Instead provide a method ("git merge
=66rom-supermodule") to sync your working branch with new stuff from
the supermodule.

>    This is an equally strong argument for just using HEAD - when we
>    actually implement a
>=20
> 	 git diff --subproject
>=20
>    flag that recurses into the subproject, if you don't use HEAD inside=
=20
>    the subproject, that suddenly becomes a *very* confusing thing.

This is right.  Suddenly we have one more player in the field which
you can diff against.

Before submodules:
tree <-> index <-> working file

submodules always using HEAD:
tree <-> index <-> submodule HEAD <-> submodule working dir

submodules using some dedicated branch:
tree <-> index <-> subm. "from-supermodule" <-> subm. HEAD <-> subm. wd

I haven't thought about which diff really makes sense in which
situation.


--=20
Martin Waitz

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHXVHj/Eaxd/oD7IRAmfQAJ4s7HBfIPDbb8/+lvCBB9hHYE+lBQCdGmtw
uHhfna1paRIR5UkLnO0mxX4=
=KUPt
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--
