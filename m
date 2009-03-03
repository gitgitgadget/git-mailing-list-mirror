From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 0/2] git submodule: normalize paths before adding
Date: Tue,  3 Mar 2009 16:08:19 +0100
Message-ID: <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net>
References: <49AD3A29.10404@drmicha.warpmail.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWFu-0007Qn-GO
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbZCCPIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbZCCPIc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:08:32 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50923 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711AbZCCPIc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 10:08:32 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 52D3E27DAEC;
	Tue,  3 Mar 2009 10:08:30 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 03 Mar 2009 10:08:30 -0500
X-Sasl-enc: ln35w1dpMHYKHAOIKyy4GE/La17+t+jgi14w9n2QGR3A 1236092909
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B5E1535F71;
	Tue,  3 Mar 2009 10:08:29 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <49AD3A29.10404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112080>

This is a rewrite taking into account the advice given by Junio and J6t.
In particular, the tests are good citizens w.r.t. cd'ing around now, the
sed expressions work at least on AIX 4.3.3, and iterations of .. are
tested for and handled correctly.

Sorry I didn't get around to finishing this earlier. Hope this doesn't
mess up any schedules.

v4 incorporates a fix by J6t regarding a spurious g specifier in the sed expression for "..".

Michael J Gruber (2):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./, .. and //

 git-submodule.sh           |   15 ++++++++++--
 t/t7400-submodule-basic.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)
