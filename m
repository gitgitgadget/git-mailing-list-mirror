From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/5] t3301: fix confusing quoting in test for valid notes ref
Date: Sat, 14 Feb 2009 21:23:23 +0100
Message-ID: <2d4b5321543974ec25921102faef900e42eea1d5.1234642638.git.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:25:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR4T-0004Kh-1l
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZBNUXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZBNUXk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:23:40 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27331 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbZBNUXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:23:38 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:34 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:33 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <200902142056.42198.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 20:23:33.0803 (UTC) FILETIME=[1BDD97B0:01C98EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109918>

The test used single quotes in the test code, but also single quotes
to wrap the entire test snippet, thus effectively skipping _out_ of
quoted mode.  Since it doesn't matter here, just drop the quotes to
cause less confusion.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

Dropped the removal of MSG=2.

 t/t3301-notes.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index ff4ea05..43d82a2 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -31,8 +31,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'need valid notes ref' '
-	! MSG=1 GIT_NOTES_REF='/' git notes edit &&
-	! MSG=2 GIT_NOTES_REF='/' git notes show
+	! MSG=1 GIT_NOTES_REF=/ git notes edit &&
+	! MSG=2 GIT_NOTES_REF=/ git notes show
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
-- 
1.6.2.rc0.296.ge2122
