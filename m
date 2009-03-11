From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 12:47:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111246390.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org> <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 12:47:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhMuL-00068h-1m
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 12:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbZCKLp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 07:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZCKLp2
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 07:45:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:48573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbZCKLp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 07:45:27 -0400
Received: (qmail invoked by alias); 11 Mar 2009 11:45:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 11 Mar 2009 12:45:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KTBNg+MMKYAkqhf87OQLcHmGsM257va28FTbokA
	m6MN0PNeqtWwNT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112910>

From: Daniel Barkalow <barkalow@iabervon.org>

The log_config module is needed for at least some versions of apache to
support the LogFormat directive.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This one works.

 t/lib-httpd/apache.conf |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index af6e5e1..f460e40 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -4,6 +4,9 @@ DocumentRoot www
 LogFormat "%h %l %u %t \"%r\" %>s %b" common
 CustomLog access.log common
 ErrorLog error.log
+<IfModule !mod_log_config.c>
+	LoadModule log_config_module modules/mod_log_config.so
+</IfModule>
 
 <IfDefine Darwin>
 	LoadModule log_config_module modules/mod_log_config.so
-- 
1.6.2.363.g9793e
