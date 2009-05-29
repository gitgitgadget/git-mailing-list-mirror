From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn fetch
Date: Fri, 29 May 2009 18:10:55 +0200
Message-ID: <4A20090F.3070608@drmicha.warpmail.net>
References: <gvots5$uob$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Doki Pen <doki_pen@doki-pen.org>
X-From: git-owner@vger.kernel.org Fri May 29 18:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA4gG-0007Q1-Iz
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 18:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760695AbZE2QLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 12:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759338AbZE2QLK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 12:11:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52914 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758215AbZE2QLJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 12:11:09 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9C183346D3C;
	Fri, 29 May 2009 12:11:09 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 29 May 2009 12:11:09 -0400
X-Sasl-enc: mTorQMfCFdBEm5Is4SZwFEsIM+GXYaXOpPayrDWPt97z 1243613469
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E55F330FE1;
	Fri, 29 May 2009 12:11:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <gvots5$uob$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120286>

Doki Pen venit, vidit, dixit 29.05.2009 17:09:
> I'm sorry if this has been brought up before, I did look through the 
> archive and didn't see it.  
> 
> I am working with a repo that has about 7000 commits and about 100 
> branches/tags.  I've been using git-svn for about 4 months now and love 
> it.  The problem I'm experiencing is that everytime a new branch is added, 
> git svn fetch seems to download the entire history all the way from r1.  
> Is this the expected behavior?  If so, why is that?  Don't we already have 
> the old revisions from trunk and other branches?  
> 

AFAIK git-svn has to go back in order to search for possible earlier
history of $newbranch. For git-svn, the following two scenarios are
basically equivalent:

- a new branch is added to the svn repo
- you change your git-svn config so that a new branch becomes
"interesting" (which had been skipped before)

git-svn treats them the same way ("a branch we don't know about yet"),
because it can't really (reliably) distinguish between them.

Michael
