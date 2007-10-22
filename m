From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] "git help" and "git help -a" shouldn't exit(1) unless they error
Date: Mon, 22 Oct 2007 02:37:37 -0400
Message-ID: <20071022063737.GT14735@spearce.org>
References: <20071021214744.GH16291@srparish.net> <20071022054741.GP14735@spearce.org> <20071022061918.GM16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjqvC-0001Y4-Ee
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 08:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXJVGhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 02:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbXJVGhn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 02:37:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47718 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXJVGhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 02:37:42 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijqux-0003WA-41; Mon, 22 Oct 2007 02:37:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D5DDF20FBAE; Mon, 22 Oct 2007 02:37:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071022061918.GM16291@srparish.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61956>

Scott Parish <sRp@srparish.net> wrote:
> On Mon, Oct 22, 2007 at 01:47:41AM -0400, Shawn O. Pearce wrote:
> 
> > The issue here is t0000-basic.sh runs "../git" and tests that the
> > exit status is 1.  If it isn't (the patch above makes it 0) we just
> > abort the test suite entirely.
> 
> Shoot, i hadn't realized i had effected the "git" case. I'll
> look into this further.
> 
> By the way, should i expect all the tests to pass from the unmodified
> public HEAD? (they don't for me)

Yes.  I only push maint, master and next if they pass all tests.
If something doesn't pass I rewind the branch until it does (of
course I only rewind back to what I've previously published).

I do however push a broken pu.  Because individual topics in there
may be valid, but one or two may also be broken.  The pu branch
is meant to be a place to obtain a specific topic of interest
from so you can work further on it, or test it.  Like tonight.
pu compiles but doesn't pass the tests.

So if you are seeing one or more tests fail please go run that
specific test(s) with "-i -v" and either come up with a fix for
the test, or at least post the output of that to the mailing
list so someone else can have a chance to resolve the problem.

Since everything passes here for me on Linux/x86_64 I'm guessing
its a platform specific issue.  We still should fix it.

-- 
Shawn.
