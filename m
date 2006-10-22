From: "Matthew D. Fuller" <fullermd@over-yonder.net>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 07:46:35 -0500
Message-ID: <20061022124635.GR75501@over-yonder.net>
References: <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <87ac3p1jn7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:46:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbciz-0007JY-00
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJVMqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWJVMqj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:46:39 -0400
Received: from ns.centralmiss.com ([206.156.254.79]:58319 "EHLO
	optimus.centralmiss.com") by vger.kernel.org with ESMTP
	id S1750741AbWJVMqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:46:38 -0400
Received: from draco.over-yonder.net (adsl-072-148-013-213.sip.jan.bellsouth.net [72.148.13.213])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by optimus.centralmiss.com (Postfix) with ESMTP id 6EE522842F;
	Sun, 22 Oct 2006 07:46:36 -0500 (CDT)
Received: by draco.over-yonder.net (Postfix, from userid 100)
	id DEF0261C57; Sun, 22 Oct 2006 07:46:35 -0500 (CDT)
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87ac3p1jn7.wl%cworth@cworth.org>
X-Editor: vi
X-OS: FreeBSD <http://www.freebsd.org/>
User-Agent: Mutt/1.5.11-fullermd.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29725>

[ Time to trim up CC's a bit ]

On Sat, Oct 21, 2006 at 01:47:08PM -0700 I heard the voice of
Carl Worth, and lo! it spake thus:
> On Sat, 21 Oct 2006 08:01:11 -0500, "Matthew D. Fuller" wrote:
> > I think we're getting into scratched-record-mode on this.
> 
> I apologize if I've come across as beating a dead horse on this.

Oh, I don't mean the whole topic in general.  It's just that there are
only so many ways one can say "revnos are only valid in certain
situations", and I really think we must have hit them all by now.  We
all agree on that; we just disagree (probably highly based on
differing workflows) on the commonness and extent of those situations.


> > B: Revnos are handier tools for [situation] and [situation] for
> >    [reason] and [reason].
> 
> I'm missing something:
> 
> I still haven't seen strong examples for this last claim. When are
> they handier?

This ties in a bit with what you say below, so I'll address it there.


> There's no doubt that there has been semantic confusion over the
> term branch that has been confounding communication on both sides.
  [...]
> Let me know if I botched any of that.

This seems correct; at least, it's correct enough to work from until
we find a detail wrong.


> But dropping a merged branch in bzr means throwing away the ability to
> reference any of its commits by its custom, branch-specific revision
> numbers.

True (though see below).


> And there is no simple way to correlate the numbers between
> branches.

Rather, unless you can one way or another access the branch the number
was for, there's NO way.


> Maybe you can argue that there isn't any centralization bias in bzr.
> But anyone that claims that the revnos. are stable really is talking
> from a standpoint that favors centralization.

I think it's using that 'c' word there that's causing contention here;
we're ascribing different meanings to it.

Revnos only apply to a specific "branch" (in this usage, I'm talking
about branch abstractly and somewhat specifically; more in a moment),
and so except by wild coincidence are only useful in talking about
that branch.  One of the two cases (the second discussed later) where
that's useful is when you have long-lived branches.  In git,
apparently, you don't have long-lived "branches" in this particular
meaning of the word, but the way people use bzr they do.  Perhaps this
is what you mean by 'centralization'.

That long-lived branch doesn't have to be any sort of "trunk", though
it usually is; it could as easily be something totally peripheral.


Now, details of that use of "branch".  In mathematical terms, a branch
may be defined purely by its head rev (and the graph built up by
recursing through all the parents), but in [bzr] UI and mental model
terms, a "branch" is that plus its mainline[0]; the left-most or first
line of descent, which colloquially is the difference between 'things
I commit' and 'things I merge'.

Let me try flexing my git-expression muscles here.  Given a branch at
a specific point in time, you point at the head rev, and there's a
subset we call 'mainline' of the whole set of parents, which is
expressed by following the 'first' parent pointers back to a single
origin (there can be 50 origins in the whole graph, of course, but
only one of them is on the 'mainline').  At some later time, more
revisions have been added to the graph, and the head rev is now
something "later".  If, at that later time, all the nodes which were
previously on that 'mainline' are still on it tracing back from the
new head, then in the sense I'm using "branch", it's still the same
"branch".  All the revnos referring to its earlier incarnation are
still valid for this one (though there are new ones tacked onto the
end; that doesn't affect the pre-existing ones).

[I THINK we all understand that, but just making sure]


[0] This probably causes some confusion too, since I know I'm guilty
    of using the word 'mainline' both in the sense of a 'trunk'
    branch, and this particular path through one branch.  _I_ think
    it's usually clear from context, but I guess it probably isn't for
    those with a different mental modeling of "branch".


> To illustrate, yesterday I gave an example where performing a bzr
> branch from a dotted-decimal revision would rewrite the numbers from
> the originating branch (1.2.2, 1.2.1, and 1) to unrelated numbers in
> the new branch (3, 2, 1).

One thing to note here is that that 1.2.1 and 1.2.2 came into your
first branch here by merging from another branch (call that branch
'b').  When you created your new branch here that now has (3,2,1),
those numbers are the same as the numbers that existed locally in 'b'
at the time 1.2.2 was its 'head'.  In a sense, then, you've just
recreated [a copy of] "branch" 'b' at that time.  So, in a way, by
taking a copy of the current bzr.dev branch, you can recreate the
entire state of any branches that were merged into it as of the time
they were merged (excluding cases of cherrypicking, or when merging
prior to the head of those branches of course).


> But then I realized why bzr is doing this. It's because, bzr users
> don't just use the revision numbers for external communication, but
> they also use them for lots of direct interaction with the tool. The
> rewriting makes it easy to write something like "bzr diff -r1..3".

This is an instance of the second case (first above) where the revnos,
applying just to one branch, become useful.  And, it's probably the
case I'm most attached to.

The great majority (I'd say easily 80%) of my references to revisions
are transient.  Most of 'em have probably exhausted their usefulness
in an hour; many of them (as in interaction with the tool you
mentioned) in just a couple seconds.  Virtually all my branches live
longer than that, so the limited lifespan of the numbers in the grand
scheme doesn't matter a whit.

So, from above, some of the places they're handier:

- Typing.  I know, copy and paste copies and pastes one string just as
  well as another, and long strings just as well as short.  But I
  don't want to copy&paste; I want to ^Z out of log and run a quick
  diff, between two revisions only one of which is on my screen at the
  time.  I can just remember the offscreen revno I'm comparing
  against, and it's very easy to quickly type the numbers,
  particularly since 95% of the time I'm comparing mainline revs so I
  don't even have to think about dotted forms.


- Some forms of communicating.  I can yell numbers across the room
  without concern about whether they'll be interpreted right.  Even 6
  digits of an SHA-1 hash are a lot harder to do that with.  I can
  hold revnos in my head while I walk down the hall to talk to
  somebody about them, or pick up a phone, or go to a meeting.  I can
  scrawl them on notepads or whiteboards.  In all these cases, the
  only reason for which I'm communicating that revno will be exhausted
  very shortly, so it's completely irrelevant whether it's meaningful
  in 5 years, or next week.


- Visual comparing (this is one that's useful on the long-lived
  branches, as well as transient stuff) and information gathering.  I
  can hold in my head "Yeah, I looked at 1350 of Joe's branch", and if
  I see an email from him "Oh, I fixed a bug in 1358" or "in 1293", I
  can know just from that whether I saw the fix or not.

  If somebody says "I introduced a bug in revision 3841, and fixed it
  in 3843", I know the window where that bug is in play is probably
  pretty small, whereas "introduced in 3841, fixed in 5337" tells me
  it was alive a looong time.

  bzr.dev is currently on revno 2091.  I didn't know that, I had to
  look it up.  But I knew it was a little past 2000, just from loosely
  watching it.  If somebody talks about something that happened in
  revno 1800, I know automatically "That was fairly recent", compared
  to talking about revno 75, where I know "Wow, that was a long time
  ago".

  This property is true of bzr revids as well.  If I see talk about
  revision "mbp@sourcefrog.net-20050520021228-bc46a17f07eff7f9", I
  know right away Martin committed it, and it was a year and a half
  ago.  If I see talk about an oops in revision "af38cc3", that just
  tells me that somebody screwed up, and it gets mentally filed away
  or goes in one eye and out the other.  But if I see talk about an
  oops in revision "fullermd@over-yonder.net-[...]", that rings bright
  blue bells that tell me that *I* screwed up and I need to jump on
  that right now.  In a sufficiently small projects with sufficiently
  discrete task division, I may even be able to guess offhand based on
  the person and date what bit of functionality the commit references,
  though that's a much lower probability.

  It can also be useful in looking at cases where you don't
  necessarily have the tool.  Compare putting CVS's rcsid tags in
  strings in the source.  static const char *rcsid = "$Id"; and the
  like.  Then you can use 'ident' on the compiled binaries to see the
  revs of files in them.  If somebody says "foo.c has a bug in 1.34,
  fixed in 1.37", I can without any VCS interaction just look at the
  compiled binary and tell whether I'm prior to the bug, have the bug,
  or after the fix.  If the binary is known to be compiled from a
  particular branch, a tree-wide revno tells me that too.  A revid
  (even one containing a date) won't tell me that; I'll have to find
  the tool and a copy of the tree and find out if my rev contains that
  other rev.

  Now, on any given revision reference, I probably don't care about
  most of those bits of info.  I may not care about any of them, but I
  often care about at least one or two.  And we all probably have
  wildly varying appraisals of the commonness of various of the
  situations described.  And yes, a lot of them are just mental
  heuristics.  Sure, with a completely opaque id, I could pull up the
  tool to look up any of those (and a lot more information besides),
  the gain is I don't HAVE to.  Just knowing some bit of that info can
  often tell me if I don't care to investigate whatever the revision
  is being referenced for at all, or that I need to put doing so at
  the top of my priority list.



> And it turns out that git also allows branch specific naming for the
> exact same reason. In place of 3, 2, 1 in the same situation git
> would allow the names HEAD, HEAD~1, and HEAD~2 to refer to the same
> three revisions. So the easy diff command would be "git diff HEAD~2
> HEAD".

In bzr, that would be "bzr diff -r-2..-1" (or just "-r-2.." since
open-ended revspecs pretty much work like you'd expect them to).  IME,
that only works well maybe 4 or 5 revs back; past that, you spend too
much time counting, and it's easier to just whack in the number from
log.

bzr _doesn't_, OTOH, have anything like HEAD^2, for selecting
alternate parent paths.  That's probably use-pattern bias; we hardly
ever do something like that, so it's never occurred to us to add the
ability to.


> Maybe some of the people that dislike git's "ugly" names so much is
> that they imagine that to compare two revisions a user of git must
> inspect the logs, fish out the sha1sum for each, and then
> cut-and-paste to create the command needed.

I do imagine that.  And I think I'd hit it, since I often look around
revs that aren't right near the tip; trying to figure out
"HEAD~293..HEAD~38" is even worse than excavating the sha1sum's.



-- 
Matthew Fuller     (MF4839)   |  fullermd@over-yonder.net
Systems/Network Administrator |  http://www.over-yonder.net/~fullermd/
           On the Internet, nobody can hear you scream.
