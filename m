From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 14/15] user-manual: Flesh out uncommitted changes and
 submodule updates
Date: Sun, 10 Feb 2013 10:10:40 -0500
Message-ID: <99c30216d8f4365e34ed71b7cf3670b0e31bc89e.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZA-0000Sg-D1
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919Ab3BJPLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 10:11:14 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:39172 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab3BJPLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:10 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI0004DJFIE7S00@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2ED5F8792AA; Sun,
 10 Feb 2013 10:11:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509062; bh=LJIj6gfhEs3Ry2wcA3SuNUeO6lrTNQuA3z/OHYKKWuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=EaaN/8RoND2lkzl3/qaT6A1ouoR2fP4pIxFSx8/rUHtXAYrzlQjNunPoz8uUyiYle
 Gy5xSm2/xIdzXzAxS0wn2aOjsBfWoFXIqcpTrvYRVPZvLDla+rPF5DIUysupeob90K
 tPJlFF8EDqOdHxP/NsMP3VqViuxuiQpB8xsXDe5k=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1360508415.git.wking@tremily.us>
In-reply-to: <cover.1360508415.git.wking@tremily.us>
References: <cover.1360508415.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215905>

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
index dbd0143..8024758 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3751,7 +3751,9 @@ module a
 
 NOTE: The changes are still visible in the submodule's reflog.
 
-This is not the case if you did not commit your changes.
+If you did not commit your submodule changes, the changes will *not*
+be silently overwritten.  Instead, you get the usual warning about not
+being able switch from a dirty branch.
 
 [[low-level-operations]]
 Low-level Git operations
-- 
1.8.1.336.g94702dd
