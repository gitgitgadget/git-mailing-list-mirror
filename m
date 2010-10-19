From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 17:53:34 -0400
Message-ID: <1287525214.11155.183.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 23:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8K85-0001pZ-2h
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 23:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab0JSVxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 17:53:49 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:52152 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab0JSVxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 17:53:47 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9JLrhvF007204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Oct 2010 17:53:43 -0400
In-Reply-To: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9JLrhvF007204
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288130024.0992@HHQW6zgTKB5+JiwQlB3kUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159369>


On Mon, 2010-10-18 at 22:45 +0200, Thore Husfeldt wrote:
> I=E2=80=99ve just learned Git. What a wonderful system, thanks for bu=
ilding
> it.=20
>=20
> And what an annoying learning experience.=20

I have to admit having dealt with quite a few annoyances, but mostly
because I'm attempting to implement new functionality into this
project--something that requires minimally groking the sections of code
that I propose to change. (Anything less is sheer idiocy--and this is a
crowd that would not hesitate to say so.)

> I promised myself to try to remember what made it all so hard, and to
> write it down in a comprehensive and possibly even constructive
> fashion. Here it is, for what it=E2=80=99s worth. Read it as the frie=
ndly, but
> somewhat exasparated suggestions of a newcomer. I=E2=80=99d love to h=
elp (in
> the form of submitting patches to the documentation or CLI responses)=
,
> but I=E2=80=99d like to test the waters first.
>=20
> So, in no particular order, here are the highlights of my former
> confusion, if only for your entertainment. Comments are welcome, in
> particular where my suggestions are born out of ignorance.

As a user and survivor of other source code management, collaboration,
and versioning systems (not to mention some OS/X Windows/uC/CPU innards=
)
I did not find git nearly as jolting as you appear to have. I suspect
this will be clear in following discussions.

> Remote (tracking) branches
> --------------------------
>=20
> There are at least two uses of the word *tracking* in Git's
> terminology.
>=20
> The first, used in the form =E2=80=9Cgit tracks a file=E2=80=9D (in t=
he sense that Git
> knows about the file) is harmless enough, and is handled under `git
> add` below.
>=20
> But the real monster is the *tracking branch*, sometimes called the
> remote branch, the remote-tracking branch, or the remote tracking
> branch. Boy did that ever confuse me. And, reading the git mailing
> list and the web, many others. There are so many things wrong with ho=
w
> this simple concept is obfuscated by the documentation that I have a
> hard time organising my thoughts about writing it down.
>=20
> Please, *please* fix this. It was the single most confusing and
> annoying part of learning Git.
>=20
> First, the word, =E2=80=9Ctracking=E2=80=9D. These branches don=E2=80=
=99t track or follow
> anything. They are standing completely still. Please believe me that
> when first you are led to believe that origin/master tracks a branch
> on the remote (like a hound tracks it quarry, or a radar tracks a
> flight) that it is very difficult to hunt this misunderstanding down:
> I believed for a long time that the tracking branch stayed in sync,
> automagically, with a synonymous branch at the remote. The CLI and
> documentation worked very hard to keep me in that state of
> ignorance. I *know* that my colleague just updated the remote
> repository, yet the remote branch (or is the remote tracking branch?
> or the remote-tracking branch?) is as it always was...? (How could I
> *ever* believe that? Well, *now* I get it, and have a difficult time
> recollecting that misunderstanding. *Now* it=E2=80=99s easy.)

Two things here:=20
(1) The meaning of "tracking" in context differs from your abstract
notion of tracking. Perhaps the metaphor is better seen as the
"tracking" of wild game animals--you follow their footprints, grazing
marks, paths, and scat (viewed with gitk ? ;-) ) yet only once in a
while can you reach out and "pull" on them (at least one doesn't have t=
o
shoot things to make git work--although it might help on some days).

(2) Hyphenation should, in theory, be consistent. I do not however
expect this to be completely automatic in a population of code authors
which contains a great deal of non-native speakers of English
(conceivably some people here may even read and write English without
feeling competent to speak it out loud). Due to this reality I usually
keep my inner "Grammar Nazi" in check with free/open software projects.
This does not make the documentation any easier to read, it just keeps
me from breaking things while I do.=20
As an aside, whose "English" are we to deem nominally correct--ASE, BSE=
,
ISE, or perhaps so-called "Singapore English" (which is actually spoken
other places as well)? Just because American Standard English currently
has (eroding) hegemony in the software documentation sphere (from my
perspective) does not grant me some special platform to shove it down
the throats of others. Thankfully clarification of hyphenation by
introducing consistency is likely to be universally received in a
positive light.

> Second, the word =E2=80=9Cremote=E2=80=9D as opposed to =E2=80=9Cloca=
l=E2=80=9D, a dichotomy enforced
> by both the documentation and by the output of `git branch -r` (list
> all remote branches, says user-manual.txt). Things began to dawn on m=
e
> only when I understood that origin/master is certainly and absolutely
> a =E2=80=9Clocal=E2=80=9D branch, in the sense that it points to a co=
mmit in my local
> repository. (It differs from my other local branches mainly in how it
> is updated. It=E2=80=99s not committed to, but fetched to. But both a=
re local,
> and the remote can be many commits ahead of me.)
>=20
> So, remote tracking branches are neither remote (they are *local*
> copies of how the remote once was) and they stand completely still
> until you tell them to =E2=80=9Cfetch=E2=80=9D. So remote means local=
, and tracking
> means still, =E2=80=9Clocal still-standing=E2=80=9D would be a less c=
onfusing term
> that =E2=80=9Cremote tracking=E2=80=9D. Lovely.

This is one area in which excessive steeping in the handling, care,
feeding, and management of other SCM systems would help understand what
git is up to.

The "origin/master" is seen semantically as a locally stashed but not
intended to be used directly "copy" of the origin's master--you create =
a
local branch for that--in your local object store. This apparent copy
can be thought of better perhaps as a pointer into the object store to
call upon the "origin/master" locally-stored state (origin's master as
your local object store remembers it). It can be used to follow changes
made to the remote--origin's--master (but one is not forced to do so).
Often times it may be found mirrored in (more correctly, merged into)
the local branch named "master"--which you created, most likely via
cloning. Therefore it can be confusing at some level--at first--to
realize that "origin/master" and "master" are not the same thing yet ma=
y
sure appear to be. Once you take the pointer for what it is this makes =
a
bit more sense. (This is why you can "git checkout origin/master" if yo=
u
want...)
Taking this metaphor one step further, we DE-REFERENCE and merge
"origin/master" into "master" (or whatever you named your
"remote-tracking" branch) as the last bulk operation when executing a
"pull" on master. This is explained fairly clearly (in my mind) in the
documentation as a convenience melding of a "git fetch"--origin's maste=
r
(remote) is copied into the local object store as "origin/master"--and =
a
"git merge origin/master" executed while checked-out as the local copy
of the branch you are tracking (you probably named it master).

> Tracking branches *track* in the sense that a stuffed Basset Hound
> tracks. Namely, not. It=E2=80=98s a dream of what once was.

YES!!! Ok, well, except for the stuffed part. Never have your dog
stuffed (ask Alan Alda, or read his book of the same name).

> The hyphenated *remote-tracking* is a lot better terminology already
> (and sometimes even used in the documentation), because at least it
> doesn't pretend to be a remote branch (`git branch -r`, of course,
> still does). So that single hyphen already does some good, and should
> be edited for consistency. (It did take time for me to convince mysel=
f
> during the learning process that =E2=80=9Cremote tracking=E2=80=9D an=
d
> =E2=80=9Cremote-tracking=E2=80=9D probably are the same thing, and =E2=
=80=9Ctracked remote=E2=80=9D
> something else, abandoning and resurrecting these hypetheses several
> times.)

This, I'm sure, can be rectified with minimum pain. Recall my note abov=
e
about non-native speakers. I don't expect them (or for that matter most
native speakers) to be in the habit of making use of English punctuatio=
n
tools that most American Language-Arts teachers don't seem to have
mastered either. Heck, I'll readily admit that I only got a 3 (of 5) on
the English Language AP Exam, so there are obviously some aspects of th=
e
"official" language known to the cognoscenti that I still don't grok
either.

> And *even if* the word was meaningful and consistenly spelt, the
> documentation uses it to *refer* to different things. Assume that we
> have the branches master, origin/master, and origin=E2=80=99s master
> (understanding that they exist, and are different, is another Aha!
> moment largely prevented by the documentation). For 50 points, which
> is the remote tracking branch? Or the remote-tracking branch?=20

Let's not make a big deal about the hyphen in that case for now.

> The remote branch?=20

That would be origin's branch (whatever it is named and whoever "origin=
"
is in this case).

> Which branch tracks which other branch?=20

Our local origin/<branch> is our local object store's memory of what it
last knew origin's branch to look like.

> Does master track anything?=20

Per-Se, No. Can it be merged with our latest fetch into the object stor=
e
of origin's (origin/...)? Yes. Can it be done with one nice convenient
wrapper command in the current git? Yes!

> Nobody seems to know, and documentation and CLI
> include various inconsistent suggestions. (I know there have been
> long, and inconclusive threads about this on the git mailing list, an=
d
> I learned a lot from seeing other people=E2=80=99s misconceptions mir=
ror my
> own.)  Granted, I think the term =E2=80=9Ctracked remote branch=E2=80=
=9D is used with
> laudable consistentcy to refer to a branch on the remote. And =E2=80=9C=
remote
> tracking branch=E2=80=9D (with our without the hyphen) more often tha=
n not
> refers to origin/master. It may be that terminology is slowly
> converging. (To something confusing, but still...)

Remember, remote branches other than "master" may be tracked. For
instance, if you are tracking git with git then you are also tracking
branches named html, todo, maint, man, pu, and next--yet you may not
have created a local remote-tracking branch for them to reside in
locally.

> But to appreciate how incredibly difficult this was to understand,
> check this, from the Git Community book:
>=20
>     A 'tracking branch' in Git is a local branch that is connected to
>     a remote branch.
>=20
> To a new user, who *almost* gets it, this is just a slap in the
> face. Which one of these is origin/master again? None? (Or rather, it
> is the confirmation one needs that nobody in the Git community cares
> much, so the once-believed-to-be-carefully-worded documentation loses
> some of its authority and therefore the learner can abandon some
> misunderstandings.)

Again, the author's sense of "connected" and your internal sense of
"connected" did not match--much like "tracking" earlier (and below). He
is not stating that they are bound at the hip, he is merely noting the
presence of a conceptual relationship between the two. It could have
been stated differently perhaps, but it is not the end of the world.

> There probably is a radical case to be made for abandoning the word
> =E2=80=9Ctracking=E2=80=9D entirely. First, because tracking branches=
 don=E2=80=99t track, and
> second because =E2=80=9Ctracking=E2=80=9D already means something els=
e in Git (see
> below). I realise that this terminology is now so ingrained in Git
> users that conservatism will probably perpetuate it. But it would be
> *very* helpful to think this through, and at least agree on who
> =E2=80=9Ctracks=E2=80=9D what. In the ideal world, origin/master woul=
d be something
> like =E2=80=9Cthe fetching branch=E2=80=9D for the origin=E2=80=99s m=
aster, or the =E2=80=9Csnapshot
> branch=E2=80=9D or the =E2=80=9Cfetched branch=E2=80=9D. (I am partia=
l to use =E2=80=9Cfetching=E2=80=9D
> because it makes that operation a first-class conceptual citizen,
> rather than pulling, which is another siren that lures newbies into a
> maelstroem of confusion.)

Umm, NO. Tracking is a term that is used consistently in most places. I=
t
means "following by collecting information about" as I noted earlier
with my wild game animals example. This is true throughout whether that
being tracked is a file's contents, an entire branch's contents, or the
contents of a whole repository. That you have mis-associated the concep=
t
of tracking with that of fetching the information used to perform that
tracking (and remembering from where and how to do so) is perhaps
something that can be dealt with but it does not require abandoning wha=
t
is frankly a useful metaphor. (Besides "fetching" in isolation begs
confusion with other concepts such as a "comely lass"--the great wonder
of the English language indeed.)

> More radically, I am sure some head scratching would be able to find
> useful terminology for master, origin/master, and origin=E2=80=99s ma=
ster. I=E2=80=99d
> love to see suggestions. As I said, I admire how wonderfully simple
> and clean this has been implemented, and the documentation, CLI, and
> terminology should reflect that.

I did not find the terminology particularly jarring, but I have used
(and survived doing so) other SCM software. Perhaps you did not have an=
y
previous SCM background? More information as to the source of confusion
and your perspective when starting out can only help improve the
documentation.

> The staging area
> ----------------
>=20
> The wonderful and central concept of staging area exists under at
> least three names in Git terminology. And that=E2=80=99s really, real=
ly
> annoying. The index, the cache, and the staging area are all the same=
,
> which is a huge revelation to a newcomer.

Not true. When merging the index may contain multiple staged instances
of any given content needed to resolve conflicts for instance. Also, th=
e
cache is stored inside of the index. Therefore while they may at any
given time have exactly the same contents they are not the same things
nor concepts.

> *Index* would have been a good word for the files known
> to Git (what is now called, sometimes, =E2=80=9Ctracked files=E2=80=9D=
)

Index is used to refer to the mechanism by which the currently operativ=
e
CONTENT known to git. Git does not track files per-se, it tracks
CONTENT. This is an important distinction to master. It literally
indexes the contents to be operated upon in the object store. That thos=
e
contents happen to exist in files is something it keeps track of but it
really could care less. So far is it is concerned they could be show
tunes.

> `git stage` is already part of the distribution. Great.
>=20
> 1. Search for index and cache in the documentation and rephrase any
> and all their occurences to use =E2=80=9Cstaged=E2=80=9D (or, if it c=
an=E2=80=99t be avoided
> =E2=80=9Cthe staging area=E2=80=9D) instead. Say =E2=80=9Cstaged to b=
e committed=E2=80=9D often, it=E2=80=99s
> a strong metaphor.

No. The documentation should not be made incorrect just to make it soun=
d
more consistent.

> 2. Introduce the alias `git unstage` for `git reset HEAD` in the
> standard distribution.

This is evidence to me that you have not used other SCM software. The
idiom "reset" is widely used in various SCM implementations.

> 3. Duplicate various occurences of `cached` flags as `staged` (and
> change the documentation and man pages accordingly), so as to have,
> e.g., `git diff --staged`.

Again, cached is not staged and flags should not be made incorrect just
to cover for the fact that you have not found a use for them separately=
=2E

> git status
> ----------
>=20
> One of the earliest-to-use commands is `git status`, whose message ar=
e
> *wordy*, but were initially completely unhelpful to me. In particular=
,
>=20
>    working directory clean
>=20
> Clean? What=E2=80=99s this now? Clean and dirty are Git slang, and no=
t what I
> want to meet as a new user.=20

This is not git-specific jargon. In fact, it is widely used terminology
throughout the computing world in memory management, databases,
filesystems, and even other SCM platforms. I have even heard it used by
non-computer-oriented people to refer to original and changed states.

> The message should inform me that the
> untracked files in the working directory are equal to their previous
> commit. But there are other things wrong with the message.=20

Actually, what it is stating is correct. It knows NOTHING about any
untracked files OTHER THAN that they have not changed since the last
commit. In other words, the POTENTIAL INDEX is clean of unwritten
changes.=20

> For
> example, even though there=E2=80=99s nothing to commit: `nothing adde=
d to
> commit but untracked files present (use "git add" to track)`? The las=
t
> paranethesis should set off warning bells already. And what did clean
> mean with respect to untracked files? And =E2=80=9Cadded to commmit=E2=
=80=9D? That
> sounds like amending. We add to the index or the staging area, don=E2=
=80=99t
> we, =E2=80=9Cready to be included in the next commit,=E2=80=9D so the=
y aren=E2=80=99t added to
> that commit quite yet?

This is analogous to files having been changed inside of an application
yet the application has not yet requested that such changes be schedule=
d
to be committed to the filesystem. You have to request that such change=
s
be added to the filesystem layer's idea of what needs to be committed
and then it will be written out in due time. The same thing applies to
git's index and the object store.

>=20
>     changed but not updated:
>=20
> I=E2=80=99m still not sure what =E2=80=9Cupdate=E2=80=9D was ever sup=
posed to mean in this
> sentence. I just edited the file, so it=E2=80=99s updated, for crying=
 out
> loud! The message might just say =E2=80=9CChanged files, but not stag=
ed to be
> committed.=E2=80=9D =20

In this case you have already scheduled some changes of a file to be
committed in the index and then have gone and made additional changes
without updating the index. So no, it isn't updated yet--but there are
changes staged to be committed for the very same files.

> The meant-to-be helpful =E2=80=9Cuse [...] to update what will be
> committed=E2=80=9D is another can of worms, and I can find at least t=
wo ways
> to completely misunderstand this. Change to =E2=80=9Cuse `git stage <=
file>` to
> stage=E2=80=9D. (With the new command name it=E2=80=99s almost superf=
luous.)

Here is where a proper discussion of why it is called "git add <file>"
comes into play. When you use the add operation you are literally addin=
g
he current status of that file to the index. If you make another change
to that file before committing you will need to add that new status of
the file. In other words, you have staged the changes to the content in
that file to be committed twice into the index at two different times
and with two different change-sets.

> Here are some concrete suggestions:
>=20
> 1.
>=20
>     nothing added to commit but untracked files present
>=20
> should be
>=20
>     nothing staged to commit, but untracked files present
>=20
> (Comment: maybe =E2=80=9C... but working directory contains untracked=
 files.=E2=80=9D
> I realise that =E2=80=9Cdirectory=E2=80=9D is not quite comprehensive=
 here, because
> files can reside in subdirectories. But I=E2=80=99d like to be more c=
oncrete
> than =E2=80=9Cbe present=E2=80=9D.)

The concept of "present" is fine in this case, just like being present
at a meeting. The comma is useful perhaps to some but may not be
grammatically correct here. As for "added" versus "staged" that depends
on the circumstances. I am having trouble coming up with an example off
the top of my head as to how to explain when "added" and "staged" diffe=
r
in meaning I am sure the do (perhaps upon the deletion of a tracked
file?).

> 2.
>     Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>=20
> should be
>=20
>     Untracked files:
>     (use "git track <file>" to track)

This is not helpful. Git does not work the way that Subversion does. In
other words, each content change must be manually added to the index fo=
r
staging to build a commit for each and every commit. Files and their
contents ARE NOT tracked perpetually (touching on earlier noted
confusion about the context-specific meaning of track). We should not
encourage confusion on this matter.

> 3.
>=20
>     Changes to be committed:
>     (use "git reset HEAD <file>..." to unstage)
>=20
> should be
>=20
>     Staged to be committed:		=20
>     (use "git unstage <file>" to unstage)

Again, "reset" is a widely used metaphor in SCM software and there is n=
o
good reason to abandon it. What you are proposing is not even a 1:1
replacement. The original command quite literally does the following
"reset index information about <file> to HEAD" while what you propose
merely says "remove staged change about <file> from the index." What if
<file> has been changed and staged to commit more than once? The
proposed syntax is ambiguous and therefore is a poor replacement.

> Adding
> ------
>=20
> The tutorial tells us that=20
>=20
>     Many revision control systems provide an add command that tells
>     the system to start tracking changes to a new file. Git's add
>     command does something simpler and more powerful: git add is used
>     both for new and newly modified files, and in both cases it takes
>     a snapshot of the given files and stages that content in the
>     index, ready for inclusion in the next commit.
>=20
> This is true, and once you grok how Git actually works it also makes
> complete sense. =E2=80=9CMaking the file known to Git=E2=80=9D (somet=
imes called
> =E2=80=9Ctracking the file=E2=80=9D) and =E2=80=9Cstaging for the nex=
t commit=E2=80=9D result in the
> exact same operations, from Git=E2=80=99s perspective.

Not exactly. You forget that git is not stateless. A file may be "known
to git" yet not changed (much less staged) since the last commit. Also,
git does not track changes perpetually--it only updates it's idea
(index) of changes to be committed (stages) when asked. It could be sai=
d
that it tracks changes incrementally upon request.

> But this is a good example of what=E2=80=99s wrong with the way the
> documentation thinks: Git=E2=80=99s implementation perspective should=
 not
> define how concepts are explained. In particular, *tracking* (in the
> sense of making a file known to git) and *staging* are conceptually
> different things. In fact, the two things remain conceptually
> different later on: un-tracking (removing the file from Git=E2=80=99s
> worldview) and un-staging are not the same thing at all, neither
> conceptually nor implementationally. The opposite of staging is `git
> reset HEAD <file>` and the opposite of tracking is -- well, I=E2=80=99=
m not
> sure, actually. Maybe `git update-index --force-remove <filename>`?
> But this only strenghtens my point: tracking and staging are differen=
t
> concepts, and therefore deserve different terms in the documentation
> and (ideally) in the CLI.

As tracking of changes is in part the art of remembering those changes
and making such changes available for inspection upon request (see my
"wild game" metaphor above) the way a detective might "track" evidence
there is no need to conflate the incremental tracking of some changes
before committing them with the list of changes we have tracked into th=
e
object store in the past. This is part of the power of git. It tells yo=
u
what content changed when and where that change came from. It "tracked"
all of them. It does not "track" mere files. It tracks CONTENT. When gi=
t
"stages" changes it tracks them in its short-term memory (the index) an=
d
when it commits those staged changes to the object store it allows
itself to track them for all time (conceptually).

> The entire quoted paragraph in the tutorial can be removed: there=E2=80=
=99s
> simply no reason to tell the reader that git behaves differently from
> other version control systems (indeed, to take some perverse *pride*
> in that fact).=20

In fact it is very worth noting that git works differently from other
SCM software. Not knowing what is different leads to a series of
important and potentially disastrous misconceptions. It should take
pride in being different, as it implements the holy grail of SCM: being
able to know who changed what, when, and perhaps even why.

> An even more radical suggestion (which would take all of 20 seconds t=
o
> implement) is to introduce `git track` as another alias for `git
> add`. (See above under `git status`). This would be especially useful
> if tracking *branches* no longer existed.

This is not appropriate. Git is not Subversion. It does not track files
for all time and it is not stateless. Full Stop.

> There=E2=80=99s another issue with this, namely that =E2=80=9Cadded f=
iles are
> immediately staged=E2=80=9D. In fact, I do understand why Git does th=
at, but
> conceptually it=E2=80=99s pure evil: one of the conceptual conrnersto=
nes of
> Git -- that files can be tracked and changed yet not staged, i.e., th=
e
> staging areas is conceptually a first-class citizen -- is violated
> every time a new file is =E2=80=9Cborn=E2=80=9D. Newborn files are *s=
pecial* until
> their first commit, and that=E2=80=99s a shame, because the first thi=
ng the
> new file (and, vicariously, the new user) experiences is an
> aberration. I admit that I have not thought this through.--

????? This strikes me as a vast misunderstanding of the mechanism at
work. If you could describe the roots of this idea then perhaps it coul=
d
be addressed. Git is not your filesystem.

Hopefully the couple of hours I spent on this helps further this
discussion in a useful manner.

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
