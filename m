Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BF1F03D4
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748858262; cv=none; b=Xjxrh7DXWgukqXuvcwWWLpXulDQFuD01dkxZ5qRdl5vZ1I5vwqFPqFzuYdXfDW3gBnfTGLxHc43R3jvYy7Ftdtt8z5z+7Hp3e7PIrurBi//e1mz6SPMyG5WkxuER9DTdXLw6vlePRpvu1uZU9UjS+RjAgJIAkuGy+vaAyYsoWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748858262; c=relaxed/simple;
	bh=p/DwbU3JEHwbQFKFmziE9EW5LOfV1NJMr5ukioyH1aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAAbKhIsgZ3rdj4Q7kNfvZWsg13E4G7/+rGoz8mRcLuIq4Tmcca2dpxehbVz5awdWNSIcJ7EYZYJIPTZjeJxwph+p0bPwyLNTgDynG6yjCyglVTn7QpuTWc02t0FiuQOguqSYtYr4RnHF2eKNb2gn9IxS/lf/wdu7QT8yIxfPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkjP/8yp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkjP/8yp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604b9c53f6fso8422170a12.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748858259; x=1749463059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x04ZC+o095ZLmIwOJKcJvNNEgQpGPYR/vvmm1ZmeIas=;
        b=WkjP/8yph8AaNIKASWYp5bJg6ML/yhfHgQpatCTyRvq0kDfnlmsKHAUmVzaisLUwzh
         hU1gYYlPzXkhB2w7xgN8GY6fA5LSm6tQp9Y+F+FwmEYF9DjwHcUVkqXZhedm6KedR0o2
         sy7nSTmgF0GBrvSksYwUBwIQhGrxScwD168YpeGwjE1QWvvl0QSvPwaml2nY1C3kMxmr
         ceiZKDgNsDabs2zpPeFIzggyKhCGJHKb4d4eyOqanRfCPlFkLtRKeOnBODb3lES5r/Z1
         +OlMMkKPGtEfFKMLoZeN3KcmBkdqwAhPSFnX5LVE+4rCoeWViZG1hJAyE+XWVtOwCIi1
         iCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748858259; x=1749463059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x04ZC+o095ZLmIwOJKcJvNNEgQpGPYR/vvmm1ZmeIas=;
        b=CjVp32upUVvEmZ6tfCDr7+DzFdwfOZZNAY2yH7kyiRqT9uav/rsdliayzW5xI0CM6J
         3A3+JaDMSYIQ4CzEhahRGQ6xhIl5pKl7Qz+CfxVyEJVUoh3ezEqYmJ0TTVGNctTgS0yP
         x16CKhBYUuGW4L1ToM8dSHZwMfHFwmJhyaObmrwPH1TYjx6U0DWROOO0iieohLwrkTSg
         l5Fmy7WiwntKpGIMT7D1pQ1RCODVXyM3Da/pPTrEcqmJ118mBv/aTwgAXKX/WwgQVIFD
         AeDZYybmr0jBpE6RnDLIyawPNp2FVsI89xtO41y9NfF7lrZAgqoVcalQeV8VyHM/WbKa
         lMfQ==
X-Gm-Message-State: AOJu0YyC90YMk/niHvlPeH1JX4ok9Y1hemeR3Gk57ggGPd/7CQSZ9tbx
	pY3W5O+Hsb8b0v6kkRl538CWpMWXG2cYpZWRahwKy3J8vENWUr70F1uKDdOgPf8F
X-Gm-Gg: ASbGncuy+5ZBWL+JB+qi/9d8HEyB9d650o3na0LDPz2IOYcMAQVOG7TqDsW5YIWC9B+
	A+FMj/We5t0J20vsSuUv+yAn0G0eLxGQEdp7kW2a0jAsvWi1fCqVb8BuPyj26fX8va8EZIkQtKt
	W5YPJRNCRZjXap46Ra7uGyxhGjcB0Gp4SFchtBiG/GTaX0I10GJKh2Ta1fGiKESCcJZDumcvkDr
	vgpfcMBv0tlxvMN/z26HVQVnBP6Goe3IoFO4iKLSrOb8U07IQmPpJ2/YqFCv3fWynmyuFRRKB23
	CCuYQ+Zx/07+UsBldNLgENAjYp4oTail07gYmN/d6q3E/w==
X-Google-Smtp-Source: AGHT+IHt6ztbmpFrOTMVVc2cQrQLimwk3i3dx9AfwgliPAD0kFNyJ0rYIVDGw7k0rULLrmiDliu7gg==
X-Received: by 2002:a17:907:3e1d:b0:ad8:9f9d:b139 with SMTP id a640c23a62f3a-adb32248b73mr961273366b.5.1748858258812;
        Mon, 02 Jun 2025 02:57:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:760e:bd06:5a20:3b6a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6ab2csm759665966b.184.2025.06.02.02.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:57:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Jun 2025 11:57:24 +0200
Subject: [PATCH 1/3] refs/files: skip updates with errors in batched
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-1-903d1db3f10e@gmail.com>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=p/DwbU3JEHwbQFKFmziE9EW5LOfV1NJMr5ukioyH1aE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGg9dZAhVJhKn7bG6SNscBCQHukirK6/LJoJ5
 7w9LWyXf+kP5okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoPXWQAAoJED7VnySO
 Rox/6zUMAJjtogpsZlJgG+J1gDpQDBvZgqE+odobk0kjZRWh9f7xsn7eJTfdlF1Y5eEQJeKflLT
 Qrw58WRwTKYMLF7OLTcTeGfGyTyeha9rKyGGnCHBApTwDOflvL3qDbKo0+OyzXEh3lsc9wcVOXM
 h756dFjxJx8KY4bOXeMhEl9yepRLgO5i8oFqPpSDeg6Ox26qR2wm+4T2OFM4yDo3Khhqd03A1li
 +bWC9CS99OWWK/oJiJM2GISz23FD59khAcdvYVcte2WJa8sl6VgMbbV+OpfOb0pfpXEnlOqB8J9
 qSjWCnh/I/sAPadq7S+2OIzFn6k3T+B4worx9mNtbKRu06DJ14uKYkzo+p6DCKvDtP2RDra8xiA
 fYttsP8dH71RUm0plFyqqF8RjSBijqpoegqWk4rQxRQSnllhLrv+bWcKATIgevQjjzezAEZ64du
 reEPcKkSed2TEezpGSGq/ByVw7CbpoUVH0oJvPXJmz2SChERMgVtnxnJ7jLjx9Scp9RrsbYg7A6
 ng=
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
 t/t1400-update-ref.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

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
index d29d23cb89..e9a605d0ba 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2299,6 +2299,20 @@ do
 			test_grep -q "refname conflict" stdout
 		)
 	'
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
+			test_grep -q "reference does not exist" stdout
+		)
+	'
 done
 
 test_expect_success 'update-ref should also create reflog for HEAD' '

-- 
2.49.0

