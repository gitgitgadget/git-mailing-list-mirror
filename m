From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule documentation: Reorder introductory paragraphs
Date: Fri, 22 May 2015 12:38:47 -0700
Message-ID: <1432323527-26868-1-git-send-email-sbeller@google.com>
Cc: philipoakley@iee.org, jrnieder@gmail.com, git@vger.kernel.org,
	hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 22 21:38:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvsmX-0004tb-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 21:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225AbbEVTiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 15:38:52 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36782 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757104AbbEVTiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 15:38:51 -0400
Received: by igbpi8 with SMTP id pi8so43687202igb.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VEDI1bjKiEGY9gWzMhjaDYjlPfOy+yBG/J+hvmWf3z0=;
        b=hId7FWZ0TZROLGkjWco54xJiJq+ayV02KRRV7Q1gYiXAle3b/KxXPz5Bki9QiPkJIJ
         ns+QcoHTNxBRL7KnxPfdvKE9yodOWgVjqXFKxIwiWLz0ZCY6D3dt94RWw2kQ7vIVRmWj
         f8+XQ0mWfrPDc2gvCZawOHxU6m7maVA+3Oxsvjm5UGOECFIwxc8GpAE2lftybkOjNGMu
         YqVXnbzFSmtU9Rj+GOIZmI/7na+72LbEkrsespHrzREDrl605sMdhJPRKdpxb+va0s9R
         bBZuOI8CYwDgHW0n225Xq9FWpCU4hV+FDof0L04+e8V0s6xKX3DU55C3bwJGQYTI3jk+
         Wmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VEDI1bjKiEGY9gWzMhjaDYjlPfOy+yBG/J+hvmWf3z0=;
        b=HfE6eXYY+q/QrjYnuHqfXg5aGI8LhyKVlOY+mr0hPe9rIGBL952P3BlrnhZmgeUjiX
         QJQWDwuOAfOPa/ZH/3cmR36OOMSprklpUHqfKMGte/6aUS5vHgKB0G4RQnwI2O8mkrX/
         +aw1AfO2RFJE8ouxuiJHQeBKdh7YZM7g1CTpHKvmEF79pQsxtJliljqIqFpJAppu6ajd
         cg324pbnFxYNvOnL6FoElI1Xj7BqYzjfNSM+k/1w35W51yEVwNYyt/TjEpYBIFkS6NIg
         uYPlVxM2iEmlkC4p4t4zcoIgRqz/NvvL3W+X8NlGkHg4Hu/YznE/HOcjlIBX0CTa6LPs
         WIjg==
X-Gm-Message-State: ALoCoQnyxanP2WkV29/yv4RSqOxC4y6/oDLAC3bDpfK0s4MBr8qAEeDcqWcdQZnOPR0SucFpTRni
X-Received: by 10.107.12.34 with SMTP id w34mr9276756ioi.10.1432323530735;
        Fri, 22 May 2015 12:38:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:607c:a992:c63c:57f3])
        by mx.google.com with ESMTPSA id h33sm2473655iod.12.2015.05.22.12.38.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 12:38:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.233.g3f9b614.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269751>

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
paragraph. Personally I think this may confuse readers, specially
newcomers though.

Additionally to reordering the paragraphs, they have been slightly
reworded.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

For now I used a part of Junios suggestion
    Submodules are not to be confused with remotes, which are other
    repositories of the same project;
    
I like the "are not to be confused" part, as they warn the reader
that there will be a paragraph not as concise but touching other
commands and topics.

 Documentation/git-submodule.txt | 50 ++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c25916..d126c86 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -25,22 +25,17 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Submodules allow foreign repositories to be embedded within
-a dedicated subdirectory of the source tree, always pointed
-at a particular commit.
+This command will inspect, update and manage submodules.
 
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
+Submodules allow you to keep another Git repository in a subdirectory
+of your repository. The other repository has its own history, which does not
+interfere with the history of the current repository. This can be used to
+have external dependencies such as libraries for example.
+
+When cloning or pulling a repository containing submodules however,
+these will not be checked out by default; the 'init' and 'update'
+subcommands will maintain submodules checked out and at
+appropriate revision in your working tree.
 
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
@@ -51,19 +46,18 @@ describes the default URL the submodule shall be cloned from.
 The logical name can be used for overriding this URL within your
 local repository configuration (see 'submodule init').
 
-This command will manage the tree entries and contents of the
-gitmodules file for you, as well as inspect the status of your
-submodules and update them.
-When adding a new submodule to the tree, the 'add' subcommand
-is to be used.  However, when pulling a tree containing submodules,
-these will not be checked out by default;
-the 'init' and 'update' subcommands will maintain submodules
-checked out and at appropriate revision in your working tree.
-You can briefly inspect the up-to-date status of your submodules
-using the 'status' subcommand and get a detailed overview of the
-difference between the index and checkouts using the 'summary'
-subcommand.
-
+Submodules are not to be confused with remotes, which are other
+repositories of the same project; submodules are meant for
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
2.4.1.233.g3f9b614.dirty
