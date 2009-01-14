From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/4] color-words: expand docs with precise semantics
Date: Wed, 14 Jan 2009 23:26:02 +0100
Message-ID: <b1290f83267e64856e58477e0c19e920dd416c82.1231971446.git.trast@student.ethz.ch>
References: <3ff3ccf6e3c1cd6a002d200aee5df88a197a7bf6.1231971446.git.trast@student.ethz.ch>
 <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 23:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEDG-0000kg-Ey
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZANW0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZANW0P
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:26:15 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:14595 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754AbZANW0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:26:12 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 23:26:07 +0100
X-Mailer: git-send-email 1.6.1.142.ge070e
In-Reply-To: <48504e8a330beca560208ce050d43bc92ac04c90.1231971446.git.trast@student.ethz.ch>
In-Reply-To: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901142104400.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 14 Jan 2009 22:26:07.0551 (UTC) FILETIME=[183C3CF0:01C97697]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105716>

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
1.6.1.142.ge070e
