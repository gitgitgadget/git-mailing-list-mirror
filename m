From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 11/16] Add explanatory comment for transport-helpers refs mapping.
Date: Mon, 30 Jul 2012 16:31:18 +0200
Message-ID: <1343658683-10713-12-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-7-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-8-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-9-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-10-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: florian.achleitner.2.6.31@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 16:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svr8Q-00086y-21
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 16:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2G3Ojd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 10:39:33 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2G3Oja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 10:39:30 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so2859087bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dTjFxBG+qZmRLW3xMzhyEsIrdBCHJNWhAS6hfyW9vqw=;
        b=ooz7SQ5HMhdPiwp45IzuSm+YsXvCV6pGAP6v2yG3sEEilI+4eU0RCDVm2PMIamRmP+
         Boowvzgi7T4eujGrV9tQ0HIg5CxDWrrZeyjKyX3h5fYRm4tqI6ndbsYOrMXQhklIyJxW
         ZgHzg2r9nR8q/dL73h8Bgi3lYecASn9kBi/qK7XpsdJKPRcAMVK0mfcm319oJJ0AbAFx
         lxR/dIsLUonokZ0P0aWGyMW8Hx2LDD5VaoQrFFDYEKG1qqR68UTgcDBmEuwE1oZBfC4F
         U0IR9D61oPrzzCom9jznpxe2I6WImr/az/yokFQWSHz7Dv7XXka8KPhMr14gmqPPR0aT
         MhZg==
Received: by 10.204.154.141 with SMTP id o13mr3919217bkw.72.1343659170009;
        Mon, 30 Jul 2012 07:39:30 -0700 (PDT)
Received: from localhost.localdomain (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm3945866bkc.5.2012.07.30.07.39.27
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 07:39:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1343658683-10713-11-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202551>

transport-helpers can advertise the 'refspec' capability,
if not a default refspec *:* is assumed. This explains
the post-processing of refs after fetching with fast-import.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 transport-helper.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/transport-helper.c b/transport-helper.c
index d6daad5..e10fd6b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -478,6 +478,21 @@ static int fetch_with_import(struct transport *transport,
 
 	argv_array_clear(&importer_argv);
 
+	/*
+	 * If the remote helper advertised the "refspec" capability,
+	 * it will have the written result of the import to the refs
+	 * named on the right hand side of the first refspec matching
+	 * each ref we were fetching.
+	 *
+	 * (If no "refspec" capability was specified, for historical
+	 * reasons we default to *:*.)
+	 *
+	 * Store the result in to_fetch[i].old_sha1.  Callers such
+	 * as "git fetch" can use the value to write feedback to the
+	 * terminal, populate FETCH_HEAD, and determine what new value
+	 * should be written to peer_ref if the update is a
+	 * fast-forward or this is a forced update.
+	 */
 	for (i = 0; i < nr_heads; i++) {
 		char *private;
 		posn = to_fetch[i];
-- 
1.7.9.5
