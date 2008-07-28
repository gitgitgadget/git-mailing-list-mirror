From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 00:03:08 +0200
Message-ID: <20080728220308.GF10409@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+ts6NCQ4mrNQIV8p";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 00:04:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNapa-00042H-TN
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 00:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbYG1WDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbYG1WDO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 18:03:14 -0400
Received: from pan.madism.org ([88.191.52.104]:60633 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756383AbYG1WDM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 18:03:12 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C5CF53BDC2;
	Tue, 29 Jul 2008 00:03:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B49C158D7D1; Tue, 29 Jul 2008 00:03:08 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90512>


--+ts6NCQ4mrNQIV8p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 09:40:22PM +0000, Avery Pennarun wrote:
> On 7/28/08, Pierre Habouzit <madcoder@debian.org> wrote:
> > On Mon, Jul 28, 2008 at 08:55:45PM +0000, Pierre Habouzit wrote:
> > >   That too indeed (the "easier to clone" bit). OTOH, I don't like the
> >  > .git/submodules idea a lot, if you mean to put a usual $GIT_DIR layo=
ut
> >  > inside of it. With what I propose, you find objects for all your
> >  > super/sub-modules in the usual store, which eases many things.
> >  > Especially, I believe that when you replace a subdirectory of a proj=
ect
> >  > with a submodule, git-blame could benefit quite a lot from this to be
> >  > able to glue history back through the submodule limits, without havi=
ng
> >  > to refactor a _lot_ of code: it would merely have to dereference so
> >  > called "gitlinks" to the commit then tree, hence twice, and just do =
its
> >  > usual work, with your proposal, we still rely on having to recurse in
> >  > subdirectories which requires more boilerplate code.
> >
> >   And of _course_ this is also true for git-log, which is like 10x as
> >  important for me (like I don't remember if I used git-blame this year,
> >  whereas I used git-log in the last 10 minutes ;p)
>=20
> I don't think you're going to get away with *not* having a separate
> ..git directory for each submodule.  You'll just plain lose almost all
> the features of submodules if you try to do that.
>=20
> Most importantly in my case, my submodules (libraries shared between
> apps) have a very different branching structure than my supermodules.
> It wouldn't be particularly meaningful to force them to use the same
> branch names.

Why not ? We're talking local branches, that can track whatever you like
on the remote side. Of course, the globing refspec are probably going to
be too simple for you if your branching scheme is _that_ different, but
if you can deal with that by hand _now_, I can't see why writing the
adequate tracking maps by hand would be any harder.

> Further, if you don't have a separate .git directory for each
> submodule, you can't *switch* branches on the submodule independently
> of the supermodule in any obvious way.

Yes you can, in what I propose you have a dummy .git in each submodule,
with probably an index, a HEAD and a config file (maybe some other
things along) to allow that especially.

> This is also useful; I might want to test updating to the latest
> master of my submodule, see if it still works with my supermodule, and
> if so, commit the new gitlink in the supermodule.  This is a very
> common workflow for me.

I agree.

> It's unfortunate that submodules involve a commit->tree->commit link
> structure.

Actually it's not a big problem, you just have to "dereference" twice
instead of one, and be prepared to the fact that the second dereference
may fail (because you miss some objects). I instead believe that
gitlinks are a good idea.

> > One irritating problem with submodules, is
> > that when someone else commited, and that you git submodule update,
> > you're on a detached head. Absolutely horrible.
>=20
> I think that roughly everyone agrees with the above statement by now.
> It would also be trivial to fix it, if only we knew what "fix" means.
> So far, I haven't seen any good suggestions for what branch name to
> use automatically in a submodule, and believe me, I've been looking
> for one :)

Well, using the same as the supermodule is probably the less confusing
way. Of course, not being in the "same" branch as the supermodule would
clearly be a case of your tree being "dirty", and it would prevent a
"git checkout" to work in the very same way that git checkout doesn't
work if you have locally modified files.

If your submodule branching layout uses the same names as the
supermodule branches then yes, it's going to hurt, but I believe it to
be unlikely (else you would become insane just trying to remember what
you are doing ;p). So even if say your work in `master` in your
supermodule, but for some reason use what is on the remote
`release/10.2` branch for a given submodule, nothing prevents you to
have a local `master` branch in that submodule as well that tracks
`release/10.2`. It's actually a quite sensible thing to do I believe.

It doesn't prevent you from switching your submodule to the `devel`
branch to perform some tests, or even make it the new state of the
submodule inside your supermodule. This operation would just then move
what is `master` in your submodule to track `devel` instead of
`release/10.2`[0].

I fail to see which current submodules features you would lose with this
scheme. In fact, said differently, I more or less propose that when you
commit your supermodule state (providing some checks hold see [0]) it
updates the 'associated' branch in the submodule. The goal here, is that
you're always on a branch, set up to track a given remote branch, that
we can check against so that we can:

  (1) avoid the usual caveats of git-submodules (one can check when
      pushing the supermodule that all submodules are indeed pushed in
      the remote branch they track);

  (2) user can commit and don't bother resetting branches and doing
      tricks to be "on branch again".

I don't think it prevents you from e.g. having topic branches in your
submodules, provided that before commiting a new submodule change, you
somehow merge those in the "matching" branch that was set up for you.



  [0] of course we probably want to refuse such a thing if `devel` isn't
      a fast-forward from release/10.2. But that's not the point of the
      explanation so I skipped this bit for clarity of my point.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+ts6NCQ4mrNQIV8p
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiOQhwACgkQvGr7W6HudhwwUwCgqfL4yTtMYX3nGLbQIVcwDcHj
NSUAn1of/WDp+e08ciXr7dYII6RbLsYh
=gwiJ
-----END PGP SIGNATURE-----

--+ts6NCQ4mrNQIV8p--
