From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/5] t7700-repack: repack -a now works properly, expect success from test
Date: Thu, 19 Mar 2009 22:47:53 -0500
Message-ID: <t_s5aa51o2kq_ePRWgLTEtCnzveAKdblNoXw2p9yc1N22fpuARDjOh9wRXpwEKvultyJoNzUWBY@cipher.nrlssc.navy.mil>
References: <EblkEXbcYUWby1OEDup9n0l6lbwNL-4-jyt02Cjab2pqLqekAUji0w@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEkVg4HqH1dQa6_mVq4djPPG4Vxylm2hNqmx7fPC2W5AsfcXg83DYbGc@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEpak5ue1ZM7YICzIF-RsnmN68psiOC0Tnz9bsH5tTxgVEU0bxG-OtJ8@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEg6KbvKii55gDA1y-1oKgx9KP4EKyrqg8sDFaph97G5MPoLgUx_vx48@cipher.nrlssc.navy.mil> <t_s5aa51o2kq_ePRWgLTEvwR8O51ATzGH2_NEfAeCgOx3i1IYGfgLg3-dTPOh68RhaeQgBB9s2g@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, drafnel@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 20 04:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkVk9-000158-47
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 04:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbZCTDsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 23:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZCTDsU
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 23:48:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60276 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZCTDsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 23:48:13 -0400
Received: by mail.nrlssc.navy.mil id n2K3m6KX019885; Thu, 19 Mar 2009 22:48:07 -0500
In-Reply-To: <t_s5aa51o2kq_ePRWgLTEvwR8O51ATzGH2_NEfAeCgOx3i1IYGfgLg3-dTPOh68RhaeQgBB9s2g@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2009 03:48:06.0824 (UTC) FILETIME=[ADDB5A80:01C9A90E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113885>

Thanks to Junio's rework of the --unpacked= option of pack-objects/rev-list
git-repack now properly packs objects from alternate repositories even when
the local repository contains packs.
---
 t/t7700-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 31e6d22..28fc87a 100755
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
1.6.2.16.geb16e
