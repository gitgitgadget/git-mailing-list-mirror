From: Marco Costalba <mcostalba@gmail.com>
Subject: [PATCH QGit] Fix "Save patch..." when selected directory name has 
	spaces
Date: Wed, 17 Jun 2009 12:00:11 +0200
Message-ID: <e5bfff550906170300r34000049o50ab107071cb7b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Markus Heidelberg <markus.heidelberg@web.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:00:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGrwO-0005v6-7U
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 12:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759187AbZFQKAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760346AbZFQKAM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 06:00:12 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:44726 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187AbZFQKAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 06:00:10 -0400
Received: by ewy6 with SMTP id 6so327195ewy.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=lQ69TxlTtzAK9XTAtdaGqWnuws/piyIPw17jCEc6SrI=;
        b=dWceGSMERBTZsAVs9dEDEUcwvRGnK9c/G8UIfL++kwk8u6plQ1M+Fdpz4Nj1yo5HhA
         8neHwDggx5q/LbB7RzBU4m0AzL0YXI7cysOhOJVSB2wXyl44xB+y1AHx38B3b4eAUbp9
         vVfKi3r5cMt0jkDC4KAL5lnfO3U9Umi02Y1yE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TOd5ZtM+/3x9fMSxWIt/P9CZRpo9uAm8dFDaxrKcw2wUB40KiPQoEsrH6+8oy1jy8h
         bpIUhsfU9K8zZ3PWsYZcWi03RYiR5IrHTz1eeXpMjofod2TtQbAqJ0jvFe84jPM8aI80
         si62XVWXfzJqS2y3ZfFkX1jfMuvByt+PSbN5Q=
Received: by 10.216.30.206 with SMTP id k56mr3131897wea.86.1245232811427; Wed, 
	17 Jun 2009 03:00:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121731>

Bug spotted by Markus Heidelberg.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 src/git.cpp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/git.cpp b/src/git.cpp
index 357383d..bf1a9d5 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -1569,7 +1569,7 @@ bool Git::formatPatch(SCList shaList, SCRef
dirPath, SCRef remoteDir) {
 	if (remote)
 		runCmd.append(" --keep-subject");

-	runCmd.append(" -o " + dirPath);
+	runCmd.append(" -o " + quote(dirPath));
 	if (!FPOpt.isEmpty())
 		runCmd.append(" " + FPOpt.trimmed());

-- 
1.6.1.9.g97c34
