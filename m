From: imyousuf@gmail.com
Subject: [PATCH] - Added command synopsis in code and edited them in manual
Date: Thu,  6 Mar 2008 13:33:33 +0600
Message-ID: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com, Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAcZ-0007vh-F6
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbYCFHdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYCFHdx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:33:53 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:41464 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbYCFHdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 02:33:52 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1229660hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=WrGzNcJLnJbeFaCy/iw049dIyKDlhaZ6kzrew/9ACIA=;
        b=oTQH1BMfnRNANFYpaEKXR24OewhrUFGeAivzjjl9sHdUxxWyQBwUEwRjaTSXKTdVNRZCRxZfkXAIsINtI48HyrnMpNjDvicyj56uY5df7wAfrBKp6Ip6e+gEikQEpy3IxX8KeIrGs6hCKAq1YtHMdacsJ3K7p5rZO6jf8mviopU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=i3tNw/slC1HCIQexIBgJ1pmwZjXg4NUCHZUcQYiD4emrIC0lrpQbdTrkDO/02+xIRgkWemPigBNUgDdLEpbLArysXMQo6+QD/xRKsmvBpqJrGaYBLspqzBrl1Bghs8lRzixNsi+ZOoh2PwDAmVnr1Vuouye8ZxcwXTARtvUZuSE=
Received: by 10.86.71.1 with SMTP id t1mr4333850fga.7.1204788831131;
        Wed, 05 Mar 2008 23:33:51 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id q9sm3126564gve.10.2008.03.05.23.33.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 23:33:49 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76347>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Added the command synopsis so that they are available for
any future command additions.

Quiet can also be specified using -q and it was missing in
the usage in the code and man page.

In the init/update command synopsis either of them is required
command as is add in its synopsis, so removed the square brackets
around them from the documentation

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 Documentation/git-submodule.txt |    6 +++---
 git-submodule.sh                |    6 +++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e818e6e..595918e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,9 +9,9 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git-submodule' [--quiet] add [-b branch] [--] <repository> [<path>]
-'git-submodule' [--quiet] status [--cached] [--] [<path>...]
-'git-submodule' [--quiet] [init|update] [--] [<path>...]
+'git-submodule' [-q|--quiet] add [-b branch] [--] <repository> [<path>]
+'git-submodule' [-q|--quiet] [status] [--cached] [--] [<path>...]
+'git-submodule' [-q|--quiet] init|update [--] [<path>...]
 
 
 COMMANDS
diff --git a/git-submodule.sh b/git-submodule.sh
index 67d3224..257be4c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -4,7 +4,11 @@
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
+# Synopsis of this commands are as follows
+# git-submodule [-q|--quiet] add [-b|--branch branch] <repository> [<path>]
+# git-submodule [-q|--quiet] [status] [-c|--cached] [--] [<path>...]
+# git-submodule [-q|--quiet] init|update [--] [<path>...]
+USAGE='[-q|--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
 OPTIONS_SPEC=
 . git-sh-setup
 require_work_tree
-- 
1.5.4.2

