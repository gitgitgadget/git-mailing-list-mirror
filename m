From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git-gui: fix use of uninitialized variable
Date: Thu, 24 Sep 2009 18:56:28 +0200
Message-ID: <4ABBA4BC.2010408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 24 18:56:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqrcY-0000x9-Vy
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 18:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbZIXQ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 12:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbZIXQ40
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 12:56:26 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:54818 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZIXQ40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 12:56:26 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 438C61246AAF9;
	Thu, 24 Sep 2009 18:56:29 +0200 (CEST)
Received: from [80.128.124.27] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MqrcK-0004rL-00; Thu, 24 Sep 2009 18:56:28 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+FKLDlY5N0d7LUwTNtZ2oS3IcZEkAzvMV2t+OP
	QRTIBRk8TuRSqg9+oRQw7zPkA4qyngiJG6/tvjhNRdY0vhPWHQ
	KdaTYdLwh088rlGZan/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129050>

This fixes a bug introduced by the "display summary when showing diff of a
submodule" patch. It lead to a "no such variable" error when opening the
diff context menu while no diff was shown.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

 git-gui/git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3c0ce26..f727111 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1132,6 +1132,7 @@ set current_branch {}
 set is_detached 0
 set current_diff_path {}
 set is_3way_diff 0
+set is_submodule_diff 0
 set is_conflict_diff 0
 set selected_commit_type new
 set diff_empty_count 0
-- 
1.6.5.rc2.5.gbbf1
