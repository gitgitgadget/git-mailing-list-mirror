From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 2/2] Documentation/git-checkout.txt: document 70c9ac2 behavior
Date: Mon, 17 Dec 2012 00:45:02 -0600
Message-ID: <1355726702-27974-3-git-send-email-chris@rorvick.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 07:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkUTP-0003Kl-5E
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 07:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab2LQGqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 01:46:31 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40010 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2LQGqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 01:46:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so8745216ieb.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 22:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=x2DfLgerWKMG3BHx9epmGdOBNyaDkC+6t/T/f8JqLzM=;
        b=O9PJLGMvEYhIByxlHfWg+YQ7txGj5BFtPsYmAtQDcEvgr7kro6cmt4kocQn4UcfaSG
         c7nDHSyip6APklUiNm9nBVemem2lCfjVi5x9yW43zsIIJUswxKjTbU0F9gFlFbeQKQzc
         eiN3CLrJsU9njQDK12Ans55Oincd3lNpQC56vzcoS56u4YQskTLHSjZ/5zFGtJd1p2ct
         +JJURZqyOpsIwv0d3yglK+unl8QvdNXLmhpvPg5o5pAsFyD+TE2P51TIjmaweCk6ieo0
         xi+qAVJWBLO685WgxiYCZBlrdlpkLAWAxrSqWHk+dkg8mzkIfF5HkNnByQlhLI+xqRaz
         egrg==
Received: by 10.50.194.131 with SMTP id hw3mr8016897igc.71.1355726790158;
        Sun, 16 Dec 2012 22:46:30 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id aa6sm5087935igc.14.2012.12.16.22.46.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 22:46:29 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.203.g1ddc124
In-Reply-To: <1355726702-27974-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211637>

Document the behavior implemented in 70c9ac2 (DWIM "git checkout
frotz" to "git checkout -b frotz origin/frotz").

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-checkout.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index a47555c..db89cf7 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -25,6 +25,14 @@ branch.
 
 	Update the index, working tree, and HEAD to reflect the
 	specified branch.
++
+If <branch> is not found but there does exist a tracking branch in
+exactly one remote (call it <remote>) with a matching name, treat as
+equivalent to
++
+------------
+$ git checkout -b <branch> --track <remote>/<branch>
+------------
 
 'git checkout' -b|-B <new_branch> [<start point>]::
 
-- 
1.8.1.rc1.203.g1ddc124
