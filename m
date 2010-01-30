From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 18:38:11 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-F006CF.18381129012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> <alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> <7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 03:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb3Gx-0004wI-8i
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 03:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab0A3Cig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 21:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920Ab0A3Cig
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:38:36 -0500
Received: from lo.gmane.org ([80.91.229.12]:36350 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab0A3Cig (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 21:38:36 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb3EH-0004Hd-EB
	for git@vger.kernel.org; Sat, 30 Jan 2010 03:38:33 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 03:38:33 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 03:38:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138428>

In article <alpine.LFD.2.00.1001292013150.1681@xanadu.home>,
 Nicolas Pitre <nico@fluxnic.net> wrote:

> On Fri, 29 Jan 2010, Mark Lodato wrote:
> 
> > Still, I find it slightly confusing and unfriendly.  How about the 
> > following?
> 
> It is slightly inaccurate.
> 
> > Checking out commit 'master^0'.
> > 
> > Since this is not a local branch head, any commits you make will be lost
> > when you check out another branch or commit.  (In git terminology, HEAD
> > is detached.)  If you just wish to look at files without committing,
> > this is fine.  If you wish to make commits and retain them, you may
> > create a new branch by running:
> > 
> >   git checkout -b <new_branch_name>
> 
> This gives the impression that any commit you make on a detached HEAD 
> are going to be lost, unless you create a new branch first.
> 
> And again, it is a good thing to have "detached HEAD" in there so to 
> relate to existing documentation easily.
> 
> > I think the above wording is fine for both commits (e.g. master^0) and
> > remote branches (e.g. origin/pu).  With other wording, we may wish to
> > have two slightly different messages depending on what the user typed.
> 
> You could have tags too.  So instead of trying to be too smart, it is 
> best to simply display the provided name without qualifier.
> 
> > Also, I am not a big fan of "local branch head".  How about "not the
> > name of a local branch"?  I'm not sure...
> 
> The confusion that started this thread was about "master^" which might 
> be interpreted as the name of a local branch except for the fact that we 
> want one commit back.  So using "local commit head" is more precise.

Since it is my confusion that started this thread (and I suppose is in 
part responsible for continuing it) I should be clear that master^ was 
just an example.  My first attempt to roll back to an earlier version 
was actually "git checkout HEAD^".  That produced the same result, since 
HEAD was pointing to master at the time.  But one of the things I 
realized was that HEAD was a variable, and so I chose to frame my 
example in terms of master instead of HEAD in order to eliminate 
ambiguity.

FWIW, here are some observations based on my current understanding:

1.  The term "detached HEAD" is inherently misleading.  A detached HEAD 
isn't detached from anything, it's just pointing to the middle of a 
branch, which is to say, to a commit that happens to already have 
descendants.  For that matter, the name HEAD is itself misleading, since 
HEAD need not be the head of a branch (though normally it is).  A better 
name for HEAD would have been CURRENT or ACTIVE.  I recognize it's 
probably too late to change it now.

2.  There are a lot of things in the documentation that turn out, now 
that I understand what is going on, to be subtly misleading.  For 
example, "A single git repository can track development on multiple 
branches. It does this by keeping a list of heads which reference the 
latest commit on each branch."  That last part is only true if the heads 
are not "detached".

I do not yet understand enough about git to know if this is a reasonable 
suggestion, but one possibility is to separate the notion of a head from 
the notion of a pointer to a commit.  A head would be a pointer to a 
commit that can only point to a commit with no descendants, whereas a 
pointer could point anywhere.  What is now called HEAD would be a 
pointer, not a head under this ontology.

Another example: "The HEAD then refers to the SHA-1 of the commit 
instead of to a branch, and git branch shows that you are no longer on a 
branch:"  But you *are* on a branch, you just aren't at the head of the 
branch.  In fact, by the definition of branch the whole concept of "not 
being on a branch" is non-sensical.  (Isn't that part of the whole point 
of git?  That everything is a branch?)

3.  These observations suggest ways in which the situation could be 
improved.

First, I think Michael Witten is on the right track with his proposal 
for a redesign of git-checkout and the new git-update command (though I 
have not yet had time to think deeply about the details).  There are 
only a small number of things that are actually going on under the hood, 
and the closer the map between the command set and those primitive 
operations can be made the better.

Second, the real problem underlying the original warning that started 
all this is that if you do a commit from a "detached head" then you have 
effectively created a branch whether you meant to or not.  This suggests 
a very straightforward warning:

"WARNING: Your HEAD is now pointing to a commit that has descendants.
If you do a commit from here, you will be creating a branch.  If this
is not what you intend, read the documentation and achieve clarity before
proceeding.  If you just want to bail out of this situation without
doing your homework, do a 'git checkout master' or something like that."

Or something like that :-)

rg
