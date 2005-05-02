From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Complete http-pull; where should it go?
Date: Sun, 1 May 2005 18:50:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505011840590.2162@ppc970.osdl.org>
References: <Pine.LNX.4.21.0505011656270.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0505011616230.22864@ppc970.osdl.org>
 <Pine.LNX.4.58.0505011638370.22864@ppc970.osdl.org> <7vsm16qyia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 02 03:44:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSPyS-0008Cd-3d
	for gcvg-git@gmane.org; Mon, 02 May 2005 03:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVEBBtj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 21:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVEBBt0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 21:49:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:57221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261624AbVEBBs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 21:48:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j421mDs4017078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 18:48:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j421mC1A008170;
	Sun, 1 May 2005 18:48:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm16qyia.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Junio C Hamano wrote:
>
> Shameless plug but could you take a look at how my JIT does it,
> at <http://members.cox.net/junkio/JITNotes.txt>, especially
> scroll down to near the bottom "Syntax to naming a snapshot or a
> commit" section?

Hmm.. I actually implemented it, because it's simple to implement, but now 
that I've tried using it, I just find it to be too much like line noise to 
do

	git-diff-tree -p 0-HEAD HEAD

for "parent to current". The notation "-HEAD" also works, but since that
looks like a command line flag, it's usually not useful, except when
combined with other stuff, ie "0---HEAD" is "three parents up".

> I still think this kind of thing belongs to Porcelain not
> Plumbing, though.

I don't entirely disagree, and I suspect that Porcelain ends up using the 
pure hex numbers which are always unambiguous.

That said, I end up still using the raw plumbing, so it's actually nice to 
have some simple shorthand. I just don't know if the parent thing ends up 
being all that useful.

Anyway, it's there. I don't love the parent syntax, but on the other hand,
I don't know how often I'd even end up using it (while the tag and HEAD
names are _very_ useful), so maybe it just doesn't matter.

		Linus
