From: Paul Jackson <pj@engr.sgi.com>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 12:20:51 -0700
Organization: SGI
Message-ID: <20050415122051.751c2a53.pj@engr.sgi.com>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	<7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
	<1113559330.12012.292.camel@baythorne.infradead.org>
	<Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, junkio@cox.net, pasky@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 21:22:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMWOO-0003qk-NY
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 21:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVDOTZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDOTYD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:24:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43741 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261902AbVDOTXS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 15:23:18 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3FL0qDU023275;
	Fri, 15 Apr 2005 14:01:03 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3FJKtlU14916504;
	Fri, 15 Apr 2005 12:20:55 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

These notions that one can always best answer questions by looking at
the content, and that "Individual files DO NOT EXIST" seem over stated,
to me.

Granted, overstated for a good reason.  A couple sticks of dynamite are
needed to shake loose some old SCM thinking habits.

===

Ingo has a point when he states:

> i believe the fundamental thing to think about is not file or line or 
> namespace, but 'tracking developer intent'.

He too overstates - it's not _the_ (as in one and only) thing.
But it's useful.  Given the traditional terseness of many engineers,
it's certainly not the _only_ thing.  The code speaks too.

===

The above two are related in this way.  Traditional SCM uses per
file (versioned controlled file, as in s.* or *,v files) metadata
to track 'developer intent'.

I'm afraid we are at risk for confusing baby (developer intent)
and bathwater (version controlled file structure of classic SCM's).

===

But we already have a pretty damn good way of tracking developer
intent that needs to fit naturally with whatever we build on top
of git.

     Mr. McGuire: I just want to say one word to you - just one word.
     Ben: Yes sir.
     Mr. McGuire: Are you listening?
     Ben: Yes I am.
     Mr. McGuire: 'Patches.'
     # the original word was 'Plastics' - The Graduate (1967)

Andrew and the other maintainers do a pretty good job of 'encouraging'
developers to provide useful statements of 'intent' in their patch
headers.

The patch series in something like *-mm, including per-patch
commentary, are a valuable part of this project.

===

I have not looked closely at what is being done here, on top of
git, for SCM like capabilities.  Hopefully the next two questions
are not too stupid:

 1) How do we track the patch header commentary?

 2) Why can't we have a quilt like SCM, not bk/rcs/cvs/sccs/... like?

For (2), anyone publishing a Linux source would periodically announce an
<sha1> value, attached to some name suitable for public consumption.

For example, sometime in the next month or so, Linus would announce
that the <sha1> of 2.6.12 is so-and-so.  That would identify the
result of applying a specific set of patches, resulting in a specific
source tree contents.  He would announce a few 2.6.12-rc* <sha1>'s
between now and then.

Between now and then, Andrew would (if using these tools) have published
several <sha1> values, one each for various 2.6.12-rc*-mm* versions.

If you explode such a <sha1> all out into a working directory, you get
both the source contents in the appropriately named files, and the
quilt-style patches subdirectory, of the patch series that gets you
here, starting from some Time Zero for that series of published kernel
versions.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
