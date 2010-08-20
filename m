From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
Date: Fri, 20 Aug 2010 17:54:00 +0530
Message-ID: <1282307041-19681-4-git-send-email-artagnon@gmail.com>
References: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmQg7-0001lu-7N
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab0HTM0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:26:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41291 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab0HTM0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:26:10 -0400
Received: by pvg2 with SMTP id 2so1175337pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lO0RbXBs1ZjAaqLgq01si8wIUw3Kyle+620toYNZtUQ=;
        b=r5qZthAFxGJft+1gLrbgHQQMXZ3UpJpl4TjEjkANyZhUt//KIQXeOCv9QNgcNhRMoR
         OyeSqIuzafI/AIiwYiyplqmKEKXVJOOvLlr+RKqZctyAyzITJTbFwmZGi9VgyFjogZVi
         t6WvhH+TMqcwgPkPnThwpjLfkhTkFRZod5fqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kWdAfJnM2p/OZ7RWD2yi+CyVoxvpB31idoYb6G8gZYL0gCHKO7nOFIiY2n1spuQO9M
         8IpyLDvP8F7kdU5kyFNeCTdOItCmXvl6Fedr4Fy8/W61R5S8QyF32Pm6adOmd9A7kiKy
         l9dgUFgQDWdhNsUv4KZSdlA1icnZ5fWzsw4io=
Received: by 10.114.92.11 with SMTP id p11mr1486013wab.12.1282307169589;
        Fri, 20 Aug 2010 05:26:09 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4770439waa.21.2010.08.20.05.26.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:26:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1282307041-19681-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154018>

Update the documentation of fmt-merge-msg and merge-config to reflect
the fact that `merge.log` can either be a boolean or integer option
now, instead of just a boolean.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |   24 +++++++++---------------
 Documentation/merge-config.txt      |    8 ++++++--
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 302f56b..a930eeb 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log=<n>] < $GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log=<n>] -F <file>
 
 DESCRIPTION
 -----------
@@ -24,19 +24,10 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log=<n>::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
-
---no-log::
-	Do not list one-line descriptions from the actual commits being
-	merged.
-
---summary::
---no-summary::
-	Synonyms to --log and --no-log; these are deprecated and will be
-	removed in the future.
+	one-line descriptions from at most <n> actual commits that are
+	being merged.
 
 -m <message>::
 --message <message>::
@@ -53,7 +44,10 @@ CONFIGURATION
 
 merge.log::
 	Whether to include summaries of merged commits in newly
-	merge commit messages. False by default.
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message. Specifying "true" is equivalent
+	to specifying 20. Defaults to false.
 
 merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index b72f533..f63f7cb 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -7,8 +7,12 @@ merge.conflictstyle::
 	marker and the original text before the `=======` marker.
 
 merge.log::
-	Whether to include summaries of merged commits in newly created
-	merge commit messages. False by default.
+	Whether to include summaries of merged commits in newly
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message. Specifying "true" is equivalent
+	to specifying 20.  Defaults to false. See also
+	linkgit:git-fmt-merge-msg[1].
 
 merge.renameLimit::
 	The number of files to consider when performing rename detection
-- 
1.7.1
