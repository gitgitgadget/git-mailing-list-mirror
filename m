From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away
 revs hidden by a graft.
Date: Fri, 19 May 2006 12:02:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605191159520.10823@g5.osdl.org>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
 <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net>
 <20060518222045.GB6535@nowhere.earth> <20060518225216.GC6535@nowhere.earth>
 <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net> <20060519185558.GE6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 21:03:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhAFn-0003Ns-Uh
	for gcvg-git@gmane.org; Fri, 19 May 2006 21:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWESTDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWESTDB
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 15:03:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932473AbWESTDA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 15:03:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4JJ2qtH015090
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 May 2006 12:02:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4JJ2pwR001500;
	Fri, 19 May 2006 12:02:51 -0700
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060519185558.GE6535@nowhere.earth>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20353>



On Fri, 19 May 2006, Yann Dirson wrote:

> On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
> > Yann Dirson <ydirson@altern.org> writes:
> > 
> > > To make my point maybe more clear: if someone really wants to make a
> > > graft permanent, wouldn't some history rewriting ... be the
> > > way to go,...
> > 
> > Yes.
> 
> So if temporary usage is a typical use for grafts, don't we want to
> protect people using them from pruning ?  I got no feedback to my
> suggestion of changing the default behaviour, even to say it was a bad
> idea :)

I don't actually know how much grafts end up being used. Right now, the 
only really valid use I know about is to graft together the old kernel 
history kind of thing, and I suspect not a whole lot of people do that (I 
keep a separate kernel history tree around for when I need to look at it, 
and it doesn't happen all that often).

So I think the lack of feedback on the graft-related issue comes directly 
from that lack of graft usage. 

We _could_ decide that fsck should just follow the "real parents" and the 
grafts _both_. That's the safe thing to do by default. Possibly with a 
flag to say "prefer one over the other", or even a "prefer which-ever 
exists".

		Linus
