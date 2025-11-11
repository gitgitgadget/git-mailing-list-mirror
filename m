Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D433AD86
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867634; cv=none; b=RSOFFlV0E1AnfAd51vwS+KzT88gAm0RWtsFtPH3cGMY7ZsYRhbn9t4sBynWqNQwT4/2FjE9RctUUUkO/+VBHaji4b06y+Ics3WSBliw/iRswwqDTtvx2amX583xmMvugy+FgBlIIg71eimJfebV+FNGt+NT3bXf/RG9Ylv5nKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867634; c=relaxed/simple;
	bh=mQG9UrHc5aJea5xzZtrJlR6Xayk81hLTdYaacfHp7VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9tglVs3AIWZEbM/DBH3DAXBGj+w2SNXVxVW6JDOoaBf+EpeyjjbgwhwUx3B73mwd3KSbQ1uGK9RZ9L1zM2MZOlkio81sAB03F9EgPH0AZKHgTAAOAecN/8gLQ0mo4LLRYcVONOt+Nfg5eI0RPLMmHAk60Td6diVPkwbwPj1PT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T11tek8J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T11tek8J"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477632d9326so31650855e9.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762867631; x=1763472431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPOD1NGfCW6PjFIAl+Im485kIbYUroUUZHJgxxjmtas=;
        b=T11tek8JK3NqUXqXTLM4PfmIlDekS3P6UXwqDLfuP4hYL0QNgNcIHRUXMuBEeSh5T7
         SC7tOqVigs39RjgsH0vbU9/H7pCdwHNLTvdO3vQ003fBkq9n7vjMdA3kW+ITmGVzPxGe
         T8KTUQ+kygx7Ig0z0ugHrfLFtb9w2KgxDflIB2dHWlx+bkSji/VFztAsyiKaT2h2dmiG
         a94tTKJC5ZlrK9Iki4aVaXOEXiJTixvSf/3pR7ykr0stgbOdPuV7A+JxF72QJbhBQP6/
         yVwYWX7Dy3XBXbc2rxJE9g9MpIgUtO3k7gkQhWABNDxTPojE4FZixItX+XLz72MBuH6/
         SNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762867631; x=1763472431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iPOD1NGfCW6PjFIAl+Im485kIbYUroUUZHJgxxjmtas=;
        b=Ixi3dXHon0Pyo5jgChg6R6XAezkWmGFwKJIgPlBfYxiEbUy0+qP1bxdHfqSH7a+v5t
         3hQD+En3c0oPLWYYRz/5WbkPNcTx8n9IHXxb758jGYvPdpk/DgNqO6EOp2SkNBZ7XGTX
         XuMZtRpi+5oUdktsk6sKYKZPfqJ0M0znhhQIj0MDkVoVBWXJsm2Ri1I/kW8Jlvmc0U/Z
         AlETKCe/U/E1+pTOGrNu7CDzJZvq/L75to0vQYrjziJC4FgM60669sXREtY0BSi5V9Hh
         8x+qCMIGfX1tNSFPpb89w5dtxMZIAXWhqdHDqbn7iJJ6ZGRyP3L+KKWhPt5aQmZeuwM5
         DBCQ==
X-Gm-Message-State: AOJu0YyXTztDkIYoygmH5amXRj5O/hN/aKwPbTymdzw34THGMcmEsIKr
	4DYUnTifImPQJNrZeZQh1myi0j03uvSZFf/5OLDslt0YoWihEJcuulpk
X-Gm-Gg: ASbGncuZvAKg5o1n8PJfj2mAoF0E7caHMx2q4gxrIqEIwjJWuo8sW9PxONJdjmii0Mt
	yJ9iu0EWbigap5c8uvgHUpYUKUupfZYzh7w5RsiG7HH1q84uiFC5gR2drsAP1xD143d8aEV4AXI
	F0ucuMJhrjAgIfNFMxgGuu1Mv1so47/WQ/jIHWcKuIwU4aistkn6UNYdCbbfgF/6EQ19zC6+Kzy
	u/mBUDuEmkWVXut0sDgOSvD8HXKhfbpT/lavJb4sBei60NyaBdH9AwE0KIyQwZgKWPXeRpqeeln
	xLbtA6bTcFUid/+kgdpiQSQNmscwkTwS7oPdOem8nWySp6tjyikTNTWTR6xd9oUPqt9BheerXoC
	WrmLjfqEUIQgjT5EafvL7Yco2PwUk86hSzzhQksSBF0IxSoA/QBAVRvUMFkya3Pa8EHqgcz3QOp
	Yh
X-Google-Smtp-Source: AGHT+IGXg4/AvkrG5OgEsxLMQPuC2C99qJ59oLI8qa5S6n1fJLoWA5Y9JalwxwL2z7LkoV/QHDGcOA==
X-Received: by 2002:a05:600c:468d:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-4777b16623amr86144765e9.7.1762867630888;
        Tue, 11 Nov 2025 05:27:10 -0800 (PST)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd521fsm300794715e9.6.2025.11.11.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:27:10 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 11 Nov 2025 14:27:07 +0100
Subject: [PATCH v4 1/2] fetch: extract out reference committing logic
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-fix-tags-not-fetching-v4-1-185d836ec62a@gmail.com>
References: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
In-Reply-To: <20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 David Bohman <debohman@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 jltobler@gmail.com, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=mQG9UrHc5aJea5xzZtrJlR6Xayk81hLTdYaacfHp7VI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkTOa3KqIKLiibiiOiH/dA9ZKc/I2B80ndSf
 TIw/GepPXwqKYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpEzmtAAoJED7VnySO
 Rox/KEUL/jWXL8hlPE0X4J+saNR9vQZM3ap1CkTiaizGUoxVDBVEzPhbca7wfQyFOF63ObAYqAK
 AVi31MjSdL+TdeSs5FNgmxphcrj8FlsJAiVkLZI5B+2V16ZcYt0Hcpl/iZ2jqTGhl7s5R0LG9G9
 xJJhy5ZoeKxqQ0z3McY3U6+vNUYLwiMg7dl8eU9Ulnp+bfVYEeChvTw6+hbdr0LR60YykLV6pSp
 lvN6vlvHYtADwRru2rzOn7hX9J6l6GyEwCciBhfv9BwUjxuVnLc3tGmXoKSr1IfquuGQVvGj67w
 /wjgdDeOcTPDvfQBq/5ld9mvC7WERbKrDQQRurza0IDI34lKDxiOvGdtFfy56bu7GR058QJNMEm
 lHBkg9iKqODQQokp7mH4KhuciHtc1rrLc9n93A9tEKHbKraUKc9d0q0054NWdld94OQ7dx5gSST
 zGpYLWmrPvEV8jQ5EeYcpoQbTv58inhQ+qaVdHcN8GkNaXLeCpTfqX6dy/noq25tGM4PuzIceZ6
 LE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `do_fetch()` function contains the core of the `git-fetch(1)` logic.
Part of this is to fetch and store references. This is done by

  1. Creating a reference transaction (non-atomic mode uses batched
     updates).
  2. Adding individual reference updates to the transaction.
  3. Committing the transaction.
  4. When using batched updates, handling the rejected updates.

The following commit, will fix a bug wherein fetching tags with
conflicts was causing other reference updates to fail. Fixing this
requires utilizing this logic in different regions of the function.

In preparation of the follow up commit, extract the committing and
rejection handling logic into a separate function called
`commit_ref_transaction()`.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c | 59 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb..f90179040b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1686,6 +1686,36 @@ static void ref_transaction_rejection_handler(const char *refname,
 	*data->retcode = 1;
 }
 
+/*
+ * Commit the reference transaction. If it isn't an atomic transaction, handle
+ * rejected updates as part of using batched updates.
+ */
+static int commit_ref_transaction(struct ref_transaction **transaction,
+				  bool is_atomic, const char *remote_name,
+				  struct strbuf *err)
+{
+	int retcode = ref_transaction_commit(*transaction, err);
+	if (retcode)
+		goto out;
+
+	if (!is_atomic) {
+		struct ref_rejection_data data = {
+			.conflict_msg_shown = 0,
+			.remote_name = remote_name,
+			.retcode = &retcode,
+		};
+
+		ref_transaction_for_each_rejected_update(*transaction,
+							 ref_transaction_rejection_handler,
+							 &data);
+	}
+
+out:
+	ref_transaction_free(*transaction);
+	*transaction = NULL;
+	return retcode;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1858,33 +1888,10 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
 
-	retcode = ref_transaction_commit(transaction, &err);
-	if (retcode) {
-		/*
-		 * Explicitly handle transaction cleanup to avoid
-		 * aborting an already closed transaction.
-		 */
-		ref_transaction_free(transaction);
-		transaction = NULL;
+	retcode = commit_ref_transaction(&transaction, atomic_fetch,
+					 transport->remote->name, &err);
+	if (retcode)
 		goto cleanup;
-	}
-
-	if (!atomic_fetch) {
-		struct ref_rejection_data data = {
-			.retcode = &retcode,
-			.conflict_msg_shown = 0,
-			.remote_name = transport->remote->name,
-		};
-
-		ref_transaction_for_each_rejected_update(transaction,
-							 ref_transaction_rejection_handler,
-							 &data);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
-			goto cleanup;
-		}
-	}
 
 	commit_fetch_head(&fetch_head);
 

-- 
2.51.0

