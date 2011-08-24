From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-reset.txt: Be clearer about the symbolic ref nature of HEAD
Date: Wed, 24 Aug 2011 11:56:26 +0200
Message-ID: <f903e0bb1c14cb083c263deb165dc9495ab4c60e.1314179720.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 11:56:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwACJ-000872-PT
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 11:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab1HXJ4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 05:56:31 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:52321 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1HXJ4a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 05:56:30 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9FE4120850
	for <git@vger.kernel.org>; Wed, 24 Aug 2011 05:56:29 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 24 Aug 2011 05:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=Mzym7eEVxmhDcjjxceXv4QiKrfk=; b=C+eStXvJ9pxUfFSoW0QK
	FVcRrkyPipOYnWmDQAvS5ya2eILn4aTtZqxs5D8qIxt1nNQiH11CjVV3AmCV/0l+
	5XP4RoIUDTiHsgKe00wszp0qDUNPJ4eofrUIhaBYSD92wTBLj7kpgMXaQGaQ94pZ
	SE5lrwzsrQ9KJwkBUHdQ8/g=
X-Sasl-enc: iUOZbnkGrw28p8QQvS8JCAWzBpaHUFWs/wVrs/PUOOam 1314179789
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2159C9E07C4;
	Wed, 24 Aug 2011 05:56:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179992>

"git reset" updates the ref which HEAD points to (or HEAD itself, if
detached), due to being a symbolic ref (unless detached). Therefore,
"updating/resetting HEAD" is a possible source of confusion especially when
compared with "git checkout", and the change in
d537c74 (git-reset.txt: make modes description more consistent, 2010-09-15)
did not quite help.

Clean up after d537c74 (myself) and try to be even clearer about which
ref is changed by "git reset". Avoid the term "symbolic ref", because who can
tell *HEAD from HEAD from &HEAD?

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index b2832fc..96c964d 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 In the first and second form, copy entries from <commit> to the index.
-In the third form, set the current branch head (HEAD) to <commit>, optionally
+In the third form, set the current branch head (which HEAD points to) to <commit>, optionally
 modifying index and working tree to match.  The <commit> defaults to HEAD
 in all forms.
 
@@ -44,8 +44,9 @@ you can use it to selectively reset hunks. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `\--patch` mode.
 
 'git reset' [--<mode>] [<commit>]::
-	This form resets the current branch head to <commit> and
-	possibly updates the index (resetting it to the tree of <commit>) and
+	This form resets the current branch head (which HEAD points to) to <commit>;
+	if HEAD points to a commit (aka detached HEAD) then HEAD is reset to <commit>.
+	This form also possibly updates the index (resetting it to the tree of <commit>) and
 	the working tree depending on <mode>, which
 	must be one of the following:
 +
-- 
1.7.6.845.gc3c05
