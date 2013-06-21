From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/16] t/t5505-remote: modernize subshell-style of one test
Date: Fri, 21 Jun 2013 16:42:36 +0530
Message-ID: <1371813160-4200-13-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKl-00044r-Uk
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935562Ab3FULQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:45 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54133 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030390Ab3FULQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:23 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so7588621pad.23
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gp9rrmuKNYVMV3gmXe7tYLezDcY0FKIP/9agly4HthU=;
        b=NCwLc9OxlJVEtc6dFnu6wGE5AgFMhoXS6KrsdjTXPqHpxNQGD7wbHGp6uUnOHDewHO
         2W3c/fZ/bxBNyUqayJlVZQoQUCyQNoRLFVDt0EZhPU2vyLW5q/BUzDy5SLA0KrO4Hh0l
         mQ62K5WmMdQvxOjBrL2wLyo2Diplgl1eTnG4oJpqTwFgU+iUZ3c5GefYKEzoa8383pOf
         zGuACBkzZyn2fbiLgY5C5QwoqRWqUb60PthZw0dwr0s+W1NqzdX1/vGipNh6ns3/NQQU
         BnOKjYYOMpQuOzFTvLnIg5Qm0t2y4SwI4ZhNwWwn8GHQTP8cRt4qJoaDdTh54AsQxd8M
         VJPA==
X-Received: by 10.69.1.69 with SMTP id be5mr6490659pbd.138.1371813383545;
        Fri, 21 Jun 2013 04:16:23 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228609>

Since we plan to edit the test "migrate a remote from named file in
$GIT_DIR/remotes" in later patches, modernize the subshell-style by
putting the parenthesis on separate lines and indenting the body.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 93e11c8..06ed381 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -676,15 +676,17 @@ EOF
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
 	git clone one five &&
-	(cd five &&
-	 git remote remove origin &&
-	 mkdir -p .git/remotes &&
-	 cat ../remotes_origin > .git/remotes/origin &&
-	 git remote rename origin origin &&
-	 test_path_is_missing .git/remotes/origin &&
-	 test "$(git config remote.origin.url)" = "quux" &&
-	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
-	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
+	(
+		cd five &&
+		git remote remove origin &&
+		mkdir -p .git/remotes &&
+		cat ../remotes_origin > .git/remotes/origin &&
+		git remote rename origin origin &&
+		test_path_is_missing .git/remotes/origin &&
+		test "$(git config remote.origin.url)" = "quux" &&
+		test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin"
+	)
 '
 
 test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
-- 
1.8.3.1.499.g7ad3486.dirty
