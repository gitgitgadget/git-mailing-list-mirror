From: Greg Price <price@ksplice.com>
Subject: [PATCH] Documentation: undocument gc'd function graph_release()
Date: Thu, 19 Nov 2009 15:58:29 -0500
Message-ID: <1ac2d430911191258l39579cb9ve06bc3657ac577f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 21:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBE5M-0007Y9-BY
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 21:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZKSU6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 15:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZKSU6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 15:58:25 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:47130 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbZKSU6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 15:58:24 -0500
Received: by ey-out-2122.google.com with SMTP id 4so119418eyf.19
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 12:58:29 -0800 (PST)
Received: by 10.213.0.198 with SMTP id 6mr1973044ebc.84.1258664309317; Thu, 19 
	Nov 2009 12:58:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133254>

graph_release() was removed in 064bfbd.  Cut it from the API
documentation and a comment.

Signed-off-by: Greg Price <price@ksplice.com>
---
 Documentation/technical/api-history-graph.txt |    5 -----
 graph.h                                       |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt
b/Documentation/technical/api-history-graph.txt
index d66e61b..d6fc90a 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -11,9 +11,6 @@ Core functions:

 * `graph_init()` creates a new `struct git_graph`

-* `graph_release()` destroys a `struct git_graph`, and frees the memory
-  associated with it.
-
 * `graph_update()` moves the graph to a new commit.

 * `graph_next_line()` outputs the next line of the graph into a strbuf.  It
@@ -134,8 +131,6 @@ while ((commit = get_revision(opts)) != NULL) {
 			putchar(opts->diffopt.line_termination);
 	}
 }
-
-graph_release(graph);
 ------------

 Sample output
diff --git a/graph.h b/graph.h
index bc30d68..b82ae87 100644
--- a/graph.h
+++ b/graph.h
@@ -6,7 +6,6 @@ struct git_graph;

 /*
  * Create a new struct git_graph.
- * The graph should be freed with graph_release() when no longer needed.
  */
 struct git_graph *graph_init(struct rev_info *opt);

-- 
1.6.5.2.37.ge17fd.dirty
