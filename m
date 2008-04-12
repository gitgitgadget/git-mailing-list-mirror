From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] shortlog wrap usage
Date: Sat, 12 Apr 2008 15:05:25 +0200
Message-ID: <E874634E-9746-4916-81F3-433C2A71BDC7@nocrew.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: multipart/mixed; boundary=Apple-Mail-9--82424844
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Apr 12 15:28:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkfm3-0005Fp-7Z
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 15:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYDLN1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 09:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753616AbYDLN1I
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 09:27:08 -0400
Received: from smtpserver.visit.se ([85.194.0.110]:57393 "EHLO mail.visit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374AbYDLN1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 09:27:07 -0400
X-Greylist: delayed 1297 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Apr 2008 09:27:06 EDT
Received: by mail.visit.se (Postfix, from userid 503)
	id 0FA9A36E025F; Sat, 12 Apr 2008 15:05:42 +0200 (CEST)
Received: from [10.0.1.2] (cust.dsl-fiber-lan.snet.lk.85.194.37.51.visit.se [85.194.37.51])
	by mail.visit.se (Postfix) with ESMTP id 6D45236E01ED;
	Sat, 12 Apr 2008 15:05:41 +0200 (CEST)
X-Mailer: Apple Mail (2.919.2)
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on mail.visit.se
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79352>


--Apple-Mail-9--82424844
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi all,

Found this hidden "-w" option to the shortlog command, and thought it  
might be good to have it documented.

  builtin-shortlog.c  |    2 +-
  man1/git-shortlog.1 |    6 +++++-
  2 files changed, 6 insertions(+), 2 deletions(-)

Thanks,
Fredrik


--Apple-Mail-9--82424844
Content-Disposition: attachment;
	filename=shortlog-wrap-usage.patch
Content-Type: application/octet-stream;
	x-unix-mode=0664;
	name="shortlog-wrap-usage.patch"
Content-Transfer-Encoding: 7bit

diff --git a/man1/git-shortlog.1 b/man1/git-shortlog.1
index 306c821..3602ad9 100644
--- a/man1/git-shortlog.1
+++ b/man1/git-shortlog.1
@@ -13,7 +13,8 @@ git\-shortlog \- Summarize 'git log' output
 .sp
 .nf
 git\-log \-\-pretty=short | \fIgit\-shortlog\fR [\-h] [\-n] [\-s] [\-e]
-git\-shortlog [\-n|\-\-numbered] [\-s|\-\-summary] [\-e|\-\-email] [<committish>\&...]
+git\-shortlog [\-n|\-\-numbered] [\-s|\-\-summary] [\-e|\-\-email] [\-w]
+             [<committish>\&...]
 .fi
 .SH "DESCRIPTION"
 Summarizes \fIgit log\fR output in a format suitable for inclusion in release announcements. Each commit will be grouped by author and the first line of the commit message will be shown.
@@ -32,6 +33,9 @@ Suppress commit description and provide a commit count summary only.
 .TP
 \-e, \-\-email
 Show the email address of each author.
+.TP
+\-w[<width>[,<indent1>[,<indent2>]]]
+Wrap printed output.
 .SH "FILES"
 If the file .mailmap exists, it will be used for mapping author email addresses to a real author name. One mapping per line, first the author name followed by the email address enclosed by \fI<\fR and \fI>\fR. Use hash \fI#\fR for comments. Example:
 .sp
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index bd795b1..e6a2865 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,7 +9,7 @@
 #include "shortlog.h"
 
 static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [<commit-id>... ]";
+"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
 
 static int compare_by_number(const void *a1, const void *a2)
 {

--Apple-Mail-9--82424844
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-9--82424844--
