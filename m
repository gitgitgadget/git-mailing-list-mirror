From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] rev-list and friends: --min-parents, --max-parents
Date: Fri, 18 Mar 2011 15:50:22 +0100
Message-ID: <cover.1300459016.git.git@drmicha.warpmail.net>
References: <20110318085616.GA16703@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0b3x-0000lK-DM
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab1CROx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 10:53:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41042 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752862Ab1CROxy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:53:54 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1EF4420A75;
	Fri, 18 Mar 2011 10:53:54 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 18 Mar 2011 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=5PDP5OjnHDYIz+20Hp/bcs+WQwc=; b=e01DFMOI6+q2HXVjgWvINILhv/3L730wRnxK4m20DYAoym8u99m0Bm6Ei5/KiD5MUibQc8R9Z6MvRacWnUvNTBxhrqok0jsWD9cr4ludLweBNc6bnhzJ1b+lLM6h7a9C1TXE82xSWitllcp1S7YiwSEXIaJmAddOEdi4v9TWo4s=
X-Sasl-enc: 1/5QexuwRolhi4I+JHJI/kS2MQwlp4A8nc3B09N0AuEn 1300460033
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A82C9441C88;
	Fri, 18 Mar 2011 10:53:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
In-Reply-To: <20110318085616.GA16703@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169325>

As opposed to the RFD it replaces, this is a real patch series with
documentation and tests, and it even comes with boiler plate. It should
make all of Jeff's and Junio's dreams come true (as far as revision
limiting by parent number goes).

1/3 introduces the new options (and has a proper commit message)
2/3 I noted along the way and could be applied earlier
3/3 depends on 1 and 2 and is the candy (doc, tests, completion)

*** BLURB HERE ***

Michael J Gruber (3):
  revision.c: introduce --min-parents and --max-parents
  t6009: use test_commit() from test-lib.sh
  rev-list --min-parents,--max-parents: doc and test and completion

 Documentation/git-rev-list.txt         |    2 +
 Documentation/rev-list-options.txt     |   13 +++++
 builtin/log.c                          |    2 +-
 builtin/rev-list.c                     |    2 +
 builtin/rev-parse.c                    |    2 +
 contrib/completion/git-completion.bash |    1 +
 revision.c                             |   23 ++++++---
 revision.h                             |    9 +++-
 t/t6009-rev-list-parent.sh             |   85 +++++++++++++++++++++++++++-----
 9 files changed, 117 insertions(+), 22 deletions(-)

-- 
1.7.4.1.464.gf81ff
