From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: [PATCH] filter-branch: Fix error message for --prune-empty --commit-filter
Date: Thu, 11 Feb 2010 18:46:22 -0800
Message-ID: <1265942782-16257-1-git-send-email-jacob.helwig@gmail.com>
References: <4B6FE325.5000909@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 03:46:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NflYK-0007UW-NH
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 03:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab0BLCqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 21:46:40 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:54574 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757817Ab0BLCqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 21:46:39 -0500
Received: by pzk2 with SMTP id 2so1508068pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 18:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hZURK9pbM0m5TV8Pb3DDugjXLdwmVmBOMD0M7otGN40=;
        b=U2TbnMQ8QZl5CsvrBxiFGiBUBkg/hv0OByeHIYDSuWCU2mLHkJlJYogbheNGz4X4L2
         ZAj3UpIe32e0uZRjS4JxXFkRHU8x7cAiUXNgHs6ZvoKMmG83scK/2Thzf2yxup2ypIP2
         lwt9NVONYfyRHY5xhPRfVtrrgvgjVF3oqAxDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T0z6q41/58v2QDRD7fo/yl4Bx0b3kszysrLxbSS5KZnFbPhy9kBVV5xVKLdoM+lS0w
         opXvpfzlRtWdz6ML/DcJwP3TI2y5sXkunf4mtUnSfGUuA6rdIsaYfS3fHyteTS6gMy+C
         eRna6lrr+Wxi6SFNBfH4I0jOJNGgbilQFqpWc=
Received: by 10.114.248.14 with SMTP id v14mr486615wah.194.1265942798612;
        Thu, 11 Feb 2010 18:46:38 -0800 (PST)
Received: from localhost.localdomain ([96.225.220.117])
        by mx.google.com with ESMTPS id 21sm4896938pzk.3.2010.02.11.18.46.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 18:46:37 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <4B6FE325.5000909@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139655>

Running filter-branch with --prune-empty and --commit-filter reports:
  "Cannot set --prune-empty and --filter-commit at the same time".

Change it to use the correct option name: --commit-filter

Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
---

Sorry for taking so long to respond to this.

I wasn't quite happy with the suggested commit message, but hopefully this will
make everyone happy.

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
1.6.6.1
