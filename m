Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF682DC330
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839098; cv=none; b=pQwx51fZ7yXo5066cLAlz3ZQg6m4UtQGo0De/jzmIJ0z+rM7CS6F/Mm5gqggwviNBbW33MY+AiRPlGAhllKKzckgxKviAv2WISS2NFnHwX3fN1fEZJFw6Dl5uyFQQm+IZe9DuAQl0FLtPSbYWMyBewIK6itXwQwhKKDoBpNFUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839098; c=relaxed/simple;
	bh=Jg5H4/8ZuMH5G3dtvvcbd1YAGYpgqwIzb8/KX2M9UjY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HPDmEcYHl3klhJXNt0VTxVQ6A+ONwh6NwG+uYyAdZa9SBKcWS30vekqReFyW1qNiyrk3zEGq6jAv1VxP//u9kjaJqc4cnCpvFY2LWtMFmv6RffTUZSbmGmXJDeVdANev6VtLgVXdGwcLMQrkF1/UzY9reh3byEKuE73FRdOoBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYeJ10C+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYeJ10C+"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so1114190666b.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839095; x=1760443895; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC00Yv4KZZZvuyQi2SiU3XdbslQbTcN7tmmzBCtKXOs=;
        b=LYeJ10C+MUJfRePiNuOfM+F3L6pGSNFD6moSM+5Z7A2cFPii4E0Rvy68yp57VcYA4B
         emIhymPbmJERC05kIxQRqnZag92aenImmxjlBHIgr/c/iN5RlY+i2eTxSHrqj0YsxRkA
         KPaAiwBRnPqJFDkCD1xT9Mq488Dnhac76guvAC0Ymhz9sUGITdF47kIlnqJxRyu8DScl
         YtBa/NtX5KekczrBYIyMY9Wg9mfE+OnBu2+5J/5zMAOh2490FSc9ggYkbkNcbCG9vvnH
         CbjVdkNkSTklcj4OI8+K/H6KpySi23T1MXHyWbQaE5XERY+ZC7RZANO1okf4oXVjRygn
         faEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839095; x=1760443895;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yC00Yv4KZZZvuyQi2SiU3XdbslQbTcN7tmmzBCtKXOs=;
        b=Oqinnt4EZrERCtjNqMyN3CVRyTDigjSXS/xFsX4nufPJKViouhHeUuMVLvZGQCLN9l
         Kyl+cqpUdYoc7/8dWYhg8Lls8I+fHMwFZ5WCW6+NFvRy0lfS5+bs9uGQvWSl7ION6ShY
         JK2agcRC1Pv7yuCn1/cz84ALGLAziB8mYxnuxUS03HBOpYNK+Cw6gnyUb1uFxcBvJSR8
         pkopEWFpzj+ZPwCIQeZFJH2NQiX/NEEFXXU+wHdiQ7RpeOEVLipRdcUC96lJtWXanK4c
         4Ro1xO0aUD4aHE+9UICxauNOwZSE0aHKiml7OImOjnIGphfdkS9sDs9VKAC4LXewXvhw
         2/dA==
X-Gm-Message-State: AOJu0YwLF9jtCgEwqQvDNxgS8eVm6V2H5rMoPQdDRgNyyHZj+7qjgn7M
	KVueJ6+8/R+kYAkNL011Pdp3NlhJGsLkYFykrU9IKlT+4T1TZnfZBGk7
X-Gm-Gg: ASbGncsdXXJ2qJOrN0p9NOOEQ1h9HkIpLJprV8Ypr5FyRzPrD51WOkEZ8q8Dlcl7cpi
	agMlzXKJZsxuYcxsou0HUqmwzyiGUC87YW4Zdb6ZQJZY15pRbJ49FNfB7QGNIPGaxhXyX59qzjO
	ZKL1BxeKyZjYf+t6iPjaCutPZtfsf5SLtdUXKtDVmk9h5XVVeTmTA4hHgrCMnol5OqK11MOk0kx
	OVxKFjSm2C7Qja4TaDrEyCZ9a+vnaey47jihFBaGzza/5U0x7VqQXzvqnf3bYxhRVjaQnhSJOCM
	pIKMTJKBSvFXADWj894SnqL01axN1tTuUqnKK5lQ5MPyOau0Nm9f32LgAoWt7WMSwKOGm6qIWpC
	VE38aKfb6QSxtMbz4i3PHhnYAnF49K+LF7zPtEgFq1xx1gSrL
X-Google-Smtp-Source: AGHT+IHA/+LNF4mRLdIo0sT++cZKtJ1gumHe3vkcPRdEaZNlN8ccikmsqtMaWqmM7966xtpVC8lgSg==
X-Received: by 2002:a17:907:9715:b0:b2d:830a:8c0a with SMTP id a640c23a62f3a-b49c3d74a99mr1786909266b.35.1759839094214;
        Tue, 07 Oct 2025 05:11:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/7] refs/reftable: add consistency checks
Date: Tue, 07 Oct 2025 14:11:24 +0200
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGwD5WgC/5XNyW7DIBSF4VeJWJeKyQxd9T2qLDBcYtQEKnCsR
 pHfvTep1EbZeXkYvv9KOrQMnbztrqTBknuuBYd+2ZEw+XIAmiNuIpgYmOGKCmFpgzT78Yh3ZW4
 1ngPQUEvPfYYSLjRMED47lcZFiE6GQSmC3hd+y9/31sce94Tva7vc0wu/nf5WLHcbKgunjNrRJ
 m2NS97B++Hk8/E11BO5VRbxLzsmtsgCZZWcHqWVyhj3LMsHmdstskRZGO4TkzBKFZ/l4U/mjOk
 t8oBy4k5HabXgKj3K67r+ALaIf1vwAQAA
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6820; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Jg5H4/8ZuMH5G3dtvvcbd1YAGYpgqwIzb8/KX2M9UjY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3QyBSraOyxj5/Cy/cYoXLLZ+6WycCs8t
 +bkBRv7W81ZBYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/KR4L/jMg8TDEWzxJ/HhHO9n4f7ufzYcMj//KwmILD0sXrRYEn1jEp7YG8FJQ/hgCmDHx+sG
 1R1/T9CUlqyW5N7oyYO6/oraIOn+zSKc3HyFWIqqb0Y80uK7o/yoAX8qWF/tNgAjdNW+Pqm8kTN
 kgBoXDqzfctyWWGR6NgMjBuNqm+pVZyaU2xgx4XZl4Jn38bo+W41SNW3Fe6hVDuKi91900y/0un
 SyqiSCecyVVCzo4Y+OYQ4qLMYMNec0LaxeCq46Axe8Mk7kxZ3SGHelKOfChiNhyB9BdX/B+A2jF
 v79qRNazweECP/pseH6GL53EHnUsDBMuomK0UJdqs8PSDJJabOr3LfyNPkAaEym0AEYhKZ9vl4O
 RhTb3Jk/NHZyT5PPcZ5SR2J8Cpv/1qVv/DPpP65lOANUA3ZJMht6WDtQdyX++R0xIC9H0ImSLui
 9XyE+hK1VvFcxyz8/u8SVgtFGnQM4cuMl4azHLsZqIjOp8ypeerWQir6g7pkJuC1NhdVkUIN6/5
 vM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference subsystems allows for adding backend specific consistency
checks. These checks are run as part of 'git refs verify'.

While the files backend has some consistency checks added, the reftable
backend currently has none. This series first tightens the reftable
backend to make it a little more strict and then also adds the required
infrastructure and some simple consistency checks.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

We add the following consistency checks:

  1. Check for validating the reftable table name. This is treated as a
  warning since the reftable specification only suggests a table name
  but doesn't enforce it. Also there is a difference in the table name
  used in Git vs that in jGit.

We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
when:

1. The 'tables.list' file doesn't have a trailing newline.

---
Changes in v6:
- In t/t0614-reftable-fsck.sh, create branches instead of root refs.
  This worked becuase we don't have reference level checks still
  implemented for reftables. Let's avoid confusion of a breaking test
  when we add reference level checks. 
- Link to v5: https://lore.kernel.org/r/20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com

Changes in v5:
- Added documentation around the return value of 'parse_names()'.
- Added a test to validate that 'git refs verify' doesn't barf against
  a clean working repository with multiple reftable tables.
- Link to v4: https://lore.kernel.org/all/20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com

Changes in v4:
- The biggest change is to iterate over the tables in a reftable stack
  for consistency checks instead of all files inside the REFTABLE_DIR.
  This avoids all race conditions. Also, since we only check the tables
  in a stack, it no longer makes sense to check file type.
- The discussion about update indices was concluded that tables indices
  in a stack must be strictly monotonically increasing. While modifying
  the code to do the same. I realized that we already have this check in
  'reftable_addition_add()' where we check while adding a new table to
  the stack: `wr->min_update_index < add->next_update_index`. So I've
  dropped this patch from the series.
- Change parse_names() to accept the output string array as an argument
  and return an error instead. This makes the flow a little easier to
  understand.
- Link to v3: https://lore.kernel.org/r/20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com

Changes in v3:
- I took a long hiatus from this topic, mostly due to other priorities.
  This has been rebased on top of '92c87bdc40 (The eighth batch,
  2025-09-12)' since there were conflicts.
- Junio suggested that two of the consistency checks (trailing newlines,
  sequential update indices for tables in stack) should actually be
  checked during runtime. I have made that change in this version.
- I've cleaned up the code and modularized the 'reftable/fsck.c' code.
- Invalid table name emits a warning, since the reftable spec doesn't
  enforce it but only makes a suggestion.
- Broken down the commits to make it easier to review.
- Link to v2: https://lore.kernel.org/r/20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com

Changes in v2:
- Ensured that 'struct reftable_fsck_info' is passed around as a
  pointer, this provides a smaller footprint (pointer size vs struct
  size).
- Run FSCK checks for other worktrees too, even if one of them fails.
- Separate messaging for table name vs table check and add additional
  test.
- Use the relative path in messages used.
- Small style and typo fixes.
- Link to v1: https://lore.kernel.org/r/20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com

---
 Documentation/fsck-msgids.adoc   |   6 +--
 Makefile                         |   3 +-
 fsck.h                           |  39 +++++++--------
 meson.build                      |   1 +
 refs.c                           |   4 ++
 refs/debug.c                     |   1 -
 refs/files-backend.c             |   3 --
 refs/reftable-backend.c          |  58 ++++++++++++++++++++---
 reftable/basics.c                |  37 ++++++++++-----
 reftable/basics.h                |   7 +--
 reftable/fsck.c                  | 100 +++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h         |  40 ++++++++++++++++
 reftable/stack.c                 |   7 +--
 t/meson.build                    |   1 +
 t/t0614-reftable-fsck.sh         |  58 +++++++++++++++++++++++
 t/unit-tests/u-reftable-basics.c |  24 ++++++++--
 16 files changed, 330 insertions(+), 59 deletions(-)

Karthik Nayak (7):
      refs: remove unused headers
      refs: move consistency check  msg to generic layer
      reftable: check for trailing newline in 'tables.list'
      Documentation/fsck-msgids: remove duplicate msg id
      fsck: order 'fsck_msg_type' alphabetically
      reftable: add code to facilitate consistency checks
      refs/reftable: add fsck check for checking the table name

Range-diff versus v5:

1:  85480cbb60 = 1:  671a79a3af refs: remove unused headers
2:  b8fdad314a = 2:  dbf9df8d3c refs: move consistency check  msg to generic layer
3:  4ce029ed8e = 3:  dbc478dbe6 reftable: check for trailing newline in 'tables.list'
4:  50655b2272 = 4:  062d66f7ed Documentation/fsck-msgids: remove duplicate msg id
5:  0b4c2295d9 = 5:  a70974a39c fsck: order 'fsck_msg_type' alphabetically
6:  2abcaa9b23 = 6:  a1dea4335e reftable: add code to facilitate consistency checks
7:  1f59191f22 ! 7:  dcd172827b refs/reftable: add fsck check for checking the table name
    @@ t/t0614-reftable-fsck.sh (new)
     +
     +		for i in $(test_seq 20)
     +		do
    -+			git update-ref branch-$i HEAD || return 1
    ++			git update-ref refs/heads/branch-$i HEAD || return 1
     +		done &&
     +
     +		# The repository should end up with multiple tables.


base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

