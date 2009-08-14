From: Chris Marshall <christopher.marshall@merchantlink.com>
Subject: Re: merging individual files
Date: Fri, 14 Aug 2009 14:31:17 +0000 (UTC)
Message-ID: <loom.20090814T135614-375@post.gmane.org>
References: <loom.20090813T192334-7@post.gmane.org> <4A851887.5010701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 16:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbxoh-0006q9-Lf
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 16:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbZHNObb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 10:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbZHNObb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 10:31:31 -0400
Received: from main.gmane.org ([80.91.229.2]:42329 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbZHNObb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 10:31:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MbxoX-0004Mj-UV
	for git@vger.kernel.org; Fri, 14 Aug 2009 14:31:30 +0000
Received: from 206.253.190.42 ([206.253.190.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 14:31:29 +0000
Received: from christopher.marshall by 206.253.190.42 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 14:31:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.253.190.42 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; InfoPath.1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125929>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> > This strikes me as not too bad of a procedure, as long as there is a 
graceful
> > way of determining the most recent common ancestor of br1 and master.  
What's
> > the simplest way of doing that?
> > 
> 
> That would be simply git merge-base master br1.
> 
> BUT: The main problem here is that git is not file based, but
> revision/commit/tree based. In the above, you're basically losing all
> the history common_ancestor_commit..br1 which produced br1's version of
> f1 and f2, in the sense that a git log master will not show that part of
> the history at all.

Well put, I agree.  One of the main arguments I am going to use to try to 
convince my fellows to switch from perforce to git is the usefulness of git 
blame.  I would be defeating that with my procedure.

> 
> If it makes sense to change f1 and f2 without changing f3 that probably
> means that the pertinent commit should have been split. Is it an option
> for you to rewrite br1's history? That would be the most gittish solution.

Yes, I like the idea of rewriting br1's history.

So, given that f1, f2, ..., fn were changed together in one commit X on br1, I 
want to break f1 and f2 out of X and put them into X', then leave the rest of 
the f3,...,fn changes in Y'.

Let's say X was the last commit on br1.  

What would the commands to do that look like?
