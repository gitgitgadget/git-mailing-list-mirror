From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Quote COGITO_LIB in scripts
Date: Fri, 21 Oct 2005 15:16:44 +0200
Message-ID: <20051021131643.GB25662@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 15:19:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESwlM-0003nO-Fr
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 15:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbVJUNQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 09:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVJUNQp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 09:16:45 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:58831 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S964941AbVJUNQp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 09:16:45 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 11FC96DFC1C; Fri, 21 Oct 2005 15:16:44 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id DB7C66DF845; Fri, 21 Oct 2005 15:16:43 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 191E6610D9; Fri, 21 Oct 2005 15:16:44 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00,UPPERCASE_25_50 
	autolearn=no version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10432>

... so they work when prefix contains spaces.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
diff --git a/Makefile b/Makefile
index fd52992..1b61953 100644
--- a/Makefile
+++ b/Makefile
@@ -92,12 +92,12 @@ install-cogito: $(SCRIPT) $(LIB_SCRIPT) 
 	$(INSTALL) $(LIB_SCRIPT) $(DESTDIR)$(libdir)
 	cd $(DESTDIR)$(bindir); \
 	for file in $(SCRIPT); do \
-		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' $$file > $$file.new; \
+		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$file > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
 	cd $(DESTDIR)$(libdir); \
 	for file in $(LIB_SCRIPT); do \
-		sed -e 's/\$${COGITO_LIB}/\$${COGITO_LIB:-$(sedlibdir)\/}/g' $$file > $$file.new; \
+		sed -e 's/\$${COGITO_LIB}/"\$${COGITO_LIB:-$(sedlibdir)\/}"/g' $$file > $$file.new; \
 		cat $$file.new > $$file; rm $$file.new; \
 	done
 

-- 
Jonas Fonseca
