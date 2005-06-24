From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The coolest merge EVER!
Date: Fri, 24 Jun 2005 12:22:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506241211100.11175@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506221433540.2353@ppc970.osdl.org>
 <7v64w4d1n6.fsf@assigned-by-dhcp.cox.net> <pan.2005.06.24.11.54.51.598627@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 21:19:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlthx-0007ke-6P
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 21:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVFXTZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 15:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263207AbVFXTZU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 15:25:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34739 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263135AbVFXTXl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 15:23:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5OJKNjA026815
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Jun 2005 12:20:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5OJKMes006899;
	Fri, 24 Jun 2005 12:20:22 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.06.24.11.54.51.598627@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Jun 2005, Matthias Urlichs wrote:

> Hi, Junio C Hamano wrote:
> 
> > I suspect there
> > would be a massive additional support needed if you want to make it easy
> > for Paul to pull changes made to gitk in your tree.
> 
> I don't think that's possible; after all, the trees are now merged, so any
> pull would fetch all of Linus' tree.

No no. 

A merge is a one-way thing. I merged Paul's tree, but Paul didn't merge 
mine. His is still independent, and you can still pull his tree without 
getting the rest of git, and Paul can still continue to work on his tree 
as if I never merged it at all.

Now, merging back isn't as easy: if any gitk changes get done in my 
"union" tree, Paul can't just pull those, becasue they now end up being 
linked to the history of the unified thing, so when pulling, he'd now end 
up getting all of the regular git stuff too.

Which is probably acceptable, but Junio's point was that this is not a 
symmetric setup: git is like a black hole that never lets any information 
escape, and once you've been sucked into a git archive, you end up not 
being able to separate it.

Or rather, you _can_ separate out pieces of it, but now it's a matter of
cherry-picking, not automatic merges. Of course, people want to be able to 
do that anyway, and normally that will also merge back perfectly, so 
there's no huge downside, except that we should make it fairly easy.

		Linus
