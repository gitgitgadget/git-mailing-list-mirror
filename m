From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 19:26:10 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-8B7921.19261029012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <fabb9a1e1001291332w1d161f8at58aa6fe6908bd77f@mail.gmail.com> <alpine.LFD.2.00.1001291641200.1681@xanadu.home> <7viqakh8ty.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291716070.1681@xanadu.home> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> <7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> <alpine.LFD.2.00.1001292013150.1681@xanadu.home> <ron1-F006CF.18381129012010@news.gmane.org> <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 04:35:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb47N-0001NA-8W
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 04:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab0A3D0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 22:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756232Ab0A3D0e
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 22:26:34 -0500
Received: from lo.gmane.org ([80.91.229.12]:38089 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756229Ab0A3D0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 22:26:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb3yi-0007op-4z
	for git@vger.kernel.org; Sat, 30 Jan 2010 04:26:32 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 04:26:32 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 04:26:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138435>

In article <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Ron Garret <ron1@flownet.com> writes:
> 
> > 1.  The term "detached HEAD" is inherently misleading.  A detached HEAD 
> > isn't detached from anything, it's just pointing to the middle of a 
> > branch, which is to say, to a commit that happens to already have 
> > descendants.  For that matter, the name HEAD is itself misleading, since 
> > HEAD need not be the head of a branch (though normally it is).  A better 
> > name for HEAD would have been CURRENT or ACTIVE.  I recognize it's 
> > probably too late to change it now.
> 
> This description, especially the phrase "middle of a branch" shows that
> you don't understand git yet.

That could well be, but it's not for lack of trying :-)

> A git branch is _not_ a line (nor multiple
> lines) of development.  It is merely a _point_ in the history.

By "middle of a branch" I simply meant "a commit that already has one or 
more descendants" (or, to be even more precise, a commit that has one or 
more commits that reference that commit as one of their predecessors).  
I do understand that histories aren't linear.

> "A commit that is in the middle of an ancestry chain with existing
> descendants" can be at the tip of a branch and does not have anything to
> do with detached HEAD state.

Ah, then you're right.  I really don't get it yet.

> When HEAD points at a branch, making a commit advances _that_ branch.  And
> we say you are "on that branch".  When HEAD is detached, because it is not
> attached to anything, it advances no branch.  "detached HEAD" is detached
> in the very real sense.  It is not attached to _any_ branch.

OK.  The docs do not make that clear at all.  In fact, the following 
statement, copied straight from the manual, flatly contradicts what you 
just said:

"The special symbol "HEAD" can always be used to refer to the current 
branch."

Always.  Except when it can't.

Soooo.....

Sometimes HEAD can refer to a branch head which is a pointer to a 
commit, and sometimes HEAD can refer to a commit directly without 
indirecting through a branch head (lower case), in which case it is 
detached.  Is that right?

If that's true, then I'm back to wondering what good is a detached head.  
Why would you ever want one?  What can you do with a detached head that 
you could not do just as easily without one?

rg
