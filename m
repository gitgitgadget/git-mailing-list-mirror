From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] graph.c: avoid compile warnings
Date: Mon, 30 Mar 2009 17:49:36 +0200 (CEST)
Message-ID: <7ee8d1c4ca806ce964356a1fe78efac19d56c29b.1238428115u.git.johannes.schindelin@gmx.de>
References: <20090330141322.GA6221@linux.vnet> <cover.1238428115u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org, Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJlb-0001Mr-S8
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbZC3Ptl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZC3Ptl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:49:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:60984 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751966AbZC3Ptk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 11:49:40 -0400
Received: (qmail invoked by alias); 30 Mar 2009 15:49:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 30 Mar 2009 17:49:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rcbB25CHrDXTI4cpEg9EZ7A//aKlMoYd1NGWX8Z
	oRIpqxEcdI0AW6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1238428115u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115166>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I'd actually like to see this and the next patch squashed in.

 graph.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/graph.c b/graph.c
index 2929c8b..5e2f224 100644
--- a/graph.c
+++ b/graph.c
@@ -701,8 +701,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
 	for (i = 0; i < graph->num_columns; i++) {
 		struct column *col = &graph->columns[i];
 		if (col->commit == graph->commit) {
-			seen_this = 1;
 			struct strbuf tmp = STRBUF_INIT;
+			seen_this = 1;
 			strbuf_addf(&tmp, "| %*s", graph->expansion_row, "");
 			strbuf_write_column(sb, col, tmp.buf);
 			strbuf_release(&tmp);
@@ -921,8 +921,6 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 {
 	int i;
 	int *tmp_mapping;
-	static int collapsing_columns[255];
-	int collapsing_seen_so_far = 0;
 
 	/*
 	 * Clear out the new_mapping array
-- 
1.6.2.1.493.g67cf3
