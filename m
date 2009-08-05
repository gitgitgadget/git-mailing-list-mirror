From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] git-rev-list.txt: Clarify the use of multiple revision arguments
Date: Wed,  5 Aug 2009 09:58:37 +0200
Message-ID: <1249459117-3853-2-git-send-email-git@drmicha.warpmail.net>
References: <1249459117-3853-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbOo-0002hr-MK
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933672AbZHEH6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933660AbZHEH6z
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:58:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43934 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933578AbZHEH6z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:58:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 0151B3BDCF4;
	Wed,  5 Aug 2009 03:58:55 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 05 Aug 2009 03:58:56 -0400
X-Sasl-enc: nBhmOxEBYMDywtsWUAZHqDslr9Zx/9ps0YZDdIsP4CpE 1249459135
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 03CD72DE0B;
	Wed,  5 Aug 2009 03:58:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
In-Reply-To: <1249459117-3853-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124871>

If one thinks of a revision as the set of commits which can be reached
from the rev, and of ^rev as the complement, then multiple arguments to
git rev-list can be neither understood as the intersection nor the union
of the individual sets.

But set language is the natural as well as logical language in which to
phrase this. So, add a paragraph which explains multiple arguments using
set language.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
While one could explain this also by describing the revision walker,
I think that and/or/union/intersection should be clearer for the average
user.

We may even want to add a paragraph which explains how one gets "A intersected B",
which is impossible to do with rev-list.

 Documentation/git-rev-list.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 847cc7d..40ca276 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -66,6 +66,13 @@ command:
 means "list all the commits which are included in 'foo' or 'bar', but
 not in 'baz'".
 
+So, the resulting set of commits is the union of 'foo' and 'bar',
+intersected with the complement of baz. The order of arguments is
+irrelevant: first, the union of all positive refs (those without
+'{caret}') is taken, then the result is intersected with all negative
+refs (i.e. with the complement of the union of all refs which appear
+with a preceding '{caret}').
+
 A special notation "'<commit1>'..'<commit2>'" can be used as a
 short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
 the following may be used interchangeably:
-- 
1.6.4.70.g9c084
