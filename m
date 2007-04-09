From: Florian Weimer <fw@deneb.enyo.de>
Subject: [PATCH] git-tag: Document that -m/-F create tag objects, too
Date: Mon, 9 Apr 2007 14:06:32 +0200
Message-ID: <E1Hash0-0004rN-Mu@mid.deneb.enyo.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 14:17:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hash8-0004d0-8O
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 14:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbXDIMJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 08:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbXDIMJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 08:09:58 -0400
Received: from mail.enyo.de ([212.9.189.167]:2686 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbXDIMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 08:09:57 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Hash1-00051N-Mh
	for git@vger.kernel.org; Mon, 09 Apr 2007 14:09:55 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Hash0-0004rN-Mu
	for git@vger.kernel.org; Mon, 09 Apr 2007 14:09:54 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44052>

And warn about the fact that lightweight tags are not normally
transferred by clone/fetch.

Signed-off-by: Florian Weimer <fw@deneb.enyo.de>
---
 Documentation/git-tag.txt |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 70235e8..fc5f4e3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -20,13 +20,15 @@ Adds a 'tag' reference in `.git/refs/tags/`
 Unless `-f` is given, the tag must not yet exist in
 `.git/refs/tags/` directory.
 
-If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
-creates a 'tag' object, and requires the tag message.  Unless
-`-m <msg>` is given, an editor is started for the user to type
-in the tag message.
-
-Otherwise just the SHA1 object name of the commit object is
-written (i.e. a lightweight tag).
+If one of `-a`, `-m <msg>`, `-F <file>`, `-s`, or `-u <key-id>` is
+passed, the command creates a 'tag' object.  Unless `-m <msg>` or `-F
+<file>` is given, an editor is started for the user to type in the tag
+message.
+
+Otherwise just the SHA1 object name of the commit object is written
+(i.e. a lightweight tag).  Note that such tags are not automatically
+copied by "git-clone" and "git-fetch", so you want to use them for
+local tags only.
 
 A GnuPG signed tag object will be created when `-s` or `-u
 <key-id>` is used.  When `-u <key-id>` is not used, the
-- 
1.5.1
