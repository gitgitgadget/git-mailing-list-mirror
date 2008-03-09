From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-clone: fix for new unpack_trees() semantics
Date: Sun, 9 Mar 2008 22:30:35 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803092227230.3975@racer.site>
References: <alpine.LNX.1.00.0803081803360.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 22:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYT6w-00039Y-53
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 22:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbYCIVae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYCIVae
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 17:30:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:58285 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751002AbYCIVad (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 17:30:33 -0400
Received: (qmail invoked by alias); 09 Mar 2008 21:30:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 09 Mar 2008 22:30:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eSiIfggieVoc7JMcusZVS1UpjImx7v8uvyngD9E
	s3jxqc0ElWQ4LI
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803081803360.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76672>

In git.git's "next" branch, unpack_trees() must specify source and target 
index.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	To be squashed into 10/11

 builtin-clone.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index e4047ed..3890e12 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -534,6 +534,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		opts.verbose_update = !option_quiet;
 		opts.merge = 1;
 		opts.fn = twoway_merge;
+		opts.src_index = &the_index;
+		opts.dst_index = &the_index;
 
 		tree = parse_tree_indirect(remote_head->old_sha1);
 		parse_tree(tree);
-- 
1.5.4.3.653.gbc310
