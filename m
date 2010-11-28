From: Matthew Ruffalo <mmr15@case.edu>
Subject: [PATCH/RFC 1/3] diffstat width: #define defaults in diff.h
Date: Sun, 28 Nov 2010 18:50:41 -0500
Message-ID: <4CF2EAD1.8030007@case.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 00:56:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMr6y-0002Ao-Mt
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 00:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340Ab0K1X4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 18:56:47 -0500
Received: from mpv1.tis.cwru.edu ([129.22.105.36]:61814 "EHLO
	mpv1.tis.cwru.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0K1X4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 18:56:46 -0500
Received: from mpv7.TIS.CWRU.edu (mpv7.tis.cwru.edu [129.22.104.170])
	by mpv1.tis.cwru.edu (MOS 4.1.9-GA)
	with ESMTP id BEB22486
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:50:43 -0500
Received: from mail-qy0-f175.google.com (mail-qy0-f175.google.com [209.85.216.175])
	by mpv7.TIS.CWRU.edu (MOS 4.1.9-GA)
	with ESMTP id OUP45731
	for <git@vger.kernel.org>;
	Sun, 28 Nov 2010 18:50:43 -0500
Received: by mail-qy0-f175.google.com with SMTP id 8so8909972qyk.13
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 15:50:43 -0800 (PST)
Received: by 10.224.2.199 with SMTP id 7mr4646120qak.203.1290988242948;
        Sun, 28 Nov 2010 15:50:42 -0800 (PST)
Received: from [10.0.8.11] (cpe-184-56-209-12.neo.res.rr.com [184.56.209.12])
        by mx.google.com with ESMTPS id l14sm2779561qck.29.2010.11.28.15.50.42
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 15:50:42 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162369>

>From 500a39e27a12151703924f42a97a50c528c289c8 Mon Sep 17 00:00:00 2001
From: Matthew Ruffalo <matthew.ruffalo@case.edu>
Date: Sun, 28 Nov 2010 13:33:59 -0500
Subject: [PATCH 1/3] diffstat width: #define defaults in diff.h

Signed-off-by: Matthew Ruffalo <matthew.ruffalo@case.edu>
---
 diff.c |    4 ++--
 diff.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index c248bc6..a151681 100644
--- a/diff.c
+++ b/diff.c
@@ -1247,8 +1247,8 @@ static void show_stats(struct diffstat_t *data,
struct diff_options *options)
                line_prefix = msg->buf;
        }
 
-       width = options->stat_width ? options->stat_width : 80;
-       name_width = options->stat_name_width ? options->stat_name_width
: 50;
+       width = options->stat_width ? options->stat_width :
DIFF_STAT_DEFAULT_WIDTH;
+       name_width = options->stat_name_width ? options->stat_name_width
: DIFF_STAT_DEFAULT_NAME_WIDTH;
 
        /* Sanity: give at least 5 columns to the graph,
         * but leave at least 10 columns for the name.
diff --git a/diff.h b/diff.h
index 0083d92..7b509c5 100644
--- a/diff.h
+++ b/diff.h
@@ -86,6 +86,9 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct
diff_options *opt, void *data)
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
