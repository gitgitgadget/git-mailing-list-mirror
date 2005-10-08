From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Allow spaces in $HOME
Date: Sat, 8 Oct 2005 19:41:06 +0200
Message-ID: <20051008174106.GA28875@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 19:43:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOIhC-0005xV-W2
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 19:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVJHRlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 13:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVJHRlJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 13:41:09 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:16859 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932168AbVJHRlI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 13:41:08 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id A00B36E0E7D; Sat,  8 Oct 2005 19:40:55 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id EBDA26E0CD5; Sat,  8 Oct 2005 19:40:54 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 78EB960F95; Sat,  8 Oct 2005 19:41:06 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9842>

Fixes sourcing of ~/.cgrc

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

diff --git a/cg-Xlib b/cg-Xlib
index b27e8b9..1644913 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -336,8 +336,8 @@ ARGPOS=0
 
 if [ -t 1 -a -e "$HOME/.cgrc" ]; then
 	_cg_name=${_cg_cmd#cg-}
-	_cg_defaults1="$(sed -n "/^$_cg_cmd/s/^$_cg_cmd //p" < $HOME/.cgrc)"
-	_cg_defaults2="$(sed -n "/^$_cg_name/s/^$_cg_name //p" < $HOME/.cgrc)"
+	_cg_defaults1="$(sed -n "/^$_cg_cmd/s/^$_cg_cmd //p" < "$HOME/.cgrc")"
+	_cg_defaults2="$(sed -n "/^$_cg_name/s/^$_cg_name //p" < "$HOME/.cgrc")"
 	ARGS=($_cg_defaults1 $_cg_defaults2 "${ARGS[@]}")
 fi
 
-- 
Jonas Fonseca
