From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Clarify documentation on commit message strip
Date: Fri, 24 Apr 2015 22:06:38 +0200
Message-ID: <1429905998-9089-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Fri Apr 24 22:06:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YljsE-0004KS-C5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbbDXUGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 16:06:50 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32991 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbbDXUGt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 16:06:49 -0400
Received: by lbbzk7 with SMTP id zk7so44516168lbb.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2015 13:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=wR2HMTNYVznHpTyH/mgHQQbXCUjyLTrZfKXV1C6RL5s=;
        b=KbsBfA3Vd9oAR/S65qL1ePuOQzMtWK69pHDehPFyjOpDek0zcFjF3YEKOD0nYoRbQX
         hUbKP7WzkiCqLqKKdFr0fvymPFx94lPxc18BIdUFMuuCe5VxaQPVpvQH3+kE/CcyiFS8
         Xsn6AiKNZBF004FgyUcsKhKYpaYr352y9aoZZRXqC4W/FFvtLH8iHvOH9XECqaF5md2d
         fHf83fvc+cA25aPBJuqFvzP06pSsfzCUxCnB/xxnXhbJS7wlw6iwO0S1qq+/DXDFMaTv
         +gRpdz1EzOTW5VJKC3zcXKCMFnKWk5YL/DXkzxtfSLYvzxgF8nkyBzuD17WEN3V6eoTU
         p07Q==
X-Received: by 10.152.29.161 with SMTP id l1mr99144lah.76.1429906008057;
        Fri, 24 Apr 2015 13:06:48 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id k12sm2859387lbg.42.2015.04.24.13.06.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2015 13:06:47 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Yljs6-0002NG-ER; Fri, 24 Apr 2015 22:06:46 +0200
X-Mailer: git-send-email 2.4.0.rc3.4.g20acbad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267753>

When using `-v` to add a unified diff to the commit message, this is
stripped and not a part of the commit message. This is not mentioned.

Add a note about this with the `-v` description as well as description
for the default `--cleanup` mode.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 Documentation/git-commit.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 617e29b..e31d828 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -180,8 +180,9 @@ OPTIONS
 +
 --
 strip::
-	Strip leading and trailing empty lines, trailing whitespace, and
-	#commentary and collapse consecutive empty lines.
+	Strip leading and trailing empty lines, trailing whitespace,
+	#commentary, unified diff added with `-v` and collapse
+	consecutive empty lines.
 whitespace::
 	Same as `strip` except #commentary is not removed.
 verbatim::
@@ -283,7 +284,8 @@ configuration variable documented in linkgit:git-config[1].
 	Show unified diff between the HEAD commit and what
 	would be committed at the bottom of the commit message
 	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
+	lines prefixed with '#'. This diff will not be a part
+	of the commit message.
 +
 If specified twice, show in addition the unified diff between
 what would be committed and the worktree files, i.e. the unstaged
-- 
2.1.4
