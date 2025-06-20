Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432361E9B0D
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403754; cv=none; b=DrURmO6E2PPDV5NTfnO67+4HMI7bPDxdCZ/EZ+uofiNVy0an1RuSivIbdrWJgeE4ABI5G00Nihr1LL7LDD22p28kJJ8Qlqc7B93B+nZkmSvFguu6DVOmWOxgLEqKCOVdlziprWCY9qM3+s1mHF4zyQSJPGXp47KD4oL/JT0fQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403754; c=relaxed/simple;
	bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPr56DzJeLRW3r++iiqcwb9PpMJqtuwPKFlgnLFQ0VZk/ZFNOf5HaySyPQB7LeRhyrXGn1wHYkhxAKxPztm9bQzMH2o+j46oWmsz8gxpZwQ+HHP3vgzsRVGFdAH5h+EHQfkfzzxOBZpqfQLXSuja3PY7VotlxIHQTTAUn2XPnXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK2d33AY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK2d33AY"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so11409645e9.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2025 00:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750403751; x=1751008551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=OK2d33AYOOWo22VJyVBM0hWMrmLUQkeD+aA5tk9vXstBRiFv1xYz7ID0LZfAjAn02E
         abzzauHZ5IhHokpIFt0PTLEsGPJta8DGrMQ65I5xKO0CL7kj12kwrl0SH62szjuF2dk3
         Clr02x/ST74uXjscMybLdv6qEP+g7PnaSusyUzMRPcQZrUiR62Cj91virntBIUbzhhO+
         yh/2Ty3F9Pz+NJOLzbjaKlTD3cjCVhvG6JdY8nW3kVRKhIU7UPHHcmpUugrT1YcC0z+Q
         Y1qg3UUwrVAg4dMmIWgMtyzsdqvUXq/5wPbJUc8SQjSgMXNUa0nVR9OlCOZbz5ADuWPe
         ZUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750403751; x=1751008551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=qlcNGx52FBh4E59grwaPa0Drwgu9OG7FsQbWIXD1aqB4Ku27Yp9wn/ZahKyH0rR1kU
         TG38fz7+nSEUyi+GZa8dDdVpj6VZCVveRvGnn70dhofvtyaWgyABHSr+DlSVHBH/IyYk
         qgkGdixI2IwpueuJBsK0X9JDzBcfh2SM6npGjUU1D6SWTHzKH5OU+WzVMSDtFKk7yzca
         /0RHTA5NyZX4zX5YgM+CTBKiPnqraqIksloopRq8/3bwZrHihBfz9H4apfLvAZtY90JH
         TzAlQtzg8hsdwunSCcoSAUE2t/ONDuamZsursOqym7H1HwHT2/uASQNPqiIXxyABgUuR
         zh7g==
X-Gm-Message-State: AOJu0YwKQDdUQRgcHI7xf744vw2etgIKjZXklna0nKzW1ni4NedU+GGt
	ZBzVievyYfGrgYyWAQ1ZW1+ZcpFyi/Gx87bh+Ye27qgef+ZclyvEe+q/
X-Gm-Gg: ASbGncvBawkFVaqZZHrXXxhiNwvaFrMbAm33mQXpjkbCSStmsTJOktlTA64V9MlaMRk
	4aLk0lIPVC6/zEyRhPx9Dn6mPcQVTwaSZ0ORcYl6W6ddXQVqc5xaihrPOigo/Wl6rZC+xy9ZaR2
	sPtBZyXKNrIjf/6cPF3zBSrngjceXpP5WMXL3dIHKNWLcnqVafQ4wON5FBXGkvYBy3SwQl3gZ2q
	kVMmh0gtmlJCh+KaM7gHPJw7BUQNXwtm3lfgGxCrZ0aAeaCnDk+j2EJMzkSG/ASlUFwTWI2+0sh
	EBxU4zdbfiQloSfRLQ28huc8XIljLmzshAGV9BBlRKYW2uzFUZDN7jSO+9iRqJf41LAPiTAiXIM
	N9/Xrg0vUhOF711PlHJBDs2xO
X-Google-Smtp-Source: AGHT+IF5cXngJHTqwbCHgrsSMcjdERyDWQieeNpUPttAIDmd1FddELLrEfo5xwAyKRx8kzj6sm/Gvg==
X-Received: by 2002:a05:6000:310a:b0:3a5:8cc2:10aa with SMTP id ffacd0b85a97d-3a6d12fbab7mr1117973f8f.32.1750403751478;
        Fri, 20 Jun 2025 00:15:51 -0700 (PDT)
Received: from [127.0.0.2] (bmly-13-b2-v4wan-168438-cust286.vm4.cable.virginm.net. [86.24.93.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c66esm1217101f8f.47.2025.06.20.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:15:51 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 20 Jun 2025 09:15:44 +0200
Subject: [PATCH v5 1/2] refs/files: skip updates with errors in batched
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-1-f35ee6b59a82@gmail.com>
References: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
In-Reply-To: <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhVCqXqrR5hZJxOJ6ZkG/VrerNMGBZuWnsS4
 4Rs9V+doQ6QIYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoVQqlAAoJED7VnySO
 Rox/+1YL/RYbYY2xAcimyG/QDb7sz1jk0nMjG20RWUFdE2jH4o3ontArTFY/6N6tg7Nn9zkQgn3
 KMBtPHY+sKy731n2vIExKjWYJlsXYIWnSVGaBculJ4mjps8GkuT53z5d8s9sQCJnhPFPT4hSpHx
 dBFjNy+/wiAmjVKGWXC2dXTUdd5YJrPd0hHe/u5G4caW1zGvqAXKg2RUHfnjQBTJ1htLNB9yLuk
 EhhYj1RZxkV+ERJ1nUWGiFAvabVBPdlG7GeZ0YM9QgfoDiYnEiXZO0abe3qY6RTQQH0hkn+Mnb1
 9Fu5b7vh8TJJwr3lSDpEo0Ui9Ek3gOAchS9VLugNiO7sbLzW1cJhR8CIweakWQN5/9e7YsloQgs
 CZ3dSQ2o1BLrnN9hnDa8tPzxHlBt7mieNLZXogczo1kC3LzJ5rC0/TYyc1bPXQQnG1zG67QJVse
 1ZwoBT7LwrYe0tUitdcR50M/2PxqNNqnwr9GnZV65uDydqq+UsFqUEHZ0eKgM+89sSCl6SoWZg3
 q0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 23fc8e4f61 (refs: implement batch reference update support,
2025-04-08) introduced support for batched reference updates. This
allows users to batch updates together, while allowing some of the
updates to fail.

Under the hood, batched updates use the reference transaction mechanism.
Each update which fails is marked as such. Any failed updates must be
skipped over in the rest of the code, as they wouldn't apply any more.
In two of the loops within 'files_transaction_finish()' of the files
backend, the failed updates aren't skipped over. This can cause a
SEGFAULT otherwise. Add the missing skips and a test to validate the
same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c  |  7 +++++++
 t/t1400-update-ref.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d1f65a57a..c4a0f29072 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3208,6 +3208,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY) &&
 		    !(update->flags & REF_IS_PRUNING)) {
@@ -3239,6 +3243,9 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
+		if (update->rejection_err)
+			continue;
+
 		if (update->flags & REF_DELETING &&
 		    !(update->flags & REF_LOG_ONLY)) {
 			update->flags |= REF_DELETED_RMDIR;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d29d23cb89..ca7eee7de2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2299,6 +2299,51 @@ do
 			test_grep -q "refname conflict" stdout
 		)
 	'
+
+	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit c1 &&
+			head=$(git rev-parse HEAD) &&
+			git symbolic-ref refs/heads/symbolic refs/heads/non-existent &&
+
+			format_command $type "delete refs/heads/symbolic" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "reference does not exist" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates delete with incorrect old_oid" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit c1 &&
+			git branch new-branch &&
+			test_commit c2 &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "delete refs/heads/new-branch" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "incorrect old value provided" stdout
+		)
+	'
+
+	test_expect_success "stdin $type batch-updates delete non-existent ref" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit commit &&
+			head=$(git rev-parse HEAD) &&
+
+			format_command $type "delete refs/heads/non-existent" "$head" >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+			test_grep "reference does not exist" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.49.0

