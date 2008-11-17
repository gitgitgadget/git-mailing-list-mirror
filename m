From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Retain multiple -q/-v occurrences in git pull
Date: Mon, 17 Nov 2008 23:09:30 +0100
Message-ID: <1226959770-4252-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: gitster@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 23:11:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CJN-00076Q-5b
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbYKQWJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYKQWJp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:09:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:44498 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752197AbYKQWJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:09:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2235671fgg.17
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=N16vIwALSvuRCMJoBw6BYV6dvWaCwUD0tWvFgo/MiuE=;
        b=XIQkn3AwNtJwlE+3vIE8deiaTa5L55PRI8fGTEYM5ytPwUrPlMfeAW+F8/Xa4KKn7R
         LZXn8Vuqcp8xb+tCdnLYtWr2EAUJVWPyfIvdYYrr1oYUB7GFfPH4IN9kSyFFiCmRoO6m
         8KTdf5S6/qgWqwouSWbQDYHDjQ0KQGn/0phrE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BtCrNFZZyOx5+BEtOUQ9tMehqwmj6f+vsoNKCVMA2DhgcToneOguJz6lBWutWnq6KF
         t/FWZRjEmjG3lTj1c5HZMGg/jpo38rVjjGg/3da5Nbm2A8BzzCmixvCezcexVAXpMKA6
         AcXSjvA8qyYoBLFTakk2dFFeo+feltJgkxn2c=
Received: by 10.181.48.13 with SMTP id a13mr1133925bkk.97.1226959782166;
        Mon, 17 Nov 2008 14:09:42 -0800 (PST)
Received: from localhost (achn-4db4978c.pool.einsundeins.de [77.180.151.140])
        by mx.google.com with ESMTPS id 28sm5238322fkx.1.2008.11.17.14.09.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 14:09:41 -0800 (PST)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101249>

To support counting -q/-v options in git pull retain
them by concatenating.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 git-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 8866f2a..1cac898 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -24,9 +24,9 @@ while :
 do
 	case "$1" in
 	-q|--quiet)
-		verbosity=-q ;;
+		verbosity="$verbosity -q" ;;
 	-v|--verbose)
-		verbosity=-v ;;
+		verbosity="$verbosity -v" ;;
 	-n|--no-stat|--no-summary)
 		no_stat=-n ;;
 	--stat|--summary)
-- 
1.6.0.2.GIT
