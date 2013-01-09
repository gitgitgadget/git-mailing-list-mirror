From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/2] git-fast-import(1): reorganise options
Date: Wed, 9 Jan 2013 19:45:29 +0000
Message-ID: <e228dd4522dbf7ebfe0e5207b1dcc9591faa4d15.1357760256.git.john@keeping.me.uk>
References: <cover.1357760256.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:54:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1jG-0000kg-By
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457Ab3AITyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:54:05 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:41617 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354Ab3AITyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:54:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 50EDFCDA5B3;
	Wed,  9 Jan 2013 19:45:44 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wc90R5Dl41IU; Wed,  9 Jan 2013 19:45:43 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8E897CDA5B2;
	Wed,  9 Jan 2013 19:45:42 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 72B1D161E262;
	Wed,  9 Jan 2013 19:45:42 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FIbKSi-3hgq; Wed,  9 Jan 2013 19:45:42 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8AEBB161E572;
	Wed,  9 Jan 2013 19:45:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <cover.1357760256.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213093>

The options in git-fast-import(1) are not currently arranged in a
logical order, which has caused the '--done' options to be documented
twice (commit 3266de10).

Rearrange them into logical groups under subheadings.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: John Keeping <john@keeping.me.uk>

---
 Documentation/git-fast-import.txt | 88 +++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 75ce808..bf1a02a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -33,34 +33,46 @@ the frontend program in use.
 
 OPTIONS
 -------
---date-format=<fmt>::
-	Specify the type of dates the frontend will supply to
-	fast-import within `author`, `committer` and `tagger` commands.
-	See ``Date Formats'' below for details about which formats
-	are supported, and their syntax.
 
 --force::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
 	not contain the old commit).
 
---max-pack-size=<n>::
-	Maximum size of each output packfile.
-	The default is unlimited.
+--quiet::
+	Disable all non-fatal output, making fast-import silent when it
+	is successful.  This option disables the output shown by
+	\--stats.
 
---big-file-threshold=<n>::
-	Maximum size of a blob that fast-import will attempt to
-	create a delta for, expressed in bytes.  The default is 512m
-	(512 MiB).  Some importers may wish to lower this on systems
-	with constrained memory.
+--stats::
+	Display some basic statistics about the objects fast-import has
+	created, the packfiles they were stored into, and the
+	memory used by fast-import during this run.  Showing this output
+	is currently the default, but can be disabled with \--quiet.
 
---depth=<n>::
-	Maximum delta depth, for blob and tree deltification.
-	Default is 10.
+Options for Frontends
+~~~~~~~~~~~~~~~~~~~~~
 
---active-branches=<n>::
-	Maximum number of branches to maintain active at once.
-	See ``Memory Utilization'' below for details.  Default is 5.
+--cat-blob-fd=<fd>::
+	Write responses to `cat-blob` and `ls` queries to the
+	file descriptor <fd> instead of `stdout`.  Allows `progress`
+	output intended for the end-user to be separated from other
+	output.
+
+--date-format=<fmt>::
+	Specify the type of dates the frontend will supply to
+	fast-import within `author`, `committer` and `tagger` commands.
+	See ``Date Formats'' below for details about which formats
+	are supported, and their syntax.
+
+--done::
+	Terminate with error if there is no `done` command at the end of
+	the stream.  This option might be useful for detecting errors
+	that cause the frontend to terminate before it has started to
+	write a stream.
+
+Locations of Marks Files
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 --export-marks=<file>::
 	Dumps the internal marks table to <file> when complete.
@@ -94,19 +106,22 @@ OPTIONS
 Relative and non-relative marks may be combined by interweaving
 --(no-)-relative-marks with the --(import|export)-marks= options.
 
+Performance and Compression Tuning
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
---cat-blob-fd=<fd>::
-	Write responses to `cat-blob` and `ls` queries to the
-	file descriptor <fd> instead of `stdout`.  Allows `progress`
-	output intended for the end-user to be separated from other
-	output.
+--active-branches=<n>::
+	Maximum number of branches to maintain active at once.
+	See ``Memory Utilization'' below for details.  Default is 5.
 
---done::
-	Terminate with error if there is no `done` command at the
-	end of the stream.
-	This option might be useful for detecting errors that
-	cause the frontend to terminate before it has started to
-	write a stream.
+--big-file-threshold=<n>::
+	Maximum size of a blob that fast-import will attempt to
+	create a delta for, expressed in bytes.  The default is 512m
+	(512 MiB).  Some importers may wish to lower this on systems
+	with constrained memory.
+
+--depth=<n>::
+	Maximum delta depth, for blob and tree deltification.
+	Default is 10.
 
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
@@ -117,16 +132,9 @@ Relative and non-relative marks may be combined by interweaving
 	as these commits can be used as edge points during calls
 	to 'git pack-objects'.
 
---quiet::
-	Disable all non-fatal output, making fast-import silent when it
-	is successful.  This option disables the output shown by
-	\--stats.
-
---stats::
-	Display some basic statistics about the objects fast-import has
-	created, the packfiles they were stored into, and the
-	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with \--quiet.
+--max-pack-size=<n>::
+	Maximum size of each output packfile.
+	The default is unlimited.
 
 
 Performance
-- 
1.8.1.468.g3d9f9b6
