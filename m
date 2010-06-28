From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-rev-parse.txt: Add more examples for caret and colon
Date: Mon, 28 Jun 2010 21:01:07 +0200
Message-ID: <d67020fd6ee18ac22cedaf482faf2b98e1cce1a9.1277750432.git.git@drmicha.warpmail.net>
References: <4C28790C.2050301@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 21:01:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJZy-0001KV-TB
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 21:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab0F1TBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 15:01:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55450 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808Ab0F1TBI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 15:01:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C9D6F10912D;
	Mon, 28 Jun 2010 15:01:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 28 Jun 2010 15:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=y++xsiJknaqe5keIDaN5JfWnPZI=; b=NdT2sooD054lXFpJuAYUiEjO3KcYIgNnSZOweqGqbVf4pYEH4MVfUKgjUCZhvG2f2D2iDiqyKzyAZQ9QUXba0966OJwpTL0XLHWb1tUmyagN9WLEmn8benhikayndV9wk+v8nzh3E+Nto3kVkMg0y34IidxpInteCmUztr5aoZI=
X-Sasl-enc: BucARVzboz0yQahpYA6rq/eh7zHbP/FmfLYFGre7O+zj 1277751656
Received: from localhost (p54859FEF.dip0.t-ipconnect.de [84.133.159.239])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9BC8A4EDF11;
	Mon, 28 Jun 2010 15:00:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <4C28790C.2050301@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149851>

Several items in the caret, colon and friends section contain examples
already. Make sure they all come with examples, and that examples come
early so that they serve as a visual guide, as well.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is on top of the ":path" patch to git-rev-parse.txt.

I chose not to rewrap the paragraphs so that the diff is clearer,
especially with --color-words.

v3 now has the quoting style consistent at least locally (and the caret
spelled out), although the existing text changes style midway.

This is about as far as I will go with a "minimal change" patch trying
to alleviate the :something confusion. I really think the whole part
needs an overhaul not only to make it consistent, so bikeshedding before
that is pointless ;)

 Documentation/git-rev-parse.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index d525e57..833a2a2 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -256,7 +256,7 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   the branch the ref is set to build on top of.  Missing ref defaults
   to the current branch.
 
-* A suffix '{caret}' to a revision parameter means the first parent of
+* A suffix '{caret}' to a revision parameter (e.g. 'HEAD{caret}') means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   'rev{caret}'
   is equivalent to 'rev{caret}1').  As a special rule,
@@ -282,23 +282,24 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
   and dereference the tag recursively until a non-tag object is
   found.
 
-* A colon, followed by a slash, followed by a text: this names
+* A colon, followed by a slash, followed by a text (e.g. `:/fix nasty bug`): this names
   a commit whose commit message starts with the specified text.
   This name returns the youngest matching commit which is
   reachable from any ref.  If the commit message starts with a
   '!', you have to repeat that;  the special sequence ':/!',
   followed by something else than '!' is reserved for now.
 
-* A suffix ':' followed by a path; this names the blob or tree
+* A suffix ':' followed by a path (e.g. `HEAD:README`); this names the blob or tree
   at the given path in the tree-ish object named by the part
-  before the colon. ":path" (with an empty part before the colon)
+  before the colon.
+  ':path' (with an empty part before the colon, e.g. `:README`)
   is a special case of the syntax described next: content
   recorded in the index at the given path.
 
 * A colon, optionally followed by a stage number (0 to 3) and a
-  colon, followed by a path; this names a blob object in the
-  index at the given path.  Missing stage number (and the colon
-  that follows it) names a stage 0 entry. During a merge, stage
+  colon, followed by a path (e.g. `:0:README`); this names a blob object in the
+  index at the given path. Missing stage number (and the colon
+  that follows it, e.g. `:README`) names a stage 0 entry. During a merge, stage
   1 is the common ancestor, stage 2 is the target branch's version
   (typically the current branch), and stage 3 is the version from
   the branch being merged.
-- 
1.7.1.621.g01d76
