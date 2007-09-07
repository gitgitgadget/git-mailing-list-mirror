From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Distributing revisions to patches in a series
Date: Thu, 6 Sep 2007 22:34:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709062219320.13907@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 07 04:34:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITTfy-0005u0-Ms
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 04:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbXIGCe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 22:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbXIGCe0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 22:34:26 -0400
Received: from iabervon.org ([66.92.72.58]:1886 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932685AbXIGCeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 22:34:25 -0400
Received: (qmail 27821 invoked by uid 1000); 7 Sep 2007 02:34:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Sep 2007 02:34:24 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57965>

I was wondering if anybody's got a good process for the following 
situation: I've just rebased a series onto the new origin/next. In the 
afterwards, I determined that some of the intermediate merges weren't 
right (the patch to split bundle-handling out of builtin-bundle didn't 
pick up fixes to builtin-bundle). I also found and fixed a warning added 
by my series. I want to take these changes, split them into individual 
hunks, and apply each hunk to the appropriate commit from the series 
before that commit, generating a new series.

I know how to do it by figuring out where the hunk should go myself and 
branching, fixing, and rebasing, but I was wondering if there was a magic 
script to just do it. It seems like it should be an automatable operation 
(take the last commit as a set of hunks, and walk back up the history, 
leaving each one at the oldest commit to which it applies cleanly; when 
all of the hunks are allocated, generate a new history by amending 
commits).

	-Daniel
*This .sig left intentionally blank*
