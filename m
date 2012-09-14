From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 00/11] rev-list/log: document logic with several limiting options
Date: Fri, 14 Sep 2012 11:46:32 +0200
Message-ID: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUC-0006vD-7p
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2INJqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59417 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752404Ab2INJqq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:46 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ABAA420969;
	Fri, 14 Sep 2012 05:46:45 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 14 Sep 2012 05:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=S+97/zm7O42zvWCKweiGJi9zg
	Pk=; b=hqWKt6r+DqYr79Pxngaq378px0Z7feJIXBvrVbiWI8KvLLY+fXpi2L8WW
	PS/ctq3DmoiqAYePq15anaIN9+coH9zU5ceWafhVa8a6o0DbutwaHjGrSO8JQVQi
	7mQSUeQJywx4M27FobHuPyoHbTDsqVG/W4QALiq78gilO1jG1I=
X-Sasl-enc: ERPKHMfpXJTCO7he4E1oAAm4Lbpb5AvVlFkHHnbYbEIx 1347616005
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 45170483805;
	Fri, 14 Sep 2012 05:46:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205467>

In v3 I've rebased my tests on top of Junio's commits which change
--all-match handling and provide a better documentation. Accordingly,
6/6 from v2 is dropped and 5/5 adjusted (expect_failure -> expect_success).

I'm sending out Junio's commits as in pu along with 3 intermixed fixups which
you may squash in freely. (I've only marked the more obvious one as fixup!.)
The last 5 are my rebased tests as described above.

[This approach seemed to be more convenient; hopefully for everyone ;)]

Junio C Hamano (3):
  grep: teach --debug option to dump the parse tree
  log --grep/--author: honor --all-match honored for multiple --grep
    patterns
  log: document use of multiple commit limiting options

Michael J Gruber (8):
  log: name --debug-grep option like in the commit message
  grep: show --debug output only once
  fixup! log: document use of multiple commit limiting options
  t7810-grep: bring log --grep tests in common form
  t7810-grep: test multiple --grep with and without --all-match
  t7810-grep: test multiple --author with --all-match
  t7810-grep: test interaction of multiple --grep and --author options
  t7810-grep: test --all-match with multiple --grep and --author
    options

 Documentation/rev-list-options.txt |  23 ++++++--
 builtin/grep.c                     |   4 ++
 grep.c                             | 111 ++++++++++++++++++++++++++++++++++++-
 grep.h                             |   1 +
 revision.c                         |   2 +
 t/t7810-grep.sh                    |  90 +++++++++++++++++++++++++-----
 6 files changed, 210 insertions(+), 21 deletions(-)

-- 
1.7.12.592.g41e7905
