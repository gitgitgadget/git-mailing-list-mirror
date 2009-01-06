From: Daniel Quinlan <danq@brtt.com>
Subject: git merge failure: what next?
Date: Mon, 5 Jan 2009 17:41:55 -0700
Message-ID: <200901060042.n060g1Cm014451@rs40.luxsci.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 01:51:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK0AT-0003DL-G9
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 01:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbZAFAuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 19:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZAFAuP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 19:50:15 -0500
Received: from rs40.luxsci.com ([65.61.166.82]:39133 "EHLO rs40.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbZAFAuO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 19:50:14 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Jan 2009 19:50:14 EST
Received: from rs40.luxsci.com (localhost [127.0.0.1])
	by rs40.luxsci.com (8.13.1/8.13.7) with ESMTP id n060gjhW014906
	for <git@vger.kernel.org>; Mon, 5 Jan 2009 18:42:45 -0600
Received: (from root@localhost)
	by rs40.luxsci.com (8.13.1/8.13.7/Submit) id n060g1Cm014451
	for git@vger.kernel.org; Tue, 6 Jan 2009 00:42:01 GMT
Received: (from danq@brtt.com) by Lux Scientiae SMTP Processor; Tue, 06 Jan 2009 00:42:01 +0000
X-Comment: Lux Scientiae SMTP Processor Message ID - 1231202521-3346946.26407269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104610>

I cannot figure out how to resolve a problem with git merge.

I usually use "git pull" to merge changes from a central repository  
before pushing local changes to the central repository.
I've learned from bitter experience not to have changes in the  
intermediate cache/stage/index, since that always leads to
confusion -- but it's possible I failed to follow that rule in this  
case.

The working tree is currently dirty with lots of changes I'm not ready  
to commit.

Anyway, now  I get this:

> % git pull
> *** : needs update
> 	.
> 	.
> fatal: Entry 'correct/orblag/orblag' would be overwritten by merge.  
> Cannot merge.
> Merge with strategy recursive failed.
> %
>

At this point, I usually do something like remove the 'correct/orblag/ 
orblag', knowing that I just want
whatever is in the repository (or ultimately, not caring, provided I  
can get past this message).

However, that doesn't work:

> % rm correct/orblag/orblag
> rm: cannot remove `correct/orblag/orblag': No such file or directory
>

Also,

> % git mergetool
> No files need merging
>


I'm stuck.

A related problem is that although I'm usually able to get past this  
problem by deleting
a file, this can be tedious as there may be multiple files with  
conflicts, but git-merge only
lets me know about the first one it finds.  Knowing all the conflicts  
right off the bat would
give me an idea about the breadth of the problem.

Another possibility I might like to see is the CVS approach -- just  
create combined files
with all the differences in them instead of hanging up on the first  
conflict.

Suggestions?
Thanks,
-- danq
