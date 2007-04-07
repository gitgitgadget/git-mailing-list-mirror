From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] git pull and importers
Date: Fri, 6 Apr 2007 22:48:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704062239420.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 04:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ha0z2-0001Nm-Pi
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 04:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbXDGCsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 22:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXDGCsx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 22:48:53 -0400
Received: from iabervon.org ([66.92.72.58]:4190 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965084AbXDGCsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 22:48:52 -0400
Received: (qmail 15296 invoked by uid 1000); 7 Apr 2007 02:48:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2007 02:48:51 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43958>

There's an SVN project I'm trying to track with git-svn. "git svn fetch" 
fetches and imports the commits perfectly, but I can't figure out a way to 
merge upstream commits into my branch automatically.

It seems like the right solution should be:

[remote "origin"]
	importer = svn
	url = svn://ixion.tartarus.org/main
	fetch = puzzles:refs/remotes/puzzles
[branch "master"]
	remote = origin
	merge = puzzles

Which would mean that it would use "git svn fetch" instead of "git fetch" 
for that remote, and "git svn fetch" would use that config section instead 
of its current config section.

Any reason this couldn't be made to work?

	-Daniel
*This .sig left intentionally blank*
