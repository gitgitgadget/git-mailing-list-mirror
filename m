From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-am: initialize variable $resume on startup
Date: Mon, 6 Aug 2007 14:15:30 +0000
Message-ID: <20070806141530.10422.qmail@8bd9c2a0b9ecab.315fe32.mid.smarden.org>
References: <20070803201405.GB12430@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II3Mf-0001nM-TJ
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 16:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXHFOPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 10:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755219AbXHFOPN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 10:15:13 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:42869 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1753482AbXHFOPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 10:15:11 -0400
Received: (qmail 10423 invoked by uid 1000); 6 Aug 2007 14:15:30 -0000
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20070803201405.GB12430@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55150>

git-am expects the variable $resume to be empty or unset, which might not
be the case if $resume is set in the user's environment.  So initialize
it to an empty value on startup.

The problem was noticed by Pierre Habouzit and reported through
 http://bugs.debian.org/435807

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6cf0eee..b5ed8ca 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -103,7 +103,8 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= resolvemsg=
+dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
+resolvemsg= resume=
 git_apply_opt=
 
 while case "$#" in 0) break;; esac
-- 
1.5.3.GIT
