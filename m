From: Brian Gernhardt <benji@silverinsanity.com>
Subject: git remote rm non-existant-remote
Date: Sun, 28 Jun 2009 10:47:23 -0400
Message-ID: <540FF00B-9DE7-4C89-9EC3-264B5BDD9CDE@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 16:48:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKvg9-0007tN-Ji
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 16:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbZF1OsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 10:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbZF1OsN
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 10:48:13 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51784 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZF1OsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 10:48:13 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id D5D3D1FFC03E; Sun, 28 Jun 2009 14:48:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CE1D41FFC02C
	for <git@vger.kernel.org>; Sun, 28 Jun 2009 14:47:21 +0000 (UTC)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122408>

I was working on updating the remotes for one of my repositories  
(adding a variety of forks) and renamed the origin branch.  When I was  
done, I tried to use "git remote rm origin" to remove the branches for  
the now dead origin.  What git-remote did was remove all of my remotes  
and the merge information for my master branch (which was moved off  
the origin remote).

This is a data loss bug.  Very bad.  `git remote rm` should either  
refuse to remove a non-existent remote or (preferably) simply remove  
any branches that exist for that remote.

When time allows I'll look into fixing this, but I thought I'd post in  
case somebody had more tuits than me this week.

~~ Brian Gernhardt
