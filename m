From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 13:57:40 +0200
Message-ID: <20091021115740.GA25049@atjola.homenet>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
 <alpine.LNX.2.00.0910202310070.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 13:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0ZpA-0001rG-Nx
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 13:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbZJUL5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 07:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZJUL5m
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 07:57:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:59574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753395AbZJUL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 07:57:41 -0400
Received: (qmail invoked by alias); 21 Oct 2009 11:57:43 -0000
Received: from i59F54FFE.versanet.de (EHLO atjola.homenet) [89.245.79.254]
  by mail.gmx.net (mp015) with SMTP; 21 Oct 2009 13:57:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18QUsM8wlUQijLE6AHCo6UOLR8wQFzl31YLMnXi32
	wjfzXtBnbZ9fQ3
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910202310070.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130905>

On 2009.10.21 00:22:18 -0400, Daniel Barkalow wrote:
> On Wed, 21 Oct 2009, Bj=F6rn Steinbrink wrote:
>=20
> > 3) User expects "pull" to update all branch heads that have a confi=
gured
> > upstream
> >=20
> > 08:31 	dimsuz 	hi guys! suppose i'm currently on master. then run g=
it
> > 		fetch. which delivers updates to master and other
> > 		branches. I don't merge anything, but do checkout some
> > 		branch (which is not master).  Question: will these new
> > 		updates get into this branch automatically after i check
> > 		it out? question2: will branch master contain those
> > 		updates when i ckeck it out later?
> > 08:32 	Circuitsoft 	dimsuz. After a fetch, no.
> > 08:33 	Circuitsoft 	However, if you pull, any branches that were se=
t
> > 			up as local tracking branches will get updated.
> > 08:33 	Circuitsoft 	Otherwise, only remote tracking branches will b=
e
> > 			updated.
> >=20
> > http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-20#l96=
9
> > (No idea about that one, have seen that once before, but it's defin=
itely
> > not even remotely as common as the others)
>=20
> I'd guess that's due to having local branches with no local changes, =
just=20
> to avoid detached HEAD, and therefore thinking it's normal to have a =
bunch=20
> of local branches that could be updated without merges. But I'm on a =
crazy=20
> "everybody really wants detached HEAD and is needlessly scared" kick,=
 and=20
> I'm probably reading too much into it.

Just to clarify: I didn't mean the question (which I didn't really
understand) in this case, but the answer from Circuitsoft (second to
last line). But maybe you also meant that? The question confuses me
enough not to be able to follow.


> > 4) User expects "pull" to create branches
> >=20
> > 07:25 	fynn 	Hey, I just pulled a branch from remote, and I don't s=
ee
> > 		it in "git branch"
> > 07:25 	doener 	fynn: if you "pull" that means "fetch this and merge=
 it
> > 		to what I have checked out"
> > 07:25 	fynn 	doener: hm, I just did "git pull" and it showed the ne=
w
> > 		branch
> > 07:26 	fynn 	but I don't see it in my branches...
> > 07:26 	fynn 	doener: should I create that branch as a tracking bran=
ch
> > 		first?
> > 07:26 	doener 	fynn: you're looking at "git branch -r" or "git bran=
ch
> > 		-a", right?
> > 07:26 	fynn 	doener: yeah, I'm seeing it in origin/foo, but not
> > 		local.
> > 07:26 	doener 	fynn: the "git fetch" should have created a remote
> > 		tracking branch, as usual, not a local branch head
> > 		(which would be shown by just "git branch")
> > 07:27 	fynn 	doener: OK, what should I do to create it locally then=
?
> > 07:28 	doener 	fynn: just the usual "git branch foo origin/foo", or=
 to
> > 		checkout at the same time: "git checkout -b foo
> > 		origin/foo" or "git checkout -t origin/foo" (shortcut)
> >=20
> > http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-19#l83=
0
> > (Note how my "fetch this and merge it" is actually inaccurate for j=
ust
> > "git pull", there is no "this" and that case. I took "pulled a bran=
ch"
> > to mean that he did "git pull <remote> <branch>", which wouldn't ha=
ve
> > created/update the remote tracking branch [or did patches for that =
go
> > in? I lost track...])
>=20
> That sounds like a real converse of "push", including creating like-n=
amed=20
> local branches. Or, perhaps, this is someone expecting that "pull" is=
 like=20
> "clone" in creating an initial local branch with the name and value o=
f a=20
> specified remote branch.

Reading that one again, I realize that I've still been confused by the
"pulled a branch". What happened was that the user did "git pull", whic=
h
ran "git fetch <remote>", which fetched a new branch head and has shown
that. At that point, the user (and me) got confused for maybe two reaso=
ns:

a) He didn't clearly distinguish between the fetch and the merge part.
The new branch wasn't pulled, but just fetched. That caused the user to
think that he "pulled the branch" (wrong terminology), which in term
confused me (wrong use-case assumed).

b) He expected local branch heads to be created, instead of remote
tracking branches. If my memory doesn't play tricks on me, that's
actually not to be expected from that specific user (I think we told hi=
m
about remote tracking branches before, and the last part of the
conversation actually suggests that, too). If I don't forget, I'll try
to get feedback from him the next time he's around.


> > 5) User possibly expecting "pull" to be able to act as "reset --har=
d"
> >=20
> > 21:01 	aidan 	What do I do about this: html/config/core.php: needs
> > 		update
> > 21:02 	aidan 	git pull (gives that)
> > 21:02 	Ilari 	aidan: You have uncommitted changes to that file...
> > 21:15 	aidan 	Ilari: how can I just pull master and overwrite any
> > 		changes?
> >=20
> > http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-18#l21=
30
> > (I'm not sure about that one, "overwrite any changes" might mean "d=
rop
> > uncommitted changes and merge" or "just get me the remote's state,
> > dropping my commits and uncommitted changes". Most of the time I've=
 seen
> > similar requests, the user wanted the latter).
>=20
> So I think that's a desire for "git checkout ." first of all (with th=
e=20
> assumption that the content without modifications has to come from=20
> somewhere remote). I don't know what's up with people not wanting to =
save=20
> their commits, though.

You haven't seen the multitude of "I have merge conflicts and just want
to take theirs/mine" requests. That often gets more weird than just
"drop my commits" ;-)

> > 6) User says "pull" but probably means "fetch"
> >=20
> > 14:08 	Alien_Freak 	once I have a clone of a repo I know you can do
> > 			a checkout tag but is there anyway to pull just
> > 			the tag?
> >=20
> > http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-16#l16=
64
> > (There was no answer, thus it's hard to tell, but I guess he wanted
> > something like:
> > git init; git fetch --no-tags url tag <tag>; git checkout <tag>
> > At least I'm quite sure he didn't mean "pull" as in "git pull")
>=20
> I don't know; you can actually do:
>=20
> $ git init; git pull --no-tags <url> tag <tag>
>=20
> It updates the master branch and working directory from (nothing) to =
the=20
> fetched tag.

Hm, yeah, that works (didn't think of it), but it's a rather special
case. Teaching that might lead to misunderstandings about what "pull"
does, I think. It would look somewhat like "fetch + reset --hard".

> > 8) "reset --hard" again
> >=20
> > 20:10 	roger_padactor 	i commited then did a pull how do i get back=
 to
> > 			my commit. the pull over wrote the files
> > 20:11 	merlin83 	roger_padactor: you can't, pull =3D=3D fetch + har=
d
> > 			reset to latest commit
> >=20
> > http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-14#l23=
06
> > (Someone being told that pull is fetch + reset --hard is actually n=
ew to
> > me. Only saw that as an expectation previously.)
>=20
> That's odd. How could you not notice that it doesn't actually do that=
,=20
> even if you try to get it to?

Hm? roger_padactor noticed that "pull" changed his files and wants to g=
o
back. And merlin83 says that that is impossible because pull supposedly
does reset --hard. There's nothing in there (I could see) that suggests
that anyone tried to make "pull" do "reset --hard".

merlin83 basically made three mistakes, I think:
1) Assume that roger_padactor was talking about uncommitted changes
2) Assume that pull is fetch + reset --hard
3) Assume that you can't undo a reset --hard for committed changes

(OK, 3) isn't actually valid when you consider 1), but 1) is so invalid
that I kept 3). After all, "pull" would complain about a dirty tree...)


> Actually, I wonder if the right formula is update =3D fetch + checkou=
t.=20
> There are a lot of people (IMHO) want "git fetch origin; git checkout=
=20
> origin/master", and I think their first idea is "git update", but tha=
t=20
> doesn't exist, and they find "pull" as the closest thing.

That has a precondition that the user is already using a detached HEAD.
Otherwise that fetch + checkout would likely mean that the get baffled
when they do:
git checkout master
git update
git checkout foo
git checkout master

Seeing that "master" is out of date "again".

I agree though, that users might look for "git update" and because it i=
s
missing, they just look for the closest thing. Adding Junio's statement
that users seem to want recipes instead of flexibility (and seeing
"update" as just "get me new stuff from upstream" without meaning any
specific method of updating), I think that "git update" could be a "rec=
ipe
collection" tool. I'll hack that into my proof-of-concept thing (which
I hope to have ready for a RFC next week).

Bj=F6rn
