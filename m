From: linux@horizon.com
Subject: Re: What's in git.git
Date: 17 Feb 2006 09:28:36 -0500
Message-ID: <20060217142836.13137.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 15:29:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA6bD-0001aC-Ub
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 15:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWBQO2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 09:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWBQO2h
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 09:28:37 -0500
Received: from science.horizon.com ([192.35.100.1]:54081 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751432AbWBQO2g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 09:28:36 -0500
Received: (qmail 13138 invoked by uid 1000); 17 Feb 2006 09:28:36 -0500
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16350>

 - "Rebase to different branch" (1 commit):

   This was previously discussed on the list.  With this command
   line:

    	$ git rebase --onto master~1 master topic
    
   would rebase this ancestry graph to:
    
              A---B---C topic
             /
        D---E---F---G master
    
    
   another graph that looks like this:
    
                  A'--B'--C' topic
                 /
        D---E---F---G master

   Earlier, you couldn't rebase to anywhere other than on top of
   "the other branch".


Er... what does this do, again?  I couldn't find the list discussion, and
I can get this exact effect in vanilla 1.2.1 with "git rebase master~1 topic".
AFAIK, $ARGV[1] of git-rebase only has to be a commit-ish, not a branch.

OTOH, I can imagine wanting
	$ git-rebase master~1 topic topic~2

to produce

              A   B---C topic
             /   /
        D---E---F---G master

H'm... I wonder if the same syntax could be used to resolve the ambiguous
case where there are multiple possible common ancestors, e.g.

              A---B---C topic
             /   /
        D---E---F---G master

as discussed in the "git rebase behaviour changed?" thread...
