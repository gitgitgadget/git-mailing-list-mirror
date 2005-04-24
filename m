From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Use diff-cache --strict in gitdiff.sh
Date: Sun, 24 Apr 2005 05:38:24 +0200
Message-ID: <20050424033824.GB23293@diku.dk>
References: <20050424033554.GA23293@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 05:33:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXsL-0003TD-Pg
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVDXDi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVDXDi2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:38:28 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:46786 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262241AbVDXDiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:38:25 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id DD92F6E2A1C; Sun, 24 Apr 2005 05:37:33 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A898F6E2A0B; Sun, 24 Apr 2005 05:37:33 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 7E93661FDD; Sun, 24 Apr 2005 05:38:24 +0200 (CEST)
To: pasky@ucw.cz, git@vger.kernel.org
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050424033554.GA23293@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use diff-cache --strict invokation to only show diff of changed files.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 2aaf94eae20acc451553766f3c063bc46cfa75c6/gitdiff.sh  (mode:100755 sha1:1478a0cfb23a85c259eae1a36cf2a48597fbe8a2)
+++ uncommitted/gitdiff.sh  (mode:100755)
@@ -76,7 +76,7 @@
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	diff-cache -r -z $tree | xargs -0 gitdiff-do "$tree" uncommitted "$filter"
+	diff-cache -r -z --strict $tree | xargs -0 gitdiff-do "$tree" uncommitted "$filter"
 
 	if [ "$id1" != " " ]; then
 		rm $GIT_INDEX_FILE

-- 
Jonas Fonseca
