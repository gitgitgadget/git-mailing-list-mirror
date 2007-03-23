From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/2] Documentation: Add version information to man pages
Date: Fri, 23 Mar 2007 19:54:05 +0100
Message-ID: <11746760452311-git-send-email-frank@lichtenheld.de>
References: <11746760451462-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 19:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUovO-0004WJ-QM
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 19:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbXCWSzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 14:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbXCWSzi
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 14:55:38 -0400
Received: from mail.lenk.info ([217.160.134.107]:59465 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbXCWSzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 14:55:38 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HUovo-00087I-Rz; Fri, 23 Mar 2007 19:56:09 +0100
Received: from p3ee3db96.dip.t-dialin.net ([62.227.219.150] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HUovH-0002vt-KK; Fri, 23 Mar 2007 19:55:35 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HUou0-0000go-67; Fri, 23 Mar 2007 19:54:16 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11746760451462-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42955>

Override the [header] macro of asciidoc's docbook
backend to add version information to the generated
man pages.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/asciidoc.conf.in |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

 I personally prefer to have this information available in the man page.

 Copying the whole [header] template is at best ugly but works. Better
 suggestions welcome.

diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
index 44b1ce4..a86c31d 100644
--- a/Documentation/asciidoc.conf.in
+++ b/Documentation/asciidoc.conf.in
@@ -31,6 +31,23 @@ ifdef::backend-docbook[]
 {title#}</example>
 endif::backend-docbook[]
 
+ifdef::backend-docbook[]
+[header]
+template::[header-declarations]
+<refentry>
+<refmeta>
+<refentrytitle>{mantitle}</refentrytitle>
+<manvolnum>{manvolnum}</manvolnum>
+<refmiscinfo class="source">Git</refmiscinfo>
+<refmiscinfo class="version">@@GIT_VERSION@@</refmiscinfo>
+<refmiscinfo class="manual">Git Manual</refmiscinfo>
+</refmeta>
+<refnamediv>
+  <refname>{manname}</refname>
+  <refpurpose>{manpurpose}</refpurpose>
+</refnamediv>
+endif::backend-docbook[]
+
 ifdef::backend-xhtml11[]
 [gitlink-inlinemacro]
 <a href="{target}.html">{target}{0?({0})}</a>
-- 
1.5.0.3
