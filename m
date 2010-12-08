From: mmr15@case.edu
Subject: [PATCH 1/3] diffstat width: #define defaults in diff.h
Date: Tue,  7 Dec 2010 21:44:21 -0500
Message-ID: <1291776263-16320-1-git-send-email-matthew.ruffalo@case.edu>
References: <7vzksr280s.fsf@alter.siamese.dyndns.org>
Cc: Matthew Ruffalo <matthew.ruffalo@case.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 03:44:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQA1S-0000Vr-Fu
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 03:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0LHCoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 21:44:44 -0500
Received: from mpv1.tis.cwru.edu ([129.22.105.36]:4905 "EHLO mpv1.tis.cwru.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164Ab0LHCon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 21:44:43 -0500
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv1.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id BET33360
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:38 -0500
Received: from mail-vw0-f54.google.com (mail-vw0-f54.google.com [209.85.212.54])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OZJ24144
	for <git@vger.kernel.org>;
	Tue, 7 Dec 2010 21:44:38 -0500
Received: by mail-vw0-f54.google.com with SMTP id 9so505254vws.13
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 18:44:38 -0800 (PST)
Received: by 10.220.191.70 with SMTP id dl6mr1739752vcb.268.1291776278051;
        Tue, 07 Dec 2010 18:44:38 -0800 (PST)
Received: from mmr15-box.discordia.local (cpe-184-56-199-68.neo.res.rr.com [184.56.199.68])
        by mx.google.com with ESMTPS id r11sm54692vbx.11.2010.12.07.18.44.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 18:44:37 -0800 (PST)
X-Mailer: git-send-email 1.7.3.3.401.g13ba73
In-Reply-To: <7vzksr280s.fsf@alter.siamese.dyndns.org>
X-Junkmail-Status: score=0/49, host=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163163>

From: Matthew Ruffalo <matthew.ruffalo@case.edu>

Signed-off-by: Matthew Ruffalo <matthew.ruffalo@case.edu>
---
 diff.c |    4 ++--
 diff.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index db5e844..75938e4 100644
--- a/diff.c
+++ b/diff.c
@@ -1247,8 +1247,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		line_prefix = msg->buf;
 	}
 
-	width = options->stat_width ? options->stat_width : 80;
-	name_width = options->stat_name_width ? options->stat_name_width : 50;
+	width = options->stat_width ? options->stat_width : DIFF_STAT_DEFAULT_WIDTH;
+	name_width = options->stat_name_width ? options->stat_name_width : DIFF_STAT_DEFAULT_NAME_WIDTH;
 
 	/* Sanity: give at least 5 columns to the graph,
 	 * but leave at least 10 columns for the name.
diff --git a/diff.h b/diff.h
index 0083d92..7b509c5 100644
--- a/diff.h
+++ b/diff.h
@@ -86,6 +86,9 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
 
+#define DIFF_STAT_DEFAULT_WIDTH       80
+#define DIFF_STAT_DEFAULT_NAME_WIDTH  50
+
 enum diff_words_type {
 	DIFF_WORDS_NONE = 0,
 	DIFF_WORDS_PORCELAIN,
-- 
1.7.1
