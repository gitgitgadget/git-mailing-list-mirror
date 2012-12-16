From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 0/7] make test output coloring more intuitive
Date: Sun, 16 Dec 2012 18:28:08 +0000
Message-ID: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7i-0007bF-Q3
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab2LPSjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:39:07 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41200 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab2LPSi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:57 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E58BD2E5D5
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:16 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211601>

This series of commits attempts to make test output coloring
more intuitive, so that:

  - red is only used for things which have gone unexpectedly wrong:
    test failures, unexpected test passes, and failures with the
    framework,

  - yellow is only used for known breakages,

  - green is only used for things which have gone to plan and
    require no further work to be done,

  - blue is only used for skipped tests, and

  - cyan is used for other informational messages.

Since unexpected test passes are no longer treated as passes, the
summary lines displayed at the end of a test run have enough different
possible outputs to warrant them being covered in the test framework's
self-tests.  Therefore this series also refactors and extends the
self-tests.

Adam Spiers (7):
  tests: test number comes first in 'not ok $count - $message'
  tests: paint known breakages in bold yellow
  tests: paint skipped tests in bold blue
  tests: change info messages from yellow/brown to bold cyan
  tests: refactor mechanics of testing in a sub test-lib
  tests: test the test framework more thoroughly
  tests: paint unexpectedly fixed known breakages in bold red

 t/t0000-basic.sh | 211 ++++++++++++++++++++++++++++++++++++++++++-------------
 t/test-lib.sh    |  25 ++++---
 2 files changed, 180 insertions(+), 56 deletions(-)

-- 
1.7.12.1.396.g53b3ea9
