From: Johan Herland <johan@herland.net>
Subject: [PATCH] Teach "git diff" HTML funcname patterns
Date: Wed, 20 Aug 2008 19:27:46 +0200
Message-ID: <200808201927.47099.johan@herland.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 19:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrUR-0000XE-3e
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbYHTR1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYHTR1z
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:27:55 -0400
Received: from sam.opera.com ([213.236.208.81]:52937 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbYHTR1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:27:55 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7KHRlEO006479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 20 Aug 2008 17:27:52 GMT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92997>

Finds lines with <h1>..<h6> tags. The pattern is adapted from the ruby one.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/gitattributes.txt |    2 ++
 diff.c                          |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index db16b0c..8bb05e6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -320,6 +320,8 @@ patterns are available:
 
 - `tex` suitable for source code for LaTeX documents.
 
+- `html` suitable for HTML/XHTML documents.
+
 
 Performing a three-way merge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/diff.c b/diff.c
index a6c1432..13ae85d 100644
--- a/diff.c
+++ b/diff.c
@@ -1382,6 +1382,7 @@ static struct builtin_funcname_pattern {
 	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
+	{ "html", "^\\s*\\(<h[1-6]\\s.*>.*\\)$" },
 };
 
 static const char *diff_funcname_pattern(struct diff_filespec *one)
-- 
1.6.0.96.g2fad1
