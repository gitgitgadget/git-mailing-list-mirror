Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03448C13B
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518671; cv=none; b=dmoe8+nb2ljn32GIehhJhQQnC65sjp/8RV94cyUK2oWU5bgqpDrjm/b+RsIZSbGQ849KgLkYIQ0eHIZkD+bEjlIi/k+jEmH5geSWshnkNHLQx0Jr8DxrREaejugMCTgi31Gem9FMXgS8/cHXanpEcTJcUSQ9s30yUCqI7C6C53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518671; c=relaxed/simple;
	bh=D/k+GqruaHy5uFMS7fnJcX7wskn7TUw+VT7dwvVi8as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4rd85X8f5drUrdkDIu8UXTGmGqLfW7IEpb8AfMKi+D5Wc3ZRFAXkZcGQgyw0Y4lgXrcTmB/3Nj4KVpgvHhEMKBmmBItegUOGmxTBiW+1wu4f09pXUj1+sstokWJTpf5kSOiuodmJCoYG8nOsLPGfctOL8c5AjdJcMWXWG1+XYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGR8K2aa; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGR8K2aa"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso766786fac.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742518666; x=1743123466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJY16DkN46gMUmDLS6j/PKhieBu69FFxoI8wLStdmAM=;
        b=cGR8K2aaXoUSi20MWVIH8Q+Z6VHLUxXfd09crYAcP8HomKuJgKLUl2ADXm8Va7aFwC
         OBnvxJ7JmZkJ06wHLa4WRFYVqQSW1EMPRQFCr3RFjaNtQpu3OoUguWMV4A4bcsgC76dg
         qnB3mudbn41uMv1gUrVLO3TDQuy4gm4PuX7ZjARCenpUUMd/GqpKKHoujfnmHBqaM4lK
         3LM+jwrczaEkRUoccLp//N0je8+fxMHpEGlcKC8w2PgCrUEhXnCR4uaNHv4UhunoWIaA
         SECv2INoNaDCsqocTcod7epxxvkRD8d6NDKBGKVJNHnsUHJO3Sz6Z4WZrngVLT6YatWp
         1QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742518666; x=1743123466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJY16DkN46gMUmDLS6j/PKhieBu69FFxoI8wLStdmAM=;
        b=VrkDlXWn0lV7i7VdwWv7Ib40sdq4D3S4BEH8ZkrvZfhCPTUUKq/pDCUtoh8ta7d9sa
         9ijIAZMJPWm3OmmQ13ZAZaEAA60Dl8E/XzgTttXEmamU6HdB9bCZzCVWPbRoz086WVzv
         l7wdPSw7chk8yb9xLTjDZvhE2HLbUDwdMabv8UQkyayPG6HIDj3lc1R+Wv1uTS/RK0M7
         sbQ0PWreZQ47SAz3iJGMenpzKgrUhYlAdscgheQAAj3E1rthrWcy5HT3Tz5natXj+jSE
         TZhXymzQI1SVBWbK4lTuW32T1qCFNdeRzlfmE68xchZQZK8WoYNGEkoC0p+LXkIEfeGI
         0fMg==
X-Gm-Message-State: AOJu0YzJbi6/ulXPLlkVDOPcd6hNBqs4nkBVsspkn7wFtZwHm5nftuWj
	RXX7XG/igo9T7xWZ0oRS9L+BZXDLoBKqC+GUGle6VsTi6iy+amYyTP1ixQ==
X-Gm-Gg: ASbGncsEbwwVGTraKkvf6qfeor8ELl1OUpGpUJgndQM3y692InrLgxqsdeu+VrWH7Vt
	0Y+zxoC6mrdxM/OPq0aoa2Nwv77udVF2DF24hiPrYFzRElRBcD/6R7HzsDyO9P39JG9KZmq8EMP
	7Vo9PEpIIHg10Iu3zwT0wFWveToG1pZ1O8sF3uKY0PBMRTn0O+zeXpD7yCao8wgvB4Js3BrFX3B
	+K/b9K2VApoivEU9j+vMXPJmu8hsNQtissii98x9s0lHyu0fOhJpixGqztJLV4INvlATl1dV1Nb
	qrSR+XXxw/KoonLV59+6cwNM95HjrPOBUX9Iw7wvI6Qs6S2vcGG5
X-Google-Smtp-Source: AGHT+IFm/NophmZBn2Mo9mLjoFfgZM1WDLOdcNXx6qQm7V7OPFTsRgD5MrSX9RxtnIh7ofvxtgzMjQ==
X-Received: by 2002:a05:6870:cd83:b0:29e:2bbd:51ba with SMTP id 586e51a60fabf-2c780288fecmr1201227fac.9.1742518666353;
        Thu, 20 Mar 2025 17:57:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abcc17esm179875a34.34.2025.03.20.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 17:57:45 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	likui@oschina.cn,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] builtin/fetch: avoid aborting closed reference transaction
Date: Thu, 20 Mar 2025 19:44:37 -0500
Message-ID: <20250321004437.505461-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
References: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of the reference transaction commit phase, the transaction is
set to a closed state regardless of whether it was successful of not.
Attempting to abort a closed transaction via `ref_transaction_abort()`
results in a `BUG()`.

In c92abe71df (builtin/fetch: fix leaking transaction with `--atomic`,
2024-08-22), logic to free a transaction after the commit phase is moved
to the centralized exit path. In cases where the transaction commit
failed, this results in a closed transaction being aborted and signaling
a bug.

Free the transaction and set it to NULL when the commit fails. This
allows the exit path to correctly handle the error without attempting to
abort the transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

It has been reported[1] that executing git-fetch(1) using transactions
can result in an unexpected bug message appearing in some scenarios
where it previously did not. This issue can be reproduced with the
following commands:

        git init foo &&
        git -C foo commit --allow-empty -m 1 &&
        git clone --mirror foo bar &&
        git -C foo commit --allow-empty -m 2 &&
        touch bar/refs/heads/master.lock &&
        git -C bar fetch --atomic origin master

In this example, the reference updates for the fetch are done in a
transaction. Since one of the references is already locked, the
transaction is expected to fail, but an unexpected "BUG: refs.c:2435:
abort called on a closed reference transaction" message also gets
printed.

This issue bisects to c92abe71df (builtin/fetch: fix leaking transaction
with `--atomic`, 2024-08-22) which changes how transaction cleanup is
handled to address a memory leak. This change starts relying on using
`ref_transaction_abort()` to free the transaction when an error occurs
during `ref_transaction_commit()`. This is problematic because
`ref_transaction_commit()` always closes the transaction and
`ref_transaction_abort()` cannot be invoked on a closed transaction.
This explains why we start to see the `BUG()` message.

This patch takes a simple approach to fix the issue by explicitly
freeing the transaction and setting it to NULL if the commit phase
fails.

I've included a test that expects the reference transaction to fail when
a reference is already locked. If the `BUG()` was still being printed
the process would be aborted resulting in the test failing. This test
unfortunately relies on the files backend to create the lock file. I
would prefer to be reference backend agnostic, but am unsure of an easy
way to exercise the issue.

-Justin

[1]: <e8789a03-41ea-42e2-9f2d-5124b849277a.likui@oschina.cn>

---
 builtin/fetch.c  |  9 ++++++++-
 t/t5510-fetch.sh | 13 +++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95fd0018b9..f2555731f4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1867,8 +1867,15 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 
 		retcode = ref_transaction_commit(transaction, &err);
-		if (retcode)
+		if (retcode) {
+			/*
+			 * Explicitly handle transaction cleanup to avoid
+			 * aborting an already closed transaction.
+			 */
+			ref_transaction_free(transaction);
+			transaction = NULL;
 			goto cleanup;
+		}
 	}
 
 	commit_fetch_head(&fetch_head);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5f350facf5..690755d2a8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -537,6 +537,19 @@ test_expect_success 'fetch --atomic --append appends to FETCH_HEAD' '
 	test_cmp expected atomic/.git/FETCH_HEAD
 '
 
+test_expect_success REFFILES 'fetch --atomic fails transaction if reference locked' '
+	test_when_finished "rm -rf upstream repo" &&
+
+	git init upstream &&
+	git -C upstream commit --allow-empty -m 1 &&
+	git -C upstream switch -c foobar &&
+	git clone --mirror upstream repo &&
+	git -C upstream commit --allow-empty -m 2 &&
+	touch repo/refs/heads/foobar.lock &&
+
+	test_must_fail git -C repo fetch --atomic origin
+'
+
 test_expect_success '--refmap="" ignores configured refspec' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone "$D" remote-refs &&

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

