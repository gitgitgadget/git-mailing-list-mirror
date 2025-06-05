Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF0202F8B
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111604; cv=none; b=WO3o3S0ejtEYsYJwGYtsdTN960lkZysGWg4kdk7Kqh9LPDoi4x2gSuGKyUeKVZIhvOmjs7prC8VazsT18ThDg3v36n2xCpsI+haM4hsEwsEndNAR0eN7rmh9oklxAJW6oYgProHP54CQpHX4Lo7gvH1p8CpwiahKykC0UhrrcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111604; c=relaxed/simple;
	bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBEJwVPVUsr29LhYAk4RdK6Rvq66wV6KUG9StfMnI6t/4XIKktVAymC44AX3KJ9iTAiWtWohIKkUTi18QA285SZJcjJCq37yDy1QYM5aas+UnhhBnxZDsBNnsB1LOstNmCyGWFzalpd9BH3eImf/tuwqR6CbwQfPS795RZmjw7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/cdVxM9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/cdVxM9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cfb79177so3277985e9.0
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 01:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749111601; x=1749716401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=c/cdVxM9UrDurG4w3LfXHR21wrAo4ipdUsKhTKYfc3vx4aB6UYxEgjNxiJ8+u8+QI6
         BG3Edt3lEUwJ7YwIqYW64izTk3dfj6/0QjItNi25x67cd8NRqSFobFCT4P/lmkjzv6Cs
         QNKUVlfoPJMU+WI60+JcIV/g+PSn6bjQVuZvcyPBBOvw8SNO1+qHTm0jKw3rsEQzDFyh
         a98+M6aSrTxOAsLYba7hbB8zeMoDEV1YS6/stiu1jWwsoljJ0BfmK4dRneUnLqf8YyG5
         luYshIXtMD8Q/cN/71GHY865ocAjlIM6OfCZTtYoBkH4JZmM8DFthjTXbvZ/cfQF7LDp
         YRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749111601; x=1749716401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=P4m7LSOtO3nqbgNkQiwPkTPUrGr0OK7CAIPSh3kF7kfnOG8ksf07OKpZsIfJFNLF3K
         Ed3vhnA36z1+kvzOebCF0LGUK6g3WBhtg6mus+xSXyEfEcCxipvlqR6s3U0Lyqh8lSJV
         +UfYztLcL808gKRI3D1bgux8yWE/zn+i93HRYDxDfBJWaWyT/NWDW4rioLkHtz8W7V3e
         SmBxFHIcGOt4QdDaC3cor83OZ+ordxXpLahdM+L4Z1I6hQyzZkbS5WLLjedPGHLYDdd/
         9mGhUxhG82DpmbcW/ZMYCFDm7rl6PIVj/25Ze0lNd0KWQIEeU58zke40P4H2D0AkKnDD
         0DGQ==
X-Gm-Message-State: AOJu0YylLPZHca1EVzRvVMttLCSC3Z8FdJCyLsPDeE+/YC/xRjGoBdJy
	61J4qKMMpeoYLLAYGSaFTFe7TYCgZdJ2bNLkVdVRTTZkyb97Eofsfgh9
X-Gm-Gg: ASbGncuvZcG5olmV3yvqpx+IG8a5ijeSwWB1qzvq1VUWPtTuCnNcjA0Yf3F9fT5VBWx
	PLeS15EIsdhFEhaAXD+IR0RB4o8RTUjB1B5bA4vWS5xnU2OO4dxI5q57b1HZVIovOvZW9qLGNbo
	mRIixI9U7O3K8zF65hVSYklOwD3GUIj23G2D9YaY7bchME05U6eSfzbPnkhI/NpGM7f7WEt6uDW
	CRTgbCn06zUq0HvG2EEmfaov48hRkCjeHvNgB9rUCw5ZMXjVn2Fgg6juG1FokSMEcubxEfOrw/6
	GRk+G6ZPtW5MF2t8oH+EyW0EbibLpzXXaUeL4KTfjQH7Qw==
X-Google-Smtp-Source: AGHT+IGkWDMx3NcEn6kJT5Z7K+PriHV79ivdb3OSKNehiGu12n3pe3RQKwkK8XL4A1Y6EwgI8Hlyzg==
X-Received: by 2002:a05:600c:8b07:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-451f0b10dd5mr45776825e9.22.1749111600416;
        Thu, 05 Jun 2025 01:20:00 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7449:f1fe:b27a:8a6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178379sm10194725e9.10.2025.06.05.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:20:00 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 05 Jun 2025 10:19:54 +0200
Subject: [PATCH v2 1/2] refs/files: skip updates with errors in batched
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-1-26cd05b8a79e@gmail.com>
References: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
In-Reply-To: <20250605-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v2-0-26cd05b8a79e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhBUy6u/1Q1YIrqyr3rLB9cZBzLyvkAa9q93
 0vY7bMQVnMEhIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQVMuAAoJED7VnySO
 Rox/ldYL/2W0zbvjG9ujuQcVFfgj2K2qhU06gNYhRhMBoRiDFwVLQC4Fz/D9eAJZPz5BjyQrOT3
 BOWXtA182ObhYEAnnA2FpjL3CVKDFWATouyrMuyoQ6eXydNUIXdlaNbnTNWpkfToAAwyPZvgM+F
 DT2H2HvXAO5/S2XmljBb5U3tPRRXC/lNNquNOBItkvn0nwMzG/Brbi+/00c8Lga0VXcPqhFyxDr
 MRvGUjATCtZagheGmOYT4c1ZhZ5vxuVCaA+JKDue3hy3AVSTfQpYC/QtA5lvf3M+cwlix/wuvbt
 OVCSFdsg0BiDSKF42C38iv3sAuG5jteyLMNwXbAg+lQ/FLAyOCRkgAT+soPXBu3W3gDmeki7SFp
 Vf4cBF+ecEdCRmcWjsKwO8/LqvLM+R8tkJVTBgZFyPQNruIuOdoLBxOf2iOUZdQfreYsWGBJHD7
 1j+NLDgeCztPiYBC0658+BmLVGUeLDIH/CY5J/heZy5hUCucbOvCzdVph8Eap//uarrD+JAZO75
 +A=
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

