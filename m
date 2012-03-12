From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 01/11] perf/aggregate: load Git.pm from the build tree
Date: Mon, 12 Mar 2012 16:09:57 +0100
Message-ID: <1f991c7d82e1f55680c7b43790fbe37bdd686415.1331561353.git.trast@student.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:11:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76ue-0002gU-88
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926Ab2CLPLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:11:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:39345 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755759Ab2CLPKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:09 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:07 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 16:10:06 +0100
X-Mailer: git-send-email 1.7.10.rc0.230.g16d90
In-Reply-To: <cover.1331561353.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192883>

As pointed out by Junio, aggregate.perl is not careful enough about
its loading of Git.pm, using the one that is installed on the system.
Load the version from the build tree, using FindBin as proposed by
Jakub.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/perf/aggregate.perl |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 15f7fc1..c0afa0b 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -2,6 +2,9 @@
 
 use strict;
 use warnings;
+use FindBin;
+use lib "$FindBin::Bin/../../perl/blib/lib",
+	"$FindBin::Bin/../../perl/blib/arch/auto/Git";
 use Git;
 
 sub get_times {
-- 
1.7.10.rc0.230.g16d90
