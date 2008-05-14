From: Kevin Ballard <kevin@sb.org>
Subject: git-svn and svn:mime-type
Date: Wed, 14 May 2008 00:46:54 -0500
Message-ID: <BC05465E-C3A1-49C7-9721-FE5AB822C42E@sb.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 07:48:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw9qY-0000ya-S8
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 07:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbYENFrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 01:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbYENFrF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 01:47:05 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:42726 "EHLO
	randymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752483AbYENFrD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 01:47:03 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a5.g.dreamhost.com (Postfix) with ESMTP id AD82690C53;
	Tue, 13 May 2008 22:47:01 -0700 (PDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82076>

When adding a binary file with svn, svn:mime-type is set to  
application/octet-stream automatically. git-svn really should be able  
to do the same thing. I tried implementing it myself, but I got lost  
in the mess of perl that is git-svn.perl and couldn't figure out the  
right place to do it or how to properly detect if the new file is a  
binary file.

This is causing problems because when I commit a new binary file to  
the macports svn repo using git-svn, an email is sent out with a  
binary diff of the whole file, because the post-commit hook script on  
the svn repo uses svn:mime-type to determine if it's a binary file or  
a text file (which is all well and proper).

Any chance somebody who knows more perl or is more familiar with git- 
svn.perl could take a look at this?

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
