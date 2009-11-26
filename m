From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/2] status -s: Use the same config as status
Date: Thu, 26 Nov 2009 16:24:37 +0100
Message-ID: <cover.1259248243.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 16:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgEE-0007mW-Sc
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbZKZPZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbZKZPZn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:25:43 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53851 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752788AbZKZPZn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 10:25:43 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 28063C230F;
	Thu, 26 Nov 2009 10:25:49 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 26 Nov 2009 10:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=XaLx8CjYFlXeeV21G0YGoLQd1fA=; b=b7ad++92A4auwiZqxU+kq2DC0gpBvrt6sB9uEZznWGlStHhWVIhiPVxri3iL2YZX8lzNc+lHelfGxsCu3HDZPv7BWumh68J8ovof86SHUi6r/kJcf8pRfuOj6p+34ewitji6TKwxNHV87ESQ2zmXS8uKgDZ7C+hmIVkbFGjtwKo=
X-Sasl-enc: UUYca5PqJcd9NSYnaHUZkdak4nvllg/Wzmt05IYaG+1f 1259249148
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 933422E730;
	Thu, 26 Nov 2009 10:25:48 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc0.274.g71380
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133799>

This mini series is an RFC for bringing the short version of status in line
with the longer one. They already both obey status.showUntrackedFiles.
Currently, status -s does not obey status.relativePaths nor
color.status.

I think status should follow the priniciple of least surprise here in
the sense that -s should not change other aspects of the output
(although it is very different internally).

I think we don't have any tests for status -s yet, which is one reason
why this is an RFC: I don't expect to get through with it, like the
introducer of status -s did ;) Another reason is mentioned in 2/2.

Michael J Gruber (2):
  status -s: respect the status.relativePaths option
  status -s: obey color.status

 builtin-commit.c |   22 +++++++++++++++++-----
 wt-status.c      |    2 +-
 wt-status.h      |    1 +
 3 files changed, 19 insertions(+), 6 deletions(-)
