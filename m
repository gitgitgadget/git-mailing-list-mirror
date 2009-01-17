From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 6/7] color-words: expand docs with precise semantics
Date: Sat, 17 Jan 2009 17:29:47 +0100
Message-ID: <1232209788-10408-7-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-2-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-3-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-4-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-5-git-send-email-trast@student.ethz.ch>
 <1232209788-10408-6-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 17:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOE5M-00087b-EP
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 17:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763631AbZAQQaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763585AbZAQQ3z
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 11:29:55 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41359 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763074AbZAQQ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 11:29:48 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:41 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 17:29:40 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232209788-10408-6-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 17 Jan 2009 16:29:40.0909 (UTC) FILETIME=[CC0AE5D0:01C978C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106084>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/diff-options.txt |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 2c1fa4b..8689a92 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -91,12 +91,17 @@ endif::git-format-patch[]
 	Turn off colored diff, even when the configuration file
 	gives the default to color output.
 
---color-words[=regex]::
-	Show colored word diff, i.e. color words which have changed.
+--color-words[=<regex>]::
+	Show colored word diff, i.e., color words which have changed.
+	By default, words are separated by whitespace.
 +
-Optionally, you can pass a regular expression that tells Git what the
-words are that you are looking for; The default is to interpret any
-stretch of non-whitespace as a word.
+When a <regex> is specified, every non-overlapping match of the
+<regex> is considered a word.  Anything between these matches is
+considered whitespace and ignored(!) for the purposes of finding
+differences.  You may want to append `|[^[:space:]]` to your regular
+expression to make sure that it matches all non-whitespace characters.
+A match that contains a newline is silently truncated(!) at the
+newline.
 
 --no-renames::
 	Turn off rename detection, even when the configuration
-- 
1.6.1.315.g92577
