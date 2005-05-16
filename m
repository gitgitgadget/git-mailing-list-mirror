From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/4] Implement git-checkout-cache -u to update stat
 information in the cache.
Date: Mon, 16 May 2005 15:32:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505161530230.18337@ppc970.osdl.org>
References: <7vll6gqj3z.fsf@assigned-by-dhcp.cox.net> <20050516220153.GA8609@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 00:46:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXoLE-00088Q-IV
	for gcvg-git@gmane.org; Tue, 17 May 2005 00:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVEPWo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 18:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEPWl3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 18:41:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:39639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261976AbVEPWa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 18:30:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4GMULU3025065
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 May 2005 15:30:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4GMUKeG032533;
	Mon, 16 May 2005 15:30:20 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050516220153.GA8609@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.39__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Petr Baudis wrote:
>
> Dear diary, on Sun, May 15, 2005 at 11:23:12PM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > With -u flag, git-checkout-cache picks up the stat information
> > from newly created file and updates the cache.  This removes the
> > need to run git-update-cache --refresh immediately after running
> > git-checkout-cache.
> 
> I actually feel ok with this, but I wonder about Linus' opinion about
> it.  :-)

I don't think I mind any more.

My initial reluctance to do this was based on the fact that I wanted to 
avoid having something that updates things "both ways" (ie updates both 
the index file _and_ the checked-out stuff), and the largest reason for 
that was just worrying about stability.

However, it's not like we've been having major stability issues, afaik, 
and as long as the index file locking is honoured (which the patch seemed 
to do), I don't have any real issues with it.

		Linus
