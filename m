From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 3/4] grep docs: --cached and <tree>... are incompatible
Date: Thu, 25 Feb 2010 22:40:12 -0500
Message-ID: <1267155613-22134-4-git-send-email-lodatom@gmail.com>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkr7i-0002u8-2A
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935130Ab0BZDoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:44:12 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:6003 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935082Ab0BZDoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:44:11 -0500
Received: by qw-out-2122.google.com with SMTP id 8so172630qwh.37
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=c67+TSMZvdvB/fMEApaOzZzQJjD09lDYkQPWr7w8T68=;
        b=WbAzthvqu6pNgVMXGdJ7OXWTIY4xUEvoxZqQbZQj45OAPEZZT8SxI/YbTlBnZ1oADT
         JId2Eb9mrUK1w0GruhwCQf3clteLDtNs9kO9Pi1B/C+esp2BroDHygrxoPIjfdp3J4Yl
         i1nhHy2E0rssWVyBcPlMbsIsq2+wa0hV1rdrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=V6JMO01OysNZa+kHMzPUt4l3/kwxqMi4Dwjj1amXW5w1Ze2URxbJJL2SkRQrNE4yvM
         AnC2Xwg6gA0ma7nfZX1E2FQQdNX+BkHv/2TevEc0YT65jolTngSw6uOnBcH/6FoaY2Im
         jQvcNIT7426v5w4OIDF+V/e5VXLo6rmq2F9Rk=
Received: by 10.224.52.132 with SMTP id i4mr211821qag.37.1267155416331;
        Thu, 25 Feb 2010 19:36:56 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1593622qyk.6.2010.02.25.19.36.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:36:55 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141096>

In the synopsis for git-grep(1), show that --cached and <tree>... cannot
be used together.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
One downside to this change is that having --cached makes it prominent, which
is good since it's a very common option.  However, I think accuracy is more
important here.

 Documentation/git-grep.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2e16130..37ce943 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -9,8 +9,7 @@ git-grep - Print lines matching a pattern
 SYNOPSIS
 --------
 [verse]
-'git grep' [--cached]
-	   [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
+'git grep' [-a | --text] [-I] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-F | --fixed-strings] [-n]
@@ -21,7 +20,8 @@ SYNOPSIS
 	   [--color | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
-	   [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
+	   [--and|--or|--not|(|)|-e <pattern>...]
+	   [--cached | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
-- 
1.7.0
