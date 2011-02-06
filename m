From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: scroll down to default selection for push dialog
Date: Sun, 6 Feb 2011 18:04:27 +0100
Message-ID: <20110206170426.GB47941@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 06 18:04:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm82N-0006bO-8j
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 18:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1BFREa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 12:04:30 -0500
Received: from darksea.de ([83.133.111.250]:39965 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753016Ab1BFRE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 12:04:29 -0500
Received: (qmail 7947 invoked from network); 6 Feb 2011 18:04:28 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Feb 2011 18:04:28 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166154>

If the list of remote/local branches is very long its inconvenient
to scroll down and find the selected branch. This patch makes the
widget automatically scroll down so its shown on the top.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
Note: Please also apply with 'git am -p2'

 git-gui/lib/transport.tcl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index e4e1add..6478efa 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -211,6 +211,7 @@ proc do_push_anywhere {} {
 		$w.source.l insert end $h
 		if {$h eq $current_branch} {
 			$w.source.l select set end
+			$w.source.l yview end
 		}
 	}
 	pack $w.source.l -side left -fill both -expand 1
-- 
1.7.4.34.gd2cb1
