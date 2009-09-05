From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 2/2] add 'scope' config option
Date: Sat, 5 Sep 2009 14:33:04 +0200
Message-ID: <20090905123304.GB3099@darc.dnsalias.org>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905072017.GA5152@coredump.intra.peff.net> <7v3a717rgl.fsf@alter.siamese.dyndns.org> <20090905123117.GA3099@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 14:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjuS9-0004dr-AE
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 14:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbZIEMdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 08:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757312AbZIEMdC
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 08:33:02 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:38552 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbZIEMdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 08:33:01 -0400
Received: by fxm17 with SMTP id 17so1171951fxm.37
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=0MYTf4/CJECSL/Q4NEDQ2P0JQkUHwd0iNydtLwZHHFk=;
        b=CiyUx9wgvQ9UnhhiBayU5dAAFcRWeaHjBcl8UTBwxvfAi7UxCoBhTWJ4+PBHPMzTJ1
         AC0ZYt2FiE+nP/5fFLaRflsx9zEiXiGovRSjD1VqQPm+4zIX5OV8ZYgI6JZlOfyV7XRD
         zGtpi48k+ZgAt9+1awNcxhPxYqBktxgVW9ONA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=OUxQlAWOmMa3czZueZFkMmdEEFBvK4ISzD7IdpRUwN974yv6nPVUqEO13lSF5IsWbl
         xSf69V/ksaxRmBmzQuWt43hd/J0erMMvhkqylyqkNAsm4dFf5oYRZWg7laN+HUUt4ixl
         pOKP5S64YF5OG2RhuD5appogsrJS1rULsdERE=
Received: by 10.86.228.16 with SMTP id a16mr6028141fgh.49.1252153982678;
        Sat, 05 Sep 2009 05:33:02 -0700 (PDT)
Received: from darc.lan (p549A2AE8.dip.t-dialin.net [84.154.42.232])
        by mx.google.com with ESMTPS id d4sm3890856fga.18.2009.09.05.05.33.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 05:33:02 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MjuS0-0006n8-Ez; Sat, 05 Sep 2009 14:33:04 +0200
Content-Disposition: inline
In-Reply-To: <20090905123117.GA3099@darc.dnsalias.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127811>

Documentation/config.txt says it all.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/config.txt |    6 ++++++
 builtin-add.c            |    2 +-
 builtin-grep.c           |    2 +-
 cache.h                  |    1 +
 config.c                 |    8 ++++++++
 environment.c            |    1 +
 6 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5256c7f..f587cf1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,12 @@ On some file system/operating system combinations, this is unreliable.
 Set this config setting to 'rename' there; However, This will remove the
 check that makes sure that existing object files will not get overwritten.
 
+core.scope::
+	By default, the commands 'git add -u', 'git add -A' and 'git grep'
+	are limited to files below the current working directory
+	(scope='workdir'). Set this variable to scope='global' to make these
+	commands act on the whole tree instead.
+
 add.ignore-errors::
 	Tells 'git-add' to continue adding files when some files cannot be
 	added due to indexing errors. Equivalent to the '--ignore-errors'
diff --git a/builtin-add.c b/builtin-add.c
index 006fd08..33ea3e4 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -285,7 +285,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
-	if ((addremove || take_worktree_changes) && !argc) {
+	if (!scope_global && (addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
 		argv = here;
diff --git a/builtin-grep.c b/builtin-grep.c
index f6af3d4..447b195 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -861,7 +861,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (i < argc)
 		paths = get_pathspec(prefix, argv + i);
-	else if (prefix) {
+	else if (!scope_global && prefix) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
 		paths[1] = NULL;
diff --git a/cache.h b/cache.h
index 5fad24c..85c5fee 100644
--- a/cache.h
+++ b/cache.h
@@ -523,6 +523,7 @@ extern int auto_crlf;
 extern int read_replace_refs;
 extern int fsync_object_files;
 extern int core_preload_index;
+extern int scope_global;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/config.c b/config.c
index e87edea..8dec019 100644
--- a/config.c
+++ b/config.c
@@ -503,6 +503,14 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.scope")) {
+		if (!strcasecmp(value, "global"))
+			scope_global = 1;
+		if (!strcasecmp(value, "worktree"))
+			scope_global = 0;
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5de6837..4d1c6e1 100644
--- a/environment.c
+++ b/environment.c
@@ -50,6 +50,7 @@ enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_replace_parents = 1;
+int scope_global = 0;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
-- 
1.6.4.2.264.g79b4f
