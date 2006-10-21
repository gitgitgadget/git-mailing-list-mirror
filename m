From: Jeff Licquia <jeff@licquia.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:07:10 -0400
Message-ID: <1161472030.9241.174.camel@localhost.localdomain>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	 <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	 <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org>
	 <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org>
	 <20061021130111.GL75501@over-yonder.net>  <87ac3p1jn7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 01:08:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbPwe-0006gm-UN
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 01:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWJUXHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 19:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbWJUXHX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 19:07:23 -0400
Received: from jeffindy.licquia.org ([216.37.46.185]:47763 "EHLO
	jeffindy.licquia.org") by vger.kernel.org with ESMTP
	id S1161093AbWJUXHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 19:07:21 -0400
Received: from server1.internal.licquia.org (unknown [192.168.50.3])
	by jeffindy.licquia.org (Postfix) with ESMTP id E47DC6FD88;
	Sat, 21 Oct 2006 19:07:18 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.52.6])
	by server1.internal.licquia.org (Postfix) with ESMTP id 4784A980DA;
	Sat, 21 Oct 2006 19:07:13 -0400 (EDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 237F24E4025; Sat, 21 Oct 2006 19:07:11 -0400 (EDT)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87ac3p1jn7.wl%cworth@cworth.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29686>

On Sat, 2006-10-21 at 13:47 -0700, Carl Worth wrote:
> I still haven't seen strong examples for this last claim. When are
> they handier? I asked a couple of messages back and two people replied
> that given one revno it's trivial to compute the revno of its
> parent. But that's no win over git's revision specifications,
> (particularly since they provide "parent of" operators).

Having used both (though my familiarity with git is less), in my opinion
the biggest win is the obvious one: sequential numbers work in the head
better than SHA1 checksums.

"But it's not a problem in practice!" is a good retort, except that I
wonder whether the set of "practices" you're using includes anyone who
decided to pass on git in favor of something else--perhaps because they
saw a few SHAs float by and ran in terror.  Beware of self-selection
bias.

Put another way, "strength" of example is often in the eye of the
beholder.  That we continue to give you the same "weak" examples may be
evidence that we have a different impression of their strengths, and
that your analysis of their strengths isn't convincing to us.

I suppose this line of conversation still has value if you don't see any
benefit at all, but OTOH if you really don't see how sequential numbers
are easier to work with in the head than SHA sums with modifiers, I'm
not sure that's a gap we can bridge.

> Let me know if I botched any of that.

I don't see any problems with it.

> But dropping a merged branch in bzr means throwing away the ability to
> reference any of its commits by its custom, branch-specific revision
> numbers. And the revision numbers _do_ change, pull, branch, and merge
> all introduce revision number differences between branches, (or
> changes within a branch in the case of pull). And there is no simple
> way to correlate the numbers between branches.
> 
> Maybe you can argue that there isn't any centralization bias in
> bzr. But anyone that claims that the revnos. are stable really is
> talking from a standpoint that favors centralization.

I wonder if part of the problem is that the revno scheme we've been
talking about (the x.y.z... format) doesn't technically exist in any
released version of bzr that I know of.

Previous to 0.12, bzr revnos were absolutely a local thing; revisions
from merges didn't even have revnos (except for the merge commit
itself).  If you merged a branch and you later wanted to recreate that
branch, or see a diff from that branch, etc., you had to use revids.

So when you talk of a "centralization bias" in bzr, a lot of us get
confused, defensive, etc., because from our perspective, bzr and git
weren't all that much different until just recently.

Now it may be that you're right that "global" revnos like bzr has now
introduce a bias in favor of centralization.  If that's true, I'm not
sure that totally vindicates the git model.  We have to ask if the bias
is a good thing, but so do you; after all, we may have done so because
of user demand, and if our users want it, maybe yours will want it too
someday.

(I say "may" because I haven't been paying close attention to the new
revno conversation, so I don't want to sound more sure than I am.)

But I think bzr people are more willing to take a wait-and-see approach.
Local revnos weren't a big deal, so we're willing to bet that the new
0.12 revnos won't be, either.

> And it turns out that git also allows branch specific naming for the
> exact same reason. In place of 3, 2, 1 in the same situation git would
> allow the names HEAD, HEAD~1, and HEAD~2 to refer to the same three
> revisions. So the easy diff command would be "git diff HEAD~2 HEAD".
> (And where I have HEAD here I could also use any branch name, or any
> other reference to a commit as well.)

FYI: The strict analogy to HEAD~1 in bzr would be -2.  And yes, -2 is
every bit as unstable as HEAD~1.

> Finally, since these branch-specific names are changing all the time,
> there's never any temptation for people to attempt to use them to for
> external communication. In contrast, by being numbered in the opposite
> direction, bzr revision numbers give a false appearance of stability
> and people _do_ use them for communication. This is the mistake we've
> been warning bzr users about in this thread.

URLs are also used for communication, despite having many of the same
drawbacks as revnos in DVC systems.  This could have been a fatal flaw,
but in reality, this has resulted in some best practices ("permalinks",
for example), and a sense of where a URL is appropriate and where it
isn't.  It's not perfect, and yet it's been wildly successful.

Copying the flaws of a highly successful system does not guarantee
success, of course.  On the other hand, it does influence our evaluation
of the severity of the flaws.

There may be a danger, though, that the bzr community may want to pay
closer attention to.

Several of us have pointed to the (branch, revno) combination as a
sufficiently reliable communication method, and we may be right about
that.  But, so far, those revnos have been entirely local to a single
branch, and have also been as absolutely reliable (locally speaking) as
a revid; the branch "foo" may go away, but while it's around, "revision
14 of branch foo" will always mean the same thing.  But we're now adding
the 0.12 revno scheme, with "global" revnos.  Will those be as reliable?
Will "revision 2418.1.4 on bzr.dev" work as well as "revision 2418 on
bzr.dev" does now?
