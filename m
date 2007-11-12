From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Installing without rebuilding
Date: Mon, 12 Nov 2007 17:33:36 -0500
Message-ID: <FA694907-4845-4102-8A74-F084F88626AE@silverinsanity.com>
References: <8B92E213-17DB-4E83-B045-01CE0E7D26CB@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irhqs-00029E-P4
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbXKLWdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754868AbXKLWdj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:33:39 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:53843 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbXKLWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:33:38 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A1AB91FFC230;
	Mon, 12 Nov 2007 22:33:37 +0000 (UTC)
In-Reply-To: <8B92E213-17DB-4E83-B045-01CE0E7D26CB@silverinsanity.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64726>


On Nov 11, 2007, at 11:49 AM, Brian Gernhardt wrote:

> Git has a very clever Makefile.  Sometimes its a little overly clever.

I found a way around the Makefile cleverness.  It's ugly, but it  
requires no changes to the existing Makefile.  I'm posting it in case  
anyone finds this thread trying to do what I'm doing.  My nieve  
suggestion fails, BTW, because git-gui's Makefile does the same  
cleverness.

----- 8< -----

# Install ignoring version changes, etc.
ignore="-o GIT-VERSION-FILE -o GIT-CFLAGS -o GIT-GUI-VARS"
install="$ignore prefix=/usr/local/stow/git"
gitgui="$install gitexecdir=/usr/local/bin"
sudo make $install NO_TCLTK=Yes install install-doc
sudo make $gitgui -C git-gui install

----- 8< -----

Why do I have to go through so many hoops just to install what I've  
already compiled?

~~ Brian
