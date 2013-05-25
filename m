From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 16/48] remote-hg: trivial cleanups
Date: Fri, 24 May 2013 21:29:32 -0500
Message-ID: <1369449004-17981-17-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Hf-0001rE-41
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab3EYCce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:34 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:37103 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab3EYCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:32 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6212911obc.27
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M0MHWzas5xaLDKNUUh1Cvp8ELS+zRXVjrN/fn5ydP4c=;
        b=yJovLa6pzvG1g9VqetQ+wvfQbVi/NdxyAfSxCFRRDLU/b1MXTAUqcSePNC57CIH/k6
         ZJN5Pzv68NZowZFIGFTmo0NkOQ26pOcEpOWK0rSUY1VUfCqT62nJoyRB1qkFxoIrQ1Xs
         rhMgr44+ZH+8HmOrzOcjHUZOBHsCHXvOJcFlBi6TMhOJRUcyF+UQZD4e1Z0sE5tkF8PO
         zaCBcEYGJdx9RY+YlxT7SCmk/y9TUynsdIqIceN34TFtLNbltqVU0sBeFGv1YYiyq1Xa
         R0ZSkB9HA3Wb5n1mt9xQwvNauaJqJ888saUqSMsmAKGU8yPTo77ZYLsqSsEzguJPPm9M
         dhWA==
X-Received: by 10.182.84.135 with SMTP id z7mr13748413oby.35.1369449151917;
        Fri, 24 May 2013 19:32:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9140747oeo.8.2013.05.24.19.32.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225429>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index e0e68ef..ee60dbf 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -74,11 +74,11 @@ def hgmode(mode):
     m = { '100755': 'x', '120000': 'l' }
     return m.get(mode, '')
 
-def hghex(node):
-    return hg.node.hex(node)
+def hghex(n):
+    return node.hex(n)
 
-def hgbin(node):
-    return hg.node.bin(node)
+def hgbin(n):
+    return node.bin(n)
 
 def hgref(ref):
     return ref.replace('___', ' ')
@@ -734,12 +734,12 @@ def parse_commit(parser):
     if from_mark:
         p1 = mark_to_rev(from_mark)
     else:
-        p1 = '\0' * 20
+        p1 = '0' * 40
 
     if merge_mark:
         p2 = mark_to_rev(merge_mark)
     else:
-        p2 = '\0' * 20
+        p2 = '0' * 40
 
     #
     # If files changed from any of the parents, hg wants to know, but in git if
@@ -826,7 +826,7 @@ def write_tag(repo, tag, node, msg, author):
         return context.memfilectx(f, content, False, False, None)
 
     p1 = tip.hex()
-    p2 = '\0' * 20
+    p2 = '0' * 40
     if not author:
         author = (None, 0, 0)
     user, date, tz = author
-- 
1.8.3.rc3.312.g47657de
