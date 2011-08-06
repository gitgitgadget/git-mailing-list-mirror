From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 34/40] whitespace: remediate t9125-git-svn-multi-glob-branch-names.sh
Date: Sat,  6 Aug 2011 18:44:48 +1000
Message-ID: <1312620294-18616-34-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcX3-0005WP-5C
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab1HFIqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:52 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52375 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1HFIqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:24 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183416iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WDoigMDFpe4LJzFgHxUPYLUI0/YfxwFeqArAXu2Son8=;
        b=T4sWqqBdcseFe/sAIA6IGvst2Vb3nVPaTesjPZGP6oXMt5ikktZMW+Tdkx8BiTH7JP
         yjfs3a+8U62x2V3mFJzZqWp5zwfWsf36RpKNz6kMeDPN24ZbU8ZcO+K/WBQmvaPakWVv
         qAagDbAwrcLEq4FHUmU99syAAfFNj33ts4AHA=
Received: by 10.231.12.132 with SMTP id x4mr956554ibx.36.1312620384477;
        Sat, 06 Aug 2011 01:46:24 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178861>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9125-git-svn-multi-glob-branch-names.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9125-git-svn-multi-glob-branch-names.sh b/t/t9125-git-svn-multi-glob-branch-names.sh
index 096abd1..c00597d 100755
--- a/t/t9125-git-svn-multi-glob-branch-names.sh
+++ b/t/t9125-git-svn-multi-glob-branch-names.sh
@@ -11,14 +11,14 @@ test_expect_success 'setup svnrepo' '
 	svn_cmd import -m "$test_description" project "$svnrepo/project" &&
 	rm -rf project &&
 	svn_cmd cp -m "fun" "$svnrepo/project/trunk" \
-	                "$svnrepo/project/branches/v14.1/beta" &&
+			"$svnrepo/project/branches/v14.1/beta" &&
 	svn_cmd cp -m "more fun!" "$svnrepo/project/branches/v14.1/beta" \
-	                      "$svnrepo/project/branches/v14.1/gold"
+			      "$svnrepo/project/branches/v14.1/gold"
 	'
 
 test_expect_success 'test clone with multi-glob in branch names' '
 	git svn clone -T trunk -b branches/*/* -t tags \
-	              "$svnrepo/project" project &&
+		      "$svnrepo/project" project &&
 	(cd project &&
 		git rev-parse "refs/remotes/v14.1/beta" &&
 		git rev-parse "refs/remotes/v14.1/gold"
-- 
1.7.6.362.gf0e6
