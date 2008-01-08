From: Christian Stimming <stimming@tuhh.de>
Subject: git-gui: Fix broken revert confirmation.
Date: Tue, 8 Jan 2008 21:21:15 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801082121.15952.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKzX-0005fo-1D
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYAHUXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYAHUXM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:23:12 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:53564 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYAHUXL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:23:11 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08KN5Mm024063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Jan 2008 21:23:05 +0100
Received: from [192.168.2.102] (p54900B03.dip0.t-ipconnect.de [84.144.11.3])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m08KMiKe015598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 Jan 2008 21:22:46 +0100
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69914>

I broke this extremely cool feature in 1ac17950,
but it is rather easy to fix this. Sorry for that.

Signed-off-by: Christian Stimming <stimming@tuhh.de>
---
 lib/index.tcl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index a0b22f2..30a244c 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -386,7 +386,9 @@ proc revert_helper {txt paths} {
 	set reply [tk_dialog \
 		.confirm_revert \
 		"[appname] ([reponame])" \
-		[mc "Any unstaged changes will be permanently lost by the revert."] \
+		"$query
+
+[mc "Any unstaged changes will be permanently lost by the revert."]" \
 		question \
 		1 \
 		[mc "Do Nothing"] \
-- 
1.5.3.4.206.g58ba4
