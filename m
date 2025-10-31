Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9333E363
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920550; cv=none; b=HkHRYB3VEwVwfbRdyEUeuZ/RYTrTonCpzxkfClsjcvdkni7We+yKUOAIy6yN0ZGFGmW6CJA8IZlyCdDBZtiuIx/04XyCnCKHFW9IpW0crPz+Z6yKsF1cuPiA5uJ8KkDQuyE6cYCC/tyIiEhXfLASrHZ6SY07to/AOmmjvTLrI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920550; c=relaxed/simple;
	bh=v4pq/sdWur3En5mzMVKdMnBGsYjZ9Vt99HM0E2Q0DG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TlQxaf3NKWqoXYWnpraT/G/Glo5rikbk/oC0NNbDEZp4DFoxkWhEN41Buvfapa6POmONU8AH6SceVmiDpLdJ8T3lKwOeRaJEzpW2ZvTSBxazFXeAQtd6CZ3FNCj1zvk0wzsc5fiIDly+XgKWhG7K98dZbiL1oCdUROkIWgpW1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJitTW/m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJitTW/m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dae5d473so18628165e9.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920544; x=1762525344; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WPbnSbKYGo74VxoAReWKwlbNssGllah2kEBKz/1nPQ=;
        b=eJitTW/mqqepnwCnM+LZ/TRWNEj9rnI2eo2hubXSPRk+L4KbYoIh0WFyotMvbj/W62
         qzCRKwaziA3qEC4p+96rQY4IrYEcoz7Wbw8IJWFWS26FDaG6l36RkNgMMEznXzv5H/LL
         vUE1kXatLDTQreNTMkIALZnIgEJV73c3JtwUC34v66Y1p7RANbF3nRW0PWcs6j1puX2Y
         B7/heF+IvbTVKcPJNwTb1v6Bh3xSpv3s77ka3suHGL8CgWOKmAmdVRJkmshSMfjpbfWK
         SVxZqMaH70XDCJ35iOtQtS91ZDp0cYOmKL0LHwJ3s1z+fXObsdtGkInYsiIa+lBomv7N
         7M6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920544; x=1762525344;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WPbnSbKYGo74VxoAReWKwlbNssGllah2kEBKz/1nPQ=;
        b=u0JrqHpkaH5Yub4V0yKY1jn+LKNExuy01S8cHk+g7/KlfMH32C5+JUq7EHhPKEGDk4
         kGKZj0D4luU/KCSUimok9u819yMAFGBSaDoMLm/IecbbC5fRfMwP8jpdboTXbVTc6p58
         wOn5BKnCF72gwUALRY6tcuMnI5Vf9QRzTGk3JbFWV2IReZP9vZWGcPUuacON/Spg0S9d
         +e1kPz75cbsCuvvgJi7TRPmyMEgT8qq10Kfm6fMtQxmL6XgOeapxsc3r6mSPvttmHEj6
         6G1b04uwIi1buABMvxRoIj0LgD0KJIxJRXGeOKAZkSvpiUQeJVs8Z/0gmxdvIMuQHNNi
         WMYg==
X-Gm-Message-State: AOJu0YzX86rg/k/iZZvqgmOoWOqgGszJgtp0g/vVxzpobHBjWXMpy2DV
	IFUCg24oYjioQz1CLaidzE18vCZ1U8tzGrx+DJQtEzWv+Y7romCyC77lp6qblwyn
X-Gm-Gg: ASbGncvKPr/MTpzRWQltSaf5a2mgSYByxZzxnGw8uqyzo6FGyFxQau7Vdoe0OyQqJ7p
	Dao6iIo28NJjVsXLCmE0CKp3HFt+EUx2nlzknAhQhostMjDZka3VkeKL80sjcWECb19glbPkbBx
	HGOj5Gkbt3mf4qt6OI5R6kokf1vPcPaaILJ0nCGSFbc/RWCeaNeQE122TQqU6cjjsr/1TvU92fZ
	HT6y2HpLGEkahGC2kkEUZmujVZACTd4TXYJMrdvOnUKP2iNTNHKEAwo1VD6CCu076pphePmhK70
	pndkiOc5V+S93AcgZLXgViemKQ0eW8IvkgOgTUZCMf3py3S6DiUx41dRek4qd8LgYYVkKMi+mQ1
	sFT3SrdhyuzydR34do/bW1kuOZ+DWgfiT7sFuRX7TtXYQcsBABWVGyf4QW2mMcGHdim9rMXoldr
	Zsg5bug8zEQJ0b+g==
X-Google-Smtp-Source: AGHT+IGrQ9dIpX1EHwU2nClGsmDeGBlaxj2U7YfA3ixkanpxPZKxN31NyDBLnQeIVeewElyCU6RAPw==
X-Received: by 2002:a05:600c:3511:b0:477:a9e:859b with SMTP id 5b1f17b1804b1-4773089c496mr35799645e9.24.1761920543815;
        Fri, 31 Oct 2025 07:22:23 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:23 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/5] maintenance: add an 'is-needed' subcommand
Date: Fri, 31 Oct 2025 15:22:20 +0100
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzGBGkC/x2NMQrDMAwAvxI0V2CbxkO/UjooktKIYrnEaSiE/
 L2m4w13d0DT1bTBbThg1d2aVe8QLwPwQv5UNOkMKaQxhhRxzAlJBNtnQq6lkAtuFXlRfqHNWMh
 8UyfnrjZ0VVHBEJk0xOmaQ4befq862/f/vT/O8wcfbLNUhwAAAA==
X-Change-ID: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3091; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=v4pq/sdWur3En5mzMVKdMnBGsYjZ9Vt99HM0E2Q0DG0=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh5R7yV4ffui6bJ9zqevkBvyh8E2cpV6H
 /+5y78ICaFtgIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/AosL/2fTDIPTWHvt+lazPLUA0dJnjYcRJ6xe0PhTnpkGPu5sEvTgBIHerqjBBE/ATBXlESo
 7h+X0E5VkY/pzQzg7nmythuYAXH8JiRL1s9oYgLwhHu16hDujay1fwqt1pcoMsLnndir949wfii
 Da9xU5fJIFrhxVbl2aqkvZwt0wbi8+Tio0GYBSsYNtWbS+heJEfxAyjQ+rOXT7Ux5BM/r5dfLvr
 A1DRHkYio2rtamT+6slnHW4JWVnOwYDH5CBNqe+1MSkGAAmWhPk42ldYU2VHfPrH3dzzt3IluLK
 DsZQdQR16VO9aaeyUdJUtAbX7X/hEwf+I6PBpFevwCrvkx+NG2YnHc/ckyFKrDGzQ0Jx1tkw3k0
 2r55r6MlrShOvNpfME6i5k4XxrJYOOj7cdpdgDe+y+3cyl5FyEaZwgn/dEMk8VyxBWgphaSXnZe
 8OBzu1LOLFAfG+WN66pXQbgWWvRmDGyGP9XkY1FAac1C3hAmxyT4P1J8Ug0Hh+Djn7gpauEMMw5
 HI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Hello,

I recently raised a patch series [1] to add 'git refs optimize --required'
which checks if the reference backend can be optimized, without actually
performing the optimization.

Back then, we had decided [2] that it would be a better to broaden the
approach and add a 'is-needed' subcommand to 'git-maintenance(1)'. This
would allow users to check if maintenance was required for the
repository and users could also provide a task via the '--task' to check
if maintenance was needed for a particular task.

Ideally the subcommand will be used with the '--auto' flag which can
check the same heuristics as that used with 'git maintenance run
--auto'. Future patches can also add support for the '--schedule' flag
which can be used to check required schedule it met. However that flag
isn't added as part of this series.

This series implements that.

Commits 1-3 add the required functionality in the refs subsystem to
expose an 'optimize_required' field which can be used to check if
backends need to be optimized.
Commit 4 utilizes this within the 'git-maintenance(1)' code.
Commit 5 adds the 'is-needed' subcommand to 'git-maintenance(1)'.

This is based on top of master a99f379adf (The 27th batch, 2025-10-30)
and is dependent on the following series:

    - kn/refs-optim-cleanup
    - ps/ref-peeled-tags

Merges cleanly with `next`. I think those two topics are close to being
merged to `next` so hopefully this dependency tree doesn't get too
complicated. I'll rebase as needed to resolve conflicts.

[1]: https://lore.kernel.org/git/20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com/
[2]: https://lore.kernel.org/git/CAOLa=ZRdxm787nE4FSr2VUHDB+hW06Ggc6yUcKmeTKAb6B7YOA@mail.gmail.com/

---
 Documentation/git-maintenance.adoc |  8 ++++
 builtin/gc.c                       | 86 +++++++++++++++++++++++++++++++++-----
 object.h                           |  1 -
 refs.c                             |  7 ++++
 refs.h                             |  7 ++++
 refs/debug.c                       | 13 ++++++
 refs/files-backend.c               | 11 +++++
 refs/packed-backend.c              | 13 ++++++
 refs/refs-internal.h               |  6 +++
 refs/reftable-backend.c            | 25 +++++++++++
 reftable/reftable-stack.h          |  5 +++
 reftable/stack.c                   | 48 ++++++++++++++++-----
 t/t7900-maintenance.sh             | 54 +++++++++++++++++-------
 t/unit-tests/u-reftable-stack.c    | 12 +++++-
 14 files changed, 256 insertions(+), 40 deletions(-)

Karthik Nayak (5):
      reftable/stack: return stack segments directly
      reftable/stack: add function to check if optimization is required
      refs: add a `optimize_required` field to `struct ref_storage_be`
      maintenance: add checking logic in `pack_refs_condition()`
      maintenance: add 'is-needed' subcommand



base-commit: edd2018f5db39d68d55a7a4af42375b1a06b9406
change-id: 20251021-562-add-sub-command-to-check-if-maintenance-is-needed-01cae01b4606

Thanks
- Karthik

