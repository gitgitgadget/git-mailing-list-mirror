From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: [PATCH] git-pull.sh: Fix call to git-merge for new command format
Date: Tue,  1 Dec 2009 19:44:11 -0300
Message-ID: <1259707451-20661-1-git-send-email-vonbrand@inf.utfsm.cl>
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 02 00:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbyA-0008SL-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 00:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbZLAXRH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 18:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754177AbZLAXRG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 18:17:06 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53501 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbZLAXRF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 18:17:05 -0500
X-Greylist: delayed 1968 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 18:17:04 EST
Received: from quelen.inf.utfsm.cl (quelen.inf.utfsm.cl [200.1.19.54])
	by inti.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id nB1MiF8W030485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Dec 2009 19:44:15 -0300
Received: from laptop14.inf.utfsm.cl (cautin.dcsc.utfsm.cl [200.1.21.41])
	by quelen.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id nB1Mw7eQ017960;
	Tue, 1 Dec 2009 19:58:07 -0300
Received: from laptop14.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3) with ESMTP id nB1MiDsD020696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 Dec 2009 19:44:14 -0300
Received: (from vonbrand@localhost)
	by laptop14.inf.utfsm.cl (8.14.3/8.14.3/Submit) id nB1MiDOY020694;
	Tue, 1 Dec 2009 19:44:13 -0300
X-Mailer: git-send-email 1.6.6.rc0.114.gc8648
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (inti.inf.utfsm.cl [0.0.0.0]); Tue, 01 Dec 2009 19:44:15 -0300 (CLST)
X-Spam-Status: No, score=-100.0 required=5.0 tests=AWL,UNPARSEABLE_RELAY,
	USER_IN_WHITELIST autolearn=failed version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134267>

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 git-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index bfeb4a0..a875809 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -218,5 +218,5 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
 	exec git-rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
-	"$merge_name" HEAD $merge_head $verbosity
+exec git-merge  $verbosity -m $diffstat $no_commit $squash $no_ff $ff_only $log_arg $strategy_args \
+	"$merge_name" $merge_head
-- 
1.6.6.rc0.114.gc8648
