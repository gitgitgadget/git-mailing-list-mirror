From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Teach "git diff -p" to locate PHP class methods
Date: Sun, 07 Sep 2008 22:15:29 +0200
Message-ID: <48C43661.8010405@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:16:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQgh-0001jH-GM
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbYIGUPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbYIGUPl
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:15:41 -0400
Received: from mail.op5.se ([193.201.96.20]:50938 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322AbYIGUPk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:15:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C9D261B800A7;
	Sun,  7 Sep 2008 22:21:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LFdHLy+rDV3R; Sun,  7 Sep 2008 22:21:31 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 8CC281B8007E;
	Sun,  7 Sep 2008 22:21:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95171>

Otherwise it will always print the class-name rather
than the name of the function inside that class.

While we're at it, reorder the gitattributes manpage to
list the built-in funcname pattern names in alphabetical
order.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 Documentation/gitattributes.txt |    6 ++++--
 diff.c                          |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 5fb5007..75124d2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -311,18 +311,20 @@ patterns are available:
 
 - `bibtex` suitable for files with BibTeX coded references.
 
+- `html` suitable for HTML/XHTML documents.
+
 - `java` suitable for source code in the Java lanugage.
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
 
+- `php` suitable for source code in the PHP language.
+
 - `python` suitable for source code in the Python language.
 
 - `ruby` suitable for source code in the Ruby language.
 
 - `tex` suitable for source code for LaTeX documents.
 
-- `html` suitable for HTML/XHTML documents.
-
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/diff.c b/diff.c
index cbd151b..e7afbe2 100644
--- a/diff.c
+++ b/diff.c
@@ -1402,6 +1402,7 @@ static struct builtin_funcname_pattern {
 			"\\|"
 			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
 			},
+	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)" },
 	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
-- 
1.6.0.1.196.g01914
