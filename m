From: Daniel Barkalow <barkalow@iabervon.org>
Subject: config-glob-octopus
Date: Sat, 16 Jun 2007 21:02:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706162039530.4740@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 03:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzjA0-0005FH-Io
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 03:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757723AbXFQBCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 21:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757735AbXFQBCb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 21:02:31 -0400
Received: from iabervon.org ([66.92.72.58]:4179 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757723AbXFQBCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 21:02:31 -0400
Received: (qmail 31122 invoked by uid 1000); 17 Jun 2007 01:02:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jun 2007 01:02:25 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50327>

With this configuration:

[remote "config-glob"]
	fetch = refs/heads/one:refs/remotes/rem/one
	fetch = refs/heads/two:refs/remotes/rem/two
	fetch = refs/heads/three:refs/remotes/rem/three
[branch "br-config-glob-octopus"]
	remote = config-glob
	merge = refs/heads/one
	merge = two
	merge = remotes/rem/three

It seems to me like "two" should be marked for merge, since "two" 
canonicalizes to "refs/heads/two", which matches the pattern and is 
fetched. However, current git-fetch marks it not-for-merge, and the test 
demands this.

Shouldn't the value of "merge" permit the same shortcuts that the lhs of 
"fetch" permits, even if the matching fetch line isn't using them in this 
case? (And vice versa, for a canonical value of merge when the fetch is a 
shortcut)

	-Daniel
*This .sig left intentionally blank*
