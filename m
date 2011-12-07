From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 08/15] t3200 (branch): fix && chaining
Date: Thu,  8 Dec 2011 01:06:44 +0530
Message-ID: <1323286611-4806-9-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNK3-0001Bw-7d
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443Ab1LGTi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36108 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:25 -0500
Received: by mail-qw0-f46.google.com with SMTP id b40so3739668qad.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qHBj51UnRw8SBvKELnydYggTLl25CpY7O6kNN85ZoI0=;
        b=uCLYrGIFl7V64ee9NB68yC8OZRFeurwMrmVNFwRrAtrEjininsbrayKiWnCfZ76VNK
         lDoeEJ71aD6RM4MZANA4NBbg0b725v0m3Um9hsbJkN+bNcqBqd44emWiHxGsTFhCOJ0h
         SXoD3Z7wfET2bhC6V89sOlaI50jpzElvwBlp0=
Received: by 10.50.135.71 with SMTP id pq7mr269862igb.26.1323286704851;
        Wed, 07 Dec 2011 11:38:24 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:24 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186489>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3200-branch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index bc73c20..7877290 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -22,7 +22,7 @@ test_expect_success \
 
 test_expect_success \
     'git branch --help should not have created a bogus branch' '
-     git branch --help </dev/null >/dev/null 2>/dev/null;
+     git branch --help </dev/null >/dev/null 2>/dev/null &&
      test_path_is_missing .git/refs/heads/--help
 '
 
@@ -88,7 +88,7 @@ test_expect_success \
 test_expect_success \
     'git branch -m n/n n should work' \
        'git branch -l n/n &&
-        git branch -m n/n n
+        git branch -m n/n n &&
 	test_path_is_file .git/logs/refs/heads/n'
 
 test_expect_success 'git branch -m o/o o should fail when o/p exists' '
-- 
1.7.7.3
