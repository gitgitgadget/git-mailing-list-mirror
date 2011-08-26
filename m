From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/5] patterns for branch list
Date: Fri, 26 Aug 2011 16:05:10 +0200
Message-ID: <cover.1314367414.git.git@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 16:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx2C-0007RU-Fw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab1HZOFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:05:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57277 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502Ab1HZOFS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:05:18 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AC210208D0;
	Fri, 26 Aug 2011 10:05:17 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 26 Aug 2011 10:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=7SoHIwj+u3qJEVteQg2tVYVRR
	AY=; b=ETaznwWwK0VUWyoYuGT/HjIQsB9049enL2RPpceBNQrNF3FFLjlNxb4x9
	1j+vxvMv0uk/flcw3eS6uCMDiN1hYx+zz09t26GOVMMcxr/jB+Jd858qm9mCA36C
	86WVe2ix7ACxTqQTJ6d0LMxD4jmqAa2JMof4quXHTg0qLqBXDg=
X-Sasl-enc: wy7JWicuNPwlma6HokfBie40a1vHPRWSUFgpwPult5W5 1314367517
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2D4D49205E1;
	Fri, 26 Aug 2011 10:05:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <20110825175301.GC519@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180166>

In this iteration, I have incorporated Jeffs and Junios suggestions and Junios
patches. Thanks!

So:

git branch --list is introduced before the patterns (though it is not needed at
that point)

Multiple patterns are allowed.

The -v/vv/vvv changing patches are gone.

Also, the independent test for "-vv" is put first (which certainly can go in
now).  Next come long option names for "git tag" and "git branch", then the
pattern related patches.

I have also rebased on next with nk/branch-v-abbrev (which conflicts, though
"trivially").

"-l -> -g" migration for "git branch" and such are issues for a later series.

Michael J Gruber (5):
  t6040: test branch -vv
  git-tag: introduce long forms for the options
  git-branch: introduce missing long forms for the options
  branch: introduce --list option
  branch: allow pattern arguments

 Documentation/git-branch.txt |   20 +++++++++++++++--
 Documentation/git-tag.txt    |    8 +++++++
 builtin/branch.c             |   46 +++++++++++++++++++++++++++++++----------
 builtin/tag.c                |   16 +++++++-------
 t/t3203-branch-output.sh     |   24 +++++++++++++++++++++
 t/t6040-tracking-info.sh     |   16 ++++++++++++++
 6 files changed, 108 insertions(+), 22 deletions(-)

-- 
1.7.6.845.gc3c05
