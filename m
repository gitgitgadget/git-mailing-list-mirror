From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 3/3] stash: modify tests to reflect stash branch fixes.
Date: Tue,  3 Aug 2010 20:36:15 +1000
Message-ID: <1280831775-30759-4-git-send-email-jon.seymour@gmail.com>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 12:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEt5-0002jL-Fd
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0HCKiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 06:38:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58488 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060Ab0HCKiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:38:16 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1594935pwi.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=bEPX5ERZyY5QrPV+foJuSVhqxiFDlMjbz3wu3fvzWxs=;
        b=iLogKQa6YPtkIk0/tGAbTP5/j3NlwPrupLgOyI6CCIgvPmpvrXrLP2UsabGEhXAmFs
         XDGCngAhTnYV1viUpWxfWLviRzhPSROukn07odr04LzN2sxaRJnT6xCpdgDrBnJwOo+w
         z8fD+bPpyh4+8Ve3lVlnz51SMk+9pkAiRAyZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aixqE4zm+mXBKUHxEZZiV01OExG6adKn/cd0fTI66+2KdPe+4nU7mUS4JyclGwAYZo
         cp53bWkB8MT1dOQAaGyUSRfKWw7agfLWsEgkMHYKbsKE+0Jup/MSuv0y9p6y4q8HpqkT
         CF6EfH7uNVhb+kjzzEP4KZbPeLzEs5aKUmxro=
Received: by 10.114.95.12 with SMTP id s12mr8745703wab.226.1280831895995;
        Tue, 03 Aug 2010 03:38:15 -0700 (PDT)
Received: from localhost.localdomain (r220-101-137-36.cpe.unwired.net.au [220.101.137.36])
        by mx.google.com with ESMTPS id c24sm13374316wam.19.2010.08.03.03.38.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:38:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.111.g8fc90
In-Reply-To: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152502>

These tests now pass so they are now updated to reflect this.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4d8b6ad..e5f248e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,7 +378,7 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
-test_expect_failure 'stash branch from arbitrary stash ref when there are no stash references' '
+test_expect_success 'stash branch with no stashes on stack and stash-like reference as argument' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
@@ -391,10 +391,8 @@ test_expect_failure 'stash branch from arbitrary stash ref when there are no sta
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
-test_expect_failure 'stash branch from arbitrary stash ref fails even if there is a stash' '
-	git stash clear && {
-		git branch -D stash-branch || true
-	}
+test_expect_success 'stash branch with stashes on stack and stash-like reference as argument' '
+	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
 	git reset --hard &&
 	echo foo >> file &&
-- 
1.7.2.1.111.g8fc90
