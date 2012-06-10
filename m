From: Lawrence Mitchell <wence@gmx.li>
Subject: [PATCH 3/3] git-blame.el: Do not use bare 0 to mean (point-min)
Date: Sun, 10 Jun 2012 12:58:04 +0100
Message-ID: <1339329484-12088-3-git-send-email-wence@gmx.li>
References: <20120610073803.GA29461@burratino>
 <1339329484-12088-1-git-send-email-wence@gmx.li>
 <1339329484-12088-2-git-send-email-wence@gmx.li>
Cc: jrnieder@gmail.com, git@vger.kernel.org, davidk@lysator.liu.se,
	user42@zip.com.au, osv@javad.com
To: =?UTF-8?q?R=C3=BCdiger=20Sonderfeld?= <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 14:35:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdhMV-0000QX-8n
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 14:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab2FJMfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 08:35:13 -0400
Received: from treacle.ucs.ed.ac.uk ([129.215.16.102]:53121 "EHLO
	treacle.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2FJMfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 08:35:12 -0400
X-Greylist: delayed 2169 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jun 2012 08:35:12 EDT
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by treacle.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q5ABwTH5006527;
	Sun, 10 Jun 2012 12:58:30 +0100 (BST)
Received: from localhost.localdomain (cpc11-sgyl30-2-0-cust962.sgyl.cable.virginmedia.com [94.175.87.195])
	(authenticated user=lmitche4 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q5ABw4hn029717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Jun 2012 12:58:28 +0100 (BST)
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1339329484-12088-2-git-send-email-wence@gmx.li>
X-Edinburgh-Scanned: at treacle.ucs.ed.ac.uk
    with MIMEDefang 2.60, Sophie, Sophos Anti-Virus, Clam AntiVirus
X-Scanned-By: MIMEDefang 2.60 on 129.215.16.102
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199595>

Signed-off-by: Lawrence Mitchell <wence@gmx.li>
---
 contrib/emacs/git-blame.el | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

A small cleanup I noticed while glancing at the code

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 20cf9a6..ef1eebd 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -340,7 +340,7 @@ See also function `git-blame-mode'."
   (with-current-buffer (process-buffer proc)
     (goto-char (process-mark proc))
     (insert-before-markers str)
-    (goto-char 0)
+    (goto-char (point-min))
     (unless in-blame-filter
       (let ((more t)
             (in-blame-filter t))
-- 
1.7.10.2.552.gaa3bb87
