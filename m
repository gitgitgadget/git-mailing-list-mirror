From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 07/15] t1510 (worktree): fix && chaining
Date: Thu,  8 Dec 2011 01:06:43 +0530
Message-ID: <1323286611-4806-8-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNK2-0001Bw-LU
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab1LGTiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:19 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Rx3nf4gA5JteQedOe4KiVfBmseDu0y8yEeIL2UI066k=;
        b=gxVoSfbSx2WBQNOyB06uDaiRK0+k5wMQ5/9/KiJa7DsvSVaRpSujFMh2qN699gmCuj
         NPF8EK9q5Md4c5K4l5kFrfK9aoZEGJCKSFDzn7vm9ZJpmuaXS38GCMo7wmU5KPpqd38o
         qDi9gomAfgVNglFd98tOP+4n1r+jqxkVW2/Us=
Received: by 10.42.153.5 with SMTP id k5mr162911icw.46.1323286699145;
        Wed, 07 Dec 2011 11:38:19 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:18 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186488>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1501-worktree.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 6384983..d9761bd 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -48,7 +48,7 @@ test_expect_success 'setup: helper for testing rev-parse' '
 '
 
 test_expect_success 'setup: core.worktree = relative path' '
-	unset GIT_WORK_TREE;
+	unset GIT_WORK_TREE &&
 	GIT_DIR=repo.git &&
 	GIT_CONFIG="$(pwd)"/$GIT_DIR/config &&
 	export GIT_DIR GIT_CONFIG &&
@@ -89,7 +89,7 @@ test_expect_success 'subdir of work tree' '
 '
 
 test_expect_success 'setup: core.worktree = absolute path' '
-	unset GIT_WORK_TREE;
+	unset GIT_WORK_TREE &&
 	GIT_DIR=$(pwd)/repo.git &&
 	GIT_CONFIG=$GIT_DIR/config &&
 	export GIT_DIR GIT_CONFIG &&
@@ -334,7 +334,7 @@ test_expect_success 'absolute pathspec should fail gracefully' '
 '
 
 test_expect_success 'make_relative_path handles double slashes in GIT_DIR' '
-	>dummy_file
+	>dummy_file &&
 	echo git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file &&
 	git --git-dir="$(pwd)//repo.git" --work-tree="$(pwd)" add dummy_file
 '
-- 
1.7.7.3
