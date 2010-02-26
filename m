From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 4/4] grep docs: document --no-index option
Date: Thu, 25 Feb 2010 22:40:13 -0500
Message-ID: <1267155613-22134-5-git-send-email-lodatom@gmail.com>
References: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 04:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkr7u-0002y4-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 04:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935134Ab0BZDo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 22:44:26 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:6003 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935131Ab0BZDoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 22:44:25 -0500
Received: by qw-out-2122.google.com with SMTP id 8so172630qwh.37
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 19:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7YvfwOBLOL2mMt46Mg0QOmBCQMeNquMIf4Q65yVnZZ8=;
        b=af+jBzCTPceq8+cmuvEb0SMtXkrJ0YfKjsD8zISsxVWUzRNw8bRkOPp00rsyJrwJgy
         oo+fJ2UTZ1d800+XO8w7DXzZtfXkFawKVd2donFbPMjlEIlvrJIBvgI0w78Yk4XSpDth
         V91OovB9v7hXDdNRPB+iiYb42NiS7fYEsRgu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q7OIxpOOABBiosz2nUcr+BPhD+mV9/hbrPchaRlrcOS+CjGY4aYd9Kifh2MT6jXGkg
         2knT3rvBzVWNGcIdbHZUD0qoQvpa7S7QgcwXaeuEk0pJBJXPYBEmG85IwjdPRmE7kR8q
         xcn3jEVphFvnLmwMukcqpvs9FgQARtYPKnnOA=
Received: by 10.224.99.67 with SMTP id t3mr165122qan.115.1267155417684;
        Thu, 25 Feb 2010 19:36:57 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1593622qyk.6.2010.02.25.19.36.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 19:36:57 -0800 (PST)
X-Mailer: git-send-email 1.7.0
In-Reply-To: <1267155613-22134-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141097>

Also clarify --cached and <tree>.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-grep.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 37ce943..86d7401 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -21,7 +21,7 @@ SYNOPSIS
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
-	   [--cached | <tree>...]
+	   [--cached | --no-index | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -33,8 +33,11 @@ registered in the index file, or blobs in given tree objects.
 OPTIONS
 -------
 --cached::
-	Instead of searching in the working tree files, check
-	the blobs registered in the index file.
+	Instead of searching tracked files in the working tree, search
+	blobs registered in the index file.
+
+--no-index::
+	Search all files in the working tree, not just those tracked by git.
 
 -a::
 --text::
@@ -164,7 +167,8 @@ OPTIONS
 	there is a match and with non-zero status when there isn't.
 
 <tree>...::
-	Search blobs in the trees for specified patterns.
+	Instead of searching tracked files in the working tree, search
+	blobs in the given trees.
 
 \--::
 	Signals the end of options; the rest of the parameters
-- 
1.7.0
