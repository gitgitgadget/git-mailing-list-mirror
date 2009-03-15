From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2] git-push.txt: describe how to default to pushing only
 current branch
Date: Sat, 14 Mar 2009 21:32:01 -0500
Message-ID: <1237084321-14492-1-git-send-email-chris_johnsen@pobox.com>
References: <7vd4cjc3da.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 03:38:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LigEr-0003RT-NH
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 03:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbZCOCcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 22:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752495AbZCOCcV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 22:32:21 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbZCOCcV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 22:32:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 12A0F603F;
	Sat, 14 Mar 2009 22:32:19 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.203.162.168]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 73CB0603E; Sat, 14 Mar 2009 22:32:15 -0400 (EDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <7vd4cjc3da.fsf@gitster.siamese.dyndns.org>
X-Pobox-Relay-ID: 8160AD62-1109-11DE-852C-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113272>

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
---
On 2009 Mar 14, at 14:26, Junio C Hamano wrote:
> The new text looks reasonable.  Sign-off?

Oops, sorry for the omission. Here it is again with the S-o-B (or
insert it by hand if you like).
---
 Documentation/git-push.txt |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 4e7e5a7..fd53c49 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -24,8 +24,8 @@ every time you push into it, by setting up 'hooks' there.  See
 documentation for linkgit:git-receive-pack[1].
 
 
-OPTIONS
--------
+OPTIONS[[OPTIONS]]
+------------------
 <repository>::
 	The "remote" repository that is destination of a push
 	operation.  This parameter can be either a URL
@@ -187,6 +187,28 @@ reason::
 Examples
 --------
 
+git push::
+	Works like `git push <remote>`, where <remote> is the
+	current branch's remote (or `origin`, if no remote is
+	configured for the current branch).
+
+git push origin::
+	Without additional configuration, works like
+	`git push origin :`.
++
+The default behavior of this command when no <refspec> is given can be
+configured by setting the `push` option of the remote.
++
+For example, to default to pushing only the current branch to `origin`
+use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
+the ones in the examples below) can be configured as the default for
+`git push origin`.
+
+git push origin :::
+	Push "matching" branches to `origin`. See
+	<refspec> in the <<OPTIONS,OPTIONS>> section above for a
+	description of "matching" branches.
+
 git push origin master::
 	Find a ref that matches `master` in the source repository
 	(most likely, it would find `refs/heads/master`), and update
-- 
1.6.2
