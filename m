From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: handle changed svn command-line syntax
Date: Fri, 21 Sep 2007 01:23:48 -0700
Message-ID: <20070921082348.GA5152@mayonaise>
References: <1190340155146-git-send-email-sam.vilain@catalyst.net.nz> <11903401551014-git-send-email-sam.vilain@catalyst.net.nz> <11903401551812-git-send-email-sam.vilain@catalyst.net.nz> <11903401552164-git-send-email-sam.vilain@catalyst.net.nz> <46F33734.3080408@vilain.net> <46F33A05.2000906@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 10:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYdnp-00023F-FO
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 10:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbXIUIXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 04:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbXIUIXv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 04:23:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54442 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbXIUIXu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 04:23:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1A2F17DC029;
	Fri, 21 Sep 2007 01:23:49 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 21 Sep 2007 01:23:48 -0700
Content-Disposition: inline
In-Reply-To: <46F33A05.2000906@vilain.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58833>

Sam Vilain <sam@vilain.net> wrote:
> Sam Vilain wrote:
> > Sam Vilain wrote:
> >> Previously, if you passed a revision and a path to svn, it meant to look
> >> back at that revision and select that path.  New behaviour is to get the
> >> path then go back to the revision.  The old syntax is selected with new
> >> syntax PATH@REV.  This new syntax is not supported by the old tools, so we
> >> have to try both in turn.
> > 
> > Blast, this analysis is wrong.  Hold off, I'll see what's really going
> > on and re-submit.
> 
> ok, figured it out :)
> 
> I was close!  I was just thrown off by 'svn ls PATH@REV'
> 
> The patch is the same, just the description has changed.
> 
> Subject: [PATCH] git-svn: handle changed svn cp command-line syntax
> 
> Previously, if you passed a revision and a path to svn cp, it meant to look
> back at that revision and select that path.  New behaviour is to get the
> path then go back to the revision (like other commands that accept @REV
> or -rREV do).  The more consistent syntax is not supported by the old
> tools, so we have to try both in turn.

The @REV and -rREV distinction/ambiguity has always confused me in svn,
too.  It always seems that it needed to be one way sometimes, the other
way at other times, and even _both_ at other times...

-- 
Eric Wong
