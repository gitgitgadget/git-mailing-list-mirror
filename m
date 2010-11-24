From: Torgny Nyblom <kde@nyblom.org>
Subject: [PATCH] Allow tuning of the threshold for detecting renames/copies.
Date: Wed, 24 Nov 2010 15:31:04 +0100
Message-ID: <20101124153104.3cc1135e@explosive.nyblom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 15:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLGXh-00050O-2Y
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 15:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab0KXOlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 09:41:44 -0500
Received: from mailrelay.veberod.com ([193.12.238.77]:37612 "EHLO
	mailrelay.veberod.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0KXOlo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 09:41:44 -0500
X-Greylist: delayed 635 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Nov 2010 09:41:43 EST
Received: from dx.nyblom.org ([212.247.117.70])
	by mailrelay.veberod.com (8.13.8/8.13.8) with ESMTP id oAOBdnZ2001194
	for <git@vger.kernel.org>; Wed, 24 Nov 2010 12:39:50 +0100
Received: from localhost (localhost [127.0.0.1])
	by dx.nyblom.org (Postfix) with ESMTP id 8227C30500
	for <git@vger.kernel.org>; Wed, 24 Nov 2010 15:31:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at dx.nyblom.org
Received: from dx.nyblom.org ([127.0.0.1])
	by localhost (dx.nyblom.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4hhZI0D+Utl for <git@vger.kernel.org>;
	Wed, 24 Nov 2010 15:31:04 +0100 (CET)
Received: from explosive.nyblom.org (explosive.nyblom.org [192.168.0.201])
	by dx.nyblom.org (Postfix) with ESMTP id 913BBE40B7
	for <git@vger.kernel.org>; Wed, 24 Nov 2010 15:31:04 +0100 (CET)
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162064>

A patch originally from Jeff King, it allows tuning of the threshold for detecting renames/copies when using git log.


From: Jeff King <peff@peff.net>

Signed-off-by: Torgny Nyblom <kde@nyblom.org>
---
 tree-diff.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 12c9a88..378f049 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -351,6 +351,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
 	diff_opts.break_opt = opt->break_opt;
+	diff_opts.rename_score = opt->rename_score;
 	paths[0] = NULL;
 	diff_tree_setup_paths(paths, &diff_opts);
 	if (diff_setup_done(&diff_opts) < 0)
-- 
1.7.1
