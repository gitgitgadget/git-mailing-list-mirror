X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: 'git diff HEAD' pager quirks
Date: Thu, 14 Dec 2006 17:01:46 -0500
Message-ID: <4581C9CA.5060207@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 23:08:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 3987 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 18:08:14 EST
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34427>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzgY-0007VI-KO for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751740AbWLNXIP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWLNXIP
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:08:15 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50436 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751741AbWLNXIO
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:08:14 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GuyeA-0003XG-R5 for git@vger.kernel.org; Thu, 14 Dec 2006
 22:01:47 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

So, after a 'yum upgrade' brought me git-core-1.4.4.2-2.fc6, I 
discovered that "git diff HEAD" will produce paged output, if at a tty. 
  Nice, I like the improvement.

However, when there is no output at all (nothing dirty in working dir), 
"git diff HEAD" will sometimes invoke $PAGER ("/usr/bin/less" here) 
__anyway__.

This causes the cursor to jump down 20-30 lines, before returning the 
command prompt.  Annoying.  Example follows.

	Jeff


---------------------<begin BEFORE>----------------------------
[jgarzik@pretzel libata-dev]$ git diff HEAD
[jgarzik@pretzel libata-dev]$
---------------------<end BEFORE>------------------------------

---------------------<begin AFTER>-----------------------------
[jgarzik@pretzel libata-dev]$ git diff HEAD



















[jgarzik@pretzel libata-dev]$
