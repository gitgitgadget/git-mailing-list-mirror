From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] doc: make clear --assume-unchanged's user contract
Date: Fri,  5 Dec 2014 22:21:57 +0000
Message-ID: <1417818117-368-2-git-send-email-philipoakley@iee.org>
References: <1417818117-368-1-git-send-email-philipoakley@iee.org>
Cc: ?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 23:21:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1FO-0004IV-6F
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaLEWVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 17:21:03 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:7421 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbaLEWVA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 17:21:00 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai4MACgvglROl3BEPGdsb2JhbABZgwaBKoYzxikEAgKBFhcBAQEBAQEFAQEBATg7hAMBBVYjEAhJOQoUBgESiD/WIQEBAQEGAiCQTweENgWbAYtQijw/MIJDAQEB
X-IPAS-Result: Ai4MACgvglROl3BEPGdsb2JhbABZgwaBKoYzxikEAgKBFhcBAQEBAQEFAQEBATg7hAMBBVYjEAhJOQoUBgESiD/WIQEBAQEGAiCQTweENgWbAYtQijw/MIJDAQEB
X-IronPort-AV: E=Sophos;i="5.07,525,1413241200"; 
   d="scan'208";a="536441056"
Received: from host-78-151-112-68.as13285.net (HELO localhost) ([78.151.112.68])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 05 Dec 2014 22:20:59 +0000
X-Mailer: git-send-email 1.9.4.msysgit.0
In-Reply-To: <1417818117-368-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260902>

Many users misunderstand the --assume-unchanged contract, believing
it means Git won't look at the flagged file.

Be explicit that the --assume-unchanged contract is by the user that
they will NOT change the file so that Git does not need to look (and
expend, fore example, lstat(2) cycles)

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 Documentation/git-update-index.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 929869b..c045509 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -82,13 +82,14 @@ OPTIONS
         Set the execute permissions on the updated files.
 
 --[no-]assume-unchanged::
-	When these flags are specified, the object names recorded
+	When this flag is specified, the object names recorded
 	for the paths are not updated.  Instead, these options
 	set and unset the "assume unchanged" bit for the
-	paths.  When the "assume unchanged" bit is on, Git stops
+	paths.  When the "assume unchanged" bit is on, the user promise
+	is not to change the file, so Git stops
 	checking the working tree files for possible
-	modifications, so you need to manually unset the bit to
-	tell Git when you change the working tree file. This is
+	modifications, so when you change the working tree file you
+	need to manually unset the bit to tell Git . This is
 	sometimes helpful when working with a big project on a
 	filesystem that has very slow lstat(2) system call
 	(e.g. cifs).
-- 
1.9.4.msysgit.0
