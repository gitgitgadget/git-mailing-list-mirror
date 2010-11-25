From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] t7300: add a missing SYMLINKS prerequisite
Date: Thu, 25 Nov 2010 09:03:39 +0100
Message-ID: <4CEE185B.9020603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:03:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLWo2-00009F-Nz
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab0KYIDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 03:03:45 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31084 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0KYIDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 03:03:44 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PLWnr-0006s4-Td; Thu, 25 Nov 2010 09:03:40 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A17891660F;
	Thu, 25 Nov 2010 09:03:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162105>

From: Johannes Sixt <j6t@kdbg.org>

The test fails on Windows since 2dec68c (tests: add missing &&, batch 2).

Even though this test allocates and leaves behind files, subsequent tests
do not depend on this, so it is safe to just skip it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t7300-clean.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b6bef7a..70d8168 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -179,7 +179,7 @@ test_expect_success 'git clean -d with prefix and path' '
 
 '
 
-test_expect_success 'git clean symbolic link' '
+test_expect_success SYMLINKS 'git clean symbolic link' '
 
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
-- 
1.7.3.2.1593.g40fa0
