From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 00/11] perf improvements past v1.7.10
Date: Mon, 12 Mar 2012 16:09:56 +0100
Message-ID: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76ue-0002gU-ON
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab2CLPLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:11:23 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:23668 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755757Ab2CLPKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:09 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:05 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:06 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192884>

This is what I have collected over a week of playing with the perf
suite.  There is no rush; I am just sending them out for anyone
interested.  If you plan on using the perf suite, I would still
suggest you apply them.

Aside from the new tests, the main goal is the bisection script.
[8/11] is fun too.  Try it!  You will have to install GNU R however.

Thomas Rast (11):
  perf/aggregate: load Git.pm from the build tree
  Introduce a performance test for git-rebase
  Introduce a performance test for git-blame
  perf: display average instead of minimum time
  perf: suppress aggregation also in 'run'
  perf: dereference to a commit when building
  perf: convert realtime to seconds when collecting runs
  perf/aggregate: optionally include a t-test score
  perf/run: allow skipping some revisions
  perf: implement a test-selection feature
  perf: add a bisection tool

 t/perf/README          |    8 +++--
 t/perf/aggregate.perl  |   65 ++++++++++++++++++++++++++--------
 t/perf/bisect_slowdown |   88 ++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/min_time.perl   |   21 -----------
 t/perf/p3400-rebase.sh |   91 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/p8002-blame.sh  |   46 ++++++++++++++++++++++++
 t/perf/perf-lib.sh     |   12 +++++--
 t/perf/run             |   10 ++++--
 t/perf/t_test_score.sh |   24 +++++++++++++
 9 files changed, 322 insertions(+), 43 deletions(-)
 create mode 100755 t/perf/bisect_slowdown
 delete mode 100755 t/perf/min_time.perl
 create mode 100755 t/perf/p3400-rebase.sh
 create mode 100755 t/perf/p8002-blame.sh
 create mode 100755 t/perf/t_test_score.sh

-- 
1.7.10.rc0.230.g16d90
