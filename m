From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/3] format-patch: remove unused total parameter from 
	reopen_stdout()
Date: Wed, 18 Mar 2009 12:51:17 -0700
Message-ID: <780e0a6b0903181251j5f3cda50xcadccb4622bad66c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 20:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk1om-0007Jg-LP
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 20:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZCRTvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 15:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZCRTvU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 15:51:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:35113 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZCRTvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 15:51:19 -0400
Received: by wf-out-1314.google.com with SMTP id 29so227695wff.4
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 12:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=hm1gLSVBEYPBI1tPFmvB2ItSHbDaXblHLp5FIoLCGwc=;
        b=RAPF3+ouXIYZSrVLFCzsnSydgd8t5WVv/cn5dPgtZIm/Ec7XLidc+vnp+68KEIgHyG
         5sRvj0orVIavUoosaixIyy7alayymhJ5RnbGDJF5KN8mld4IY3xAmh6QYL7TuU33orBr
         fjbzJRzZTGOXaCFTymS+Yx2wSfu+BTbc47opk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=dP3VYPKg5NnDbsNHd1t7u9tESIRCUEjUSA2tUgQ7KNfIzf7bI8o90pf6AzFcsJ5m4b
         LVRdQMQ8DClXcHea8EyL/BxsXO6jyzW2S1TNyXXtR8zPXVxrEeK2W6VN6JBTMQ68ufT5
         uBDz1J7ad1tsXAd8IXodbucgWbuGATG9Tn9R4=
Received: by 10.142.203.19 with SMTP id a19mr674308wfg.177.1237405877383; Wed, 
	18 Mar 2009 12:51:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113654>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin-log.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 8684fcd..c72e35a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -573,7 +573,7 @@ static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
 static int outdir_offset;

-static int reopen_stdout(const char *oneline, int nr, int total)
+static int reopen_stdout(const char *oneline, int nr)
 {
 	char filename[PATH_MAX];
 	int len = 0;
@@ -687,7 +687,7 @@ static void make_cover_letter(struct rev_info
*rev, int use_stdout,
 		die("Cover letter needs email format");

 	if (!use_stdout && reopen_stdout(numbered_files ?
-				NULL : "cover-letter", 0, rev->total))
+				NULL : "cover-letter", 0))
 		return;

 	head_sha1 = sha1_to_hex(head->object.sha1);
@@ -1106,7 +1106,7 @@ int cmd_format_patch(int argc, const char
**argv, const char *prefix)
 		}
 		if (!use_stdout && reopen_stdout(numbered_files ? NULL :
 				get_oneline_for_filename(commit, keep_subject),
-				rev.nr, rev.total))
+				rev.nr))
 			die("Failed to create output files");
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
-- 
1.6.2
