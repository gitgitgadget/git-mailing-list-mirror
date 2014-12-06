From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/8] refs.c: rename transaction.updates to transaction.ref_updates
Date: Fri,  5 Dec 2014 18:46:30 -0800
Message-ID: <1417833995-25687-4-git-send-email-sbeller@google.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 03:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx5Ou-0004z5-ED
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaLFCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:46:46 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:64709 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbaLFCqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:46:42 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so297896iga.14
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t76yqpl73OPwRkUZ63tMOJplZdSWF74Svj95Vd+bWI=;
        b=lhbq+sxQKVzTuB4Kw2AG4SCBcfts/t3GOgf0ba4D/B2bPeOLvCo//JjA10BjBORlPg
         Y9ba629C3M2O1krBKttFCxKwp6tDZ/6P4dIKpSF+1zVm/BqG17QrqTyMwJrJ6KY+jZtE
         e/U6TY6vIiICfHvDpUVWtHiRVxRrrJ4QUJ0EXAZZy7PWKQ1BmRqqdwBCJu0a3kOPzXdK
         zPt7QQxH4Y1Un/gSsps4uqqvMCiUVIhrrsTyfxgG/D+15SZEHoZwLTkudYcjUPfbR0zY
         PURyy3z0cVZTmh2cXmGZz9HFzDdKlXALcd2L54QkZpMYcxzsujQMe1voq1ZNx3Ywv+oW
         EOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t76yqpl73OPwRkUZ63tMOJplZdSWF74Svj95Vd+bWI=;
        b=Wn+JYR1GFSgQ6v4DDnJQtJiSvpgFxyzEURryBRlDIP4X977sDXsdl2R2lua8ZnEWUw
         yDOVzW8/w1JjNT05ux+NWRvnd9CrVSEUNHNWPZCkiydInyq+B2kf/Tuegdt23Oow0BIB
         2Cefs5t9o+VtAPmgTQMRMq6DZFXYgH9XHHt6UwKsQVwa7k0MENoxGEtwAzllCOMa7yvJ
         9o/lb5XyaRk7VuMWNP0bconMi0uvcVk4VREpOXqbe7O+/of1Zaywg9UXe1sTUUzAxg9w
         SQK4aIKbSBQKKBauJUHCzI9x+xWnpRWoPnZ7YUfNVR9zX/slvHK7oIkBt4bg3j/bcVr6
         tSVA==
X-Gm-Message-State: ALoCoQlL5J61IRe59yGrbGkroxWta+J3amRO9noLyLW6D00Pc+O8O8cKS2o6G1pGe3U5LMwdPzCy
X-Received: by 10.43.74.3 with SMTP id yu3mr18208697icb.15.1417834002257;
        Fri, 05 Dec 2014 18:46:42 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:4022:de56:febc:d879])
        by mx.google.com with ESMTPSA id i3sm16928643iod.19.2014.12.05.18.46.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:46:41 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417833995-25687-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260933>

The updates are only holding refs not reflogs, so express it to the reader.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Notes:
    no changes since last sending it.

 refs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 9f2628b..aad44d5 100644
--- a/refs.c
+++ b/refs.c
@@ -3556,7 +3556,7 @@ enum transaction_state {
  * as atomically as possible.  This structure is opaque to callers.
  */
 struct transaction {
-	struct ref_update **updates;
+	struct ref_update **ref_updates;
 	size_t alloc;
 	size_t nr;
 	enum transaction_state state;
@@ -3577,10 +3577,10 @@ void transaction_free(struct transaction *transaction)
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
 
@@ -3591,8 +3591,8 @@ static struct ref_update *add_update(struct transaction *transaction,
 	struct ref_update *update = xcalloc(1, sizeof(*update) + len + 1);
 
 	strcpy((char *)update->refname, refname);
-	ALLOC_GROW(transaction->updates, transaction->nr + 1, transaction->alloc);
-	transaction->updates[transaction->nr++] = update;
+	ALLOC_GROW(transaction->ref_updates, transaction->nr + 1, transaction->alloc);
+	transaction->ref_updates[transaction->nr++] = update;
 	return update;
 }
 
@@ -3714,7 +3714,7 @@ int transaction_commit(struct transaction *transaction,
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
 	int n = transaction->nr;
-	struct ref_update **updates = transaction->updates;
+	struct ref_update **updates = transaction->ref_updates;
 
 	assert(err);
 
-- 
2.2.0
