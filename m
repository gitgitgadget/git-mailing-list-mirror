From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] gitk: Add shortcut Ctrl-W for closing the active window
Date: Tue, 02 Feb 2010 23:11:28 +0100
Message-ID: <4B68A310.6000807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 23:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQy8-0003nP-Sk
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 23:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab0BBWLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 17:11:31 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:52740 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911Ab0BBWLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 17:11:30 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id B2A6113CFBD7D;
	Tue,  2 Feb 2010 23:11:29 +0100 (CET)
Received: from [80.128.126.55] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NcQy1-0004P7-00; Tue, 02 Feb 2010 23:11:29 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/SGN6es3nVijBPHsMLhY9/5a6oLHrWHZlhYYSX
	XsuB13yNQhazrbEDWDiVyKdNq4V1djYfTvONQYHECsHlhCXiwf
	XG3h5rwXtFxrlI0wBzZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138769>

To make the user experience between git gui and gitk more homogeneous, use
Ctrl-W in gitk too for closing the active window. When closing the main
window doquit is called for proper cleanup.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Found myself hitting Ctrl-W in gitk with no effect once too often ;-)

 gitk-git/gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 03dd0f4..9629394 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2383,6 +2383,8 @@ proc makewindow {} {
     }
     bindall <$::BM> "canvscan mark %W %x %y"
     bindall <B$::BM-Motion> "canvscan dragto %W %x %y"
+    bind all <$M1B-Key-w> {destroy [winfo toplevel %W]}
+    bind . <$M1B-Key-w> doquit
     bindkey <Home> selfirstline
     bindkey <End> sellastline
     bind . <Key-Up> "selnextline -1"
@@ -2814,6 +2816,7 @@ proc keys {} {
 [mc "Gitk key bindings:"]

 [mc "<%s-Q>		Quit" $M1T]
+[mc "<%s-W>		Close window" $M1T]
 [mc "<Home>		Move to first commit"]
 [mc "<End>		Move to last commit"]
 [mc "<Up>, p, i	Move up one commit"]
-- 
1.7.0.rc1.173.gc7c5.dirty
