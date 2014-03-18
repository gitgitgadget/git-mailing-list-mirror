From: Benoit Pierre <benoit.pierre@gmail.com>
Subject: [PATCH 2/7] merge hook tests: use 'test_must_fail' instead of '!'
Date: Tue, 18 Mar 2014 11:00:51 +0100
Message-ID: <1395136856-17225-2-git-send-email-benoit.pierre@gmail.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
 <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 11:01:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPqq2-0003wX-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:01:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbaCRKBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:01:23 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33869 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbaCRKBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:01:21 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so5750576wgh.29
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=t4DvcWIUxelmUoTrCczhdcpYbNUZcglPp6XS+kjoyyg=;
        b=O50nZO3TKnj0BN9TfyCv8yclHWhWdrytWaeqGyqq4lEl8cjqtPsTOwQCLjcOf9XhF4
         6GtTSWDoYM4Ctj1VIhtEAldmYdlblWOPpk4W69UDdqyK2tGWzlbRvvh9dUupPKIDupkA
         0kT1dZvKaxsgREaIHv5kXlUwgDVvxZpc0aa6Gdc3csIM3SLbT92iJ/1dgVdRPo9Jej00
         G7BVZoS6myE9jkDKzSXzzWpCzGdsCTv5Ft1f4rW06B95H8GJAV/1ab5/3O1HeYF1pveV
         T4oKbaYAeMJEDETB2E8M7OTY61T3Y1qwTQZQ0Yi+TWUBAzPkgYAhufBcGObYrAFr4278
         fq0w==
X-Received: by 10.180.182.166 with SMTP id ef6mr456899wic.29.1395136880464;
        Tue, 18 Mar 2014 03:01:20 -0700 (PDT)
Received: from localhost (121.12.70.86.rev.sfr.net. [86.70.12.121])
        by mx.google.com with ESMTPSA id d15sm45857928wjx.0.2014.03.18.03.01.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Mar 2014 03:01:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244346>

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
