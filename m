From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: More help with "pull" please
Date: Wed, 1 Apr 2009 22:15:37 +0200
Message-ID: <4659A860-4AF5-4E34-B38E-60C926E2BAE1@dbservice.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp6t2-0001iT-IS
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 22:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133AbZDAUQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933830AbZDAUQK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 16:16:10 -0400
Received: from office.neopsis.com ([78.46.209.98]:58301 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759330AbZDAUQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 16:16:08 -0400
Received: from [192.168.0.130] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES128-SHA (128 bits));
	Wed, 1 Apr 2009 22:16:03 +0200
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A7D4D9A@EXCHANGE.trad.tradestation.com>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115411>


On Apr 1, 2009, at 9:28 PM, John Dlugosz wrote:

> I've actually given up on using "git pull" at all, preferring to fetch
> first, examine in gitk, and then decide whether to merge or whatever.
>
> The problem I have is that it seems to always want to merge  
> "something"
> with the current checked-out branch.  It always throws the remote HEAD
> into the mix, or if fetch lines are set up in the configuration file,
> takes the first thing on there regardless of which branch I'm  
> currently
> checked out.  Maybe I'm wrong, but I just re-read the man page,  
> forward
> and backwards, and am more bewildered than ever.

When you create a branch, you can tell git which remote branch it  
tracks, like this:

$ git branch --track mynext origin/next

So whenever you are on brach 'mynext' and do a git-pull, it will fetch  
and merge origin/next.

You can do the same with the git-checkout command:

$ git checkout --track origin/next

This will create a local branch 'next' which tracks 'origin/next'

> Anyway, I want to help out a co-worker who has a more specialized
> situation that may be right for a pull.  Also, I'll talk him through
> cloning the remote from the beginning, so the config files won't be  
> all
> strange or not setup from the previous users.
>
> The only remaining issue is the remote in question:  it is not a bare
> repository, and may be in use locally as well, at least for  
> maintenance.
> So I can't trust its HEAD to be anything reasonable at any given time.
>
> This person wants to track a remote branch tip.  When that advances or
> otherwise changes on the remote, update the working tree to match.  It
> will always use the same branch, let's call it ReleaseCandidate for  
> this
> discussion.
>
> My question is:  What is the easiest way to create this local  
> repository
> and operate it so that he can just keep it following that branch on  
> the
> remote?

$ git clone $url XXX
$ cd XXX
$ git checkout --trach origin/ReleaseCandidate
...
$ git pull # will automatically fetch and merge origin/ReleaseCandidate

tom
