From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 21 Apr 2007 00:11:05 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704210001380.9964@woody.linux-foundation.org>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net> <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net> <20070419100757.GB27208@admingilde.org>
 <7vmz13z4au.fsf@assigned-by-dhcp.cox.net> <20070420193142.GA13080@uranus.ravnborg.org>
 <20070421060950.GE27208@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 09:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf9kk-0000p5-S2
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 09:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933004AbXDUHLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 03:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbXDUHLX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 03:11:23 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:49817 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933004AbXDUHLW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 03:11:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3L7B6hq000441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 21 Apr 2007 00:11:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3L7B5tW000932;
	Sat, 21 Apr 2007 00:11:05 -0700
In-Reply-To: <20070421060950.GE27208@admingilde.org>
X-Spam-Status: No, hits=-3.043 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45151>



On Sat, 21 Apr 2007, Martin Waitz wrote:
> On Fri, Apr 20, 2007 at 09:31:42PM +0200, Sam Ravnborg wrote:
> > 
> > But I see no easy solution for the requireent for kernel.org to
> > a new git (and I doubt kernel.org sysadmin is too keen to
> > update to a next-based git).
> 
> Well, it only needs to be new enough to understand enough of
> submodules so that it can play the server part.

Yes. I don't think kernel.org itself really needs more than already exists 
in 'next': it needs the ability to *serve* projects (and that means doing 
the tree traversal properly and know to stop traversing at gitlink 
entries), but kernel.org itself wouldn't actually need any of the 
porcelain at all. The porcelain would all be used on the client sides.

> So once we are in that part to be stable we can merge it to master,
> so that kernel.org can use it.
> Full submodule support should then mature until the next major version
> after which git.git could use it itself.

Yes. I *think* that the gitlink stuff in 'next' is ready to be merged, if 
only because (a) there really hasn't been any disagreement about it (yeah, 
partly probably simply because it was me writing the patches, but I think 
largely because the patches simply were pretty clean!) and (b) there 
aren't any real downsides either, since it won't actually affect any 
non-gitlink use.

So there's certainly the *possible* downside that the whole approach is 
broken and won't work, and merging something broken is pointless. However, 
we've had people thinking about this for quite so time, and I don't think 
anybody seriously believes that it's not a fairly straightforward 
(although probably time-consuming and painful) thing to do all the 
porcelain stuff and it will "just work". So it's _possible_ that there is 
some roadblock that everybody has just ignored, but that just doesn't seem 
very likely.

So it could stay in 'next' until we have everything else in place too, and
the argument for getting it into master literally boils down to the fact 
that it's probably already in a good enough shape for the server side 
(even if the client side is obviously totally missing, and we may find 
*bugs* that are just hiding because it's not used very actively as a 
result). 

I don't really have a huge strong personal feeling either way. I've not 
thought about the patches lately, partly because I'm just fairly happy 
with the core, and partly because I'm just waiting for somebody else to 
start working on it, and then I'll happily jump in and fix any issues that 
come up.

So I would kind of prefer to get it merged sooner rather than later, but 
it's not a huge deal for me - what's more important is probably that 
somebody else rolls up his sleeves and gets dirty with it too ;)

			Linus
