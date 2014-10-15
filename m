From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/5] t7610-mergetool: add missing && and remove commented-out code
Date: Wed, 15 Oct 2014 01:35:18 -0700
Message-ID: <1413362121-17361-2-git-send-email-davvid@gmail.com>
References: <1413362121-17361-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:35:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeK34-0004rT-KD
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 10:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbaJOIfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 04:35:04 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61290 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaJOIfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 04:35:02 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so854486pdj.40
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zl+hVvah3mQ7pJWHOpEfS9Kr+IB37MbmXU46aNrJX/A=;
        b=ToRaeW7CRTktFPKyqETjFer/7G6IVqWYhfSXSU2WzgEzaIZD1oYUY7g+DHYj4NwcxI
         sT9CRswalbxfdsBHQ6YXGY+FlF738X0+F3v/YpjlN/AMdbAHFSH+dvpppsMk/it3Sy3/
         SLdRboBTGn4ritpB1zqcJSzdxK3xRQmkzubcC76BytnUQtKTsuqVs4t/9vLSF0vEplhc
         7UIcpGcAY0+5kK8aH887kKCldkIoLQLYTXMAlUu5k1dnDnQSjHwAwJoYFU6WRbUIceW/
         qJyukmPK8i813VGsMp1E12Rd17HVnsLu5N/+18LaaemOUZKMyilWOxhUiqFCj+dXd+bF
         gcvA==
X-Received: by 10.70.42.15 with SMTP id j15mr3317817pdl.17.1413362100664;
        Wed, 15 Oct 2014 01:35:00 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm16371416pdh.56.2014.10.15.01.34.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 01:35:00 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
In-Reply-To: <1413362121-17361-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7610-mergetool.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 875c8af..214edfb 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -192,7 +192,7 @@ test_expect_success 'mergetool merges all from subdir' '
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	git config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
-	git checkout -b test5 branch1
+	git checkout -b test5 branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
@@ -231,18 +231,12 @@ test_expect_success 'conflicted stash sets up rerere'  '
 '
 
 test_expect_success 'mergetool takes partial path' '
-	git reset --hard
+	git reset --hard &&
 	git config rerere.enabled false &&
 	git checkout -b test12 branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 
-	#should not need these lines
-	#( yes "d" | git mergetool file11 >/dev/null 2>&1 ) &&
-	#( yes "d" | git mergetool file12 >/dev/null 2>&1 ) &&
-	#( yes "l" | git mergetool submod >/dev/null 2>&1 ) &&
-	#( yes "" | git mergetool file1 file2 >/dev/null 2>&1 ) &&
-
 	( yes "" | git mergetool subdir ) &&
 
 	test "$(cat subdir/file3)" = "master new sub" &&
-- 
2.1.2.453.g1b015e3
