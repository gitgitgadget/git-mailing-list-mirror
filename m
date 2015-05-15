From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/log: clarify what --raw means
Date: Fri, 15 May 2015 17:44:34 +0200
Message-ID: <1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
Cc: git@vger.kernel.org, eda@waniasset.com,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 15 17:44:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtHn6-0004y9-1h
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 17:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934787AbbEOPon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 11:44:43 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55298 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934569AbbEOPom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 11:44:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4FFiYT6004050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2015 17:44:34 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FFianc009972;
	Fri, 15 May 2015 17:44:36 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YtHmt-0004tW-VC; Fri, 15 May 2015 17:44:35 +0200
X-Mailer: git-send-email 2.3.5.2.ge515092.dirty
In-Reply-To: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 15 May 2015 17:44:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4FFiYT6004050
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432309477.29768@8KndyMY/Od9LFV0GZbKWLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269154>

There are several "raw formats", and describing --raw as "Generate the
raw format" in the documentation for git-log seems to imply that it
generates the raw *log* format.

Clarify the wording by saying "raw diff format" explicitely, and make a
special-case for "git log": "git log --raw" does not just change the
format, it shows something which is not shown by default.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/diff-options.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ccd4998..163163b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -41,8 +41,17 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --raw::
-	Generate the raw format.
+ifndef::git-log[]
+	Generate the raw diff format.
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
