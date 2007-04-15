From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 14:01:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
 <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBqr-0001gh-MJ
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932AbXDOVBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 17:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXDOVBe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:01:34 -0400
Received: from smtp.osdl.org ([65.172.181.24]:36092 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753932AbXDOVBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 17:01:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FL1TIs025551
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 14:01:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FL1ScK020316;
	Sun, 15 Apr 2007 14:01:28 -0700
In-Reply-To: <7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.445 required=5 tests=AWL,OPT_IN
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44525>



On Sun, 15 Apr 2007, Junio C Hamano wrote:
> 
> I have been thinking about the approach using index-base to
> guard against somebody else updating the tip of branch you are
> currently on (let's call that "gremlin updates (to the HEAD)"
> for lack of better wording).  Unlike the earlier cache-tree
> based write-tree optimization, it turns out to be an uphill
> battle to make it an "opt-in" enhancement [*1*].

I never understood what you were trying to do.

The SHA1 doesn't really help.

If "next" and "pu" are the same, and you have "next" checked out, and you 
push into "pu", what happens? Since the two branches were the same, the 
SHA1 was the same before, so the BASE commit in the index will be the one 
that is updated.

The only thing that matters is that if you update the branch that HEAD 
points to, and then you'd always need to do something special, but I don't 
see that it has anything to do with what the "BASE" commit was.. It's 
purely a matter of "what does HEAD point to", independently of the index.

But no, I wasn't following that series, so I probably totally 
misunderstood what you were going after..

		Linus
