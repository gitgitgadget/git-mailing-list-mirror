From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/13] remote-hg: trivial cleanups
Date: Tue,  2 Apr 2013 13:02:50 -0600
Message-ID: <1364929382-1399-2-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Va-0006r2-8y
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab3DBTED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:03 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:49877 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3DBTEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:00 -0400
Received: by mail-yh0-f42.google.com with SMTP id b12so113690yha.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Hn44uhgHzpgD3YdYjV2End3Ud1x5VU87F7n0llXkbgg=;
        b=bASpnBeY+Pe7iHqSBpjn4wd/MEyrkNspNwAv18txtZvwNXJHtep714+FKs5ncw/Q8I
         Kns5lanC0WDzS12RIbMJ8rSWaMl5kDbOVuxzhX7nPQX7L8d5k4Y21DcARbuhvOH+Cmf/
         Q1WuKmVyLHT4dMSU9/74HRb76Bxe/+Dj4wgoRzdGA9bfFFmwLLUU4m2kO4AP4xIevNZp
         BdVCxWk2Ro//l/wPMa+jMvqTIRv0ZzTlGYk2Va2dtbVkIKDMh3hbj1o+5RHiZHRyC1xl
         pN19z3K8AzBlLyPlm+gnB/OfNPOX3LKCT59Uzv5Tz0nPvu1Oho+Q8sze3uACNTC5eROv
         Ht2g==
X-Received: by 10.236.81.172 with SMTP id m32mr16456730yhe.198.1364929439589;
        Tue, 02 Apr 2013 12:03:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s16sm4851363yhj.13.2013.04.02.12.03.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:03:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219835>

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
