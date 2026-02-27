Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061B44DB60
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220644; cv=none; b=Vo0O4K9O2kMgl/zD+STPFYc7cc8D8+1vIYGXLlXkPPIfDIoh9qdJ3oiWsElBYKWO3lZ1L1JZbHXluEkQQgMYwZQqPBJgw6q7p9KNwJhRdOqGL8wtsGDo+b2asMGQNAIoGZdIqLTTT3bzg/dvShVAMu5nMhzqoWXziHNFFVloyGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220644; c=relaxed/simple;
	bh=9S3wN73kTsVqMhgOoeLoBUctxKniv746T6WWmCiomVk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=isAGkEKy9FQqANffoIPXjqK09Wr90TFOmL45xbtes0a2GA5OAAfRyKyDoJ4LUUbkCkyJ0NiarWhJl+lJZzkTwhg76fRO8MI/9dRvfkhXHHOKo+pOJ5ZPVFZn6NY+mne/vvYBk9ZKd9vCQ0eiDcmfJDnZV2siEJvb7m4xFAfWFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMfYKBw1; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMfYKBw1"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1275750cfc7so4034469c88.0
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772220642; x=1772825442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLmbkBd9JWRzmpwP0q2qDK2nzoBwk2FF9miJRYkkPgY=;
        b=KMfYKBw1/miWSKFIK8zfa+FGEcYymz0vRxpzMtEysj9S5KM5RE2BtxcF5BRSiwWMhW
         Y3CRh0NT25GT93rWj10mKIDTH90HYNS3254/5jcSMaqCRKAH7vXbpuycYKv2ziziCMLG
         rn3wH9xLlKfeMCb1g6ZK3KD9aOWqCCi5JNbil3Oh6fbQjHVK0eJAdzDfBV3hnkduFvBF
         PIcaUUxSJkpJxC9ETGZpu7TaeVpeQ3JFtTVf+1+/ULiteZqpZsbBMOyUqVu5zwwV9yeB
         ynde8Y+P0nTIfXZKq57vaCcYOOuAFrpqnZTzfzSkcqytFrde/sOOHAj6BxtU0n7n/Kfn
         Dfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220642; x=1772825442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLmbkBd9JWRzmpwP0q2qDK2nzoBwk2FF9miJRYkkPgY=;
        b=mQBfOJjAh7j/6FMiPlaNK9MzJCOnEwpauAYZ/Gr/9ilC5lvnCfcIpaoKX2yQ0bonzG
         PV02mpKZbgjIR9ufTKE2nxc+QCQEiZ2sRLKTHPTP1IgsPsX2Ums+wKD2fVACVb3zAL42
         /COOy1r8MqeeLQ9msghpoO0U2lKdJomLwNVwrMIblNFAgXmO2kfOboJAZUOzW7O2BQ14
         wyMDC7GYVKYTk7j4CacU5HD7DU9FWE7j++IHnahApJ+UlpwFEP0DIv/WlJ925mguNEw2
         nXk1ZziKVJ/XXdE6YQY/rFsB4z3du6fAsaFvFwI60zIQ43D5pxitcAJSmiS07hAPQKKh
         srAw==
X-Gm-Message-State: AOJu0YyzG4GqHNDD1gCmNMp1lQObZkhf/MdU8eKb7Iwl8Nb/MwlezwCg
	xUTHleO+VI85ppRNLqDae2PjfecUuX2//EABCNMNkVHuB1DSzDkSfl75PkPv3Q==
X-Gm-Gg: ATEYQzy8bVu3q+Hn8pvdIIGQfrFpvJ+Ms49vpTLSqMhSTslPhE5S3tALCck5GHSIAuy
	Clh/kfPSE2giEo7fYQtw/rvrXm7YLN4xr/Vip9H8xsx9MtGR3D7ztFMZmUENxlaNHTSxuDFs3Pj
	xLqiTWkkilujCSurKHDXWGDJUtkBBhr28L7Lwjp1uIzBz6iG6BMGJfY9Rvku+yJmUVbbGvjD4oV
	1Wx9M1V4v18NhOWeQH7YjTBBh115IqtwsdqmiWVaFkUzTXwIdPkXEGIr5TWqOo88DMgFqWZZFQQ
	Bb4M9NxusptOB5VEK2zT/w/9ZCAKA4rEYi8wjCZmKrcgagws2C23xvGkUW48ejqdfvM7k9lPA9m
	hSwQUL8ZUsIg70Tfys1fwgYoHqzE7A84i/yqJmN2gYeC7bXXsQ82LJKQFjzSo+rRCsZMPMVwHWz
	tZlD4Bvzo05e2Rbh/Fp41ZFbapvI4=
X-Received: by 2002:a05:7022:b8d:b0:123:34e8:aec2 with SMTP id a92af1059eb24-1278fc2caf0mr1603759c88.1.1772220641732;
        Fri, 27 Feb 2026 11:30:41 -0800 (PST)
Received: from [127.0.0.1] ([172.184.191.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm5849633c88.14.2026.02.27.11.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:30:41 -0800 (PST)
Message-Id: <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
From: "eslam reda via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 19:30:29 +0000
Subject: [PATCH v5 00/11] repo info: add category/path keys and --path-format
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    eslam reda <eslam.reda.div@gmail.com>


This series now focuses only on git repo info improvements.
===========================================================

It introduces category-aware key requests, adds path-oriented keys (path.*),
and adds --path-format=(absolute|relative) so scripts can request stable
path rendering behavior.


What this PR does
=================

For git repo info, this series:

 * introduces explicit info-context plumbing in the codepath,
 * adds category-key expansion (for example, layout expands to layout.*),
 * adds path-oriented keys (path.*) for common repository locations,
 * adds --path-format=(absolute|relative) to control path output style.

Tests and documentation are updated accordingly.


What this PR does NOT do
========================

 * No git repo structure feature changes.
 * No t1901 structure test changes.
 * No structure metrics/docs additions.


Why this change
===============

 * Makes git repo info more script-friendly by reducing the need for
   multiple plumbing calls.
 * Improves output ergonomics through category requests and explicit path
   formatting.
 * Keeps this series narrowly scoped and non-overlapping with in-flight repo
   structure work.


Commit structure
================

 * repo: teach info context and category keys
 * repo: add path keys to repo info
 * repo: add --path-format for info path output
 * t1900: cover repo info path keys and path-format
 * docs: describe repo info path keys

All commits are signed off with the same real-name identity.


Changes since previous revision
===============================

 * Dropped all repo structure code, tests, and docs from this PR.
 * Kept only the repo info subset and matching t1900/documentation updates.
 * Preserved split, review-friendly commit structure.


Validation
==========

Focused:

 * make -C t test T=t1900-repo.sh (Linux container): passed.

Full:

 * make test in Linux Docker environment: failed 0 (with expected
   prereq-based broken/skipped categories).

Eslam reda ragheb (11):
  repo: teach info context and category keys
  repo: add path keys to repo info
  repo: add --path-format for info path output
  repo: add structure max object size metrics
  repo: add structure topology and path-depth metrics
  repo: add aggregate structure totals to keyvalue output
  t1900: cover repo info path keys and path-format
  t1901: extend structure metric coverage and portability
  docs: describe repo info path keys and structure metrics
  repo: reduce repetition in structure keyvalue output
  repo: refine path keys for repo info

 Documentation/git-repo.adoc |  61 +++-
 builtin/repo.c              | 559 ++++++++++++++++++++++++++++++++----
 t/t1900-repo.sh             | 192 +++++++++++++
 t/t1901-repo-structure.sh   | 250 ++++++++++++----
 4 files changed, 942 insertions(+), 120 deletions(-)


base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2208%2Feslam-reda-div%2Fgsoc-contribute-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2208/eslam-reda-div/gsoc-contribute-v5
Pull-Request: https://github.com/git/git/pull/2208

Range-diff vs v4:

  1:  99c8058298 =  1:  99c8058298 repo: teach info context and category keys
  2:  6d5b9ff075 =  2:  6d5b9ff075 repo: add path keys to repo info
  3:  5c438d045b =  3:  5c438d045b repo: add --path-format for info path output
  4:  504d9cf7a0 =  4:  504d9cf7a0 repo: add structure max object size metrics
  5:  4b502925c9 =  5:  4b502925c9 repo: add structure topology and path-depth metrics
  6:  1751181950 =  6:  1751181950 repo: add aggregate structure totals to keyvalue output
  7:  fd18f28db0 =  7:  fd18f28db0 t1900: cover repo info path keys and path-format
  8:  0525ed4cd9 =  8:  0525ed4cd9 t1901: extend structure metric coverage and portability
  9:  f17c0f03e5 =  9:  f17c0f03e5 docs: describe repo info path keys and structure metrics
 10:  1bc100d6ca = 10:  1bc100d6ca repo: reduce repetition in structure keyvalue output
  -:  ---------- > 11:  8af17ad831 repo: refine path keys for repo info

-- 
gitgitgadget
