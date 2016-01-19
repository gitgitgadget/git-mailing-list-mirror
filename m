From: Lars Vogel <lars.vogel@gmail.com>
Subject: [PATCH] Consistent usage of working tree in the git-add help
Date: Tue, 19 Jan 2016 19:53:55 +0100
Message-ID: <1453229636-16269-1-git-send-email-Lars.Vogel@vogella.com>
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 19:54:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbPu-0005xW-JM
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345AbcASSyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 13:54:07 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37030 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757331AbcASSyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 13:54:05 -0500
Received: by mail-wm0-f41.google.com with SMTP id n5so127460711wmn.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WrX7Kpurz6EKGwB6W1kcX/KXMp67H97+nPngU+IxuHQ=;
        b=ubYOfxoGGUo30jUxkO0OvrQNV4yxLxhjXBzjScR5tcagQvG5MCs7humgeLaCHv38kx
         Mr2rjRdWC/HJrm9s8SX6eMLkNnDUGP5pt5aQGA+CNsQCudam9t/qsIMkIwh9gGzIyvI5
         QOaFxT6KFsclF+NwysL3LzP+3U8wE6TeksuI0+rTy5IW4S2K/V6WdLgKa/V+KoXACU1y
         K9Qj0NYWhHzwNSNP2ZyLCHP6WZEtyY0hpsBCNcRprIa/++arS90g2gD4gq6KQ7BmFXJT
         cNz5Lg09PjpgxcRhpY5FZ9sKCfaq3VTmyThHY7TmNlkF1tPY1e2RffR22jTb0NC7BFRB
         RUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WrX7Kpurz6EKGwB6W1kcX/KXMp67H97+nPngU+IxuHQ=;
        b=YNwoHaRs3Fz7Gej37xInMg/BWkUUu+DfAEohb/KUVd7g5sAM3la97jAOutl1oSnwRz
         g5HQVua204Oi4BLEP76WjdWZAQqTzGPNvoad2xKM/vC/zVxmxKlbtxsgxKG3ENtdouIp
         jrgqHKaEECBkRvcTzay0vWAuyUjnbfb+H048BZA15fD/ieGzu47/l89p4zRDm8F2GB6w
         abu/QfEQSniEFIAGVGmjU1A+YeIu5ROM7B46MKOAO+RbAGH5PCXl29e8Y2SssfIZHQUo
         zLl5qTXDjdM8SCfBsdmzwwNl7leOAWgl+8U2IgicFyQrtaSyyp0ufbHOpr6qMZOPho1I
         KVHQ==
X-Gm-Message-State: ALoCoQn5Pct3OmvX/A37BsXAg00+jK9+STQojzkk6Eqp3hlqLtSYpy5+68//QnJFB0RAkLrZ0ECab5gRRigOW52k/9avEIpRIQ==
X-Received: by 10.194.110.230 with SMTP id id6mr30275845wjb.67.1453229643271;
        Tue, 19 Jan 2016 10:54:03 -0800 (PST)
Received: from localhost.localdomain ([212.230.124.11])
        by smtp.gmail.com with ESMTPSA id i196sm21627260wmf.23.2016.01.19.10.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 10:54:02 -0800 (PST)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284370>

The usage of working directory is inconsistent in the git add help.
Also http://git-scm.com/docs/giit-clone speaks only about working tree.
Remaining entry found by "git grep -B1 '^directory' git-add.txt" really
relates to a directory.

Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
---
 Documentation/git-add.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index fe5282f..cfef77b 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -24,7 +24,7 @@ remove paths that do not exist in the working tree anymore.
 
 The "index" holds a snapshot of the content of the working tree, and it
 is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working directory, and before running
+after making any changes to the working tree, and before running
 the commit command, you must use the `add` command to add any new or
 modified files to the index.
 
@@ -85,7 +85,7 @@ OPTIONS
 -p::
 --patch::
 	Interactively choose hunks of patch between the index and the
-	work tree and add them to the index. This gives the user a chance
+	working tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
 	index.
 +
-- 
2.7.0
