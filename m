From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/23] Documentation/git-worktree: add EXAMPLES section
Date: Fri,  3 Jul 2015 20:17:16 -0400
Message-ID: <1435969052-540-8-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAU-0000AP-FC
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbbGDASt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:49 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34288 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875AbbGDASd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:33 -0400
Received: by igcsj18 with SMTP id sj18so196949152igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FGXWEcpQceWOjJyXiJRTSqJRqjM6uwAX1R2An/r5cUg=;
        b=ThLxJByQFl8gw1Grb1oqP4uHU0iYEU39OeWewVjk/fEagvZzSu3aWnBz/XkWSM4YJz
         uvVlcxvi6SBeLv8MLexLgPLjNlRX9jaRwsTwjYvlFDHL1VXNsBFY+oZUnrRgDfx49K9l
         p3dDVEnBGypiZid1tPpoQ1as+btM1rzk6f/g7mNouK4hLb1+8ebqoG6zFezbx2tzNdXx
         /eZdS7xUqiRgj7ydUUObTIl/5HYDkbHjZ4tgQPGUeKKTajOCqLiPrPLT/aaRovZu4hRl
         5VWQPBJI3zl1Cm0PPYV1TUnyqlguTkknsosZvwGO9krFL92x5R0PHFwCRrfyULkiiJD6
         QTvw==
X-Received: by 10.50.164.199 with SMTP id ys7mr669841igb.6.1435969112710;
        Fri, 03 Jul 2015 17:18:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:32 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273319>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 410f0b4..028bbd9 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -105,6 +105,28 @@ to `/path/main/.git/worktrees/test-next` then a file named
 `test-next` entry from being pruned.  See
 linkgit:gitrepository-layout[5] for details.
 
+EXAMPLES
+--------
+You are middle of a refactoring session and your boss comes in and demands
+that you fix something immediately. You might typically use
+linkgit:git-stash[1] to store your changes away temporarily, however, your
+worktree is in such a state of disarray (with new, removed, moved files,
+and other bits and pieces strewn around) that you don't want to risk
+disturbing any of it. Instead, you create a temporary linked worktree to
+make the emergency fix, remove it when done, and then resume your earlier
+refactoring session.
+
+------------
+$ git branch emergency-fix master
+$ git checkout --to ../temp emergency-fix
+$ pushd ../temp
+# ... hack hack hack ...
+$ git commit -a -m 'emergency fix for boss'
+$ popd
+$ rm -rf ../temp
+$ git worktree prune
+------------
+
 BUGS
 ----
 Multiple checkout support for submodules is incomplete. It is NOT
-- 
2.5.0.rc1.197.g417e668
