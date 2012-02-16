From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/3] Adding a performance framework
Date: Thu, 16 Feb 2012 22:41:12 +0100
Message-ID: <cover.1329428159.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 22:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry95A-0003HQ-2b
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 22:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab2BPVle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 16:41:34 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:1107 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753062Ab2BPVld (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 16:41:33 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 22:41:28 +0100
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 16 Feb
 2012 22:41:31 +0100
X-Mailer: git-send-email 1.7.9.1.334.gd1409
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190911>

This is a reroll of the original RFC at

  http://thread.gmane.org/gmane.comp.version-control.git/187127

Basically, a perf framework that uses little perf scripts written in
the style we already use in the test suite.

As Junio pointed out, the line between GIT_BUILD_DIR and
GIT_TEST_INSTALLED was not very clear cut or well adhered to, so I
threw out the overrides for the former.  This also made
GIT-TEST-OPTIONS moot.

There are no other changes, though I did a rebase on current next.


Thomas Rast (3):
  Move the user-facing test library to test-lib-functions.sh
  Introduce a performance testing framework
  Add a performance test for git-grep

 Makefile                        |   22 +-
 t/Makefile                      |   43 ++-
 t/perf/.gitignore               |    2 +
 t/perf/Makefile                 |   15 +
 t/perf/README                   |  146 +++++++
 t/perf/aggregate.perl           |  166 ++++++++
 t/perf/min_time.perl            |   21 +
 t/perf/p0000-perf-lib-sanity.sh |   41 ++
 t/perf/p0001-rev-list.sh        |   17 +
 t/perf/p7810-grep.sh            |   23 ++
 t/perf/perf-lib.sh              |  198 +++++++++
 t/perf/run                      |   82 ++++
 t/test-lib-functions.sh         |  835 +++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                   |  574 ++--------------------------
 14 files changed, 1633 insertions(+), 552 deletions(-)
 create mode 100644 t/perf/.gitignore
 create mode 100644 t/perf/Makefile
 create mode 100644 t/perf/README
 create mode 100755 t/perf/aggregate.perl
 create mode 100755 t/perf/min_time.perl
 create mode 100755 t/perf/p0000-perf-lib-sanity.sh
 create mode 100755 t/perf/p0001-rev-list.sh
 create mode 100755 t/perf/p7810-grep.sh
 create mode 100644 t/perf/perf-lib.sh
 create mode 100755 t/perf/run
 create mode 100644 t/test-lib-functions.sh

-- 
1.7.9.1.334.gd1409
