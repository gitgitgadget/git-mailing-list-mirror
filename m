From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 01/21] remote-hg: trivial cleanups
Date: Thu, 11 Apr 2013 07:22:57 -0500
Message-ID: <1365682997-11329-2-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:24:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGYL-0006qb-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933891Ab3DKMY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:24:26 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:39370 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935175Ab3DKMYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:24:25 -0400
Received: by mail-qe0-f51.google.com with SMTP id 1so836656qec.38
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6tPz97o/O1ckA84tlbChCYMcl1/zBTedP4kMJsVFgBY=;
        b=QTsIkVq38VnLQkROsJY44HQswWTVDFo+QZJNTLW6s8OAki+CHPPCgHC7uDcTifvXDl
         bkI5b7RGxgSOVMEVHQC4WBS1xONWOuZs9p0a0W+xoZbpE5NIRR07rouxgbr1PhxLBWkd
         56SQbkaPS3JpeuY5mMQdEwosQuFfmlm8WvBs/+FYI/dM6aWcA2XdIhah+dTUuKrckrGD
         CjRDj2EV1hklP1u+qThSghbtBYiVrUQokfhtFIJvlXg3+tGlm99QzydurmUuSahH+Wod
         jPs0s4Y4YlSUKrnfw6yT7mPZG86xqCMbJHUNdeOgEsn5mIX3YhYhN5MQ74nKdmClbO6s
         21UA==
X-Received: by 10.229.119.10 with SMTP id x10mr2352065qcq.133.1365683064901;
        Thu, 11 Apr 2013 05:24:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id g6sm6985493qav.6.2013.04.11.05.24.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:24:24 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220854>

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
1.8.2.1
