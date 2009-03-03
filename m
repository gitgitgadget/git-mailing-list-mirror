From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/2] git submodule: normalize paths before adding
Date: Tue,  3 Mar 2009 13:39:47 +0100
Message-ID: <1236083989-20526-1-git-send-email-git@drmicha.warpmail.net>
References: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 13:41:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeTwQ-0006TI-H8
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 13:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbZCCMkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 07:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZCCMkD
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 07:40:03 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35081 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbZCCMkB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 07:40:01 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7CCB92D31D8;
	Tue,  3 Mar 2009 07:39:58 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 03 Mar 2009 07:39:58 -0500
X-Sasl-enc: +4jlScNYMP9NRd6hS/Ub6fG0H6Qh3Mvz/Ly63/Oesr2y 1236083997
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DEB992D9BE;
	Tue,  3 Mar 2009 07:39:57 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2
In-Reply-To: <7vtz6ht9ho.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112066>

This is a rewrite taking into account the advice given by Junio and J6t.
In particular, the tests are good citizens w.r.t. cd'ing around now, the
sed expressions work at least on AIX 4.3.3, and iterations of .. are
tested for and handled correctly.

Sorry I didn't get around to finishing this earlier. Hope this doesn't
mess up any schedules.

Michael J Gruber (2):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./, .. and //

 git-submodule.sh           |   15 ++++++++++--
 t/t7400-submodule-basic.sh |   49 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)
