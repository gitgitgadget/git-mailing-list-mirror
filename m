From: Ferry Huberts <ferry.huberts@pelagic.nl>
Subject: [PATCH v3 2/2] Ensure consistent usage of mergetool.keepBackup in git
Date: Fri, 10 Apr 2009 21:33:57 +0200
Message-ID: <9a358c8b6275a7103eb036a2d1d6073bcf191e09.1239376248.git.ferry.huberts@pelagic.nl>
References: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>,
	Ferry Huberts <ferry.huberts@pelagic.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 21:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsMVr-0007T4-7q
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 21:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765093AbZDJTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 15:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763431AbZDJTeI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 15:34:08 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:44565 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758329AbZDJTeH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 15:34:07 -0400
Received: from localhost.localdomain (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 61D6F58BDBA;
	Fri, 10 Apr 2009 21:33:58 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl>
In-Reply-To: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl>
References: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116279>

In several places merge.keepBackup is used i.s.o.
mergetool.keepBackup. This patch makes it all
consistent for git

Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
---
Based on pu

 git-mergetool.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index efa31a2..2e3e02b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -257,7 +257,7 @@ prompt_after_failed_merge() {
 merge_tool=$(get_merge_tool "$merge_tool") || exit
 merge_tool_cmd="$(get_merge_tool_cmd "$merge_tool")"
 merge_tool_path="$(get_merge_tool_path "$merge_tool")" || exit
-merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+merge_keep_backup="$(git config --bool mergetool.keepBackup || echo true)"
 merge_keep_temporaries="$(git config --bool mergetool.keepTemporaries || echo false)"
 merge_tool_trust_exit_code="$(git config --bool mergetool."$merge_tool".trustExitCode || echo false)"
 
-- 
1.6.0.6
