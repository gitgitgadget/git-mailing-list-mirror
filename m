Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814871DF985
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382255; cv=none; b=FqQJTmhK4wSuXo5CcRMaBiHuvjxDphoySvQ5xuv9HGY/DjytinF68llc3eHPbB5fPMj0/8/2EgwfH8Vs51Iosz6EQRMr1VrHJurU5xr1uhcJxP8t3VI2ySIMpJ8H40a9L22TMlDP8dwKmlYKshIj8RSaF08IqSZOLn6RAqwBuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382255; c=relaxed/simple;
	bh=OZzmidSbOixr2kjZZGQCtobQjiXlohWWg5UDLOzD+y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RrLjXrXlShfqJ4yv1EbJb+huGffMlrpHAFD7g1LlsMxZFwNfMJPb1z2poqFVYj6j6TZEsusXnHebqOdSabnLiKXdK7rF9yrwl9qJTZ7vo60xSrlLrSNsX34x7lakdrG8El5cePlqPBkvDLTUaFngco+HmcYVHHjVeIGTLwq85l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIIdNg1r; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIIdNg1r"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae223591067so586179066b.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382251; x=1751987051; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s4JvbfCHM7OJwTd9RJloWARvcIj2YFh92ms+w7EXQ6c=;
        b=AIIdNg1rsvOsVcy9yRvls0rnOP1fEH9HQOuXa5w9+gKfSVFtvWQQzYLUn0+KJnjC4X
         Ez+xC3nG1CMhM3KvJROtCdtfj1buu6mZdVxsQ3gJ/ruARdpiYbEWQA5RI3V7rb2pMHY2
         wyY8muo/GCMUu/VUXTdcBRtvd6VRgrSXg0E1eTrOqt/lM4klstgJBSBsyQqryf0BF0dc
         7jWhUDaBQLKS69TokETeUF+GrMo+dr7GiRuZcm7RrKmBuIkk5qfMVSGoi+qp30Ao956c
         9wAojCsZGRiB2Yam59T9vFl14SO8XdcRmU9u3Ixf+OPl7uy2kuD3eCm8BBBU+LE1asFr
         zuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382251; x=1751987051;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4JvbfCHM7OJwTd9RJloWARvcIj2YFh92ms+w7EXQ6c=;
        b=DrOGR1qrlT5rvwH+OVLGgpvVhEjIWkr+ls0z8sYdWQ9j01lhLJRvGlyaVic6Dlowd/
         6cdUhAyNUbK0rpv19Hey070FKvZA3ABtH1vyVYA5kCPKf6pL/nfnoxiB6gFHL3lHCnWa
         CNY4KL9G+ySFckWLosXvkOK73PLYvO8mpnSBwWh9G72Y3KhcRE9hcI6zuCHFVwTj1Rr6
         ox6QBHx5uVkNqr7uwb9ahJ/U1SxKSMrt5CaaOnRqDTuKiaeykQZCWVAEsFy8fhCaTZMd
         5MAiU/zbDXMOHjwJ8BwfgKqdrCw8lVeOUM3gF8FgksBfl6O6NIMQi6yXnZVpuA5UUgAW
         SuAg==
X-Gm-Message-State: AOJu0YyGko1V/j6bM8R+JfSNodBRMTU2ye1PhvjiXuzi6XuYjiKgRZhP
	vT/FDuhjSYYjvpZAbVMC9PU0eg+DQLs2Q8bDv38I+nchJiWCpp+UTeZWi4o1x/4I
X-Gm-Gg: ASbGncuZNQOkAmhvzo4j02Iap7+5HvuYcwEJpY9dNEqqNpZF3C/jCl1DR6EmaPprBhS
	vsIWLL7fvNIzS4wt82Tdx6kCdvRQrBTOBMq4QBS6ywWsKZKxp3tMIjIke2uMYfnJsjE/XhCwxyu
	9hD1ZNennKvs+oSSadQG/fb/PQh0EtyXkvV/P7xh/mtSn9IAso7wowX0+9FpHFpK3xkJu/IGFNa
	jBQZJ5QDJXefMaqGzafhbndsaqagtnFl26zY4mMwuLRZviMPkCenHm/KqhCd2Lh6NGZd/H8JMgc
	BMkVXOP4dKyTR+OAf9B2Tng/Q5/mTRdSDuh8F+JRyp/MYQ==
X-Google-Smtp-Source: AGHT+IEqFe7pnHrXLSYnfu/rpUPaoEagbdr/SckzIn8gH2y5vUTwueABzNjFpIOHL4WONb/yycbO+Q==
X-Received: by 2002:a17:907:fdc1:b0:ad8:93a3:299d with SMTP id a640c23a62f3a-ae3500f39bdmr1732026366b.30.1751382249368;
        Tue, 01 Jul 2025 08:04:09 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6747:3d30:531b:25db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm895472266b.102.2025.07.01.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:04:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
Date: Tue, 01 Jul 2025 17:03:26 +0200
Message-Id: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL74Y2gC/x2NQQqFMAwFryJZG4hVi9+riIuosWZTpRURxLv/4
 HJ4zJsHsiSVDH3xQJJLs+7RoCoLmDeOQVAXY3DkWvLUYk0eg5647gmF5w2TrHhw0MinuUgTd+x
 +LL7xYC+H7Xp/hWF83z+WgJR2cQAAAA==
X-Change-ID: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2761; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=OZzmidSbOixr2kjZZGQCtobQjiXlohWWg5UDLOzD+y8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhj+OcEEfjB4NaxE9jBhi9rAuEQ+uinVkrbo
 EqnJRzb9o58YYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoY/jnAAoJED7VnySO
 Rox/IIYL/jnthAG1uQp9RPkdLc7+McL7ABHlveKX1zb3fXfmSBh7W2VXXrEmHlK0bqb6X7wsDwV
 GpVg+YAvjuEIXE6Q3OL5gAwV5D7hECPnwMDrqRDCbJYGVIAWzxLZ0DBoOFM+r8p9t2wt03X+zs3
 /mfq3WH2OAiET4KJzCQUaN1dkz9P4UA8wqyEIa5X1eO/VW/6L4x718OvRSwTEst0JuGoJgq+ujc
 wjM6cmeTtezHDG7Rg7CTVnB7yy3JLbmpNi8eZEp+UXpsywXkmfg1bUlWwT9TpW5ahFQimn6eYN9
 i3Mxm7VQIqyL1pMrUoSuvbS+N93xdiM/FA82QtXJnPSm+BkozybMsEcsSfEJV39yOqIz9icXKyo
 JSxNViOm3+PjXCzdoSdFn9BsvD+pXgS0POqdQgMoyHCdSaeXM0lxN9z9BtdETFGqiL30B0BXR0Z
 WjY3pWFLTtdbYDGi01XS+Aymi9MKaDCiZGhsEQ+gONmFKCmUmRIo5wBtruYl/HbKXLloW7A8Uy4
 zI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git-for-each-ref(1)` command is used to iterate over references
present in a repository. In large repositories with millions of
references, it would be optimal to paginate this output such that we
can start iteration from a given reference. This would avoid having to
iterate over all references from the beginning each time when paginating
through results.

This series adds a '--skip-until' option in 'git-for-each-ref(1)'. When
used, the reference iteration seeks to the first matching reference and
iterates from there onward.

This enables efficient pagination workflows like:
    git for-each-ref --count=100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-200

To add this functionality, we expose the `ref_iterator` outside the
'refs/' namespace and modify the `ref_iterator_seek()` to actually seek
to a given reference and only set the prefix when the `set_prefix` field
is set.

On the reftable and packed backend, the changes are simple. But since
the files backend uses 'ref-cache' for reference handling, the changes
there are a little more involved, since we need to setup the right
levels and the indexing.

Initally I was also planning to cleanup all the `refs_for_each...()`
functions in 'refs.h' by simply using the iterator, but this bloated the
series. So I've left that for another day.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc |   6 +-
 builtin/for-each-ref.c              |   5 +
 ref-filter.c                        |  57 ++++++++----
 ref-filter.h                        |   1 +
 refs.c                              |   2 +-
 refs.h                              | 153 ++++++++++++++++++++++++++++++
 refs/debug.c                        |   7 +-
 refs/files-backend.c                |   7 +-
 refs/iterator.c                     |  24 +++--
 refs/packed-backend.c               |  15 +--
 refs/ref-cache.c                    |  95 +++++++++++++++----
 refs/ref-cache.h                    |   7 --
 refs/refs-internal.h                | 152 ++----------------------------
 refs/reftable-backend.c             |  17 ++--
 t/t6302-for-each-ref-filter.sh      | 180 ++++++++++++++++++++++++++++++++++++
 15 files changed, 507 insertions(+), 221 deletions(-)

Karthik Nayak (4):
      refs: expose `ref_iterator` via 'refs.h'
      ref-cache: remove unused function 'find_ref_entry()'
      refs: selectively set prefix in the seek functions
      for-each-ref: introduce a '--skip-until' option



base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
change-id: 20250605-306-git-for-each-ref-pagination-0ba8a29ae646

Thanks
- Karthik

