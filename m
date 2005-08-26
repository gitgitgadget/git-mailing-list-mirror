From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:01:35 +0300
Message-ID: <11250540952285-git-send-email-tv@debian.org>
References: <11250540944027-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:04:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8by5-0006zI-AM
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbVHZLBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHZLBn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:01:43 -0400
Received: from i1.inoi.fi ([194.100.97.46]:57757 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S932554AbVHZLBn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:01:43 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 6FAF5FF9DF;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 0DEF1FEDD2;
	Fri, 26 Aug 2005 14:01:49 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 4BEECBA06A;
	Fri, 26 Aug 2005 14:01:35 +0300 (EEST)
In-Reply-To: <11250540944027-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7801>

As long as the cg-cancel name is around, provide docs for it too.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit c1970992d81e2c26d2d85ad65b0e2e90fbeee7f1
tree 461b478052898b2d9cfc67a1b29098abdf5d427e
parent 97b501908e075bfd1f97261f94842669e7b4db5b
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:03 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:03 +0300

 Documentation/Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,7 +1,7 @@
 CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej)
 CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg-*))
 
-MAN1_TXT=$(patsubst ../cg-%,cg-%.txt,$(CG_SRC))
+MAN1_TXT=$(patsubst ../cg-%,cg-%.txt,$(CG_SRC)) cg-cancel.txt
 MAN7_TXT=cogito.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) introduction.html
@@ -71,3 +71,9 @@ cogito.txt : make-cogito-asciidoc
 
 cg-%.txt : ../cg-% make-cg-asciidoc
 	./make-cg-asciidoc $< > $@
+
+cg-cancel.txt : cg-reset.txt
+	ln -s $< $@
+
+cg-cancel.1 : cg-reset.1
+	ln -s $< $@
