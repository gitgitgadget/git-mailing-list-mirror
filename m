Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98935294F
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071263; cv=none; b=QHYz4tUhxYh66FS+vj9WMOMJYF69hXaCqfqDuGWDfwv/rIcILmfUSLUKWDl65l/9dSsonnJoawSTUz3j1SYSOb4BPsgM5iTQZgXyrhQ4of0Yp3eirPMd74fUWj8NfGwYWfzUfjxGaXHCvA9Wruug2yH24iG9hhnX5lolX0rKScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071263; c=relaxed/simple;
	bh=RKKMQURBoZ7ucNob+pFDyzT8K1OK97ieeATcJfcJF1Y=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=i/XHIHh2/5/9bt5JJ4yif+dc26egtxIQRj17P7FWnAPZjmum74VgSDLGd+ZlWWqPIr9C7FewPAwKT5uuCJaR7lL3zGYmuENUIdgATwnBLk+pvv2/dH4cFNgbk3idoijB49+E3cMeFk1gs340LeF9Z6PhLgWSxZwqqOamO5YwyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRonXfbN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRonXfbN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5de23ddba5eso494287137.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071261; x=1766676061; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lc7I2HxHmmDvi2idTP5nesQhoR/tP3GhYzJcm1VmvjM=;
        b=hRonXfbNh9jo7JHiM8MbaKQwfU98UyuNcySRIpXqny6uYwzaktdqQn0KNrfHq7viWQ
         z478L8V9X8YosKRb4jrXR4MW1ZxltTYTWHF118jqUU+8Kf28Umzv111hgkKQFf2gCaPQ
         /6qcyobGXuk8o+tEDZZsbbkDRM4SE2Xkc5/P5J8lm9YkbKF+czyIPdOQjcQfbC/sNNkQ
         nb4P8xbOthOSjfUGOIVvKOZF4Iobon0/epDTrSZx2qqQO/xckrmXVMzaK4NO3BkFyuW0
         lfwu+vrxkZ9nLFAiC8SvvTOyn7YSmOqsiG+CfRf8Ua/E7iFWj1wYyAWJjSgSpq5oyFQp
         IEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071261; x=1766676061;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lc7I2HxHmmDvi2idTP5nesQhoR/tP3GhYzJcm1VmvjM=;
        b=K8qw3gCb7HyBoCmHrlVavZByPSdCcE/dmN7Xj0QAEJgdhLBpyiOe3z4HNPywe0qXtj
         0AftNLPtOdOP4j7r69Trf53WeY2hfJ9ReU4hPWCblkrEgWLy1+fEgu6OR/fj+6i8YmcN
         kc5oIVJoyyH4fjjwGjXkcW4GsHmQYfwGKuKI1qNLuNsYxUtZN8K6JP8yNJEWqxeMag7O
         ClxWDqJwzL8GoSsBek2JXlxAs4MGyrXwBVfkr44p7CQYI55Ma7Ll1cJgoamypO02g+SN
         iiDQax1LegqQxtUwSSv3pOj6KBSK/H2VxtlbRf4Xrh3L5R/hsLd5ZN5hpjJoRqLfMbNA
         B3Kg==
X-Gm-Message-State: AOJu0YxX1rEgkbirRWrXP9gF27d0d+Z6J1GQFTcgsEcxvMRUhIptJsFW
	8BxoqABRnoy64JXsKssw/u/Ifeadh+YowD/cfnZRiIMq9oZqhFxk9dbiYNWpPg==
X-Gm-Gg: AY/fxX6gXoy+dWtSCaUdGsrKRd+/2hQXp2ZBloQhS7Uaz5DiwXRc8MIJS9dS0KsNe65
	joTZNEHkSz7N1VTNl+N/ee29VTnunuyTYTF7AXZF1JdgWRSYPjZ643GIOaaMGlf8kXf9UDnzziT
	hclICob/XeyKifcxBwj7gQqyJ8ktotzEvtLs1hXTd4WOC9P4I1ygxQspaSp5okp6QQiCGKiEt8T
	zf+XjCKlBea9L72gjEIO0gQaZL4PrPy1edhqtPt38I90dd8CJpa8YBtcXcrE8uhrqZEG2eLblH0
	HTaZ5T7u4o/R+SvYJ7fv0NE4Ag/AMHSFU2gukFeNMKpLDOedOwAWFAAd7/cSVOURS0/rNrKv5c/
	5cu1/5q26sHLr7VaIa9NpTP5UDDTiYuJydOW2TYT5Ah3Bg+CID1oCnjtZSY57oOgMq14QI0rjyI
	rzAEn50Ur6jCnXtQ==
X-Google-Smtp-Source: AGHT+IGZ2nVONYxS0BOVF97wSGFHwN2h6UEecCQrTqQ3uE2wNEL1etrV7FNjpTn1XAoccqkZjtAWzg==
X-Received: by 2002:a05:6102:3e84:b0:5b2:d28a:8937 with SMTP id ada2fe7eead31-5e8276c1892mr8308253137.12.1766071260797;
        Thu, 18 Dec 2025 07:21:00 -0800 (PST)
Received: from [127.0.0.1] ([135.232.193.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c5e05b780sm17885556d6.14.2025.12.18.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:21:00 -0800 (PST)
Message-Id: <pull.2019.git.1766071259531.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 15:20:59 +0000
Subject: [PATCH] test_detect_ref_format: fix comment
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When 58aaf59133b (t: introduce GIT_TEST_DEFAULT_REF_FORMAT envvar,
2023-12-29) copy-edited the `test_detect_hash` function, the code
comment was accidentally left unchanged. Let's adjust it.

Noticed-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    test_detect_ref_format: fix comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2019%2Fdscho%2Ffix-detect-ref-format-comment-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2019/dscho/fix-detect-ref-format-comment-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2019

 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 52d7759bf5..14e238d24d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1724,7 +1724,7 @@ test_detect_hash () {
 	esac
 }
 
-# Detect the hash algorithm in use.
+# Detect the ref format in use.
 test_detect_ref_format () {
 	echo "${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 }

base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
-- 
gitgitgadget
