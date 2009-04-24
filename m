From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t7700-repack: repack -a now works properly, expect success from test
Date: Fri, 24 Apr 2009 18:18:53 -0500
Message-ID: <Co3qF9iC9xgxpoIzGtFpX6p4iJOjJWCyIFm5Q0PFl_S8Oz2tukQh2DrW-Is_bK7Ld0lHcP1hN-4@cipher.nrlssc.navy.mil>
References: <Co3qF9iC9xgxpoIzGtFpX2wpm0wGMRif6RL6YZX1xKxhwc2RmS02g8PwAw16-_n3Wi-vA_tZ8Mg@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 01:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUhL-00085x-89
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZDXXTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754385AbZDXXTI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:19:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51209 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbZDXXTG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:19:06 -0400
Received: by mail.nrlssc.navy.mil id n3ONIxT8030532; Fri, 24 Apr 2009 18:19:02 -0500
In-Reply-To: <Co3qF9iC9xgxpoIzGtFpX2wpm0wGMRif6RL6YZX1xKxhwc2RmS02g8PwAw16-_n3Wi-vA_tZ8Mg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 24 Apr 2009 23:18:59.0397 (UTC) FILETIME=[0C1C8750:01C9C533]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117516>

Since the recent rework of the object listing mechanism of
pack-objects/rev-list, git-repack now properly packs objects from alternate
repositories even when the local repository contains packs.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t7700-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6b29bff..87c9b0e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -69,7 +69,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	done
 '
 
-test_expect_failure 'packed obs in alt ODB are repacked when local repo has packs' '
+test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
 	rm -f .git/objects/pack/* &&
 	echo new_content >> file1 &&
 	git add file1 &&
-- 
1.6.2.4.24.gde59d2
