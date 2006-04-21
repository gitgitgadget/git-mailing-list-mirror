From: Blaisorblade <blaisorblade@yahoo.it>
Subject: [cogito-0.17.2] Bug in cg-log selection
Date: Fri, 21 Apr 2006 02:08:44 +0200
Message-ID: <200604210208.45891.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 02:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWjCn-0004qn-C8
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 02:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWDUAIw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 20:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWDUAIw
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 20:08:52 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:21396 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932149AbWDUAIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 20:08:51 -0400
Received: (qmail 44759 invoked from network); 21 Apr 2006 00:08:50 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=FixfW9gZkIHbC+5iORZUMMqOjd4WR7kZXYilL4vQIvc8+oawhBNqexoK6u9F06LNicSFWraq4lTVHVebMs9pupAG3GZhJrkZTHRoDsNbHpA2AWQWg1+TASd0rne2NYutI+9SS3StPpxCw+0Z0zoiFfuCGscvSWC55GHBgQyQxec=  ;
Received: from unknown (HELO ?151.97.230.49?) (blaisorblade@151.97.230.49 with login)
  by smtp007.mail.ukl.yahoo.com with SMTP; 21 Apr 2006 00:08:50 -0000
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.8.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19009>

(Please CC me on replies as I'm not subscribed).

On a standard Linux tree:
$ cg-branch-ls
origin  
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

this command selects two commit instead than the right one (which is selected 
by git-whatchanged):
$ cg-log -r v2.6.16:v2.6.16.9 kernel/power/process.c
shows commits 6b2467e45179a336f1e5b70d2b2ae1fe89a00133 and 
1dd6f008de5a04251d9cbe4c1cf67e4c708f9fe9, but the latter doesn't touch that 
file, and
$ git-whatchanged -p v2.6.16..v2.6.16.9 kernel/power/process.c
only shows the first commit.

Verbatim output of short listing:

$ cg-log -c -s -r v2.6.16:v2.6.16.9 kernel/power/process.c|cat
6b2467e45179a336f1e5b70d2b2ae1fe89a00133 Pavel Machek    2006-04-17 13:16 
[PATCH] Fix suspend with traced tasks
1dd6f008de5a04251d9cbe4c1cf67e4c708f9fe9 Jeff Garzik     2006-03-27 22:47 
[PATCH] sata_mv: fix irq port status usage

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
