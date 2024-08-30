Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B61BF7E5
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725052250; cv=none; b=BUrs28MQxlFTcLUKCCmIk1IypPQ0G8/cex2YRC9lwM9xLM5Rb/dK+XiPtK4MVqI4djFtzeBSsmR+iVMk3OYmsaRDKMzrQMeYON1D7Sjr0slTTdgCecx1HYCDK7mATuEXkzG0jVyXHXC9tGkuJhF3ABYsg6NfTSiro+I0fgn5oGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725052250; c=relaxed/simple;
	bh=hqERkU8Xv4p4J68xvsqCxpbXzO90U+55m1cyNyH8Lj0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kSfBr9T9BLHoSf/ukhY+/DU4foHkR6AYFqWEGryBCfA1iUx1CjxccexA9AJWcw4dPDy72kB/DkTuYDG+o7/nHFnRZHDElQK6JuVGZLQB/+TQR8l/VnfmChqSb+ex6XHWAQI/5dX0JPZR+Sm0I4coaqDQeuJwRwLvva+rW7RI7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPrVsPI+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPrVsPI+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53349ee42a9so3076842e87.3
        for <git@vger.kernel.org>; Fri, 30 Aug 2024 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725052247; x=1725657047; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKkzs1Kz9im3O36eraNjz8vseVQfkUVd+C+hugEctJY=;
        b=UPrVsPI+Qw81VldinNVnC595n7gZAsj5ifhcOeFun5j5vEE39n+JSokGUCLTK4NQs7
         id7FelHuSr6hskOmENVnw42BViRAoOcW/aWQj286w/N+hg8ZXzRkF/m2Ct60Zd9bvBll
         cj4JT0qm+rmi+C1ZY8nb4b+wxuwmCEWnxiSKys8HNs7DgI7Ryddk5xQ+5ccq/53LK5el
         sJrEnRfZ+THKKTRTSm2t9BbXt4U7yFS4erSJ+NFPoRT2EAxgzLBLDRpc6HN1yKryKo21
         4KJgB5CzyxmyfjZrmu4FQMlZpI+71oA1teu9LuqFGfk4oNXsj7y4ys1CvpE43o48HAYO
         Hn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725052247; x=1725657047;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKkzs1Kz9im3O36eraNjz8vseVQfkUVd+C+hugEctJY=;
        b=oPrag7sBm6QvweAIISaNiKn9fYQyzPQQk2AGF7TPncvBrFxqYoJh2FkBZW2IKZNzny
         eQ16iQvC2PYgmjxL69/HE3SEEI4o/bXRY9uYVHECZMqW4D5laCoVR4KZjFn/aTs3KJG7
         LRzdaeTeL7qX6Aw9JZDMqoPzDcbh7aqT4OiqQKz09DwzGhOk28LYNPQinzOewgTth9Yb
         5x9ugnv4RwWtCGlqsU7QKfS/qIE55XNcxGkXlOU6SwBtQkx2VcLwFW8VR5ba/q8Cfaap
         NetcYVxhgcJ13gr0k4X3ST3sWbG2VXyNWX32JsOKCjfbai8WFfp/9Zy/iXLC1usw+bYW
         XIVg==
X-Gm-Message-State: AOJu0Yzaf4bWWnQV/WqcxDLxc71JN2wh8NiaCy4ULjoxDASRFg9arYxR
	Lz3sa3jXqSoo6LC5cgeNLNfXwM6nk/36dUIAUlnXAdUyLYkdmR6zde3u4w==
X-Google-Smtp-Source: AGHT+IGlbk/5X96gm1GbvMloiZ5NHIh8zFNjvW4b4Tlg6x4QI/OeIt3FiL/VU8YjP69ZmJqAhnGrdw==
X-Received: by 2002:a2e:a590:0:b0:2f3:ef3f:2289 with SMTP id 38308e7fff4ca-2f6108922c1mr55052521fa.35.1725052245833;
        Fri, 30 Aug 2024 14:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ce5463sm2295248a12.84.2024.08.30.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 14:10:45 -0700 (PDT)
Message-Id: <7067a4c5da2cc8af61cc0f92940eb7b1ae299390.1725052243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
References: <pull.1770.git.git.1724695732305.gitgitgadget@gmail.com>
	<pull.1770.v2.git.git.1725052243.gitgitgadget@gmail.com>
From: "Kevin Lyles via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Aug 2024 21:10:42 +0000
Subject: [PATCH v2 1/2] Allow using stdin in run_on_* functions
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Kevin Lyles <klyles+github@epic.com>,
    Kevin Lyles <klyles@epic.com>

From: Kevin Lyles <klyles@epic.com>

The 'run_on_sparse' and 'run_on_all' functions previously did not work
correctly for commands accepting standard input. This also indirectly
affected 'test_all_match' and 'test_sparse_match'.

Now, we accept standard input and will send it to each command that we
run. This does not impact using the functions for commands that don't
need standard input.

Signed-off-by: Kevin Lyles <klyles@epic.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a2c0e1b4dcc..b140b642b21 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -179,22 +179,26 @@ init_repos_as_submodules () {
 }
 
 run_on_sparse () {
+	cat >run_on_sparse-input &&
+
 	(
 		cd sparse-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
-	) &&
+	) <run_on_sparse-input &&
 	(
 		cd sparse-index &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
-	)
+	) <run_on_sparse-input
 }
 
 run_on_all () {
+	cat >run_on_all-input &&
+
 	(
 		cd full-checkout &&
 		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
-	) &&
-	run_on_sparse "$@"
+	) <run_on_all-input &&
+	run_on_sparse "$@" <run_on_all-input
 }
 
 test_all_match () {
@@ -221,7 +225,7 @@ test_sparse_unstaged () {
 	done
 }
 
-# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Usage: test_sparse_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
 # Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
 # leaves the sparse index in a state where <s1> ... <sM> are sparse
 # directories (and <c1> ... <cN> are not).
-- 
gitgitgadget

