From: Junio C Hamano <gitster@pobox.com>
Subject: [RFH/PATCH] asciidoc markup fixes
Date: Thu, 07 Aug 2008 16:05:25 -0700
Message-ID: <7v8wv8ifyi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 01:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KREZ0-00064E-Kh
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 01:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbYHGXFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 19:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYHGXFc
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 19:05:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbYHGXFb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 19:05:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 358D04FF50;
	Thu,  7 Aug 2008 19:05:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3B35C4FF4D; Thu,  7 Aug 2008 19:05:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 54A82542-64D5-11DD-A906-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91610>

I see quite a few pages on k.org site, e.g.

    http://www.kernel.org/pub/software/scm/git/docs/git-rerere.html
    (scroll down to find "After this test merge")

are misformatted to lose teletype text '+' that is followed by a comma,
and turns the following paragraph all typeset in teletype.

This patch seems to fix the issue at the site (meaning, with the
particular vintage of asciidoc and docbook toolchain), without breaking
things with the version I have at my primary development machine, but
wider testing is very much appreciated.

After this patch,

    git grep '`+`,' -- Documentation

should report noting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 050c3dd..89c0c3f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 <refspec>...::
 	The canonical format of each <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `+`, followed
+	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 89f321b..64715c1 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -90,15 +90,15 @@ One way to do it is to pull master into the topic branch:
 
 The commits marked with `*` touch the same area in the same
 file; you need to resolve the conflicts when creating the commit
-marked with `+`.  Then you can test the result to make sure your
+marked with `{plus}`.  Then you can test the result to make sure your
 work-in-progress still works with what is in the latest master.
 
 After this test merge, there are two ways to continue your work
 on the topic.  The easiest is to build on top of the test merge
-commit `+`, and when your work in the topic branch is finally
+commit `{plus}`, and when your work in the topic branch is finally
 ready, pull the topic branch into master, and/or ask the
 upstream to pull from you.  By that time, however, the master or
-the upstream might have been advanced since the test merge `+`,
+the upstream might have been advanced since the test merge `{plus}`,
 in which case the final commit graph would look like this:
 
 ------------
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 00a8d21..ebdd948 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -6,7 +6,7 @@
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `+`, followed
+	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
