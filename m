Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76960186294
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430476; cv=none; b=b7KZh+IHk7k11uX8jWHkDOsmykNNoJlYQfjyqvhwPLDQy4M6k200YxIK9BHoLDht8+VfJb7t3IC9e7RYLgBMzEDRBvSfnMnXe2794uvxo2xQUOblSsxW+c6DMrWNvXm6OEE93ILBURagCZbPAWt5jXLspsIn42OlvDylexto3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430476; c=relaxed/simple;
	bh=zHgYt5EMfHPid5ATZrHYDmyotN8vPAhsL4D345D80JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPvsds9Ob7hYw3omkYVm83gTAe6PpYhvt1/zCTw/VLYJwVpeRpUFWTr/1Wh/Q2VvqL398OvYgDlIoPnGQjniHTNFAlEZ7z3/BxCM00gu7ooNmlgPNddVeNRneVkRlV5wieYe3DLkPVYphIxYdmOeOgoKsX+m7HytXg6Xs3znscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0BF02SW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0BF02SW"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so6512563a91.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737430474; x=1738035274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28jZfOcxKfK2UzG27PNx/kXejqCrp9DUSkgWXfLGGg0=;
        b=A0BF02SWeWJKli9bXaBtKaDdXm193FkH9lJId4pir8nnO3W0KYRQWFl9OU6fnHxzq+
         1ycnjc6KlZ3WKR0zwyAXDvj1lI2mh6QhX4nhBkOnaD1AXFaM2bBDrNunnMJRZtXIb3Zk
         /ThLDuUR05IHlio84F6G1XcwpluqIT5OwAoM2/ln7KIIh52RpSpyCGuUUF96U34bAiDD
         jGL39HQwq0YJKfLLbKc1qDxK0cEY0TxfyjqMQm+9QwSD8qd4Qtg07o5Y6xD2/wA5+QY7
         0LA0eN80EkhwqK7iJ7MDYgDu6Ms9iFZt4accxGyuMBpl4WCgzZ+O9mT1iw2ex5e++Ktr
         ZKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737430474; x=1738035274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28jZfOcxKfK2UzG27PNx/kXejqCrp9DUSkgWXfLGGg0=;
        b=XTY+ro45mv/oK1prMr8hbkLZZYhUTRx7F41K7TR6InXGTTDi7aVp5qiebXLJuQPHH9
         qezh/yRjVXAiSRLVMaLrP35CYubJa2/sWXf9rO6N/S5M2AiZ27n7nAgpBi7mXcpRdw4v
         VLAaMad9mxBXWusED4SgRqkeYXD9DRc/GV914R54m6/c0mK3M5VmNDnGq36oY6lGMWNS
         1papjgspHsjQfTTSuLWHhHCEDADyLpogunxOtKnSeB5S+TZ+kE5t46sAvaFEEmcR9R1U
         viBxefM5+LQlmf5YYID4jTAQ3kqwV+opTP72d7HUf15wPTS6znM79ewmeTO1LhdUnnVd
         blEw==
X-Gm-Message-State: AOJu0YytCmEdNDSZBnfw9UstnLmu3HKSY833W/1jozanfvYarOhf6nLe
	6zOIdsrmOXHShcjrD8HzNErgaD4/eib8U40rGwIoiRzqcK+4qla+
X-Gm-Gg: ASbGncsJnlToL2NiPkFgmihFAul+6myJzCSffoOUVao+yB2sC78hKvPrlrFmLbM9Rw8
	pO1vQRF7hQG0C6SNxIom0IPzdpUjwC3azmC6faJaOyUYIuGVnRAkgcYXI0nBUYrIJsm5yUqaptR
	ytng1WzCgpd+rSbEQtkr+8IK+IjHYF8gwYYOg1yD2S1vcVy3MiYhe8Z0VS0ziGCUVVTGWDmtHX6
	VepXMqlsm0dMQpGHp6XYaSWvRt33LU550EFSFK8Ic5wK8AOKq05oJzSC+zQh2GQ4C0TA94+
X-Google-Smtp-Source: AGHT+IGlMmKyyDjs6T4cAXPPkEaYCD0W0a2LiES9Q76VIXTK4r0wMgr4XI8MHX5Bkl6+umhtX6k0yA==
X-Received: by 2002:a17:90b:5245:b0:2ee:5691:774e with SMTP id 98e67ed59e1d1-2f782c55044mr23882449a91.2.1737430473602;
        Mon, 20 Jan 2025 19:34:33 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7db6ab125sm126291a91.26.2025.01.20.19.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 19:34:33 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 21 Jan 2025 04:34:10 +0100
Subject: [PATCH v2 1/3] refs: mark `ref_transaction_update_reflog()` as
 static
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-461-corrupted-reftable-followup-v2-1-37e26c7a79b4@gmail.com>
References: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
In-Reply-To: <20250121-461-corrupted-reftable-followup-v2-0-37e26c7a79b4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zHgYt5EMfHPid5ATZrHYDmyotN8vPAhsL4D345D80JE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGePFcR1bDJmrsVdS9X1GWqE36xPkLh6rxjhw
 Ka2NE4EZFqHL4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjxXEAAoJED7VnySO
 Rox/NZwL/iJi6Ol7pDTt176Hl5Ocp8yhJNcz1FzrZL4dA5N0Z7uaNtYnWWBxH1dpt0H657ptn6M
 7Ibn2zWkUf+gbjD1sU19e94vBsDC2tAeo9jhLlMmoyoLTgP24opibAra9GxQsmGfLW5PoB0owvj
 fv4YGW1P2gQr3gDhq9vBQBIzSkF0rxU+lqSdxNiGnHPRx9HkB4PNukme18ZZc6ECntfDkdIymcU
 lgXzJsp/X7Q52pc+0UrMFA86Cg5E6j99KOSulc+cXO24IlRO2eAEx/9pUuGeaBmVOUKeknHRZXb
 0vkZULOs43heqHTuwXZhX25eK8yIu3LkhcLkR40GPI2qfEpprfmk0mfmXukeQO+Co+a0IqnXpia
 i7jUbQSTDa2YHoR9SOis+GUR6cm0B58AcX9OEWiipdsU6Dydb5uFsc+ZMb1My0OznPhcy147yy7
 hgti+Pzd41cnzAmh7SkOeDSZ7/S9CGMP4s8lmEjL8fQgM9yZQhti28G9OrnIwnSmTzOlw5H3nL6
 Yg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `ref_transaction_update_reflog()` function is only used within
'refs.c', so mark it as static.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 22 +++++++++++++++-------
 refs.h | 14 --------------
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index f7b6f0f897eb58665e10a2efd3eb53c3f72abe61..ad6d774717150f1fe68a59c629e05e49a469693f 100644
--- a/refs.c
+++ b/refs.c
@@ -1318,13 +1318,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err)
+/*
+ * Similar to`ref_transaction_update`, but this function is only for adding
+ * a reflog update. Supports providing custom committer information. The index
+ * field can be utiltized to order updates as desired. When not used, the
+ * updates default to being ordered by refname.
+ */
+static int ref_transaction_update_reflog(struct ref_transaction *transaction,
+					 const char *refname,
+					 const struct object_id *new_oid,
+					 const struct object_id *old_oid,
+					 const char *committer_info,
+					 unsigned int flags,
+					 const char *msg,
+					 unsigned int index,
+					 struct strbuf *err)
 {
 	struct ref_update *update;
 
diff --git a/refs.h b/refs.h
index a0cdd99250e8286b55808b697b0a94afac5d8319..09be47afbee51e99f4ae49588cd65596ccfcb07e 100644
--- a/refs.h
+++ b/refs.h
@@ -771,20 +771,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   unsigned int flags, const char *msg,
 			   struct strbuf *err);
 
-/*
- * Similar to`ref_transaction_update`, but this function is only for adding
- * a reflog update. Supports providing custom committer information. The index
- * field can be utiltized to order updates as desired. When not used, the
- * updates default to being ordered by refname.
- */
-int ref_transaction_update_reflog(struct ref_transaction *transaction,
-				  const char *refname,
-				  const struct object_id *new_oid,
-				  const struct object_id *old_oid,
-				  const char *committer_info, unsigned int flags,
-				  const char *msg, unsigned int index,
-				  struct strbuf *err);
-
 /*
  * Add a reference creation to transaction. new_oid is the value that
  * the reference should have after the update; it must not be

-- 
2.47.0

