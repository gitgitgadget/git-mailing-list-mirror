Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715733988EA
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266033; cv=none; b=puPAaDeMOsfZ0ilA9xCazaqamh07K1/KSPGvS/7FTejistNSinnv9NILZTMtsNxxkzYYweo1WQg0mHTggKCtuXgeXOFeLtM3oWJBxVhgb3q9+udZfKfCjVJ5lxCw4UKn/tQ0rhrl94OGdN7e/UL6xa2FWMvem9dBEysNB+KYj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266033; c=relaxed/simple;
	bh=37UtG9JMf9Gx7/HkocpumuIGX3BPbuDGt4FUwbsCx0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H4dWgv7lbqahzJ1+mBh2sw0kAh5IiGpI0bV4phpoKMcXA5Iqt0zTcPCS0j4JyqXVwcNadGru9sBD4BbpFG0SZmbuP8ASB1UYUMm8txQvjLYYrTfECqPgP1jgme4w8sFtS4mgFEVt8lOd1O9RHJsfskj/Yn5C3A7Y8WjwYYGR0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHOKGugc; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHOKGugc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2489162eec.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266031; x=1774870831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9WQNstima1stoqHeFCDIjLn8tfi5gQxLV2IaIzRF44=;
        b=jHOKGugcOh+A8MWxgJ9gY+QpQxhCUvw5D7y0Rvy8HGifKp4IyC0Dyd0+IVmV/rrPfP
         OOiriTbontC3vU/WnTopQ6V8ogNUudAolGYpEeFSPJULnXWjPcTfLKhDYRA7wyd1v297
         K8jRs2ClMxKj4v1iS24581zL8QXUTg1lrZx7ZMmUnL0CKndyxDs5f8RivPUdcAVz7p3k
         LoGAQYDlwPF/yxFIXCMPXzBt8B/XMYwvDWtMr34Rw4PfPBlS9RltMGL8TpuxaA+esU8R
         8FoZ+If97Nxgg8MsTZBRnEiTEMJISvhRmvdU5dq+koSOf73O9UJbyNXHX93qMgryHGMy
         LP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266031; x=1774870831;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9WQNstima1stoqHeFCDIjLn8tfi5gQxLV2IaIzRF44=;
        b=F5lE86i0X2AsgnnswEuh9R/wkCq2GA4J2YFxMiASLTGWTmMWtic7mFahdmDmySsILi
         KxkNESpHcF7NEe7TxFknywuFrnkcNGQ4nCxOKLXWQw4BNX4TYGh5TxfIs1L248jcZDHS
         xWSB4h4CteWz7ixnSjw85Rlt+IoLhAaWxmhCwZwwT+BKamKy32xvNqB0q0n0dttc0CNn
         XiubaEjynbWFzgPSNLqGDlcDsQnyIXbxbo/47dJ/ii0d04uPwT9BkvSMhBUauSDY1RdS
         0pf6MCQ1EoFaCcB5Pb/LS5M66Gis1DpsZsQyUWs6p/e3KSJeIGLm6sQ5C7py+/MAFcCl
         uWBA==
X-Gm-Message-State: AOJu0YyC9CBuvkllX4c5/cjJ0UOBFKUB5JT+68hzaekh+j8RmBi1KIHc
	gYCFXMaOMUKLOePJwMWdDUvheCbsO/UHWqGTzT8Hh7JMWz+btQDulqo5DsGnCQ==
X-Gm-Gg: ATEYQzy8LjJHFdjhkxBOy1vvO66Dvo43Ayz1WzqcTUhcQWAZOe32gCE4fmxQdKVNxTZ
	oEu9xkFPuO0tfINV9WPi9Gk0hMwn4Q//YoBVn6s4NU4DV4bhCoX46X4iRxn1oKpHV8ApoCtx0zb
	f65RuotQTgRccIvBhu+6I8mLKMGs0Aemga7tZ8DOU9jhmDbEEsrdVIk3TMWdjWC0GzVOfpDFp2N
	DhUrC0SC8G44+E2NrVS0ol3WtHgCbk28fzoR/qLsmL6kYNu43TZO+B1uxMiX8ARBBkB6641MGqL
	qkoq4vUKruuM42Ji9r4q258b3Ugbh+KK/j5eIlWL5MZpFkA8R21kijS5DtJ4LBQ+Oyk6p5eFn0D
	ns3LkrRF8+LGB0i/UETslqDvjJabze+KKZyQ/ADOFpw/wmi4NVGITY//SJz1a2PlNzp8eAh0+HN
	DqAaxDEZS1jzFiMH8UIjQVd6WKsNc=
X-Received: by 2002:a05:7300:818c:b0:2c1:27c:75d2 with SMTP id 5a478bee46e88-2c109752926mr4614789eec.17.1774266031158;
        Mon, 23 Mar 2026 04:40:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b90dsm15518131eec.10.2026.03.23.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:30 -0700 (PDT)
Message-Id: <9699650aa7dc04cf1cdc26803caa8304b29c1662.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:19 +0000
Subject: [PATCH v2 6/6] t5620: test backfill's unknown argument handling
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Before the recent changes to parse rev-list arguments inside of 'git
backfill', the builtin would take arbitrary arguments without complaint (and
ignore them). This was noticed and a patch was sent [1] which motivates this
change to encode this behavior in test.

[1] https://lore.kernel.org/git/20260321031643.5185-1-r.siddharth.shrimali@gmail.com/

Reported-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5620-backfill.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index c6f54ee91c..85740f1f13 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -7,6 +7,14 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_expect_success 'backfill rejects unexpected arguments' '
+	test_must_fail git backfill unexpected-arg 2>err &&
+	test_grep "ambiguous argument .*unexpected-arg" err &&
+
+	test_must_fail git backfill --all --firt-parent unexpected-arg 2>err &&
+	test_grep "ambiguous argument .*unexpected-arg" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget
