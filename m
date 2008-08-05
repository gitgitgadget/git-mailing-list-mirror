From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/6] Remove the "jgit is slow" remark from README
Date: Mon,  4 Aug 2008 19:47:15 -0700
Message-ID: <1217904436-1989-6-git-send-email-spearce@spearce.org>
References: <1217904436-1989-1-git-send-email-spearce@spearce.org>
 <1217904436-1989-2-git-send-email-spearce@spearce.org>
 <1217904436-1989-3-git-send-email-spearce@spearce.org>
 <1217904436-1989-4-git-send-email-spearce@spearce.org>
 <1217904436-1989-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQCbU-0006tq-QL
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 04:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757512AbYHECr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 22:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbYHECr1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 22:47:27 -0400
Received: from george.spearce.org ([209.20.77.23]:45384 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471AbYHECrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 22:47:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A024D3844E; Tue,  5 Aug 2008 02:47:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B2BF238368;
	Tue,  5 Aug 2008 02:47:19 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc1.250.g9b5e2
In-Reply-To: <1217904436-1989-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91414>

Historically this may have been true, back when we built things
on the lib.Commit and lib.Tree API.  Those APIs are quickly being
rebuilt around RevWalk and TreeWalk, which are much more powerful
and significantly faster.

Most testing indicates that once the JIT has had a chance to do
its optimization magic on the jgit library we get performance that
really does rival C git running on the same system.  Since C git
is so ridiculously fast we're probably still beating many of the
other VCS tools available.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 README |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/README b/README
index e18a9eb..334f3d5 100644
--- a/README
+++ b/README
@@ -188,36 +188,6 @@ partial files simple.
 - The Eclipse plugin cannot handle files outside any Eclipse project. You
   need commit changes to such files outside of Eclipse.
 
-- Speed in some areas
-
-  Java is "slooow", they say. Not true as a general statement. A lot of Java
-  code is slow because it it not optimized (to some extent due to this
-  belief). Java has quite good performance although it cannot compete with
-  C code written by good hackers simply because C can be optimized more than
-  Java when you actually do it and have the skills to do it. Some areas of
-  the plugin have been optimized but not all and not conclusively. In general
-  however Java almost always needs more memory than an application written in 
-  e.g. C. In particular there is an overhead from the rather large standard
-  libraries that a normal Java installation comes with. See the ACM report:
-
-	Prechelt, L. 1999. Technical opinion: comparing Java vs. C/C++
-        efficiency differences to interpersonal differences. Commun. ACM 42, 
-        10 (Oct. 1999), 109-112. DOI= http://doi.acm.org/10.1145/317665.317683
-
-  for an interesting comparison of C, C++ and Java. It is somewhat dated so 
-  the comparison involved Java 1.2, i.e. without hotspot that appeared in Java 
-  1.3 and the shared runtime in 1.4. Those features made common Java
-  applications many times faster than with Java 1.2
-
-  The conclusion from having about 30 programmers write a program to the same
-  specification using their own choice of language (from C,C++ and Java) is
-  that the skills of the programmer is what determines the performance of the
-  code rather than choice of programming language.
-
-  JGit is much slower (measured up to eight times for some random cases), but
-  then the real Git is ridicilously fast.
-
-
             == Support                         ==
 
   Post question, comments or patches to the git@vger.kernel.org mailing list.
-- 
1.6.0.rc1.250.g9b5e2
