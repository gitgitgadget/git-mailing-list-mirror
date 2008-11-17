From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: [PATCH] Retain multiple -q/-v occurrences in git pull
Date: Mon, 17 Nov 2008 23:10:50 +0100
Message-ID: <1226959850-4329-1-git-send-email-tuncer.ayaz@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 17 23:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2CKU-0007Wn-K3
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 23:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbYKQWK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbYKQWK6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 17:10:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:51188 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbYKQWK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 17:10:57 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2235995fgg.17
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=N16vIwALSvuRCMJoBw6BYV6dvWaCwUD0tWvFgo/MiuE=;
        b=Wrmte4Py6d11ZJv6Ah6Dsw5LTIt5ftJDq15pHR6CgYYDCGvr8E5XAeT9eaSTZeeRQb
         75HjHz7pDKOINFoOcfkdvQYqm8aPWEpNL75WmzJAoB6Q6nl/jW5TIMro5L8A9Zq3OMCF
         QYPNAVY9YZaZCimOAgVqGN1H1gJsH4lLXY2Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lWqZylcG4EFbVFJtUfPNzRxFybtkl63sXhEw5VTjAG0LtmeW9rPVN9H7PyvodyCo4Y
         TmGScaWaCgOlzKDwDQQebdO5S9TLHhdGeLZfsI+CBlSm42zsxLC9cM+PUTfqOGVvVn7Q
         TX1/emxfpFra35BNZQqmiPm0+PLKewGwD6WPE=
Received: by 10.181.59.19 with SMTP id m19mr1130402bkk.91.1226959855678;
        Mon, 17 Nov 2008 14:10:55 -0800 (PST)
Received: from localhost (achn-4db4978c.pool.einsundeins.de [77.180.151.140])
        by mx.google.com with ESMTPS id p9sm5245678fkb.5.2008.11.17.14.10.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 14:10:54 -0800 (PST)
X-Mailer: git-send-email 1.6.0.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101251>

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
