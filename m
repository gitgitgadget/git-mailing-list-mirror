Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96E8814
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722877; cv=none; b=TDSKVPvFopFUdFyxByaXn37Z3q7Sq0ZkMWiNjOPd/aOIyGNqb9d988/FpdLoaEano+kQ6dz/2OBo3WqfS+sVqT+C90DXvIT3jM2NCh2YxYJVd7//CXrTIKLJ0lkEV/GgIIJCDSPMoZpyg/bdre9BRgUHc5TSAjhskAusYE1gyBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722877; c=relaxed/simple;
	bh=S21wFozdgGPgJEYwjWem6YWoDPQFwRn8ua1JDC34T70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAcwWRK3rr+Mde3mDLFkMtaCoYBW4iSaYPwGhOyorb+luRxm8P533T5mLDrWFqsPTc1oBUdSXRmdXcn52hVdtYB7T5JsjJnXNRsr07jJ7C828VHnksloFjFur92JZccDo4dvAxejOJmJLQxkouoyDRNc/2AjhqDFY3VaVzK9upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf8lJ6iu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf8lJ6iu"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01afa11cso3245444e87.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721722874; x=1722327674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Anz3617af4qhH+DytFnV5M+etEjEDkruHcaa9sQgFhY=;
        b=Qf8lJ6iu03ChAbzwHhSfpVUvJAMnxRehWCLTqSdg9tfq4+thjW99+TyY4yyroIkFNf
         3VKwnP9Izun1QqDc70FPUGnfwH0mNpIj7EVVQOjZy+hXYt7l6CewRnC9k4TtNB+5XqN9
         biTvoSthb1SS9aSZWPhGiGMM6mVDz//SnJziJsAmZZQFUUQ6lsXc6jX9XNMrvjytSCJ8
         cfW04JzNl6z8c53OAkZ0AIMSmdFcI3VZOzNx01c2NRWeHg/iQwJ2tE39jiDLplOLHTY+
         NkJoKhSmIAAhtrW13ikg++NFpk+FHunRJ1nR015NPWida4dm7NIU6JHb98GVMREqVy/f
         5XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722874; x=1722327674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Anz3617af4qhH+DytFnV5M+etEjEDkruHcaa9sQgFhY=;
        b=A2JgAQR0rRNpO4bXyW5O8YzUrNIot/FepNqX2W01qJOYCNQg5PYuIf0fM3XpTTlIxO
         kXWY1o1J7HEAWoWslzr1V74l214vZyZg+PU8wFxFge9zFtilW3iF0z1kVCDDqDnMARf9
         GkmaPqQFGLfU+WUnS2kUbVCwj75goGdolBKD5/mAITKfuyAQi/fv35A6doG2zQJ63U3N
         ojCnKI7v1gILSE5RoHTzPTrDcsrbg7G6xNMF2exumF42N3vEQQ5oDaGm+Pb7Q+sjyNGC
         KaQm1ppYAtKcsMJN7XOwHePjwqotTxPK6zAiQ2nYEoOdadvtsmzaHz6qEJ8nM5jw+wcx
         niNA==
X-Forwarded-Encrypted: i=1; AJvYcCV5PM6+CTXAKp63s3IUMBTGD4rSfwUhFMlI/1ajUIZ/2zdQR/EJpLWKHy29UeirDjs6ZVWayz6AokrShe2carOynhHT
X-Gm-Message-State: AOJu0Yy3wjLax+cF+xjbbAJgLG4IGNxgNWXxVl0ZYyF4ietU0jcdgi/t
	1CuHnu26n/qv52kmV1mk5YSGOJ8bO8DiV1VTc8b5e1exDSEFnZ4i
X-Google-Smtp-Source: AGHT+IEQZK+jUT1mU+Kw6JVEwRnHZ7IF3G9ycQUGDDbTbCMYOoIRFC4gw60IBW3+u8o8u+24dDZPnA==
X-Received: by 2002:a05:6512:308a:b0:52c:cd4f:b95b with SMTP id 2adb3069b0e04-52fc4045538mr1397139e87.22.1721722873823;
        Tue, 23 Jul 2024 01:21:13 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:45ae:72d0:1982:e034])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a9f463194sm24026266b.112.2024.07.23.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 01:21:13 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v6 0/6] clang-format: add more rules and enable on CI
Date: Tue, 23 Jul 2024 10:21:05 +0200
Message-ID: <20240723082111.874382-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v6 of my series to add clang-format to the CI.

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

Changes from v5:
- Used 'C=${A-${B:?}}' instead of 'C=${A-${B?}}' for obtaining the base OID
in GitLab CI script. The difference being that the former also checks
for B being empty. With this we can simplify the script from

    R=${A-${B?}}
    if test -z "$R"
    then
        error
    fi

to 
    R=${A-${B:?}} || exit


* CI without issues
  - GitLab: https://gitlab.com/gitlab-org/git/-/jobs/7394162598
  - GitHub: https://github.com/KarthikNayak/git/actions/runs/10037207688/job/27736512636?pr=1
* CI with issues detected
  - GitLab: https://gitlab.com/gitlab-org/git/-/jobs/7394406605
  - GitHub: https://github.com/KarthikNayak/git/actions/runs/10037229508/job/27736859486

Karthik Nayak (6):
  clang-format: indent preprocessor directives after hash
  clang-format: avoid spacing around bitfield colon
  clang-format: formalize some of the spacing rules
  ci: run style check on GitHub and GitLab
  check-whitespace: detect if no base_commit is provided
  ci/style-check: add `RemoveBracesLLVM` in CI job

 .clang-format                     | 25 +++++++++++++++++++++++
 .github/workflows/check-style.yml | 34 +++++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 25 ++++++++++++++++++++++-
 ci/check-whitespace.sh            | 10 +++++++--
 ci/install-dependencies.sh        |  4 ++++
 ci/run-style-check.sh             | 25 +++++++++++++++++++++++
 6 files changed, 120 insertions(+), 3 deletions(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

Range-diff against v5:
1:  6cf91ffc86 = 1:  6cf91ffc86 clang-format: indent preprocessor directives after hash
2:  beb002885f = 2:  beb002885f clang-format: avoid spacing around bitfield colon
3:  3922529001 = 3:  3922529001 clang-format: formalize some of the spacing rules
4:  ae23eb5af8 ! 4:  14718625ad ci: run style check on GitHub and GitLab
    @@ .gitlab-ci.yml: check-whitespace:
     +  # be defined in all pipelines.
     +  script:
     +    - |
    -+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    -+
    -+      if test -z "$R"
    -+      then
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    -+        exit 1
    -+      fi
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
     +      ./ci/run-style-check.sh "$R"
     +  rules:
     +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
5:  a38cde03a8 ! 5:  fb8c30852b check-whitespace: detect if no base_commit is provided
    @@ .gitlab-ci.yml: check-whitespace:
        script:
     -    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
     +    - |
    -+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
    -+
    -+      if test -z "$R"
    -+      then
    -+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
    -+        exit 1
    -+      fi
    ++      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} || exit
     +      ./ci/check-whitespace.sh "$R"
        rules:
          - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
6:  008e77bd0a = 6:  08c5bb777d ci/style-check: add `RemoveBracesLLVM` in CI job
-- 
2.45.2

