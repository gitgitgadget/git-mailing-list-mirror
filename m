From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] fixed translation error in fetch
Date: Mon, 4 May 2015 12:47:49 +0100
Message-ID: <55476a2c.0530c20a.7f3d.ffffcb98@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFmG-0001Wi-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbbEDMrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:47:12 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35516 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbEDMqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:46:38 -0400
Received: by widdi4 with SMTP id di4so120044788wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=/WhI6/Un9TSntA1RYulLv3oI/HCwlxuLTk6XUIEK1Us=;
        b=dhVk1Ew76VAhc5J6XiZuR+koo0EAoBvoJP7SzsifmmElW7QWuZ9SBfnT8s4QaPyWsd
         1CIU1BqU5H9f/U8dKlRkvIWLmh0j4n3hd+kZxhfU1Mx8Tfabzik3CxPAOHkw6BVniFgk
         5nOFKBFbAEi0WVBNXuihYPqhb7XYgxvlg9GuZ4mw4V8bcUs0EUoFRYVmDBQDEvpOxZGp
         PzZWRJClFCETP/HZmoyxcG/ryiBVuOY945LFxaGGljbOk0xC3cZDGdMApd+IOFNF+Fyv
         uaG+wt+ZUqXDDtj5dYxrf8MnYMuffXbYlOtICpOnKqaq/hb1QOcgTfsA5TUnow6IJjwT
         9whQ==
X-Received: by 10.180.90.72 with SMTP id bu8mr18986459wib.62.1430743597218;
        Mon, 04 May 2015 05:46:37 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id h5sm20496166wjn.20.2015.05.04.05.46.35
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:46:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268323>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 builtin/fetch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f951265..ab110b2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -340,7 +340,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		if (tags == TAGS_SET)
 			get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	} else if (refmap_array) {
-		die("--refmap option is only meaningful with command-line refspec(s).");
+		die(_("--refmap option is only meaningful with command-line refspec(s)."));
 	} else {
 		/* Use the defaults */
 		struct remote *remote = transport->remote;
@@ -432,7 +432,7 @@ static int s_update_ref(const char *action,
 	return 0;
 fail:
 	ref_transaction_free(transaction);
-	error("%s", err.buf);
+	error(_("%s"), err.buf);
 	strbuf_release(&err);
 	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
 			   : STORE_REF_ERROR_OTHER;
-- 
2.4.0.8.geba5036.dirty
