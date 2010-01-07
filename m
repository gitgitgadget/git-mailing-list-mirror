From: Zing <zing@fastmail.fm>
Subject: Re: [PATCH] Documentation: do not advertise --all in git-pull(1)
Date: Thu, 7 Jan 2010 18:25:15 +0000 (UTC)
Message-ID: <hi58ub$c0l$1@ger.gmane.org>
References: <hi2mu8ob@ger.gmane.org>
	<a6112d286c5deeb4cc2ccfb1a90ff384440c1341.1262880109.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 19:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSx4H-0000xR-VY
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab0AGS0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 13:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006Ab0AGS0l
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:26:41 -0500
Received: from lo.gmane.org ([80.91.229.12]:38812 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289Ab0AGS0l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 13:26:41 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NSx3E-0000FM-D0
	for git@vger.kernel.org; Thu, 07 Jan 2010 19:25:40 +0100
Received: from 204.97.104.30 ([204.97.104.30])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 19:25:40 +0100
Received: from zing by 204.97.104.30 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 19:25:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 204.97.104.30
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136379>

On Thu, 07 Jan 2010 17:09:33 +0100, Thomas Rast wrote:

> This one fixes the documentation problem, but I think there's a deeper
> misunderstanding.  What did you hope to do with 'git pull --all'?  I
> suspect most people on this list would take it to mean "fetch all
> branches from all remotes, and merge them into HEAD".  I cannot imagine
> a use-case where that would make any sense.  (And it wouldn't work,
> because the current implementation of 'git fetch --all' leaves only the
> last remote's branches in FETCH_HEAD.)
> 
> From earlier discussions on the non-intuitiveness of git-pull, I kind of
> suspect you wanted to fetch all remotes, and then "update" all local
> branches that track some remote with their corresponding remote-tracking
> branches.  In which case the question is: why do you use local branches
> if you have them "blindly" track the upstream?

Let me just state first that I'm a casual git user and I would have 
missed those earlier discussions.... sorry if this old news:

I do basically just use git to just "blindly" track upstream repos/
projects using local branches.  I realize this is "dumb" in a sense,
because it's basically just a copy of the remote branch that needs to be
fast-forwarded all the time; but it's just a handy lazy way for me to
remember which remote branches I want to "watch" with just a 'git branch' 
command, plus it's easier and shorter to just type the local branch names 
I specify than to type for example "origin/something" or "myotherremote/
something".

What I thought 'git pull --all' would do is just pass down the --all flag 
to fetch and that's it:

1. do a 'git fetch --all'
2. then do a 'git merge <tracked remote branch of the current local 
branch>', basically, in my case, just fast-forwarding my current local 
branch if need be.

I didn't think that 'git pull --all' would "update" all local branches 
that needed to be fast-forwarded.  It would be too, how to say, "messy" 
in the output, and not really what 'git pull' alone was doing before.  I 
did think it could be a possibility, so, really, I was trying it out to 
see what would happen.

The other possibility you mentioned about fetching all branches and then 
merging all of them to HEAD, didn't occur to me at all.  I can see now 
how it could make more intuitive sense from the perspective of a more 
"experienced" git person.  Personally, I don't think I'd ever need 
something like that.  HTH.
