From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 21/28] rebase: trivial cleanup
Date: Fri, 30 Aug 2013 00:56:15 -0500
Message-ID: <1377842182-18724-22-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmc-0007iQ-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab3H3GB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:56 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:62918 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:54 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so1767724oah.20
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u+QdB0Z/0UR8F8DGUOu70R6tSdaLK923PHKbIS/BRaU=;
        b=KK7ST/MeujIFMHHJqpbOSP6rnrxYDl2e8bfXOsDRV9JC4D5TuYR/Tf/itDV3xBuZUy
         E07PxfjwRPHXovU/RZla39DZtzvvgI49o6Xq5ywKaIsN5EyrWFX+lCrx44DEhuidvvtg
         EHQZYNRhDkrv1ICAe/XdKW335mYoX0b7z28K92oeXZrroGTvXVdhXW8cfzGJTmFQUYfR
         UZinqFJQ3niwG6hXDvGbjGV1PBtuqG2BS8XgC+qc8XP1df7MBkmn1HXKhguNLuF0dc7D
         RHJjpivgIe/V+UpqDwf7ES1RycyXOOn+J5my9o418WiDyITGXHOHOxGVkIn4dAGWs0DK
         RJlQ==
X-Received: by 10.60.44.193 with SMTP id g1mr5558147oem.47.1377842513938;
        Thu, 29 Aug 2013 23:01:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm36954515oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233420>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--am.sh | 1 +
 git-rebase.sh     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index aae6a85..d6a434c 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -51,6 +51,7 @@ ret=0
 		return $?
 	fi
 
+	test -n "$GIT_QUIET" && git_am_opt="$git_am_opt -q"
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 	ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index db2ea8d..ebe87a3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -284,7 +284,6 @@ do
 		;;
 	-q)
 		GIT_QUIET=t
-		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-- 
1.8.4-fc
