From: "Jason St. John" <jstjohn@purdue.edu>
Subject: [PATCH] State correct usage of backticks for options in man pages in the coding guidelines
Date: Tue, 12 Nov 2013 23:21:41 -0500
Message-ID: <1384316501-27965-1-git-send-email-jstjohn@purdue.edu>
Cc: "Jason St. John" <jstjohn@purdue.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 05:22:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgRy3-0000qY-9D
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 05:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3KMEVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 23:21:55 -0500
Received: from mailhub131.itcs.purdue.edu ([128.210.5.131]:57660 "EHLO
	mailhub131.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753777Ab3KMEVx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 23:21:53 -0500
Received: from megahurtz.itap.purdue.edu (pal-nat184-041-152.itap.purdue.edu [10.184.41.152])
	(authenticated bits=0)
	by mailhub131.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAD4LmbK005428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 12 Nov 2013 23:21:52 -0500
X-Mailer: git-send-email 1.8.4.2
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237773>

The man pages contain inconsistent usage of backticks vs. single quotes
around options and commands that are in paragraphs. This commit states
that backticks should always be used around options and commands.

This commit also states that "--" and friends should be left unescaped
(e.g. use `--pretty=oneline` instead of `\--pretty=oneline`).

Signed-off-by: Jason St. John <jstjohn@purdue.edu>
---
This was discussed here:
http://marc.info/?l=git&m=138419319223845&w=2
http://marc.info/?l=git&m=138424552300662&w=2


 Documentation/CodingGuidelines | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index a600e35..b335d48 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -260,9 +260,11 @@ Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
  The same general rule as for code applies -- imitate the existing
- conventions.  A few commented examples follow to provide reference
- when writing or modifying command usage strings and synopsis sections
- in the manual pages:
+ conventions.
+
+ A few commented examples follow to provide reference when writing or
+ modifying command usage strings and synopsis sections in the manual
+ pages:
 
  Placeholders are spelled in lowercase and enclosed in angle brackets:
    <file>
@@ -312,3 +314,17 @@ Writing Documentation:
    Use 'git' (all lowercase) when talking about commands i.e. something
    the user would type into a shell and use 'Git' (uppercase first letter)
    when talking about the version control system and its properties.
+
+ A few commented examples follow to provide reference when writing or
+ modifying paragraphs or option/command explanations that contain options
+ or commands:
+
+ Backticks are used around options or commands:
+   `--pretty=oneline`
+   `git rev-list`
+
+ Options or commands should use unescaped AsciiDoc:
+   Correct:
+      `--pretty=oneline`
+   Incorrect:
+      `\--pretty=oneline`
-- 
1.8.4.2
