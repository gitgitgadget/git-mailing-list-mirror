From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] Documentation/fast-export: Document --import-marks and --export-marks options
Date: Sat,  7 Jun 2008 15:25:04 +0200
Message-ID: <1212845104-79789-1-git-send-email-pdebie@ai.rug.nl>
References: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 15:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4yQl-0007go-DO
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 15:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbYFGNZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 09:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755920AbYFGNZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 09:25:09 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:13547 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703AbYFGNZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 09:25:08 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6206.orange.nl (SMTP Server) with ESMTP id 1CEC01C00085;
	Sat,  7 Jun 2008 15:25:06 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6206.orange.nl (SMTP Server) with ESMTP id 7C7281C00084;
	Sat,  7 Jun 2008 15:25:05 +0200 (CEST)
X-ME-UUID: 20080607132505509.7C7281C00084@mwinf6206.orange.nl
X-Mailer: git-send-email 1.5.6.rc0.165.ge08d6b.dirty
In-Reply-To: <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84201>

This adds a description for git-fast-export's --import-marks and
--export-marks options to its man page.
---

I forgot to add the options to the man page. Perhaps this should be squashed
on top of the other patch?

 Documentation/git-fast-export.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 332346c..277a547 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -36,6 +36,26 @@ when encountering a signed tag.  With 'strip', the tags will be made
 unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
+--export-marks=<file>::
+	Dumps the internal marks table to <file> when complete.
+	Marks are written one per line as `:markid SHA-1`. Only marks
+	for revisions are dumped; marks for blobs are ignored.
+	Backends can use this file to validate imports after they
+	have been completed, or to save the marks table across
+	incremental runs.  As <file> is only opened and truncated
+	at completion, the same path can also be safely given to
+	\--import-marks.
+
+--import-marks=<file>::
+	Before processing any input, load the marks specified in
+	<file>.  The input file must exist, must be readable, and
+	must use the same format as produced by \--export-marks.
++
+Any commits that have already been marked will not be exported again.
+If the backend uses a similar \--import-marks file, this allows for
+incremental bidirectional exporting of the repository by keeping the
+marks the same across runs.
+
 
 EXAMPLES
 --------
-- 
1.5.6.rc0.165.ge08d6b.dirty
