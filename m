From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/2 v3] git-fast-import.txt: improve documentation for quoted paths
Date: Thu, 29 Nov 2012 20:11:32 +0100
Message-ID: <1354216293-21921-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20121129185404.GC17309@sigill.intra.peff.net>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 29 20:13:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Xg-0008Lj-C3
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab2K2TMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:12:44 -0500
Received: from mx2.imag.fr ([129.88.30.17]:51210 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734Ab2K2TMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:12:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qATJ30FT021628
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2012 20:03:01 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te9XH-0001il-9g; Thu, 29 Nov 2012 20:12:35 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Te9XH-0005iJ-4T; Thu, 29 Nov 2012 20:12:35 +0100
X-Mailer: git-send-email 1.8.0.319.g8abfee4
In-Reply-To: <20121129185404.GC17309@sigill.intra.peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Nov 2012 20:03:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qATJ30FT021628
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1354820582.8852@yBftJ8HQGrFZ2z04l+o6NQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210864>

The documentation mentionned only newlines and double quotes as
characters needing escaping, but the backslash also needs it. Also, the
documentation was not clearly saying that double quotes around the file
name were required (double quotes in the examples could be interpreted as
part of the sentence, not part of the actual string).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
cut-and-paste of Peff's version, adapted from mine.

 Documentation/git-fast-import.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 959e4d3..d1844ea 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -562,8 +562,12 @@ A `<path>` string must use UNIX-style directory separators (forward
 slash `/`), may contain any byte other than `LF`, and must not
 start with double quote (`"`).
 
-If an `LF` or double quote must be encoded into `<path>` shell-style
-quoting should be used, e.g. `"path/with\n and \" in it"`.
+A path can use C-style string quoting; this is accepted in all cases
+and mandatory if the filename starts with double quote or contains
+`LF`. In C-style quoting, the complete name should be surrounded with
+double quotes, and any `LF`, backslash, or double quote characters
+must be escaped by preceding them with a backslash (e.g.,
+`"path/with\n, \\ and \" in it"`).
 
 The value of `<path>` must be in canonical form. That is it must not:
 
-- 
1.8.0.319.g8abfee4
