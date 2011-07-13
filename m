From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 01/11] svn-fe: add man target to Makefile
Date: Wed, 13 Jul 2011 18:21:03 +0600
Message-ID: <1310559673-5026-2-git-send-email-divanorama@gmail.com>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 14:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyR0-0004Ap-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab1GMMUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:20:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35552 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab1GMMUw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:20:52 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4787045bwd.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FeHnx7/KHkH7ZqcI5mps9SOfU4Ho/oFSwhYs9KfvDTI=;
        b=N/DhYRnKKVRKtlrnJOuvByOHG560gTJxkeJ9rdx43qevD1JBSG/k3QNguUjOUjNbAL
         PFeISRZTRPUItjcEDTNBCpYNMSdY8KWSE8D9I1O51fO3nCGxYoMYZU4plnts2/ADO4ka
         gfiJ8xitAy13EiJGbQRtMn50E5YW8HfzrnRwA=
Received: by 10.205.35.194 with SMTP id sx2mr461746bkb.384.1310559652073;
        Wed, 13 Jul 2011 05:20:52 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id c8sm1653987bkc.15.2011.07.13.05.20.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 05:20:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177028>

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
