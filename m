Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195A2EA75E
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786655; cv=none; b=Ak29pywIK5cIT8bQuJK58DQ4szob3sg7MI45WXKT7tQOz/FkGL3OZ0OWaC6e2T4FdVgIJwBOCtRxXdEdAuIp5tbAIn2+1OGqKKS+EaSCBxEleu+u8Qu4H5dAvKYbeWsdgf/n+mfn/1dp6f4v/ZeMUsY0wZ2JZkPZE6uxHrxRJ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786655; c=relaxed/simple;
	bh=WyRoLIUIE51kDoPe8PUlzT5iyORC9z79nwnSLinLRI4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kNDjRLF2Zso+OzOD8GK2y818cUE8nApph0QGbqxudNruRZE2pTRommxfqYe7WqY6JPYTNXrLi3QCraR/gKM3AsRQik+iV674C2ce3uhSdJ7js0GyVqa9wJEimqLMmG2NeX1whVigoaSFDcSylUnlC3lEWsDTLt8DnLzrL/eU5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TITUdv59; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TITUdv59"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9185503e6a5so116780085a.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781786653; x=1782391453; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht0OHWAkPUGLukFTVZWcn1Psr8N8mEaDOF7YVbaboFk=;
        b=TITUdv59RUOI25afqRmrG88Sq0/r6DMF8d/2kEeVand8tqWB2zl2jiyKKQkpJgAh3V
         k4sjhG3Zl5XmQIC2IUpK+1SBmdUFjpbSjWxnH5+fjHOI402uzSTvkI2z0NXLb8NZQ/0t
         q+sP173B99LRGOQsUP03keBqiLsarl0oJ7yDEISGUijGJSV6o7x1OjAHZYfgtCFpGSUV
         UzBR+niueyCjqMzbfIKv5atbDuA7BkPI9aA+Pgo1q3cXffGh7Y4pkCWabo6D6uDek7Bf
         OdWpQBKWVgzWixm359bssZ7sCHLNMJdfMEcRszKz+gcSSRogsV39x4ZRDvr8l/DMayzv
         zT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781786653; x=1782391453;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ht0OHWAkPUGLukFTVZWcn1Psr8N8mEaDOF7YVbaboFk=;
        b=ojWMF1JgmiNJquQyffj2OuQ/aq7NUHCaza1ClyX/SDmaKrMN8qhMKy9UbR6ZK8Au6z
         wP3+yH5vWT6FO0krETkch7o6vqjixw+UlWH9lcn/F2fwZfQpnhuCsZ+vdSr1hW/GzOF8
         YrPysjmNQFKlnsro7PhnCRms1grwZ7ZOJujSZ1G2/lZJa8X5szYJpyxRQRiwP6nmh+W4
         NBzKWAbCdefgVaDBOt2P8by9+v3pISabcd9tK7EPidiAi8xJ2DjSP96crkGjdaxzfJsQ
         BkQMQ87A6vIiUYre47AdGzGN7Ypjxulx5Jvn1/anFOwCFEM6ESEP6M+3cGFGXGN8EFMi
         k5yA==
X-Gm-Message-State: AOJu0YzJOPUUxJsacrxRiB3e4GAGk2CHx6+fJ/eppBHtX5ZCBdCDLIyU
	M7Jpv17cQsqLPBskkkWmuMnptJtgxkL7SV8rm3TH9nDjC2LFmxAwQWV4irXnnQP7
X-Gm-Gg: AfdE7cl0B7nXqKkW4kbzt52xYsKM67nMkSdHdil3AhtTiJTsam1IBJN03cjPoTJmJr+
	tNQCyF8SXW8MA2BikFH2NShMIsx3uYU6RONhxj/SACwVputt2Hn/BkjZlG+tfvEIfdkp6QaHhAU
	JwxGS5w57cKi33QudGc55lSkncz4XzWcyrWzXFevs0IyZnritzAcsh1zaWY8H1YhXldFen6DqcB
	vzj3LDbvyUlNvw8ASwZVfzuIeswveQTu8RLFfcX9lrw70+a92qHn0HvgXDjtZAVneo4O19CIrxw
	EpheKd5m5u144qN5mcgivhy/uxAgZFIDcQB07E7tuTaLfYCe9/8DzK4+gAZ4dVDU9ghGz7VbzvT
	UfyojHN51o/9erYexK/OUtm2RXE7rJxEjLjczrU2xxYhya+HFXX3FXn29CCKAiQnw0rlEWfxyJf
	cp5fDDrhDGy6mPtH0Y
X-Received: by 2002:a05:620a:4728:b0:8cf:bad7:20c5 with SMTP id af79cd13be357-91f09c7f212mr497673785a.25.1781786653231;
        Thu, 18 Jun 2026 05:44:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8c83sm2014842485a.5.2026.06.18.05.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:44:12 -0700 (PDT)
Message-Id: <pull.2281.v14.git.git.1781786652.gitgitgadget@gmail.com>
In-Reply-To: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
References: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 12:44:10 +0000
Subject: [PATCH v14 0/2] checkout: --track=fetch
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
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Marc Branchaud <marcnarc@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Extend checkout --track with a fetch mode to refresh start-point.

Changes in v14:

 * Handle .h files in a better way.

Changes in v13:

 * Create a preparatory commit that exposes find_tracking_remote_for_ref()
   and advise_ambiguous_fetch_refspec() from branch.c, so checkout can reuse
   the same lookup git branch --track uses.
 * Use advise_ambiguous_fetch_refspec() for the "multiple remotes match"
   case, so the wording matches git branch --track.

Harald Nordgren (2):
  branch: expose helpers for finding the remote owning a tracking ref
  checkout: extend --track with a "fetch" mode to refresh start-point

 Documentation/git-checkout.adoc |  17 +-
 Documentation/git-switch.adoc   |   5 +-
 branch.c                        |  96 ++++++-----
 branch.h                        |  16 ++
 builtin/checkout.c              | 139 +++++++++++++++-
 t/t7201-co.sh                   | 276 ++++++++++++++++++++++++++++++++
 6 files changed, 498 insertions(+), 51 deletions(-)


base-commit: 4621f8ce5e9b97aa2e8d0d9ffe9d25df2471074d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2281%2FHaraldNordgren%2Fcheckout-fetch-start-point-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2281/HaraldNordgren/checkout-fetch-start-point-v14
Pull-Request: https://github.com/git/git/pull/2281

Range-diff vs v13:

 1:  2369afad24 ! 1:  f79689c23d branch: expose helpers for finding the remote owning a tracking ref
     @@ branch.h
       #define BRANCH_H
       
      +#include "refspec.h"
     -+#include "string-list.h"
      +
     ++struct string_list;
       struct repository;
       struct strbuf;
       
 2:  60adf0e67d ! 2:  8518f090b1 checkout: extend --track with a "fetch" mode to refresh start-point
     @@ builtin/checkout.c
      +#include "run-command.h"
       #include "sequencer.h"
       #include "setup.h"
     - #include "strvec.h"
     + #include "sparse-index.h"
      @@ builtin/checkout.c: struct checkout_opts {
       	int count_checkout_paths;
       	int overlay_mode;

-- 
gitgitgadget
