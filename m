From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Help understanding "rebase"
Date: Tue, 10 Mar 2009 16:30:21 -0500
Message-ID: <KVXTFwpJn-0uEQYfgfg9YwrrimNYx6hbxe73y6qLYxfHYZH9eE4N4g@cipher.nrlssc.navy.mil>
References: <gp6kqj$tkb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 22:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh9YR-0007XJ-0z
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 22:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbZCJVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbZCJVa3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 17:30:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54324 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbZCJVa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 17:30:28 -0400
Received: by mail.nrlssc.navy.mil id n2ALUMQU003596; Tue, 10 Mar 2009 16:30:22 -0500
In-Reply-To: <gp6kqj$tkb$1@ger.gmane.org>
X-OriginalArrivalTime: 10 Mar 2009 21:30:22.0167 (UTC) FILETIME=[6AF36670:01C9A1C7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112850>


John M. Dlugosz wrote:
> Here is the situation:  An old topic branch containing 3 commits.  A dev
> branch that has recently been merged.  To catch up the topic's work
> before adding it to dev, I expected that rebase would do what I ended up
> doing manually, detailed below.
> 
> Instead, it crunched away for a long time and gave errors applying patches.
> 
> So I did it manually by checking out dev, then cherry-picking each of
> the three commits. Actually, this left it on top of dev, but suppose I
> had created a new branch at dev, cherry-picked the stuff from the old
> topic branch, and then deleted the old topic branch.  Now I have a new
> topic branch with the rebased changes, albeit with a different branch
> name.  Point is, there were no conflicts and the changes were simple, so
> cherry-picking each node was clean.
> 
> So, what did the rebase command try to do?  I think it may have
> something to do with finding a common root between the topic and dev,
> which, due to the merge, was a long way back.  Something like this:
> 
>       o--o--   ...  --o
>      /                 \
>     A--...--B--   ... --C--D <== dev
>              \
>                   q--r--s  <== topic
> 
> 
> I was able to cherry-pick q,r,s on top of D without any issues.  So why
> did rebase get in such a tizzy?

It may help those who know the internals of git-rebase if you supplied the
commands you used and your git version.

So, you're saying you did

   git checkout topic
   git rebase dev

or the equivalent

   git rebase dev topic

?  Are you sure you didn't get the arguments to rebase reversed?

-brandon
