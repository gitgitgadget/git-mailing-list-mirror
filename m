From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-push.txt: document the behavior of --repo
Date: Tue, 27 Jan 2015 13:35:53 +0100
Message-ID: <d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Prem <prem.muthedath@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 13:36:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG5NQ-0000aZ-TM
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 13:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759049AbbA0MgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 07:36:13 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58290 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759017AbbA0Mf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2015 07:35:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3765420924
	for <git@vger.kernel.org>; Tue, 27 Jan 2015 07:35:55 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 27 Jan 2015 07:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=DqliYtIEGffQPW
	ikrVotR1jYOJE=; b=WSxjagRa+VKAvEhA4WWx+7vps4RbObFiEcLffrBCs6y1Xu
	eYHdVTDODzxXvKtDUiEDbeYeT/C+3FLUVY/8KE6QOtuQM5uHDqSUS9KRVKVrNSfl
	QkRilbXGF3OIWRbluwVBYshf0+JUUOj7PfL4QKs55dbeSG1wISgcLvD/vFaBQ=
X-Sasl-enc: rY9KUW9+rhtzpBTPazMaAY8wBRpsW+gzmnuTDBLMydb/ 1422362154
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 827C7C00017;
	Tue, 27 Jan 2015 07:35:54 -0500 (EST)
X-Mailer: git-send-email 2.3.0.rc1.222.gae238f2
In-Reply-To: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263065>

As per the code, the --repo <repo> option is equivalent to the <repo>
argument to 'git push'. [It exists for historical reasons, back from the time
when options had to come before arguments.]

Say so. [But not that.]

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Thanks for digging up the thread, Junio. I never would have thought that
I had been with the Git community for that long already...

 Documentation/git-push.txt | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ea97576..0ad31c4 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -219,22 +219,8 @@ origin +master` to force a push to the `master` branch). See the
 `<refspec>...` section above for details.
 
 --repo=<repository>::
-	This option is only relevant if no <repository> argument is
-	passed in the invocation. In this case, 'git push' derives the
-	remote name from the current branch: If it tracks a remote
-	branch, then that remote repository is pushed to. Otherwise,
-	the name "origin" is used. For this latter case, this option
-	can be used to override the name "origin". In other words,
-	the difference between these two commands
-+
---------------------------
-git push public         #1
-git push --repo=public  #2
---------------------------
-+
-is that #1 always pushes to "public" whereas #2 pushes to "public"
-only if the current branch does not track a remote branch. This is
-useful if you write an alias or script around 'git push'.
+	This option is equivalent to the <repository> argument; the latter
+	wins if both are specified.
 
 -u::
 --set-upstream::
-- 
2.3.0.rc1.222.gae238f2
