From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Wed, 20 May 2015 16:11:57 -0700
Message-ID: <1432163517-22785-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>, pasky@suse.cz,
	hvoigt@hvoigt.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 21 01:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvD9q-0002sE-6L
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 01:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbbETXMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 19:12:09 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37672 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbETXMH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 19:12:07 -0400
Received: by igbsb11 with SMTP id sb11so52156765igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 16:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eWn0SpLdGycYucENSO2Tbm6I7BIVxHcerQTn1r5lQpg=;
        b=JlQTDnF998JgBoVcm9XGAP76rBraomVXsWUY7aezjCsh97S0KTqFsOc8PqliBAqs7k
         2SH2QXlRXNVk0cKCJavfCDixVajlENOi7TlzEgL2QCFf7I1Ai3s9eRELvwAhKhsz8evs
         bE7qot985nmHcCm+J0tupVnHBrO9QPwOlGPRwMamK5fo17Wec0CqiRaCavsV9snEq0jj
         HvG9QlOrzplxdCrPTRo2YIq3ftLovZZDgKSr2KL9EgS7Hn5Mqr+L4+l6AB39eH+ZoNMA
         IKTIp5YVIwN8cpUkemoLLVOKGvl3A67grk2ta5GD+ypmx7uNo9UbH7qYp1gLUAQhGOOf
         6zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eWn0SpLdGycYucENSO2Tbm6I7BIVxHcerQTn1r5lQpg=;
        b=YsEiK8bxpDIhZtc1TIwWMswtDQRjCm0PUcyDIvFKyUXHgB53I4pmEkqmsBWEdGRFL3
         A3n39UftKuIuwEtW5qiFOsQ0yMUc6oXV6MacpUgLayK3GcJ2clicWzGhwQZChJLYj7ju
         8Y5VtRIeu8LHZGUVqpSEl+O6Vv3SJ5zOq7ya/FQsxQuPpPZVhacSYT2EoNM8dYMy0XWZ
         RlnuUgs12qkCjIQBdlVUFFmRkrG8vcpLQljBL27DyzWRh2cCJQqpN4SFMhV5t5FyHP+y
         eGPWkK475sovBhRtcEik+StlJMKcw/062pM1scKEsgIMXPUgbXpkqpwLKhinRM1U9VD4
         b74g==
X-Gm-Message-State: ALoCoQk5XDbx3i2hIvFeyfjnM9QlBBDUm7Wy6CJ4zFQm2Kiknmw/a0BNWMuyYAJJhADkf8ag/q6f
X-Received: by 10.42.175.198 with SMTP id bb6mr233639icb.53.1432163526369;
        Wed, 20 May 2015 16:12:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7985:51a0:3d7b:e3ba])
        by mx.google.com with ESMTPSA id c20sm13442902ioc.40.2015.05.20.16.12.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 16:12:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.194.gc518059
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269534>

It's better to start the man page with a description of what submodules
actually are instead of saying what they are not.

Reorder the paragraphs such that
the first short paragraph introduces the submodule concept,
the second paragraph highlights the usage of the submodule command,
the third paragraph giving background information,
and finally the fourth paragraph discusing alternatives such
as subtrees and remotes, which we don't want to be confused with.

This ordering deepens the knowledge on submodules with each paragraph.
First the basic questions like "How/what" will be answered, while the
underlying concepts will be taught at a later time.

Making sure it is not confused with subtrees and remotes is not really
enhancing knowledge of submodules itself, but rather painting the big
picture of git concepts, so you could also argue to have it as the second
paragraph. Personally I think this may confuse readers, specially newcomers
though.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-submodule.txt | 54 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c25916..6c38c0d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -25,35 +25,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Submodules allow foreign repositories to be embedded within
-a dedicated subdirectory of the source tree, always pointed
-at a particular commit.
+Submodules allow other repositories to be embedded within
+a dedicated subdirectory of the source tree pointing
+at a particular commit in the other repository.
 
-They are not to be confused with remotes, which are meant mainly
-for branches of the same project; submodules are meant for
-different projects you would like to make part of your source tree,
-while the history of the two projects still stays completely
-independent and you cannot modify the contents of the submodule
-from within the main project.
-If you want to merge the project histories and want to treat the
-aggregated whole as a single project from then on, you may want to
-add a remote for the other project and use the 'subtree' merge strategy,
-instead of treating the other project as a submodule. Directories
-that come from both projects can be cloned and checked out as a whole
-if you choose to go that route.
-
-Submodules are composed from a so-called `gitlink` tree entry
-in the main repository that refers to a particular commit object
-within the inner repository that is completely separate.
-A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
-root of the source tree assigns a logical name to the submodule and
-describes the default URL the submodule shall be cloned from.
-The logical name can be used for overriding this URL within your
-local repository configuration (see 'submodule init').
-
-This command will manage the tree entries and contents of the
-gitmodules file for you, as well as inspect the status of your
-submodules and update them.
+This command will manage the submodules for you, as well as
+inspect the status of your submodules and update them.
 When adding a new submodule to the tree, the 'add' subcommand
 is to be used.  However, when pulling a tree containing submodules,
 these will not be checked out by default;
@@ -64,6 +41,27 @@ using the 'status' subcommand and get a detailed overview of the
 difference between the index and checkouts using the 'summary'
 subcommand.
 
+Submodules are composed from a so-called `gitlink` tree entry
+in the main repository that refers to a particular commit object
+within the inner repository that is completely separate.
+A record in the `.gitmodules` (see linkgit:gitmodules[5]) file at the
+root of the source tree assigns a logical name to the submodule and
+describes the default URL the submodule shall be cloned from.
+The logical name can be used for overriding this URL within your
+local repository configuration (see 'submodule init').
+
+Submodules are not to be confused with remotes, which are meant
+mainly for branches of the same project; submodules are meant for
+different projects you would like to make part of your source tree,
+while the history of the two projects still stays completely
+independent and you cannot modify the contents of the submodule
+from within the main project.
+If you want to merge the project histories and want to treat the
+aggregated whole as a single project from then on, you may want to
+add a remote for the other project and use the 'subtree' merge strategy,
+instead of treating the other project as a submodule. Directories
+that come from both projects can be cloned and checked out as a whole
+if you choose to go that route.
 
 COMMANDS
 --------
-- 
2.4.0.194.gc518059
