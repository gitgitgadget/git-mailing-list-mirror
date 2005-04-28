From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 14:40:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281432490.18901@ppc970.osdl.org>
References: <42703E79.8050808@zytor.com>  <1114673723.12012.324.camel@baythorne.infradead.org>
  <20050428081005.GG8612@pasky.ji.cz>  <1114676955.12012.346.camel@baythorne.infradead.org>
  <1114680199.12012.363.camel@baythorne.infradead.org> 
 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
 <1114723214.2734.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:34:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGdQ-0005GK-1g
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVD1Viz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVD1Viz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:38:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:54946 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbVD1Viw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:38:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SLcks4015658
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 14:38:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SLcjFc011604;
	Thu, 28 Apr 2005 14:38:46 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114723214.2734.9.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, David Woodhouse wrote:
> 
> Still, using the date isn't any better. It'll give results which are
> about as random as just sorting by the sha1 of each parent.

Well, it does use real information, and it is repeatable. And I don't see 
why you say that the date is meaningless, when it clearly isn't. The date 
absolutely does have meaning. 

Not having a global clock doesn't mean that clocks go away. It just means 
that they don't generate a total sort. They still generate a _partial_ 
sort, though, and it's a very valid partial sort.

The fact is, this is how the world works in real life too. Relativity 
doesn't make time "pointless". You still have "before" and "after" for 
almost all relevant events. The fact that not _all_ events can be sorted 
by "before" and "after", and different observers can disagree about some 
of the ordering does not mean that causality has gone away and that time 
is meaningless.

The same is true in a distributed system. Time still exists, and is still 
meaningful even outside the direct "causality" links implied by the 
parents. People probably discussed things, and there are methods of 
communication other than just direct parent links, and while you're not 
_guaranteed_ that "before" and "after" always makes sense, they definitely 
still exist 99% of the time.

> The best we could probably do, from a theoretical standpoint, is to look
> at the paths via each parent to a common ancestor, and look at how many
> of the commits on each path were done by the same committer.

That's quite expensive. 

> Even that isn't ideal, and it's probably fairly expensive -- but it's
> pointless to pretend we can infer anything from _either_ the dates or
> the ordering of the parents in a merge.

Wrong. The date _does_ have meaning. It shows which of the parents was 
more recent, which indirectly is a hint about which side had more activity 
going on. 

In other words, it _is_ meanginful. Maybe it's a _statistical_ meaning 
("that side is probably the active one, because it has the last commit"), 
but it's a meaning.

		Linus
