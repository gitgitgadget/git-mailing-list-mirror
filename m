From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 3/5] contrib/subtree/Makefile: s/libexecdir/gitexecdir
Date: Tue,  6 May 2014 22:41:47 +1000
Message-ID: <1399380109-3805-4-git-send-email-nod.helm@gmail.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQk-0008Bg-MN
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbaEFMmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36738 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757492AbaEFMmY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:24 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so5840400pad.4
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y3VyMDOhPGowt3XXRHOMFq1EOt0CUzizB4sisVYjvu4=;
        b=HVxfgbLe6uIk1ZZc1FZc3uj3M6zLx+bmM9XA2bT0etuFX0GXaNPHd64pPz+TSTNj6u
         yMvX9hUv7pS3gX6cODRFeAdbw1YXSXD1HGqxqIwWgRuhehXVcnWMGwXq6gtjFNSIl6tS
         D4U9oLpibuw0MHR8NfzuDX6uuGkWzceirdrex4PH0sWvIMi/I8BWX6owZ5mrNsBKoIIB
         XD9WztB/qnbLMnb7EiuGOTfyIRX9NbL+2InhV2IagKWB/VWKmFzPxTQcTkyItQT8HP2/
         w9dZrenqPaCJwwg1pjSppQlcUkWPECgRRyG72CrtwTrzrAtoJdpYovytffQZIfgM7iXP
         /WAg==
X-Received: by 10.66.120.201 with SMTP id le9mr5769180pab.98.1399380143794;
        Tue, 06 May 2014 05:42:23 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248215>

$(libexecdir) isn't used anywhere else in the project, while
$(gitexecdir) is the standard in the other appropriate makefiles. Hence,
replace the former with the latter.

Reviewed-by: Jeff King <peff@peff.net>
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
