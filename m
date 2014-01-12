From: "W. Trevor King" <wking@tremily.us>
Subject: Tight submodule bindings (was: Preferred local submodule branches)
Date: Sat, 11 Jan 2014 17:08:47 -0800
Message-ID: <20140112010847.GJ29954@odin.tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PK5kSfjks5jzTD3m"
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 12 02:09:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W29YK-00047z-Ve
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 02:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbaALBIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jan 2014 20:08:54 -0500
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:43412
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877AbaALBIw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jan 2014 20:08:52 -0500
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id Cp1U1n0030mv7h056p8rMc; Sun, 12 Jan 2014 01:08:51 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id Cp8p1n00E152l3L3Xp8qfQ; Sun, 12 Jan 2014 01:08:51 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 43D0BECD5FF; Sat, 11 Jan 2014 17:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389488928; bh=tgDqY2g/9qTdSWc5qall8vBiH0zSjc/n0ptUORYHrB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DV6ouVaVXHL7TzDH6zRGC7zzaxaABu0uBrxQRgKo0++MTTwqQeFX7DrmOR+mqrtnk
	 g4j5mOHsUZVOWZYm5BldWt3HI4+T2kPyk1oGgNnpcRPdrBuRM02hYoTyEUTf4kvvdd
	 oe//Mf+aL/ud4IEptO23T626VvG8Q0eQ4FD8r+0s=
Content-Disposition: inline
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389488931;
	bh=DdC7upqdg2Ri8YoKUlstttyJ6u3jUlklt14FgsNnXA0=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=IHqMfSTF2X/ZZLljK/Oqc9UQ2Wek5H/MOC7NiuvNMeqTn55mChRbHRwYDe1W0bXEm
	 zyqOMadKPCwz+xabXh1UU8ocohy9Lcnx44wYz4nUHzwfxHWaUAXvGUs+Djx4eim5d5
	 5YWLqeyamHZGWQxAhkqCyi1XEV+EqLTwd13LSsh2rnNUFmYZqDKhbLd6RPDh3pdVXl
	 /vAi+bd/16RHjIkMH8Cv/Ld3n9Gv3SXyINXVnc58jvJ51BdIUsWuZS6z0oc4w5GmPb
	 juSMEXA8aVBX9BtyfpBzrM7p6O8/sTAnSyQ28o3oV/49EVp14px5r+dx6s7WsmavDN
	 cDuR+3q28WkCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240336>


--PK5kSfjks5jzTD3m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2014 at 10:17:51PM -0800, W. Trevor King wrote:
> In another branch of the submodule thread Francesco kicked off, I
> mentioned that we could store the preferred local submodule branch on
> a per-superbranch level if we used the
> .git/modules/<submodule-name>/config for local overrides [1].  Here's
> a patch series that greatly extends my v2 "submodule: Respect
> requested branch on all clones" series [2] to also support automatic,
> recursive submodule checkouts, as I outlined here [3].
>=20
> [1]: http://article.gmane.org/gmane.comp.version-control.git/240240
> [2]: http://article.gmane.org/gmane.comp.version-control.git/239967
> [3]: http://article.gmane.org/gmane.comp.version-control.git/240192

While mulling over better ways to explain my local-branch idea, I've
come up with a more tightly bound model that may help break the
silence that has greeted the =E2=80=9CPreferred local submodule branches=E2=
=80=9D
series ;).  That series doesn't have strong options on update
mechanics, which leads to wishy-washy exchanges where nobody has a
clear mental picture:

On Thu, Jan 09, 2014 at 10:40:52PM +0100, Jens Lehmann wrote:
> Am 09.01.2014 20:55, schrieb W. Trevor King:
> > On Thu, Jan 09, 2014 at 08:23:07PM +0100, Jens Lehmann wrote:
> >> Am 09.01.2014 18:32, schrieb W. Trevor King:
> >>>> when superproject branches are merged (with and without conflicts),
> >>>
> >>> I don't think this currently does anything to the submodule itself,
> >>> and that makes sense to me (use 'submodule update' or my 'submodule
> >>> checkout' if you want such effects).  We should keep the current logic
> >>> for updating the gitlinked $sha.  In the case that the
> >>> .gitmodule-configured local-branches disagree, we should give the
> >>> usual conflict warning (and <<<=3D=3D=3D>>> markup) and let the user =
resolve
> >>> the conflict in the usual way.
> >>
> >> For me it makes lots of sense that in recursive checkout mode the
> >> merged submodules are already checked out (if possible) right after
> >> a superproject merge, making another "submodule update" unnecessary
> >> (the whole point of recursive update is to make "submodule update"
> >> obsolete, except for "--remote").
> >=20
> > If you force the user to have the configured local-branch checked out
> > before a non-checkout operations with checkout side-effects (as we
> > currently do for other kinds of dirty trees), I think you'll avoid
> > most (all?) of the branch-clobbering problems.
>=20
> I'm thinking that a local branch works in two directions: It should
> make it easy to follow an upstream branch and also make changes to it
> (and publish those) if necessary. But neither local nor upstream
> changes take precedence, so the user should either use "merge" or
> "rebase" as update strategy or be asked to resolve the conflict
> manually when "checkout" is configured and the branches diverged.
> Does that make sense?

The current series is only weakly bound (you can explicitly call git
submodule checkout' to change to the preferred local submodule
branch), and the current Git is extremely weakly bound (you have to cd
into the submodule and change branches by hand).  The following
extrapolates the =E2=80=9CPreferred local submodule branches=E2=80=9D serie=
s to a
tightly-bound ideal.

Gitlinked commit hash
---------------------

The submodule model revolves around links to commits (=E2=80=9Cgitlinks=E2=
=80=9D):

  $ git ls-tree HEAD
  100644 blob 189fc359d3dc1ed5019b9834b93f0dfb49c5851f    .gitmodules
  160000 commit fbfa124c29362f180026bf0074630e8bd0ff4550  submod

These are effectively switchable trees.  The tree referenced by commit
fbfa124 is 492781c:

  $ (cd submod/ && git cat-file commit fbfa124)
  tree 492781c581d4dec380a61ef5ec69a104de448a74
  =E2=80=A6

If you init the submodule, subsequent checkouts will check out that
tree, just like 'git checkout' would do if you'd had a superproject
tree like:

  $ git ls-tree HEAD
  100644 blob 189fc359d3dc1ed5019b9834b93f0dfb49c5851f    .gitmodules
  040000 tree 492781c581d4dec380a61ef5ec69a104de448a74    submod

For folks who treat the submodule as a black box (and do no local
development), switchable trees are all they care about.  They can
easily checkout (or not, with deinit), the submodule tree at a
gitlinked hash, and everything is nice and reproducible.  The fact
that 'submod' is stored as a commit object and not a tree, is just a
convenient marker for optional init/deinit/remote-update-integration
functionality.

Additional metadata, the initial checkout, and syncing down
-----------------------------------------------------------

However, folks who do local submodule development will care about
which submodule commit is responsible for that tree, because that's
going to be the base of their local development.  They also care about
additional out-of-tree information, including the branch that commit
is on.  For already-initialized submodules, there are existing places
in the submodule config to store this configuration:

1. HEAD for the checked-out branch,
2. branch.<name>.remote =E2=86=92 remote.<name>.url for the upstream
   subproject URL,
4. branch.<name>.rebase (or pull.rebase) to prefer rebase over merge
   for integration,
5. =E2=80=A6

You need somewhere in-tree to store this destined-to-be-out-of-tree
information, so that superproject developers that have not yet
initialized the submodule will know what values are suggested by the
superproject maintainers.  That's where .gitmodules comes in, because
storing all of this fairly static, locally overridable information in
the gitlink itself would be nonsensical (said Linus in 2007 [1]).
When you checkout a submodule for the first time, Git should take the
default information from .gitmodules and file it away in the
submodule's appropriate out-of-tree config locations.  The out-of-tree
data listed above should be stored in:

1. submodule.<name>.local-branch
2. submodule.<name>.url
4. submodule.<name>.update
5. =E2=80=A6

Once you have an in-tree way to specify defaults for this out-of-tree
information, you're going to have developers like me that just want to
stick with the defaults, following them through changes.  That means
you'd like to have the =E2=80=9Ccopy .gitmodules defaults into your
submodule's config=E2=80=9D functionality that usually happens on the initi=
al
submodule checkout happen on *every superproject-initiated checkout*.
In fact, I think life is easier for everyone if this is the default,
and we add a new option (submodule.<name>.sync =3D false) that says
=E2=80=9Cdon't overwrite optional settings in my submodule's out-of-tree
config on checkout=E2=80=9D for for folks who want to opt out.  Don't worry,
this is not going to clobber people, because we'll be syncing the
other way too.

Syncing up
----------

In the previous section I explained how data should flow from
=2Egitmodules into out-of-tree configs.  What about the other direction?
We currently let folks handle this by hand, but I'd prefer a tighter
integration between the submodule config and the superproject tree to
avoid losing work.  That means changes to tracked submodule status
(checked-out hash, checked-out branch, upstream URL, upstream branch,
default integration strategy, =E2=80=A6) should trigger dirty-tree status j=
ust
like uncommitted changes to in-tree files.  'git add' (or stash) on
the dirty submodule would store changed commit hashes in the index,
pull changed out-of-tree configs back into the in-tree .gitmodules,
and add the new .gitmodules to the index.  If the working .gitmodules
was already dirty (vs. the index), the add/stash should die without
making any changes.  If the user has disabled syncing between
=2Egitmodules and the submodule's out-of-tree configs, then don't worry
about optional settings.  Always sync the required settings, which at
this point would just be submodule.<name>.local-branch.

Purely local metadata
---------------------

Some metadata does not make sense in the superproject tree.  For
example, whether a submodule is interesting enough to checkout
(init/deinit) or whether you want to auto-sync optional metadata
=2Egitmodules defaults.  This metadata should live in the superproject's
out-of-tree config, and should not be stored in the in-tree
=2Egitmodules.  Since you *will* want to share the upstream URL, I
proposed using an explicit submodule.<name>.active setting to store
the =E2=80=9Cdo I care=E2=80=9D information [2], instead of overloading
submodule.<name>.url (I'd auto-sync the .gitmodule's
submodule.<name>.url with the subproject's remote.origin.url unless
the user opted out of .gitmodules syncing).

Subsequent checkouts
--------------------

Now that we have strict linking between the submodule state (both
in-tree and out-of-tree configs) and the superproject tree (gitlink
and .gitmodules), changing between superproject branches is really
easy:

1. Make sure the working tree is not dirty.  If it is, ask the user to
   either add-and-commit or stash, and then die to let them do so.

2. Checkout the new superproject branch.

   2.1. For each old submodule that doesn't exist in the new branch,
        blow away the submodule directory (assuming a new-style
        .git/modules/=E2=80=A6 layout, and not an old-style submod/.git/=E2=
=80=A6
        layout).

   2.2. For each gitlinked submodule that didn't exist in the old
        branch, setup the submodule as if you were doing the initial
        cloning checkout (forcing a new local-branch to point at the
        gitlinked commit).  If you find local out-of-tree
        *superproject* configs that conflict with the .gitmodules
        values, prefer the superproject configs.  Clobber submodule
        configs and local branches at will (modulo
        submodule.<name>.sync), because any submodule configs that the
        user wanted to keep should have been added to the superproject
        branch earlier (or stashed).

Integrating other branches
--------------------------

Merges and rebases can alter the submodule's in-tree configs (and
create and remove submodules).  The existing logic for merging
=2Egitmodules and gitlinks works well, so stick with that.  In the event
that there are unresolvable conflicts, bail out and let the user
resolve the conflicts and use 'git commit' to finish checking out the
resolved state.

Issues
------

I like the current submodule integration configuration:

* submodule.<name>.branch (specify the remote branch to integrate, but
  I'd prefer submodule.<name>.integration-ref for clarity).
* submodule.<name>.update (specify how to integrate it, but I'd prefer
  submodule.<name>.integration-mode for clarity).

more than the current core integration configuration:

* branch.<name>.merge (with branch.<name>.remote, the branch to remote
  branch to integrate via merging).
* branch.<name>.rebase (override branch.<name>.merge to integrate via
  rebasing).

These seem to mix the orthogonal concepts of integration target and
integration mode, and the divergence from the .gitmodules
representation makes syncing awkward.

Summary
-------

New .gitmodules options:

* submodule.<name>.local-branch, store the submodule's HEAD, must stay
  in sync for checkouts.

New .git/config options:

* submodule.<name>.active, for init/deinit.

* submodule.<name>.sync, for whether you want to automatically sync
  the submodule's out-of-tree configs up to .gitmodules before
  checkout operations, and sync back from .gitmodules (possibly
  altered on the new branch) into the submodule's out-of-tree configs
  during checkout.

With this tighter binding, submodule information is either tracked in
the superproject, or explicitly not touched by the superproject.  That
makes it much harder to break things or clobber a user's work, and
also much easier to keep submodules up to date with superproject
changes.  Users shouldn't have to explicitly manage their submodules
to carry out routine core tasks like checking out other branches.

I see no reason to add --recurse-submodule flags to 'git checkout'
(and merge, =E2=80=A6).  Anything that happens post-clone should recurse
through submodules automatically, and use the submodule.<name>.active
setting to decide when recursion is desired.

I think the ideal submodule-specific interface would be just:

* git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>]
                [--reference <repository>] [--] <repository> [<path>]
* git submodule [--quiet] init [--] [<path>...]
* git submodule [--quiet] deinit [-f|--force] [--] <path>...
* git submodule [--quiet] foreach [--recursive] <command>

The current 'git submodule update --remote' would just be:

  $ git submodule foreach 'git pull'

because all of the local-branch checkouts would have already been
handled.  Similarly, a global push would be just:

  $ git submodule foreach 'git push'

You get all the per-submodule configuration (for triangular workflows,
etc.) for free, with no submodule-specific confusion.

So, is this:

* Interesting enough to be worth pursuing?
* Simple enough to be easily understood?

I'd be happy to mock this up in shell, but only if anyone else would
be interested enough to review the implementation ;).  Then I'll look
into integrating the preferred model (this tightly bound proposal, or
v3's looser bindings, or <your idea here>) in C, building on Jens and
Jonathan's work.

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/44162
[2]: http://article.gmane.org/gmane.comp.version-control.git/211042

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--PK5kSfjks5jzTD3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS0esdAAoJEKKfehoaNkbtSj8P/jwT2lO02rq5Ytr0N6BeOR97
5P+jvvqxxDleP2IYJKex1Aby/5u+CwItAX55Or/qwElvXqFiT7HaT4EwOGG92U94
LDBWiNuaFdwlFXPckeNg9Cqm0/YOETZxpv0GkvoctvTaPWrlOWrNOxNIrnwceIyB
8HzgttwMmpOMQBMpgFg/ClI5c6gieg3YMYBQURw4gBpjnkTgEC+cswO85xBPgVgS
uT4qfAczcDfWbKf7Z38MxPSXIARdrPiffNhSxDen1xAirfZMj520lL2pRT6+vvNi
EqmQSjVhw1SV1zI5uMTZsp6aUyt0Q5Jl+KJo6bgNtjhRsLCvUq8hCwM43HiZeRsF
hz/oxRcRjNExQFHMTTppwlMVX4hcFnqWvPAzXVfAgFJKY3GCgr6kd7taTYM/hkf1
4bg/eiwYlD0PLQ9KRus3ov5rHJxc8TQbZ1sS987ynPxhaqNH4GoZZhPbxwLKhYAa
zpuo4dHhKnTDQkoMrO0HyZ00OHaBd66LKGMe69mZ/v72EuXwbhyd4Pr7z4yqkpz2
WfJio80UZWkovoiB7VSwIB0TzIRqy/9sp3RUaQS1TbvwqclYEy4pEVvTl7Y/KMkv
1kYgJ1g3bGRbgi2wF5t3OHekU4YuNB1+aIeUkybIAIeYrZaM02vjThHHzpheA4Yx
UbnssehV/nbKlcuC/0Y+
=qfut
-----END PGP SIGNATURE-----

--PK5kSfjks5jzTD3m--
