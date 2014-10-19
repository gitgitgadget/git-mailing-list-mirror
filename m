From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: fix 'git status --help' character quoting
Date: Sun, 19 Oct 2014 15:17:15 +0100
Message-ID: <1413728235-1504-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 19 16:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfrHa-0006Om-EF
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 16:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbaJSOQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 10:16:26 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:41425 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbaJSOQ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 10:16:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkkxAHvGQ1QCYJWhPGdsb2JhbABbgw0BgSuHPYF3s1yOeIdXBAKBDxcBAQUBAQEBODuEMC8jGIECChoTiEO/dZBRhFIFmQqcOIIxPC+CSwEBAQ
X-IPAS-Result: AkkxAHvGQ1QCYJWhPGdsb2JhbABbgw0BgSuHPYF3s1yOeIdXBAKBDxcBAQUBAQEBODuEMC8jGIECChoTiEO/dZBRhFIFmQqcOIIxPC+CSwEBAQ
X-IronPort-AV: E=Sophos;i="5.04,749,1406588400"; 
   d="scan'208";a="648769754"
Received: from host-2-96-149-161.as13285.net (HELO localhost) ([2.96.149.161])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 19 Oct 2014 15:16:22 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct backtick quoting for some of the modification states to give
consistent web rendering.

While at it, use 00 for ASCII NUL to avoid any confusion with the letter O.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

Noticed when reviewing a stackoverflow problem where the OP actually
desired to just list those files with merge indicators present.
---
 Documentation/git-status.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index def635f..1c01d3ac 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -116,7 +116,7 @@ In the short-format, the status of each path is shown as
 
 where `PATH1` is the path in the `HEAD`, and the " `-> PATH2`" part is
 shown only when `PATH1` corresponds to a different path in the
-index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
+index/worktree (i.e. the file is renamed). The `XY` is a two-letter
 status code.
 
 The fields (including the `->`) are separated from each other by a
@@ -125,7 +125,7 @@ characters, that field will be quoted in the manner of a C string
 literal: surrounded by ASCII double quote (34) characters, and with
 interior special characters backslash-escaped.
 
-For paths with merge conflicts, `X` and 'Y' show the modification
+For paths with merge conflicts, `X` and `Y` show the modification
 states of each side of the merge. For paths that do not have merge
 conflicts, `X` shows the status of the index, and `Y` shows the status
 of the work tree.  For untracked paths, `XY` are `??`.  Other status
@@ -189,7 +189,7 @@ There is also an alternate -z format recommended for machine parsing. In
 that format, the status field is the same, but some other things
 change.  First, the '\->' is omitted from rename entries and the field
 order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
-(ASCII 0) follows each filename, replacing space as a field separator
+(ASCII 00) follows each filename, replacing space as a field separator
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
 characters are not specially formatted; no quoting or
-- 
1.9.4.msysgit.0
