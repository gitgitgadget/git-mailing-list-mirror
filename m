From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 04/24] Added the iterface Rules.
Date: Fri, 13 Jun 2008 20:35:01 +0200
Message-ID: <1213382121-19786-4-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAK-0005zA-3b
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYFMSfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:35:38 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYFMSfg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:35:36 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41919 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbYFMSf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:27 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C0D6BDFAF684
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:25 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7R-0000eI-00; Fri, 13 Jun 2008 20:35:25 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/AyFaaXl8gC+lxBPAIseQjks29G/nTcIgaWVsJ
	SNfLt6E+97cWeYmmqy1hPyyJY5pCUIgMSE0m7tmrEqBZbK+XtE
	Ozhk4i+A/EoC/GWEhvww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84917>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../src/org/spearce/jgit/treewalk/rules/Rules.java |  121 ++++++++++++=
++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/treewalk/rule=
s/Rules.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules=
=2Ejava b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.ja=
va
new file mode 100644
index 0000000..0a71150
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/rules/Rules.java
@@ -0,0 +1,121 @@
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
+package org.spearce.jgit.treewalk.rules;
+
+/**
+ * A {@link Rules} instances defines ignore or do not ignore rules for=
 files in
+ * a directory. It can't directly be used to match files in sub direct=
ories, but
+ * provides a method {@link #getRulesForSubDirectory}.
+ *=20
+ */
+public interface Rules {
+
+	/**
+	 * Provides the instance of {@link IgnoreAllRules}.
+	 */
+	public static final Rules IGNORE_ALL =3D new IgnoreAllRules();
+
+	/**
+	 * Provides the instance of {@link IgnoreNothingRules}.
+	 */
+	public static final Rules IGNORE_NOTHING =3D new IgnoreNothingRules()=
;
+
+	/**
+	 * @param fileName
+	 *            the name of the file or directory.
+	 * @param fileIsDirectory
+	 *            should be true if the file is a directory.
+	 * @return true if the file or directory should be ignored.
+	 */
+	public abstract boolean shouldIgnore(String fileName,
+			boolean fileIsDirectory);
+
+	/**
+	 * @param directoryName
+	 *            the sub directory for which you want an {@link Rules}
+	 *            instance.
+	 * @return an {@link Rules} instance, which can be used to check file=
s in
+	 *         the specified sub directory.
+	 */
+	public abstract Rules getRulesForSubDirectory(String directoryName);
+
+	/**
+	 * This implementation ignores everything.
+	 */
+	public static final class IgnoreAllRules implements Rules {
+		private IgnoreAllRules() {
+			// declared to make the constructor private
+		}
+
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean shouldIgnore(String fileName, boolean fileIsDirectory=
) {
+			return true;
+		}
+
+		@Override
+		public String toString() {
+			return "Rules[IGNORE_ALL]";
+		}
+	}
+
+	/**
+	 * This implementation ignores nothing.
+	 */
+	public static final class IgnoreNothingRules implements Rules {
+		private IgnoreNothingRules() {
+			// declared to make the constructor private
+		}
+
+		public Rules getRulesForSubDirectory(String directoryName) {
+			return this;
+		}
+
+		public boolean shouldIgnore(String fileName, boolean fileIsDirectory=
) {
+			return false;
+		}
+
+		@Override
+		public String toString() {
+			return "Rules[IGNORE_NOTHING]";
+		}
+	}
+
+}
--=20
1.5.4.3
