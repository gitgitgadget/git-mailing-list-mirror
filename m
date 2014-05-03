From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 3/5] contrib/subtree/Makefile: s/libexecdir/gitexecdir
Date: Sat,  3 May 2014 22:49:33 +1000
Message-ID: <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOg-0002ev-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbaECMuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:25 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49242 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECMuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:21 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so6092718pdj.1
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8c7Huf3MPcCiaqmSn41Gfp/2Q6oT4/J+rT7gSkDHHD4=;
        b=R0Koyh+G3/umTihXEgqaDgnAkMvFVb9+aXlxObgBtefreKg3ZvkJUC7n0TejtDPDhD
         POOQ1woSFRj53CjAf5cj5BDSBW82j0S85fphJljLV8EqvWC3LVdE6qBeReJGZ98xstMM
         2g83j/4LChovyt3Zl+s12qSmyxDWc7LtkkZ/xJCGQuS4d6Blna2Hj5zsFwwwePAiBFo2
         Gk0LXxFlzFoojEhtmL4NDgow5LO6jlpmD3HaBVxacZS0jLLi1zuN6cAKJ+geSKm/yrVm
         3Gj+tqSBwKy3mtXOAbHJrWncw5f6qbisynjbUlsxVpLyeC+7KopJCBc7wTNdN0IKpH8h
         SZQg==
X-Received: by 10.66.66.66 with SMTP id d2mr47407899pat.24.1399121421042;
        Sat, 03 May 2014 05:50:21 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.50.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248040>

$(libexecdir) isn't used anywhere else in the project, while
$(gitexecdir) is the standard in the other appropriate makefiles. Hence,
replace the former with the latter.

Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index f63334b..579bb51 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -3,7 +3,7 @@
 
 prefix ?= /usr/local
 mandir ?= $(prefix)/share/man
-libexecdir ?= $(prefix)/libexec/git-core
+gitexecdir ?= $(prefix)/libexec/git-core
 man1dir ?= $(mandir)/man1
 
 ../../GIT-VERSION-FILE: FORCE
@@ -33,8 +33,8 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
 
 install: $(GIT_SUBTREE)
-	$(INSTALL) -d -m 755 $(DESTDIR)$(libexecdir)
-	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(libexecdir)
+	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
+	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
 
 install-doc: install-man
 
-- 
1.9.2
