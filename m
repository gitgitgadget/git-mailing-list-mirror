From: Maaartin <grajcar1@seznam.cz>
Subject: Tracking branches and pulling on remote
Date: Wed, 5 Jan 2011 00:58:47 +0000 (UTC)
Message-ID: <loom.20110105T013525-413@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 01:59:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaHiY-0003px-79
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 01:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab1AEA7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 19:59:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:37022 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab1AEA7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 19:59:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PaHiM-0003lc-Jv
	for git@vger.kernel.org; Wed, 05 Jan 2011 01:58:58 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 01:58:58 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 01:58:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.7.62 Version/11.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164536>

1.
I'm using git for couple of months and still don't get it. In a new repo a have 
two branches: master and X. I pushed both to the server, everything seems to 
work. However, there's origin/master but no origin/X in my repo. When I execute
git fetch --all -v
only master gets fetched. I've created an entry in the .git/config, no change. 
I've tried things like
git branch --track X origin/X
and all of them ends with an error message. Finally I've found out that
git config --add remote.origin.fetch refs/heads/X:refs/remotes/origin/X
seems to do it, was it right?

2.
I'd like to do some (at least for now) private changes on a foreign project. The 
ideal way I think about would be the following:
- my local repo is linked to my own server (for backup purposes and for private 
cooperation with a college)
- the repo on my server is linked to the github hosting the project
Now, I'd need to do something like
ssh myserver git fetch
and everything would be fine. I can do it this way, but I'd prefer something like
git remote fetch
or even
git fetch --remote-too
which would first make my server fetch from its origin and then my local repo 
fetch from my server. Is there such a thing? Would you recommend me doing it in 
a different way?
