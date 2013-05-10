From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote-hg: test: be a little more quiet
Date: Fri, 10 May 2013 05:17:02 -0500
Message-ID: <1368181023-10402-4-git-send-email-felipe.contreras@gmail.com>
References: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 12:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UakPo-0001xR-HU
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 12:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3EJKSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 06:18:41 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34898 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3EJKSk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 06:18:40 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so4673200oah.35
        for <git@vger.kernel.org>; Fri, 10 May 2013 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4vPbgWTyK156NqPN1s9pJ6keUa7pc+pCZHcQOtUQDvA=;
        b=zyerY9cmnws55kmUFCczK1PjWTVtTwyaSk3RIis1vLNp2Wov9DI6uaGmJStBNSE8Tj
         Vdoun3coq8NmdjLv/blLuZBvrffy9iJ1FuTdD7QwyxoowURmt3BPDlVY+uKwtbNnzPpF
         ALfOnvoVTZta32TWhhQClsCfUJ8WH9VFVz+a/TvyfRHXTgX0WOYV02M7pykINTpn6jgs
         XKXDgwPvzse5pOn2nV9VP7xlfjNJrrKf106QgKV8kp3eDFvIgfJFMX9KOXiO1TyrJbhi
         DsJXNRcs4yQWqrfbEEzdqf93rB9QLEHPIywtnC1ebRjPOWsEoqDzkA8DbMtkMt4264iQ
         +UAA==
X-Received: by 10.60.34.167 with SMTP id a7mr6690580oej.20.1368181120280;
        Fri, 10 May 2013 03:18:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm2213006oes.6.2013.05.10.03.18.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 03:18:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.555.gd13b5a0
In-Reply-To: <1368181023-10402-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223830>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8de2aa7..f8d1f9e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -109,10 +109,10 @@ test_expect_success 'update bookmark' '
   (
   git clone "hg::$PWD/hgrepo" gitrepo &&
   cd gitrepo &&
-  git checkout devel &&
+  git checkout --quiet devel &&
   echo devel > content &&
   git commit -a -m devel &&
-  git push
+  git push --quiet
   ) &&
 
   hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
-- 
1.8.3.rc1.555.gd13b5a0
