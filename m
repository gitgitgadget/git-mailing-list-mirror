Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23125F78F
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995972; cv=none; b=Kjb79Rg3RUHxJhIwMJGSLTdB7mJ/AATUlT4KJAFxDOj+/mB1ruzp3Gjv2lsw9WklsbPTfkukIpvdZfys/fq1wRzc0UChiBRaVJo23gwBf4cjw0xhjRfuviGWc999XKWEUAgMHU+lLLQuf5vlqfs7yebaK73Ci4eBKsaqgiBu4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995972; c=relaxed/simple;
	bh=dOzpa7zun8YofuOdKiTq5SjT0br+PqDEN2eknT97wQM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PwXp1kl9ENxeHVQ3cBmdJiiTlqt42kexezu1zEyZfQlmYJlkUpLL4YBkfnu1oY5OSFHXPKiC9tBwlIJJKlEZezdNI5xqR/zuGZRVpcYi4SYgCJoIN2WFK9dxmeu8oHzO+I5Rh4yPrhcT4Eojjy0Tl+40ccbz+Dk7R5svcvu7rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwtgBKx1; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwtgBKx1"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42f8e93c54eso6067745ab.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759995968; x=1760600768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tirXb8qgcpqFGA3bBp0RZvF71FQvIFw80b6f85b4xpQ=;
        b=YwtgBKx1jb0CvoKpydOJed2rSa18+++p05jGBAVSZ7QbpVEiSuX5VIZ4BeP8sL0RgO
         MnxHPwiJTd1bQjDcYnYw2B7wV7LCOBzMxMiRBTyMZCtSgXYop26HteM5F6iGkh6KFFrw
         WTYHXrx8eSM6RHH46snu+CzWpRP7ZUskXR0mPeV5XeBVNpmUC25P2WtEucUADBrtgLiE
         Wbt4JMRvKw7NJRhJuedM1e1f7TCFYQxRQEe/hYgaCSDnF+iuPFrlk34AaUjFje4Nnjn4
         uAExH9RWZ1iQ3HPtcMuzUHMFGW4bvRr02djJUqR/Z6tGQQdv9gMNHY50HBhjTQJHCzr0
         aT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995968; x=1760600768;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tirXb8qgcpqFGA3bBp0RZvF71FQvIFw80b6f85b4xpQ=;
        b=UpWKw0w8S86ggHmu+82Jeuc79kAuv6+AWngmCwQ4BXEnNs8bbDwmeOo6kLHZgBg/Lk
         jcqX8GjzyIyCZaS2AN3IhQi+rsdG1Dnkfn5EL/raQiVt4mX32o3+sXxCwomFFjHyaZxC
         k3W6UemQZeU4hbOyn8A+Momg3khN8RIQgbwOqC7SZauUSRg15bmpil4BklV578muLehr
         6RNuFdwIZz27UlZKgTcOZ2pk6PempYQLN5k+r5SuRR1Dw15X8ZNThR8FPh9JtGtBBAAo
         mj4N2OHrbgdl8usEZEw+qOcZmzjteb7dtixTdTAsSIBr2BfTVLPQx5UyBzdO8TgumQgj
         TWpw==
X-Gm-Message-State: AOJu0YwWNftaKwjN23wCv51TJTEL3rra++MBVNrS8mNJ7/XM5ZGcfgPy
	VQATez7q3rg0xqfJiQjszS+MYaoDDkJhlTFmaO0MactwZIhTya7YJcprN+aeHg==
X-Gm-Gg: ASbGnct/HwZuS8sFmhaYhYbrY4GqCcHf9NAhD+32ZfTLnUIk10kXwi/h67bjc+Ai/qy
	qA2vOH2JfGv3XLPeMb6qXzHZxP7U0Ck7X/p54P6GeXY/JfUoDMdDBMWX/lwlrKTZGx/7t05wrXw
	IppNt01L1RkGAWsM1ZXWH9KQcQCBDmy08A28sl06J8esz3VjUET0K4tt78qaTrwJVGz1oFRlB6e
	F7q0VWgkPsVOScJ30gvXKCxXs2h7mqQcNRa8Egg4BbfEtdfSJkD+3w05+RA1h2eg00UXN4vZnRt
	hybut6zaGTVbQhAuDDOVSwoCb7sDFiYgFRwROjn2xt+HqMUzcBsgqx4FgF0lvwnBfgtLOaGvbP/
	UALmLHWf9KUvDbf1UjiluzNvT0d4rMj7/M/LLaqzN4upZS9Nrly5zyeZN8LGj
X-Google-Smtp-Source: AGHT+IGumtS3j1RwmZAa1ZuqlSZVVp+IStZtegd7GitetXgsazI9HnNWHIepWg9rquuVvr38J2FGkA==
X-Received: by 2002:a05:6e02:470c:b0:42f:8ab5:828d with SMTP id e9e14a558f8ab-42f8ab5843fmr40558435ab.27.1759995967948;
        Thu, 09 Oct 2025 00:46:07 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.67])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea80655sm7772638173.34.2025.10.09.00.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:46:07 -0700 (PDT)
Message-Id: <5303aa57c4e5aa8e88b4a3d553ff3a69dbe54871.1759995961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 07:46:01 +0000
Subject: [PATCH 2/2] mingw: order `#include`s alphabetically
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It allows for more consistent patches that way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index da99473f56..736a07a028 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2,25 +2,25 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "win32.h"
-#include <aclapi.h>
-#include <sddl.h>
-#include <conio.h>
-#include <wchar.h>
-#include "strbuf.h"
-#include "run-command.h"
 #include "abspath.h"
 #include "alloc.h"
-#include "win32/lazyload.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
-#include "trace2.h"
+#include "gettext.h"
+#include "run-command.h"
+#include "strbuf.h"
 #include "symlinks.h"
+#include "trace2.h"
+#include "win32.h"
+#include "win32/lazyload.h"
 #include "wrapper.h"
-#include "dir.h"
-#include "gettext.h"
+#include <aclapi.h>
+#include <conio.h>
+#include <sddl.h>
 #define SECURITY_WIN32
 #include <sspi.h>
+#include <wchar.h>
 #include <winternl.h>
 
 #define STATUS_DELETE_PENDING ((NTSTATUS) 0xC0000056)
-- 
gitgitgadget
