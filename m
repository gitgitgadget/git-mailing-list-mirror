From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/2] Documentation: Add version information to man pages
Date: Sun, 25 Mar 2007 13:56:50 +0200
Message-ID: <117482381140-git-send-email-frank@lichtenheld.de>
References: <7vircqe389.fsf@assigned-by-dhcp.cox.net> <11748238102228-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 13:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVRMj-0001kF-Ue
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 13:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXCYL6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 07:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbXCYL6T
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 07:58:19 -0400
Received: from mail.lenk.info ([217.160.134.107]:63628 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbXCYL6S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 07:58:18 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HVRMZ-00055X-1V; Sun, 25 Mar 2007 13:58:19 +0200
Received: from p3ee3dfa5.dip.t-dialin.net ([62.227.223.165] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HVRMW-00075z-FB; Sun, 25 Mar 2007 13:58:16 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HVRLJ-0005OB-6Y; Sun, 25 Mar 2007 13:57:01 +0200
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11748238102228-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43053>

Override the [header] macro of asciidoc's docbook
backend to add version information to the generated
man pages.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/asciidoc.conf |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

 This one is unchanged but now applied to asciidoc.conf directly
 since asciidoc.conf.in is no longer necessary.

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 44b1ce4..a86c31d 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
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
