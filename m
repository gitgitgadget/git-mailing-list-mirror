From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] Document negated forms of format-patch --to --cc --add-headers
Date: Mon, 29 Aug 2011 22:10:49 +0200
Message-ID: <b18a36a42a45dd4147c43d959c64e00b9b17e4ac.1314648438.git.trast@student.ethz.ch>
References: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:11:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ao-0005Zk-6L
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996Ab1H2UKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:10:55 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:51140 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969Ab1H2UKw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:10:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
Received: from localhost.localdomain (129.132.153.219) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:50 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
In-Reply-To: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180342>

The negated forms introduced in c426003 (format-patch: add --no-cc,
--no-to, and --no-add-headers, 2010-03-07) were not documented
anywhere.  Add them to the descriptions of the positive forms.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I can't help but notice that the options aren't symmetric:
--no-add-header clears more than just the options added by
--add-header.  It's probably too late to change though.


 Documentation/git-format-patch.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index d13c9b2..6ea9be7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -166,15 +166,22 @@ will want to ensure that threading is disabled for `git send-email`.
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
+	The negated form `--no-to` discards all `To:` headers added so
+	far (from config or command line).
 
 --cc=<email>::
 	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
+	The negated form `--no-cc` discards all `Cc:` headers added so
+	far (from config or command line).
 
 --add-header=<header>::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
-	For example, `--add-header="Organization: git-foo"`
+	For example, `--add-header="Organization: git-foo"`.
+	The negated form `--no-add-header` discards *all* (`To:`,
+	`Cc:`, and custom) headers added so far from config or command
+	line.
 
 --cover-letter::
 	In addition to the patches, generate a cover letter file
-- 
1.7.7.rc0.370.gdcae57
