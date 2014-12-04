From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/13] refs.c: rename transaction.updates to transaction.ref_updates
Date: Thu,  4 Dec 2014 00:29:15 -0800
Message-ID: <1417681763-32334-6-git-send-email-sbeller@google.com>
References: <1417681763-32334-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, mhagger@alum.mit.edu, jrnieder@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 04 09:29:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwRnG-0005fc-EX
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 09:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbaLDI3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 03:29:42 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42107 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaLDI3j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 03:29:39 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so15617304ier.28
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 00:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpEK5wD5aaGnUlxcjNDyCVLB1R5BxXBbd0MBrUVwhrs=;
        b=ETS5edkBV3nMtZZEs9sRbJXYZWEVZFhP5mSNFMp+7x23uNg/LkeHWUgFwGqFxg0/TC
         bc3H8gt6klpJNgEeuNcUJr8I1UrdQ79JrGN5dGQRS5pwTdpfyz47gTz9kpuGV04srWKm
         pKAd5qvDAWc1xR46h3AKBw29nwuuxv+84sqZyQoQz7nBeVVnhVUv6ktWJr/EyV7/hieM
         XrWX6jZoDPNNYYFYwTFYfmX/OaSFJfJcLXdRlt491Q+niiVhRYBn5QVofBdGkZU8rf3O
         gs60ELSVmEPihGIeLWgtvrbzgT/365U3mSZ5BwRvermM3MvyAyN+UP0KEB5UmcqeAn9t
         BbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YpEK5wD5aaGnUlxcjNDyCVLB1R5BxXBbd0MBrUVwhrs=;
        b=cCxNq6o4S69gZFI+fkbjI8X/62NrfmFrPmurl862WbhmmgWSA+54vJN4kJ7um3ROWs
         6+rWlpn1RaLkli2pw62fNkYuxOP7gnnKZqDQs79qbrxWTfNMvQ9EmOx+XsEFGTMREUSb
         ScccVp6Ir9OqYXgGs3tMdJwcGT7zOfp2cg3E3YISLXXIDOMLIHITB2iuVWSADmsawKlO
         8MQd9Ab57yoIJhxUTcTIVLz9U7ON4f7AGNbADzKzj6Gqf7w5v7YGu+L0jJ77HJZE1vXy
         TdxNFV7RRZYFeWlte+vZsQYhGbnrumgeAmiNaIDMs4/i2vc5JsB0shYJ1u8PFB5VsZ9T
         fUOw==
X-Gm-Message-State: ALoCoQn3xOle5YBGuYVmn9TOXrjvh1tkXqebObZtQ9FBZoSTDrdn8SYVpaS7FkULze2b8zRNXZm3
X-Received: by 10.42.212.10 with SMTP id gq10mr10359569icb.79.1417681779006;
        Thu, 04 Dec 2014 00:29:39 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5d2c:9a2d:3064:bc4])
        by mx.google.com with ESMTPSA id qc7sm8838111igb.5.2014.12.04.00.29.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 00:29:38 -0800 (PST)
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1417681763-32334-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260734>

The updates are only holding refs not reflogs, so express it to the reader.

Signed-off-by: Stefan Beller <sbeller@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---

Notes:
    remotes/origin/sb/ref-transaction-reflog
    
    no changes since last review

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
