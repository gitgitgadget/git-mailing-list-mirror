From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] git describe --first-parent
Date: Tue, 11 Sep 2012 15:51:50 +0200
Message-ID: <cover.1347370970.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 15:52:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBQsn-0001KM-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 15:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab2IKNvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 09:51:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41886 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754039Ab2IKNvy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 09:51:54 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3E75121996
	for <git@vger.kernel.org>; Tue, 11 Sep 2012 09:51:54 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 11 Sep 2012 09:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=o5FGMefUQyfQRt57qo736V4INWM=; b=UGe2puEk0Tp2EP+JfEc1
	ha9CPhBsxQ+0Wt14m2IQtms7V5uPTSafQ+722r9B8XMJwb++dUNmEZDOcFfuLyPG
	X3PqgkMSFj2MAJJst/7pW8tJUD3b4s0Z3AfP14XissGvmirYqCZ8T8xPO2qV8MsS
	jGeF+O+sN7LOKByU5etOiI4=
X-Sasl-enc: JD13iP/PIBbEZkGhe0WDe4/55Q1w/kNAJrU4ICDwbnMO 1347371513
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id CEA784837F8;
	Tue, 11 Sep 2012 09:51:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205229>

While "git describe" behaves as documented, the notion of "most recent tag"
is not really easy to grab, and it's not always the way you want to describe
a commit.

"--first-parent" is the option which answers the question: Which is the
most recent tag on this branch which can be reached from this commit?
("This branch" being defined as "--first-parent" walk.)

I had suggested this before, but the discussion veered off quite a bit:
http://permalink.gmane.org/gmane.comp.version-control.git/156811

No need to discuss the way "git describe" behaves again ;)

Michael J Gruber (2):
  git-describe: introduce --first-parent
  describe: document and test --first-parent

 Documentation/git-describe.txt | 16 +++++++++++++++-
 builtin/describe.c             |  8 +++++++-
 t/t6120-describe.sh            |  7 +++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.7.12.463.gbd9d638
