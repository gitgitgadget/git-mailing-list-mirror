From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 5/5] fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
Date: Sat, 21 Aug 2010 00:45:02 +0530
Message-ID: <1282331702-5115-6-git-send-email-artagnon@gmail.com>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 21:18:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmX6G-000787-C1
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 21:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab0HTTRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 15:17:43 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53315 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab0HTTRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 15:17:41 -0400
Received: by pvg2 with SMTP id 2so1324663pvg.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=h+G0buZvUmsF4SPiI9G9wo81HOo9G5ogTlKoZBCztZ4=;
        b=uwnX8xeKabEA4cxo4spDaer0SAh7LYou440x9vgO4jlfPNy+vbfYV2aapRqvMlvMXC
         15KuduKC4h/bVeHxUDosQ6A+TTPCwv26GU6c+yTC03q8oZf3ctLoN39HRrDaacpRGBbO
         8v0Vm3O+vpU6AjJTl7O7GdnE7ja4b+YNLft7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qKqzSChaFUUv2BGHNgakUGTg1v80dNE2tPd837G+CEzOULBGlg9wT86F+OEI4hnYsy
         7on9/om5g5v4jB+D5oDl2nvmLeMj3wt1fPSQAlBMZrE6Y+CUw8Am1OMnDujqVuejI89Q
         mrWe3EU6kbqRJkLMiq9zORMQgoV99VR3WLopU=
Received: by 10.142.13.11 with SMTP id 11mr1351870wfm.212.1282331861170;
        Fri, 20 Aug 2010 12:17:41 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm3610572wff.7.2010.08.20.12.17.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 12:17:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154074>

Update the documentation of fmt-merge-msg and merge-config to reflect
the fact that `merge.log` can either be a boolean or integer option
now, instead of just a boolean.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-fmt-merge-msg.txt |   20 +++++++++-----------
 Documentation/merge-config.txt      |    8 ++++++--
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 78c8a6d..4149a1f 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
-'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] < $GIT_DIR/FETCH_HEAD
+'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
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
1.7.2.2.409.gdbb11.dirty
