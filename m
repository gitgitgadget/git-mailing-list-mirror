From: Len Brown <len.brown@intel.com>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 18:31:22 -0400
Message-ID: <1124836282.14730.4.camel@toshiba>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	 <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 00:25:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7hCp-000376-SH
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHWWZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVHWWZQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:25:16 -0400
Received: from zorn.worldpath.net ([206.152.180.10]:64180 "EHLO
	unix.worldpath.net") by vger.kernel.org with ESMTP id S932417AbVHWWZP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 18:25:15 -0400
Received: from toshiba (WPIS-64-140-212-33.worldpath.net [64.140.212.33])
	by unix.worldpath.net (8.12.9/8.12.9) with ESMTP id j7NMP8rQ011039;
	Tue, 23 Aug 2005 18:25:09 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1 
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7682>

On Tue, 2005-08-23 at 18:06 -0400, Junio C Hamano wrote:
> Len Brown <len.brown@intel.com> writes:
> 
> > The merge issue below is reproduced in a "git clone -l" copy
> > with no plain files present.
> 
> Meaning you did not have any file in the working tree?  It seems
> to me that what is happenning is the resolve is trying to merge
> the head of your tree and from-linus, but at the same time it
> notices that you removed those files from your working tree and
> thinks that is what you would want to do.

Doesn't matter if the merge is after a git checkout -f
or not.  I was just pointing out that it also fails
if there are no plain files checked out.

> I could get to 81065e2f415af6... commit (Linus tip at this
> moment), so if you can tell me where to snarf the other commit
> (702c7e76....) that would help me diagnose the problem a lot.

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/lenb/to-akpm.git

fails when merged into latest linus, or when latest linus
is merged into it.

I suspect some artifact of my patches being based on
one of several branches rooted at 2.6.12 is the issue,
and that in switching between latest 2.6.13 and stable
2.6.12 branches, some state has bled through that
now confuses the heck out of resolve.

thanks,
-Len
