From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] topgit tg push feature
Date: Thu, 7 May 2009 10:43:55 +0200
Message-ID: <20090507084355.GA11680@pengutronix.de>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 10:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zD4-0006Be-Qp
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZEGIn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbZEGIn5
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:43:57 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52211 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbZEGIn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:43:56 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M1zCt-0000Er-Mt; Thu, 07 May 2009 10:43:55 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M1zCt-0007Pn-AB; Thu, 07 May 2009 10:43:55 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118446>

Hi Marc, hi Bert,


On Thu, May 07, 2009 at 07:45:21AM +0200, Bert Wesarg wrote:
> On Thu, May 7, 2009 at 06:59, Marc Weber <marco-oweber@gmx.de> wrote:
> > Uwe K,
> >
> > what do you think. Is there still much to change to include this pa=
tch into
> > upstream?
> I think its a usefull tool, but I haven't tested it yet.
Bert, thanks for your review.
=20
> > new patch version. adding small comment saying that the two options
> > --ne-deps and --tgish-only will seldomly used..
> >
> > Sincerly
> > Marc Weber
> >
> > commit c1cff518e3f70e9bd6cb4f2119b86e506ab43776
> > Author: Marc Weber <marco-oweber@gmx.de>
> > Date: =A0 Thu May 7 06:46:28 2009 +0200
> >
> > =A0 =A0t/tg-push
> >
> > =A0 =A0add tg-push =A0pushing the branch, its deps and their bases
> >
> > =A0 =A0Usage: tg push [(--no-deps | --tgish-only)] remote*
> >
> > =A0 =A0Signed-off-by: Marc Weber <marco-oweber@gmx.de>
> >
> > diff --git a/README b/README
> > index d2f095d..6f2b2bc 100644
> > --- a/README
> > +++ b/README
> > @@ -480,6 +480,19 @@ tg update
> >
> > =A0 =A0 =A0 =A0TODO: tg update -a for updating all topic branches
> >
> > +tg push
> > + =A0 =A0 =A0 Usage: tg push [(--no-deps | --tgish-only)] remote*
> no need to repeat yourself. 'tg help push' will print the usage from
> tg-push first. And where is the --dry-run option?
>=20
> > + =A0 =A0 =A0 $git push remote branch # this doesn't push the base.
> > + =A0 =A0 =A0 $git push remote =A0 =A0 =A0 =A0# pushes all branches=
 (and bases)
> > + =A0 =A0 =A0 You use
> > +
> > + =A0 =A0 =A0 $tg push remote
> > + =A0 =A0 =A0 to push the current branch,
> > its deps and their both tgish and non-tgish deps.
> This phrase needs rewording, what about: "its deps, both their tgish
> and non-tgish ones."
I'd like to have a bit more prose.  Something like:

	tg push
	~~~~~~~
		pushes a TopGit-controlled topic branch to a remote
		repository.  By default the remote gets all dependencies
		(both tgish and non-tgish) and bases pushed to.

> > --- /dev/null
> > +++ b/tg-push.sh
> > @@ -0,0 +1,69 @@
> > +#!/bin/sh
> > +# TopGit - A different patch queue manager
> > +# GPLv2
> > +
> > +remotes=3D
> > +
> > +## Parse options see README
> > +
> > +recurse_deps=3D1
> > +tgish_deps_only=3D
> > +
> > +while [ -n "$1" ]; do
> > + =A0 =A0 =A0 arg=3D"$1"; shift
> > + =A0 =A0 =A0 case "$arg" in
> > + =A0 =A0 =A0 --no-deps)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 recurse_deps=3D;;
> > + =A0 =A0 =A0 --dry-run)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dry_run=3D1;;
> > + =A0 =A0 =A0 --tgish-only)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tgish_deps_only=3D1;;
> > + =A0 =A0 =A0 *)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remotes=3D"$remotes $arg";;
> > + =A0 =A0 =A0 esac
> > +done
> now i see why you have the Usage: in the README. common practice is t=
o
> print the usage if an unknown option was given. see all the other
> tg-*.sh scripts.
ack
=20
> > +
> > +if [ -z "$remotes" ]; then
> > + =A0 =A0 =A0 remotes=3D"$(git config topgit.remote 2>/dev/null)"
> > +fi
> How effetcts the tg -r REMOTE option this command. Or more exactly wh=
y
> doesn't have this option an effect here?
ack
=20
> > +
> > +if [ -z "$remotes" ]; then
> > + =A0 =A0 =A0 die "no remote location given. Either add a remote as=
 additional argument or set topgit.remote"
> > +fi
> > +
> > +name=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
> > +ref_exists "$name" || die "detached HEAD? Can't push that"
> the common error message is: "not a TopGit-controlled branch".
>=20
> > +
> > +push_branch(){
> > + =A0 =A0 =A0 # don't push remotes
> > + =A0 =A0 =A0 [ -z "${_dep##refs/remotes/*}" ] && return 0
maybe extend the comment to something like:

	# if a remote is used ('topgit.remote' configuration variable or
	# tg -r $remote, a tg-base implicitly depends on
	# refs/remotes/$remote/top-bases/$_dep.  Don't push these.

You could even test if this is a dependency as described in this
comment.  Didn't test it, but something like

	test "x$_dep" =3D "xrefs/remotes/$base_remote/top-bases/$_name"

could do the trick.

> > + =A0 =A0 =A0 # if so desired omit non tgish deps
> > + =A0 =A0 =A0 [ -z "$tgish_deps_only" ] || [ -n "$_dep_is_tgish" ] =
|| return 0
I've always problems to understand these constructs.  Are these any
better than

	if test ...; then
		return 0
	fi

?  And I think it's more readable to use

	tgish_deps_only=3Dfalse

	...
		--tgish-only)
			tgish_deps_only=3Dtrue;;

	...

	if $tgish_deps_only; then

		...

	fi

=2E  (OK, I have to admit, that these constructs are used everywhere in
topgit, but I'm not happy with these either.)


> > + =A0 =A0 =A0 echo "$_dep"
> > + =A0 =A0 =A0 local base=3D"top-bases/$_dep"
> > + =A0 =A0 =A0 if ref_exists "$base"; then
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "top-bases/$_dep"
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "warning, no base found $base" 1=
>&2
> > + =A0 =A0 =A0 fi
mmh, I wonder why you need to do the top-bases explicitly.  recurse_dep=
s
doesn't that for you?

> > +}
> > +
> > +for remote in $remotes; do
> > + =A0 =A0 =A0 list=3D"$(
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 # deps
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ -n "$recurse_deps" ]; then
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 recurse_deps push_bra=
nch "$name"
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 # current branch
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _dep=3D"$name"
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _dep_is_tgish=3D1
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 push_branch "$name"
> > + =A0 =A0 =A0 )"
> > + =A0 =A0 =A0 echo "pushing:"; echo $list
> > + =A0 =A0 =A0 if [ -n "$dry_run" ]; then
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo git push $remote $list
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git push $remote $list
> > + =A0 =A0 =A0 fi
> why not pass the --dry-run option to git remote?
s/remote/push/
=20
Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
