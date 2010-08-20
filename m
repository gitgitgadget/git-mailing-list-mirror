From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 4/4] fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
Date: Fri, 20 Aug 2010 22:24:52 +0530
Message-ID: <1282323292-11412-5-git-send-email-artagnon@gmail.com>
References: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmUuO-0004cf-KE
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab0HTQ5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:57:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53675 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab0HTQ5U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:57:20 -0400
Received: by mail-gy0-f174.google.com with SMTP id 8so1331630gyd.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8nxx7sgDQaAtgCi9iitp3J/16TR+2l7NgQVFBB05qTw=;
        b=JhPnDo1H0OskxnscmQfw4xi7veR6gs+PInouJKRzc+UACbGoZKBLmSA8GU8Vtgebqn
         smbGW52bJOXAVZnEU36MyRQ16mzzm4mycdxnbhBHIDC9/gsvKretAbdH2VO/suwso+Dw
         VvpTPywaDAiPmNaZRDJO0F0JvM5/BrFuyn4BA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JXqf5oGvs6uB86/A3d3z9hfdRe2/UZAeVjj0qpWfVlovzCTkAib0Mm3BFxcI4yAy6j
         NEapa32BnUNb5l1UAV9Wq8SPccTOzutqSpfa+34sE54Ie4wCDjaNcGCKVISPnSQLY1qd
         iIO6JVLCshaSQ4MtXFkE9q2PYwjIF1aP+XbJ0=
Received: by 10.101.180.20 with SMTP id h20mr1873987anp.223.1282323440427;
        Fri, 20 Aug 2010 09:57:20 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2761091ibb.20.2010.08.20.09.57.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 09:57:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.408.g7357
In-Reply-To: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154056>

Update the documentation of fmt-merge-msg and merge-config to reflect
the fact that `merge.log` can either be a boolean or integer option
now, instead of just a boolean.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |   20 +++++++++-----------
 Documentation/merge-config.txt      |    8 ++++++--
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 78c8a6d..720af64 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] < $GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] -F <file>
 
 DESCRIPTION
 -----------
@@ -24,19 +24,14 @@ automatically invoking 'git merge'.
 OPTIONS
 -------
 
---log::
+--log=<n>::
 	In addition to branch names, populate the log message with
-	one-line descriptions from the actual commits that are being
-	merged.
-
 --no-log::
 	Do not list one-line descriptions from the actual commits being
 	merged.
 
---summary::
---no-summary::
-	Synonyms to --log and --no-log; these are deprecated and will be
-	removed in the future.
+	one-line descriptions from at most <n> actual commits that are
+	being merged.
 
 -m <message>::
 --message <message>::
@@ -53,7 +48,10 @@ CONFIGURATION
 
 merge.log::
 	Whether to include summaries of merged commits in newly
-	merge commit messages. False by default.
+	created merge commit messages.  Optionally, an integer can be
+	used to specify how many merged commits to summarize (at
+	maxmium) in the merge message. Specifying "true" is equivalent
+	to specifying 20. Defaults to false.
 
 SEE ALSO
 --------
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
1.7.2.2.408.g7357
