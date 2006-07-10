From: Jakub Narebski <jnareb@gmail.com>
Subject: git-update-ref (reflog) uses bogus author ident information
Date: Mon, 10 Jul 2006 22:52:32 +0200
Organization: At home
Message-ID: <e8uele$o7t$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 10 22:52:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02jt-000744-L9
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWGJUwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWGJUwP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:52:15 -0400
Received: from main.gmane.org ([80.91.229.2]:38836 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964965AbWGJUwP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 16:52:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G02je-00071Q-6E
	for git@vger.kernel.org; Mon, 10 Jul 2006 22:52:06 +0200
Received: from host-81-190-19-52.torun.mm.pl ([81.190.19.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:52:06 +0200
Received: from jnareb by host-81-190-19-52.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:52:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-52.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23653>

git-log reports 

  commit 059111c9381ce1444d17c8fc35606b0aa417ca42
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Sat Jul 8 18:52:35 2006 +0200
  
      configure.ac vertical whitespace usage cleanup
 
git-var -l shows:

 GIT_COMMITTER_IDENT=Jakub Narebski <jnareb@gmail.com> 1152564452 +0200
 GIT_AUTHOR_IDENT=Jakub Narebski <jnareb@gmail.com> 1152564452 +0200

BUT in git/.git/logs/refs/heads/autoconf I have (broken into lines):
  fe7b45a419ae62ed96148d98f6aba8710a6f6245
  059111c9381ce1444d17c8fc35606b0aa417ca42 
  Jakub Narebski <jnareb@roke.D-201> 1152377555 +0200   
  commit: configure.ac vertical whitespace usage cleanu

where "roke.D-201" are results of "hostname -f" on my computer, and are
suitable _only_ for my small private local network.

Bug or a feature?

I use git 1.4.0.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
