From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 2/3] Documentation: move support for old compilers to CodingGuidelines
Date: Sun, 16 Dec 2012 19:36:00 +0000
Message-ID: <1355686561-1057-3-git-send-email-git@adamspiers.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkK0t-0000fB-3V
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 20:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab2LPTgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 14:36:06 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41239 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab2LPTgE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 14:36:04 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 4A4902E65F
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 19:36:03 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355686561-1057-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211608>

The "Try to be nice to older C compilers" text is clearly a guideline
to be borne in mind whilst coding rather than when submitting patches.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/CodingGuidelines  |  8 ++++++++
 Documentation/SubmittingPatches | 13 -------------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 57da6aa..69f7e9b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -112,6 +112,14 @@ For C programs:
 
  - We try to keep to at most 80 characters per line.
 
+ - We try to support a wide range of C compilers to compile git with,
+   including old ones. That means that you should not use C99
+   initializers, even if a lot of compilers grok it.
+
+ - Variables have to be declared at the beginning of the block.
+
+ - NULL pointers shall be written as NULL, not as 0.
+
  - When declaring pointers, the star sides with the variable
    name, i.e. "char *string", not "char* string" or
    "char * string".  This makes it easier to understand code
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c107cb1..c34c9d1 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -127,19 +127,6 @@ in templates/hooks--pre-commit.  To help ensure this does not happen,
 run git diff --check on your changes before you commit.
 
 
-(1a) Try to be nice to older C compilers
-
-We try to support a wide range of C compilers to compile
-git with. That means that you should not use C99 initializers, even
-if a lot of compilers grok it.
-
-Also, variables have to be declared at the beginning of the block
-(you can check this with gcc, using the -Wdeclaration-after-statement
-option).
-
-Another thing: NULL pointers shall be written as NULL, not as 0.
-
-
 (2) Generate your patch using git tools out of your commits.
 
 git based diff tools generate unidiff which is the preferred format.
-- 
1.7.12.1.396.g53b3ea9
