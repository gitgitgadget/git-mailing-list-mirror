From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/1] t9146: use 'svn_cmd' wrapper
Date: Sat, 19 Dec 2009 23:09:59 -0800
Message-ID: <20091220070959.GA8141@dcvr.yhbt.net>
References: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com> <20091217200852.GA5797@dcvr.yhbt.net> <20091219222738.GA20331@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Zeh <robert.a.zeh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 08:10:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMFve-0005mL-Ad
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 08:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZLTHKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 02:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbZLTHKA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 02:10:00 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42989 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbZLTHJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 02:09:59 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83F161F516;
	Sun, 20 Dec 2009 07:09:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091219222738.GA20331@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135520>

Using 'svn' directly may not work for all users.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 > Test case included and pushed out to git://git.bogomips.org/git-svn

 Junio: Not sure if you've merged yet, but feel free to squash this
 with the other one.  Thanks.

 t/t9146-git-svn-empty-dirs.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 3f2d719..565365c 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -122,7 +122,7 @@ test_expect_success 'git svn gc-ed files work' '
 		: Compress::Zlib may not be available &&
 		if test -f "$unhandled".gz
 		then
-			svn mkdir -m gz "$svnrepo"/gz &&
+			svn_cmd mkdir -m gz "$svnrepo"/gz &&
 			git reset --hard $(git rev-list HEAD | tail -1) &&
 			git svn rebase &&
 			test -f "$unhandled".gz &&
-- 
Eric Wong
