From: Shawn Pearce <spearce@spearce.org>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Thu, 25 May 2006 21:11:53 -0400
Message-ID: <20060526011153.GA27720@spearce.org>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 26 03:12:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjQs2-0007xy-I3
	for gcvg-git@gmane.org; Fri, 26 May 2006 03:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWEZBL6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWEZBL6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 21:11:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:31662 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030204AbWEZBL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 21:11:57 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FjQrh-0000hr-4s; Thu, 25 May 2006 21:11:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A6F3220E46C; Thu, 25 May 2006 21:11:53 -0400 (EDT)
To: Stefan Pfetzing <stefan.pfetzing@gmail.com>
Content-Disposition: inline
In-Reply-To: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20775>

Stefan Pfetzing <stefan.pfetzing@gmail.com> wrote:
> Hi,
> 
> for some reason I could not yet figure out, t8001-annotate.sh fails at test 
> 18.
> 
> --- snip ---
> *   ok 17: some edit
> * expecting success: check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
> Author A (expected 1, attributed 1) good
> Author B1 (expected 1, attributed 1) good
> Author D (expected 1, attributed 2) bad
> Author A U Thor (expected 1, attributed 1) good
> Author B2 (expected 1, attributed 1) good
> Author B (expected 1, attributed 1) good
> * FAIL 18: some edit
>        check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
> * failed 1 among 18 test(s)

I've been seeing the same failed test case for a long time now on
my own Mac OS X system.  I think it has to do with the "git blame"
vs. "git annotate" war which never really happened.

I think we had hoped that one of the two tools would prove to be
_the_ annotation/blame tool and would get used but thus far that
hasn't happened.  Since they are two different implementations
they also differ slightly over how they attribute a change across
a merge, and in this case annotate is producing a different result
from blame - but that different result isn't considered to be wrong
so it hasn't been changed in annotate.  Meanwhile the test has stayed
broken as a reminder that these two generate different results.

-- 
Shawn.
