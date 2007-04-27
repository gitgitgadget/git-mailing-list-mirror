From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH 5/8] Update -L documentation for git-blame/git-annotate
Date: Fri, 27 Apr 2007 00:09:49 -0500
Message-ID: <20070427050949.GD9798@bowser.ruder>
References: <20070427050550.GA9594@bowser.ruder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 07:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIkj-00019Y-HZ
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 07:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXD0FMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 01:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbXD0FMO
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 01:12:14 -0400
Received: from www.aeruder.net ([65.254.53.245]:4592 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755338AbXD0FMO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 01:12:14 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 8F8C040EC7;
	Fri, 27 Apr 2007 00:12:13 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070427050550.GA9594@bowser.ruder>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45692>

Documenting alternate ways to use -L:

-L /regex/,end
-L start,+offset

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/blame-options.txt |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 331f161..0099bb2 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -9,8 +9,28 @@
 --show-stats::
 	Include additional statistics at the end of blame output.
 
--L n,m::
-	Annotate only the specified line range (lines count from 1).
+-L <start>,<end>::
+	Annotate only the given line range.  <start> and <end> can take
+	one of these forms:
+
+	- number
++
+	If <start> or <end> is a number, it specifies an
+	absolute line number (lines count from 1).
++
+
+	- /regex/
++
+	This form will use the first line matching the given
+	POSIX regex.  If <end> is a regex, it will search
+	starting at the line given by <start>.
++
+
+	- +offset or -offset
++
+	This is only valid for <end> and will specify a number
+	of lines before or after the line given by <start>.
++
 
 -l::
 	Show long rev (Default: off).
-- 
1.5.2.rc0.64.g8476
