From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] progress.c: avoid use of dynamic-sized array
Date: Sun, 8 Jun 2008 13:52:42 -0600
Message-ID: <Pine.LNX.4.64.0806081351220.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806080924330.18454@xenau.zenez.com>
 <alpine.DEB.1.00.0806082029170.1783@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 21:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5QxX-0003Mi-0p
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 21:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbYFHTwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 15:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbYFHTwo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 15:52:44 -0400
Received: from zenez.com ([166.70.62.2]:5943 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716AbYFHTwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 15:52:43 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id B857CE5FCD; Sun,  8 Jun 2008 13:52:42 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id A3CAAE5FC8;
	Sun,  8 Jun 2008 13:52:42 -0600 (MDT)
In-Reply-To: <alpine.DEB.1.00.0806082029170.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84313>

On Sun, 8 Jun 2008, Johannes Schindelin wrote:
> On Sun, 8 Jun 2008, Boyd Lynn Gerber wrote:
> > Dynamically sized arrays are gcc and C99 construct.  Using them hurts
> > portability to older compilers, although using them is nice in this case
> > it is not desirable.  This patch removes the only use of the construct
> > in stop_progress_msg(); the function is about writing out a single line
> > of a message, and the existing callers of this function feed messages
> > of only bounded size anyway, so use of dynamic array is simply overkill.
> > 
> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
> > 
> > --
> > Boyd Gerber <gerberb@zenez.com>
> > ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
> > 
> > ---
> 
> Do you really want to have your mail signature in the commit message, 
> particularly because...
> 
> > [...]
> >
> >  	clear_progress_signal();
> >  	free(progress->throughput);
> > -- 
> > 1.5.2.4
> > 
> > 
> > --
> > Boyd Gerber <gerberb@zenez.com>
> > ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
> 
> You repeat it at the end of the mail anyway?
> 
> The patch looks fine to me, though.

I put it in because in the git repo it is not their.  Only in the email.  
It is fine to remove it.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
