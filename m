Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769917BA0
	for <git@vger.kernel.org>; Thu,  2 May 2024 19:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714678877; cv=none; b=AY3+digTAw3A0FX5vHfMKV+YgiAu5h+6juZ2KZtZSciqaRqmOre3lw5G0Yylb4Hwoq17AlCS1ZD/YJd1yMk7Xoy4JzY9zvBajC+zk1ds2Gt5Q//Os2zD1rD8j2n+CuvGJexRcXmZlabwCccKnV962rV1uv+aU6u5BiL3Jv0AFso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714678877; c=relaxed/simple;
	bh=SyH1/NATHgeYdB2e0mnytwwuAwIFx9+ZymJtRThTRN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKIOT+Am/eJnHi2H/AJf+zVK/r+fjQDtLfS+h9uqy4dm17PfkywX4UFBk07X+zjnDWgj+S4nirKzBoVFd6HrTRUmSd5goVdPXruwGwhIM3RLghifPpI/pU0yYR1pyDlEt1sRzkRMy0du6q7H8fKvYGZsFleM6/JATFybSIpcWUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqylPyo/; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqylPyo/"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b1bbff09f8so526441eaf.1
        for <git@vger.kernel.org>; Thu, 02 May 2024 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714678874; x=1715283674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dUqCQxcz4YlQSa4l9LLxgK3klvIGFju+oLHfgjzX4E=;
        b=SqylPyo/HaD7Or+ZBNEgUYNwzy+a3BgaaL6DnM9kPJ3TwWXGcbn6DEidzLg8b7L2rH
         Nlr0d12WeZlZEGo8mylze3xaOZrtF0j6Za1Lbk2+d12xiaLg7hgIh6zWcJcpdBvCLeAM
         Tq8KdN/yetneZtGkE0WOmwPWv16G+fXmaeVCH/gX9OhbSOJ71S6qFmbqkOSdeMM2N8UV
         acOA9auTc1A/TQKQ6Pe4Bdm+K+ooAcmsvc9Ydk2K/Vm/udW4igPOF8SKC7jIMCVzbpRN
         0eodSIazdcJrdLW9HkFa2OE6I0f6RWW9A0An41CF4qJNFjemp8wyFgBWsjWLcj7JWhA+
         +rtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714678874; x=1715283674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dUqCQxcz4YlQSa4l9LLxgK3klvIGFju+oLHfgjzX4E=;
        b=d4g/a9nmkzy8uWr9FOyeMus8v3h9z7Y4unjJPJgrDNmQhgAtiMxsb9l66NlVPsvC1N
         gvXqOTSGkshYCaszPugTcGDL8cjnQXCuoDVCIz1RnwoBc4xwhQxCe00BIU7YFv5gfogA
         P9gHmPfFFW258pk2+lGkvtRY1QFxN7x5kHc7rD9gyzzYAl2QZSU1Aj3yq04bvc9/sQuu
         WImipiHTS90p0r2W1r3/MoY1cQ9G0sdFH7gGblYam9+LNCrd0OIHJNJmYuO/yYCe4n5J
         sNpFWWUsS0/wNJgDPopXW3aqUBoQ3mUlFJ3Kbs71vcYJF/tG7zyzu5uoNiCmqqrbWMFs
         DFeQ==
X-Gm-Message-State: AOJu0YwqafSArK7SdRYhsZY6LNDkNzOhqrr9lR188kDbB4sKxCQpR2iI
	vymQ9wlZB9f0/ZejrcLEmkCCm0RPYDOkk9GuGZ5A93PTTHCXyg7ENN8XbQ==
X-Google-Smtp-Source: AGHT+IGaapNsu/3aG4wjnG/P6j0vomcxC8uAMxkv+zJDUiBBeuYuRLcD5wUBdiflsPhnrnckctoR+g==
X-Received: by 2002:a05:6870:a9a8:b0:233:73b7:5379 with SMTP id ep40-20020a056870a9a800b0023373b75379mr312881oab.21.1714678874414;
        Thu, 02 May 2024 12:41:14 -0700 (PDT)
Received: from denethor.localdomain ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id uj12-20020a0568714e4c00b002390714e903sm297443oab.3.2024.05.02.12.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 12:41:14 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>,
	ps@pks.im
Subject: [PATCH v2 0/5] Add GitLab CI to check for whitespace errors
Date: Thu,  2 May 2024 14:38:34 -0500
Message-ID: <20240502193840.105355-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240430003323.6210-1-jltobler@gmail.com>
References: <20240430003323.6210-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello again,

This is the second version of my patch series to add a GitLab CI job to
check for whitespace errors. The main differnece with this version is
that it first generalizes the existing GitHub whitespace check CI job
allowing the GitLab one to reuse it.

To validate that these changes do not break the existing GitHub CI, here
are some links to a successful run and a failed run:

- https://github.com/gitgitgadget/git/actions/runs/8929081916
- https://github.com/gitgitgadget/git/actions/runs/8928887225

To validate that these changes also work on GitLab CI, here some
additional links to a succdessful run and a failed run:

- https://gitlab.com/gitlab-org/git/-/jobs/6768304381
- https://gitlab.com/gitlab-org/git/-/jobs/6768282645

Thanks,
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

Range-diff against v1:
1:  924d3eb23c = 1:  924d3eb23c ci: pre-collapse GitLab CI sections
-:  ---------- > 2:  c8d8b444dc github-ci: fix link to whitespace error
-:  ---------- > 3:  6b44b21dda ci: separate whitespace check script
-:  ---------- > 4:  87dfd1d5a9 ci: make the whitespace report optional
2:  624e68a8d2 ! 5:  175b300e91 gitlab-ci: add whitespace error check
    @@ Metadata
      ## Commit message ##
         gitlab-ci: add whitespace error check
     
    -    To check for whitespace errors introduced by a set of changes, there is
    -    the `.github/workflows/check-whitespace.yml` GitHub action. This script
    -    executes `git log --check` over a range containing the new commits and
    -    parses the output to generate a markdown formatted artifact that
    -    summarizes detected errors with GitHub links to the affected commits and
    -    blobs.
    -
    -    Since this script is rather specific to GitHub actions, a more general
    -    and simple `ci/check-whitespace.sh` is added instead that functions the
    -    same, but does not generate the markdown file for the action summary.
    -    From this, a new GitLab CI job is added to support the whitespace error
    -    check.
    +    GitLab CI does not have a job to check for whitespace errors introduced
    +    by a set of changes. Reuse the existing generic `whitespace-check.sh` to
    +    create the job for GitLab pipelines.
     
         Note that the `$CI_MERGE_REQUEST_TARGET_BRANCH_SHA` variable is only
         available in GitLab merge request pipelines and therefore the CI job is
    @@ .gitlab-ci.yml: static-analysis:
     +  before_script:
     +    - ./ci/install-docker-dependencies.sh
     +  script:
    -+    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA
    ++    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
    -
    - ## ci/check-whitespace.sh (new) ##
    -@@
    -+#! /bin/sh
    -+#
    -+# Check that commits after a specified point do not contain new or modified
    -+# lines with whitespace errors.
    -+#
    -+
    -+baseSha=${1}
    -+
    -+git log --check --pretty=format:"---% h% s" ${baseSha}..
    -+if test $? -ne 0
    -+then
    -+	echo "A whitespace issue was found in one or more of the commits."
    -+	echo "Run the following command to resolve whitespace issues:"
    -+	echo "\tgit rebase --whitespace=fix ${baseSha}"
    -+	exit 2
    -+fi
-- 
2.45.0

