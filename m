From: Jing Xue <jingxue@digizenstudio.com>
Subject: git rm --cached
Date: Thu, 1 Nov 2007 22:17:11 -0400
Message-ID: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 03:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inm6N-00045H-SR
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 03:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbXKBCRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 22:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbXKBCRX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 22:17:23 -0400
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:36167
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753337AbXKBCRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 22:17:22 -0400
Received: (qmail 31859 invoked from network); 2 Nov 2007 02:17:19 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 02 Nov 2007 02:17:18 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id CA34F10008A
	for <git@vger.kernel.org>; Fri,  2 Nov 2007 02:17:18 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sH++ogthdYN2 for <git@vger.kernel.org>;
	Thu,  1 Nov 2007 22:17:12 -0400 (EDT)
Received: from fawkes (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 8933010007A
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 22:17:12 -0400 (EDT)
Received: by fawkes (Postfix, from userid 1000)
	id 8778B63725; Thu,  1 Nov 2007 22:17:11 -0400 (EDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63048>


In the following scenario, why do I have to run 'git reset' following
'git rm --cached 1.txt' to revert to exactly where I was before 'git add
1.txt'?  Shouldn't 'git rm --cached' have done that already?

jingxue@fawkes:~/workspace/t1.git$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   1.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
jingxue@fawkes:~/workspace/t1.git$ git add 1.txt
jingxue@fawkes:~/workspace/t1.git$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   1.txt
#
jingxue@fawkes:~/workspace/t1.git$ git rm --cached 1.txt
rm '1.txt'
jingxue@fawkes:~/workspace/t1.git$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       deleted:    1.txt
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       1.txt
jingxue@fawkes:~/workspace/t1.git$ git reset
1.txt: needs update
jingxue@fawkes:~/workspace/t1.git$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   1.txt
#
no changes added to commit (use "git add" and/or "git commit -a")

Thanks.
-- 
Jing Xue
