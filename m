X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/4] git.el: Move point after the log message header when entering log-edit mode.
Date: Fri, 03 Nov 2006 17:42:17 +0100
Message-ID: <874ptg32ja.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 16:43:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30865>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg27b-0003ta-ON for gcvg-git@gmane.org; Fri, 03 Nov
 2006 17:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753361AbWKCQmV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 11:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKCQmV
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 11:42:21 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:43191 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S1753361AbWKCQmU
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 11:42:20 -0500
Received: from adsl-84-227-158-29.adslplus.ch ([84.227.158.29]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1Gg27X-0004WQ-M0 for
 git@vger.kernel.org; Fri, 03 Nov 2006 10:42:20 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id C34AA109EB7; Fri,
  3 Nov 2006 17:42:17 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Suggested by Han-Wen Nienhuys.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 08d6404..6f3b46d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -899,7 +899,8 @@ and returns the process output as a stri
               (2 font-lock-function-name-face))
              (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
               (1 font-lock-comment-face)))))
-      (log-edit #'git-do-commit nil #'git-log-edit-files buffer))))
+      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
+      (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."
-- 
1.4.3.3.gf3240

-- 
Alexandre Julliard
