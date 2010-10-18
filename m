From: Thore Husfeldt <thore.husfeldt@gmail.com>
Subject: Git terminology: remote, add, track, stage, etc.
Date: Mon, 18 Oct 2010 22:45:50 +0200
Message-ID: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 22:46:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7wap-0005D8-Pf
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 22:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab0JRUp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 16:45:56 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33951 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0JRUpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 16:45:55 -0400
Received: by ewy20 with SMTP id 20so2312027ewy.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version:x-mailer;
        bh=zKHrj/i0x6lYnoNPP5CJPoHyhq0VoN+ncmrR8Suieqw=;
        b=j5bEVTmI1ptmkCUe72nQpbL7a/E8/0eyXz64paJo/5Y4VyG402osAzqlqeP2tnusVc
         jxGyJHtJAVnLia3I5AnNm2UhRUcrSEIMj7gtxI8afue2lOdQnrAfYsgLvF8q6rO5RckN
         7Cew+RH5uZkSSK5RpLPqX4+cUj5eL0QgcJxhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=MNj0kzJuGjV5udb/pdfRQcrgucZhZzN9xabI1gMbyprS/1c3dg/PfjeS89VUH5Usaf
         Px7/8V0aBx+jiu2v3RAMkkxDlmKM16o9h48r1zeVcr+5+UUN6ca5+Txmbh1nPjgvKbkB
         cBfxAdKRreDbZqbhRwT2Y4lrgK39ZysuMVZWA=
Received: by 10.213.108.201 with SMTP id g9mr4742400ebp.46.1287434753399;
        Mon, 18 Oct 2010 13:45:53 -0700 (PDT)
Received: from [10.0.1.4] (h51baf259.k2290.dyn.perspektivbredband.net [81.186.242.89])
        by mx.google.com with ESMTPS id b52sm1849605eei.13.2010.10.18.13.45.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 13:45:52 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159287>

I=92ve just learned Git. What a wonderful system, thanks for building
it.=20

And what an annoying learning experience.=20

I promised myself to try to remember what made it all so hard, and to
write it down in a comprehensive and possibly even constructive
fashion. Here it is, for what it=92s worth. Read it as the friendly, bu=
t
somewhat exasparated suggestions of a newcomer. I=92d love to help (in
the form of submitting patches to the documentation or CLI responses),
but I=92d like to test the waters first.

So, in no particular order, here are the highlights of my former
confusion, if only for your entertainment. Comments are welcome, in
particular where my suggestions are born out of ignorance.

Remote (tracking) branches
--------------------------

There are at least two uses of the word *tracking* in Git's
terminology.

The first, used in the form =93git tracks a file=94 (in the sense that =
Git
knows about the file) is harmless enough, and is handled under `git
add` below.

But the real monster is the *tracking branch*, sometimes called the
remote branch, the remote-tracking branch, or the remote tracking
branch. Boy did that ever confuse me. And, reading the git mailing
list and the web, many others. There are so many things wrong with how
this simple concept is obfuscated by the documentation that I have a
hard time organising my thoughts about writing it down.

Please, *please* fix this. It was the single most confusing and
annoying part of learning Git.

=46irst, the word, =93tracking=94. These branches don=92t track or foll=
ow
anything. They are standing completely still. Please believe me that
when first you are led to believe that origin/master tracks a branch
on the remote (like a hound tracks it quarry, or a radar tracks a
flight) that it is very difficult to hunt this misunderstanding down:
I believed for a long time that the tracking branch stayed in sync,
automagically, with a synonymous branch at the remote. The CLI and
documentation worked very hard to keep me in that state of
ignorance. I *know* that my colleague just updated the remote
repository, yet the remote branch (or is the remote tracking branch?
or the remote-tracking branch?) is as it always was...? (How could I
*ever* believe that? Well, *now* I get it, and have a difficult time
recollecting that misunderstanding. *Now* it=92s easy.)

Second, the word =93remote=94 as opposed to =93local=94, a dichotomy en=
forced
by both the documentation and by the output of `git branch -r` (list
all remote branches, says user-manual.txt). Things began to dawn on me
only when I understood that origin/master is certainly and absolutely
a =93local=94 branch, in the sense that it points to a commit in my loc=
al
repository. (It differs from my other local branches mainly in how it
is updated. It=92s not committed to, but fetched to. But both are local=
,
and the remote can be many commits ahead of me.)

So, remote tracking branches are neither remote (they are *local*
copies of how the remote once was) and they stand completely still
until you tell them to =93fetch=94. So remote means local, and tracking
means still, =93local still-standing=94 would be a less confusing term
that =93remote tracking=94. Lovely.

Tracking branches *track* in the sense that a stuffed Basset Hound
tracks. Namely, not. It=91s a dream of what once was.

The hyphenated *remote-tracking* is a lot better terminology already
(and sometimes even used in the documentation), because at least it
doesn't pretend to be a remote branch (`git branch -r`, of course,
still does). So that single hyphen already does some good, and should
be edited for consistency. (It did take time for me to convince myself
during the learning process that =93remote tracking=94 and
=93remote-tracking=94 probably are the same thing, and =93tracked remot=
e=94
something else, abandoning and resurrecting these hypetheses several
times.)

And *even if* the word was meaningful and consistenly spelt, the
documentation uses it to *refer* to different things. Assume that we
have the branches master, origin/master, and origin=92s master
(understanding that they exist, and are different, is another Aha!
moment largely prevented by the documentation). For 50 points, which
is the remote tracking branch? Or the remote-tracking branch? The
remote branch? Which branch tracks which other branch? Does master
track anything? Nobody seems to know, and documentation and CLI
include various inconsistent suggestions. (I know there have been
long, and inconclusive threads about this on the git mailing list, and
I learned a lot from seeing other people=92s misconceptions mirror my
own.)  Granted, I think the term =93tracked remote branch=94 is used wi=
th
laudable consistentcy to refer to a branch on the remote. And =93remote
tracking branch=94 (with our without the hyphen) more often than not
refers to origin/master. It may be that terminology is slowly
converging. (To something confusing, but still...)

But to appreciate how incredibly difficult this was to understand,
check this, from the Git Community book:

    A 'tracking branch' in Git is a local branch that is connected to
    a remote branch.

To a new user, who *almost* gets it, this is just a slap in the
face. Which one of these is origin/master again? None? (Or rather, it
is the confirmation one needs that nobody in the Git community cares
much, so the once-believed-to-be-carefully-worded documentation loses
some of its authority and therefore the learner can abandon some
misunderstandings.)

There probably is a radical case to be made for abandoning the word
=93tracking=94 entirely. First, because tracking branches don=92t track=
, and
second because =93tracking=94 already means something else in Git (see
below). I realise that this terminology is now so ingrained in Git
users that conservatism will probably perpetuate it. But it would be
*very* helpful to think this through, and at least agree on who
=93tracks=94 what. In the ideal world, origin/master would be something
like =93the fetching branch=94 for the origin=92s master, or the =93sna=
pshot
branch=94 or the =93fetched branch=94. (I am partial to use =93fetching=
=94
because it makes that operation a first-class conceptual citizen,
rather than pulling, which is another siren that lures newbies into a
maelstroem of confusion.)

More radically, I am sure some head scratching would be able to find
useful terminology for master, origin/master, and origin=92s master. I=92=
d
love to see suggestions. As I said, I admire how wonderfully simple
and clean this has been implemented, and the documentation, CLI, and
terminology should reflect that.

The staging area
----------------

The wonderful and central concept of staging area exists under at
least three names in Git terminology. And that=92s really, really
annoying. The index, the cache, and the staging area are all the same,
which is a huge revelation to a newcomer.

This problem could of course be easily fixed by making up your
mind. The decision which of the three terms to adopt is somewhat
arbitrary, but *staging area* gives the strongest and best
metaphor. It also verb quite well, even though it is not the best,
shortest noun. *Index* would have been a good word for the files known
to Git (what is now called, sometimes, =93tracked files=94), and *cache=
*
is terrible in any case.

`git stage` is already part of the distribution. Great.

1. Search for index and cache in the documentation and rephrase any
and all their occurences to use =93staged=94 (or, if it can=92t be avoi=
ded
=93the staging area=94) instead. Say =93staged to be committed=94 often=
, it=92s
a strong metaphor.

2. Introduce the alias `git unstage` for `git reset HEAD` in the
standard distribution.

3. Duplicate various occurences of `cached` flags as `staged` (and
change the documentation and man pages accordingly), so as to have,
e.g., `git diff --staged`.

git status
----------

One of the earliest-to-use commands is `git status`, whose message are
*wordy*, but were initially completely unhelpful to me. In particular,

   working directory clean

Clean? What=92s this now? Clean and dirty are Git slang, and not what I
want to meet as a new user. The message should inform me that the
untracked files in the working directory are equal to their previous
commit. But there are other things wrong with the message. For
example, even though there=92s nothing to commit: `nothing added to
commit but untracked files present (use "git add" to track)`? The last
paranethesis should set off warning bells already. And what did clean
mean with respect to untracked files? And =93added to commmit=94? That
sounds like amending. We add to the index or the staging area, don=92t
we, =93ready to be included in the next commit,=94 so they aren=92t add=
ed to
that commit quite yet?

    changed but not updated:

I=92m still not sure what =93update=94 was ever supposed to mean in thi=
s
sentence. I just edited the file, so it=92s updated, for crying out
loud! The message might just say =93Changed files, but not staged to be
committed.=94  The meant-to-be helpful =93use [...] to update what will=
 be
committed=94 is another can of worms, and I can find at least two ways
to completely misunderstand this. Change to =93use `git stage <file>` t=
o
stage=94. (With the new command name it=92s almost superfluous.)
 =20
Here are some concrete suggestions:

1.

    nothing added to commit but untracked files present

should be

    nothing staged to commit, but untracked files present

(Comment: maybe =93... but working directory contains untracked files.=94
I realise that =93directory=94 is not quite comprehensive here, because
files can reside in subdirectories. But I=92d like to be more concrete
than =93be present=94.)

2.
    Untracked files:
    (use "git add <file>..." to include in what will be committed)

should be

    Untracked files:
    (use "git track <file>" to track)

3.

    Changes to be committed:
    (use "git reset HEAD <file>..." to unstage)

should be

    Staged to be committed:		=20
    (use "git unstage <file>" to unstage)

Adding
------

The tutorial tells us that=20

    Many revision control systems provide an add command that tells
    the system to start tracking changes to a new file. Git's add
    command does something simpler and more powerful: git add is used
    both for new and newly modified files, and in both cases it takes
    a snapshot of the given files and stages that content in the
    index, ready for inclusion in the next commit.

This is true, and once you grok how Git actually works it also makes
complete sense. =93Making the file known to Git=94 (sometimes called
=93tracking the file=94) and =93staging for the next commit=94 result i=
n the
exact same operations, from Git=92s perspective.

But this is a good example of what=92s wrong with the way the
documentation thinks: Git=92s implementation perspective should not
define how concepts are explained. In particular, *tracking* (in the
sense of making a file known to git) and *staging* are conceptually
different things. In fact, the two things remain conceptually
different later on: un-tracking (removing the file from Git=92s
worldview) and un-staging are not the same thing at all, neither
conceptually nor implementationally. The opposite of staging is `git
reset HEAD <file>` and the opposite of tracking is -- well, I=92m not
sure, actually. Maybe `git update-index --force-remove <filename>`?
But this only strenghtens my point: tracking and staging are different
concepts, and therefore deserve different terms in the documentation
and (ideally) in the CLI.

The entire quoted paragraph in the tutorial can be removed: there=92s
simply no reason to tell the reader that git behaves differently from
other version control systems (indeed, to take some perverse *pride*
in that fact).=20

=46ixing this requires no change to the implementation. `git stage` is
already a synonym for `git add`. It merely requires discipline in
using the terminology of staging. Note that it completely valid to
tell the reader, maybe immediately and in a footnote, that `git add`
and `git stage` *are* indeed synonyms, because of Git=92s elegant
model. In fact, given the amount of documentation cruft one can find
on the Internet, this would be a welcome footnote.

An even more radical suggestion (which would take all of 20 seconds to
implement) is to introduce `git track` as another alias for `git
add`. (See above under `git status`). This would be especially useful
if tracking *branches* no longer existed.

There=92s another issue with this, namely that =93added files are
immediately staged=94. In fact, I do understand why Git does that, but
conceptually it=92s pure evil: one of the conceptual conrnerstones of
Git -- that files can be tracked and changed yet not staged, i.e., the
staging areas is conceptually a first-class citizen -- is violated
every time a new file is =93born=94. Newborn files are *special* until
their first commit, and that=92s a shame, because the first thing the
new file (and, vicariously, the new user) experiences is an
aberration. I admit that I have not thought this through.