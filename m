From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 2/7] merge hook tests: use 'test_must_fail' instead of '!'
Date: Mon, 10 Mar 2014 19:49:32 +0100
Message-ID: <1394477377-10994-3-git-send-email-benoit.pierre@gmail.com>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 19:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN5HC-0005To-7k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 19:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbaCJStv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 14:49:51 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:64896 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbaCJStu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 14:49:50 -0400
Received: by mail-wg0-f49.google.com with SMTP id a1so4861882wgh.20
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=t4DvcWIUxelmUoTrCczhdcpYbNUZcglPp6XS+kjoyyg=;
        b=SyGCJTZWVzLngDsyx4RYgocOb0ZJgO5zRkuE+IjbHjHKlgdVANOYnBO4/PNOg0sOkw
         sbED6pmXzkxtmbD1FdUXQfMU9J3fk6Wxd2RPd4QyM9KO0N/YPTFCTMAsF/JjQwWIQ3lr
         QOY3Qx8nWnhGJ+SzxsddOd5yaLLrQ1P5dO66V3RD05Jd0M2zJAOnIBcahJvt3hWclYkI
         0o9XlWwRFKiCEOOuw9pSLhVCg0//FJsulRx+wUiX7goAWzxvWlDYsMRDAhI1spzpedFi
         p7M1DKZasriXqYclBIC+odrK6tpOPcoGngfa/K3GQRSelT8rrnA9bZT3bKRteo0y5hHm
         9VNQ==
X-Received: by 10.194.58.180 with SMTP id s20mr3309384wjq.54.1394477388906;
        Mon, 10 Mar 2014 11:49:48 -0700 (PDT)
Received: from localhost (109.12.70.86.rev.sfr.net. [86.70.12.109])
        by mx.google.com with ESMTPSA id 12sm54374822wjm.10.2014.03.10.11.49.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Mar 2014 11:49:48 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.7.gca5104e.dirty
In-Reply-To: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243788>

Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 1c95652..5531abb 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -154,7 +154,7 @@ test_expect_success 'with failing hook' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
+	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
 
 '
 
@@ -163,7 +163,7 @@ test_expect_success 'with failing hook (--no-verify)' '
 	head=`git rev-parse HEAD` &&
 	echo "more" >> file &&
 	git add file &&
-	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
+	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify -c $head
 
 '
 
-- 
1.9.0
