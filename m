From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/5] t/t5150: remove space from sed script
Date: Tue,  1 Jun 2010 19:13:42 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfHdhdVVIWdBL2foeesc5htUYUB0CGsjKfyMiphDZSQ95SVoPotS07S0@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbbG-0007mc-CP
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271Ab0FBAOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:14:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50199 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299Ab0FBAOR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:14:17 -0400
Received: by mail.nrlssc.navy.mil id o520EDFh007919; Tue, 1 Jun 2010 19:14:13 -0500
In-Reply-To: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Jun 2010 00:14:13.0552 (UTC) FILETIME=[87F9B300:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148175>

From: Brandon Casey <drafnel@gmail.com>

Solaris's xpg4/sed and IRIX's sed fail to parse these negated matching
expressions when the '!' is separated from the command that follows.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5150-request-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index 169d3ea..9cc0a42 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -67,7 +67,7 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 
 	cat <<-\EOT >read-request.sed &&
 	#!/bin/sed -nf
-	/ in the git repository at:$/! d
+	/ in the git repository at:$/!d
 	n
 	/^$/ n
 	s/^[ 	]*\(.*\) \([^ ]*\)/please pull\
@@ -102,7 +102,7 @@ test_expect_success 'setup: two scripts for reading pull requests' '
 	/^        [a-zA-Z]/ n
 	/^[a-zA-Z]* ([0-9]*):\$/ n
 	/^\$/ N
-	/^\n[a-zA-Z]* ([0-9]*):\$/! {
+	/^\n[a-zA-Z]* ([0-9]*):\$/!{
 		a\\
 	SHORTLOG
 		D
-- 
1.6.6.2
