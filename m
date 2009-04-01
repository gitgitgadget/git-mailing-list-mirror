From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] Make local branches behave like remote branches when --tracked
Date: Wed,  1 Apr 2009 23:42:47 +0200
Message-ID: <1238622169-5238-1-git-send-email-git@drmicha.warpmail.net>
References: <49CD0440.6010304@drmicha.warpmail.net>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 23:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp8El-0000Pm-8b
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 23:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934681AbZDAVnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 17:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934766AbZDAVnD
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 17:43:03 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33936 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756967AbZDAVnB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 17:43:01 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 6F0EC30DDA4;
	Wed,  1 Apr 2009 17:42:58 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 01 Apr 2009 17:42:58 -0400
X-Sasl-enc: 7idxzu+iRd10nd90NR/pA1VkmngdArKkkD7fSrXbidBZ 1238622177
Received: from localhost (p4FC63601.dip0.t-ipconnect.de [79.198.54.1])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ACD1D45E18;
	Wed,  1 Apr 2009 17:42:57 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.507.g0e68d
In-Reply-To: <49CD0440.6010304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115419>


This mini series makes local branches behave the same as remote ones
when they are used as --tracked branches. This means differences are
reported by git status and git checkout, and also that the soon to be
released tracking branch short cut (aka BEL) will work.

v2 adds a more detailed commit message to 2/2 and fixes up formatting.
Also, the simplification of remote refs is now unchanged, and local refs
are simplified in the same way. This may lead to ambiguous refs just
like before this series. Unique simplification (which several places may
benefit from) is left for a future series.

Michael J Gruber (2):
  Test for local branches being followed with --track
  Make local branches behave like remote branches when --tracked

 remote.c                 |    7 +++++--
 t/t6040-tracking-info.sh |   10 +++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)
