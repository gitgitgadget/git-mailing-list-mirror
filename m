From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Refactor status producers and make status -s use color
Date: Sat,  5 Dec 2009 16:04:36 +0100
Message-ID: <cover.1260025135.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 05 16:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGwBo-0005yu-KL
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 16:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721AbZLEPEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 10:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755617AbZLEPEi
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 10:04:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46728 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755531AbZLEPEh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Dec 2009 10:04:37 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ED70CC58B1;
	Sat,  5 Dec 2009 10:04:43 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 05 Dec 2009 10:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=IjiJ/cbDJKF+9KI2NLqmCCYt+kI=; b=OllJdVWhjJOQcf+r5sWZMdd0aJ46JifkZhzxyduE31rIyexVCk+qLi6C7OGFAhvZ1k1jwfxuglMcwp/Z00hMr1+zdskiR90BCmwXn9D74mvl111nMWjZYwRRpidi7rXSIxAjvIRRWiSsKTw0Pp/oDgWqLQ0kv1ATbWrY/TGo1iU=
X-Sasl-enc: G3NO9rHP0+L6BiT4y/QhbWGqthZsgmSz42gMSjcto0cg 1260025483
Received: from localhost (p5DCC0D75.dip0.t-ipconnect.de [93.204.13.117])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3DC4A42C2;
	Sat,  5 Dec 2009 10:04:43 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc1.282.ge6667
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134604>

This is is the refactoring as suggested by Junio, and rebased on top is
the patch which makes status -s obey color.status. I also adjusted the
latter to not color the space separating the (colored) status letters
from the (uncolored) file name.

This mini series is directly on top of 91691ec (Merge branch
'jk/1.7.0-status' into next, 2009-11-27).

Michael J Gruber (2):
  builtin-commit: refactor short-status code into wt-status.c
  status -s: obey color.status

 builtin-commit.c |  105 ++++-------------------------------------------------
 wt-status.c      |   96 +++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |    2 +
 3 files changed, 106 insertions(+), 97 deletions(-)
