From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 0/2] git notes show: handle empty notes gracefully
Date: Fri,  6 Feb 2009 17:17:53 +0100
Message-ID: <1233937075-31194-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 17:19:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTQR-0000jm-6n
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbZBFQSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZBFQSE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:18:04 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59487 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752183AbZBFQSD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 11:18:03 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4C175287C56;
	Fri,  6 Feb 2009 11:18:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 06 Feb 2009 11:18:01 -0500
X-Sasl-enc: wrLRPU6Lksg+7wwKPUhIyGbDKC0FY7ZyyMdc3m+ZVGn3 1233937080
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 79A5114902;
	Fri,  6 Feb 2009 11:18:00 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108754>

"git notes show" barks when there is no note to show. This introduces a
test (yes, a test!) and, in a second round, reacts more gracefully to
empty notes and adjust the expected test output accordingly.

Note that in both cases (before/after the patch) the return code is
non-zero: It's 128 in the ungraceful case, 1 when "dieing gracefully",
uhm...

The main achivement in v2 is the correction of typos in the commit
messages and comments, as well as the addition of proper s-o-b (son of
a...) lines.

Additionally, v2 incorporates input from the two J's. We test explicitly
for return code 1 now.

Michael J Gruber (2):
  git notes show: test empty notes
  handle empty notes gracefully

 git-notes.sh     |    2 ++
 t/t3301-notes.sh |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)
