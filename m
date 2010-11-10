From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Keep together options controlling the behaviour of diffcore-rename.
Date: Wed, 10 Nov 2010 21:27:13 +0100
Message-ID: <1289420833-20602-3-git-send-email-ydirson@altern.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 21:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHGW-0001jm-0h
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab0KJU11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:27:27 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:50322 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756469Ab0KJU11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:27:27 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id EBEA5D48102;
	Wed, 10 Nov 2010 21:27:20 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PGHGH-0005N6-Ad; Wed, 10 Nov 2010 21:27:17 +0100
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1289420833-20602-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161182>

It makes little sense to have --diff-filter in the middle of them, and
even spares an ifndef::git-format-patch.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/diff-options.txt |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ed9c44e..c93124b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -250,20 +250,6 @@ endif::git-log[]
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
-ifndef::git-format-patch[]
---diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
-	Select only files that are Added (`A`), Copied (`C`),
-	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
-	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
-	are Unmerged (`U`), are
-	Unknown (`X`), or have had their pairing Broken (`B`).
-	Any combination of the filter characters (including none) can be used.
-	When `*` (All-or-none) is added to the combination, all
-	paths are selected if there is any file that matches
-	other criteria in the comparison; if there is no file
-	that matches other criteria, nothing is selected.
-endif::git-format-patch[]
-
 --find-copies-harder::
 	For performance reasons, by default, `-C` option finds copies only
 	if the original file of the copy was modified in the same
@@ -281,6 +267,18 @@ endif::git-format-patch[]
 	number.
 
 ifndef::git-format-patch[]
+--diff-filter=[(A|C|D|M|R|T|U|X|B)...[*]]::
+	Select only files that are Added (`A`), Copied (`C`),
+	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
+	type (i.e. regular file, symlink, submodule, ...) changed (`T`),
+	are Unmerged (`U`), are
+	Unknown (`X`), or have had their pairing Broken (`B`).
+	Any combination of the filter characters (including none) can be used.
+	When `*` (All-or-none) is added to the combination, all
+	paths are selected if there is any file that matches
+	other criteria in the comparison; if there is no file
+	that matches other criteria, nothing is selected.
+
 -S<string>::
 	Look for differences that introduce or remove an instance of
 	<string>. Note that this is different than the string simply
-- 
1.7.2.3
