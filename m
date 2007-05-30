From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 22:02:36 -0400
Message-ID: <20070530020236.GI7044@spearce.org>
References: <1180478596243-git-send-email-jbowes@dangerouslyinc.com> <7vabvn5hca.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, James Bowes <jbowes@dangerouslyinc.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 04:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtDWT-0007km-0i
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbXE3CCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXE3CCn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:02:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41430 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbXE3CCm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:02:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtDW7-0002mH-Ad; Tue, 29 May 2007 22:02:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9FAA020FBAE; Tue, 29 May 2007 22:02:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabvn5hca.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48721>

Junio C Hamano <junkio@cox.net> wrote:
> James Bowes <jbowes@dangerouslyinc.com> writes:
> 
> > find_short_packed_object was not loading the pack index files.
> > Teach it to do so.
> >
> > Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
> 
> I think this is the proper fix of the problem I was unhappy
> about with 'next'

Actually this bug is exactly the reason why I *always* run 'next'
in production use on all of my systems, and why I also get a number
of coworkers to run it.  Many people beating on the same code in
weird ways notice things.

Today I found this because I have a shell script that tried to
do something of the form "git checkout v1.8.0-18-g18as1f' and Git
couldn't believe that was a revision...  It held up day-job work
for an hour while I tracked it down, but I did catch it.  ;-)

-- 
Shawn.
