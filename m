From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Broken test..
Date: Sun, 26 Apr 2009 12:29:13 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904261226370.7331@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyA5Q-0004VU-11
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 21:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbZDZTav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbZDZTau
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 15:30:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51497 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536AbZDZTat (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 15:30:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3QJTDcD012566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Apr 2009 12:29:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3QJTDOR011991;
	Sun, 26 Apr 2009 12:29:13 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.457 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117622>


While I did a

	make -j64 test > ~/t.out

to check my previous patch (in case some test actually tested 'trustctime' 
or something), I noticed this one. Somebody has speeling trouble:

	t4202-log.sh: line 345: test_expect_sucess: command not found

Fixed thus.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 t/t4202-log.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 67f983f..64502e2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -342,7 +342,7 @@ cat > expect <<\EOF
 * initial
 EOF
 
-test_expect_sucess 'log --graph with merge' '
+test_expect_success 'log --graph with merge' '
 	git log --graph --date-order --pretty=tformat:%s |
 		sed "s/ *$//" >actual &&
 	test_cmp expect actual
