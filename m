From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/5] git-diff.txt: banish the <commit>..<commit> form
Date: Wed, 24 Apr 2013 22:33:00 +0530
Message-ID: <1366822980-21926-1-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 19:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV363-000640-ET
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab3DXRDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 13:03:01 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:43618 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab3DXRDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:03:00 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1308940pad.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0Wz021/pOLXrsbWJUsQrVbxUhqugfHJCsQKm1QifQzI=;
        b=RW70MPFjS/vVAxiAM7CSUmsSht+KmIp0nziN1KA1fQMbNmLJV/Jdvyjtm52cDndUqB
         cypRUIBYHxGBOcGwrIEpJN1Cvahd12hlg2TOc2kpK6D0j9iEZ7wOkYpTHvXUkOYTnNEg
         tUS51QOjEkkL05ZhNSNMzoD7mVOomuVfxvxSuzsH5HNpkchOmCgJvFRya0YLNbKWfRCT
         o7XDcefsEqIGbAxDj+8T1K97T5/s1ipVOP018ZMY+XE70x/CXGzfEIs2ZtdHDpFEKCcN
         9USYygPa3LsiGWVC+sqYZG+x0rIYdSYFLrepBKwNSSAiOOz9vFqhB8E6UvDQmPkXLs7V
         xjxw==
X-Received: by 10.66.166.104 with SMTP id zf8mr20749548pab.166.1366822980307;
        Wed, 24 Apr 2013 10:03:00 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id g8sm4377469pae.7.2013.04.24.10.02.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 10:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222272>

The '<commit>..<commit>' and '<commit>...<commit>' forms are confusing
as they are reminiscent of the corresponding forms in the "SPECIFYING
RANGES" section of revisions.txt.  We can remove the
'<commit>..<commit>' form now (hence discouraging its use), since it
is exactly equivalent to the clearer '<commit> <commit>' form.
However, we must keep the '<commit>...<commit>' form around until we
can find a different way to express the same thing.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 1f2f681..118b448 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -14,7 +14,6 @@ SYNOPSIS
 'git diff' [options] --cached [<commit>] [[--] [<path>...]]
 'git diff' [options] <blob> <blob>
 'git diff' [options] <commit> <commit> [[--] [<path>...]]
-'git diff' [options] <commit>..<commit> [[--] [<path>...]]
 'git diff' [options] <commit>\...<commit> [[--] [<path>...]]
 
 DESCRIPTION
@@ -63,12 +62,6 @@ directories. This behavior can be forced by --no-index.
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [options] <commit>..<commit> [[--] [<path>...]]::
-
-	This is synonymous to the previous form.  If <commit> on
-	one side is omitted, it will have the same effect as
-	using HEAD instead.
-
 'git diff' [options] <commit>\...<commit> [[--] [<path>...]]::
 
 	This form is to view the changes on the branch containing
@@ -79,14 +72,12 @@ directories. This behavior can be forced by --no-index.
 
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
-<tree>.
-
-For a more complete list of ways to spell <commit>, see
-"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
-However, "diff" is about comparing two _endpoints_, not ranges,
-and the range notations ("<commit>..<commit>" and
-"<commit>\...<commit>") do not mean a range as defined in the
+in the last "..." form, can be any <tree>.
+
+For a more complete list of ways to spell <commit>, see "SPECIFYING
+REVISIONS" section in linkgit:gitrevisions[7].  However, "diff" is
+about comparing two _endpoints_, not ranges, and the range notation
+"<commit>...<commit>" does not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
 OPTIONS
-- 
1.8.2.1.502.g2d60b5c
