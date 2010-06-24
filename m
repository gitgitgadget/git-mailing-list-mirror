From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 12:14:49 +0200
Message-ID: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:15:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORjT7-0001Px-VU
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab0FXKPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:15:34 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49510 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753391Ab0FXKPc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 06:15:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1BD871036F9;
	Thu, 24 Jun 2010 06:15:32 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 24 Jun 2010 06:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=iTIYtOVDaqs1jTNWg2HhqVPGiE4=; b=T45iKHlAQJaVB7JmkhsAl6JliUPIa080yNPHcjfQOFhrrcYBBHr3wkSB7jPQsmt2hXgpCrHYw85NCil02ko5NWCnFrYhcVjF5K22zUevg/SFScwLXMSMYj3TjF/xjUXyjB8qdPrHLodBWiOMEL+MO44KJ4DwqxSp1UlaodVe9Sc=
X-Sasl-enc: AK8kpVNg/218WVyX1QMZOSapn+d06lmNW+mI5+Z/RBvC 1277374531
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 693B94E270A;
	Thu, 24 Jun 2010 06:15:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149570>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This formulation is based on my understanding that you can't cat-file
 --textconv something in the index or worktree.

 Documentation/git-cat-file.txt |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 58c8d65..da932ab 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,14 +9,15 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t | -s | -e | -p | <type>) <object>
+'git cat-file' (-t | -s | -e | -p | <type> | --textconv ) <object>
 'git cat-file' (--batch | --batch-check) < <list-of-objects>
 
 DESCRIPTION
 -----------
 In its first form, the command provides the content or the type of an object in
 the repository. The type is required unless '-t' or '-p' is used to find the
-object type, or '-s' is used to find the object size.
+object type, or '-s' is used to find the object size, or '--textconv' is used
+(which implies type "blob").
 
 In the second form, a list of objects (separated by linefeeds) is provided on
 stdin, and the SHA1, type, and size of each object is printed on stdout.
@@ -51,6 +52,11 @@ OPTIONS
 	or to ask for a "blob" with <object> being a tag object that
 	points at it.
 
+--textconv::
+	Show the content as transformed by a textconv filter. In this case,
+	<object> has be of the form <treeish:path>, with treeish defaulting to
+	HEAD.
+
 --batch::
 	Print the SHA1, type, size, and contents of each object provided on
 	stdin. May not be combined with any other options or arguments.
-- 
1.7.1.621.g01d76
