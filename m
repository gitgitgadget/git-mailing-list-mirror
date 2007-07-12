From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] Document GIT_MERGE_VERBOSITY environmental variable
Date: Fri, 13 Jul 2007 01:54:06 +0200
Message-ID: <11842844481113-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 01:54:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I98UR-0006r5-3Z
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 01:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757900AbXGLXyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 19:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758132AbXGLXyT
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 19:54:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:60275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441AbXGLXyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 19:54:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so457429ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 16:54:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=mq5i0SRFfkBY7V/VuXkZG7Llz0Ok0hEm4/zg0SZYbiTis2PMqdnZaCkwi8nfegecb3K7nkUnWTDm55Cjy72f7YJW+SWhcsIaf7baOeVe0sk2zX41tPhCLOstEfU7/sIEVi8YXef0aOmbQIr8RRC/6H25dm0MK97B0gZ56p9IvVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=swkl7kJUbqHHMp6XJ83j4jxqI5B6cOg/2M2yLXeBGihIcdvN5mBsUfP2kOhLiMwtOE9s7/mumnux0+fdA+RvJJc/3kGJBw1eUuFU4BaqBZ5+aLVi4CPyRko3wf7XnhHeZIIKm6BAlhlCw7W5JHxF04xXfNwWDmoZCegmx3ZlRr0=
Received: by 10.67.19.11 with SMTP id w11mr1552273ugi.1184284454919;
        Thu, 12 Jul 2007 16:54:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.8.65])
        by mx.google.com with ESMTP id y34sm51331389iky.2007.07.12.16.54.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 16:54:12 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l6CNsBYJ002389;
	Fri, 13 Jul 2007 01:54:12 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l6CNs9H1002388;
	Fri, 13 Jul 2007 01:54:09 +0200
X-Mailer: git-send-email 1.5.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52345>

While at it, add "Configuration" section mentioning merge.summary
configuration variable (which is mentioned in git-fmt-merge-msg(1)
man page, but it is a plumbing command), and merge.verbosity
configuration variable (so there is a place to make reference
from "Environment Variables" section of git(7) man page) to the
git-merge(1) man page.

The configuration variable merge.verbosity and environmental variable
GIT_MERGE_VERBOSITY were introduced in commit 8c3275ab, which also
documented configuration variable but not environmental variable.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The alternative to adding "Configuration" section to git-merge(1)
man page, and referring to it in the description of GIT_MERGE_VERBOSITY
environmental variable in git(7), would be to either refer to
git-config(1), or add full description similar to description of
merge.verbosity to git(7).

Perhaps above paragraph should be added to commit message?

I have put shortened sha1 of commit which introduced setting of
a merge verbosity to be able to go to it from graphical UI
like for example gitweb.

 Documentation/config.txt    |    1 +
 Documentation/git-merge.txt |   15 +++++++++++++++
 Documentation/git.txt       |    5 +++++
 3 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b67f0a..6cd0ff0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -567,6 +567,7 @@ merge.verbosity::
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
 	above outputs debugging information.  The default is level 2.
+	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
 
 merge.<driver>.name::
 	Defines a human readable name for a custom low-level
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index d285cba..1442e06 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -43,6 +43,21 @@ If you tried a merge which resulted in a complex conflicts and
 would want to start over, you can recover with
 gitlink:git-reset[1].
 
+CONFIGURATION
+-------------
+
+merge.summary::
+        Whether to include summaries of merged commits in newly
+        merge commit messages. False by default.
+
+merge.verbosity::
+	Controls the amount of output shown by the recursive merge
+	strategy.  Level 0 outputs nothing except a final error
+	message if conflicts were detected. Level 1 outputs only
+	conflicts, 2 outputs conflicts and file changes.  Level 5 and
+	above outputs debugging information.  The default is level 2.
+	Can be overriden by 'GIT_MERGE_VERBOSITY' environment variable.
+
 
 HOW MERGE WORKS
 ---------------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 10c7bb3..895c25c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -410,6 +410,11 @@ parameter, <path>.
 
 other
 ~~~~~
+'GIT_MERGE_VERBOSITY'::
+	A number controlling the amount of output shown by
+	the recursive merge strategy.  Overrides merge.verbosity.
+	See gitlink:git-merge[1]
+
 'GIT_PAGER'::
 	This environment variable overrides `$PAGER`.
 
-- 
1.5.2.2
