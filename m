From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] push/pull: adjust missing upstream help text to changed interface
Date: Tue,  6 Nov 2012 11:29:01 +0100
Message-ID: <bd710e422cb8ca0cec4cf52ea3c9ddb284d6c60d.1352197626.git.git@drmicha.warpmail.net>
References: <00F68AED-5D59-44F2-B0F1-E541881BC2CB@uva.nl>
Cc: Jeroen van der Ham <vdham@uva.nl>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 11:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVgPJ-00057t-Kg
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 11:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab2KFK3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 05:29:07 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44848 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193Ab2KFK3F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2012 05:29:05 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C8CEE20BD1;
	Tue,  6 Nov 2012 05:29:03 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 06 Nov 2012 05:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=MJpwuDzMYwOa/nzOTMxskUoZV
	7o=; b=eIjQm8amGa2Hjm9IpIBFeohIpjwlJqjyY457dWT7zmatMLYw1PndD34Kk
	L2puoE1/S1EMjJu1RZFSLfQTDR2NZWB+U3mUMn4Zk+/pgXF1tuD1uUFgaw0UsPfg
	ahoVvJ/Pz8ZlqkHu6iVrzuCitr5lwtqo0yvQRzjTFYcSwcp0VQ=
X-Sasl-enc: VcczGhdOyqMpUiwh68BgSJ2t9tuld7/rfcJ8tI0yKE9R 1352197743
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5C8C34827C0;
	Tue,  6 Nov 2012 05:29:03 -0500 (EST)
X-Mailer: git-send-email 1.8.0.226.gba44ac5
In-Reply-To: <00F68AED-5D59-44F2-B0F1-E541881BC2CB@uva.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209106>

In case of a missing upstream, the git-parse-remote script suggests:

If you wish to set tracking information for this branch you can do so
with:

    git branch --set-upstream nsiv2 origin/<branch>

But --set-upstream is deprectated. Change the suggestion to:

    git branch --set-upstream-to=origin/<branch> nsiv2

Reported-by: Jeroen van der Ham <vdham@uva.nl>
---
Yes, I'm in low hanging fruits mood.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git-parse-remote.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 484b2e6..0e87e09 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -80,7 +80,7 @@ See git-${cmd}(1) for details
 
 If you wish to set tracking information for this branch you can do so with:
 
-    git branch --set-upstream ${branch_name#refs/heads/} $remote/<branch>
+    git branch --set-upstream-to=$remote/<branch> ${branch_name#refs/heads/}
 "
 	fi
 	exit 1
-- 
1.8.0.226.gba44ac5
