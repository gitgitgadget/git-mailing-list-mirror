From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] git notes show: handle empty notes gracefully
Date: Fri,  6 Feb 2009 16:19:01 +0100
Message-ID: <1233933543-28407-1-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:21:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSWL-0001nD-BZ
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588AbZBFPTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756416AbZBFPTM
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:19:12 -0500
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:33759 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756283AbZBFPTK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 10:19:10 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A859728A0EB;
	Fri,  6 Feb 2009 10:19:08 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 06 Feb 2009 10:19:08 -0500
X-Sasl-enc: DLkMUU20EZ6BbHN65xvwEJ1g2FfTTBUVD3dfHg8ly19U 1233933548
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 061E129AA4;
	Fri,  6 Feb 2009 10:19:07 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108730>

"git notes show" barfs when there is no note to show. This introduces a
test (yes, a test!) and, in a second round, reacts more gracefully to
empty notes and adjust the expected test output accordingly.

Note that in both cases (before/after the patch) the return code is
non-zero: It's 128 in the ungraceful case, 1 when "dieing gracefully",
uhm...

Michael J Gruber (2):
  git notes show: test empty notes
  handle empty notes gracefully

 git-notes.sh     |    2 ++
 t/t3301-notes.sh |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)
