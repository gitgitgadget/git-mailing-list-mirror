From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 2/7] merge hook tests: use 'test_must_fail' instead of '!'
Date: Sat, 15 Mar 2014 22:42:25 +0100
Message-ID: <1394919750-28432-2-git-send-email-benoit.pierre@gmail.com>
References: <CA+SSzV1LcuTWMGrJrto3cJ13-MxgFsJP6z3zTYjHp=qZGPoraw@mail.gmail.com>
 <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 22:42:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOwLz-0001pY-2u
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 22:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbaCOVmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 17:42:47 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:58015 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 17:42:46 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so3269185wes.20
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 14:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=t4DvcWIUxelmUoTrCczhdcpYbNUZcglPp6XS+kjoyyg=;
        b=x4O/WaVtpEdCrTPgfPb4VNbgonuHggwIO2xbrzP56A4F5aGxcTzH+y3qel0FTdrQ2c
         /S+0zboAyiVBRqYXU7mWXN9nEfv0z4gJDi1u7eBzi5x7X2Lsb+8LCOn+JYY3dAvlwQ/W
         nRQ3pFe4ycIj0Vhfd17MOZKqvgeQekHz5jSsePl3imdSAJerNkH8H4xXzHJUm5K2x+bk
         +yOrfdqmwIPV7llUJ5XzvnHnPTO79hC3HVkf78QGhmmvnBRIkLcw1I65WfDdE2dcFRJB
         W2dcatHYr0z6T+c3FhoIN4YzEoBJQNpiEcpJi/mCsdD34yIpeZXqjleYFlq28q1kyb8P
         oPjg==
X-Received: by 10.180.107.136 with SMTP id hc8mr3573090wib.11.1394919765445;
        Sat, 15 Mar 2014 14:42:45 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id z1sm24327337wjq.19.2014.03.15.14.42.42
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Mar 2014 14:42:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394919750-28432-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244170>

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
