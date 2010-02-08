From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] filter-branch: Fix error message for --prune-empty --commit-filter
Date: Sun,  7 Feb 2010 18:36:27 -0800
Message-ID: <1265596587-9949-1-git-send-email-jacob.helwig@gmail.com>
Cc: Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 03:36:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeJUQ-0005rp-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412Ab0BHCgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 21:36:37 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:34799 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab0BHCgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 21:36:36 -0500
Received: by pxi27 with SMTP id 27so3319749pxi.4
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 18:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cVClLFL4basxRs/K++UDuOq3BbpfSfSK32zauCoDB1M=;
        b=k9pBV+XvPmsKkBybnO243+MSg92RYMhsrWlTVDWvuOdCVKB/Gk2zkNIqX5kkOIDAls
         XUMR7uo5No6I9SieGrUZMTh8l5yDwP7gfa4TWAMfuIhk1UjVZH+Fqm5Ik61LBnxRhwJx
         kMjOmKH2oEtFWvxmLez3YlEaMvDWPsCzl/ibY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=osBuv3fENdfZRPD9Yd+Kaxwhn7X7xj7D/pjIoeSV93jCg3Ok2JmbjXB71qSuYxDBoq
         5vTXLxXtvBoBv8YRFWJE6IO67bNAL6vZkUSnQih+d+g4pj9+HpZ/CcvllbK2cUw4MtkE
         iVWgNS/6NoT87s1YYPfKgXoFYOVpJ9hfyfXKk=
Received: by 10.140.83.37 with SMTP id g37mr2888108rvb.75.1265596595860;
        Sun, 07 Feb 2010 18:36:35 -0800 (PST)
Received: from localhost.localdomain ([96.225.220.117])
        by mx.google.com with ESMTPS id 23sm6002009pzk.12.2010.02.07.18.36.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 18:36:35 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.50.g8424
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139276>

Running filter-branch with --prune-empty and --commit-filter, no longer
incorrectly reports that you had tried to run '--filter-commit' in
combination with '--prune-empty'.
---

This problem with filter-branch's error message was originally brought up by
hipe in the IRC channel.

 git-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index e95845c..88fb0f0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -207,7 +207,7 @@ t,)
 ,*)
 	;;
 *)
-	die "Cannot set --prune-empty and --filter-commit at the same time"
+	die "Cannot set --prune-empty and --commit-filter at the same time"
 esac
 
 case "$force" in
-- 
1.7.0.rc1.50.g8424
