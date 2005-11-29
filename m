From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 18:39:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 03:40:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgvPE-0004U1-Qu
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 03:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVK2Cjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 21:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVK2Cjl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 21:39:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42657 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932339AbVK2Cjl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 21:39:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAT2dSnO009013
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 28 Nov 2005 18:39:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAT2dPqt003607;
	Mon, 28 Nov 2005 18:39:26 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12915>



On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> > 
> > but if you use a special git branch for the checked-out state, then you 
> > have to realize that nobody can push directly to it.
> 
> The idea is to have something which is private, to match the working tree, 
> which is obviously private (because it doesn't even exist from the point 
> of view of the database).

Sure. It's private because it has its own name, and you can make _sure_ 
that nobody tries to push to it by having a trigger that refuses to update 
that branch.

Now, if you want to make it also be _invisible_ (so that when others don't 
clone, they don't see what the checked-out state was when they cloned), 
you'd have to make some new rules to git. We could have rules like "branch 
names that start with '.' aren't listed", which would effectively do 
exactly that..

			Linus
