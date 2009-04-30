From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 29 Apr 2009 22:07:31 -0400
Message-ID: <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
References: <20090427201251.GC15420@raven.wolf.lan>
	 <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com>
	 <20090428223728.GE15420@raven.wolf.lan>
	 <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
	 <20090429160129.GF15420@raven.wolf.lan>
	 <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
	 <20090429223747.GG15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 04:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzLgb-0001U4-2V
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 04:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761793AbZD3CHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 22:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761843AbZD3CHf
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 22:07:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:64729 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761724AbZD3CHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 22:07:33 -0400
Received: by yw-out-2324.google.com with SMTP id 5so907011ywb.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=zhLw4YIj/72Ue0km6aRQzUCJhmeT5t9XM8hvm+lkQ6E=;
        b=I90GTaidwWdygF+gpuYJwRD/9Pw1xNog4CC1ON4/aQHRvQCA0X0TsQvUthi3Ww+XQ3
         +3/TV/+OVTQ03scBeEOigamfuDBuPOfyEG9QZk1NcsZWaJW3p/sshm58JpTlRB5N3YjI
         wNwXUnVrDFYeejwFyylsnejdr3jsfsy6D5XHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=dGFC80jg81nHeymIsmCOFjw1a0qNnoSe9xL3EZI3eZFKsZHqPo/bT5bAEAPzVMZQfc
         cGALM/vGlcYBzL+P/KJS54e2A+ATatI3iHH+vMBSTIvFmpzpust4RmHADAzK2Jspgr14
         5JGs2F3U/GNLqsonGaVT4oOvXwJ3bwRtSeDPo=
Received: by 10.150.203.13 with SMTP id a13mr2609006ybg.98.1241057251990; Wed, 
	29 Apr 2009 19:07:31 -0700 (PDT)
In-Reply-To: <20090429223747.GG15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117984>

On Wed, Apr 29, 2009 at 6:37 PM, Josef Wolf <jw@raven.inka.de> wrote:
> On Wed, Apr 29, 2009 at 02:13:29PM -0400, Avery Pennarun wrote:
>> So you're saying that from now on, *all* changes from *both* branche=
s
>> need to be integrated in both directions?
>
> Exactly. =A0Those three commands:
>
> =A0git diff first-svn =A0 =A0 =A0 =A0second-svn =A0# this should be t=
he "private" diff
> =A0git diff first-svn/trunk =A0first-svn =A0 # what my cherry-picking=
 has changed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0# (and waits for push) in first-svn
> =A0git diff second-svn/trunk second-svn =A0# what my cherry-picking h=
as changed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0# (and waits for push) in second-svn
>
> show me _exactly_ what I want them to be. =A0The manual synchronizati=
ons
> which were done in the past are resolved now. =A0But I can't find the=
 way
> how to put the result of this cherry-picking back into the svn reposi=
tories

Okay, I think perhaps you're missing something that took me a long
time to figure out about git-svn, but once I understood it, my life
went a lot more smoothly.

Basically, 'git svn fetch' updates just a *remote* branch.  (Remote
branches are in .git/refs/remotes/* and you can't change them
yourself, because you can't attach your HEAD to them.  If you try to
check them out, you get the latest revision in that branch, but your
HEAD becomes detached.)

I'm not actually sure which of the above branches you're referring to
is remote and which is local.  Let's guess that first-svn/trunk is
remote, and first-svn is a local copy of it, onto which you
cherry-picked some extra patches.

Some people like to think of just making a copy of the git-svn remote
branch, doing stuff to it, and then doing git-svn dcommit and/or
rebase on that branch.  This sounds good, but it makes a mess *if*
you're doing any kind of git merging (which many git-svn users never
do, but which it seems you'd like to do extensively).  Remember: git
merge is 100% totally incompatible with rebasing.

What I'm suggesting is that you think of your local branch (first-svn
in this case, I guess) as *not* an svn branch at all.  You never do
any git-svn operations directly on this branch.  In fact, rename it to
master so you aren't tempted to get yourself into trouble.

Now, you've merged from first-svn/trunk and cherry-picked some extra
stuff onto this branch, right?  Good.  Now you want to *merge* this
branch into first-svn/trunk, producing just *one* new commit, and
dcommit that into svn.

   git checkout first-svn/trunk
      # detaches the HEAD
   git merge master
      # produces a merge commit on the detached HEAD
   git svn dcommit
      # produces a *different* commit object on the first-svn/trunk bra=
nch
      # ...and moves HEAD to it.

The newly-produced commit tells git that first-svn/trunk is now
up-to-date with master.  Note that the interim merge commit (produced
by 'git merge') is never shared with *anyone*, so it's perfectly okay
that we replace it with the next command.

What you probably thought you should do, given that the existing
git-svn documentation says to do it, is more like this:

   # WRONG
   git checkout first-svn
   git cherry-pick some stuff
   git merge [perhaps -s ours] second-svn/trunk
   git svn dcommit

But the above will *change* every single commit you put on first-svn,
because dcommit needs to *regenerate* all the commits after putting
them into svn and getting them back again.  This is essentially a
rebase, and disrupts any merges you might have made from this branch
to another one.  Next time you merge, you'll get a zillion conflicts.

> Ah! =A0I thought I _have_ to "git svn rebase" before I dcommit, like =
I need
> to "svn update" before I can do "svn commit".

This is true and yet not true.  The reason I don't have to ever use
'git svn rebase' is that 'git svn fetch' updates my first-svn/trunk
branch, and then I quickly do a merge-then-dcommit on that branch.  If
I was to do a 'git svn rebase' first, nothing would happen, because
svn doesn't change.

This is important, since 'git svn dcommit' actually *does* do a 'git
svn rebase' for you automatically, trying to be helpful.

>> In general, 'git svn rebase' should be avoided for all the same
>> reasons that 'git rebase' should be avoided. =A0They're both great w=
hen
>> used carefully, but they shouldn't be your main day-to-day activity.
>
> Unfortunately, all the howto's I could find recommend exactly that:
> git-svn-rebase for getting commits from svn and dcommit for sending
> commits to svn.

Yeah, they're trying to keep things simple, at the cost of preventing
you from doing anything complicated.  I'm not smart enough to do both,
so I'm just making things complicated for you here ;)

As it happens, I wrote the git-svn chapter for the
very-nearly-available new O'Reilly book "Version Control with Git."  I
gave the complicated solution there too.  I'm eagerly awaiting the
giant flames from people who actually wrote git-svn (and its
documentation) and therefore are highly qualified to disagree with me.

>> =A0 - 1 remote branch: git-svn-1
>> =A0 - 1 remote branch: git-svn-2
>> =A0 - 1 local branch: master
>
> I will try this one. =A0But this will take a while, since my
> cherry-picking was done criss-cross. =A0Thus, I need to "rebase"
> the cherries now to get them onto a single branch. =A0Is there
> a simple way to do that or do I have to redo the cherry-picking from
> scratch?

No no!  Stop rebasing!

You have a branch that looks the way you want, right?  That means
you're 99% of the way there.  You just have to convince git that this
branch and the svn branch are related to each other in the way they
actually are.

To do that, you just need to do is make a single merge commit on your
svn remote branch that looks the way you want and merges from your
existing branch, then do a single 'git svn dcommit'.  Here's one way
(assuming you want to make svn look like your new local branch):

   git checkout my-local-branch
   git merge -s ours svn-branch
   git checkout svn-branch
   git merge --no-ff my-local-branch
   git svn dcommit

(If the occasionally-suggested '-s theirs' merge strategy existed, you
could just do the last three steps using git merge -s theirs.)

>> >> As long as you "git config merge.summary true" (to make the merge
>> >> commit list all the commits it's merging)
>>
>> When you *merge* (as opposed to rebase or cherry-pick) into an svn
>> branch, you only create a *single* svn commit that contains *all* th=
e
>> changes. =A0The above config setting just makes the merge commit con=
tain
>> a list of all the commits it contains.
>
> But git will not use this information in any way, AFAIK. =A0So this i=
nformation
> is only for the person who will do the next merge?

In fact, it *only* affects the svn log.  Otherwise svn log ends up
with a useless commit that says "Merged from commit (giant hex
string)", and you can't actually do anything with the giant hex string
because svn doesn't know what it is.

If nobody looks at your svn changelog, it's irrelevant.

> The people are not uncooperative. =A0It is just that there's no way t=
o
> completely separate the public and private content.

There is, if you're willing to do it.  The usual way is two have two
branches: public and private.

Whenever you make a change that you want to be public, you commit it
on the public branch, then merge (git merge or svn merge, it doesn't
matter) from public to private.  If you want to make a private change,
you just commit it directly to private.

This way, you will always have the two sets of changes isolated, you
never have to cherry-pick anything, and "git diff public private" is
always a sensible thing to do.

(In fact, when I do this, I often don't share the private branch with
anyone at all, which means it's safe to rebase.  That means I can keep
a clean set of patches against the public branch, and sort and
rearrange or share them whenever I feel like it.  This is useful in
some cases.  Rebasing isn't *always* bad :))

>> If you're using cherry-pick for everything, there's no reason to use
>> tricks like 'merge -s ours'. =A0Just leave out the merging entirely =
and
>> don't pretend that what you're doing is merging; it isn't. =A0(You s=
till
>> don't need 'git svn rebase' for anything. =A0Just checkout the branc=
h
>> you want to change, cherry-pick stuff into it, and 'git svn dcommit'
>> if appropriate.)
>
> But then I have to do the book-keeping (what was already picked in wh=
ich
> direction) by myself?

On branch b, 'git merge x' will always merge all the changes from the
most recent merge of x into b (which might be a "-s ours" merge if you
want), up to the tip of x.  So if you don't commit any *new* private
stuff to x, you can use merge.  If you're intermixing the changes,
you'll need to use cherry-pick.  git won't attempt to track the
cherry-picks for you (like eg. svnmerge will).

Have fun,

Avery
