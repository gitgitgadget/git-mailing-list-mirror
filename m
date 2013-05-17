From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: fix old organization destroy
Date: Fri, 17 May 2013 05:32:28 -0500
Message-ID: <1368786748-30949-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sandor Bodo-Merle <sbodomerle@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 12:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdHz8-0007Yk-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 12:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3EQKd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 06:33:59 -0400
Received: from mail-gg0-f180.google.com ([209.85.161.180]:55883 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab3EQKd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 06:33:58 -0400
Received: by mail-gg0-f180.google.com with SMTP id q4so818280ggn.25
        for <git@vger.kernel.org>; Fri, 17 May 2013 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ABYej91JXUQbToHTykW+id5ha0OLYDVQtMunKylUxG4=;
        b=VOsYdSCUQ1CSJFtyXUhvYyjHvSisaNyS4TWPY64EascUS8At3KoGojn7SP05Gm6Viq
         pUWaa/MU/aWjA2g6JCbKnePe0p9/REH7rs3A8IiaobqrYxzEUM8Skrv10VMhzEL4LfSD
         IngdGohsOYu6qgoQteBqHbKj6tYbkwFlV1YJdrsdwd7cFa0NuAjshqs53g+moTdYIihc
         hTbmWOzSt1zmK77xZLQLBqWZQlKyg7V31K9vJiDn5YFSIvNjcddTbvMWHQOGDM+oZCFR
         9iUSQD+vq6f9kYYh9Qw2SjWWA2og4P+113TRb3/ouw2BB2JqsL7aTqjIPedhTf/v/ZAv
         MRdQ==
X-Received: by 10.236.187.10 with SMTP id x10mr10309276yhm.190.1368786837777;
        Fri, 17 May 2013 03:33:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w62sm16436880yhd.27.2013.05.17.03.33.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 03:33:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224682>

From: Sandor Bodo-Merle <sbodomerle@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index ad42317..8ecee67 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -837,6 +837,8 @@ def get_repo(url, alias):
                 bdir.destroy_repository()
             except bzrlib.errors.NotBranchError:
                 pass
+            except bzrlib.errors.NoRepositoryPresent:
+                pass
 
     try:
         repo = origin.open_repository()
-- 
1.8.3.rc2.542.g24820ba
