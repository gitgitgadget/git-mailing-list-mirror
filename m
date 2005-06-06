From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-commit: prefix pathspec argument with --
Date: Mon, 6 Jun 2005 23:32:52 +0200
Message-ID: <20050606213252.GB3498@diku.dk>
References: <20050606212700.GA3498@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 23:31:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfP9t-0002Hv-RT
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 23:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVFFVc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 17:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVFFVc4
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 17:32:56 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:10691 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261269AbVFFVcx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 17:32:53 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id D50B56E166B; Mon,  6 Jun 2005 23:32:08 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9DAB96E14C0; Mon,  6 Jun 2005 23:32:08 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 29BFD61FE0; Mon,  6 Jun 2005 23:32:52 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050606212700.GA3498@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make cg-commit handle files beginning with dashes.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

[ Obviously depends on the patch I sent previously. ]

 cg-commit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -110,7 +110,7 @@ if [ "$1" ]; then
 	[ "$ignorecache" ] && die "-C and listing files to commit does not make sense"
 	[ -s $_git/merging ] && die "cannot commit individual files when merging"
 
-	eval commitfiles=($(git-diff-cache -r -m HEAD "$@" | \
+	eval commitfiles=($(git-diff-cache -r -m HEAD -- "$@" | \
 		sed 's/^\([^	]*\)\(.	.*\)\(	.*\)*$/"\2"/'))
 	customfiles=1
 
-- 
Jonas Fonseca
