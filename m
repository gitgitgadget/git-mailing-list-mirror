From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 2/2] Fix t3404 assumption that `wc -l` does not use
	whitespace.
Date: Mon, 28 Apr 2008 18:30:03 +0200
Message-ID: <20080428163003.GA6449@alea.gnuu.de>
References: <20080427151610.GB57955@Hermes.local> <alpine.DEB.1.00.0804271620440.16320@eeepc-johanness> <7vej8rgq62.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281112500.2949@eeepc-johanness> <slrng1bdsf.25r.joerg@alea.gnuu.de> <alpine.DEB.1.00.0804281409030.5399@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:48:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWWA-0001PC-J6
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbYD1QrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936155AbYD1QrJ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:47:09 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1427 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935981AbYD1QrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:47:01 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 2B8F6488069; Mon, 28 Apr 2008 18:47:00 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JqWEu-0004HX-Od; Mon, 28 Apr 2008 18:30:04 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JqWEt-0003ra-RM; Mon, 28 Apr 2008 18:30:03 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804281409030.5399@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80563>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Johannes Schindelin schrieb am Mon 28. Apr, 14:42 (+0100):
> On Mon, 28 Apr 2008, J=C3=B6rg Sommer wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Sun, 27 Apr 2008, Junio C Hamano wrote:
> > >
> > >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >>=20
> > >> > ...  It did not help that I hated the fact that that series change=
d=20
> > >> > the original design without even understanding it.
> > >>=20
> > >> Care to elaborate on this point further?  I do not get it.
> > >
> > > The original implementation of -p was modeled closely after=20
> > > filter-branch, in that it created a subdirectory (dotest/rewritten)=
=20
> > > containing the new commit names for those commits that were rewritten.
> >=20
> > But that wasn't the way rebase -i works.
>=20
> I know exactly how it works. D'oh.
>=20
> > You had to jump in before pick_one does anything which clearly shows yo=
u=20
> > did something different from the default way.
>=20
> That is bullshit.  I did not do anything "different from the default way"=
=2E =20
> I carefully designed an interface that was easy to understand, because it=
=20
> mimicked how you would do the same _by hand_, but without the hassle to=
=20
> actually having to do everything by hand.
>=20
> In other words, rebase -i is just a cherry-pick in a loop.

But not rebase -i -p.

> And _exactly_ the same should have been done for -p.

But you didn't do it.

> Namely, _not_ introduce some artificial marks, but use the _commit
> names_!

I don't buy, you don't use marks (notes on paper or git tags) when you reba=
se
a branch with at least 8 commits and 2 merges.

And Junio discribed how he would do such a rebase and it included marks.
And I follow how. So no, they aren't artificial.

> > > Now, whenever a commit was picked, the parents would be looked up in=
=20
> > > dotest/rewritten, and replaced with the rewritten name (or left=20
> > > unchanged if they were not rewritten).
> >=20
> > This approach doesn't work when you change the order of commits.
> > Take the commit A, B and C in this order and reorder them to A C B:
> > 1. pick A, A^ was not rewritten, nothing changed, A stays the same
> > 2. pick C, C^ was not rewritten, nothing changed, C stays the same
> > 3. pick B, B^ was not rewritten, nothing changed, B stays the same
>=20
> You carefully ignored how I intended the parents to be used: only for=20
> merges.

And why does this test fail? Please tell me, as you =E2=80=9Cknow exactly h=
ow it
works.=E2=80=9D

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 9cf873f..83c2964 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -361,4 +361,10 @@ test_expect_success 'rebase with a file named HEAD in =
worktree' '
=20
 '
=20
+test_expect_success 'rebase with a file named HEAD in worktree' '
+       head=3D$(git rev-parse HEAD) &&
+       FAKE_LINES=3D"1 3 2" git rebase -i -p HEAD~3 &&
+       test $(git rev-parse HEAD) !=3D $head
+'
+
 test_done

* FAIL 25: rebase with a file named HEAD in worktree

                head=3D$(git rev-parse HEAD) &&
                FAKE_LINES=3D"1 3 2" git rebase -i -p HEAD~3 &&
                test $(git rev-parse HEAD) !=3D $head

> > > Basically, the output of rebase -i -p is ugly now, because you have=
=20
> > > _two_ ways of specifying things,
> >=20
> > > I have the feeling that I have to repeat my point again, so that it i=
s not=20
> > > ignored -- again.  Maybe an example would help:
> > >
> > > -- snip --
> > > pick abcdefg This is the first commit to be picked
> > > reset cdefghij
> > > pick zyxwvux A commit in a side-branch
> > > merge recursive abcdefg

Where do you tell which merge should be redone?

> > > -- snap --
> > >
> > > I am convinced that this syntax does not need much explanation.
> >=20
> > But above you said this syntax + mark is =E2=80=9Cugly=E2=80=9D. Strang=
e.
>=20
> You know, I find it strange how you try to make a _point_ in=20
> misunderstanding me.  Did I not mention that the way to have _two_ ways t=
o=20
> reference commits was ugly?  You did not even bother to remove that part=
=20
> from what you quoted.

Because Junio told you about it. And I don't find your suggestion in
<alpine.DEB.1.00.0804141506270.28504@racer> very readable:

| I would like it much better, if there was something like
|
| pick 5cc8f37 (init: show "Reinit" message even in ...)
| pick 18d077c (quiltimport: fix misquoting of parse...)
| merge 9876543:5cc8f37,18d077c (Merge blub)
        ^^^^^^^^^^^^^^^
| reset 5cc8f37
| ...

I don't see why you complain about the marks and suggest to use
9876543:5cc8f37,18d077c. In a short example like yours it doesn't hurd,
but put 10 line between the merge an the pick and maybe change move one
of the merged commits behind the merge.

pick 8a785dc Add tests to catch problems with un-unlinkable symlinks
pick 8d14ac9 Test: catch if trash cannot be removed
pick 29dc133 git-merge-one-file: fix longstanding stupid thinko
pick deda26b Merge branch 'jc/makefile'
pick 7f8ab8d Don't update unchanged merge entries
pick 198724a fast-import: Allow "reset" to delete a new branch without error
pick 20fd60b t1000: use "test_must_fail git frotz", not "! git frotz"
pick 7092882 Update draft release notes for 1.5.5
pick c817faa Resurrect git-rerere to contrib/examples
pick 1eaa541 Merge branch 'maint'
pick 81d6650 Start draft ReleaseNotes for 1.5.4.5
merge 9876543:81d6650,198724a (Merge blub)
pick e637122 rebase -m: do not trigger pre-commit verification

pick 8a785dc Add tests to catch problems with un-unlinkable symlinks
pick 8d14ac9 Test: catch if trash cannot be removed
pick 29dc133 git-merge-one-file: fix longstanding stupid thinko
pick deda26b Merge branch 'jc/makefile'
pick 7f8ab8d Don't update unchanged merge entries
pick 198724a fast-import: Allow "reset" to delete a new branch without error
mark #1
pick 20fd60b t1000: use "test_must_fail git frotz", not "! git frotz"
pick 7092882 Update draft release notes for 1.5.5
pick c817faa Resurrect git-rerere to contrib/examples
pick 1eaa541 Merge branch 'maint'
pick 81d6650 Start draft ReleaseNotes for 1.5.4.5
merge 9876543:81d6650,#1 (Merge blub)
pick e637122 rebase -m: do not trigger pre-commit verification

> > > A patch implementing a syntax like this would have won my unilateral=
=20
> > > approval
> >=20
> > I doubt this. You refused any changes to your idea and your code from=
=20
> > the beginning. You didn't answer questions and doesn't take part on the=
=20
> > discussion [1] about the new syntax.
>=20
> Well, you carefully ignored (but removed from the quoted text) my=20
> explanation.

Sorry no, Junio made his proposal on Mar 24 and merge the code on Apr 25.
I treat this as a adequate time window to propose a _better_ idea.

Bye, J=C3=B6rg.
--=20
=E2=80=9CUnfortunately, the current generation of mail programs do not have
 checkers to see if the sender knows what he is talking about=E2=80=9D
            (Andrew S. Tanenbaum)

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFfuLwe0mZwH1VIARAt2oAJ9U8nUB5o98WbM6RvhmjRd5N4BQLACgjleF
525p5wPJIyNAjk++aOgpYlE=
=4+Ab
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
