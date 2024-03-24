Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9E179BE
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711293251; cv=none; b=GyICX/wiiQM0I5JBcGdXPnaxBpHCNesBLdy0tPJKHIWm+xijA1Xl9mBNc3dz7RCYGD/3sdICK/ce0To5TsaV1CkiS33hZU7Sj2a6JFAl8sMAyQv5MWCPOwbXPcq39RJJ9PpNNmSDn3wUS1XxiEfp3/kZwguZAoYpDblABXRtn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711293251; c=relaxed/simple;
	bh=miDBRr+qIkLg66F14bej3LqLMqoQedMTcIWo8EM/u2c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TqSM6PG/wak1PxNYMwGtdHc29ll+rI7Lk505pYTIT0UMIJJzy74gLa/1fzPa2MUq5uKFvXtdbtDgVzzdk/Ph5CQj06UxNNhI1co2OfApT6fH/7KURVz6GHFDiUSrvMy5A2HGP6Q+ksKQSmvD9QgWBB+qmD1m4CWlwNRSgHz3gMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd6lGYOS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd6lGYOS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41480df2ce0so9497875e9.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711293247; x=1711898047; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k9UaoegwUTwO8GJDZ4SVi25GH3iqNG9s4oOdS/iHt9c=;
        b=Sd6lGYOSDLu4QVYQ7pErGlelL1AfaPs4aJW25ZdSRQcO2MNXRb3Qs3NwHGjdjHHGYi
         XhULlrlCsJ1prBTX9k690gueLiXmOB+gg0n3YVATl2iFPdOhXUCwBg9C2i37YSBcjCoD
         qxELr8p6kOttEq52c0FH7t8KmNBxRBJQJSL8hGW3z+zZmx2GT2fzXyFyVebUy3mzlExS
         PEeVaxcR00QBLWbOdz8jJQVqXOpatAvtV9Q2qrXCh6hymVpu0u5mfMnvp0KpsWuzoeCy
         UXawXr9ASDJJxmcEaeR/FnVmYMZLwKJ6vwIMQGwiuXiDuVPccUWZHhf/A9O2Gz6K8hyq
         +e1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711293247; x=1711898047;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9UaoegwUTwO8GJDZ4SVi25GH3iqNG9s4oOdS/iHt9c=;
        b=QEo+mnQ0uayRbijNWQr2nqt029S3SXeb9u+SsjQQlP0kqRC1/ChfO2hAYvNXZo+KNP
         imro76Gq++f7muJkpUYAJdo3D1kFFTKuDTGVO3TWNKxwfIM9lbjrYRf7/E/i9calyPIN
         pJ78YB/KXsfj0RSvqnp8wzEGrf2Rl7qhveI270FZto+c9IhQrVgak0TT0a+G/Z05JCLK
         bODPeimw/6fIMB2/G8Rn+aL8w57FamYZ3Y183Pv5icUYKTFL5qm/cuL0KOc0O9BzntIK
         J2bT63eOLro1bTKMqEnySxiDlztxjnonKqaR9Z27wS+b293NzorzFlffzppfkaZa1iE+
         8czw==
X-Gm-Message-State: AOJu0YyW4mekPPiwDH54LC4/Tr2f4PJNiFi5wnsh7uVhX9fzhqVDmN87
	XXkcLuFq8KSS0ZL9/zJ7mM9mlmyyQxRrFh5DNpl20DbyrrvD8t8XLyEr+ck4
X-Google-Smtp-Source: AGHT+IHAtGLt3TvS4wCyCfqyxW8BcQUw9aqJcWJKgIOTRZNY/Wdvj8CihagCvjoISd58kLigCg1H+g==
X-Received: by 2002:a05:600c:22c7:b0:414:392:38d2 with SMTP id 7-20020a05600c22c700b00414039238d2mr3849266wmg.24.1711293247319;
        Sun, 24 Mar 2024 08:14:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b004147ec48845sm5429519wmo.26.2024.03.24.08.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 08:14:06 -0700 (PDT)
Message-Id: <pull.1701.git.1711293246094.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 Mar 2024 15:14:05 +0000
Subject: [PATCH] t/README: mention test files are make targets
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 23fc63bf8f (make tests ignorable with "make -i", 2005-11-08), each
test file defines a target in the test Makefile, such that one can
invoke:

	make *checkout*

to run all tests with 'checkout' in their filename. This is useful to
run a subset of tests when you have a good idea of what part of the code
is touched by the changes your are testing.

Document that in t/README to help new (or more seasoned) contributors
that might not be aware.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    t/README: mention test files are make targets

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1701%2Fphil-blain%2Ftests-makefile-targets-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1701/phil-blain/tests-makefile-targets-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1701

 t/README | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/README b/t/README
index 621d3b8c095..71211109338 100644
--- a/t/README
+++ b/t/README
@@ -32,6 +32,13 @@ the tests.
     ok 2 - plain with GIT_WORK_TREE
     ok 3 - plain bare
 
+t/Makefile defines a target for each test file, such that you can also use
+shell pattern matching to run a subset of the tests:
+
+    make *checkout*
+
+will run all tests with 'checkout' in their filename.
+
 Since the tests all output TAP (see https://testanything.org) they can
 be run with any TAP harness. Here's an example of parallel testing
 powered by a recent version of prove(1):

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
gitgitgadget
