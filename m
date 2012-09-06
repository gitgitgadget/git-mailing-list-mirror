From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/4] merge: document prepare-commit-msg hook usage
Date: Thu,  6 Sep 2012 16:25:55 +0200
Message-ID: <f64d15fe61f1e9d755a7afbe015d1b0dbf5f706d.1346939542.git.git@drmicha.warpmail.net>
References: <50487F8A.4050803@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 16:26:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9d24-0001zj-R5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 16:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab2IFO0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 10:26:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55385 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645Ab2IFO0B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 10:26:01 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8BDB520B8C;
	Thu,  6 Sep 2012 10:26:01 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 06 Sep 2012 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=uk
	wfwniCup2VUlIo9dL1vackn/Y=; b=n0bp0PRUhYOkceP0bKNM8V5b6ic4AOVYGM
	YpJ4YTaNfKOK3VjhekKglUpCb2DcRw1IUSJx+IMHKwbTxC0kAtnRqJ8kv/cC/pYB
	j/E6HQnSBxrkNuQuVLJxzQSdJTrCGRdeMbmecoqWFMeNYXCZtOZrSPtxPloUYOLj
	cSecb1+ZU=
X-Sasl-enc: yrCQ396xt+nmBrl5tqVJA2iGI43BGqsxcN0Czyq5cm0b 1346941561
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 25AFD4825F2;
	Thu,  6 Sep 2012 10:26:01 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.406.gafd3f81
In-Reply-To: <50487F8A.4050803@alum.mit.edu>
In-Reply-To: <cover.1346939542.git.git@drmicha.warpmail.net>
References: <cover.1346939542.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204886>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-merge.txt | 5 +++++
 Documentation/githooks.txt  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 20f9228..b3ba8a8 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -308,6 +308,11 @@ branch.<name>.mergeoptions::
 	supported options are the same as those of 'git merge', but option
 	values containing whitespace characters are currently not supported.
 
+HOOKS
+-----
+This command can run the `prepare-commit-msg` hook.
+See linkgit:githooks[5] for more information.
+
 SEE ALSO
 --------
 linkgit:git-fmt-merge-msg[1], linkgit:git-pull[1],
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index b9003fe..b32134c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -108,6 +108,8 @@ it is not suppressed by the `--no-verify` option.  A non-zero exit
 means a failure of the hook and aborts the commit.  It should not
 be used as replacement for pre-commit hook.
 
+This hook is also called by 'git merge' when it creates a new commit.
+
 The sample `prepare-commit-msg` hook that comes with git comments
 out the `Conflicts:` part of a merge's commit message.
 
-- 
1.7.12.406.gafd3f81
