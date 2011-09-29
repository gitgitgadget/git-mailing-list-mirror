From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: [BUG?] gitk assumes initial commit is empty
Date: Thu, 29 Sep 2011 16:33:06 +0200
Message-ID: <4E8481A2.6060301@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 16:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Hez-0005y4-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 16:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab1I2OcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 10:32:21 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:39656 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab1I2OcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 10:32:20 -0400
Received: from beck.fuw.edu.pl ([193.0.82.235])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1R9Het-0004FV-E7
	for git@vger.kernel.org; Thu, 29 Sep 2011 16:32:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Icedove/3.1.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182399>

I was looking at gitk display for git itself, and scrolling all the way
down to initial commit show this:

Author: Linus Torvalds <torvalds@ppc970.osdl.org>  2005-04-08 00:13:13
Committer: Linus Torvalds <torvalds@ppc970.osdl.org>  2005-04-08 00:13:13
Child:  8bc9a0c769ac1df7820f2dbf8f7b7d64835e3c68 (Add copyright notices.)

    Initial revision of "git", the information manager from hell

with no files added or modified. But e.g. 'git show' shows that files
were added in the initial commit:

$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290 --stat
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Thu Apr 7 15:13:13 2005 -0700
...
   11 files changed, 1244 insertions(+), 0 deletions(-)

In gitk, the next commit shows changes to some files, like if they existed
in the parent commit. So it seems that gitk assumes that initial commit
is empty, which doesn't have to be true.

This is with gitk from master.

-
Zbyszek
