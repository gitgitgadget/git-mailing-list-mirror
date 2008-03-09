From: Jakub Narebski <jnareb@gmail.com>
Subject: Mercurial's only true "plugin" extension: inotify... and can it be done in Git?
Date: Sun, 9 Mar 2008 14:59:20 +0100
Message-ID: <200803091459.21354.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 09 14:59:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYM49-00048y-08
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 14:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYCIN7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 09:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbYCIN7O
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 09:59:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:56339 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYCIN7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 09:59:13 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1531947fga.17
        for <git@vger.kernel.org>; Sun, 09 Mar 2008 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=YEiWm/bBYjx7gPlBkH7gVV6gGj4xkGW2vFbTpXdF6u0=;
        b=o8v57SnenNboKHEM6sKgEiw2COO1ZPijiStzz4akTkpGySgsjGewYkCNiy3EeENRYDcxMJHkVdkzfXgz2cTdWuWFG7hRf1mYyIz/3gKvYXdHMPF3KAzsWTSxQHpfR7XgVSl++IQU4iVHJGecIhqPlLO3VFrclN/HUw6aOcGDJY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UMd/sShFaGDzl7TrE98eYz0rLG/uqs1+McLTI4z19/lsbAZ3HjsVvgDIPtvntzBLnaef2ZZ7YSF3eqGmviHkGMIDWS14QVaJ9dm47hwbCRG6tzsxOABKwLM54EtSt4jdLJYQUcUd3L6tVq2cThrcjNejaS8D3hG4GRYIq2anmLU=
Received: by 10.82.149.8 with SMTP id w8mr9803533bud.29.1205071151782;
        Sun, 09 Mar 2008 06:59:11 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.176])
        by mx.google.com with ESMTPS id t12sm11663977gvd.2.2008.03.09.06.59.09
        (version=SSLv3 cipher=OTHER);
        Sun, 09 Mar 2008 06:59:10 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76661>

When reading "Distributed Revision Control with Mercurial"[1] to see
how Mercurial differs from Git, in the chapter 14 "Adding functionality 
with extensions" there is description (in section 14.1) of one 
interesting extension (see also [2]), namely 'inotify' extension. 

This extension[3][4] optimises "hg status" command by asking file 
notification daemon about changed files instead of doing stat. I'm not 
sure how useful this extension is: inotify is Linux specific, and Linux 
has fast stat... nevertheless this is one example where extension 
(plug-in) framework shows that it can do more than good scriptability.

I wonder if, and how, such 'extension' could be done with Git...

References:
===========
[1] http://hgbook.red-bean.com
[2] http://www.selenic.com/mercurial/wiki/index.cgi/UsingExtensions
[3] http://hgbook.red-bean.com/hgbookch14.html#x18-31700014.1
[4] http://www.selenic.com/mercurial/wiki/index.cgi/InotifyExtension
-- 
Jakub Narebski
Poland
