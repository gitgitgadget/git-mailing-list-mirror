From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] t9200: On MSYS, do not pass Windows-style paths to CVS
Date: Wed, 11 Jan 2012 10:20:14 +0100
Message-ID: <4F0D544E.6010105@gmail.com>
References: <4F0D5367.1000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jan 11 10:20:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkuMC-0005fS-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 10:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757337Ab2AKJUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 04:20:21 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53255 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755599Ab2AKJUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 04:20:17 -0500
Received: by bkvi17 with SMTP id i17so351168bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 01:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=U3hP9f3r/ymZTFED1Iipk6DoDZV+nPkTmL9nQGJatFk=;
        b=xKk2g6xX2IauQIuAVrYjg7V5cNQhKxcyWqAhTHMRzrH7voiauOdnkOlJlHRWzQmebI
         ymLxwGnRLhBxcdhvl5wQG4bOY29UVHAOAbM54UfSu4qklPdMiSEr5rl/BSPKuT9Av+fU
         r0JAw3UC8bZVjg0Ym7m15FNihI/f1E85Ws7IU=
Received: by 10.205.127.65 with SMTP id gz1mr10189612bkc.12.1326273616121;
        Wed, 11 Jan 2012 01:20:16 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id jt2sm1988553bkb.1.2012.01.11.01.20.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 01:20:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.msysgit,gmane.comp.version-control.git
In-Reply-To: <4F0D5367.1000506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188346>

For details, see the commit message of 4114156ae9. Note that while using
$PWD as part of GIT_DIR is not required here, it does no harm and it is
more consistent. In addition, on MSYS using an environment variable should
be slightly faster than spawning an external executable.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 41db05c..518358a 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -19,9 +19,9 @@ then
     test_done
 fi
 
-CVSROOT=$(pwd)/cvsroot
-CVSWORK=$(pwd)/cvswork
-GIT_DIR=$(pwd)/.git
+CVSROOT=$PWD/cvsroot
+CVSWORK=$PWD/cvswork
+GIT_DIR=$PWD/.git
 export CVSROOT CVSWORK GIT_DIR
 
 rm -rf "$CVSROOT" "$CVSWORK"
-- 
1.7.9.rc0.5096.g30a61
