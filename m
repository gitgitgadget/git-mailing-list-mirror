From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 4/7] gitk(1): expand the manpage to look less like a template
Date: Fri, 25 Aug 2006 03:04:58 +0200
Message-ID: <20060825010458.GE4069@diku.dk>
References: <20060818084545.GB4717@diku.dk> <7virkqbcq3.fsf@assigned-by-dhcp.cox.net> <20060825005655.GB4069@diku.dk> <20060825005820.GC4069@diku.dk> <20060825010149.GD4069@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 25 03:05:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGQ8H-0005pG-J2
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 03:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422803AbWHYBFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 21:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422805AbWHYBFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 21:05:09 -0400
Received: from [130.225.96.91] ([130.225.96.91]:21936 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1422803AbWHYBFH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Aug 2006 21:05:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E228C77007D;
	Fri, 25 Aug 2006 03:04:59 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26305-02; Fri, 25 Aug 2006 03:04:58 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3F335770079;
	Fri, 25 Aug 2006 03:04:58 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1C5826DF88D; Fri, 25 Aug 2006 03:03:40 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2590A629FB; Fri, 25 Aug 2006 03:04:58 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060825010149.GD4069@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25987>

Add a short description and document a few selected options additionally to
the different "entities" in the standard calling convention. Advertise
other git repository browsers. Lastly, climb Mount Ego.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/gitk.txt |   60 ++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index cb482bf..23be005 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -3,26 +3,52 @@ gitk(1)
 
 NAME
 ----
-gitk - Some git command not yet documented.
-
+gitk - git repository browser
 
 SYNOPSIS
 --------
-'gitk' [ --option ] <args>...
+'gitk' [<option>...] [<revs>] [--] [<path>...]
 
 DESCRIPTION
 -----------
-Does something not yet documented.
+Displays changes in a repository or a selected set of commits. This includes
+visualizing the commit graph, showing information related to each commit, and
+the files in the trees of each revision.
 
+Historically, gitk was the first repository browser. It's written in tcl/tk
+and started off in a separate repository but was later merged into the main
+git repository.
 
 OPTIONS
 -------
---option::
-	Some option not yet documented.
+To control which revisions to shown, the command takes options applicable to
+the gitlink:git-rev-list[1] command. This manual page describes only the most
+frequently used options.
+
+-n <number>, --max-count=<number>::
+
+	Limits the number of commits to show.
+
+--since=<date>::
+
+	Show commits more recent than a specific date.
+
+--until=<date>::
+
+	Show commits older than a specific date.
 
-<args>...::
-	Some argument not yet documented.
+<revs>::
 
+	Limit the revisions to show. This can be either a single revision
+	meaning show from the given revision and back, or it can be a range in
+	the form "'<from>'..'<to>'" to show all revisions between '<from>' and
+	back to '<to>'. Note, more advanced revision selection can be applied.
+
+<path>::
+
+	Limit commits to the ones touching files in the given paths. Note, to
+	avoid ambiguity wrt. revision names use "--" to separate the paths
+	from any preceeding options.
 
 Examples
 --------
@@ -37,13 +63,27 @@ gitk --since="2 weeks ago" \-- gitk::
 	The "--" is necessary to avoid confusion with the *branch* named
 	'gitk'
 
+See Also
+--------
+'qgit(1)'::
+	A repository browser written in C++ using Qt.
+
+'gitview(1)'::
+	A repository browser written in Python using Gtk. It's based on
+	'bzrk(1)' and distributed in the contrib area of the git repository.
+
+'tig(1)'::
+	A minimal repository browser and git tool output highlighter written
+	in C using Ncurses.
+
 Author
 ------
-Written by Paul Mackerras <paulus@samba.org>
+Written by Paul Mackerras <paulus@samba.org>.
 
 Documentation
 --------------
-Documentation by Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by Junio C Hamano, Jonas Fonseca, and the git-list
+<git@vger.kernel.org>.
 
 GIT
 ---
-- 
1.4.2.GIT


-- 
Jonas Fonseca
