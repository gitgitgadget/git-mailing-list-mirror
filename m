Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245B11A08A0
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727119887; cv=none; b=gHFPRsdT4xlzVw1bYQWTd+DPgQ+pGprr0pgB86+56eITRotM8vw1hR2ya8i0E/5agrJ1YGk4TNyVAoEGOm0MZIZm1LkFZBAEhCc6JVcHDn38sfJ+18/p+aKH4TNwFa+PW2HQNzmHF+NloN+Xw/RkBIDHS91yjYXpgYD6NyirtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727119887; c=relaxed/simple;
	bh=lQpvHEbCXzjX6d/cnP2hcGjKrRZgohelcnVj+rm01gk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JfDxmZBo2He510FIhlSxu6d4uNE43jReH1GlCFF2s4D4Jr1xICCVRsxwCDocFCUulBawP7ZhwmAJILU0LqF7mRiw6GALA4d1FZ7mYxC3+qF8EKe8MiXJsfSy5w3KjHRRKYngvboluKpR9Af98rveFo6W77ZgoteIcUUh4lFoEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKsdXcFB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKsdXcFB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so678994166b.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727119884; x=1727724684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jF55GzDFPzozdUK+vBRM0klXDe3EY0fgfnHPxGXnRjs=;
        b=ZKsdXcFBV+WQHqGDOQ6OdWYM/+ejslm+bJFfINZHsH1vBkcSzGRbu1L3PMk2KPxtol
         WEdK/mGMiAZzxuTVEei7fs+tK+o2utlroyjO9XOHKVGHKgPqyFGJvJDUDtPftpbwFIT9
         q8bZIVmXb+eh3+3Yez9sREzar1YwANP8QhWCW3oRK7twOsmhncJ0s6Vpbb+auZs/5cUT
         FUa1WjTOJjyQ2Gsl23P71S2mL12KyzHPk+p+af5iDvMkSP2CwjlZaaBrhef2gyfJ9Prj
         XJ/fbycYHtFnKWg1/LJlkVsrGZGqgKVIy2EWoPofNRRX/GYKMR6L/KuDU19pBQrT7qMR
         Frzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727119884; x=1727724684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jF55GzDFPzozdUK+vBRM0klXDe3EY0fgfnHPxGXnRjs=;
        b=AjNLEVS6w1U2zSerZZDX9674FvSdjdjET03O7IMIqGi3XHC4lcKn5EOfLgIZHA03c3
         Ya6xEkwE9rL4pP98gjYv/ODs1uhyztZS4dWRKV7TPW9vLaVWerWcYOeHBy8hAjueplXR
         xKR3Ym27rutEe+3jmH4ajUxB5DkJmm+D6UeQd16mWNlYH7Pm+NNkntJ24lMn1ZZ9L9Q3
         iwDbj69zqLhhbLghtOGtOz1hc8SrobKReZR7nMEzNWjyQIgQaK5ftWacOK3NbVutvLS3
         Vc+xQVIG15BVnafpGWu1XDQs09mBTHIpMb1sfgx02MTIRJckDQMv6XZw4LgOAJA5CJDb
         DCrA==
X-Gm-Message-State: AOJu0Yy9Qw0yLjkxOnPQdtfWdsvq0txHi78VVOpZ10+sJq+jmnXctkZD
	2Hsccv4wkBEaO8+KRxAEPe+O235GRMgLIv8fm4jDGqpxnzCilixmRz96MA==
X-Google-Smtp-Source: AGHT+IH6pB7wrKTJuhXXJqF0kkmMEcpIwTyN6fbl8aavFNTgnQnU/GDqoHN+tQr+dT0vIf0trIPjgA==
X-Received: by 2002:a17:907:efc7:b0:a8d:439d:5c25 with SMTP id a640c23a62f3a-a90d4fdfe99mr1366347966b.4.1727119883952;
        Mon, 23 Sep 2024 12:31:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330ab8sm1254538966b.195.2024.09.23.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 12:31:23 -0700 (PDT)
Message-Id: <pull.1800.git.1727119882901.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 19:31:22 +0000
Subject: [PATCH] sparse-checkout: disable advice in 'disable'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When running 'git sparse-checkout disable' with the sparse index
enabled, Git is expected to expand the index into a full index. However,
it currently outputs the advice message saying that that is unexpected
and likely due to an issue with the working directory.

Disable this advice message when in this code path. Establish a pattern
for doing a similar removal in the future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    sparse-checkout: disable advice in 'disable'
    
    I found this while someone was demoing some behavior that included
    disabling the sparse-checkout feature. Having this message pop up during
    that interaction was embarassing.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1800%2Fderrickstolee%2Fsparse-checkout-unset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1800/derrickstolee/sparse-checkout-unset-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1800

 builtin/sparse-checkout.c                | 5 +++++
 sparse-index.c                           | 5 +++--
 sparse-index.h                           | 7 +++++++
 t/t1092-sparse-checkout-compatibility.sh | 5 ++++-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 5ccf6968628..85b4fc06b35 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -924,6 +924,11 @@ static int sparse_checkout_disable(int argc, const char **argv,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
 
+	/*
+	 * Disable the advice message for expanding a sparse index, as we
+	 * are expecting to do that when disabling sparse-checkout.
+	 */
+	give_advice_on_expansion = 0;
 	repo_read_index(the_repository);
 
 	memset(&pl, 0, sizeof(pl));
diff --git a/sparse-index.c b/sparse-index.c
index 9958656ded1..0f9fb4df026 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -19,9 +19,10 @@
  * advice for advice.sparseIndexExpanded when expanding a sparse index to a full
  * one. However, this is sometimes done on purpose, such as in the sparse-checkout
  * builtin, even when index.sparse=false. This may be disabled in
- * convert_to_sparse().
+ * convert_to_sparse() or by commands that know they will lead to a full
+ * expansion, but this message is not actionable.
  */
-static int give_advice_on_expansion = 1;
+int give_advice_on_expansion = 1;
 #define ADVICE_MSG \
 	"The sparse index is expanding to a full index, a slow operation.\n"   \
 	"Your working directory likely has contents that are outside of\n"     \
diff --git a/sparse-index.h b/sparse-index.h
index a16f3e67d75..727034be7ca 100644
--- a/sparse-index.h
+++ b/sparse-index.h
@@ -1,6 +1,13 @@
 #ifndef SPARSE_INDEX_H__
 #define SPARSE_INDEX_H__
 
+/*
+ * If performing an operation where the index is supposed to expand to a
+ * full index, then disable the advice message by setting this global to
+ * zero.
+ */
+extern int give_advice_on_expansion;
+
 struct index_state;
 #define SPARSE_INDEX_MEMORY_ONLY (1 << 0)
 int is_sparse_index_allowed(struct index_state *istate, int flags);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index eb32da2a7f2..6e230b54876 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2355,7 +2355,10 @@ test_expect_success 'advice.sparseIndexExpanded' '
 	mkdir -p sparse-index/deep/deeper2/deepest &&
 	touch sparse-index/deep/deeper2/deepest/bogus &&
 	git -C sparse-index status 2>err &&
-	grep "The sparse index is expanding to a full index" err
+	grep "The sparse index is expanding to a full index" err &&
+
+	git -C sparse-index sparse-checkout disable 2>err &&
+	test_line_count = 0 err
 '
 
 test_expect_success 'cat-file -p' '

base-commit: 94b60adee30619a05296cf5ed6addb0e6d4e25dc
-- 
gitgitgadget
