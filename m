From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 1/6] merge: tidy up options
Date: Wed,  6 May 2015 01:00:48 +0100
Message-ID: <1430870453-5408-2-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmlu-0004Wn-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933304AbbEFAA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:00:58 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:36613 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbEFAAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:52 -0400
Received: by wgiu9 with SMTP id u9so37097409wgi.3
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kOYqcDr5XzuGVOuBInh3HqZ6NqlUvS8+CjAT+2Ff2fQ=;
        b=YuhrXRrSfU0Sc8Qbu8ef2kKbV58EJ3tton00a/1Pwt++H40mDft1E5JuNPzRgtKQP6
         /BbHMA5wNK5Ho0iCTDRACuvLhlY/br4wv2mGaQP8TQ64em43dwKHGBSM7SJTXPUobZa9
         zUgDDsVSK0tlTOjKEABlT1Qor1J/ZMZ4pYedabH9myTuKOt0yr7BjI/ZrMiufODOCbZy
         VhsUU/ybyy9P0H1Z+wpMRGOjyISp2MbKVceyW1tN8dUjZ7aiHUm+/Fbm9EWwaTRhSD9/
         R0H5JcK9RMmOmQ2qSA7ZpA53S65bJDKo2aWepLK9tYfYkQDPuLjTnzYJE4KGvsCXFKf1
         YFGA==
X-Received: by 10.194.121.38 with SMTP id lh6mr55749954wjb.2.1430870451422;
        Tue, 05 May 2015 17:00:51 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id e2sm42969wij.5.2015.05.05.17.00.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268435>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

Hide --summary (it is a deprecated synonym for --stat).
Correct capitalization of the description of --verify-signatures.
Correct indentation of code.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b0f8f9..d6b0579 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -194,10 +194,10 @@ static struct option builtin_merge_options[] = {
 		PARSE_OPT_NOARG, option_parse_n },
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
-	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
+	OPT_HIDDEN_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
 	{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
-	  N_("add (at most <n>) entries from shortlog to merge commit message"),
-	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
+		N_("add (at most <n>) entries from shortlog to merge commit message"),
+		PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 	OPT_BOOL(0, "squash", &squash,
 		N_("create a single commit instead of doing a merge")),
 	OPT_BOOL(0, "commit", &option_commit,
@@ -210,7 +210,7 @@ static struct option builtin_merge_options[] = {
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
-		N_("Verify that the named commit has a valid GPG signature")),
+		N_("verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
@@ -223,7 +223,7 @@ static struct option builtin_merge_options[] = {
 		N_("abort the current in-progress merge")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
-	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_END()
 };
-- 
2.4.0.7.gf20f26f
