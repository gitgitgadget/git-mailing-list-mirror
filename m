From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: [JGIT PATCH] Silence noise from javadoc when generating.
Date: Tue, 11 Aug 2009 07:39:59 +0200
Message-ID: <1249969199-10049-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:29:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MarPX-0000AG-5a
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZHKN2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZHKN2y
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:28:54 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59311 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZHKN2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:28:54 -0400
Received: by ewy10 with SMTP id 10so3770614ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=G7BQCCw44Xwix2MXWlkKenhIJvBZFBahz2BRTGRQJkM=;
        b=RQ3STIcBeDWgKcRJhj0pFpgRS7na7pj0l39l9Pmwgq4rEXJ6S+iWGm0B/n2JPaBq+A
         U1ygD0nsjGqg0e+hfTYNm6Jl7O2nAPn9IAAzhHUKmWYSTjRmV4M2ns4WdFf92nUD268N
         c0c5tBCxX1HocZ7cf3Ae1WNXkcv4YZm3ZkA6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qVwIgkZ8LhNekYM7jgRIZl7eN32wIjAdoSMF3wHuHeJBq3h5bALvZKbbSycMf/iAk5
         kIZEErKlrpFJiFM5pVdHJcy/1niuWA9GyxI1YCLUINpPATQ3xbVNUPG1Wl5FTBvVaHKf
         sByrPH4X49a9NLkZ/OXH7+DNCqbbJjoDuP5rc=
Received: by 10.210.63.12 with SMTP id l12mr417256eba.15.1249969211015;
        Mon, 10 Aug 2009 22:40:11 -0700 (PDT)
Received: from localhost.localdomain (h59n1fls34o811.telia.com [213.67.102.59])
        by mx.google.com with ESMTPS id 10sm2132404eyd.7.2009.08.10.22.40.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 22:40:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125556>

We do not need javadoc(1) to tell us about every file it is processing. With
the -quiet flag we get to see warnings and errors instead.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 make_jgit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index 9608b70..e3f7ffa 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -122,7 +122,7 @@ echo "Created $O_CLI." || die "Build failed."
 
 echo "Building Javadocs ..."
 for p in $PLUGINS; do
-	javadoc -sourcepath "$p/src/" -d "docs/$p/" \
+	javadoc -quiet -sourcepath "$p/src/" -d "docs/$p/" \
 	`find "$p/src" -name "*.java"`
 done
 
-- 
1.6.3.2.199.g7340d
