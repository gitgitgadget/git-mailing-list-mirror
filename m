From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 try2] build: add default aliases
Date: Sat, 12 Oct 2013 02:04:42 -0500
Message-ID: <1381561482-20208-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLf-0003nP-Cg
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab3JLHKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:46 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43414 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab3JLHKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:43 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3437354obc.37
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OYTWsNb0/NzspmG3ZzlcL6gXwVeGf9JtR4pEmXz/hqA=;
        b=NfEsJdC0EIBJSf9w+oGrUywHcU0RoWO97Y7TtaixgGE9ET82hesp+Klk0XTBD/Mq7e
         jjS1fi4xHFE5VvsQYiFL6ouaBy1H2z3sdoFkl+XEAgHRkFIMbPWxUQpZcfVnSZclVJBS
         BocaDBmO1ac0/E1kAxEWPekhgTVqL3KgiIMBuRRxVUqjAwE4Ppz9b3RVCVkPI7LWdM8n
         UJ3GaEtRoI+/5YFkJZRE4+QTRiu5cmtv/uFj6MPulQ5nge3gvlfqXOah0ObmbwYWHwPF
         qXS0Il8Ci8opfm8cj2aucuwSvL+ekBz+UZ5qjUw2BA0eLmDTEyt6H7M4FAHkQ+6EG/m0
         uK4Q==
X-Received: by 10.182.181.34 with SMTP id dt2mr17460648obc.30.1381561843346;
        Sat, 12 Oct 2013 00:10:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u3sm101372862oeq.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235961>

For now simply add a few common aliases.

  co = checkout
  ci = commit
  rb = rebase
  st = status

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-checkout.txt | 5 +++++
 Documentation/git-commit.txt   | 5 +++++
 Documentation/git-rebase.txt   | 5 +++++
 Documentation/git-status.txt   | 5 +++++
 config.c                       | 5 +++++
 5 files changed, 25 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ca118ac..7597813 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -14,6 +14,11 @@ SYNOPSIS
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
 
+ALIAS
+-----
+
+git co
+
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 1a7616c..8705abc 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -15,6 +15,11 @@ SYNOPSIS
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
 
+ALIAS
+-----
+
+git ci
+
 DESCRIPTION
 -----------
 Stores the current contents of the index in a new commit along
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6b2e1c8..bb18fea 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -14,6 +14,11 @@ SYNOPSIS
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --edit-todo
 
+ALIAS
+-----
+
+git rb
+
 DESCRIPTION
 -----------
 If <branch> is specified, 'git rebase' will perform an automatic
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 9046df9..30ecd25 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -11,6 +11,11 @@ SYNOPSIS
 [verse]
 'git status' [<options>...] [--] [<pathspec>...]
 
+ALIAS
+-----
+
+git st
+
 DESCRIPTION
 -----------
 Displays paths that have differences between the index file and the
diff --git a/config.c b/config.c
index e13a7b6..be724b2 100644
--- a/config.c
+++ b/config.c
@@ -1082,6 +1082,11 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	home_config_paths(&user_config, &xdg_config, "config");
 
+	ret += fn("alias.ci", "commit", data);
+	ret += fn("alias.co", "checkout", data);
+	ret += fn("alias.rb", "rebase", data);
+	ret += fn("alias.st", "status", data);
+
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0)) {
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
 					    data);
-- 
1.8.4-fc
