From: David Michael Barr <david.barr@cordelta.com>
Subject: [PATCH 13/10] vcs-svn: use mark from previous import for parent commit
Date: Sun, 12 Dec 2010 20:32:57 +1100
Message-ID: <11EEDD77-214C-44DB-AC7B-C1A086E35E4C@cordelta.com>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 10:33:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRiIn-0006oY-9m
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 10:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab0LLJdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 04:33:04 -0500
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:15177
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751770Ab0LLJdC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 04:33:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAF8lBE3LWHsF/2dsb2JhbACkBgh4tjKIToVKBA
X-IronPort-AV: E=Sophos;i="4.59,332,1288530000"; 
   d="scan'208";a="302756798"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 12 Dec 2010 20:32:59 +1100
Received: (qmail 31186 invoked from network); 12 Dec 2010 20:32:59 +1100
Received: from d110-33-95-167.mit3.act.optusnet.com.au (HELO ?192.168.1.1?) (110.33.95.167)
  by 203.88.123.185 with SMTP; 12 Dec 2010 20:32:58 +1100
In-Reply-To: <20101210102007.GA26298@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163475>

From: David Barr <david.barr@cordelta.com>
Date: Sun, 12 Dec 2010 13:41:38 +1100
Subject: [PATCH] vcs-svn: use mark from previous import for parent commit

Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index d2397d8..6abd108 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -77,7 +77,7 @@ void fast_export_begin_commit(uint32_t revision, uint32_t author, char *log,
 		   log, gitsvnline);
 	if (!first_commit_done) {
 		if (revision > 1)
-			printf("from refs/heads/master^0\n");
+			printf("from :%"PRIu32"\n", revision - 1);
 		first_commit_done = 1;
 	}
 }
-- 
1.7.3.2.846.gf4b062
