Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947B1F81A5
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578342; cv=none; b=qYxySONEJtwtf7Zqvnuv7PGNC6esEocGJo04VcqC9GYYfuGX5TDZ1q+Wrw0ssWyCzMYR+PPYx1PpRITlBluhlScUmFqmXkiRP6FD9mFTFZBKujcYHkdf4WtBTkJ0hmXmSN1s2qPtMTAHIzHARx1Q86J7GH5XvmKYes9o/eERbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578342; c=relaxed/simple;
	bh=7w7BT52iwa88oF8n92WnUIJqsEvH5iHLrCGdpyDzBAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U06Rrh+CYlv2VX3ykmxru/1EmTUgY7LGlgAwFEXyLt67kg8poK5akyDPOgLgNn3UcADiI2wKgTfzLioGRxFZ052LygWIcTyPfQg1YS76Ijvpvl7FQaD6NmdPf+WSjMYc6JOAhj9mmsiZYapdmbTRKlamvk6dT+XKcuXyrIW4HTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q49qrHVt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q49qrHVt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so561460a12.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 01:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578339; x=1732183139; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3u1xBHr8FnIm+5TBiOfl4qNKBgXiuMHQM/YSxwIjxg=;
        b=Q49qrHVt6O6qIsfVu8YhxL7dxaTAFSjkEn+UJ2fkWbRVgVWTX3jv/jSX5Y4aajTS3H
         f4bbpGpqpZuVV65P9EslKWyTsWMLwbfvp2x5PpqLRMCdvwHc/YN4EAC4Rcd+Rw06elAD
         7j+n5sG3sMGQ6kU+kt1/9dlZOIwQfJvWVlLe9wJN7TAxrOmc52Qy5DNh+MAiiabSOSdk
         a7lJAlRJQj5nncRWmTnFFc0R4/mxwJ5QfW3DrDzG0wP1y+snPs1dqbEiyEiINbbnEXd/
         TOncZmLmJfHofYY3hETxqtXeN/sjCjtVqUUUpTwXDXvJxWyhHC1+S64uriiAfwQ7CpLX
         uRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578339; x=1732183139;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3u1xBHr8FnIm+5TBiOfl4qNKBgXiuMHQM/YSxwIjxg=;
        b=MoAPgZTsKRKJitGIbLyLMaorThuhJhAt1KbLQj1jfBJ2gSUvsuVLVRUcIUdtrMNq9f
         pbxE+yNmyej98/jNN7PqKuS6F4F22sipeiacxfVbqwU0EANGKGFjUIJ1qtUgOkM2Lafx
         7Y/IMyeqco3iS0aEnc3+egHw15WVSYO84BPo9qFMpuwDcge79xoS6cB9Af+002U4CctP
         8PG3czBirxA4oUagwJV/lpOeyg6uYe5nSKlhUu9xVqDl8A/7jIzCLg5q4nKB0BE1sPtu
         /1koRSd9I1SzDXW92F9RXJLlxwkyOlBJesLKsO6lJ8yjLqWjFPv3rhzAg4LO5jyH0tzj
         2BcQ==
X-Gm-Message-State: AOJu0YxBqaRrZm7Fgiw0nR4edgZiVU87qkzI7VUNi97eZuoCcsXgGII3
	whwvV7i8SV7r/StCZtyudAZwofWkjQuNam1Dcydrfs+xHfxLRo7puGGoyA==
X-Google-Smtp-Source: AGHT+IF2cfgLTn54xPhXO52mCpss7Ji45MW/2KYaFQ19MI7vbvLIS6M5iy6yu0zn9mPrnqWOhCzaag==
X-Received: by 2002:a05:6402:5241:b0:5ce:d53e:f27e with SMTP id 4fb4d7f45d1cf-5cf0a26de61mr20535619a12.0.1731578338932;
        Thu, 14 Nov 2024 01:58:58 -0800 (PST)
Received: from [10.17.102.74] ([217.110.181.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1e3bbsm389872a12.87.2024.11.14.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:58:57 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 14 Nov 2024 10:58:35 +0100
Subject: [PATCH] refs: don't invoke reference-transaction hook for reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-348-do-not-call-the-reference-transaction-hooks-for-reflogs-v1-1-ece7260ee3c1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMrJNWcC/x2NywrDIBAAfyXsuQtZI/TxK6UHNWuUiltcKYWQf
 6/tcRiY2UG5ZVa4TTs0fmfNUgfQaYKQXN0Y8zoYzGwsES242AuuglU6BlcK9sTYOHLjGhh7c1V
 d6KOCSeSpGKX9fJFN0Xt7Jjd7upoI4/AaIn/+9/vjOL4dVqaMjQAAAA==
X-Change-ID: 20241113-348-do-not-call-the-reference-transaction-hooks-for-reflogs-bb471a0b192f
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7w7BT52iwa88oF8n92WnUIJqsEvH5iHLrCGdpyDzBAg=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnNcnZS83bMNv/Ccmm5xNA+f19Z3OF9jmPrNbEB
 cARUqxd//OJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzXJ2QAKCRA+1Z8kjkaM
 fzh6C/4sOfO14WVd0J8HFhQa8Tpze6JJzai0owmZOgzKJgT9/fQ62tAFn6ROhCJvA9aR6bWFZM3
 Cvyjd3Fu7t/wnjOJE6XtTwZ40rfPudEbbvFuL6DODZkqFssVqfIqoZlYKni89DmujpTr4p4gw6H
 bj8k2Jk29mXiltv6NzLlRlmyCyJd19xZASRQnLi4pWRQ5GXl/Tv+GlhLEg4zD7jK7Jb5U8zeht8
 P+LjbByzdt2NrqSJeXaT+PwgTiGFMNL8d9+f7csNbZDGmrXJSZkn/T0XbkfMirPeEpVySGamrFh
 6RlgDbHswZv3Op8M+5nI1dCG3RJX7sTAEqxGzHp3o0N3e+4XuTdwIjGidIy87sJAKAng11QQEos
 zszKz+uQN9WH/P3ly3ZBz1gY5ypLjxYCst/GqulqcfJEZ7ORAS/Daq57y7xaasKeNKpGfDquQDU
 qkEqN+krRoE/LpCOlfWzLLhj1YVEMXIGHW3oEe7WaN+bRfu5XHWEGgXY0tx3k/DB5eCnY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference-transaction hook is invoked whenever there is a reference
update being performed. For each state of the transaction, we iterate
over the updates present and pass this information to the hook.

The `ref_update` structure is used to hold these updates within a
`transaction`. We use the same structure for holding reflog updates too.
Which means that the reference transaction hook is also obtaining
information about a reflog update. This is a bug, since:

  - The hook is designed to work with reference updates and reflogs
  updates are different.
  - The hook doesn't have the required information to distinguish
  reference updates from reflog updates.

This is particularly evident when the default branch (pointed by HEAD)
is updated, we see that the hook also receives information about HEAD
being changed. In reality, we only add a reflog update for HEAD, while
HEAD's values remains the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                           | 3 +++
 t/t1416-ref-transaction-hooks.sh | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 5f729ed4124f7fe8fa9df7fd1f1ce951abefc585..7866cd7378da95b3cdd508500633958802d166d0 100644
--- a/refs.c
+++ b/refs.c
@@ -2185,6 +2185,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
 
+		if (update->flags & REF_LOG_ONLY)
+			continue;
+
 		strbuf_reset(&buf);
 
 		if (!(update->flags & REF_HAVE_OLD))
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 5a812ca3c0b5d3f7de60dc999de6aafaf1f384a6..262efec60e85b7e00def18cce15d5ce15897836d 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -53,7 +53,6 @@ test_expect_success 'hook gets all queued updates in prepared state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
 		$ZERO_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST <<-EOF &&
@@ -76,7 +75,6 @@ test_expect_success 'hook gets all queued updates in committed state' '
 		fi
 	EOF
 	cat >expect <<-EOF &&
-		$ZERO_OID $POST_OID HEAD
 		$ZERO_OID $POST_OID refs/heads/main
 	EOF
 	git update-ref HEAD POST &&

---
base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241113-348-do-not-call-the-reference-transaction-hooks-for-reflogs-bb471a0b192f

Best regards,
-- 
Karthik Nayak <karthik.188@gmail.com>

