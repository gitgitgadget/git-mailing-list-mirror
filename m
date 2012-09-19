From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 0/6] make test output coloring more intuitive
Date: Wed, 19 Sep 2012 18:15:09 +0100
Message-ID: <1348074915-19985-1-git-send-email-git@adamspiers.org>
References: <20120918213617.GB2567@atlantic.linksys.moosehall>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:15:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENs0-0001m5-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab2ISRPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:15:18 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:44882 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab2ISRPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:15:17 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 0C0B62E39E;
	Wed, 19 Sep 2012 18:15:16 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <20120918213617.GB2567@atlantic.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205949>

This series of commits attempts to make test output coloring
more intuitive, so that:

  - red is _only_ used for things which have gone unexpectedly wrong:
    test failures, unexpected test passes, and failures with the
    framework,

  - yellow is _only_ used for known breakages and skipped tests, and

  - green is _only_ used for things which have gone to plan and
    require no further work to be done.

Adam Spiers (6):
  Change the color of individual known breakages
  Make 'not ok $count - $message' consistent with 'ok $count -
    $message'
  Color skipped tests the same as informational messages
  Refactor mechanics of testing in a sub test-lib
  Test the test framework more thoroughly
  Treat unexpectedly fixed known breakages more seriously

 t/t0000-basic.sh | 179 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 t/test-lib.sh    |  25 +++++---
 2 files changed, 174 insertions(+), 30 deletions(-)
 mode change 100644 => 100755 t/test-lib.sh

-- 
1.7.12.147.g6d168f4
