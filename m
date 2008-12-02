From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t4030-diff-textconv: Make octal escape sequence more portable
Date: Tue, 02 Dec 2008 09:31:01 +0100
Message-ID: <4934F245.9020908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 09:33:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Qgs-0001pW-LH
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 09:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbYLBIbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 03:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYLBIbU
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 03:31:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9010 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYLBIbT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 03:31:19 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7Qew-0006QT-Vk; Tue, 02 Dec 2008 09:31:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9AA5E6D9; Tue,  2 Dec 2008 09:31:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  From: Johannes Sixt <j6t@kdbg.org> There are printfs around
	that do not grok '\1', but need '\01'. Discovered on AIX 4.3.x. Signed-off-by:
	Johannes Sixt <j6t@kdbg.org> --- [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102126>

From: Johannes Sixt <j6t@kdbg.org>

There are printfs around that do not grok '\1', but need '\01'.
Discovered on AIX 4.3.x.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---

	I found no other instance of printf backslash-nonzero.

 t/t4030-diff-textconv.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 03ba26a..4e961df 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -29,7 +29,7 @@ test_expect_success 'setup binary file with history' '
 	printf "\\0\\n" >file &&
 	git add file &&
 	git commit -m one &&
-	printf "\\1\\n" >>file &&
+	printf "\\01\\n" >>file &&
 	git add file &&
 	git commit -m two
 '
-- 
1.6.1.rc1.5.gf691f
