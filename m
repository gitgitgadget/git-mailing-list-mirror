From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 15:53:43 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngms2k7.s3e.sitaramc@sitaramc.homelinux.net>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>
 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>
 <2729632a0901132333h6caf9facu871869abce5597c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 16:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN85j-00076K-T3
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:55:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbZANPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZANPyE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:54:04 -0500
Received: from main.gmane.org ([80.91.229.2]:41435 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbZANPyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:54:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LN841-0006wQ-S0
	for git@vger.kernel.org; Wed, 14 Jan 2009 15:53:54 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 15:53:53 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 15:53:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105646>

On 2009-01-14, skillzero@gmail.com <skillzero@gmail.com> wrote:
> I guess maybe a better question is how do people normally handle
> situations like mine where I did some work on branch X and I later
> realize I need only a portion of that work on branch Y? I'm not sure
> how I can change my workflow to completely eliminate these situations.
> For example, I often start a branch to add a new feature and I end up
> fixing bug A on that branch. Then other people on my team decide they
> need the fix for bug A immediately and can't wait for me to finish my
> feature branch and do a full merge.
>
> Is there some way I can change my workflow such that I can fix bug A
> (maybe on a separate branch?) and somehow apply it to both both
> branches in a way that won't result in duplicate commits?
>
> Does this kind of thing ever happen with the Linux kernel or git
> itself: somebody does a fix as part of their topic branch and the
> Linux kernel or git master wants that particular fix now, but is not
> ready for the full topic branch? Would they just suggest the fix be
> separated into its own topic branch and that merged? If so, how would
> that new topic branch merge into the original topic branch without
> resulting in a duplicate commit when it's later merged into master?

If I understand you right, you're talking about a situation
where a particular change is in two different branches, but
the SHA is different.

And yet, in your scenario, both of these branches somehow
get merged into the final branch.

In other words, a DAG of branches merging itself has a
merge, if that makes sense :-)

You may need to think about how commits flow from branch to
branch, and what branches are private, and therefore can be
rebased or change history, and what are public, and how
often and when the private ones rebase off of the public
ones.
