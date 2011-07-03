From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/8] svn-fe: add man target to Makefile
Date: Sun,  3 Jul 2011 23:57:51 +0600
Message-ID: <1309715877-13814-3-git-send-email-divanorama@gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 19:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQus-00025S-MA
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab1GCR4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jul 2011 13:56:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62342 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab1GCR4o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 13:56:44 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so3614734bwd.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FeHnx7/KHkH7ZqcI5mps9SOfU4Ho/oFSwhYs9KfvDTI=;
        b=ZY2KCt+hshnz+TjSd6Emh3rSaFN7CGbrEa5FV7PfZg6EorRc4cOjBDKQFzMX7gZwB6
         YEnXIkAzZ9ymD9ih5OTUvJ6T6k5r2w9d2wVDvB0lvFPJLgFD4zGSZ4aOLs2E//ahbsfw
         rSkXL7TZhnjCw4IirVHAok3ypV7IE6eSpziCw=
Received: by 10.204.122.210 with SMTP id m18mr4762688bkr.138.1309715803565;
        Sun, 03 Jul 2011 10:56:43 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm4841383bkc.19.2011.07.03.10.56.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Jul 2011 10:56:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176579>

There already is a svn-fe.1 target. But 'man' being a standard
target is easier to discover or type. It can also be reused if
more manpages arise here.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 contrib/svn-fe/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index 360d8da..bc03a3e 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -33,6 +33,8 @@ ifndef V
 endif
 endif
 
+man: svn-fe.1
+
 svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(GIT_LIB)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ svn-fe.o \
 		$(ALL_LDFLAGS) $(LIBS)
@@ -60,4 +62,4 @@ svn-fe.1: svn-fe.txt
 clean:
 	$(RM) svn-fe$X svn-fe.o svn-fe.html svn-fe.xml svn-fe.1
 
-.PHONY: all clean FORCE
+.PHONY: all man clean FORCE
-- 
1.7.3.4
