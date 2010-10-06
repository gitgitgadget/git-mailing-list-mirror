From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 01/17] t/test-lib.sh: Export also GIT_BUILD_DIR in test_external
Date: Thu,  7 Oct 2010 00:01:46 +0200
Message-ID: <1286402526-13143-2-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:02:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c4M-0001X4-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab0JFWCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:02:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63360 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab0JFWC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:02:29 -0400
Received: by bwz11 with SMTP id 11so49448bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oeUlblNtSekBllS1eXs5zOLt9U62nVVnZatIGu1oLm8=;
        b=iBD9b+NcyUPan3jDf4goGN0I4E3o5XzN9K9ClfTsiWDaT+OTjF+jp7J7YHIojkvaMF
         dBCKnbBYd2Lw1H367FgUkLe2dyUzI8wYXoyjufWbWhFzZVyWiXbjNU3t6JojBrzZbcnC
         ssFfw0Kmre+1Wo+NdYf2QZIBHMNIrdndnqfUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DYzpxGlnw0UFkBhedt8N9wmaaX3e3rYryGxcx9ELWU89VgSH+U+uPnI183+ZAy1S6f
         9NTkmzit6mc9zGOCQ1lgYiyTtSdFyWqe+auJhy8o4xb30YDFUFvwWydD5uxKr1Jk6Wfp
         1VoG/XlVa+2+Ki/NXweDtRVsy9207v4Wtnmjw=
Received: by 10.204.137.80 with SMTP id v16mr10246981bkt.46.1286402546218;
        Wed, 06 Oct 2010 15:02:26 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.24
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158310>

This way we can use it in test scripts written in other languages
(e.g. in Perl), and not rely on "$TEST_DIRECTORY/.."

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is not strictly required, but if we modified t/gitweb-lib.sh to
use GIT_BUILD_DIR, we would want to do the same in the test scripts
for caching interface etc. included in this series.

This patch was not present in previous version of this series, and it
has no equivalent in original patch by J.H.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 830e5e7..968d240 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -510,9 +510,9 @@ test_external () {
 		# Announce the script to reduce confusion about the
 		# test output that follows.
 		say_color "" "# run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
+		# Export TEST_DIRECTORY, GIT_BUILD_DIR, TRASH_DIRECTORY and GIT_TEST_LONG
 		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
+		export TEST_DIRECTORY GIT_BUILD_DIR TRASH_DIRECTORY GIT_TEST_LONG
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
-- 
1.7.3
