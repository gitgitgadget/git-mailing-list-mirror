From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/13] remote-hg: trivial cleanups
Date: Thu,  4 Apr 2013 09:30:10 -0600
Message-ID: <1365089422-8250-2-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm8y-0003uy-Je
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762560Ab3DDPbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:25 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61881 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762533Ab3DDPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:22 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so2651967obc.24
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Hn44uhgHzpgD3YdYjV2End3Ud1x5VU87F7n0llXkbgg=;
        b=yD2D3BaSOYsgYa/iSd8+MIBGA9bSF0v9mxmDALprvg60zp7ZouiHGD4+XoT585WSDo
         0hY+jF4ji9IYQkxFRI/pAS3WY4gfy+1oULr11vuZl7WaRWruTnVJr2DM6AWmXCWuzfOS
         bNPCrT7dIzvulZD4m4pDQZbOGg9vcrFt5X/7vkBNXYBHyKDClJvCFpeS6Rq5M+pTDOF9
         a2iqnj2wSWe9kCtcsm0HHdUBV3hiaeHomQ5lgu0AKlNv3g1+31UStARYk3Vv8RFATVHV
         a2wH9y+x4tMWoW1e7YMEQrwHMmsSwA8LtCUjmpwELj+goR+aHTfwt6U9Qvg3yj4jvxF5
         HfNA==
X-Received: by 10.182.235.49 with SMTP id uj17mr4591363obc.18.1365089482297;
        Thu, 04 Apr 2013 08:31:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id gs18sm6780572obb.12.2013.04.04.08.31.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220004>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 328c2dc..d0dfb1e 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -531,7 +531,6 @@ def parse_blob(parser):
     data = parser.get_data()
     blob_marks[mark] = data
     parser.next()
-    return
 
 def get_merge_files(repo, p1, p2, files):
     for e in repo[p1].files():
@@ -542,7 +541,7 @@ def get_merge_files(repo, p1, p2, files):
             files[e] = f
 
 def parse_commit(parser):
-    global marks, blob_marks, bmarks, parsed_refs
+    global marks, blob_marks, parsed_refs
     global mode
 
     from_mark = merge_mark = None
@@ -647,10 +646,11 @@ def parse_commit(parser):
     rev = repo[node].rev()
 
     parsed_refs[ref] = node
-
     marks.new_mark(rev, commit_mark)
 
 def parse_reset(parser):
+    global parsed_refs
+
     ref = parser[1]
     parser.next()
     # ugh
@@ -715,11 +715,11 @@ def do_export(parser):
             continue
         print "ok %s" % ref
 
-    print
-
     if peer:
         parser.repo.push(peer, force=False)
 
+    print
+
 def fix_path(alias, repo, orig_url):
     repo_url = util.url(repo.url())
     url = util.url(orig_url)
-- 
1.8.2
