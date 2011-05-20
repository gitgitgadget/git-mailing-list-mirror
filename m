From: John Lumby <johnlumby@hotmail.com>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: Fri, 20 May 2011 15:18:37 -0400
Message-ID: <4DD6BE8D.4080708@hotmail.com>
References: <20110520162502.7854.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, timmazid@hotmail.com
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri May 20 21:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNVDg-0000Hu-18
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 21:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935699Ab1ETTSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 15:18:38 -0400
Received: from toip5.srvr.bell.ca ([209.226.175.88]:36320 "EHLO
	toip5.srvr.bell.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935691Ab1ETTSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 15:18:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApYOACa81k1GHzDf/2dsb2JhbACCJoMtoEt5iHCpKocfiR6GGQSUQIpi
Received: from bas3-toronto06-1176449247.dsl.bell.ca (HELO lumbywnt.localdomain) ([70.31.48.223])
  by toip5.srvr.bell.ca with ESMTP; 20 May 2011 15:18:37 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by lumbywnt.localdomain (8.14.4/8.14.1) with ESMTP id p4KJIb4w009205;
	Fri, 20 May 2011 15:18:38 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110520162502.7854.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174076>

On 05/20/11 12:25, George Spelvin wrote:
> Er, no.  One "git merge" command produces (at most) one commit.
> It may be that the head of the branch you merged in was already
> a merge commit, but tha
>
> You may find "gitk" useful for for visualizing all of this.

I have tried gitk.    Can you or someone tell me what the colours of the 
nodes in the top left signifies?
Specifically,   a commit of mine (done since all the merging I've been 
asking about) shows as yellow,
whereas all the ones prior to that show as blue.   (I have not altered 
or changed the colour scheme so
it's whatever the default is)

>
> A merge *is* exactly one commit.  A "merge commit" is just a commit with
> more than one ancestor.  Now, that merge can *point to* lots of other
> commits, but it doesn't exactly "consist of" them.
>
>
>
> Now, what might have happened to you was a "fast forward" merge.

Yes!    actually in the output of the merge command (that I showed in my 
original posting) it said

Updating 72a8f97..1b1cb1f
Fast-forward



> If you have a history like this:
>
> o--o--o--a--b--c--d
>
> And you ask git to merge a and d together, the result will be simply d.
> Git, by default, avoids creating useless merges in such a case.  So if
> you merge in someone else's work, and you haven't done anything locally
> since their branch split off from your HEAD, the result will not include
> a merge commit at all.  (A NEW merge commit; they branch might include
> merge commits.)
>
> Since the top merges in your example are by Dave Miller (and not by you),
> it looks like that's what happened in this case.

Yes indeed,   thanks for explaining.
So what would be the correct way,  before doing my fast-forward merge,
to have made some kind of mark pointing at "a",  which I could then have 
used
to undo the fast-forward,  without having to calculate the number of 
commits in between?
(supposing my branch was not anchored at "a" but at some much earlier 
point)?

Cheers,    John Lumby
