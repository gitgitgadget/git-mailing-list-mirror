From: Robin Luckey <robin@ohloh.net>
Subject: How can I tell if a SHA1 is a submodule reference?
Date: Thu, 15 May 2008 12:39:03 -0700
Message-ID: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 21:53:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjVa-0004DA-Bo
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 21:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485AbYEOTvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759200AbYEOTvb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 15:51:31 -0400
Received: from smtp202.iad.emailsrvr.com ([207.97.245.202]:43394 "EHLO
	smtp202.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186AbYEOTv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 15:51:27 -0400
X-Greylist: delayed 738 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 May 2008 15:51:27 EDT
Received: from relay10.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 462D81B5341
	for <git@vger.kernel.org>; Thu, 15 May 2008 15:39:07 -0400 (EDT)
Received: by relay10.relay.iad.mlsrvr.com (Authenticated sender: robin-AT-ohloh.net) with ESMTP id 098001B5383
	for <git@vger.kernel.org>; Thu, 15 May 2008 15:39:06 -0400 (EDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82225>

I am parsing the output of git-diff-tree to create some code analysis  
reports.

When a user adds a submodule to a repository, git-diff-tree reports  
the SHA1 of the commit from the submodule.

However, if I subsequently try to pass this SHA1 to git-cat-file, or  
indeed any other git command I have tried, I receive an error:

error: unable to find b0f8c354b142e27333abd0f175544b71a0cc444e
fatal: Not a valid object name b0f8c354b142e27333abd0f175544b71a0cc444e

This makes sense to me, since these objects are not stored locally;  
they are stored in the submodule repository.

However, is there a simple and reliable way for me to know which SHA1  
hashes refer to such submodule objects? I'd like to simply ignore them.

My ideal feature would be that `git cat-file -t` would respond with  
`submodule`, but of course this does not happen. Long term, an '-- 
ingore-submodules' flag for git would be great since I wouldn't see  
these hashes in the first place.

However, today, given an arbitrary hash, how can I tell whether it is  
a submodule commit?

Thanks,
Robin
