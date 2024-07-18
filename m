Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC0259C
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290572; cv=none; b=WC4ORkPRxp1oQ9jCNTBZDAvAkJAqxnEbnoQMv4AOfFn6JFJURaAKrtrTYfRMfI+vxcKnrJtqEvm3MAVSC5CEiCCYT3jPI2Io/Macn3fUufKp4pcGMkhFMNZFe1IKuo28spJTzVkLOG4P94lWweCLW2/trBH/ovBQDe4xM9l5f/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290572; c=relaxed/simple;
	bh=+FlXUaneK+LsIkFz2B1rNw1dlDpiPUM+8GlvkA7tQqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8zPme1IVngzjQrLNbW01oRHxEfwQc8/bfwqI0Q61crjilizgRMJwakNk6W8q/Sx/ZRP34BYoRP1BhHjo+yM+7UTih3Z4aTnwITVg+0KRu1vYq059ptDRl9EY1mAhwWAV9dqIyU4qlK4SmTHe9d3bKnR/xxUTCXXD9tbZviFOpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCVl1tWh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCVl1tWh"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so229105e9.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290568; x=1721895368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAFIVeL4G51BeKd/MsfW/kDGLZ74Q1/ljC9mIPFhgs8=;
        b=YCVl1tWhKuO1Sgu786otSj/TI7R0TsbkAQlAx+2DH8Se2xeyGuHdOSbOBJlfppStim
         P9tLHtGIBMkxAtFE5+SxLLjf4P145sPxKwhVnswxu5ITnislmrCo/u1iYliO7lqXG+Gx
         VCsp03CFnNlbnPb+02d6kWjYCbBxUgZ/4ORZd7lU1IPsJ+6F3JVRk2w+dzru4Zp06SLn
         i76/GtXr1szlYAiiukZbb657hOrWkTqei2Sp0E2JUSwVaaRxhNB50LKnP+LdEVIStZIR
         Qg50hIDF5X2GJXZkKZ1q9XPbbO+CKLr7mJE/lKfNF1/3oILAhZlb6N6SnCvhZZx/8odg
         whug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290568; x=1721895368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAFIVeL4G51BeKd/MsfW/kDGLZ74Q1/ljC9mIPFhgs8=;
        b=qhkxehWUXIpSuwhtnmQca5/Y3AVvIWjwFfbhdDL+GE2F4WiElcjsUZzi96vHrobCML
         UgR4k0p6sRGXtJt942ElkaMNm8QycD9+fu0AG1rXGsyCCy5GYhQAVAdIfm69fifjcqvw
         yAK4vnGNqfoYeFqJBtiu7EDxeB5/SnAfKqRtRrzKkE3BL5BERkXyfn773n3FUpr8pTBF
         oZCX1dPAINNRk6crGwsLZ8qpN9qNvurAEVvyi2mJTqALBdo/rEmA2Onz9zj4qYtULM0Q
         LM2khuMeMW+Vu9DB51G9MUZrQCm179SKXrMYauAQO7Bhz+g6DjqGCfcu4O48jvy4IW6Z
         wkLg==
X-Forwarded-Encrypted: i=1; AJvYcCXTn7JLUmMK5H0NDpdzwrB8xzya1BvzNiEgPN9Xqtjm//88Mhfsz+HQgBWfTXJ84G3iWNkezvMaIsIWCpgT4RE88igy
X-Gm-Message-State: AOJu0YykzsKPwbEYq4xpR3UVlQjQNsJEGKVEuBTbG4q9ROCaxnzd/dTE
	sejTPX8HIaukNvMhwoaCiN36Py6DUe/zs+eswcGAW/NmkX9/6IOa
X-Google-Smtp-Source: AGHT+IGQ7V/K1D0YteA8oYCm5iUPXs4fmN57kZGzuVrM3aohxmRDnFVk0Eg8H96so9MQbP/8DutYXQ==
X-Received: by 2002:a05:600c:458a:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-427c2cbd992mr33395125e9.19.1721290568041;
        Thu, 18 Jul 2024 01:16:08 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 0/6] : add more rules and enable on CI
Date: Thu, 18 Jul 2024 10:15:59 +0200
Message-ID: <20240718081605.452366-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v5 of my series to add clang-format to the CI.

The series was mostly inspired by a patch sent recently to 'include
kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
run the formatting on CI and reduce some of the workload of reviewers.

We have a '.clang-format' file to provide rules for code formatting.
The commits 1-3 aims to add more rules to the file.

Commit 4 enables CI action on GitHub and GitLab to also check for the
code formatting. Currently, it is allowed to fail. This way we can build
confidence and fine tune the values as needed and finally enforce the
check in a future patch. I'm not well versed with GitHub workflows, and
I mostly tried to copy existing work there. Expecting some feedback in
that section!

Commit 5 fixes an existing issue with the 'check-whitespace' job, which
is failing as success in the GitLab CI.

Commit 6 adds the `RemoveBracesLLVM` only in the context of the CI. If we
decide against it, we could drop this commit from the series.

1: https://lore.kernel.org/git/4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de/

Changes against v4:
- While testing out temp file as source for the CI, I noticed that version
of clang-format on GitHub is much older than that of GitLab, in accordance
with that, I removed some of the rules which are newer and not supported.
- Cleaned up extra dependency addition in 'install-dependencies'. 
- Instead of murking the in-tree '.clang-format', now we create a temporary
file and use that. 

Test jobs:
- With error:
  - GitLab: https://gitlab.com/gitlab-org/git/-/jobs/7357893486
  - GitHub: https://github.com/git/git/actions/runs/9964605815/job/27533243002
- Without error: 
  - GitLab: https://gitlab.com/gitlab-org/git/-/jobs/7357903589
  - GitHub: https://github.com/git/git/actions/runs/9964631696/job/27533328240

Karthik Nayak (6):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided
  ci/style-check: add `RemoveBracesLLVM` in CI job

 .clang-format                     | 25 +++++++++++++++++++++
 .github/workflows/check-style.yml | 34 ++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 37 ++++++++++++++++++++++++++++++-
 ci/check-whitespace.sh            | 10 +++++++--
 ci/install-dependencies.sh        |  4 ++++
 ci/run-style-check.sh             | 25 +++++++++++++++++++++
 6 files changed, 132 insertions(+), 3 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

Range-diff against v4:
1:  6cf91ffc86 = 1:  6cf91ffc86 clang-format: indent preprocessor directives after hash
2:  beb002885f = 2:  beb002885f clang-format: avoid spacing around bitfield colon
3:  3031be43e7 < -:  ---------- clang-format: ensure files end with newlines
4:  bc1550e300 < -:  ---------- clang-format: replace deprecated option with 'SpacesInParens'
5:  4586c0094b ! 3:  3922529001 clang-format: formalize some of the spacing rules
    @@ .clang-format: PointerAlignment: Right
      # Put a space before opening parentheses only after control statement keywords.
      # void f() {
      #   if (true) {
    -@@ .clang-format: SpaceBeforeAssignmentOperators: true
    - # }
    - SpaceBeforeParens: ControlStatements
    +@@ .clang-format: SpaceBeforeParens: ControlStatements
    + # Don't insert spaces inside empty '()'
    + SpaceInEmptyParentheses: false
      
     +# No space before first '[' in arrays
     +# int a[5][5];     not      int a [5][5];
    @@ .clang-format: SpaceBeforeAssignmentOperators: true
     +# No space will be inserted into {}
     +# while (true) {}    not    while (true) { }
     +SpaceInEmptyBlock: false
    - 
    ++
      # The number of spaces before trailing line comments (// - comments).
      # This does not affect trailing block comments (/* - comments).
    + SpacesBeforeTrailingComments: 1
6:  c18cb23369 ! 4:  ae23eb5af8 ci: run style check on GitHub and GitLab
    @@ Commit message
         this job to fail, so we can validate if this is useful and eventually
         enforce it.
     
    -    For GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA' variable by
    -    default to obtain the base SHA of the merged pipeline (which is only
    -    available for merged pipelines [1]). Otherwise we use the
    +    For GitHub, we allow the job to pass by adding 'continue-on-error: true'
    +    to the workflow. This means the job would show as passed, even if the
    +    style check failed. To know the status of the job, users have to
    +    manually check the logs.
    +
    +    For GitLab, we allow the job to pass by adding 'allow_failure: true', to
    +    the job. Unlike GitHub, here the job will show as failed with a yellow
    +    warning symbol, but the pipeline would still show as passed.
    +
    +    Also for GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA'
    +    variable by default to obtain the base SHA of the merged pipeline (which
    +    is only available for merged pipelines [1]). Otherwise we use the
         'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.
     
         [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .github/workflows/check-style.yml (new) ##
    @@ .github/workflows/check-style.yml (new)
     +
     +jobs:
     +  check-style:
    ++    env:
    ++      CC: clang
    ++      jobname: ClangFormat
     +    runs-on: ubuntu-latest
     +    steps:
     +    - uses: actions/checkout@v4
     +      with:
     +        fetch-depth: 0
     +
    ++    - run: ci/install-dependencies.sh
    ++
     +    - name: git clang-format
     +      continue-on-error: true
     +      id: check_out
    @@ .gitlab-ci.yml: check-whitespace:
     +  allow_failure: true
     +  variables:
     +    CC: clang
    ++    jobname: ClangFormat
     +  before_script:
     +    - ./ci/install-dependencies.sh
     +  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
    @@ .gitlab-ci.yml: check-whitespace:
     +  # be defined in all pipelines.
     +  script:
     +    - |
    -+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      then
    -+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    ++
    ++      if test -z "$R"
     +      then
    -+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    -+      else
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    ++        exit 1
     +      fi
    ++      ./ci/run-style-check.sh "$R"
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
     +
    @@ .gitlab-ci.yml: check-whitespace:
        variables:
     
      ## ci/install-dependencies.sh ##
    -@@ ci/install-dependencies.sh: ubuntu-*)
    - 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
    - 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
    - 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
    --		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
    -+		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE clang-format
    +@@ ci/install-dependencies.sh: macos-*)
    + esac
      
    - 	mkdir --parents "$CUSTOM_PATH"
    - 	wget --quiet --directory-prefix="$CUSTOM_PATH" \
    + case "$jobname" in
    ++ClangFormat)
    ++	sudo apt-get -q update
    ++	sudo apt-get -q -y install clang-format
    ++	;;
    + StaticAnalysis)
    + 	sudo apt-get -q update
    + 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
     
      ## ci/run-style-check.sh (new) ##
     @@
7:  4d08c570bb ! 5:  a38cde03a8 check-whitespace: detect if no base_commit is provided
    @@ Commit message
     
         [1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .gitlab-ci.yml ##
    @@ .gitlab-ci.yml: check-whitespace:
        script:
     -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +    - |
    -+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      then
    -+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    -+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    ++
    ++      if test -z "$R"
     +      then
    -+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    -+      else
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    ++        exit 1
     +      fi
    ++      ./ci/check-whitespace.sh "$R"
        rules:
          - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
      
8:  2b39431f93 ! 6:  008e77bd0a ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
    +    ci/style-check: add `RemoveBracesLLVM` in CI job
     
    -    For 'clang-format' setting  'RemoveBracesLLVM' to 'true', adds a check
    +    For 'clang-format', setting 'RemoveBracesLLVM' to 'true', adds a check
         to ensure we avoid curly braces for single-statement bodies in
         conditional blocks.
     
    @@ Commit message
         rule, adding it to the in-tree '.clang-format' could affect end-users.
         Let's only add it to the CI jobs for now. With time, we can evaluate
         its efficacy and decide if we want to add it to '.clang-format' or
    -    retract it entirely.
    +    retract it entirely. We do so, by adding the existing rules in
    +    '.clang-format' and this rule to a temp file outside the working tree,
    +    which is then used by 'git clang-format'. This ensures we don't murk
    +    with files in-tree.
     
         [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
     
    @@ ci/run-style-check.sh
      
      baseCommit=$1
      
    +-git clang-format --style file --diff --extensions c,h "$baseCommit"
     +# Remove optional braces of control statements (if, else, for, and while)
     +# according to the LLVM coding style. This avoids braces on simple
     +# single-statement bodies of statements but keeps braces if one side of
    @@ ci/run-style-check.sh
     +# While also ensuring that end-users are not affected directly.
     +#
     +# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
    -+echo "RemoveBracesLLVM: true" >> .clang-format
    ++{
    ++	cat .clang-format
    ++	echo "RemoveBracesLLVM: true"
    ++} >/tmp/clang-format-rules
     +
    - git clang-format --style file --diff --extensions c,h "$baseCommit"
    ++git clang-format --style=file:/tmp/clang-format-rules \
    ++	--diff --extensions c,h "$baseCommit"
-- 
2.45.2

