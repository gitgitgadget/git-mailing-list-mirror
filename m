From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [PATCH] git-commit: no silent exit on duplicate Signed-off-by lines
Date: Sun, 13 Aug 2006 01:03:28 -0700 (PDT)
Message-ID: <20060813080328.14584.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1998203895-1155456208=:14219"
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Aug 13 10:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCAwX-0004iP-C4
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 10:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHMID3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 04:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHMID3
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 04:03:29 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:61372 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750748AbWHMID3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 04:03:29 -0400
Received: (qmail 14586 invoked by uid 60001); 13 Aug 2006 08:03:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GiRcJNhn6Qr5AUJvbtzanCeiKkB7z2TYt47WNArbBv2rX9th0KvMrDaZEfgW9Fa8ima+4/jI+lFgH7GFDYR2zNp2T5TgC9gFT/2axZcYMu3g078FIeyS0khaPaeILmh7DZsE/cw1MKjcyTyxMprY+2jBpS1Zlswm4C1cio4ysiU=  ;
Received: from [71.80.231.253] by web31805.mail.mud.yahoo.com via HTTP; Sun, 13 Aug 2006 01:03:28 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25277>

--0-1998203895-1155456208=:14219
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

git-commit would silently exit if duplicate Signed-off-by
lines were found.  Users of git-commit would not know it,
unless they checked '$?'.  This patch makes git-commit
actually print out a message that nothing was commited
since duplicate Signed-off-lines were found.

Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
---
 git-commit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
--0-1998203895-1155456208=:14219
Content-Type: text/inline; name="pd.patch"
Content-Description: 3331037722-pd.patch
Content-Disposition: name="pd.patch"; filename="pd.patch"

diff --git a/git-commit.sh b/git-commit.sh
index 4cf3fab..edfd8c0 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -690,7 +690,7 @@ case "$verify" in
 t)
 	if test -x "$GIT_DIR"/hooks/commit-msg
 	then
-		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || exit
+		"$GIT_DIR"/hooks/commit-msg "$GIT_DIR"/COMMIT_EDITMSG || die "Duplicate Signed-off-by lines -- nothing commited"
 	fi
 esac
 
-- 
1.4.2.g73dbd

--0-1998203895-1155456208=:14219--
