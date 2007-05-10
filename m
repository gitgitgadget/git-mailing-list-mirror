From: linux@horizon.com
Subject: Re: Merging commits together into a super-commit
Date: 10 May 2007 17:55:15 -0400
Message-ID: <20070510215515.3084.qmail@science.horizon.com>
To: git@vger.kernel.org, kernel-hacker@bennee.com
X-From: git-owner@vger.kernel.org Fri May 11 00:29:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmH8H-0000cZ-FS
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbXEJW3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbXEJW3G
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:29:06 -0400
Received: from science.horizon.com ([192.35.100.1]:17339 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754505AbXEJW3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:29:05 -0400
X-Greylist: delayed 1610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 May 2007 18:29:04 EDT
Received: (qmail 3085 invoked by uid 1000); 10 May 2007 17:55:16 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46914>

Er... why is everyone making this so complex?

git checkout trunk	# Switch to "trunk"
git checkout branch .	# Overwrite with "branch", but stay on "trunk"
git commit

Now branch is the same tree object as "branch", but without the history.

Of course, you could be even nastier and di a direct

git-commit-tree branch^{tree} -p HEAD < commit_message

But that's not really necessary.


Starting from the branch, using the high-level commands is a bit awkward,
but it's easy enough to:

git-update-ref HEAD trunk
git-commit
