From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] build: add default aliases
Date: Sat, 21 Sep 2013 14:20:21 -0500
Message-ID: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
Cc: David Aguilar <davvid@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 21:25:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSoW-00083r-So
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 21:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3IUTZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 15:25:53 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:55788 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3IUTZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 15:25:52 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so2142158obc.11
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7Q759UipsTshwKQ6ZVyspSCVoOX6s3JKjNy7gNx+3FA=;
        b=zcdr7o5issvVfBD5V9CTI9BTS6O8FG7zUy2u4aHkrDUtWRsamscSnk/2T9wz3UoZ2g
         hXcJLZdlt+7Fp15LxpVO2m1Me5PI+elzdCNTuG+sImwQ3ohsHAsnPs8nQN2we5Jrx32H
         ryEcbjoJlz5u3bIOEBd7E74Y00OTmg9M62y4RgPJpFuWeefgtI2xV4tVNmpV9JMiMc67
         T8cj67Wv44g/X5/DFKh+SBbR4mnMn1E3g14tFFsaFeDwqZtIbOykqE85EGSSC/tmI34x
         zYZX9UzDr0/i4PNVESpHpVArtF8uv3sZlDdtWxwpzcu9xEbT6fzMoY/s8IZbVmkBzTCa
         vtRg==
X-Received: by 10.182.22.226 with SMTP id h2mr11832418obf.8.1379791551944;
        Sat, 21 Sep 2013 12:25:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm8651054obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 12:25:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235145>

For now simply add a few common aliases.

  co = checkout
  ci = commit
  rb = rebase
  st = status

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I still think we should ship a default /etc/gitconfig, but the project needs to
agree it's a good change, and nobody every agrees changes are good. So this is
the minimal change that achieves the desired result.

 Documentation/git-checkout.txt |  5 +++++
 Documentation/git-commit.txt   |  5 +++++
 Documentation/git-rebase.txt   |  5 +++++
 Documentation/git-status.txt   |  5 +++++
 alias.c                        | 17 +++++++++++++++++
 5 files changed, 37 insertions(+)

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
diff --git a/alias.c b/alias.c
index eb9f08b..d6bad69 100644
--- a/alias.c
+++ b/alias.c
@@ -14,11 +14,28 @@ static int alias_lookup_cb(const char *k, const char *v, void *cb)
 	return 0;
 }
 
+static struct {
+	const char *key;
+	const char *val;
+} default_aliases[] = {
+	{ "co", "checkout" },
+	{ "ci", "checkout" },
+	{ "rb", "rebase" },
+	{ "st", "status" },
+};
+
 char *alias_lookup(const char *alias)
 {
+	int i;
 	alias_key = alias;
 	alias_val = NULL;
 	git_config(alias_lookup_cb, NULL);
+	if (alias_val)
+		return alias_val;
+	for (i = 0; i < ARRAY_SIZE(default_aliases); i++) {
+		if (!strcmp(alias, default_aliases[i].key))
+			return xstrdup(default_aliases[i].val);
+	}
 	return alias_val;
 }
 
-- 
1.8.4-fc
