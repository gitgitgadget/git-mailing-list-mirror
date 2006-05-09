From: iler.ml@gmail.com
Subject: Re: (patch) calloc->xaclloc in read-cache.c
Date: Tue, 09 May 2006 16:14 +0000
Message-ID: <0IZ000KI11YCKL10@mxout4.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue May 09 15:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdRzc-0005hM-KW
	for gcvg-git@gmane.org; Tue, 09 May 2006 15:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWEINLJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 09:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWEINLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 09:11:09 -0400
Received: from mxout4.netvision.net.il ([194.90.9.27]:41608 "EHLO
	mxout4.netvision.net.il") by vger.kernel.org with ESMTP
	id S932494AbWEINLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 09:11:08 -0400
Received: from main ([62.90.164.62]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
 with ESMTPA id <0IZ000KHZ1YBKL10@mxout4.netvision.net.il> for
 git@vger.kernel.org; Tue, 09 May 2006 16:11:04 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008008-linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19838>

How about this.

--- read-cache.c.000	2006-05-09 15:27:56.000000000 +0000
+++ read-cache.c	2006-05-09 15:28:10.000000000 +0000
@@ -552,7 +552,7 @@
 
 	active_nr = ntohl(hdr->hdr_entries);
 	active_alloc = alloc_nr(active_nr);
-	active_cache = calloc(active_alloc, sizeof(struct cache_entry *));
+	active_cache = xcalloc(active_alloc, sizeof(struct cache_entry *));
 
 	offset = sizeof(*hdr);
 	for (i = 0; i < active_nr; i++) {
