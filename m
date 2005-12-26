From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Handle symlinks graciously
Date: Tue, 27 Dec 2005 00:00:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512270000070.347@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512262231350.21076@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Dec 27 00:01:13 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er1L0-0001qW-PU
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 00:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVLZXBB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 18:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVLZXBA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 18:01:00 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:45985 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750770AbVLZXBA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 18:01:00 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 341A2E3DBC; Tue, 27 Dec 2005 00:00:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 26C6D2B7C;
	Tue, 27 Dec 2005 00:00:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 0BA34905;
	Tue, 27 Dec 2005 00:00:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E2273141576; Tue, 27 Dec 2005 00:00:58 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
In-Reply-To: <Pine.LNX.4.63.0512262231350.21076@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14063>

Hi,

to make the test t4011 pass all the time, this little patch is needed on 
top:

diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 9e70063..e3ebf38 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -32,6 +32,7 @@ test_expect_success \
 test_expect_success \
     'diff unchanged symlink' \
     'tree=$(git-write-tree) &&
+    git-update-index frotz &&
     test -z "$(git-diff-index --name-only $tree)"'
 
 cat > expected << EOF

Ciao,
Dscho
