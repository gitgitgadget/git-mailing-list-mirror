From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] commit.txt: clarify how --author argument is used
Date: Sun,  6 Jun 2010 19:31:34 -0400
Message-ID: <1275867094-8634-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 07 01:33:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLPL2-0007VZ-3f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 01:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab0FFXbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 19:31:51 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:48416 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0FFXbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 19:31:51 -0400
Received: by ywh17 with SMTP id 17so197291ywh.1
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 16:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s+129J+7gCbXLfAa7pekwIV0uNxkTcAFLz6vLjyhDUw=;
        b=byO9XiohOORTmcpfj3utYxpZ5+KVsvAa9vwyzsy8zf9/DKRut4HkVqmXSf2Ros+4Oi
         DQqEgPQkEUMHAple+VrjvSkS42950MTphe7H2rySi3n3tEQdAK6ZxG+Bb6OdTxEntTUX
         YzQ7i2acPEO22ocpAILnHbdAGhOQDZxAtvyjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mjKIe/iOR1JSptLvl01gaIf1eHqvDLV2zmDcGz/fOlXDwSN2xJ6lCoDe1cPRetgGf3
         u6U4Df6zPe/vkMAUsXaJJnUzzJqFhkpMoWCykrRpj0aGWJWpNtnm5ffuuc3bG132JcK5
         0FOfBY76fxuWuo/yztOlLw3UcmDyXfIAPLHwQ=
Received: by 10.150.187.10 with SMTP id k10mr13415501ybf.190.1275867109841;
        Sun, 06 Jun 2010 16:31:49 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id f1sm13013192ybh.2.2010.06.06.16.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 16:31:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148562>

commit --author was added by 146ea06 (git commit --author=$name: look $name up
in existing commits), but its documentation was sorely lacking compared to its
excellent commit message. This commit tries to improve the documentation.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-commit.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 32c482f..c28603e 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -95,10 +95,11 @@ OPTIONS
 	read the message from the standard input.
 
 --author=<author>::
-	Override the author name used in the commit.  You can use the
-	standard `A U Thor <author@example.com>` format.  Otherwise,
-	an existing commit that matches the given string and its author
-	name is used.
+	Override the commit author. Specify an explicit author using the
+	standard `A U Thor <author@example.com>` format. Otherwise <author>
+	is assumed to be a pattern and is used to search for an existing
+	commit by that author (i.e. rev-list --all -i --author=<author>);
+	the commit author is then copied from the first such commit found.
 
 --date=<date>::
 	Override the author date used in the commit.
-- 
1.7.1
