Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63A230BDB
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199371; cv=none; b=o4SzOtCH7jVeu80DQtAr7K215LsIx3M9uRZi+pRnLQq/UGp3bX20XetSSj6q08+fEdbtptQUkSZ/caohjmws6A7J4yC8KHLS8yGtdw/kknsuDUNAC5bTG0sJc8ATQ0CA+35OqKAsg6LbykcSlsxdhniDkWwId8ER12Nmw6dXPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199371; c=relaxed/simple;
	bh=G8biKsDhL5z/zrpQd1zTyMNhaL63MHLXnDDL6lzT1MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuyvEpmZU6NkO8+SeQGEJ5Heb2EaTezbIg4wqZWkiWmq9/xRtNaJn/LkeGta+8zDFDv0b8q+MdKwnfw7pp7BNKJXSWfwZfZWmXyt4QPyjyNthITm0Lsb2Z062Fd8KiBGaATVEavVBcw6frLhy0yhBz1AUcKcUeGr3S4JJStZOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJXrXS9k; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJXrXS9k"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3797337eec.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775199369; x=1775804169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsEsXTuhxqPEpO7CT4rQXiuYbMqKaRP3DBRNfFV+pAE=;
        b=aJXrXS9k8gBOjIt0fqOqDVY7pUQRrVMboJxqf1HDND3GJxLvayQu+pwRa+tUxyCX15
         ik9yn6N7ba/og8B2EDFz3MM8JajsNpeVuIRq3z+ksUiujwo1CjDGHmnBzAqDA4eUsoz3
         EUr3sLX5ZaXm+PT5xpGoXwILuWqFNn7bG61OSkfvmwoUwIdVNAJ5zqvmihxVDbUxEGmk
         hSx6nGHmTKZCz8ttTfuKzzaawhGm0JRRWt9gj2nLapRkGYSEvvXQCwfgL+YEug1GB7Ba
         nVrVNpXXr4zgBmTXxIzbf5YGntGMZEOsoFlk8Ts6Z0dlZrgOM91UdM6KaTECnm4HU/r2
         bFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199369; x=1775804169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsEsXTuhxqPEpO7CT4rQXiuYbMqKaRP3DBRNfFV+pAE=;
        b=eL3eNAe+NFy1IEFWXj76N6R2ab4dA1PEzBgbT3TDZgTg1yz1EFdPTWnNYkR7zFNHBD
         pMW+3KAgs4FGF4dWUVVThMfnskqh5wBwTsEndnpsp4iJanQ+jzRkqVSbYqxPCvLcBWBX
         KQjQOKAnkwJOoshrIeirbByO6OmHrAyyHcwlQkgXifPr/AaPo7BdoNMXKT3wSiXr0JPG
         /XcZgR9nECH+FSO4YsypvhmRu7TB3NHQMFI8Txat1sDEEStRTz319KRtpWDqGRjblqmU
         o/9fAaW1zQhFvmgylw2sovCxTOSqwDrqJi4kooL/cq1oqEIYl0t9wqUV0SRGShazyXIH
         LhJA==
X-Gm-Message-State: AOJu0YwUxz/ZKLBWtonteDV3p2J52BUfw22c827gehJZVUZNp6delunF
	+A3ToRGu6y1fq5Fig5TQnSUxF/LX6DEPRRzWyUEOr4gDCmGQWN+74FMImT6ZEA==
X-Gm-Gg: AeBDieuxH0J+IROVyTpN/5mO1/3QpInVuZY7eR2wUxw/asjg6Rtv7fgtEnWldc8PzBR
	dRoPp+oYoD/5hExTGIJpN4aX00o5zEuz2O7QSos5u6C8P/sMHXdlnIX9Sl5hBU4Z30w0J/d8vQG
	zkUgHBx47qxw6uxUkA8U04RJOl6VuNzQdEbA4oamw3l+bNZgo3+rswVnxGft+8gKuN1f7L4PkXo
	mFLNxaPivbjoEwG4GnZHyXdhJXDQDp3JJux1MJicD97+8oSXlg6SBnbRJmCkqyMz+R+IQHFoXE6
	K2v//y1MGnBLc/+Fli+EAlePmAoqatx5IGiWpKYktegSf61spBqeob9q8zd25PsZ5bEmm+MRpV3
	d/hwrCtbNxSt9eUrJTNsV4X3j4aFLmoqvSi/d4ufWPbu7V/5zjGdocrPcrN1kg73TVEpKrwc+/L
	qvzLVLgNKfnx5nSmPUpmYJw908auhZVepW473Fi6pVufPPTUZq0IInowDrlR4E8EFwdhgXso/f5
	MmdsUQ8lf/7iaDQW5swX9oLSeN5cb0XHiSs
X-Received: by 2002:a05:7300:fd09:b0:2c7:3a7:c7a7 with SMTP id 5a478bee46e88-2cbfc55b4d9mr970320eec.25.1775199368729;
        Thu, 02 Apr 2026 23:56:08 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cba62d7590sm3097188eec.24.2026.04.02.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:56:07 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
X-Google-Original-From: Paulius Zaleckas <paulius.zaleckas@ui.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 0/2] fetch: make submodule fetch errors configurable
Date: Fri,  3 Apr 2026 09:55:32 +0300
Message-ID: <20260403065534.252799-1-paulius.zaleckas@ui.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulius Zaleckas <paulius.zaleckas@gmail.com>

When fetching with --recurse-submodules, git currently exits with a
non-zero status if any submodule references an OID that is not reachable
from the submodule's remote.  This situation arises naturally when an
upstream branch is still in preparation (e.g. a topic branch in a merge
window): the local branch does not depend on the missing commit, so a
hard failure is unnecessarily disruptive.

Patch 1 fixes a pre-existing NEEDSWORK in submodule.c where a phase-1
fetch failure was recorded immediately, even when a phase-2 OID-based
retry was about to be scheduled.  After this fix the existing fatal
behaviour is preserved but the logic is now structured so that errors
are only recorded when the phase-2 retry actually fails.

Patch 2 introduces fetch.submoduleErrors (fail|warn) and
--submodule-errors=(fail|warn) to let users opt into non-fatal
behaviour.  The default remains fail for full backwards compatibility.

Changes in v2:
- Fix option synopsis to use (fail|warn) instead of <fail|warn>
- Add --submodule-errors documentation to Documentation/fetch-options.adoc

Paulius Zaleckas (2):
  submodule: fix premature failure in recursive submodule fetch
  fetch: add fetch.submoduleErrors to make submodule fetch errors
    non-fatal

 Documentation/config/fetch.adoc  | 14 +++++
 Documentation/fetch-options.adoc |  8 +++
 builtin/fetch.c                  | 39 ++++++++++++-
 submodule.c                      | 52 ++++++++++++-----
 submodule.h                      |  7 ++-
 t/t5526-fetch-submodules.sh      | 96 ++++++++++++++++++++++++++++++++
 6 files changed, 200 insertions(+), 16 deletions(-)

-- 
2.53.0

