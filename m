From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/16] t/t5505-remote: modernize subshell-style of one test
Date: Fri, 21 Jun 2013 16:42:25 +0530
Message-ID: <1371813160-4200-2-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzK5-00036l-3z
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454Ab3FULQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:03 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38668 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933076Ab3FULQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:00 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so7692814pab.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i4q0sU44ds9IDzIPtGc5w5or+IwJTEvYri9GuYhYVoo=;
        b=SRRhNEeg2vvhtDxAENbti+rEQbMl8PzmydFlIL9Igf+sx2B6PttCp4eeniNwpdWf0o
         Z+rFmUJ+XTwp9d1McmJoma+Qj9IhyTPsiaGILu1K5ZbHkybJ2/v/DhFAaM5lZRcRvfZZ
         mRAbSrNlEboHjB7BAN8q4C1dT+CcYHNeizEQiEmbHA01IabKE6+H0SG4myS6xATXVGQb
         Q4lFjDDzXVkGlcsOQM/dXUmP7hqgJvXR+zpG3biC5s8zgLyXkmcvqL6EQizCmASixnPg
         9+fQRaDvOHx4sIwAkZuwrW3gPYqNGsDgqgEFBY+wo0R9yBHRALbn/g9jkD9UGL93zXtf
         Z/sg==
X-Received: by 10.67.21.229 with SMTP id hn5mr15880030pad.135.1371813359764;
        Fri, 21 Jun 2013 04:15:59 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.15.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:15:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228595>

Since we plan to edit the test "migrate a remote from named file in
$GIT_DIR/remotes" in later patches, modernize the subshell-style by
putting the parenthesis on separate lines and indenting the body.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index dd10ff0..4d5810f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -691,13 +691,15 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	git clone one six &&
 	origin_url=$(pwd)/one &&
-	(cd six &&
-	 git remote rm origin &&
-	 echo "$origin_url" > .git/branches/origin &&
-	 git remote rename origin origin &&
-	 ! test -f .git/branches/origin &&
-	 test "$(git config remote.origin.url)" = "$origin_url" &&
-	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+	(
+		cd six &&
+		git remote rm origin &&
+		echo "$origin_url" > .git/branches/origin &&
+		git remote rename origin origin &&
+		! test -f .git/branches/origin &&
+		test "$(git config remote.origin.url)" = "$origin_url" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+	)
 '
 
 test_expect_success 'remote prune to cause a dangling symref' '
-- 
1.8.3.1.499.g7ad3486.dirty
