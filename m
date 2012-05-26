From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCHv2 3/3] git-p4: Clean up branch test cases
Date: Sat, 26 May 2012 10:56:06 +0100
Message-ID: <1338026166-5462-4-git-send-email-vitor.hda@gmail.com>
References: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 11:56:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYDjr-00018H-VR
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 11:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab2EZJ4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 05:56:45 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51980 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2EZJ4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 05:56:22 -0400
Received: by wibhn6 with SMTP id hn6so280710wib.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/ogvNiTHYoTfsCUXvQsnU8fKEg53tj9u2kOSieb9QbM=;
        b=mvuY/wzalujhRnh9tDkE8BjI6aXbkWkxBKVIKNLuhMbeSBaYSC8lBTfYOc3N/KN5qF
         WsSmgW3qThJudBq+J85h3ojh7aaQ8x7MxiZc2qqjGymtDyHBF9ZnyVPbwo4BMC9gSE44
         I/0iaPzJN+O6ql78ZGYEO8MVaX0iLdh4zY1W3tC/SKe++aiflxO6oWF2Q1VDCmdBz2OG
         KNKkzUUCrZBVYoX1tueOUCtempoo+ZIFma0p0ODQHJ+Ikr+da3v9gijFeJoMxOY17Aiv
         R75zB8F/Ppgy0NwqbC6VDap1qQHq8mtVPCC0RJw/BljK7/xgI9meSwDmRUqWpnn+n96A
         MaWw==
Received: by 10.180.94.8 with SMTP id cy8mr2615325wib.11.1338026181261;
        Sat, 26 May 2012 02:56:21 -0700 (PDT)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id gv4sm5763390wib.8.2012.05.26.02.56.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 May 2012 02:56:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc2.14.g5e044.dirty
In-Reply-To: <1338026166-5462-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198546>

Correct submit description in one test and remove not required commands
from another.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9801-git-p4-branch.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 308b123..99fe16b 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -218,7 +218,7 @@ test_expect_success 'git p4 clone simple branches' '
 		cd branch1 &&
 		p4 edit file2 &&
 		echo file2_ >>file2 &&
-		p4 submit -d "update file2 in branch3" &&
+		p4 submit -d "update file2 in branch1" &&
 		cd "$git" &&
 		git reset --hard p4/depot/branch1 &&
 		git p4 rebase &&
@@ -249,8 +249,6 @@ test_expect_success 'git p4 clone simple branches' '
 #   `- file2
 #   `- file3
 test_expect_success 'git p4 add complex branches' '
-	test_when_finished cleanup_git &&
-	test_create_repo "$git" &&
 	(
 		cd "$cli" &&
 		changelist=$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
-- 
1.7.7.rc2.14.g5e044.dirty
