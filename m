From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Document -w option to shortlog
Date: Sat, 12 Apr 2008 15:37:57 -0700
Message-ID: <7v1w5ahf7e.fsf@gitster.siamese.dyndns.org>
References: <E874634E-9746-4916-81F3-433C2A71BDC7@nocrew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Noring <noring@nocrew.org>
X-From: git-owner@vger.kernel.org Sun Apr 13 00:39:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkoNM-0006DW-7u
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 00:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbYDLWiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 18:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbYDLWiF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 18:38:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbYDLWiE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 18:38:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C7BBD229C;
	Sat, 12 Apr 2008 18:38:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 24037229B; Sat, 12 Apr 2008 18:37:59 -0400 (EDT)
In-Reply-To: <E874634E-9746-4916-81F3-433C2A71BDC7@nocrew.org> (Fredrik
 Noring's message of "Sat, 12 Apr 2008 15:05:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79386>

Noticed by Fredrik Noring.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-shortlog.txt |   10 ++++++++--
 builtin-shortlog.c             |    2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c775257..d7cb4c0 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s] [-e]
-git-shortlog [-n|--numbered] [-s|--summary] [-e|--email] [<committish>...]
+git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s] [-e] [-w]
+git-shortlog [-n|--numbered] [-s|--summary] [-e|--email] [-w[<width>[,<indent1>[,<indent2>]]]] [<committish>...]
 
 DESCRIPTION
 -----------
@@ -35,6 +35,12 @@ OPTIONS
 -e, \--email::
 	Show the email address of each author.
 
+-w[<width>[,<indent1>[,<indent2>]]]::
+	Linewrap the output by wrapping each line at `width`.  The first
+	line of each entry is indented by `indent1` spaces, and the second
+	and subsequent lines are indented by `indent2` spaces. `width`,
+	`indent1`, and `indent2` default to 76, 6 and 9 respectively.
+
 FILES
 -----
 
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index f08095b..01cfd7b 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -8,7 +8,7 @@
 #include "mailmap.h"
 
 static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [<commit-id>... ]";
+"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
 
 static char *common_repo_prefix;
 static int email;
