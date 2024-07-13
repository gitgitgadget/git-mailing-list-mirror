Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E91BC37
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878325; cv=none; b=mjXjcGorW4UMFbiAvNEa5M5bhUuPjAxA5cJ+XicyeW9LVXWYNTKtexTPGDK/K/7sJn7RVFrCFsd9+SknSVSObYECmSzp5uN6pLS+9GJpgpDmT+xawq5CjArbOYQ9IPrxuM8KB3FUuZxU7rH6RZ9zlEJkNwhQQKsZoTAUitTBFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878325; c=relaxed/simple;
	bh=2tDtjANDV2PYP57ER4qI4EF8ogOTggd8DM8/k5KLqfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebqzOugFiZj4Z2YgF8wSsz0kI6P89imx6Hdhdlubs9Ps1J6u0pR2C6CbxNkS0m290nEtJ+H7BAtfbTaDv33zI/X7gGsmcS6Tfte8QdxmIHeb0HeR+GXknYhq2m9Be4wbHMV5LAmHeytwvc0z2WcoSIzMMhPtjqCjGtMuB9RfZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewXfqYht; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewXfqYht"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367818349a0so1638039f8f.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878322; x=1721483122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnBZ5sXzjgfYRYdC0awr55ObcGFVWdnVorTPhYTztno=;
        b=ewXfqYhtBDRSarTo0n0eCgIruQco10ESvXAjNdglbVYWT9TgZ49vCkd3VkEVTtjKmH
         Sr6SAdydAj4bee2qsKSu5QNtcxXZARYJAoHwdV3BD7Tmwd49980D2HzJPkyELa6V1fgE
         zjbWG98Udz75U55Q3VsJBlAYETmFLQKkrOUUE5E6YQeYCst3EkQUsROYhhPnBXQcVHEs
         IgHM2NFabsvNXhtzmofEQmsC50AwRKPWdI0rcA/qLvo+6ogootNNKebZtqlFiG0TmI/C
         hQkbsOwQf5hWOlLZB41byxdQEnWhols7tfgsJiMnc8pwETld1HZTqrA+Kg+t7h/0q0bP
         pQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878322; x=1721483122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnBZ5sXzjgfYRYdC0awr55ObcGFVWdnVorTPhYTztno=;
        b=A/2iYJ0E7XTXW6li19R8rqo2NVuaEixNzU4nJVgyqOg9WSBz+fdUuEQxlxqLK7hkH1
         ST5ShRiGzYOHjVOtUtA/hvpEAL+oBmCcq3bpDCY4ei0Eqz1/d+GJJ374oT7M0yAaAAVS
         JVu8F4sJ0UklWEzZ/e/MpsgGeswO+ftvLXYN29YdijLOABXZFgpr1ICs94y+jkl/WigC
         v7Z7ZKFs+UFi0U+3Jqv8C4J/xTVuCR6bTlfiqHNu5LCxCiJmB39dRF4g33eQt9vxgoln
         RB+r9qus8Zul61obQfRyrGcqkQBQv48+JOnOW1f/rFiGDu1QHVwo8LnPRMRew3w8P+Hh
         ncVg==
X-Forwarded-Encrypted: i=1; AJvYcCURxL2XIE6crhBNI495qdWx3DmO5CZ8IMQyXqHPxI3Um4FtjDQNabOIpgvFplCe4DpfXRJNfmYdYsRsmSrEHvB/hilv
X-Gm-Message-State: AOJu0YxxIzvogNXUpsFLo4VV6qmJC/ftqZKW+RKaSx3wnQrCud2UkbPY
	lAFvvmEH7o3U7Nl13/raK4aErK0Isupd/N/QcOH58RzUvHfHkVJzod/2eo/U
X-Google-Smtp-Source: AGHT+IHig8Swlcl7DWcI8CgL4mqXTOTZ+sBu+fR5qxbaPSGMP19v92oS9iBIdLWEAvhX5nR7Y6znlQ==
X-Received: by 2002:adf:e64b:0:b0:367:9795:92ba with SMTP id ffacd0b85a97d-367cea73740mr9196148f8f.23.1720878321441;
        Sat, 13 Jul 2024 06:45:21 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:21 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 0/8] clang-format: add more rules and enable on CI
Date: Sat, 13 Jul 2024 15:45:10 +0200
Message-ID: <20240713134518.773053-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of my series to add clang-format to the CI.

The series was mostly inspired by a patch sent recently to 'include
kh_foreach* macros in ForEachMacros' [1]. I was wondering why we don't
run the formatting on CI and reduce some of the workload of reviewers.

We have a '.clang-format' file to provide rules for code formatting.
The commits 1-5 aims to add more rules to the file while deprecating old
ones.

Commit 6 enables CI action on GitHub and GitLab to also check for the
code formatting. Currently, it is allowed to fail. This way we can build
confidence and fine tune the values as needed and finally enforce the
check in a future patch. I'm not well versed with GitHub workflows, and
I mostly tried to copy existing work there. Expecting some feedback in
that section!

Commit 7 fixes an existing issue with the 'check-whitespace' job, which
is failing as success in the GitLab CI.

Commit 8 adds the `RemoveBracesLLVM` only in the context of the CI. If we
decide against it, we could drop this commit from the series.

1: https://lore.kernel.org/git/4e7893f5-2dd9-46cf-8a64-cf780f4e1730@web.de/

Changes against v2:
* Dropped the commit to add 'RemoveBracesLLVM' to the in-tree '.clang-format'.
Now, we only add it in the CI context.
* Added comments for the reasoning and picking of the ENV variables in GitLab's
CI. Also changed the syntax to be more readable.

Karthik Nayak (8):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: ensure files end with newlines
  clang-format: replace deprecated option with 'SpacesInParens'
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided
  ci/style-check: add `RemoveBracesLLVM` to '.clang-format'

 .clang-format                     | 36 +++++++++++++++++++++++++----
 .github/workflows/check-style.yml | 29 +++++++++++++++++++++++
 .gitlab-ci.yml                    | 38 ++++++++++++++++++++++++++++++-
 ci/check-whitespace.sh            | 10 ++++++--
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             | 21 +++++++++++++++++
 6 files changed, 127 insertions(+), 9 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

Range-diff against v2:
1:  6cf91ffc86 = 1:  6cf91ffc86 clang-format: indent preprocessor directives after hash
2:  beb002885f = 2:  beb002885f clang-format: avoid spacing around bitfield colon
3:  3031be43e7 = 3:  3031be43e7 clang-format: ensure files end with newlines
4:  bc1550e300 = 4:  bc1550e300 clang-format: replace deprecated option with 'SpacesInParens'
5:  840318a4c9 < -:  ---------- clang-format: avoid braces on simple single-statement bodies
6:  0ecfd8d24b ! 5:  4586c0094b clang-format: formalize some of the spacing rules
    @@ Commit message
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## .clang-format ##
    -@@ .clang-format: RemoveBracesLLVM: true
    +@@ .clang-format: PointerAlignment: Right
      # x = (int32)y;    not    x = (int32) y;
      SpaceAfterCStyleCast: false
      
7:  11a9ac4935 ! 6:  c18cb23369 ci: run style check on GitHub and GitLab
    @@ .gitlab-ci.yml: check-whitespace:
     +    CC: clang
     +  before_script:
     +    - ./ci/install-dependencies.sh
    ++  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
    ++  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
    ++  # be defined in all pipelines.
     +  script:
     +    - |
    -+      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
    ++      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++      then
    ++        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      then
     +        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
     +      else
    -+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
     +      fi
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
8:  caccbf8264 ! 7:  4d08c570bb check-whitespace: detect if no base_commit is provided
    @@ Commit message
     
      ## .gitlab-ci.yml ##
     @@ .gitlab-ci.yml: check-whitespace:
    +   image: ubuntu:latest
        before_script:
          - ./ci/install-dependencies.sh
    ++  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
    ++  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
    ++  # be defined in all pipelines.
        script:
     -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +    - |
    -+      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
    ++      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++      then
    ++        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
    ++      then
     +        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
     +      else
    -+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
    ++        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
     +      fi
        rules:
          - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
-:  ---------- > 8:  2b39431f93 ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
-- 
2.45.2

