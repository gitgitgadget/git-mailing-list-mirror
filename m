From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/9] remote-helpers: trivial cleanups
Date: Thu, 25 Apr 2013 19:08:14 -0500
Message-ID: <1366934902-18704-2-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEX-0003aH-Mv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096Ab3DZAJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:09:43 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55355 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab3DZAJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:09:42 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so3092059obb.14
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0VOMwwQqcUXdy7wLbOoce+Ry3CUyym8G66KUobXElVY=;
        b=EK5l95IQWGpWnQvAd38NzBYCyp9AxB1CPW7WbW/2164Ng/9dhguwRQgkoZArw+9SsE
         N+5l+VjoLhUzf1JF60ZXJ+OWM3x0KtxAq8N0m1ebkLz7gsg5yAKjfVMbOXcE8joiMuIl
         vWvPpOOcN4SbhKGOksfGU7dFod2XWcK0Qq+1gbpS47hqDZP3L5mDxVtSWNkSGuwtrdZ0
         LryYdo5vWQ1BIPCL2TuLZiFcT3AC1RwcFjKh1nEC1me/rMILxbX+xD8AAawaTyXHLrDz
         i7KDFlJH8C1wsmoAo1KlbH0uJirJbp2nq+dugXidHRkHOXEbjhS8EoEzB5XcjF7Bnqrh
         /Bfw==
X-Received: by 10.182.113.164 with SMTP id iz4mr7603563obb.87.1366934981363;
        Thu, 25 Apr 2013 17:09:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm5635306obb.14.2013.04.25.17.09.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:09:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222470>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Do I have to say it? If code is removed, it's because it's not used.

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
1.8.2.1.884.g3532a8d
