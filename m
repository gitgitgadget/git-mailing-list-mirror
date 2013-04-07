From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 16:28:41 +0530
Message-ID: <CALkWK0=cCu-dH7Cstuj5WJ6WW2xSWO9FuBWK0zm4=LK7+J6mzg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 12:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOnJn-0000Eu-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 12:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933325Ab3DGK7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 06:59:23 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:47342 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933267Ab3DGK7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 06:59:22 -0400
Received: by mail-ia0-f182.google.com with SMTP id u8so4338139iag.41
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hV/pNK6eVCXr9Q3IUdxajd87rNKqsi+BEjGIhk6D3Vc=;
        b=s0ZF27fbfT80LcWWWRK2ev2IgPGvZ3vTuGMlZ2PSPQch5bDazjS51C5VpR0Q6Hu+yI
         /lOC0WK86EiKqDxPkrJn3cwNLSHwTIqmKdofwWtd/EbxQ8GVQPh3MKNTJieECckjby+g
         uVtfRpRFtPhWRXBnrIK9GG5nKPxZJZ6iMEi2IZ4PcL0QW77RpNWVcs6j9pKm1H8AbRwJ
         /UtmSKbK2MXDogKF7GPOmXCqguWsQGSPl22/Fa4QOVvcnJmHGHVZQwoMUId7iHTvNDXW
         BRrQ60NOCdAoz1GC/tovhAl2DsQc0ld+LLvWJVWatot4nSHuWR9EGMaMGyS6h02Be/pU
         PERA==
X-Received: by 10.50.50.71 with SMTP id a7mr3825425igo.14.1365332361926; Sun,
 07 Apr 2013 03:59:21 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 03:58:41 -0700 (PDT)
In-Reply-To: <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220307>

Your overall hostility is unappreciated.  The burden of proof is on
me, while you calmly sit back and criticize anything that breaks the
current working state, and refuse to look at the implementation.
Anyway, here we go again.

Junio C Hamano wrote:
> Not at all.  And please do not start _coding_.

You've successfully killed all my enthusiasm.  Congratulations.

> When the design is not clear enough that a 7-patch series is not
> ready to be reviewed, certainly 50-patch series will not be.  Not
> until you can explain what you are trying to solve and convince
> others why other less disruptive approaches are fundamentally
> unworkable, and why we need to change the object layer.

"So, my final question is: are you still not convinced that this
approach shows a lot of potential, and is worth exploring now?"
"No."

I don't know how many times to repeat this: No, Junio.  A less
disruptive approach is _not_ fundamentally unworkable.  You can spend
the next five years fixing submodule.c/ git-submodule.sh, or can take
a step back and think about why it's in such pathetic shape right now.

>> To reiterate: link does not make possible something that is not
>> fundamentally _possible_ with a .githack and a 100k-line Perl script.
>>
>> At its core, every variant of submodules does this.  What I'm
>> essentially proposing: break up the information in .githack into
>> smaller bits and create a new object type so it can be parsed by
>> git-core easily.
>
> The .gitmodules file is designed to be easily parsable by the config
> infrastructure and implemented as such already, thank-you-very-much.

You're missing the point.  Who parses .gitmodules?  submodule.c and
git-submodule.sh, as opposed to a link being parsed by git-core.  How
is it any different?  That's what my series is trying to answer.

> Why do you keep calling an already working solution with derogatory
> misspelling?  That only gives others an impression that you do not
> understand how the current system works, and pursuade them not to
> waste time responding to you.  Stop it.

I don't see why you have to get offended by my deliberate misspelling:
we're not emotionally attached to software, and I'm merely criticizing
what I think is a bad hack.  I'm not pointing out the concrete
limitations of git-submodule precisely because they can be fixed
without any changes to the object layer: this thread will become a
discussion about how to fix submodule.c/ git-submodule.sh.  You want
floating submodules?  Fine, we'll write a helper script that
auto-commits to superproject everytime the SHA-1 changes.  Everything
_can_ be done.

What exactly don't I "understand" about the current system, apart from
the fact that everybody is super-rigid and defensive about what
already works?

Let us take a moment to look at the current state of git-submodule
(note that this is after many years of hard work).  This is just off
the top of my head:

1. To add a submodule, you can't git add.  You need to git submodule
add.  And only from the toplevel directory.  You can't first clone and
then add either: a git submodule add clones, adds lines to
.gitmodules, AND stages everything.

2. There is currently no way to remove a submodule.  You have to git
rm it, remove the lines in .gitmodules, and remove the GITDIR from
.git/modules.

3. It is currently impossible to git mv a submodule, because of the
amount of gymnastics required to relocate the object store, rewrite
the .gitmodules and stage the correct changes.

4. It is currently impossible to do true floating submodules, because
we're using a commit object in-tree.

5. You have to execute all submodule commands from the toplevel of the worktree.

6. It is currently impossible to initialize a nested submodule without
initializing the container submodule.  If I really want this, I have
to trade-off composability and use repo.

What is going on?  Either the people working on git-submodule are
horribly incompetent, or there's some fundamental problem.  I believe
the problem is the latter and have tried to show that the above quirks
can be fixed in a much simpler way with two days of work.  What part
of this didn't you understand?

> Sorry, but that is not how open source works in general, and
> certainly not how this project works.
>
> We do not add disruptive change just for the sake of changing it to
> break a working system, make an extra work to clean up the fallout
> for ourselves (i.e. your "40 to 50 patch series", but honestly
> speaking I expect it would be more like a 4 months work for a full
> time engineer or two), for unproven design (that has not yet to be
> illustrated) to solve problems (that has not yet to be explained),
> without knowing that
>
>  (1) the problems are worth solving;
>
>  (2) the design will solve the problems; and
>
>  (3) solving the same problems without such a disruptive change is
>      impossible, or so cumbersome that it will be far larger than
>      the work needed to clean-up the fallout of the disruptive
>      change.
>
> So what are your X, Y, Z?  You still haven't answered that question.

(1) The ones that are currently solved by various existing
implementations.  repo, mr, gitslave, git-subtree and git-submodule.

(2) Currently, I'm targeting making the life of git-submodule.sh
simpler, fixing the UI/UX, and adding a few new features: floating
submodules, refs for submodules, and blocking statthrough.  Isn't this
a definite improvement over the current design?  Why are you asking me
to investigate and solve every problem exhaustively now?

(3) Nothing is impossible.  It's cumbersome, and that's what I'm
trying to answer with my series: a little bit of code written in two
days can simplify a lot of things.  How do I give a definite answer to
this question without submitting two different series: one fixing
submodule.c/ git-submodule.sh to do everything I want, and another to
fix everything using my approach?

> What are the real advantages?  How are they used?  What do they
> allow us to do what we cannot do with .gitmodules (or repo or
> gitslave for that matter)?  What do they buy us?

For the 100th time, there's nothing you _cannot_ do with .gitmodules.
I'm not solving any new problems.  They're all solved by using a
combination of existing tools: each come with a specific set of
benefits and trade-offs.  I'm trying to engineer an simple and elegant
solution that will solve many of those problems natively in git.  They
buy us simplicity and elegance (I know you especially hate the word
"elegant", but I have no other way to put it).

> I have this suspicion that you do not have to change anything in the
> object layer to make Git behave very differently from the current
> submodule implementation.

Yes, you can!  For the 101th time.

> For example, if your gripe were (I am
> just speculating without any input from you in this thread) that
> each submodule working tree has ".git" at their top and there is no
> unified view from the top-level [*1*], we certainly can solve it
> without any change to the object layer.

I don't know where you got that idea from (certainly not from reading
my series): that is not my gripe at all.  As I've already stated, my
gripe is with how unnecessarily complicated, inelegant, and
featureless submodule.c/ git-submodule.sh is.

> We currently add a cache entry that has the commit object name to
> the index from the tree object when we check out the superproject,
> and create a separate repository with a working tree when we
> instantiate a submodule.

Yes, I'm aware.

> You could arrange a single index (the one in the superproject) to
> hold the tree contents from the commit in the submodule, while
> noting the original commit object name in a new mandatory extension
> section in the index. The index will have a unified view of the
> whole tree, and we do not have to have a .git at the root of each
> submodule working tree (be it a directory or a gitfile).

I think this is a very bad idea, because the toplevel index (and
combined object store) will blow up when we have lots of big
submodules.  One of my goals for the new submodule design is to answer
the scaling problem with ultra-large repositories: the answer is to
break them up into smaller ones and compose them using this beautiful
and powerful mechanism.

> I think the message where I talked about the "bind" idea in the list
> archive URLs I gave you earlier would give you such a layout, and
> you should go read it again to understand how the flow from object
> database to index to working tree back to index back to object
> database was envisioned to work.  I think the only thing we need to
> do differently from that "bind" proposal in the current world order
> is not to record the new submodule state in the commit object of the
> superproject, but actually create a new commit for the submodule
> part and store it in the tree object for the commit in the
> superproject (the "bind lines in the superproject commit" was a
> hack, only because we didn't have a way to write the submodule
> commit object name in the index and in the trees).

I don't see how this is relevant to our discussion, but anyway:

Yes, I read about your bind idea back from 2006.  TL;DR version for
everyone else reading:  Junio proposed that the commit object be
extended in the following way in January 2006.

tree 04803b09c300c8325258ccf2744115acc4c57067
bind 5b2bcc7b2d546c636f79490655b3347acc91d17f linux-2.6/
bind 0bdd79af62e8621359af08f0afca0ce977348ac7 appliance/
author Junio C Hamano <junio@kernel.org> 1137965565 -0800
committer Junio C Hamano <junio@kernel.org> 1137965565 -0800

The bind lines are referring to tree objects.  There's a reason the
link infrastructure written in 2007 by Linus made no reference to
this: it's a bad idea.  It's a much better idea to compose using
commits.  Even better to compose using a specialized link object.  Why
are you taking one step back from the current implementation?

So, my final question is: what do I have to do to convince you that
this approach shows promise?  Haven't I answered the questions you
keep repeating: "what problem does it solve?" and "why are existing
implementations fundamentally unworkable?".  I really don't know what
more to say, so can you give me a list of concrete actionable items
instead of repeating the same questions?
