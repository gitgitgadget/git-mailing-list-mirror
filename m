From: martin@ng.eduforge.org (Martin Langhoff)
Subject: [PATCH] git-cvsimport - remove hardcoded reference to origin
Date: Wed, 17 Aug 2005 09:27:09 +1200 (NZST)
Message-ID: <20050816212709.1958B3300AD@ng.eduforge.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 23:28:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E58xm-0006Es-7U
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 23:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVHPV1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbVHPV1K
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 17:27:10 -0400
Received: from 34.70-85-230.reverse.theplanet.com ([70.85.230.34]:16551 "EHLO
	ng.eduforge.org") by vger.kernel.org with ESMTP id S932728AbVHPV1J
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 17:27:09 -0400
Received: by ng.eduforge.org (Postfix, from userid 3373)
	id 1958B3300AD; Wed, 17 Aug 2005 09:27:09 +1200 (NZST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] git-cvsimport - remove hardcoded reference to origin

Signed-off-by: Martin Langhoff <martin.langhoff@gmail.com>

---

 git-cvsimport-script |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

61d32d57375d751f565baf61a144ebd6e0d6a61d
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -578,7 +578,7 @@ my $commit = sub {
 		foreach my $rx (@mergerx) {
 			if ($logmsg =~ $rx) {
 				my $mparent = $1;
-				if ($mparent eq 'HEAD') { $mparent = 'origin'};
+				if ($mparent eq 'HEAD') { $mparent = $opt_o };
 				if ( -e "$git_dir/refs/heads/$mparent") {
 					$mparent = get_headref($mparent, $git_dir);
 					push @par, '-p', $mparent;
