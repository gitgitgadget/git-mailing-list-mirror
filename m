From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] Documentation/push: clarify matching refspec behavior
Date: Tue, 19 Feb 2008 11:25:22 -0500
Message-ID: <20080219162522.GB30451@sigill.intra.peff.net>
References: <d9b18b1827a183e5b3b785a092605eab1ff4b6e7.1203438181.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jason Garber <jgarber@ionzoft.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVIF-0000GS-3N
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbYBSQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbYBSQZY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:25:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4254 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbYBSQZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:25:24 -0500
Received: (qmail 22585 invoked by uid 111); 19 Feb 2008 16:25:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 11:25:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 11:25:22 -0500
Content-Disposition: inline
In-Reply-To: <d9b18b1827a183e5b3b785a092605eab1ff4b6e7.1203438181.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74426>

The previous text was correct, but it was easy to miss the
fact that we are talking about "matching" refs. That is, the
text can be parsed as "we push the union of the sets
of remote and local heads" and not "we push the intersection
of the sets of remote and local heads". (The former actually
doesn't make sense if you think about it, since we don't
even _have_ some of those heads). A careful reading would
reveal the correct meaning, but it makes sense to be as
explicit as possible in documentation.

We also explicitly use and introduce the term "matching";
this is a term discussed on the list, and it seems useful
to for users to be able to refer to this behavior by name.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-push.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 5f24944..650ee91 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -47,9 +47,9 @@ even if it does not result in a fast forward update.
 +
 Note: If no explicit refspec is found, (that is neither
 on the command line nor in any Push line of the
-corresponding remotes file---see below), then all the
-heads that exist both on the local side and on the remote
-side are updated.
+corresponding remotes file---see below), then "matching" heads are
+pushed: for every head that exists on the local side, the remote side is
+updated if a head of the same name already exists on the remote side.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
 +
-- 
1.5.4.1.143.ge7e51-dirty
