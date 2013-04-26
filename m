From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/9] remote-helpers: trivial cleanups
Date: Fri, 26 Apr 2013 16:12:31 -0500
Message-ID: <1367010759-17928-2-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpy2-00076o-Ox
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757409Ab3DZVOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34450 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3DZVOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:00 -0400
Received: by mail-ob0-f174.google.com with SMTP id wc20so3936439obb.5
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=hzyy5f5RDKPQQdGdQNmcmIvdRqqjfq9a/o7HxEmCLJU=;
        b=c4rpF2Jg54CPRU4og+m5A+mslArayOSQoGLPxpbXscT7A518qygsGKNbE3LJbXg1fa
         gPNabhW+RW+26O+5EZusxgwUiWvAMwc7KRj+DQ1yD17LiXk+r2tT4uObEWWokgesJFWT
         ENb/FVHhOj+oUdVdvJZ1coG/ns5y+fOcXvJOR7duNzWIvoGwCLY19KvYL22toCjXgyyU
         11uS04EqgjqABbfInPaAaH1oEHNxv3hsM0Ttnduyu888eqxT6mfdDnl45laM114t4lzY
         XRGz53o5Cw7U6vJaIOw+GaNT2USzQlYj5ftL00xL7ZWGKEKhXA/iDqi1iWWKpF4wT9aR
         5n/Q==
X-Received: by 10.182.33.40 with SMTP id o8mr9862106obi.39.1367010838538;
        Fri, 26 Apr 2013 14:13:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm9391469oby.5.2013.04.26.14.13.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:13:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222583>

No functional changes. Typos, unused variables, redundant operations,
and white-spaces.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 7 ++++---
 contrib/remote-helpers/git-remote-hg  | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index cc6609b..87c54bf 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -94,7 +94,7 @@ class Marks:
         return self.last_mark
 
     def is_marked(self, rev):
-        return str(rev) in self.marks
+        return rev in self.marks
 
     def new_mark(self, rev, mark):
         self.marks[rev] = mark
@@ -224,7 +224,7 @@ def export_files(tree, files):
             else:
                 mode = '100644'
 
-            # is the blog already exported?
+            # is the blob already exported?
             if h in filenodes:
                 mark = filenodes[h]
                 final.append((mode, mark, path))
@@ -521,7 +521,7 @@ def c_style_unescape(string):
     return string
 
 def parse_commit(parser):
-    global marks, blob_marks, bmarks, parsed_refs
+    global marks, blob_marks, parsed_refs
     global mode
 
     parents = []
@@ -643,6 +643,7 @@ def do_export(parser):
                 wt = repo.bzrdir.open_workingtree()
                 wt.update()
         print "ok %s" % ref
+
     print
 
 def do_capabilities(parser):
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index fda4199..cfa96c1 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, util, encoding, node, error, extensions
+from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions
 
 import re
 import sys
-- 
1.8.2.1.1031.g2ee5873
