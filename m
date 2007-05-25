From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] Replace the last 'dircache's by 'index'
Date: Sat, 26 May 2007 00:37:40 +0200
Message-ID: <11801326633595-git-send-email-jnareb@gmail.com>
References: <11801326601014-git-send-email-jnareb@gmail.com>
 <1180132662719-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 26 00:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HriL9-0006ZS-PM
	for gcvg-git@gmane.org; Sat, 26 May 2007 00:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXEYWco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbXEYWco
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 18:32:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:4279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbXEYWcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 18:32:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1222480ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 15:32:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HR7+h8aJMEQWUmumSJMSmnYx6lG5g7883mr8z5FoXiuvFxKXWx9oFjkk0If5Ob+vQ+haN2TjyDrdbx2E6uCoAi5jVvS83baw7Xuge7KtyJv8r/K/MyBo0INP9JZNdCRP1mzlSYlTDVTlcaKMa6Jt6Hp8YKk22sc7zucvRc0tNkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m+FmumtYem3jPwagy41QT+mH1YKfRaqOjKCio1s9LjSFDb4IiBs63t0mCOy1pRmtaCCdhLWFvfzsXActmVtvI/Y6x/EjTODzbuHCJy86cAOLfOjmHGYyRpLwzyLP2uESsBPe6cxEYKi/C4EyE11pSuzkNnW+BgzjGdrie2dKH3k=
Received: by 10.67.27.3 with SMTP id e3mr3214286ugj.1180132362112;
        Fri, 25 May 2007 15:32:42 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id u9sm15577973muf.2007.05.25.15.32.39;
        Fri, 25 May 2007 15:32:41 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l4PMbhuD015342;
	Sat, 26 May 2007 00:37:43 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l4PMbh1s015341;
	Sat, 26 May 2007 00:37:43 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1180132662719-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48427>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-ls-files.txt |    2 +-
 diff.c                         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 076cebc..43e0d22 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -124,7 +124,7 @@ which case it outputs:
 detailed information on unmerged paths.
 
 For an unmerged path, instead of recording a single mode/SHA1 pair,
-the dircache records up to three such pairs; one from tree O in stage
+the index records up to three such pairs; one from tree O in stage
 1, A in stage 2, and B in stage 3.  This information can be used by
 the user (or the porcelain) to see what should eventually be recorded at the
 path. (see git-read-tree for more information on state)
diff --git a/diff.c b/diff.c
index 0e26049..508bc51 100644
--- a/diff.c
+++ b/diff.c
@@ -1349,7 +1349,7 @@ void fill_filespec(struct diff_filespec *spec, const unsigned char *sha1,
 }
 
 /*
- * Given a name and sha1 pair, if the dircache tells us the file in
+ * Given a name and sha1 pair, if the index tells us the file in
  * the work tree has that object contents, return true, so that
  * prepare_temp_file() does not have to inflate and extract.
  */
-- 
1.5.2
