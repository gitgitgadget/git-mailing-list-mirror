From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/3] diff.c: --stat-count=<n>
Date: Fri, 27 May 2011 14:36:39 +0200
Message-ID: <cover.1306499600.git.git@drmicha.warpmail.net>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 14:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPwHc-0005GB-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 14:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1E0Mgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 08:36:45 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47583 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753648Ab1E0Mgp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2011 08:36:45 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C8C7820520;
	Fri, 27 May 2011 08:36:44 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 May 2011 08:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=EJ8fgeCGMWmVKIVgegvZERs6de0=; b=XlPLvIiC0iZgXSKBaiypf5HU6FQ0H/rWJjPNJ9t8CqIWQtDkZFg7FYxzeZAIYHnz3sLxtswF8pj0oGoekaYtf9ITlMotCMgQiziQ8jpEPruPTaL2VxynWcrkgOrAi0t2Sj+hDPZB6p/X4bAy27hKRzTNFvTv5NeQu1WszsDA1xI=
X-Sasl-enc: BFFhyl3Ia3s5Q4P/UmwAZi1xVmafVItvQQJvZyIM4OWF 1306499804
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5083F4492BC;
	Fri, 27 May 2011 08:36:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.2.657.g62c2
In-Reply-To: <4DC0FD3D.9010004@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174610>

So, this grew into a little series because of the issue in 1/3. The fact
that we looked up the name for a diff item  even when we don't display it
was never great but started being bad when we started not to fill in
unnecessary names... With that segv out of the way, here's v3 of the series.

Compared to v2, I hope I have learned to count.

Michael J Gruber (3):
  diff.c: omit hidden entries from namelen calculation with --stat
  diff: introduce --stat-lines to limit the stat lines
  diff-options.txt: describe --stat-{width,name-width,count}

 Documentation/diff-options.txt |    8 +++++-
 diff.c                         |   52 +++++++++++++++++++++++++++++++++-------
 diff.h                         |    1 +
 3 files changed, 51 insertions(+), 10 deletions(-)

-- 
1.7.5.2.657.g62c2
