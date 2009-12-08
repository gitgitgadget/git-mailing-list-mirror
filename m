From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Add a few more status tests
Date: Tue,  8 Dec 2009 11:12:00 +0100
Message-ID: <cover.1260266027.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 11:13:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHx3F-0005Gu-3B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 11:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbZLHKMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 05:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbZLHKMA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 05:12:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60567 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753227AbZLHKMA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 05:12:00 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7E174C55CE;
	Tue,  8 Dec 2009 05:12:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 08 Dec 2009 05:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=CRrlB4lJ5nCqd6Itz+JYwPpumWk=; b=DuO2Lab0JMMEOA/BEnW7Hafoq+zNUpikwZPLkdcNI2fn9BsbLq1lueXguL/dEdxnIVd/X/iemPvZBIMMGyZZOasHx65qsCbxV6cbfRlrxzTCzi4wFXgnBvtNWX4QlrJIhVFPItEGBalOHApEZk1wAffKr1D+ieMVosApFzXo5oY=
X-Sasl-enc: 86LTuRXjpPgsvqrNG2Y+yj5T2Die7Agx5GW8hDdJ2Xge 1260267125
Received: from localhost (p5DCC1658.dip0.t-ipconnect.de [93.204.22.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EBC14557E;
	Tue,  8 Dec 2009 05:12:05 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.292.gd8fe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134850>

Here are a few more tests for git status. The first one makes sure that
--porcelain uses paths based on the root, it makes sense on top of
14ed05d (t7508-status.sh: Add tests for status -s, 2009-11-27) or later.

The second one checks long, short and porcelain with color. It makes
sense on top of 3fe2a89 (status -s: obey color.status, 2009-12-05),
although one test will fail without the later 8661768 (status: reduce
duplicated setup code, 2009-12-07) and predecessor.

Remarks:
- There's not a single merge related status test so far.
- There's no test with -z because I don't know what it's suppoded to
  (besides the obvious thing): should it turn off color automatically
  but not relativePaths? Or should it switch to --porcelain -z?

Depending on the answer to the latter I have to do one more fixup to
wt-status.c (and write another test).

Thanks:
to J6t for pointing me to decrypt_color()

Michael J Gruber (2):
  t7508-status: status --porcelain ignores relative paths setting
  t7508-status: test all modes with color

 t/t7508-status.sh |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)
