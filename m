From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 1/2] Documentation/log: clarify what --raw means
Date: Mon, 18 May 2015 19:55:57 +0200
Message-ID: <1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 18 19:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPGw-0005vv-P4
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbbERR4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:56:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56842 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbbERR4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:56:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHtwv0010112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2015 19:55:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHu04V001201;
	Mon, 18 May 2015 19:56:00 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YuPGh-0000KI-TP; Mon, 18 May 2015 19:55:59 +0200
X-Mailer: git-send-email 2.3.5.2.ge515092.dirty
In-Reply-To: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 May 2015 19:55:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4IHtwv0010112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432576559.17822@UwxvXPlMyffI4MiFZjZT+w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269285>

There are several "raw formats", and describing --raw as "Generate the
raw format" in the documentation for git-log seems to imply that it
generates the raw *log* format.

Clarify the wording by saying "raw diff format" explicitly, and make a
special-case for "git log": "git log --raw" does not just change the
format, it shows something which is not shown by default.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Since v1: Reworded after Junio's remark, typo fix thanks to Eric Sunshine.

 Documentation/diff-options.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ccd4998..a1a5868 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -41,8 +41,17 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --raw::
-	Generate the raw format.
+ifndef::git-log[]
+	Generate the diff in raw format.
 	{git-diff-core? This is the default.}
+endif::git-log[]
+ifdef::git-log[]
+	For each commit, show a summary of changes using the raw diff
+	format. See the "RAW OUTPUT FORMAT" section of
+	linkgit:git-diff[1]. This is different from showing the log
+	itself in raw format, which you can achieve with
+	`--format=raw`.
+endif::git-log[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
-- 
2.3.5.2.ge515092.dirty
