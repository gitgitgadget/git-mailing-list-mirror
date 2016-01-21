From: Lars Vogel <lars.vogel@gmail.com>
Subject: [PATCH] Consistent usage of working tree in the git-add help
Date: Thu, 21 Jan 2016 11:09:15 +0100
Message-ID: <1453370955-26199-1-git-send-email-Lars.Vogel@vogella.com>
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 11:09:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMCBI-0001UL-N0
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 11:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215AbcAUKJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 05:09:28 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38446 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759002AbcAUKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 05:09:26 -0500
Received: by mail-wm0-f48.google.com with SMTP id b14so72072025wmb.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 02:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6RR2Gdh0nlzbTsSFhOkAMArluTQ3h6acQpquip1fxkA=;
        b=kmdsWq/G/NicfUDP6s9ie/E8dgNsqQhicsqlPRB4j1WIY9mEgQj2N91lyKTzo2U9kc
         76+2ttyJK0X1hn3BhMoLSZvOA8ddnXU6JxoSTd4o6BUXz5f88IUHCvZbyF4IaNJe2SkU
         IhGJC6yNQ11xGOynEaG+1UmP4NWRSHMR4uViTuSB1UKOFcqJXIP/p/2MR0nt9aXp/Sy9
         rfONFGBcuOX895mIVpqZdqcJtGPXE27wU1q+4wU3cP0hW809ccpKZBZoXJm+lLvFqn7S
         zakLvSAaiQdSnTz0h3sTJKVKopgcXbKk9R0FYLmk7D+cx+y2Bn8dNffsDjHdex7HINhV
         vBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6RR2Gdh0nlzbTsSFhOkAMArluTQ3h6acQpquip1fxkA=;
        b=SEFAz/Dc1NpLqs71xqq8vQ4gwFBiZA50Ic+GgXVYHLIJkMLqriGFJOpUVHCPeezXfV
         9yg3iGT19GJmpluHJ+OKLdyxSVikOO6AmSbZkqjrC85TdJcQ/Jpb5AnyPE5T3xczlWc7
         h5gr4/V/pdo8q/Yh3ra6nG+ks3zu8gBn+vxgZpHMGn9btlxhKRtVUZAwzbCDHZLfY3JX
         JnVX26euD1L4GrLvJ2MUD3cAKHYQSUHaiv0i/88EEjD595EIJpJTj1gScBWJ46DeeMaU
         1zWzHZMTR3cU2Aig+5bbwYKPV0suETK4bGxiYxqaPRtlNeFlMvZ5iNEKR+id4J5TEa0V
         1MNw==
X-Gm-Message-State: AG10YOQqW/mT8dwZGtjzs6sFpqTCgYwLWcMVvZ5OKAlO4nzr7BZc2afJE3UjsjF6VFmPIw==
X-Received: by 10.28.57.69 with SMTP id g66mr9685585wma.63.1453370964411;
        Thu, 21 Jan 2016 02:09:24 -0800 (PST)
Received: from Frodo.fritz.box (p5B32577D.dip0.t-ipconnect.de. [91.50.87.125])
        by smtp.gmail.com with ESMTPSA id cv10sm698744wjb.17.2016.01.21.02.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 02:09:22 -0800 (PST)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284510>

The usage of working directory is inconsistent in the git add help.
Also http://git-scm.com/docs/git-clone speaks only about working tree.
Remaining entry found by "git grep -B1 '^directory' git-add.txt" really
relates to a directory.

Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
---
 Documentation/git-add.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index fe5282f..6a96a66 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -24,7 +24,7 @@ remove paths that do not exist in the working tree anymore.
 
 The "index" holds a snapshot of the content of the working tree, and it
 is this snapshot that is taken as the contents of the next commit.  Thus
-after making any changes to the working directory, and before running
+after making any changes to the working tree, and before running
 the commit command, you must use the `add` command to add any new or
 modified files to the index.
 
-- 
2.7.0
