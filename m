From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] rebase: pass --signoff option to git am
Date: Thu, 16 Sep 2010 11:07:59 +0200
Message-ID: <1284628079-14156-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 16 11:08:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwASB-00031P-KU
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 11:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab0IPJIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 05:08:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60216 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab0IPJIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 05:08:21 -0400
Received: by wwe15 with SMTP id 15so108124wwe.1
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QWGc856cQtsERMOdJdEQgXam6PxTVBK5C8e/4elIU7c=;
        b=LHkvp1MIj765O6oA62zCQfj1+y2lk4NoeQ6XSOw/KOSizwDdlQYGvLvWAaCG9NmVjd
         /jE+r2NjRnzp02Ly7+23gqdv/JihzSIH/Mf2OTCFw0Q/Jraz7H0JNDrG4i80wD/SS6U6
         mB91wFmj4jJl4AvORgMsxYRA7JHhbLjIvy/nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=iGK+vmyfZC3sKBSJ7sWh9cg67qWADd8Irlom7myqqZs7oHAhXQ70VFGaqpa+yq0TCn
         imMHkH5ViJpupTOvPQFQfblR/n2h9SGl+9uciRiSAwIaexuBXd8xeqJevnqjFlzTIyHW
         ztBmDK7nuQSBDZgAkuZzj019RebO952TMuj2Y=
Received: by 10.216.155.199 with SMTP id j49mr2448564wek.48.1284628098124;
        Thu, 16 Sep 2010 02:08:18 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id w1sm1655063weq.1.2010.09.16.02.08.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 02:08:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.230.g8b572
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156301>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Although this patch is born to help people like me that forget to sign
off their patchset before sending, it can also be of help to maintainers
that want to add their signoff to a patchset in case they forgot during
the `git am` run. (Also, there is no reason why this `git am` option
should not be available through `git rebase`.)

diff --git a/git-rebase.sh b/git-rebase.sh
index 3335cee..cdb4299 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -358,7 +358,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-- 
1.7.3.rc1.230.g8b572
