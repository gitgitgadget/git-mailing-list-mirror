From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 10/24] Added the class PathNotInProjectDirectoryException.
Date: Fri, 13 Jun 2008 20:35:07 +0200
Message-ID: <1213382121-19786-10-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAM-0005zA-N3
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYFMSfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:47 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYFMSfo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:44 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43426 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbYFMSf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:29 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id C0F37E184F9D
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:28 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7U-0000eI-00; Fri, 13 Jun 2008 20:35:28 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19XHm9n+4/wAaG9jOcVnIVb+KQ119ONaqw0Xko2
	rIgOeKTl7+htREs3n+l43d0nXFaHb1e9dv/h2+uDZJkYn+tVVZ
	HSckY1WnKBZ9puswzcoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84912>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../errors/PathNotInProjectDirectoryException.java |   46 ++++++++++++=
++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/PathNo=
tInProjectDirectoryException.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProj=
ectDirectoryException.java b/org.spearce.jgit/src/org/spearce/jgit/erro=
rs/PathNotInProjectDirectoryException.java
new file mode 100644
index 0000000..5fce2b3
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/PathNotInProjectDire=
ctoryException.java
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2008, Florian K=C3=B6berle <florianskarten@web.de>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.errors;
+
+/**
+ * Thrown when a path wasn't in the project directory, but expected to=
 be.
+ *=20
+ */
+public class PathNotInProjectDirectoryException extends
+		IllegalArgumentException {
+}
--=20
1.5.4.3
