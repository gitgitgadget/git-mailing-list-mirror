From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 4/4] contrib/subtree: update documentation
Date: Tue, 12 Feb 2013 23:24:20 +0000
Message-ID: <CALeLG_k2diZ9WdE5Mpwv7u2_wd0vp2o1vrbFwDzXyeg+x5gtzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "David A. Greene" <greened@obbligato.org>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 00:24:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5PDR-0006Yc-8y
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 00:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863Ab3BLXYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 18:24:21 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42032 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab3BLXYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 18:24:21 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so679897obb.3
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 15:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=bTMnGhAd93jONWYkUIq10Wn9NKsBr0RMkrZeNltn0M8=;
        b=XxEfN1TofvArsfFjPe8XFo9ZW2bIaduxTH0CXTt6pwMDpPUhKuD5y6jmLHqZBRPi1e
         Q29tKLbAr/RnjcKPE5duQaKOglrQCSVaL+LUnJrTnmc/jWc2fu7yM/7rHRFB1GUyuxvR
         BFMBH46/L1inf/lPLBZ+mqRFGUQf7Cs8ovV/q0/zflXjvVgQ/RCvU1iD2+1vqLkReKfh
         x4kCGouAs9lscHXtMWdUWf7/wkbjGDTkGPdiryNKfj0DoerI7JGu3BKS8kQG8QrZyllK
         yy6Fdyz/RpE4UbC+Ud+x6Hsjxerl0a9BXu0yXGEg0DhEdRqIoGhpLTdn2WtZLWcSG9gn
         uhow==
X-Received: by 10.182.217.10 with SMTP id ou10mr14893189obc.30.1360711460607;
 Tue, 12 Feb 2013 15:24:20 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Tue, 12 Feb 2013 15:24:20 -0800 (PST)
X-Originating-IP: [2.102.85.14]
X-Gm-Message-State: ALoCoQmSQPO+oAgfxJ3U2BLdXGQDoaOpztenEW5b2biOFr0eS1KCqYZy+2iQr9YGme7JhuGyFjY9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216226>

>From 483a644fb40d14f2209116c45c1cb6beab11a181 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Tue, 12 Feb 2013 00:07:26 +0000
Subject: [PATCH 4/4] contrib/subtree: update documentation

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c5bce41..67dea3f 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git subtree' add   -P <prefix> <commit>
-'git subtree' pull  -P <prefix> <repository> <refspec...>
-'git subtree' push  -P <prefix> <repository> <refspec...>
+'git subtree' pull  -P <prefix> [<repository> <refspec...>]
+'git subtree' push  -P <prefix> [<repository> <refspec...>]
 'git subtree' merge -P <prefix> <commit>
 'git subtree' split -P <prefix> [OPTIONS] [<commit>]

@@ -71,7 +71,9 @@ add::
 	A new commit is created	automatically, joining the imported
 	project's history with your own.  With '--squash', imports
 	only a single commit from the subproject, rather than its
-	entire history.
+	entire history. Details of the <prefix> are added to the
+	.gitsubtree file, where they will be used as defaults for
+	'push' and 'pull'.

 merge::
 	Merge recent changes up to <commit> into the <prefix>
@@ -90,13 +92,16 @@ merge::
 pull::
 	Exactly like 'merge', but parallels 'git pull' in that
 	it fetches the given commit from the specified remote
-	repository.
+	repository. Default values for <repository> and <refspec>
+	are taken from the .gitsubtree file.
 	
 push::
 	Does a 'split' (see below) using the <prefix> supplied
 	and then does a 'git push' to push the result to the
 	repository and refspec. This can be used to push your
 	subtree to different branches of the remote repository.
+	Default values for <repository> and <refspec> are taken
+	from the .gitsubtree file.

 split::
 	Extract a new, synthetic project history from the
-- 
1.8.1.3.566.gaa39828
