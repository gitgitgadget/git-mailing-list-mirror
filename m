From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/4] refs.c: rename transaction.updates to transaction.ref_updates
Date: Mon,  1 Dec 2014 23:46:40 -0800
Message-ID: <1417506402-24257-3-git-send-email-sbeller@google.com>
References: <1417506402-24257-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, ronniesahlberg@gmail.com,
	mhagger@alum.mit.edu, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 02 08:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XviAm-0006Tp-6i
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 08:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbaLBHqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 02:46:53 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:56732 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965AbaLBHqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 02:46:51 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so14521809igd.8
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 23:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFz3G4RGrajsu/uDf3/8Lup+TQfvx5h7fXpdFQ6whKw=;
        b=EVQah16+GV00YJpqUyv2jFcHiELZBjbXsNAyMCXnCpkJKfWXCfYUcBIi/sMPeMdkU/
         kBHLhf4pEO6tyfAQ033LGTya2Yz0V0SrhOEdgpI68dyJLdUsKI49bs/iZCEAX/p/ReVv
         kkmASY32wQvKJ4V45u7aIklUzpTk3QMBb43f4SJ1Njb52hClZ+ofHUWdo0y0Kh2F8SXH
         iEoGo2tpyGLLm2rhji5Txgq+rexlmc3LdH7kpE3VjE0n9uZBj2WtwS590FsnKaxMzS6P
         XkxXet2dDteh+g0IDneIfLVGvGc6e95szrN8Lx08mrIuNLDD+j+psVLeMDJBJ3emOzyp
         lf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFz3G4RGrajsu/uDf3/8Lup+TQfvx5h7fXpdFQ6whKw=;
        b=csvxzpqIjyg4Kprn0CS1oykuumoVuLoba8rQYnG3JZLlGzU6LHiuDFYtLVsfwiakW+
         A294VLugJOVCHtNhJ3u5Pjfn5cz5e9NlCcPc5nkkjla5sbIwZ2oOmzGXRULVnMl0WbUm
         Jcn/7wNZ7wBi/QfaOe8oCECAxvaIB2Oz/OdaEZ1M3GyC9SgEm/KUxuJgWHZs0MS1Ig5a
         qcBfFZbfQb6m89Mo4BR+Al9yCytRHt4E7PBhhvuI1YZ9yHfr23DXFhkxJzv93vfO4Wet
         2PExelzjC2b+SxdFqaXakYCuYw1pE28853SyXtiId3Po47idjvdh7GtD3UcAmFMDm3KC
         Iu1g==
X-Gm-Message-State: ALoCoQmbheoJrndddYtr5ivrJtFWnn6Td19uV91GDpuuVrrudQ5gpL/i5F7RVl8A5vjygNQNHxLH
X-Received: by 10.50.43.162 with SMTP id x2mr10332965igl.46.1417506408598;
        Mon, 01 Dec 2014 23:46:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:21e7:446b:f329:a30a])
        by mx.google.com with ESMTPSA id b3sm928086igl.2.2014.12.01.23.46.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Dec 2014 23:46:48 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417506402-24257-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260547>

The updates are only holding refs not reflogs, so express it to the reader.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

* only renaming, no extra code in this patch.
* new to the series.

 refs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f0f0d23..58de60c 100644
--- a/refs.c
+++ b/refs.c
@@ -3554,7 +3554,7 @@ enum transaction_state {
  * as atomically as possible.  This structure is opaque to callers.
  */
 struct transaction {
-	struct ref_update **updates;
+	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
 	enum transaction_state state;
@@ -3575,10 +3575,10 @@ void transaction_free(struct transaction *transaction)
 		return;
 
 	for (i = 0; i < transaction->nr; i++) {
-		free(transaction->updates[i]->msg);
-		free(transaction->updates[i]);
+		free(transaction->ref_updates[i]->msg);
+		free(transaction->ref_updates[i]);
 	}
-	free(transaction->updates);
+	free(transaction->ref_updates);
 	free(transaction);
 }
 
@@ -3589,8 +3589,8 @@ static struct ref_update *add_update(struct transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	ALLOC_GROW(transaction->ref_updates, transaction->nr + 1, transaction->alloc);
+	transaction->ref_updates[transaction->nr++] = update;
 	return update;
 }
 
@@ -3712,7 +3712,7 @@ int transaction_commit(struct transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
 	int n = transaction->nr;
-	struct ref_update **updates = transaction->updates;
+	struct ref_update **updates = transaction->ref_updates;
 
 	assert(err);
 
-- 
2.2.0
