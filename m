From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH 1/2] git-p4: Make rename test case runnable under dash
Date: Fri, 27 Mar 2015 01:04:28 +0000
Message-ID: <1427418269-3263-2-git-send-email-vitor.hda@gmail.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 02:05:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbIi9-0007YS-8V
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbbC0BFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:05:16 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36491 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbC0BFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:05:14 -0400
Received: by wgra20 with SMTP id a20so82945955wgr.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktGitkl4co68dkwsTod+BAOtO/Wq718uwfTCWPNs1Js=;
        b=qsos5icwDufY2w/7mbMRNF75y74ZqWbhrp+GNhtXc7HUjP+MOnJ1Mluk7FOYC38GtO
         JqtfZ32uztaB45zKHrIxwaXcBXzU0bOcrXNminOxnrI9myvbNn/1xfPjzGJ1CrrpXcQT
         Uy8pEu+bJKxKllUiEL9WJF/oJPBX3ak9D/Ru4mrhwQvybkXkZdQ9yV4IyohKhOTX8ByQ
         LrDBijFhin6HSVZbV6h5ckRkgLcvFH3UMQfjUjq8dvCGyPc7UzxedHZm++kIp+4YBenj
         sv/N+KEreI80YykN5TMciCq1NdwZ72Zeg63Q+ITCNqaC26Jixymt8pi2JUJZnqd4aSYG
         Hbdg==
X-Received: by 10.194.241.202 with SMTP id wk10mr32149085wjc.145.1427418313693;
        Thu, 26 Mar 2015 18:05:13 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id u10sm1231219wib.1.2015.03.26.18.05.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 18:05:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266358>


Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9814-git-p4-rename.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 95f4421..24008ff 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -178,9 +178,9 @@ test_expect_success 'detect copies' '
 		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		case "$src" in
-		file10 | file11) : ;; # happy
+		file10 | file11) true ;; # happy
 		*) false ;; # not
-		&&
+		esac &&
 		git config git-p4.detectCopies $(($level + 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file12 &&
@@ -195,9 +195,9 @@ test_expect_success 'detect copies' '
 		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
 		case "$src" in
-		file10 | file11 | file12) : ;; # happy
+		file10 | file11 | file12) true ;; # happy
 		*) false ;; # not
-		&&
+		esac &&
 		git config git-p4.detectCopies $(($level - 2)) &&
 		git p4 submit &&
 		p4 filelog //depot/file13 &&
-- 
1.7.10.4
