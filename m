From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH] grep: Add the option '--line-number'
Date: Mon, 28 Mar 2011 13:11:55 -0500
Message-ID: <1301335915-5782-1-git-send-email-jratt0@gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 20:12:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Gvi-0005oI-H2
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab1C1SMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:12:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62797 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab1C1SMg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:12:36 -0400
Received: by iyb14 with SMTP id 14so3379867iyb.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=XjzctqLHSwafScLtzKAfb0jDF6O49wm9PBTbC/0FZeo=;
        b=dONBl+E6pwKDiU65J6axLUK83KyHOKeixXuF88+lrmd/zppMnI6aSgeYt2bPxqAAYu
         uvRu7RI0wrq4xwGQlDPNJTlkEzdCAmliBW45F5KNNMPK4XF9Bu9VNXSY9x2iC3cwyarf
         hM2HSE2Hkz1P1dglfyBX243kVWpQfJPReH1Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wiDFf/my1r/RGA8C+ucu0vLPLmK6A3WynTsXzC29Sa8yqKLSnsDynuVGlo8Sw1ZhU1
         B2pzkOfjI6pOcAMzveMiLu1uVNkMmrr/2SmyGwWZqQBJUmZQ10AM5k6lB4Iydr4WZrGM
         Hez4vkjodh0hC+ElXwWJmhVyaVBNsAz5ZaacY=
Received: by 10.42.97.7 with SMTP id l7mr6932535icn.471.1301335934262;
        Mon, 28 Mar 2011 11:12:14 -0700 (PDT)
Received: from localhost.localdomain ([129.42.161.50])
        by mx.google.com with ESMTPS id c1sm3085565ibe.32.2011.03.28.11.12.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 11:12:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.3.gbe203
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170172>

This is a synonym for the existing '-n' option, matching GNU grep.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
---
 Documentation/git-grep.txt |    1 +
 builtin/grep.c             |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71668e0..c446590 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -102,6 +102,7 @@ OPTIONS
 	as a regex).
 
 -n::
+--line-number::
 	Prefix the line number to matching lines.
 
 -l::
diff --git a/builtin/grep.c b/builtin/grep.c
index 1d35f76..c51e9f1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -874,7 +874,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
 			"interpret patterns as fixed strings"),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('n', NULL, &opt.linenum, "show line numbers"),
+		OPT_BOOLEAN('n', "line-number", &opt.linenum, "show line numbers"),
 		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
 		OPT_BIT('H', NULL, &opt.pathname, "show filenames", 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
-- 
1.7.4.1.4.g0ea33
