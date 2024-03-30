Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C022079
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838790; cv=none; b=fmT/+ZtE1uibfdf+1e8gJDmaby+/+k9OK6QHz6XiNIbukXVvDVqibRCaLpXkgOZKwDuqSmX7Bv4LvBNl93gUEDHybbRv7LhJgk5WWF4EB/UTy9jsOLr4EOc5ZGQm3XmubJmm3VhjaNLfPXxaxKBNNlpDL/5x80L+MCrxRl7DkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838790; c=relaxed/simple;
	bh=dV6rEEMbfhewYL+Qp3g38r4AQXwbqv4lXpVIjIfzEuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KPafYoB146kc8wGdDIbNl/bRo02KMclHSuhCfKlrsf5kT5rGISlTx5SVaXbzhCGI7AkjV3/ctMg2qVWTqobq5wMube4lypFSZjNjwpDKceVsOlooO0DiQudR+5IpA7jhj96IdVTsPTv/7tiEpPqVfBofoAFSdcXQTkleiaq/gVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxHUCi0K; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxHUCi0K"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4715991c32so363639066b.1
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838787; x=1712443587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx5VMatKpiVh7DJCB20s5ZWG28sk6Mh1w77RjhFMjsk=;
        b=hxHUCi0KweDbr/vnKE3g+afi38Lb9VhB+3wNsYLqqkyAYC0pyhWfoUWHoKZ9aE85Ve
         SoJZ+5uwZMNMcfqBiOp/f63jn18jADhkvZk797rqzHfE8u0DmgGrbHuqwNRXI+5f45NZ
         IX5cdieO/bXQSDkvBm0DSEC48vyc3KsQOYMurAYJCLvxVekVS4jqzgSumaE2UBSb4vgK
         W5ARo4LGqCvYSTRUanl9ytydZPUqB/V1mEKFVjA6vrKJZ9yyDWYq5dXACufF459j2MHf
         PTy4ghPteAoqG/NoVS0FqYhx93X+FNM9x+BSXnnBX2+o99b1bqZHbnyW4imvNiZyC8m8
         19YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838787; x=1712443587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx5VMatKpiVh7DJCB20s5ZWG28sk6Mh1w77RjhFMjsk=;
        b=JZnDFF3/MRNbMjmFP8Q3+nBTtmdgaOupZ5nw2nYZWI31yfkN5mipU8UAOYRhFB0uHn
         x7QPKgvC+F5Ys9IVn+vLUuEdaZs+gsrHznaA5heHQrTXeT/1uAG4LcdE51JG6tGLMUnz
         yscZxTPuWqjJnjc/YMN9/U7sqSKKoEWLMVMwr5kY2hZG935lmeMrttrkGqGQZQ2U3EZQ
         29RN/PlTDeMGh3wECdkfDBAw3rnlrYIdJgu8QITKcKINJzRLpWer1hBxSMVofHku8bLY
         qSptwpyk5CCC5W0p4Yepa+UfK/br0xeNSkH/S6W+ENA102JxCWUGMabVufuoJQUqDiwh
         M2wA==
X-Gm-Message-State: AOJu0Yzg2xUGQY+RVwmCemJgY9Y5OFs4FBaSmnbz9QCCCfKTXMYPKO9J
	whFmGFhidInCV+5teDFRo0/u2bq+iV6Iu6K6c53ckKDnGxG7MQUOfpP+P5YTHCI=
X-Google-Smtp-Source: AGHT+IFfyHkJxFj7YGBxut9CGxI9OLHs8gEMAvEQsj+RA+Uflkf0KmRyFZ2OieJ3NC2kf+f2A+VKVw==
X-Received: by 2002:a17:907:9874:b0:a46:7323:6ab3 with SMTP id ko20-20020a170907987400b00a4673236ab3mr3500130ejc.49.1711838786821;
        Sat, 30 Mar 2024 15:46:26 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/8] update-ref: add support for update-symref option
Date: Sat, 30 Mar 2024 23:46:15 +0100
Message-ID: <20240330224623.579457-1-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'git-update-ref(1)' command allows transactional reference updates.
But currently only supports regular reference updates. Meaning, if one
wants to update HEAD (symbolic ref) in a transaction, there is no tool
to do so.

One option to obtain transactional updates for the HEAD ref is to
manually create the HEAD.lock file and commit. This is intrusive, where
the user needs to mimic internal git behavior. Also, this only works
when using the files backend.

At GitLab, we've been using the manual process till date, to allow users
to set and change their default branch. But with the introduction of
reftables as a reference backend, this becomes a necessity to be solved
within git.

This patch series goes about introducing 'update-symref' command for
'git-update-ref(1)'. This command allows the user to create symref in a
transaction similar to the 'update' command of 'git-update-ref(1)'. This
command also works well with the existing 'no-deref' option.

We don't create a dedicated 'create-symref' since 'update-symref' can
also create symrefs. We don't create 'delete-symref', since the 'delete'
command can also delete symrefs.

Karthik Nayak (8):
  files-backend: extract out `create_symref_lock`
  reftable-backend: extract out `write_symref_with_log`
  reftable-backend: move `write_symref_with_log` up
  refs: accept symref in `ref_transaction_add_update`
  refs/files-backend: add support for symref updates
  refs/reftable-backend: add support for symref updates
  refs: add 'update-symref' command to 'update-ref'
  refs: support symrefs in 'reference-transaction' hook

 Documentation/git-update-ref.txt |  11 ++-
 Documentation/githooks.txt       |  13 ++-
 branch.c                         |   2 +-
 builtin/fast-import.c            |   6 +-
 builtin/fetch.c                  |   2 +-
 builtin/receive-pack.c           |   2 +-
 builtin/replace.c                |   2 +-
 builtin/tag.c                    |   2 +-
 builtin/update-ref.c             |  63 +++++++++++---
 refs.c                           |  37 ++++++---
 refs.h                           |   9 +-
 refs/files-backend.c             |  95 ++++++++++++++++-----
 refs/refs-internal.h             |  12 ++-
 refs/reftable-backend.c          | 136 ++++++++++++++++++-------------
 sequencer.c                      |   6 +-
 t/t0600-reffiles-backend.sh      |  30 +++++++
 t/t1400-update-ref.sh            | 127 +++++++++++++++++++++++++++++
 t/t1416-ref-transaction-hooks.sh |  27 ++++++
 walker.c                         |   2 +-
 19 files changed, 464 insertions(+), 120 deletions(-)

-- 
2.43.GIT

