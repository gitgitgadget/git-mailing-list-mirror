Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40241E47B3
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749199291; cv=none; b=dVJ52TtsOS8YXYQiy42L2IwUSsjveZTPrH7NP0HsySFhYlnarMm9c6hRePLptns1JvdXJsAciXnWQ88uASq30vaMyVKV0uJJn99py2hDNZOZ/kLYVhDKuZgBHnBapfSnQkaSVuOcXEXnEsWkWIBkAWxonvTUlnq4P9KMWxMDbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749199291; c=relaxed/simple;
	bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXofMoiS/lQoNSH8Hicwm9oqiawnI/TK2EobD+rhzlLWRjWAALPOMm3U2VSvuEiwP7xcHqGLroDSlteq6Fri+Gd42ytk8OBa0KDNW6dhMOysNvv4/i4BrL8hy1KuG348up/KRoJR1145wf5FtqFa4LPMGwjZX+gSjE30uZejPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOPHBmuf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOPHBmuf"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60497d07279so3502681a12.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2025 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749199288; x=1749804088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=XOPHBmuf5wwSXnzJiI1lwVL0RMjzx9lYL1TasKjmQKl+AOO1yrmb8UVSQ1pzfIOmQd
         IEMetTgkPIL8ef8I08pmcTcQ5p59L8JuEUFY00JGg4GO2Qd2+8KAmGdifwrNIGeGsgZG
         oWVdymdHtG+3xynjmlLk1dUdM1VXO/Lv0DstP3R6CFcMU6L6IgDgxdwnnIl2FhRamNLj
         8szxjJ3tHIfi29hus18XyJDjDwSlt9LdUyMM6isA2pU6mrt5hTHBgaqctmlhn6+3PCnN
         mbC+QsBeb++06eB61YnDPCeG3psQN9ltw+l98qCbOHeaupzsVh6Lw53czNxYLKViDNM7
         T0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749199288; x=1749804088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABqrWlWo5IkJnKbUky5FOgl3RMkGIX7rQBbYykTVxlU=;
        b=CFVxP+cu907nCW6wKx8K6Cts3JiJRe5bfclUmf6zpgCXFkJwKyrJuIu88hdm9T7tmb
         m9Iy93DCt7tNDlM+0edVlHfuIlNFPSuen238vXJrwt2gv1hohwGsuOrcP6yCKXDGXNQD
         K0KAkpTYZHlY472emTGT5KpiSt6nYxvm8LHrHNXUHu2hS7/MmQFwtN7aC7AhD3z7EMbh
         LK/r6oGlsZaywsyE6MsqNjuhNowBOeS6uETe7FUo0OLrWcZoTgsldjvyqwoIuw8+zFe5
         6RTBcf7TDbgq6SazEUe2ClRodYDw0j35jM+javsJ4rPCsZAsThIIzbsyHlzg/7aDbWWo
         wyhA==
X-Gm-Message-State: AOJu0YwSctbSy52HBBagOXYRKOl+gTWr3Z6GrLC5gbMWER07oSAhBebi
	002dfRPq8p0/jDZf+3SWJZO1ZWNc34CV2sNNNTNCGZLt8oRvnzE9juYp
X-Gm-Gg: ASbGncvJ9J72LfDe+b4+mqbnKDtB4VdKNKRKyTeIby7TuZ717ufBB+ZpDrdyFy5cTAg
	m25HD+AEFfXxUjUs8n8Ed4DSMXyOHzbZ2Cqb+fJKif1JjtcIb0ZzBR9jTADRRZX/Xcmcku6o8CL
	M1aQU1ifhwfmBU4Qw7vjeHMo+Mjon8DJnAlUu2lTdr/7Tl8RRD6KNARshYviwh58P/mNnpsMEon
	2wdfzCE7NYxZGwabOhUyLohIZ0VTgikv0+0/8i/qh459OphbT3KSoF/AT5oFB2g5jzxVEJVUafQ
	4DBA/dwK+aZ0pLjKZ3daBZ8JkY+nH6feXU0=
X-Google-Smtp-Source: AGHT+IFUx/4wHiOMXFHffURu0pAEddRbGmdl83QA76OE2pxg8WaJJokeuzxuPARUnKZRsY7h04pDhw==
X-Received: by 2002:a05:6402:350e:b0:5fa:fcda:bf57 with SMTP id 4fb4d7f45d1cf-60773ecefdamr2156372a12.17.1749199287743;
        Fri, 06 Jun 2025 01:41:27 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:1baf:dad2:9556:ca27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e654asm706910a12.69.2025.06.06.01.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 01:41:22 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 06 Jun 2025 10:41:10 +0200
Subject: [PATCH v3 1/2] refs/files: skip updates with errors in batched
 updates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-1-e1c41693bd35@gmail.com>
References: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
In-Reply-To: <20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3525; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WbXjCpPzVlMg/veWMid7cyAOfkl9HaPq/7fAtHB+nrQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhCqa4ggnTlNfp621CIG4yEF0zxqb/acmaR6
 E1AXBJnTwiF/IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoQqmuAAoJED7VnySO
 Rox/S2gL/0V7FYumTd/38tNwT4vC5TC981FivnOAtmMPPABfSPbc5REDS2cX+znTZdRUwYXOTOf
 M8/Qe0+5zQ7Z/9swPQpNqJfUdYt/zTVxaio2B8K+gzkiToskhNA8MzP4sC9R/1MWxdYCjfWB2ct
 GaYSuJcw6GM4nfwxe6TXOyA7KZ2bkz9HyBH0z9jX6bnf6un7LHO18KYCZLzSKgRiHRzbrkc3kpW
 YGFYaQCnYZKpAP9Iw6Kiiljzi3scKJ3d1NsvfUBsaUoxm9kKkj/qgORDQ/20rI7v3v5zlI7uAXj
 hVD9kxngwtoLgBLe2wJck2uSW3SN3YjlNrEcv6G84WwZzFy9K6vbMKsu5XRcTAggsC4PGxktJcN
 BAGoMQ1LMbHAN75Dd00UW93nyF4BdJv41hPW0HoZAEj5vQH6MuTGIEG1tzO9P4bO5/BNncKyRjz
 nAYl+ENyYhPSYG9usrkhefaWZTP6a9UsQoYm/bi5Jde4P1DdREyVBfb02xvNIKMO0g+Rq9XgbV5
 v8=
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

