From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Recovering from an aborted git-rebase?
Date: Wed, 10 Jan 2007 10:53:31 -0800
Message-ID: <45A5362B.3030204@midwinter.com>
References: <45A42341.8040304@midwinter.com> <7v3b6jiv82.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 19:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4iZZ-0007s5-GX
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 19:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbXAJSxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbXAJSxI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 13:53:08 -0500
Received: from tater.midwinter.com ([216.32.86.90]:50130 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965029AbXAJSxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 13:53:07 -0500
Received: (qmail 13653 invoked from network); 10 Jan 2007 18:53:02 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 10 Jan 2007 18:53:02 -0000
User-Agent: Mail/News 1.5.0.9 (Macintosh/20070108)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b6jiv82.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36524>

Junio C Hamano wrote:
 > Doesn't "git rebase --abort" work for you at this point?

It probably would have, but he ran another "git rebase" immediately 
after hitting ctrl-C, not realizing that the interrupted one had left 
things in an odd state. I tried --abort after the fact and it said there 
was no rebase in progress; I assume the second rebase wiped out the 
temporary state from the first one.

However, all's well; Shawn's suggestion of using the reflog worked fine. 
We were able to reset back to HEAD@{3 hours ago} then do the rebase 
again, and it did the right thing. Even though we had a filesystem 
snapshot to fall back on, needless to say we were very happy to see 
there was a way to recover using nothing but git commands.

Hooray for the reflog being turned on by default!

-Steve
