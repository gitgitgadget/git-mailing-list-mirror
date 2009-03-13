From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Allow running the test suite against installed git
Date: Fri, 13 Mar 2009 16:45:14 +0100
Message-ID: <1236959116-3334-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 16:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9b9-0002QL-2y
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbZCMPpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755818AbZCMPpb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:45:31 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55681 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755740AbZCMPpb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 11:45:31 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 23F832EF5AE;
	Fri, 13 Mar 2009 11:45:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 11:45:29 -0400
X-Sasl-enc: PNqurRyB/c1vrZ9ybCMEOP9VGZwBtZWtu+qcJIcivV+I 1236959128
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8E227461E4;
	Fri, 13 Mar 2009 11:45:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113198>

Part 1 corrects only an inconsistency which does not matter as long as
you run tests against git compiled in a checkout only: There,
$GIT_EXEC_PATH contains git, in general it does not.

Part 2 allows running the test suite against a git installed anywhere in
the file system. This has at least 2 use cases:
- Test an installed distro package after the installation.
- Run easily current tests against older versions, or vice versa, if you
  have those versions installed somewhere.

Note that one still needs git compiled in git.git for test helpers etc.,
and also because I did not adjust the paths to templates and such. I did
not really feel a need for that.

Also, t0000 there is still one explicit use of "../git" which is fine
because it simply tests for the presence of a built, which we need
anyways.

Michael J Gruber (2):
  test-lib.sh: Test for presence of git-init in the right path.
  test-lib.sh: Allow running the test suite against installed git

 t/test-lib.sh |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)
