From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-rev-parse.txt: Add more examples for caret and colon
Date: Mon, 28 Jun 2010 10:18:09 +0200
Message-ID: <97667b60355ab334a390985cae56a28f7a622eb3.1277712897.git.git@drmicha.warpmail.net>
References: <7vocewff4b.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 10:19:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OT9YU-00018C-9X
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 10:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0F1ITA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 04:19:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47546 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755267Ab0F1IS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 04:18:58 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 37A70109484;
	Mon, 28 Jun 2010 04:18:57 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 28 Jun 2010 04:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=jUBuT5RE2xbkD/HRAuR8S56KMFo=; b=k4YrAczF1QwA0uC5awO6KTMl+vXOMTVO4fqZ54LikgkRITOJMkChl0RFW77eKqTfg3lZifcsrK05MLM+xV+Gx3EZgdqHlJzhqML0imtKBxF/EcSAlrG3mSDPoNl1zTlByElEXGyTPuIAmjNKa5wY80NsLKLc+Afi+tgmhal0Ln0=
X-Sasl-enc: LDamXmZ1Y8yWxBD+f6jGFj9skmYaeGry/cbs6fDFSHWy 1277713133
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 31B9C68FC5;
	Mon, 28 Jun 2010 04:18:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <7vocewff4b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149820>

Several items in the caret, colon and friends section contain examples
already. Make sure they all come with examples, and that examples come
early so that they serve as a visual guide, as well.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is on top of the ":path" patch to git-rev-parse.txt.

I chose not to rewrap the paragraphs so that the diff is clearer,
especially with --color-words.
I don't know what the best patch workflow guideline is here. Maybe
rewrapping a v2?

 Documentation/git-rev-parse.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d525e57..da5cdf4 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -256,7 +256,7 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   the branch the ref is set to build on top of.  Missing ref defaults
   to the current branch.
 
-* A suffix '{caret}' to a revision parameter means the first parent of
+* A suffix '{caret}' to a revision parameter (e.g. "HEAD^") means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
   is equivalent to 'rev{caret}1').  As a special rule,
@@ -282,23 +282,24 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   and dereference the tag recursively until a non-tag object is
   found.
 
-* A colon, followed by a slash, followed by a text: this names
+* A colon, followed by a slash, followed by a text (e.g. ":/fix nasty bug"): this names
   a commit whose commit message starts with the specified text.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
 
-* A suffix ':' followed by a path; this names the blob or tree
+* A suffix ':' followed by a path (e.g. "HEAD:README"); this names the blob or tree
   at the given path in the tree-ish object named by the part
-  before the colon. ":path" (with an empty part before the colon)
+  before the colon.
+  ":path" (with an empty part before the colon, e.g. ":README")
   is a special case of the syntax described next: content
   recorded in the index at the given path.
 
 * A colon, optionally followed by a stage number (0 to 3) and a
-  colon, followed by a path; this names a blob object in the
-  index at the given path.  Missing stage number (and the colon
-  that follows it) names a stage 0 entry. During a merge, stage
+  colon, followed by a path (e.g. ":0:README"); this names a blob object in the
+  index at the given path. Missing stage number (and the colon
+  that follows it, e.g. ":README") names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
-- 
1.7.1.621.g01d76
