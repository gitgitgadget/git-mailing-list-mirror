From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 01/10] svn-fe: add man target to Makefile
Date: Tue, 16 Aug 2011 15:54:46 +0600
Message-ID: <1313488495-2203-2-git-send-email-divanorama@gmail.com>
References: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 11:54:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtGLR-00081U-B9
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 11:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab1HPJx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 05:53:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1HPJx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 05:53:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3585259bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FeHnx7/KHkH7ZqcI5mps9SOfU4Ho/oFSwhYs9KfvDTI=;
        b=uZEeZv3IBjkRaPCXRHY3QMjqk/F8Mjt7pIi+oOq03vd4WdFYKQNmXe90niV9Ugj6vP
         w70ij5YqwxmPqbbjB3QmFhTtu/4gQmce6FerCfs9kS3eZsWkd0jMKtbb4UiI25pqFCN0
         JA1nJT3wRiWHoTHkviCmLVgehYRUYzlIlsC5k=
Received: by 10.204.199.129 with SMTP id es1mr1357123bkb.118.1313488435811;
        Tue, 16 Aug 2011 02:53:55 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id zx9sm1841723bkb.61.2011.08.16.02.53.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 16 Aug 2011 02:53:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313488495-2203-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179413>

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
