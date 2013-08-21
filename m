From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH 1/3] git-completion.bash: use correct Bash/Zsh array length syntax
Date: Wed, 21 Aug 2013 13:49:31 -0700
Message-ID: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:49:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFLb-0005m8-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab3HUUtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:49:39 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1310 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab3HUUti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:49:38 -0400
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
	id <B521527e00000>; Wed, 21 Aug 2013 13:49:36 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2013 13:49:37 -0700
X-PGP-Universal: processed;
	by hqnvupgp07.nvidia.com on Wed, 21 Aug 2013 13:49:37 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server id 8.3.298.1; Wed, 21 Aug 2013
 13:49:07 -0700
X-Mailer: git-send-email 1.8.4.rc0.2.g6cf5c31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232729>

From: Brandon Casey <drafnel@gmail.com>

The syntax for retrieving the number of elements in an array is:

   ${#name[@]}

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5da920e..e1b7313 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2580,7 +2580,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 				--*=*|*.) ;;
 				*) c="$c " ;;
 				esac
-				array[$#array+1]="$c"
+				array[${#array[@]}+1]="$c"
 			done
 			compset -P '*[=:]'
 			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-- 
1.8.4.rc0.2.g6cf5c31


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
