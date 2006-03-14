From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: [PATCH] Invoke git-stripspace directly.
Date: Tue, 14 Mar 2006 21:11:35 +0000
Message-ID: <20060314211135.GB12498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 14 22:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJGnm-0005kO-Hn
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 22:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWCNVLb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 16:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCNVLb
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 16:11:31 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:43676 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932451AbWCNVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 16:11:30 -0500
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20060314211129.VYSC1060.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:11:29 +0000
Received: from rabbit.zoo.mayhq.org ([80.0.127.16])
          by aamtaout04-winn.ispmail.ntl.com with SMTP
          id <20060314211129.VNJQ18957.aamtaout04-winn.ispmail.ntl.com@rabbit.zoo.mayhq.org>
          for <git@vger.kernel.org>; Tue, 14 Mar 2006 21:11:29 +0000
Received: (qmail 12575 invoked by uid 1000); 14 Mar 2006 21:11:35 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17597>

Run "git-stripspace" instead of "git stripspace" to avoid calling
external git command.

Signed-off-by: Qingning Huo <qhuo@mayhq.co.uk>

---

 git-format-patch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

aad41923a43b82713af05eaa26db688272091520
diff --git a/git-format-patch.sh b/git-format-patch.sh
index 2ebf7e8..486fb31 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -213,7 +213,7 @@ sub show_date {
 }
 
 print "From nobody Mon Sep 17 00:00:00 2001\n";
-open FH, "git stripspace <$commsg |" or die "open $commsg pipe";
+open FH, "git-stripspace <$commsg |" or die "open $commsg pipe";
 while (<FH>) {
     unless ($done_header) {
 	if (/^$/) {
-- 
1.2.4.ga019-dirty
