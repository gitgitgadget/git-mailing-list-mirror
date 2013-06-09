From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 30/45] rebase: cherry-pick: set correct action-name
Date: Sun,  9 Jun 2013 11:40:42 -0500
Message-ID: <1370796057-25312-31-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijA-0007CV-Qs
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284Ab3FIQoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:18 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:58241 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3FIQoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:16 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so428015oag.12
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kVI/2mYulwTc1TSDyBnMhRHN60ecYgY8kZ4vOol3IW8=;
        b=l+qQwBUdWLfbXvuhyrDbEefcS5AFWtMOOR9zcGYMLVFGTdRmMYwwkiqE9oAtJsmeWd
         3XtyiLwKQymRw1Wy515n6xtyQrW6z3Vu7bU/vY3DECZdWkRGRk/Zy96h15JhA8yObXEq
         X2GL3bBeae5RC1b6XzNoX3yJIjcsukfwo+PqsMS0RI8g7kMxNfrQy74gRvgTbam9woNr
         uxV6HMu7xTOKlpoO/T3OUw0IzSYRW1arSOc3uaYYmjQB31W5TLQcQ8xlDUfV9zRrXCBr
         bQiVME+iMRPycK0Sn1YR2Sj49tvct9DJUmn4Y1nPgit4rQZXYItdnLYaCcpsMpjpiBJP
         N9lA==
X-Received: by 10.60.42.205 with SMTP id q13mr5178048oel.75.1370796255701;
        Sun, 09 Jun 2013 09:44:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm15187260oem.3.2013.06.09.09.44.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226999>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 241cda7..d36b0dc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -45,7 +45,7 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
-git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
+git cherry-pick --no-merges --right-only --topo-order --do-walk --action-name rebase $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.3.698.g079b096
