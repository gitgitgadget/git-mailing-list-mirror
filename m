From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Remote "push" syntax
Date: Sun, 22 Apr 2007 16:49:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704221611040.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 22 22:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfj0X-0006Pk-5m
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 22:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030962AbXDVUuA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 16:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030963AbXDVUuA
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 16:50:00 -0400
Received: from iabervon.org ([66.92.72.58]:2428 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030962AbXDVUt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 16:49:59 -0400
Received: (qmail 24323 invoked by uid 1000); 22 Apr 2007 20:49:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Apr 2007 20:49:58 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45274>

I'm splitting the code for reading configuration of remotes out of 
builtin-push, for eventual use by builtin versions of additional commands, 
as well as to make git-push hopefully a bit nicer to use, so I'm wodnering 
about details of the behavior I should match.

Is it actually valid to have wildcards in the "push" configuration for a 
remote? git-push seems to skip them when looking at configuration files, 
and the documentation only talks about them being valid on the command 
line. Is there some reason to filter them out of the configurations, 
rather than just treating them as (unlikely) literals?

git-push currently always defaults to "origin", even if there is a 
different remote configured for the current branch. It seems to me like 
using the branch's remote would be better if there is one.

Do we care about the order of precedence of ways of configurating remotes? 
The current order is remotes > config > branches; it would be convenient 
to use config > remotes > branches, particularly because I'd like to read 
the config file first to find out the branch configuration.

	-Daniel
*This .sig left intentionally blank*
