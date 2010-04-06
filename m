From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] Docs: Describe omitted <repository> behavior in a prominent
	place
Date: Tue, 6 Apr 2010 22:32:29 +0300
Message-ID: <4bbb8fa3.0f1abc0a.2383.7991@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 21:46:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzEjf-0003N6-WA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 21:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324Ab0DFTqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 15:46:50 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:62055 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659Ab0DFTqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 15:46:49 -0400
Received: by bwz1 with SMTP id 1so230131bwz.21
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:sender:from:to
         :date:subject;
        bh=sTEhsK35XfuNRtpfyEWUrOg8xzLYNuNJbz6ILh7NDKE=;
        b=ttQB32EwF1SH06wSH9qNT2YSw8726XVs3tSQRjR+W0ncYeWEjZbWApe2jPCC2c+dGD
         iOcSABhK/xUoRqhKcLpSp/9te9eGY4bRX3lfkpTYpwzoh6TCzmXFqBMtRYCDLBkmJxHD
         vzpKxz4u/F/Dw5RNnohb+LyCQw5EvkGRRNddg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        b=camT00T/FteA12eu5YyGufQpduKKXDljN3lFN8Ds9PEGR9DlGj55fa2xVgcSk1XHrg
         ZQL4UVXoJA8GVwqdTASHbGDJtbkvKSjIpAOFJ59PfRmbJlMeKWCbz+oPT6GViC8E5Cd7
         +IfECR8VDkoi3eHkrZ0tLMzeTyjtb0baIaGzE=
Received: by 10.204.36.199 with SMTP id u7mr8130688bkd.212.1270583206523;
        Tue, 06 Apr 2010 12:46:46 -0700 (PDT)
Received: from [127.0.1.1] (bzq-109-64-38-2.red.bezeqint.net [109.64.38.2])
        by mx.google.com with ESMTPS id 15sm6784123bwz.0.2010.04.06.12.46.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 12:46:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144167>

The documentation of which repository is pushed to when the repository
flag is omitted was only mentioned under the --repo flag.

It is now described under the <repository> argument.

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---
 Documentation/git-push.txt |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 59dc8b1..14d286e 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -31,6 +31,11 @@ OPTIONS[[OPTIONS]]
 	operation.  This parameter can be either a URL
 	(see the section <<URLS,GIT URLS>> below) or the name
 	of a remote (see the section <<REMOTES,REMOTES>> below).
++
+If omitted, 'git push' derives the remote name from the current
+branch: If it tracks a remote branch, then that remote repository
+is pushed to. Otherwise, the name "origin" is used. This can be
+overridden with the `--repo` option.
 
 <refspec>...::
 	The format of a <refspec> parameter is an optional plus
@@ -116,12 +121,10 @@ nor in any Push line of the corresponding remotes file---see below).
 
 --repo=<repository>::
 	This option is only relevant if no <repository> argument is
-	passed in the invocation. In this case, 'git push' derives the
-	remote name from the current branch: If it tracks a remote
-	branch, then that remote repository is pushed to. Otherwise,
-	the name "origin" is used. For this latter case, this option
-	can be used to override the name "origin". In other words,
-	the difference between these two commands
+	passed in the invocation, and the current branch does not track
+	a remote branch. For this case, this option can be used to 
+	override the name "origin". In other words, the difference
+	between these two commands
 +
 --------------------------
 git push public         #1
-- 
1.7.0
