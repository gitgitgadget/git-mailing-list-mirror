From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/5]rev-list and friends: --min-parents, --max-parents
Date: Wed, 23 Mar 2011 10:38:47 +0100
Message-ID: <cover.1300872923.git.git@drmicha.warpmail.net>
References: <20110321105628.GC16334@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 10:42:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2KaI-0008KH-EF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 10:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab1CWJm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 05:42:27 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51296 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751962Ab1CWJm0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 05:42:26 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E7F7720268;
	Wed, 23 Mar 2011 05:42:24 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 05:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=d73GpwOykgFTExRVkEWhbg6U+/Q=; b=Lh+vQOaLmkiXo0KQgkuUeAs3QHFIvIGWrI2P7b2AgSGNFbeYqRXKgglGVvy7myxMnjjg6aqaY+raMWcuG6RTCbE0JUBg7OV1588i7XLYYm799vunFYy9uBq0LQiHNEvnkBgggwz+wJvLoRPBN+PbAGMDkUY/Hi9Wz6kmN4v1Cts=
X-Sasl-enc: DJGH8F1PGSaWj9wtTTgJUh1+97TAG7IlJ16GhzQ+gjSk 1300873344
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3AC8B448B2A;
	Wed, 23 Mar 2011 05:42:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.511.g72e46
In-Reply-To: <20110321105628.GC16334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169807>

Compared to what is currently in pu (which is v2+eps), v3 has:

1/3 -> 1/5 unchanged

2/3 -> 2/5 unchanged

3/5 is !squash for 2/5 and introduces --no-min-parents and --no-max-parents
as natural ways to reset the limits

3/3 -> 4/5 with a fix to the notation in documentation (spell out =<number>)
and an additional dodecapus test

5/5 is !fixup for 4/5 and adds test, doc and completion for --no-min-parents
and --no-max-parents

Junio, please let me/us know whether sending an amended series in this way
(which I've seen before) is actually convenient for you or not. !squash
commits require a message edit, for example. OTOH, I don't know any (other?)
good inter diff solution.

Thanks for everyone's input which went into this (Junio, Jeff, Jonathan).

Michael J Gruber (5):
  t6009: use test_commit() from test-lib.sh
  revision.c: introduce --min-parents and --max-parents
  squash! revision.c: introduce --min-parents and --max-parents
  rev-list --min-parents,--max-parents: doc, test and completion
  fixup! rev-list --min-parents,--max-parents: doc, test and completion

 Documentation/git-rev-list.txt         |    4 +
 Documentation/rev-list-options.txt     |   19 +++++-
 builtin/log.c                          |    2 +-
 builtin/rev-list.c                     |    4 +
 builtin/rev-parse.c                    |    4 +
 contrib/completion/git-completion.bash |    2 +
 revision.c                             |   28 ++++++--
 revision.h                             |    4 +-
 t/t6009-rev-list-parent.sh             |  118 +++++++++++++++++++++++++++++---
 9 files changed, 163 insertions(+), 22 deletions(-)

-- 
1.7.4.1.511.g72e46
