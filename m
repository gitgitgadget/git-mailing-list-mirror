From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] Make t9119-git-svn-info.sh run with svn 1.6.*
Date: Wed,  3 Mar 2010 21:34:30 +0100
Message-ID: <cover.1267647872.git.git@drmicha.warpmail.net>
References: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvGu-000239-K9
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab0CCUeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:34:16 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60336 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752335Ab0CCUeO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 15:34:14 -0500
Received: from compute2.internal (compute2 [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DC244E2654;
	Wed,  3 Mar 2010 15:34:13 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 03 Mar 2010 15:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=rjErGjXBDEK854ooSb60TDZaJZA=; b=gEjKNnGWbFrJonUlpb1Xw7yYZbSJJvIF7QKnJRYxFgumfis4Mp+dNwQarsl5Srgg4dOh0ftPsAFuTP4/tYudyVyeq1zOTbwoAaiSAfDOV2/BWEHMuLMZkvweYqay1Qc/ReJBtnJIgeZOoMwZdY0cYViXUqpuLoMQKTPA279ZBxU=
X-Sasl-enc: K7J/TRpyZL5d6lufqeaHucW78DZFYQ/bB6ubDpIAl7ni 1267648453
Received: from localhost (p3EE2AD69.dip0.t-ipconnect.de [62.226.173.105])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A0BF49CF9A;
	Wed,  3 Mar 2010 15:34:13 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141474>

I'm sorry my previous analysis was wrong. In fact, since the delayed
loading of SVN::Core, git-svn's cmd_info would guess the wrong svn version
because it uses SVN::Core without loading it (leading to an empty version string).

After fixing this, the test runs unmodified, so enbale it for 1.6.*.

Michael J Gruber (2):
  git-svn: req_svn when needed
  t9119-git-svn-info.sh: test with svn 1.6.* as well

 git-svn.perl            |    1 +
 t/t9119-git-svn-info.sh |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)
