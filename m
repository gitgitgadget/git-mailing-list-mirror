From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a test for git-add --ignore-errors
Date: Sun, 2 Mar 2008 16:44:23 +0100
Message-ID: <20080302154423.GG2973@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home> <20080302154238.GD2973@steel.home> <20080302154321.GE2973@steel.home> <20080302154400.GF2973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqNK-0002yF-El
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbYCBPo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbYCBPo0
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:44:26 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45622 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbYCBPoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:44:25 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (klopstock mo51) (RZmta 16.8)
	with ESMTP id a03fd7k22BOcNw ; Sun, 2 Mar 2008 16:44:24 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CE222277BD;
	Sun,  2 Mar 2008 16:44:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id C46DE56D24; Sun,  2 Mar 2008 16:44:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080302154400.GF2973@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75791>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t3700-add.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 287e058..ca3e33d 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -179,4 +179,13 @@ test_expect_success 'git add --refresh' '
 	test -z "`git diff-index HEAD -- foo`"
 '
 
+test_expect_success 'git add --ignore-errors' '
+	git reset --hard &&
+	date >foo1 &&
+	date >foo2 &&
+	chmod 0 foo2 &&
+	git add --verbose --ignore-errors .
+	git ls-files |grep foo1
+'
+
 test_done
-- 
1.5.4.3.391.gf5a0c

