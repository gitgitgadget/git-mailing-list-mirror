From: Eric Raible <raible@nextest.com>
Subject: Re: Git Stash stages files if there is a conflict
Date: Mon, 18 Oct 2010 10:18:25 -0700
Message-ID: <4CBC8161.3080507@nextest.com>
References: <loom.20101015T220924-952@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Pretty Boy Floyd <boxerab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 19:18:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7tLx-0006m9-TU
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 19:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483Ab0JRRSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 13:18:25 -0400
Received: from smtps.nextest.com ([12.96.234.114]:57647 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754070Ab0JRRSY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 13:18:24 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Mon, 18 Oct 2010 10:18:23 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <loom.20101015T220924-952@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159269>

On 11:59 AM, Pretty Boy Floyd wrote:
> Hello!
> 
> I am running msysgit 1.7.3.1.  If I run stash apply, and there is a conflict,
> all of my stash changes get staged. Is this the correct behaviour? I found it a
> little surprising.

My tests indicate that the same thing happens as with any conflicted merge.
Namely: non-conflicting changes get staged, and conflicting changes are left
only in the working directory (with conflict markers added as appropriate).

See http://progit.org/book/ch3-2.html#basic_merging,
especially the part on conflicts.

> Another question: if I have stashed 10 files, and there is a conflict in one of
> them, will stash apply abort when it has a conflict, or will it apply all
> non-conflicted files.

Same as above.  In both cases the stash is unaffected, which allows
you to reset and try again.

> Finally, if I do the following:
> 
> git stash
> git pull
> git stash apply
> 
> and another developer has removed a file that I have stashed, then I am unable
> to apply the stash  on this file. How can I retrieve my changes from the stash?

One nice (relatively new feature) is "git stash branch", which makes a new
branch from an existing stash.

HTH - Eric
