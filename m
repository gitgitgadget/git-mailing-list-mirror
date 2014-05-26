From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2] wording fixes in the user manual and glossary
Date: Mon, 26 May 2014 07:20:23 -0700
Message-ID: <1401114023-4015-1-git-send-email-jmmahler@gmail.com>
Cc: Ben Aveling <bena.001@optusnet.com.au>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 16:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wovlm-0001MD-1S
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 16:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbaEZOUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 10:20:50 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59354 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaEZOUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 10:20:49 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so7759200pbc.4
        for <git@vger.kernel.org>; Mon, 26 May 2014 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9TcBtJhOXvRTdi+I2M2HcpBv59FuKfY54098zkkLGJE=;
        b=I2CVZYjgEtsORe/A14w8es0PKTV2rL/CD5m6M7i/qeCw7xF6Mw16f4OmG6TsDGGpWp
         sHck1+ZeEkk31jq9f6YNBy0TjFECTGsjmcrbWFwLJ4Uj3wepcqR+Y/d9NMsGf4LpwB++
         k3Nzf98CVjpg5/2dkXGK0iyLtS6rJqYBGcNhMUfU5WEy1cPXVKMqhxtwI7fXs5XFfg/9
         swFI3iElUv50XVzEjKbbh0J1o+0YHI8aWIbkKng1q4g57tQGlEdzj/OS1dgiZZHldxFL
         bu/kyHEhsizFPbgeALGDPWNiBbojNmwzgmiHmlxeoXgEywi29uhgeIEHrBFL1yzJqQ2P
         zk6A==
X-Received: by 10.68.130.38 with SMTP id ob6mr27852858pbb.141.1401114049006;
        Mon, 26 May 2014 07:20:49 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fk4sm58979420pab.23.2014.05.26.07.20.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 07:20:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 07:20:44 -0700
X-Mailer: git-send-email 2.0.0.rc4.480.gad29d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250091>

Various minor wording fixes throughout the user manual
and glossary.

The section on "Updating a repository with git fetch" was
substantially re-worded to try and better explain `git fetch`.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    From the feedback I received by Chris Packham [1] it was clear
    that my re-wording of the section "Updating a repository with git fetch"
    still wasn't quite right [1].
    
    [1]: http://marc.info/?l=git&m=140100460903936&w=2
    
    I re-worded it some more to try and emphasize the remote (upstream)
    and local aspects of `git fetch`.  Chris liked those changes better [2].
    
    [2]: http://marc.info/?l=git&m=140109062903038&w=2
    
    I expanded upon this even further.  The section on git-pull is similar
    so I tried to use that as a basis.  I also thought the relationship between
    git fetch and git pull was worthy of a short note along with a link to
    the section on git-pull.

 Documentation/glossary-content.txt |  2 +-
 Documentation/user-manual.txt      | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index be0858c..4e0b971 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -1,7 +1,7 @@
 [[def_alternate_object_database]]alternate object database::
 	Via the alternates mechanism, a <<def_repository,repository>>
 	can inherit part of its <<def_object_database,object database>>
-	from another object database, which is called "alternate".
+	from another object database, which is called an "alternate".
 
 [[def_bare_repository]]bare repository::
 	A bare repository is normally an appropriately
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d33f884..f5fd61b 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -416,14 +416,22 @@ REVISIONS" section of linkgit:gitrevisions[7].
 Updating a repository with git fetch
 ------------------------------------
 
-Eventually the developer cloned from will do additional work in her
-repository, creating new commits and advancing the branches to point
-at the new commits.
+After you clone a repository and commit a few changes of your own, you
+may wish to check the original repository for updates.
+The linkgit:git-fetch[1] command is used to update all the remote-tracking
+branches to the latest version found in those repositories.
+It will not touch any of your own branches--not even the "master"
+branch that was created during clone.
+The linkgit:git-merge[1] command can then be used to merge the changes.
+
+-------------------------------------------------
+$ git fetch
+$ git merge origin/master
+-------------------------------------------------
 
-The command `git fetch`, with no arguments, will update all of the
-remote-tracking branches to the latest version found in her
-repository.  It will not touch any of your own branches--not even the
-"master" branch that was created for you on clone.
+The linkgit:git-pull[1] command,
+<<getting-updates-With-git-pull,discussed later>>,
+performs both of these steps, a fetch followed by a merge.
 
 [[fetching-branches]]
 Fetching branches from other repositories
@@ -1811,8 +1819,8 @@ manner.
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
 use the linkgit:git-send-email[1] script to automate the process.
-Consult the mailing list for your project first to determine how they
-prefer such patches be handled.
+Consult the mailing list for your project first to determine
+their requirements for submitting patches.
 
 [[importing-patches]]
 Importing patches to a project
@@ -2255,7 +2263,7 @@ $ git checkout test && git merge speed-up-spinlocks
 It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
 
-Some time later when enough time has passed and testing done, you can pull the
+Sometime later when enough time has passed and testing done, you can pull the
 same branch into the `release` tree ready to go upstream.  This is where you
 see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
-- 
2.0.0.rc4.480.gad29d77
