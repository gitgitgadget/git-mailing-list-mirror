From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 1/5] Documentation: alter checkout --orphan description
Date: Fri, 21 May 2010 21:28:35 -0300
Message-ID: <1274488119-6989-2-git-send-email-erick.mattos@gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:29:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcaw-00027A-2N
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634Ab0EVA3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:29:33 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:54023 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab0EVA3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:29:32 -0400
Received: by ywh10 with SMTP id 10so919647ywh.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n0ceVdm6Jy6yJRvghsDvVkgmUwq66KAdExlNALzGFb8=;
        b=qfOzevj2nl1sxkDN1TAotucA3+03QT/Zf7d1g+V6Ll89v1Wl/lA0kEeykITIkCTH/e
         RZRiR2Lwwn/lH7N/lOoCqmiVAYwOU6kb7QJVYOCCYHz8ynzPcljygepwirGUd8U0r8iA
         EJgpzDEfRa+2WvoSEN0oAucMQ+vRweJ8zyvGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HhCh+o3260p+MHMClB/SojjzuomAhSWkyChQYqcfiLjPFhL6jKswP7DTRuY8Lo5o43
         tluFDT/TFCxfusxyR9ZyRSpdGyoZZK8nHBU5tA+wQK7/G6N8EwAll8kxClqVIsQfKy+7
         H956pjqySfqQ5BHYYc4vAfuGC30QY2iNq5U5c=
Received: by 10.150.165.13 with SMTP id n13mr3962206ybe.389.1274488170994;
        Fri, 21 May 2010 17:29:30 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z42sm23557998ybc.6.2010.05.21.17.29.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:29:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
In-Reply-To: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147498>

The present text is a try to enhance description accuracy.  It is a
merge of the rewritten text made by native english speaker Chris Johnsen
and further changes of Junio.  It came from the last thread messages of
--orphan patch.
---
 Documentation/git-checkout.txt |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4505eb6..b84ec26 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -91,22 +91,29 @@ explicitly give a name with '-b' in such a case.
 	details.
 
 --orphan::
-	Create a new branch named <new_branch>, unparented to any other
-	branch.  The new branch you switch to does not have any commit
-	and after the first one it will become the root of a new history
-	completely unconnected from all the other branches.
+	Create a new 'orphan' branch, named <new_branch>, started from
+	<start_point> and switch to it.  The first commit made on this
+	new branch will have no parents and it will be the root of a new
+	history totally disconnected from all the other branches and
+	commits.
 +
-When you use "--orphan", the index and the working tree are kept intact.
-This allows you to start a new history that records set of paths similar
-to that of the start-point commit, which is useful when you want to keep
-different branches for different audiences you are working to like when
-you have an open source and commercial versions of a software, for example.
+The index and the working tree are adjusted as if you had previously run
+"git checkout <start_point>".  This allows you to start a new history
+that records a set of paths similar to <start_point> by easily running
+"git commit -a" to make the root commit.
 +
-If you want to start a disconnected history that records set of paths
-totally different from the original branch, you may want to first clear
-the index and the working tree, by running "git rm -rf ." from the
-top-level of the working tree, before preparing your files (by copying
-from elsewhere, extracting a tarball, etc.) in the working tree.
+This can be useful when you want to publish the tree from a commit
+without exposing its full history. You might want to do this to publish
+an open source branch of a project whose current tree is "clean", but
+whose full history contains proprietary or otherwise encumbered bits of
+code.
++
+If you want to start a disconnected history that records a set of paths
+that is totally different from the one of <start_point>, then you should
+clear the index and the working tree right after creating the orphan
+branch by running "git rm -rf ." from the top level of the working tree.
+Afterwards you will be ready to prepare your new files, repopulating the
+working tree, by copying them from elsewhere, extracting a tarball, etc.
 
 -m::
 --merge::
-- 
1.7.1.231.g0687c.dirty
