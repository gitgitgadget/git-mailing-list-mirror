From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git-commit.sh: convert run_status to a C builtin
Date: Fri, 8 Sep 2006 03:34:52 -0400
Message-ID: <20060908073452.GA25343@coredump.intra.peff.net>
References: <64c62cc942e872b29d7225999e74a07be586674a.1157610743.git.peff@peff.net> <20060907063621.GC17083@coredump.intra.peff.net> <7vzmdbqke3.fsf@assigned-by-dhcp.cox.net> <20060908054226.GA19537@coredump.intra.peff.net> <7v64fynbpg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 09:35:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLatI-0003c7-4h
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 09:35:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIHHez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 03:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWIHHez
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 03:34:55 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:30164 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750703AbWIHHey (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 03:34:54 -0400
Received: (qmail 2318 invoked from network); 8 Sep 2006 03:34:18 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Sep 2006 03:34:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  8 Sep 2006 03:34:52 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64fynbpg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26680>

On Thu, Sep 07, 2006 at 10:56:11PM -0700, Junio C Hamano wrote:

> I just wanted to point it out because I felt the names to
> programmers are slightly different matter.

Fair enough. Do you want to change git-runstatus? It should ideally not
be used by end users at all (and hopefully can eventually go away if
git-status and git-commit become builtins).

> > wt_status? ucu_status (updated, changed, untracked)?
> Yeah, something along those lines.

I think wt_status is the most reasonable of those.

> In a distant past I saw some terminals get confused near the
> edge if you do that, but these days everybody is on some sort of
> Xterm so it may not matter.  But that would probably be nice to
> fix.

OK, it will take a little wrangling with the color_printf interface, but
it should be doable.

> > OK. Besides the things you mentioned, what improvements would you like
> > to see?
> Besides the things I mentioned?  I dunno offhand -- otherwise I
> would have mentioned them ;-).

Heh. OK, I assumed your previous comment hinted at hidden depths of
dissatisfaction, but clearly not. :) Patches forthcoming...

-Peff
