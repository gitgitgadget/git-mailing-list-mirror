From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Correct git-pull documentation
Date: Tue, 19 Feb 2008 14:24:32 -0500
Message-ID: <1203449072-89011-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 20:25:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRY5b-0003A0-Ht
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 20:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307AbYBSTYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 14:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755254AbYBSTYj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 14:24:39 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:3001 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbYBSTYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 14:24:37 -0500
Received: by an-out-0708.google.com with SMTP id d31so530251and.103
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 11:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=kNwayEXRBTh0ToIQvLKuGTgvGqQ0srV8v7WwLRnubOg=;
        b=DhD3SjDfY9QWHHbiicZ4Ks6M+JE+UR2/3VNcfmqGdVMmrBEzF0Md4vukLDIajTUW6sTFpusQUUj9VWxHnHp3HQJjIdZlc2c37sznldwP0WqraGyDg2tLwUSD84JPzZP8lbeoIkEMFu1Fr7yI8FbmfGLmKbDwqYoK3cFyUdDM0Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=nRFvlqLrtgBdfPxxU8QQX8OuVQN3+SsQHFa4XrtpRAzImbvj2nP2C42fBIerrHXTmoUsNT8ojrw9QyDHlXczlox3JvSgOfn4/hA3dX3owELn2buPhgJtP34OsWwFjB8atJYDdYVR48Db3E4b7T/O4D0lj6Epu0GE2OXNuwpkCwk=
Received: by 10.100.190.15 with SMTP id n15mr14925809anf.96.1203449076898;
        Tue, 19 Feb 2008 11:24:36 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b14sm16144146ana.26.2008.02.19.11.24.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 11:24:36 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.204.gbea87
In-Reply-To: 1203137441-52448-1-git-send-email-jaysoffian@gmail.com
References: 1203137441-52448-1-git-send-email-jaysoffian@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74446>

The --rebase option was documented in the wrong place (under MERGE
STRATEGIES instead of OPTIONS). Noted the branch.<name>.rebase
option.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/git-pull.txt |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 179bdfc..7378943 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -15,6 +15,7 @@ DESCRIPTION
 -----------
 Runs `git-fetch` with the given parameters, and calls `git-merge`
 to merge the retrieved head(s) into the current branch.
+With `--rebase`, calls `git-rebase` instead of `git-merge`.
 
 Note that you can use `.` (current directory) as the
 <repository> to pull from the local repository -- this is useful
@@ -26,19 +27,14 @@ OPTIONS
 include::merge-options.txt[]
 
 :git-pull: 1
-include::fetch-options.txt[]
-
-include::pull-fetch-param.txt[]
-
-include::urls-remotes.txt[]
-
-include::merge-strategies.txt[]
 
 \--rebase::
 	Instead of a merge, perform a rebase after fetching.  If
 	there is a remote ref for the upstream branch, and this branch
 	was rebased since last fetched, the rebase uses that information
-	to avoid rebasing non-local changes.
+	to avoid rebasing non-local changes. To make this the default
+	for branch `<name>`, set configuration `branch.<name>.rebase`
+	to `true`.
 +
 *NOTE:* This is a potentially _dangerous_ mode of operation.
 It rewrites history, which does not bode well when you
@@ -48,6 +44,14 @@ unless you have read linkgit:git-rebase[1] carefully.
 \--no-rebase::
 	Override earlier \--rebase.
 
+include::fetch-options.txt[]
+
+include::pull-fetch-param.txt[]
+
+include::urls-remotes.txt[]
+
+include::merge-strategies.txt[]
+
 DEFAULT BEHAVIOUR
 -----------------
 
-- 
1.5.4.2.204.gbea87
