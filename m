From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git log -z still outputting newlines?
Date: Mon, 30 Apr 2012 10:58:04 -0700
Message-ID: <86ty01qez7.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 19:58:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOurW-000470-D3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756417Ab2D3R6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 13:58:09 -0400
Received: from lax-gw15.mailroute.net ([199.89.0.115]:59233 "EHLO
	gw15.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528Ab2D3R6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 13:58:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 7A459E36226
	for <git@vger.kernel.org>; Mon, 30 Apr 2012 17:58:06 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw15.lax01.mailroute.net ([199.89.0.115])
	by localhost (gw15.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id cgVLv3_jVmv9 for <git@vger.kernel.org>;
	Mon, 30 Apr 2012 17:58:05 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw15.lax01.mailroute.net (Postfix) with ESMTP id 7785CE3620F
	for <git@vger.kernel.org>; Mon, 30 Apr 2012 17:58:05 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 71DFF22C0; Mon, 30 Apr 2012 10:58:04 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.5; tzolkin = 3 Chicchan; haab = 8 Uo
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196586>


$ git log -z --format='%cE' -5 | od -c
0000000    g   i   t   s   t   e   r   @   p   o   b   o   x   .   c   o
0000020    m  \n   g   i   t   s   t   e   r   @   p   o   b   o   x   .
0000040    c   o   m  \n   g   i   t   s   t   e   r   @   p   o   b   o
0000060    x   .   c   o   m  \n   g   i   t   s   t   e   r   @   p   o
0000100    b   o   x   .   c   o   m  \n   g   i   t   s   t   e   r   @
0000120    p   o   b   o   x   .   c   o   m  \n                        
0000132

Why are all those newlines in there?  Bug?  Misfeature?  Feature?  If
feature, how do I ensure \0 in my output?  If I add %x00, I get both \0
*and* \n in output. :(

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
