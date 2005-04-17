From: Brad Roberts <braddr@puremagic.com>
Subject: [patch] Fix off by one error in show-diff.c:sq_expand
Date: Sun, 17 Apr 2005 08:53:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170852420.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 17 17:50:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNC2Z-0005x5-N3
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDQPx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDQPx6
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:53:58 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:14469 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261337AbVDQPxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 11:53:55 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HFrq6O013179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 08:53:52 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HFrqNM013175
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 08:53:52 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tree b2eb41fec5cb7a3b83b53f1eb59e59785e57cf5d
parent 1c45567134945bccefc1b5fbacc2862cd8f346c4
author Brad Roberts <braddr@puremagic.com> 1113752911 -0700
committer Brad Roberts,,, <braddr@gameboy2> 1113752911 -0700

Fix off by one error in sq_expand, forgot space for the null.

Signed-off-by: Brad Roberts <braddr@puremagic.com>

 show-diff.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: show-diff.c
===================================================================
--- f9e06a309f63ac6858d019b51f2172283378d2ef/show-diff.c  (mode:100644 sha1:d85d79b97a59342390bd34da09049dd58d56900f)
+++ b2eb41fec5cb7a3b83b53f1eb59e59785e57cf5d/show-diff.c  (mode:100644 sha1:462f88a67cb3a100bbf307e567eebbcf911292ce)
@@ -36,7 +36,7 @@
 	if (buf_size < cnt) {
 		free(buf);
 		buf_size = cnt;
-		buf = malloc(cnt);
+		buf = malloc(cnt+1);
 	}

 	cp = buf;

