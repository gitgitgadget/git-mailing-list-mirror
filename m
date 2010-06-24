From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 14:56:55 +0200
Message-ID: <735c21d857407c7f0cb18da13d556d3a77a358db.1277383590.git.git@drmicha.warpmail.net>
References: <4C2355EF.7030604@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 14:57:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORm00-0002uM-JE
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 14:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab0FXM5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 08:57:38 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34747 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755309Ab0FXM5h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 08:57:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 68067108D17;
	Thu, 24 Jun 2010 08:57:37 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 24 Jun 2010 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=4gYa7SLPP2gehwilNAN0AnJzYHE=; b=tHU5NRyVyC4+W2n9uqgvsT52VDaYqt9A+lO6jNPckXW0FSeTlxRLba3tdSYdOD+su/La0wmXYBf66i2gxXvd7i++sE22SfLItaIoLzDeA0dIq2vAkLjSXCgp+7PhiABNmwtUjWyvnUGdLwNH3eu3U/cekzTvPvjBOAM1ln6Vg94=
X-Sasl-enc: ci5FIBH5eqSeO7Ia5D3vaOjGTjZswnLQL340h+Zbx/h9 1277384256
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9F5E259BED;
	Thu, 24 Jun 2010 08:57:36 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <4C2355EF.7030604@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149589>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2 based on clarification by Matthieu Moy.

 Documentation/git-cat-file.txt |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 58c8d65..9ebbe94 100644
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
+	<object> has be of the form <treeish>:<path>, or :<path> in order
+	to apply the filter to the content recorded in the index at <path>.
+
 --batch::
 	Print the SHA1, type, size, and contents of each object provided on
 	stdin. May not be combined with any other options or arguments.
-- 
1.7.1.621.g01d76
