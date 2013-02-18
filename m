From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 8/9] user-manual: Flesh out uncommitted changes and
 submodule updates
Date: Sun, 17 Feb 2013 19:16:00 -0500
Message-ID: <6219cb47a0a5b7428ae6c729e9a1a55344f47428.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQA-0000ml-OT
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757424Ab3BRAQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:49 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:60301 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756872Ab3BRAQq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:46 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00K053EWBE20@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:42 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 69E1E885672; Sun,
 17 Feb 2013 19:16:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146568; bh=THEUrQ2tmQJ7ehFP0MqOU6wq+QDtQRs6CRBErEFnwdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=lX2BYmdlE8hUVfmY36pYUceul6oc21TpaBWBtWTGKbtrm/NUdwwvJSzXyOlsbUY+F
 hncG/pRyqauTIF6kf/IPviSGCg+qiBxZJ13PWRcrIgxOmxQcN+PvxIovdoZB3H77+b
 cjWQWUkmpUUPps7wdulU/rQY162yGWDdpXtXtmQs=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216417>

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
index cf09ddf..3381c22 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3729,7 +3729,9 @@ module a
 
 NOTE: The changes are still visible in the submodule's reflog.
 
-This is not the case if you did not commit your changes.
+If you did not commit your submodule changes, the changes will *not*
+be silently overwritten.  Instead, you get the usual warning about not
+being able switch from a dirty branch.
 
 [[low-level-operations]]
 Low-level Git operations
-- 
1.8.1.336.g94702dd
