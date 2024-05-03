Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CF157E8B
	for <git@vger.kernel.org>; Fri,  3 May 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756994; cv=none; b=IHV/J6PwnS4mlB/yqGB/Q/mEs9sLpnJ4ltG3Mm8ZuecMia/daBBKRROWw4g139/EgHT/Pkp6SkzljeiF17s0VN8Jy8pII0OyNgch2/m8KHi3FSg7orKjkKNDDytGYBSvbDDj0aaC/oNKre8TtAhOB5WNP0m+CFRSJFpweRI41Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756994; c=relaxed/simple;
	bh=FOfcvgVkGAzrVL54L7f7lYJWWQ/pKmbX31NjQgP8s6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRB+7wxhgbCOwfmWAUQNDvKPda7Crb0zGKqZ4VlEhmOppeNlvzGua+9TnFgplFtdM7udQT5T+Qi56i4VGJEllWdst1GbN97dda5hW7ogJoHDoiZZ4Hlg5CoSTBWpmEGhx/gVfKcPCmNGDQCQRXO3rh3SpawQt1aS61/wdVp41lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFqDvIYy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFqDvIYy"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ee68823724so2517351a34.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756992; x=1715361792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhVJmmKcZE9sNtWIfxeplRpJCF1uSQby1gy4rKC5mRk=;
        b=VFqDvIYyStmfqaBgi4hz2QiwDjdzNDs7kdqrAFE8YkMXWtU/0iQf6d/nbAZFU47jrl
         LNejCrBEXDcKQ63FcIhflL9wudZ3TbJovI5PR/MOT4b6/5M3g9vTjitOLkjVreUWxOnH
         dHIeFg+xovopv0c23TLbi1xKUoHH504wxPDLqNdmktlN32LRJKsizM6AfUdloP2or/FQ
         9tASUgWeXpY0uj1oib2Elpqlll5cuNtWjZWHKKGeXKLtpdkd1/SAgmj75MGkoWhyow26
         NpjVsRM+5WX9K7SkNNRfjBA7eFit4UtPPWsZs0Yu9maGwJi0JeTcc/u0Q0Hm5DWvSa40
         9/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756992; x=1715361792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhVJmmKcZE9sNtWIfxeplRpJCF1uSQby1gy4rKC5mRk=;
        b=W9FA+9CHRqvV1/YfJvwrvV2SJ7kVY47vGIi8B38gQ0eXMhUFuEM3u2ZUS+lyepikP0
         k/hJk96vFFQcDvpdvCXATaK1spYMo33vCVqC03uaPgBsoY6ibOt+FXp0Z/+W05uB0mrZ
         eDN+vCJIg+DnR2SVSOelqel5gYX/VzaETU1yIE1V7N9hOVR8n+RsW3nh0H/TXo2/cPrw
         14kbA1v8Ba66WxiCOc1u1xu+dPyWuYkhWK0VPve2HUMDEvojf+7/E++mdnPHDpwCXuxN
         4r+pubSRdKj2JH4MT8lo9hNw3NTJoELgrHHgPmlByyi2Ji2UiAvougEbx+Lo1UVc6DLo
         EO9Q==
X-Gm-Message-State: AOJu0Yy5DOftcp+hIVunrAGkxyPOz5UsR5rHyk9ddl24pb19g7jDQyHn
	pwzUNo0Y6/LG9+Zvs9QNoo99EEzNaPDI2qzkzSCMSUsOPqA2K7oxp5voYdec
X-Google-Smtp-Source: AGHT+IG/1JD1IrtwSnW6X1AA+L+yNrQVqPW6cGI/vwincjVgBDCcII2+LUwxWKRFYMKfsBwUw64O+g==
X-Received: by 2002:a9d:7848:0:b0:6ee:1e31:4ff1 with SMTP id c8-20020a9d7848000000b006ee1e314ff1mr3340232otm.16.1714756991769;
        Fri, 03 May 2024 10:23:11 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id cy14-20020a056830698e00b006eb7b0ee326sm705212otb.65.2024.05.03.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:23:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	ps@pks.im
Subject: [PATCH v3 0/5] Add GitLab CI to check for whitespace errors
Date: Fri,  3 May 2024 12:21:02 -0500
Message-ID: <20240503172110.181326-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240502193840.105355-1-jltobler@gmail.com>
References: <20240502193840.105355-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello again,

This is the third version of my patch series to add a GitLab CI job to
check for whitespace errors.

Changes since V2:

- In 35e293e6 (Merge branch 'ps/ci-test-with-jgit' into next,
  2024-05-01), `install-docker-dependencies.sh` script was merged into 
  `install-dependencies.sh` and removed. Thus this patch series now 
  depends on that change and is updated to use the other script.
- Changed the shebang to "#!/usr/bin/env bash".
- Made the argument count validation more strict.
- Fixed a typo.

GitHub CI:

- https://github.com/gitgitgadget/git/actions/runs/8941666020?pr=1727
- https://github.com/gitgitgadget/git/actions/runs/8941721282?pr=1727

GitLab CI:

- https://gitlab.com/gitlab-org/git/-/jobs/6776032414
- https://gitlab.com/gitlab-org/git/-/jobs/6776038234

Thanks for the reviews,
-Justin

Justin Tobler (5):
  ci: pre-collapse GitLab CI sections
  github-ci: fix link to whitespace error
  ci: separate whitespace check script
  ci: make the whitespace report optional
  gitlab-ci: add whitespace error check

 .github/workflows/check-whitespace.yml | 67 ++----------------
 .gitlab-ci.yml                         |  9 +++
 ci/check-whitespace.sh                 | 95 ++++++++++++++++++++++++++
 ci/lib.sh                              |  2 +-
 4 files changed, 109 insertions(+), 64 deletions(-)
 create mode 100755 ci/check-whitespace.sh

Range-diff against v2:
1:  924d3eb23c = 1:  924d3eb23c ci: pre-collapse GitLab CI sections
2:  c8d8b444dc = 2:  c8d8b444dc github-ci: fix link to whitespace error
3:  6b44b21dda ! 3:  933e0c33f9 ci: separate whitespace check script
    @@ .github/workflows/check-whitespace.yml: jobs:
     
      ## ci/check-whitespace.sh (new) ##
     @@
    -+#!/bin/bash
    ++#!/usr/bin/env bash
     +
     +baseCommit=$1
     +outputFile=$2
4:  87dfd1d5a9 ! 4:  374735c60f ci: make the whitespace report optional
    @@ Commit message
     
      ## ci/check-whitespace.sh ##
     @@
    - #!/bin/bash
    + #!/usr/bin/env bash
     +#
     +# Check that commits after a specified point do not contain new or modified
     +# lines with whitespace errors. An optional formatted summary can be generated
    @@ ci/check-whitespace.sh
      outputFile=$2
      url=$3
      
    -+if test "$#" -eq 0 || test "$#" -gt 3
    ++if test "$#" -ne 1 && test "$#" -ne 3
     +then
     +	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
     +	exit 1
    @@ ci/check-whitespace.sh: then
     +	echo "Run the following command to resolve whitespace issues:"
     +	echo "git rebase --whitespace=fix ${goodParent}"
     +
    -+	# If target output file is provided, write formatted ouput.
    ++	# If target output file is provided, write formatted output.
     +	if test -n "$outputFile"
     +	then
     +		echo "🛑 Please review the Summary output for further information."
5:  175b300e91 ! 5:  a7deaeadc7 gitlab-ci: add whitespace error check
    @@ .gitlab-ci.yml: static-analysis:
     +check-whitespace:
     +  image: ubuntu:latest
     +  before_script:
    -+    - ./ci/install-docker-dependencies.sh
    ++    - ./ci/install-dependencies.sh
     +  script:
     +    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +  rules:
-- 
2.45.0

