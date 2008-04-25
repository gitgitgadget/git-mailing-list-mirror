From: John Wiegley <johnw@newartisans.com>
Subject: Problem with git fetch over http://
Date: Fri, 25 Apr 2008 16:42:25 -0400
Message-ID: <63F7B390-32D1-458A-8ED9-D5AC62F46745@newartisans.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 23:06:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpV6U-0003tI-6R
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 23:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761325AbYDYVEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 17:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760360AbYDYVEX
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 17:04:23 -0400
Received: from johnwiegley.com ([208.70.150.153]:39979 "EHLO
	mail.johnwiegley.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753263AbYDYVEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 17:04:22 -0400
X-Greylist: delayed 1311 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Apr 2008 17:04:22 EDT
Received: from [192.168.2.100] (unknown [72.51.86.36])
	by mail.johnwiegley.com (Postfix) with ESMTP id D30E4422215
	for <git@vger.kernel.org>; Fri, 25 Apr 2008 15:42:29 -0500 (CDT)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80348>

Hello, I'm using the Builtbot to pull sources from a Git repository,  
and have found that the Buildbot's Git step always uses git-fetch -- a  
detail of Buildbot which I currently have little control over.

This is no problem if the git:// protocol is used, but using fetch  
with http:// doesn't work.  This has been mentioned elsewhere:

   http://lists.berlios.de/pipermail/bitbake-dev/2007-November/000765.html

Here's a quick example of what I mean:

   cd /tmp ; mkdir foo ; cd foo ; git init

   git fetch git://newartisans.com/ledger.git	# works fine

   cd /tmp ; rm -fr foo ; mkdir foo ; cd foo ; git init

   git fetch http://newartisans.com/git/ledger.git  # fails

This is happening with git-1.5.5 on the server, Apache 2.2 and  
git-1.5.5.1 on the client.

Thanks,
   John
