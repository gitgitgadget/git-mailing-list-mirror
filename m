From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 01/20] remote-hg: trivial cleanups
Date: Mon,  8 Apr 2013 12:13:15 -0500
Message-ID: <1365441214-21096-2-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFgm-0006jS-Op
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934783Ab3DHRQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:16:52 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:36362 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934482Ab3DHROl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:14:41 -0400
Received: by mail-oa0-f51.google.com with SMTP id g12so6473832oah.10
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Hn44uhgHzpgD3YdYjV2End3Ud1x5VU87F7n0llXkbgg=;
        b=A7yULvgKQEBgMg+5l3XwNnoGRPPovZYnki5F82k2UMPzfIwh4gW6kNFQdhwgtw84kf
         bS52cmPpzL7juAh7LnRfI6R97XOLJ2o26cY5j3G1/A7K4JXjcc9czSy6vxezPttWHx13
         NBpibNLAEXElgb14U8q/ZC90wHmT4XyfBscX/nILjB0msJyIBBR5nsM2hS1rJBlBWuLt
         Gmov7zSdXu+eBkXikea/6fp9WAUJXGgLFhrUqXL4r+ZxJrQEJ0fL/PZt5F2gcEFXn2tL
         +67YXxL47kheoyLbN6f92Chr4VtkKj1OiDwY4mlpPiyOUdDFpOWHPkOUq6twMa06PImp
         Pkmw==
X-Received: by 10.60.26.137 with SMTP id l9mr16187246oeg.17.1365441280849;
        Mon, 08 Apr 2013 10:14:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c4sm24848553obo.9.2013.04.08.10.14.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:14:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220463>

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
