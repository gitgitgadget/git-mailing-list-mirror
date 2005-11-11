From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: merge-base: fully contaminate the well.
Date: Fri, 11 Nov 2005 08:18:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511110805350.4627@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
 <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511090800330.3247@g5.osdl.org> <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511091348530.4627@g5.osdl.org> <7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511091518370.4627@g5.osdl.org> <7vzmobuc00.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511102125510.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 17:20:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eabbj-0001xh-Ll
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVKKQS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVKKQS3
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:18:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbVKKQS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 11:18:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jABGIMnO011957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 11 Nov 2005 08:18:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jABGILtr012291;
	Fri, 11 Nov 2005 08:18:21 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viruzu3du.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11613>



On Thu, 10 Nov 2005, Junio C Hamano wrote:
> 
> > Btw, I don't think your contamination logic is necessarily complete. We 
> > may not even have parsed some of the commits that end up being on that 
> > strange corner case.
> 
> I haven't tried walking any other test cases, but wouldn't that
> be arguing that the our assumption that the current merge-base
> is at least complete if not optimum?

Oh yes, it's always complete, even though it may not be optimal. And it's 
going to be optimal in all realistic cases.

And even in the unrealistic cases if we end up returning a commit that is 
actually reachable by another one (through at least two levels of other 
commits that were in the wrong date-order with the _other_ ways of 
reaching that commit), the recursive strategy of merging the merge-bases 
will always end up boiling it doing to the optimal thing.

So I think this is absolutely 100% correct.

			Linus
