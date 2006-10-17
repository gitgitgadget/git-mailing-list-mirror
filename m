From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 16:09:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <Pine.LNX.4.64.0610171448150.3962@g5.osdl.org>
 <45355EEE.3060105@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 01:10:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZy4o-0003Zb-5c
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 01:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWJQXKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 19:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWJQXKV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 19:10:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54738 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751062AbWJQXKT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 19:10:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9HN9faX007638
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 16:09:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9HN9Xos010009;
	Tue, 17 Oct 2006 16:09:36 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45355EEE.3060105@utoronto.ca>
X-Spam-Status: No, hits=-0.474 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29132>



On Tue, 17 Oct 2006, Aaron Bentley wrote:
> > 
> > Excuse me? What does that "throws away your local commit ordering" mean?
> 
> Say this is the ordering in branch A:
> 
> a
> |
> b
> |
> c
> 
> Say this is the ordering in branch B:
> 
> a
> |
> b
> |\
> d c
> |/
> e
> 
> When A pulls B, it gets the same ordering as B has.  If B did not have e
> and c, the pull would fail.

Sure. But that doesn't throw away any local commit ordering. The original 
order (a->b->c) is still very much there. The fact that there was a branch 
off 'b' and there is also (a->b->d) and a merge of the two at 'e' doesn't 
take away anything from the original local commit ordering. 

> > So generating an extra "merge" commit would be actively wrong, and adds 
> > "history" that is not history at all.
> 
> It's not a tree change, but it records the fact that one branch merged
> the other.

But that's a totally specious "record". It has no meaning in a distributed 
SCM. There is absolutely zero semantic information in it.

The fact that you _locally_ want to remember where you were is a total 
non-issue for a true distributed system. You shouldn't force everybody 
else to see your local view - since it has no relevance to them, and 
doesn't add any information.

> Maybe not in Git.

I don't think there is any in bzr either. Can you explain?

In other words, the empty merge is totally semantically empty even in the 
bazaar world. Why does it exist?

		Linus
