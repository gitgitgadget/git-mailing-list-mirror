From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Sat,  2 Aug 2014 16:46:23 +0100
Message-ID: <1406994383-5076-2-git-send-email-philipoakley@iee.org>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 17:46:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDbVs-0003yD-U4
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbaHBPqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 11:46:24 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:25551 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814AbaHBPqX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 11:46:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhkMAFsH3VMCYJjrPGdsb2JhbABagw1jAUWCJ4UIzDUBC3cXBQEBAQE4NoQEAQVWIxAISTkKFAYTiEbGdhePTAcuhB0FtDI8Lw
X-IPAS-Result: AhkMAFsH3VMCYJjrPGdsb2JhbABagw1jAUWCJ4UIzDUBC3cXBQEBAQE4NoQEAQVWIxAISTkKFAYTiEbGdhePTAcuhB0FtDI8Lw
X-IronPort-AV: E=Sophos;i="5.01,786,1400022000"; 
   d="scan'208";a="468372694"
Received: from host-2-96-152-235.as13285.net (HELO localhost) ([2.96.152.235])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 02 Aug 2014 16:46:22 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254701>

Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch used
'origin' as the upstream branch name. That name is now used as the nominal
name for the upstream remote.

While 'origin' would be DWIMmed (do what I mean) to be that remote's
primary branch, do not assume the reader is ready for such magic.

Likewise, do not use 'origin/master' which may not be up to date with the
remote, nor reflect the reader's master branch. The patch series should be
relative to the reader's view of 'git show-branch HEAD master'.

Use the more modern 'master' as the reference branch name.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-format-patch.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c0fd470..b0f041f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -523,25 +523,25 @@ $ git format-patch -k --stdout R1..R2 | git am -3 -k
 ------------
 
 * Extract all commits which are in the current branch but not in the
-origin branch:
+master branch:
 +
 ------------
-$ git format-patch origin
+$ git format-patch master
 ------------
 +
 For each commit a separate file is created in the current directory.
 
-* Extract all commits that lead to 'origin' since the inception of the
+* Extract all commits that lead to 'master' since the inception of the
 project:
 +
 ------------
-$ git format-patch --root origin
+$ git format-patch --root master
 ------------
 
 * The same as the previous one:
 +
 ------------
-$ git format-patch -M -B origin
+$ git format-patch -M -B master
 ------------
 +
 Additionally, it detects and handles renames and complete rewrites
-- 
1.9.4.msysgit.0
