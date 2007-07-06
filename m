From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-commit: add commit.signoff config option
Date: Fri, 6 Jul 2007 14:45:43 +0000
Message-ID: <20070706144543.12001.qmail@562ca05ec1cc76.315fe32.mid.smarden.org>
References: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 16:45:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6p3s-0004HM-3r
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 16:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665AbXGFOp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 10:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbXGFOp3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 10:45:29 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:41325 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753653AbXGFOp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 10:45:28 -0400
Received: (qmail 12002 invoked by uid 1000); 6 Jul 2007 14:45:43 -0000
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070706144227.11736.qmail@046ba2bc1a0185.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51755>

Have the commit.signoff boolean config option automatically add a
Signed-off-by: by git-commit, without giving the -s switch explicitly.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-commit.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 7a7d19a..b493820 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -275,6 +275,7 @@ $1"
 	esac
 done
 case "$edit_flag" in t) no_edit= ;; esac
+test "$(git config --bool commit.signoff)" != true || signoff=t
 
 ################################################################
 # Sanity check options
-- 
1.5.2.1
