From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH 1/3] gitk: Avoid calling tk_setPalette on Windows
Date: Fri, 12 Mar 2010 18:31:47 +0000
Message-ID: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 19:32:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq9ef-0003vt-UD
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 19:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934379Ab0CLScI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 13:32:08 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:43221 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934085Ab0CLScG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 13:32:06 -0500
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Nq9eR-00010S-K0; Fri, 12 Mar 2010 18:31:59 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Nq9eR-0006Sv-1h; Fri, 12 Mar 2010 18:31:59 +0000
Received: from frog (pc014.patthoyts.tk [192.168.0.14])
	by fox.patthoyts.tk (Postfix) with ESMTP id 9678B21945;
	Fri, 12 Mar 2010 18:31:58 +0000 (GMT)
Received: by frog (Postfix, from userid 1000)
	id 770E06D6A1D; Fri, 12 Mar 2010 18:32:19 +0000 (GMT)
X-Mailer: git-send-email 1.6.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142058>

This just messes up the system colors. Leave them alone.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..dc9b8a8 100755
--- a/gitk
+++ b/gitk
@@ -10849,6 +10849,7 @@ proc setselbg {c} {
 # radiobuttons look bad.  This chooses white for selectColor if the
 # background color is light, or black if it is dark.
 proc setui {c} {
+    if {[tk windowingsystem] eq "win32"} { return }
     set bg [winfo rgb . $c]
     set selc black
     if {[lindex $bg 0] + 1.5 * [lindex $bg 1] + 0.5 * [lindex $bg 2] > 100000} {
-- 
1.6.6
