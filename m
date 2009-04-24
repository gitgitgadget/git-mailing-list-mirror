From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Document --no-signoff option of git commit
Date: Fri, 24 Apr 2009 10:31:00 +0200
Message-ID: <1240561860-4762-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 10:33:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxGqa-00042I-8n
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 10:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbZDXIbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 04:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbZDXIbL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 04:31:11 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52986 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962AbZDXIbJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 04:31:09 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 549A0321888;
	Fri, 24 Apr 2009 04:31:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 24 Apr 2009 04:31:08 -0400
X-Sasl-enc: D1Z+xsw77D01mWXFoXjxXV7xncDNn3wnfz3cbtYgIXBB 1240561867
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B362A39076;
	Fri, 24 Apr 2009 04:31:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc1.51.gea0b7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117421>

--no-signoff can be used to override --signoff and -s. This is useful
for overriding options set in git aliases.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Patch is against 09cff06 (Documentation: Clarify '--signoff' for git-commit, 2008-10-19).

It is "obvious" that one can override boolean options by prepending
"no-" for all commands which use the appropriate option parser. But I
don't think it's obvious to most users.

On the other hand, having an alias like ci="commit -s" is useful and
appropriate depending on a project's policy and a user's discipline. But
still one may want to do a few commits without s-o-b. E.g., merge
commits (without conflicts) don't get s-o-b lines, but amending them
would add a s-o-b line with teh above alias.

Maybe there is a better place to discuss general option parsing? But
it's not the same for all commands yet, I think.

Michael

 Documentation/git-commit.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index b5d81be..ef20ba6 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -96,7 +96,7 @@ OPTIONS
 -s::
 --signoff::
 	Add Signed-off-by line by the committer at the end of the commit
-	log message.
+	log message. This can be overriden with `--no-signoff`.
 
 -n::
 --no-verify::
-- 
1.6.3.rc1.51.gea0b7
