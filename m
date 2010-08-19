From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t9155: fix compatibility with older SVN
Date: Thu, 19 Aug 2010 12:15:52 -0700
Message-ID: <20100819191552.GB1543@dcvr.yhbt.net>
References: <4C6D6274.90009@web.de> <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com> <20100819191425.GA1543@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	"David D. Kilzer" <ddkilzer@kilzer.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 21:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmAaj-00068M-Oa
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 21:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab0HSTPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 15:15:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57752 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753319Ab0HSTPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 15:15:52 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580001F4FC;
	Thu, 19 Aug 2010 19:15:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100819191425.GA1543@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153949>

The "--parents" option did not appear until SVN 1.5.x
and is completely unnecessary in this case.

Reported-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Also pushed up to git://git.bogomips.org/git-svn

 t/t9155-git-svn-fetch-deleted-tag.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9155-git-svn-fetch-deleted-tag.sh b/t/t9155-git-svn-fetch-deleted-tag.sh
index ef0ac87..a486a98 100755
--- a/t/t9155-git-svn-fetch-deleted-tag.sh
+++ b/t/t9155-git-svn-fetch-deleted-tag.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup svn repo' '
 	svn_cmd import -m "import for git svn" import "$svnrepo" &&
 	rm -rf import &&
 
-	svn_cmd mkdir --parents -m "create mybranch directory" "$svnrepo/branches/mybranch" &&
+	svn_cmd mkdir -m "create mybranch directory" "$svnrepo/branches/mybranch" &&
 	svn_cmd cp -m "create branch mybranch" "$svnrepo/trunk" "$svnrepo/branches/mybranch/trunk" &&
 
 	svn_cmd co "$svnrepo/trunk" svn_project &&
-- 
Eric Wong
