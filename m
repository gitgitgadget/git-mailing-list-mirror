From: "Eric N. Vander Weele" <ericvw@gmail.com>
Subject: [PATCH] log: Update log.follow doc and add to config.txt
Date: Tue,  6 Oct 2015 21:14:33 -0400
Message-ID: <1444180473-8518-1-git-send-email-ericvw@gmail.com>
Cc: "Eric N. Vander Weele" <ericvw@gmail.com>,
	dturner@twopensource.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 03:14:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjdJg-0006kb-JC
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 03:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbbJGBOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 21:14:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33497 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbbJGBOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 21:14:42 -0400
Received: by igbkq10 with SMTP id kq10so100640876igb.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=B1RLupKsCnbkXqO7gYVxsrFVhu1C7rmgQn19c24ITBI=;
        b=zAuixvZHyC24w4oRDgyJTVKI/CDTyvteIAmp5iEDdI7McjTAG3xhbb3sftx0mbpolO
         q0M0V3e73hDifqQ8LPIPMp5lizhdziC0LUo+7h+tKqRTqVNaCmlwvSPfxbmM54yR3d0R
         RCBRaLzKhgFwGGIn6SRZnZnigmjSuphH1mT82iTXPKpn+mQT4dTKvWtlWanz/gor/7QW
         1k8Wis8mEU7VFoHiuo3bLA7sWw+qfPXicjRFf5fIPpe/wRIbIqaLP+dX1V7FpctiVHAV
         smmKu9yxk6SdNXoFedZJwCH8lbEr8+vfNLdZP2VD8hISUo3r+KNCwUcCagKRbZYZUh6V
         NnuQ==
X-Received: by 10.50.114.166 with SMTP id jh6mr20201522igb.47.1444180481739;
        Tue, 06 Oct 2015 18:14:41 -0700 (PDT)
Received: from localhost.localdomain ([207.179.68.194])
        by smtp.gmail.com with ESMTPSA id f31sm13408453ioj.13.2015.10.06.18.14.40
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Oct 2015 18:14:41 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279169>

Documentation/config.txt does not include the documentation for
log.follow that is in Documentation/git-log.txt.  This commit adds the
log.follow documentation to config.txt and also updates the wording to
be consistent with the format that is followed by other boolean
configuration variables.

Signed-off-by: Eric N. Vander Weele <ericvw@gmail.com>
---
 Documentation/config.txt  | 6 ++++++
 Documentation/git-log.txt | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4d3cb10..391a0c3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1838,6 +1838,12 @@ log.decorate::
 	specified, the full ref name (including prefix) will be printed.
 	This is the same as the log commands '--decorate' option.
 
+log.follow::
+	If `true`, `git log` will act as if the `--follow` option was used when
+	a single <path> is given.  This has the same limitations as `--follow`,
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.
+
 log.showRoot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 97b9993..03f9580 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -185,10 +185,10 @@ log.date::
 	dates like `Sat May 8 19:35:34 2010 -0500`.
 
 log.follow::
-	If a single <path> is given to git log, it will act as
-	if the `--follow` option was also used.  This has the same
-	limitations as `--follow`, i.e. it cannot be used to follow
-	multiple files and does not work well on non-linear history.
+	If `true`, `git log` will act as if the `--follow` option was used when
+	a single <path> is given.  This has the same limitations as `--follow`,
+	i.e. it cannot be used to follow multiple files and does not work well
+	on non-linear history.
 
 log.showRoot::
 	If `false`, `git log` and related commands will not treat the
-- 
2.6.0
