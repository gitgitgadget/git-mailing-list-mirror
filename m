From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 3/3] user-manual: Flesh out uncommitted changes and
 submodule updates
Date: Tue, 19 Feb 2013 05:05:02 -0500
Message-ID: <9d0838fec9a9e25ddac636845d12c03cf851cb40.1361267945.git.wking@tremily.us>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:05:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7k55-0004nH-LN
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612Ab3BSKFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:05:16 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:50203 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab3BSKFN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:05:13 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00JQ9PCLCB10@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:05:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id A13758ABA11; Tue,
 19 Feb 2013 05:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361268309; bh=Gq3a8nYc7pDdroafOyFuumrKTMdaJ+Exvve1Fm34lao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=ULaoSPsRguzqiT+AOWrIeHBGNcN+uLzs894a1Zh3hSqVzT51sUOTjvrpPQXk7537a
 2V9ikOTHUKxh+RUcql3nsv1pukh8ulB5Ai9ZiXoTxD8x/L38Q9VfbFGD1jcU6Hc9zA
 o3iciFvSr9UjMMKMji5p/mWwFxK6Y3TTqo3qv85E=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361267945.git.wking@tremily.us>
In-reply-to: <cover.1361267945.git.wking@tremily.us>
References: <cover.1361267945.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216592>

From: "W. Trevor King" <wking@tremily.us>

If you try and update a submodule with a dirty working directory, you
get an error message like:

  $ git submodule update
  error: Your local changes to the following files would be overwritten by checkout:
  ...
  Please, commit your changes or stash them before you can switch branches.
  Aborting
  ...

Mention this in the submodule notes.  The previous phrase was short
enough that I originally thought it might have been referring to the
reflog note (obviously, uncommitted changes will not show up in the
reflog either ;).

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 3aab106..df7524a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3739,7 +3739,9 @@ module a
 
 NOTE: The changes are still visible in the submodule's reflog.
 
-This is not the case if you did not commit your changes.
+If you have uncommitted changes in your submodule working tree, `git
+submodule update` will not overwrite them.  Instead, you get the usual
+warning about not being able switch from a dirty branch.
 
 [[low-level-operations]]
 Low-level git operations
-- 
1.8.1.336.g94702dd
