From: David Greaves <david@dgreaves.com>
Subject: [PATCH 4/4] split core-git.txt and update
Date: Tue, 10 May 2005 22:32:39 +0100
Message-ID: <E1DVcLH-0004jr-44@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 23:54:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVcfp-0002wZ-Uz
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEJWAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVEJV7f
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 17:59:35 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:32692 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261813AbVEJVcq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2005 17:32:46 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id BDEC1E6DF8; Tue, 10 May 2005 22:31:35 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21831-04; Tue, 10 May 2005 22:31:35 +0100 (BST)
Received: from oak.dgreaves.com (modem-825.lion.dialup.pol.co.uk [217.135.163.57])
	by mail.ukfsn.org (Postfix) with ESMTP
	id E16F7E6DEF; Tue, 10 May 2005 22:31:34 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVcLG-0001NP-WF; Tue, 10 May 2005 22:32:39 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DVcLH-0004jr-44; Tue, 10 May 2005 22:32:39 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Makefile for html and man

Signed-off-by: David Greaves <david@dgreaves.com>


---
commit 9b651818abae168f7e0dbfafda81c9a4298ea410
tree 4e3b4488b60547a6c90e8aefebb1befea26e0402
parent 6cec96ce19223f1852a12632ad44007822e2a3de
author David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:20:25 +0100
committer David Greaves <david@dgreaves.com> Tue, 10 May 2005 22:20:25 +0100

 Documentation/Makefile |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

Index: Documentation/Makefile
===================================================================
--- /dev/null  (tree:0b343ac5a1a6f8d6a4cb796c523ef84bf7e7254c)
+++ 4e3b4488b60547a6c90e8aefebb1befea26e0402/Documentation/Makefile  (mode:100644)
@@ -0,0 +1,24 @@
+DOC_SRC=$(wildcard git*.txt)
+DOC_HTML=$(patsubst %.txt,%.html,$(DOC_SRC))
+DOC_MAN=$(patsubst %.txt,%.1,$(DOC_SRC))
+
+all: $(DOC_HTML) $(DOC_MAN)
+
+html: $(DOC_HTML)
+
+man: $(DOC_MAN)
+
+git-%: %.c $(LIB_FILE)
+	$(CC) $(CFLAGS) -o $@ $(filter %.c,$^) $(LIBS)
+
+clean:
+	rm -f *.xml *.html *.1
+
+%.html : %.txt
+	asciidoc -b css-embedded -d manpage $<
+
+%.1 : %.xml
+	xmlto man $<
+
+%.xml : %.txt
+	asciidoc -b docbook -d manpage $<



!-------------------------------------------------------------flip-


