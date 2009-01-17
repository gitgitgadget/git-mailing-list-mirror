From: "Ray Chuan" <rctay89@gmail.com>
Subject: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 02:59:29 +0000
Message-ID: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1Qe-00087x-FH
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbZAQC7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 21:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZAQC7b
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 21:59:31 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:35206 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZAQC7a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 21:59:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1037076wah.21
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 18:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=CFeguLgCDljjGHsoI2LF3ne7LbgUfG+bdE3DNok9SCY=;
        b=i+gXmLbPTiTLrjG5tRWtZcGTGP+Szd1d1CXzfokMBzIkNMIHNFf9fPaCQ0KWW7GjJh
         yDphPWOenDWemOc20sbSBl7VVNUYnEXLZvghxyL4VU3x+/FrLQzRbkSBeIPME1osgLQS
         /jw+z/tEcLFY8ZpNDtG3ZNLcPVv9/wU3GGKHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=WsN64Zb65v3ujPyGAGZ7xIxW5UdTaioAcyOqFT62+mIZDTjLqUl9rTEjqI9mNJUWOn
         7rs7II8O48LUpF7HnOpLc0GxYggT6mGuAfuLwc/6SWJdKjjsdBQ9pxjWs54sJxkGFFB9
         H0nF4L3wfJyF/eE3AFIFXwtp7dXMDriEej8TU=
Received: by 10.114.53.1 with SMTP id b1mr2245087waa.173.1232161169967;
        Fri, 16 Jan 2009 18:59:29 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Fri, 16 Jan 2009 18:59:29 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106014>

note: the test needs to chmod the test_repo.git folder so that
apache/mod_dav can create .DAV folders in it for locking.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 src/git-1.6.1/t/t5540-http-push.sh |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/git-1.6.1/t/t5540-http-push.sh
b/src/git-1.6.1/t/t5540-http-push.sh
index da95886..730b9cb 100755
--- a/src/git-1.6.1/t/t5540-http-push.sh
+++ b/src/git-1.6.1/t/t5540-http-push.sh
@@ -51,17 +51,16 @@ test_expect_success 'clone remote repository' '
 	git clone $HTTPD_URL/test_repo.git test_repo_clone
 '

-test_expect_failure 'push to remote repository' '
+test_expect_success 'push to remote repository' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	: >path2 &&
 	git add path2 &&
 	test_tick &&
 	git commit -m path2 &&
-	git push &&
-	[ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
+	git push origin master
 '

-test_expect_failure 'create and delete remote branch' '
+test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
 	: >path3 &&
-- 
1.6.0.4
