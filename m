From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/15] t1510 (repo-setup): fix && chaining
Date: Thu,  8 Dec 2011 01:06:41 +0530
Message-ID: <1323286611-4806-6-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJw-00018H-6d
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab1LGTiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:13 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PHq0MHcNE100SR7DNtLlS5aWEpAiiE3/eaWXifz4TIY=;
        b=GO1CYd9wBUvR1HRG9r9DDy7zSW5x03J4BDvl1n7AyS+Kw134czDlq1A1i5FPlqTw8/
         nBiWrKDGJpoU/eRjNJT4Pbb/dgiM+rHT5vI5HHcQcxKMSB6+oXgmXkJvZq7mHZw5Dtvx
         mQA1FVxT63qlw3F58hs8H1GHnzdORb9vLfjIk=
Received: by 10.42.131.135 with SMTP id z7mr251553ics.23.1323286692831;
        Wed, 07 Dec 2011 11:38:12 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:12 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186486>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1510-repo-setup.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index ec50a9a..80aedfc 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -603,7 +603,7 @@ test_expect_success '#22a: core.worktree = GIT_DIR = .git dir' '
 	# like case #6.
 
 	setup_repo 22a "$here/22a/.git" "" unset &&
-	setup_repo 22ab . "" unset
+	setup_repo 22ab . "" unset &&
 	mkdir -p 22a/.git/sub 22a/sub &&
 	mkdir -p 22ab/.git/sub 22ab/sub &&
 	try_case 22a/.git unset . \
@@ -742,7 +742,7 @@ test_expect_success '#28: core.worktree and core.bare conflict (gitfile case)' '
 # Case #29: GIT_WORK_TREE(+core.worktree) overrides core.bare (gitfile case).
 test_expect_success '#29: setup' '
 	setup_repo 29 non-existent gitfile true &&
-	mkdir -p 29/sub/sub 29/wt/sub
+	mkdir -p 29/sub/sub 29/wt/sub &&
 	(
 		cd 29 &&
 		GIT_WORK_TREE="$here/29" &&
-- 
1.7.7.3
