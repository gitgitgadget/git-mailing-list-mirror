From: Martin Nordholts <martin@chromecode.com>
Subject: [PATCH] git.el: Make it easy to add unmerged files
Date: Sun, 30 Aug 2009 16:55:48 +0200
Message-ID: <4A9A92F4.2090209@chromecode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	julliard@winehq.org
X-From: git-owner@vger.kernel.org Sun Aug 30 16:52:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhllv-0003gV-TK
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 16:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZH3Owi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 10:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753786AbZH3Owi
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 10:52:38 -0400
Received: from proxy1.bredband.net ([195.54.101.71]:49327 "EHLO
	proxy1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773AbZH3Owh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 10:52:37 -0400
Received: from iph2.telenor.se (195.54.127.133) by proxy1.bredband.net (7.3.140.3)
        id 49F5A1520314AEFF for git@vger.kernel.org; Sun, 30 Aug 2009 16:52:38 +0200
X-SMTPAUTH-B2: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMkAKIvmkrVcXgmPGdsb2JhbAAIigWRDAEBAQE3uGWEGgU
X-IronPort-AV: E=Sophos;i="4.44,299,1249250400"; 
   d="scan'208";a="39370100"
Received: from c-267871d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.120.38])
  by iph2.telenor.se with ESMTP; 30 Aug 2009 16:52:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127413>

(Resending as I managed to mangle the previous patch despite trying not to...)

It is nice and easy to git-add ignored and unknown files in a
git-status buffer. Make it equally easy to add unmerged files which is
a common use case.

Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
---
 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 8c70ad8..3af5d00 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1046,7 +1046,7 @@ The FILES list must be sorted."
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
+  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored 'unmerged))))
     ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
-- 
1.6.2.5
