From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: Re: [PATCH] submodule : Add --no-separate-git-dir option to add
 and update command.
Date: Tue, 11 Mar 2014 23:07:51 +0100
Message-ID: <1394575671.7891.65.camel@Naugrim>
References: <53176951.7000201@web.de> <1394069128.7891.29.camel@Naugrim>
	 <5318D101.9050305@web.de> <1394136925.7891.31.camel@Naugrim>
	 <5318DFDD.4060006@web.de> <1394144428.7891.33.camel@Naugrim>
	 <531A4FA3.3040007@web.de> <1394442486.7891.45.camel@Naugrim>
	 <20140310203245.GB5345@sandbox-ub> <1394531703.7891.54.camel@Naugrim>
	 <20140311201110.GB4833@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tvjlXDYvvzStD/mcc9ve"
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 23:08:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNUqD-0003vU-92
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 23:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbaCKWH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 18:07:59 -0400
Received: from smtpout7.laposte.net ([193.253.67.232]:50083 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561AbaCKWH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 18:07:58 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8514-out with ME
	id cN7r1n0022iaXuy03N7rL1; Tue, 11 Mar 2014 23:07:53 +0100
In-Reply-To: <20140311201110.GB4833@sandbox-ub>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243906>


--=-tvjlXDYvvzStD/mcc9ve
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 11 mars 2014 =C3=A0 21:11 +0100, Heiko Voigt a =C3=A9crit :
> On Tue, Mar 11, 2014 at 10:55:03AM +0100, Henri GEIST wrote:
> > Le lundi 10 mars 2014 =C3=A0 21:32 +0100, Heiko Voigt a =C3=A9crit :
> > > On Mon, Mar 10, 2014 at 10:08:06AM +0100, Henri GEIST wrote:
> > > > Le samedi 08 mars 2014 =C3=A0 00:00 +0100, Jens Lehmann a =C3=A9cri=
t :
> > > > > Am 06.03.2014 23:20, schrieb Henri GEIST:
> > > > > >> What is the use case you are trying to solve and why can that
> > > > > >> not be handled by adding "subsubmodule" inside "submodule"?
> > > > > >=20
> > > > > > The problem is access rights.
> > > > > >=20
> > > > > > Imagine you have 2 people Pierre and Paul.
> > > > > > Each with different access write on the server.
> > > > > > Pierre has full access on every things.
> > > > > > Paul has full access on superproject and subsubmodule but no re=
ad/write
> > > > > > access to submodule only execution on the directory.
> > > > >=20
> > > > > Ok, I think I'm slowly beginning to understand your setup.
> > > > >=20
> > > > > > I want all user to get every things they are allowed to have wi=
th the
> > > > > > command 'git submodule update --init --recursive'.
> > > > > > Then as Paul can not clone submodule he can not get subsubmodul=
e
> > > > > > recursively through it.
> > > > >=20
> > > > > Sure, that's how it should work. Paul could only work on a branch
> > > > > where "submodule" is an empty directory containing "subsubmodule"=
,
> > > > > as he doesn't have the rights to clone "submodule".
> > > >=20
> > > > I will not redundantly create a branch for each user on the server.
> > > > When users clone the server it already create a special branch for =
them
> > > > 'master' which track 'origin/master'. And if each user have its own=
 branch
> > > > on the server it will completely defeat the goal of the server "col=
laboration".
> > > > And transform the git server in simple rsync server.
> > >=20
> > > I do not think that is what Jens was suggesting. It does not matter i=
n
> > > which branch they work, they can directly use master if you like. Wha=
t
> > > he was suggesting is that they create their repository structure like
> > > this:
> > >=20
> > > git clone git@somewhere.net:superproject.git
> > > cd superproject/submodule
> > > git clone git@somehwere.net:subsubmodule.git
> > > cd subsubmodule
> > > ... work, commit, work, commit ...
> > >=20
> > > The same applies for the superproject. Now only someone with access t=
o
> > > the submodule has to update the registered sha1 once the work is push=
ed
> > > to submodule.
> >=20
> > I am not sure to understand everything.
> > But if you suggest to clone manually subsubmodule because it could
> > not be clone recursively by submodule due to the lake of access write
> > to get submodule.
> >=20
> > It is not practical in my use cases.
> > Two of the superprojects I have in charge contains hundreds of submodul=
es
> > or subsubmodules and I have too much users with disparate computer skil=
ls.
> >=20
> > Getting all what a user has access on should be just a recursive clone.
>=20
> Then I would think about getting rid of the recursion part as it seems
> you have interdependencies which can only be solved by a package
> management system. I would see the superproject as this package
> management system, but it requires you to have all the submodules next
> to each other instead of contained in each other.
>

You put the finger on a key point.

I use the submodule system exactly as a package management system.
It is even the only use I have of it. I am not able to imagine another use.
(My imagination is limited).
I really use 'git clone --recursive' as 'apt-get install'.
And I am pretty sure you also.

And in fact for the case where the submodules/packages should be side by
side, I have a third patch witch enable just this by enabling '../' to be
part of a gitlink.
Much of my submodules/packages make use of this feature but I also have the
case where the dependency make them contained in each others.
=20
> I think in terms of combining libraries that is actually the correct
> solution because there can be modules that need each other. Some
> submodule A might evolve and add a dependency to a subsubmodule B that
> is itself contained in another submodule C. Then it just does not feel
> correct anymore that B is contained in C. You want to have one instance
> that is in charge of all the dependencies, that is IMO directly the
> superproject and not something that reaches through another submodule
> to record a dependency to a subsubmodule.

Right.
But each module need to know by its own gitlinks which are its
dependency to be able to track version compatibility and not rely on
an hypothetic superproject which may or may not do it as a submodule
do not even know if it is part of a superproject.
And could be include in totally different superprojects.

>=20
> > > > > > And I need superproject to add also submodule/subsubmodule.
> > > > >=20
> > > > > No. Never let the same file/directory be tracked by two git
> > > > > repositories at the same time. Give Paul a branch to work on
> > > > > where "submodule" is just an empty directory, and everything
> > > > > will be fine. Or move "subsubmodule" outside of "submodule"
> > > > > (and let a symbolic link point to the new location if the
> > > > > path cannot be easily changed). Would that work for you?
> > > >=20
> > > > If I use symbolic links it will just as gitlink enable to use the
> > > > same subsubmodule clone by more than one superproject but with two
> > > > major problems :
> > > >   - symbolic links do not work under Windows and some of my users d=
o
> > > >     not even know something else could exist.
> > > >   - symbolic links will not store the SHA-1 of the subsubmodule.
> > > >     And a 'git status' in the repository containing the symbolic li=
nk
> > > >     will say nothing about subsubmodule state.
> > >=20
> > > Here you are also missing something. What Jens was suggesting was tha=
t
> > > you move your subsubmodule directly underneath the superproject and f=
rom
> > > the old location you create a link to the new location for a quick
> > > transition. But you can also change all paths in your project to poin=
t
> > > to the new location. But in the new location you will have subsubmodu=
le
> > > registered as a submodule only that it is now directly linked (as
> > > submodule) from the superproject instead of the submodule.
> > >=20
> >=20
> > Ok but in this case what happen to someone cloning only submodule but
> > not superproject ? He will not get subsubmodule which is part of it.
> > Just a dead symbolic link with no hint on what is missing behind.
> >=20
> > Each of my submodules (at any level) should be usable superprojects by
> > them self having a gitlink to each subsubmodules they needs.
>=20
> Then you will end up duplicating many submodules if everything should
> contain everything it needs. Think about the example I described above.
> In case of libraries, that will become a management nightmare.
>=20

As stated above in this case my other patch enable me to put the submodules
sides by sides and address this issue. Then I have no duplication.

> > > > I think where we diverge is in the way we are looking gitlinks.
> > > > Where you see a hierarchic tree, I see a web.
> > > > And I use gitlinks just like multiplatform symbolic links storing
> > > > the SHA-1 of there destination and pointing exclusively on git repo=
sitories.
> > >=20
> > > Well but the problem with a web is that it will introduce a lot of
> > > problems that need to be solved. Some repository has to have the
> > > authority about a file (or link). If you have a file in multiple
> > > repositories overlayed how do you know who is in charge and when?
> > >=20
> >=20
> > It will not introduce a lot of problems.
> > Me and my teams are using gitlinks this way every days for 2 years know=
.
> > With a web far more complex than the example I give above.
> > And the problem you are speaking about and which we solve with the
> > --no-separate-git-dir option is the only one we encounter until now.
> >=20
> > This solve the question of who is in charge ? and when ?
> > subsubmodule is in charge of itself. Always.
> >=20
> > I know there is some good reasons for the separate gitdir.
> > But none of them bother me in my day to day use.
> > That is why I came with this simple solution
> >=20
> > Another solution to combine all advantages.
> > Is deciding to always make superproject in charge and place a link
> > $SUBMODULE_GIT_DIR/modules/link_to_subsubmodule_gitdir
> > pointing to $SUPERPROJECT_GIT_DIR/modules/submodule/subsubmodule.
> >=20
> > I think I can write a 3 step patch doing just that :
> >=20
> >   1) A little change in the $GIT_DIR/modules layout making the
> > $SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/.git inste=
ad of
> > $SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule
> >=20
> > Then it will be possible to have
> > $SUBSUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/subsubm=
odule/.git
> > and so on without risk of name collision in case subsubmodule have a na=
me like
> > 'branches', 'hooks', 'refs' or anything like that.
> >=20
> >   2) Making submodules aware that they have been cloned has submodule a=
nd
> > where is at least one of their superproject that is the non trivial par=
t.
> > Maybe choosing the one which actually clone it.
> > Another solution is to simply found it by the fact the $SUBMODULE_GIT_D=
IR
> > is supposed to be in the $SUPERPROJECT_GIT_DIR.
> >=20
> >   3) Making 'git submodule <add|update>' search recursively through its
> > superprojects or directly for the top one and place adequately its own
> > $SUBSUBMODULE_GIT_DIR.
> >=20
> >=20
> > > There is a reason why it is designed like this: simplicity. I current=
ly
> > > do not see how your web idea can be simple without introducing a lot =
of
> > > user interface questions.
> > >=20
> >=20
> > Working with the web idea for several time now I can ensure you that
> > Git is so well designed that it is ready to use with this concept.
> > I have no user interface problem except the one we are speaking about.
>=20
> If you have multiple superprojects for a submodule in which superproject
> do you commit a change on a gitlink?

Each superproject impacted by the changes.
But only when I need it to be updated.

>=20
> Don't you end up having a lot of commits if you have to commit in
> multiple superprojects?
>=20

I have only commit in project which have a real change which conceptually
need a commit.
A careful design of projects modularization and dependency will not
lead to unneeded commits. But if you create unneeded dependency between
your submodules you can have a lot of meaningless commit.
It is only a project design problem not a Git problem.

But in counterpart it add some capital value (at least to my eyes),
traceability of the dependency between submodules/packages through their SH=
A-1.

> Suppose you have a directory layout like this:
>=20
> super\
>    submoduleA\
>    	submoduleB
>=20
> What happens if submoduleA has no knowledge about submoduleB but super
> decides to track it? Then on one point submoduleA decides to put files
> into the directory named 'submoduleB'. What happens?
>=20

It is a general design question not a Git question.
If super have put a submoduleB in the submoduleA directory it is intentiona=
l
and should be sound in your design.
And as designer I see no good reason to place submoduleB in a submoduleA al=
ready containing
a submoduleA directory or track file in submoduleB by submoduleA.
And in fact Git prevent this.
My patch only enable it for gitlinks.

But maybe you have in mind a case where the maintainer of super will do thi=
s
for a good reason in this case I can enable it.

> Just a few questions that immediately pop into my mind.
>=20
> Cheers Heiko



--=-tvjlXDYvvzStD/mcc9ve
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMfiTcACgkQkKuHPdwEGdR7KQD/Weu5ovOmXRnynojYM9ffJy/0
ClhA0OGN7oHDATQ4JncA/36Qq8cRR0H5ob9S6gdWhLZiHV0XE9tmcggJj0eLuB9z
=n+GO
-----END PGP SIGNATURE-----

--=-tvjlXDYvvzStD/mcc9ve--
