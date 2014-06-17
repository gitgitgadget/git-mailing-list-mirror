From: Caleb Thompson <caleb@calebthompson.io>
Subject: [PATCH v6 0/4] commit: Add commit.verbose configuration
Date: Tue, 17 Jun 2014 14:38:56 -0500
Message-ID: <cover.1403033723.git.caleb@calebthompson.io>
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:39:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzEL-0007aa-7S
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933632AbaFQTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 15:39:22 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60391 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756487AbaFQTjV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jun 2014 15:39:21 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5639A685;
	Tue, 17 Jun 2014 15:39:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 17 Jun 2014 15:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=calebthompson.io;
	 h=from:to:cc:subject:date:message-id; s=mesmtp; bh=N2uX9RtqQ3T/
	P/X6c899cqx3xo8=; b=bY3DY3Rz3ycMh1Pk1OYJFabmzR2NpBCtxLbR7a+8l5rt
	bvKC36bSETy5qsmjJYiBTf60HCWpbHNMybJzXZxJnD+eaDOv9hOjJZlt41zUwON/
	AkstId7GADtZXF0CYDgqWbijjg0LoxJa3GJGYFIF5NqbCQlCjcn9DFbT8oXO7uQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=N2uX9RtqQ3T/P/X6c899cqx3xo8=; b=Hgr/9h+ZdXQH3pCalzSJ
	sOInxh5uy8kXx3WQwHkome1ODow+wn+KCieyxUhE3kUdQLbc3tiW3eqnB7PjXt6b
	g7YB6h+O6g9tOqZrNRV9O9Y255GkVaPIvG68AqzVJsj5F3EpIOHUml0H6eyOZf99
	tnUIN5WVI2OjFJCeme4lqs8=
X-Sasl-enc: y8mtDjSgWFQRGmkubGnAkcyYOv3TywD0eqSE9yEHXvAu 1403033950
Received: from localhost.localdomain (unknown [67.78.97.126])
	by mail.messagingengine.com (Postfix) with ESMTPA id 96335C007B1;
	Tue, 17 Jun 2014 15:39:10 -0400 (EDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251943>

This patch allows people to set commit.verbose to implicitly send
--verbose to git-commit.

It introduces several cleanup patches to t/t7505-commit-verbose.sh to
bring it closer to the current state of the tests as they have been
explained to me, then adds the verbose config and --no-verbose flag.

Since the last version of this patch
(http://thread.gmane.org/gmane.comp.version-control.git/251486), there
have been a couple of commit message clarifications and the body of the
check-for-no-diff script in the last patch was changed to simply negate
check-for-diff.

Caleb Thompson

------------------------------------------------------


Caleb Thompson (4):
  commit test: Use test_config instead of git-config
  commit test: Use write_script
  commit test: test_set_editor in each test
  commit: Add commit.verbose configuration

 Documentation/config.txt               |  5 +++
 Documentation/git-commit.txt           |  8 ++++-
 builtin/commit.c                       |  4 +++
 contrib/completion/git-completion.bash |  1 +
 t/t7507-commit-verbose.sh              | 64 +++++++++++++++++++++++++---------
 5 files changed, 64 insertions(+), 18 deletions(-)

--
2.0.0
