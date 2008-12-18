From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] gitk: force the focus to the main window on Windows
Date: Thu, 18 Dec 2008 08:30:49 +0100
Message-ID: <4949FC29.2080200@viscovery.net>
References: <4948E771.4050705@viscovery.net> <18761.29020.237388.687560@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 08:32:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDDMk-0002b1-F4
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbYLRHaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbYLRHaz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:30:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19460 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbYLRHay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:30:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LDDLN-0005qp-Qf; Thu, 18 Dec 2008 08:30:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6B86A6EF; Thu, 18 Dec 2008 08:30:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <18761.29020.237388.687560@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103442>

From: Johannes Sixt <j6t@kdbg.org>

On msysGit, the focus is first on the (Tk) console.  This console is then
hidden, but keeps the focus.  Work around that by forcing the focus onto
the gitk window.

This fixes msysGit issue 14. Diagnosed and originally fixed by
Johannes Schindelin.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Paul Mackerras schrieb:
> At least put a if {[tk windowingsystem] eq "win32"} in there.
> (msysGit is a windows thing, isn't it?)

I did that.

-- Hannes

 gitk |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index b63109b..121b621 100644
--- a/gitk
+++ b/gitk
@@ -10898,4 +10898,9 @@ if {[info exists permviews]} {
 	addviewmenu $n
     }
 }
+
+if {[tk windowingsystem] eq "win32"} {
+    focus -force .
+}
+
 getcommits {}
-- 
1.6.1.rc3.950.g5dd2
