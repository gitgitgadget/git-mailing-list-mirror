Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1410230BDF
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768116617; cv=none; b=d3jBGQyENt1CBYe9XUVQyYrIm+XoPoZBmYmOELcM0NBL5Sm97RPdfYblswcVQtUNHLIQr07HinO7mTaIp8CwiRUmMffjFB7TX9Kq8+/TIYne6+uvnf2phH6touunvcpuXiLgIang+m9TmtQrgJKBKd6aUGu2Wo8Mmc/R6jd49DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768116617; c=relaxed/simple;
	bh=2a+r1BiJEhFHVsq0SbdTlPNOSzV6WdjUyR040mHf0Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYeVnfz3Le3mFfP6yl+ctZOF2Xv3T3ZlflKtPRX+xiTWf0RyBvxkh6L0030wG354HugQxbvn2m7i+5r6mhJdFy9uMjqTVgF4CtVZ+8iJAzkzg2om1icm306ttuuo8eIz4prTWbuikSKXV3uMrXVoZC13D7CGRfhIs/WgU1bb4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVHkseCb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVHkseCb"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c363eb612so3327369a91.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 23:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768116615; x=1768721415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsA40m3FdtzcWsF1DOD9FI21uOvapsjMSI8tveTHYHk=;
        b=XVHkseCbYyM3o662z/R5LczKWPaNzYicd2TDgUH8+LH7HIt056NOT8eE1FDC8c8cwu
         /IrlbxEKuAkP84BOpRlmKWfmtddNJdlI+JebIBqdaLNA9k7YEtWNfccxsYcJLmyafHmM
         DByJhaVnKT4iqIlqYPLoOLJIi+11hTLaNwgBz2L3n1J8XqD+CIKKl7rmCTPamG5oJlTz
         m45f62w6YTQpqZOgfcCx8ZslAE2xlOfBB7KVppnFUapatr5pB0/HEnF2Vjn5TFqlak71
         U3qU+K8PrwvL8UB4ddhynIOVSiJItE2ejziCBqFo/vQF8MS1tCfSZZouBqPxsfTfpPt3
         jRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768116615; x=1768721415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsA40m3FdtzcWsF1DOD9FI21uOvapsjMSI8tveTHYHk=;
        b=fOxDzzHhRXLAbVEB1x43r7Uop5e/z9GUFfXcgGQOCzxWkAkXrv0RgqmbR4oQQDGoAP
         RvoDcYNVGgC07RflPO4GC1O3jzYhwLon1Jsxd0IYVAk+U63B1sB1bz8D59ZW5ILUSEbT
         pJ92nQMkTdd64MpaLzRwnmvDubjelG+ENkzpz78YNjorHHzjtusg8nO6QriDq0C+F+PL
         sY8dot5r6wffdk57YVV8Hw6/WLOj2eXtJYGaSI6ySZDY11vUIhfF0TKwajmByPYBakPq
         BMSdv2z/+t8TmXDiO8Ais9I5EsFw3X41vo8pRzzoQTe+BY1cuzOHk6p55MDScAwuiHBK
         4kZQ==
X-Gm-Message-State: AOJu0Yz77Z73EWJjjlse8yeFfzU+nO3Eg5789tHwWGxejakbSSb4n5gN
	Lu5kQrlmiNAP21lAaImczcQQfzD0dPMhj3G1B2N1bKHmDOG1J3Je/lT9o7fMrfL7
X-Gm-Gg: AY/fxX5W/cbRd71ZQNzsGcxag3LltJGZrfDh4TL82aPg8t9ih1NNEV4ktNrJzwYgIFo
	T1YfZbL5d1B6+z9u/Ipncn5DWOQbCs9ewwcBDQ0da1xhtxMjbR4KXryiMmxo8E4fk04wlIUGQmC
	vrQR70PISAs0vGj+twmCqz7t4PLUGuoVrCRmsFEmcQpwSXVWKgPr850WkvaU0LAp8OpTiRBOYj9
	/qI/aD8+bqMtSZIdh+OhRhOG/u2EoUvUNExiC/0UiODjfY2iV8R67D4ztmlTwrTvZtJpOFuX1Uu
	2BubmCOIjidV2q2VSdel5JGOfq+KrOj56nQJ53Rt7djpzLfSL0yS9VUCaakEgNnINxSlTYQw3n7
	fycD7ZxUgbO/2PQ67p5UPDudn5KWSTk2OEgbNqPRsMW4SbiI3CPg9FXupkv+UJpsha+LS+fTbPV
	0W0UI34B9lFOBsPutoBPaKtyHh31SD77va
X-Google-Smtp-Source: AGHT+IFEYzbLPGDH7CPytrphh1H7fNJf65GbwZM8+QGuzenAO02CTGjldXnR7R4w48foRkUao/ySTQ==
X-Received: by 2002:a17:90b:1b08:b0:34c:75d1:6f90 with SMTP id 98e67ed59e1d1-34f68c0018dmr15165394a91.17.1768116614698;
        Sat, 10 Jan 2026 23:30:14 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d292fcsm14177619a12.20.2026.01.10.23.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 23:30:14 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 2/2] t5403: use test_cmp for post-checkout argument checks
Date: Sun, 11 Jan 2026 07:29:50 +0000
Message-ID: <20260111072950.9463-3-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260111072950.9463-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update check_post_checkout and the post-checkout hook implementation to
use test_cmp instead of individual test commands. This provides better
error messages when tests fail, making it easier to debug which specific
argument (old ref, new ref, or flag) was incorrect.

The hook now outputs in key=value format which test_cmp can display
clearly when there's a mismatch.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 63a2221441..a50c8d0eee 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -12,13 +12,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 # Helper function to check post-checkout hook arguments
 check_post_checkout () {
 	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
-	read old new flag <"$1" &&
-	test "$old" = "$2" && test "$new" = "$3" && test "$flag" = "$4"
+	echo "old=$2 new=$3 flag=$4" >expect &&
+	test_cmp expect "$1"
 }
 
 test_expect_success setup '
 	test_hook --setup post-checkout <<-\EOF &&
-	echo "$@" >.git/post-checkout.args
+	echo "old=$1 new=$2 flag=$3" >.git/post-checkout.args
 	EOF
 	test_commit one &&
 	test_commit two &&
@@ -108,7 +108,7 @@ test_rebase --merge
 test_expect_success 'post-checkout hook is triggered by clone' '
 	mkdir -p templates/hooks &&
 	write_script templates/hooks/post-checkout <<-\EOF &&
-	echo "$@" >"$GIT_DIR/post-checkout.args"
+	echo "old=$1 new=$2 flag=$3" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
 	check_post_checkout clone3/.git/post-checkout.args \
-- 
2.52.0.230.gd8af7cadaa

