From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/3] git-bundle.txt: Cleanup
Date: Mon, 23 Aug 2010 11:02:37 +0200
Message-ID: <4cc5ea19fda713050f3f247d32df44fcfcea3296.1282553586.git.git@drmicha.warpmail.net>
References: <cover.1282553585.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 11:02:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSvZ-0001ZX-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab0HWJCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:02:47 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53391 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753596Ab0HWJCp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 05:02:45 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CE44E461;
	Mon, 23 Aug 2010 05:02:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 23 Aug 2010 05:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=VBnwCyHiE5op/nbFjF5qw/8Er/Q=; b=AVF+eSM9oq7aoFdnJWZeE32uzbOpKn+N+UA9ahyCap79p+kW2RhvjSb5lOafFQnbux2rPj3u4mVe/5anXkUp2mZh/h2fEtR+8xkR2/5uUlrH/WsJqMbbC25Uj1CqIenmZmcBTLRlwZ0lMrcRLcaa6026HhJkxrESvQdazjnRGb4=
X-Sasl-enc: ogvBffX7A2tjt4/ElYUL9T6s1snJnEhC6wsV0SiQWmPI 1282554164
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0EDF140A195;
	Mon, 23 Aug 2010 05:02:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
In-Reply-To: <cover.1282553585.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154211>

Cleanup various spellings of the same argument, as well as the code
for the tilde: Since neither '~' nor '\~' work consistently, use
'{tilde}'.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-bundle.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index a5ed8fb..2d92696 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,7 +9,7 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git bundle' create <file> <git-rev-list args>
+'git bundle' create <file> <git-rev-list-args>
 'git bundle' verify <file>
 'git bundle' list-heads <file> [refname...]
 'git bundle' unbundle <file> [refname...]
@@ -35,7 +35,7 @@ OPTIONS
 
 create <file>::
        Used to create a bundle named 'file'.  This requires the
-       'git rev-list' arguments to define the bundle contents.
+       'git-rev-list-args' arguments to define the bundle contents.
 
 verify <file>::
        Used to check that a bundle file is valid and will apply
@@ -57,10 +57,10 @@ unbundle <file>::
        references matching those in the list are printed. This command is
        really plumbing, intended to be called only by 'git fetch'.
 
-[git-rev-list-args...]::
+<git-rev-list-args>::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and references
-       to transport.  For example, `master\~10..master` causes the
+       to transport.  For example, `master{tilde}10..master` causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -79,12 +79,12 @@ SPECIFYING REFERENCES
 
 'git bundle' will only package references that are shown by
 'git show-ref': this includes heads, tags, and remote heads.  References
-such as `master\~1` cannot be packaged, but are perfectly suitable for
+such as `master{tilde}1` cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master\~10`), or implicitly (e.g.
-`master\~10..master`, `--since=10.days.ago master`).
+specified explicitly (e.g. `^master{tilde}10`), or implicitly (e.g.
+`master{tilde}10..master`, `--since=10.days.ago master`).
 
 It is very important that the basis used be held by the destination.
 It is okay to err on the side of caution, causing the bundle file
@@ -154,7 +154,7 @@ machineB$ git pull
 If you know up to what commit the intended recipient repository should
 have the necessary objects, you can use that knowledge to specify the
 basis, giving a cut-off point to limit the revisions and objects that go
-in the resulting bundle. The previous example used lastR2bundle tag
+in the resulting bundle. The previous example used the lastR2bundle tag
 for this purpose, but you can use any other options that you would give to
 the linkgit:git-log[1] command. Here are more examples:
 
@@ -194,7 +194,7 @@ references when fetching:
 $ git fetch mybundle master:localRef
 ----------------
 
-You can also see what references it offers.
+You can also see what references it offers:
 
 ----------------
 $ git ls-remote mybundle
-- 
1.7.2.1.52.g7f7860
