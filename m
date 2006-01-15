From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Starting a new project remotely
Date: Sun, 15 Jan 2006 13:45:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601151323320.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jan 15 19:43:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyCqQ-0003wS-OA
	for gcvg-git@gmane.org; Sun, 15 Jan 2006 19:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWAOSnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jan 2006 13:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWAOSnM
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jan 2006 13:43:12 -0500
Received: from iabervon.org ([66.92.72.58]:54283 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750774AbWAOSnL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2006 13:43:11 -0500
Received: (qmail 2540 invoked by uid 1000); 15 Jan 2006 13:45:01 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2006 13:45:01 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14700>

Is there something currently that acts like git-clone, except that it sets 
up automatic connections in the opposite direction? That is, you run it in 
a repository with no origin, and it pushes the data to the specified 
location (which probably needs to be set up already as an empty 
repository) and sets the local side's origin remote to the location given.

This recipe seems to work:

 git branch origin master
 echo >$GIT_DIR/remotes/origin \
"URL: $repo
Pull: $head_points_at:$origin"
 git push origin $origin:refs/heads/$head_points_at

(where $origin is "origin", $head_points_at is "master", $repo is the 
target repository, "origin" is the remote you want to create, and "master" 
is the head that currently holds the commit you want to push)

	-Daniel
*This .sig left intentionally blank*
