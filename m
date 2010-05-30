From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation/checkout: clarify description
Date: Sun, 30 May 2010 03:41:53 -0500
Message-ID: <20100530084153.GA5447@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 30 10:41:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIe5M-00076z-8n
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 10:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab0E3Il1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 04:41:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54292 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0E3IlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 04:41:25 -0400
Received: by iwn6 with SMTP id 6so305591iwn.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ApTQeWa71FPBKwc3YeiyC556mkjLWQz4ugJbwiWd/qM=;
        b=IXCLblBr02ZM86YbXLO7eaRzcimzq34JgHvbFmqB5k9ukPe73hAOJTVaJTPj6cpK7q
         ewtWzKDlK8s6ZE0zyTNMvN+klQ2eQXBXwlEOMqtxN6TTeZYGsU4tfPs0SbkWB2xkUc6a
         xBqHSxPouO90tfawJ7W15kDMjC/iHLvKyP+WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=kUwAYuq24bWYeFdL8LyxMzvt34dl2s8APDruhtMkg79EHUlOxGiOu8QE5qZsbLMGfV
         vy109qmixVI8QLyffSzkY+M01QDpdHEedyCYkCbsI0+5IF7uJWYeTKalJ0P5r54mWP9r
         nOsts4gOufbkEoyMFUZfBPWVJfTi0dXvD2T9M=
Received: by 10.231.154.202 with SMTP id p10mr3657221ibw.31.1275208881174;
        Sun, 30 May 2010 01:41:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm20151883ibg.15.2010.05.30.01.41.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 01:41:20 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147989>

To the first-time reader, it may not be obvious that =E2=80=98git check=
out=E2=80=99
has two modes, nor that if no branch is specified it will read
from the index.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks to neha_ from IRC for pointing this out.

 Documentation/git-checkout.txt |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 4505eb6..99bd7f2 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -15,26 +15,32 @@ SYNOPSIS
=20
 DESCRIPTION
 -----------
+Retrieves files from the index or specified tree and writes them
+to the working tree.
=20
-When <paths> are not given, this command switches branches by
-updating the index, working tree, and HEAD to reflect the specified
-branch.
+'git checkout' [-b <new branch>] [<branch>]::
=20
+	When <paths> are not given, this command switches branches by
+	updating the index, working tree, and HEAD to reflect the
+	specified branch.
++
 If `-b` is given, a new branch is created and checked out, as if
 linkgit:git-branch[1] were called; in this case you can
 use the --track or --no-track options, which will be passed to `git
 branch`.  As a convenience, --track without `-b` implies branch
 creation; see the description of --track below.
=20
-When <paths> or --patch are given, this command does *not* switch
-branches.  It updates the named paths in the working tree from
-the index file, or from a named <tree-ish> (most often a commit).  In
-this case, the `-b` and `--track` options are meaningless and giving
-either of them results in an error. The <tree-ish> argument can be
-used to specify a specific tree-ish (i.e. commit, tag or tree)
-to update the index for the given paths before updating the
-working tree.
+'git checkout' [--patch] [<tree-ish>] [--] [<pathspec>...]::
=20
+	When <paths> or --patch are given, this command does *not* switch
+	branches.  It updates the named paths in the working tree from
+	the index file, or from a named <tree-ish> (most often a commit).  In
+	this case, the `-b` and `--track` options are meaningless and giving
+	either of them results in an error. The <tree-ish> argument can be
+	used to specify a specific tree-ish (i.e. commit, tag or tree)
+	to update the index for the given paths before updating the
+	working tree.
++
 The index may contain unmerged entries after a failed merge.  By
 default, if you try to check out such an entry from the index, the
 checkout operation will fail and nothing will be checked out.
--=20
1.7.1
