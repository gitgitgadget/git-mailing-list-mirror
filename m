From: Chris Marshall <christopher.marshall@merchantlink.com>
Subject: Re: merging individual files
Date: Fri, 14 Aug 2009 16:14:34 +0000 (UTC)
Message-ID: <loom.20090814T160738-200@post.gmane.org>
References: <loom.20090813T192334-7@post.gmane.org> <4A851887.5010701@drmicha.warpmail.net> <loom.20090814T135614-375@post.gmane.org> <4A858298.4020702@drmicha.warpmail.net> <4A858B3B.3000208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 18:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbzQg-0002bh-S8
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 18:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755800AbZHNQOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 12:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbZHNQOt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 12:14:49 -0400
Received: from main.gmane.org ([80.91.229.2]:40748 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755701AbZHNQOs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 12:14:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MbzQR-0008LS-IG
	for git@vger.kernel.org; Fri, 14 Aug 2009 16:14:44 +0000
Received: from 206.253.186.24 ([206.253.186.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 16:14:43 +0000
Received: from christopher.marshall by 206.253.186.24 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 16:14:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.253.186.24 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.12) Gecko/2009070611 Firefox/3.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125935>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> > If you're on br1, I would:
> > 
> > git rebase -i X^
> > # change "pick" to "edit" in front of X in the list you get
> > git checkout X^ -- f3 f4 f5
> > git commit --amend
> > git checkout X -- f3 f4 f5
> > git commit
> 
> followed by
> 
> git rebase --continue
> 
> of course ;)
> 
> > 
> > For the 2nd commit, using the -c option may be beneficial.
> > 
> > Cheers,
> > Michael
> > 
> 
> 

Michael:

Thanks so much for your help, this is a lot of fun!

It occurs to me that another way (that doesn't use rebase) would be this:
git branch -m br1 br1-old
git checkout br1-old
git reset HEAD~
git checkout -b br1
git add f1
git commit -m "f1"
git add f2 f3
git commit -m "f2"
git branch -d br1-old (history eraser button ;-)

git checkout master
git merge br1~ (which now only pulls f1's changes)
(work for a while)
git merge br1 (which now pulls f2 and f3).

I like this sequence because it's so explicit about what's going on.

Are there any conceptual problems going this route that I am missing that might
screw up history?

Chris Marshall
