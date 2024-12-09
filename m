Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C9021B8F0
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742446; cv=none; b=TUIf9h5Diy7+K3vSceTr40G9X6q6KW97tSSk59O86k7jroxQ/nz9Hvxrbtafrz0BaObfeNRA1Y4wY1HkiK1eEKkV4cQyj/0UO6qhyB9eLw5SO4py6EsteHQBqsgGnGTQBBLTAnHfbum1Dgnwx59Oj+CbywcCghwIeXB+69yIYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742446; c=relaxed/simple;
	bh=qW2Svi9KBt4pVw5YRGvSjx9iIuZePOW+jhRvfn8qIJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YGeN4mPIUEHhYhCyMQUSW1YW75pQ1WEdL21oc8JgUMpAASsGX7jsKsMarREzCuxa5VnP42vEowN2pt0gG1PXFYbt1MWUQg2xGMi8bvfMdVhNf6uvCwA1nPgO6gCE6GMr98L87lVK4jCTVukgG3yL5MbpzUTRsEpJ7REfLy7Mink=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKQMXWAQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKQMXWAQ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a68480164so565674866b.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 03:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733742443; x=1734347243; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITmROnKzg0GndfLWW3AguzrtnANKJWz5umXr4NrEGTA=;
        b=TKQMXWAQ/F95w+2gW6z/UVhCE8vDl4DmftODGR+OdpM0DutuAiC1GlcTDbo6HwVmbb
         bidHYMt4Rhj0tojGsHUO2EshOvOOX47x2sJWE9yoUBSDj+yrcz7EaIlXdjGQgszpN3uj
         UU1GGMT80xxWulE5rEe0qMOHoKTzyFHaYOndEZ9QZAnfNBdLtJ9+GMsxMFsfFGZ2PWBJ
         g37LlUwV5y8zRfd76Q0aOnaKGs7A/ix7tHZU+pR35rVHuNq5R+LE15Ach426BUZL9wn8
         37jNswmFILF+b8PsBN8d9Ag+/oCasI5HRkOQs/nzYDJl4V4LV3/ho7ISJ8+TMv0F7Dlu
         UvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742443; x=1734347243;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITmROnKzg0GndfLWW3AguzrtnANKJWz5umXr4NrEGTA=;
        b=QklK1M1Dwjxhmu97RFrGtFr0wfiGw5/dvqIJo9FY5vZfy5F++/vCD+RQK8kTFNmTAa
         BTFOW0eNpZjL6lWzpjufmp7lRHOWESXm4q5hk9rLfXdtVUgAk6nyWIfIRL3XfaYr5v+a
         o3YLGo6yyowrNHvmOvIMhYMWh5z8XZcxsYMVYosir3qtYojdH+Lsrzu3P/UmK27d6Xn2
         sRDatggd9yyOhsRIXaxqyasN8DygTPrYPMLKerjso07qYTBp2hJUT6gOsw2vG1Zr6FbT
         xZwF6LvS3tsekIz0ek/WP4msky4sO6v1tqdDZzthAwDuoYKk/jvt+tHGim3ami1VQCOe
         e0wQ==
X-Gm-Message-State: AOJu0YxybZSpZU2y8NGwlKvzv37D21BFI2A8RplTk4OzQZvu6trJNpPD
	VvmsSBwJi/UHL8iMqx/c5EmY4EIaPecNJi8V6iDEXL/vnItPkUQ10TxdGC3s
X-Gm-Gg: ASbGnctm7b20/wVszhJULc+jxivJGCOid/xol1LoNm+4HyoOTgAY5BXUbEUli4GSjPB
	Vy1okQRZWg3ivNY6OUvm7OLhE+HvKMGnRoYpn3JZjyEjmbhGJzYX1oHH6q7crhG1uZTGxSxOkKc
	6F0PU09BEiEpnJ4Go3/xlT6oQ8vc9vL7Wuoipf/iH0fiB2SeURgsmFjufM0SyFCZCWvRXAK8DU6
	WgN+uuZyYaS016ve01knzhlq0jwbpP3prj2A7nZXkP1kE9z5rIDHPuH2Qq0WEY=
X-Google-Smtp-Source: AGHT+IEnuRfg6CS1Qw16e4ot8kjL1vVY3+kvP7/lS4ubE62rjkALW6X4mEkfbvSGhSOkFAlcMS/igA==
X-Received: by 2002:a17:906:2932:b0:aa6:89b9:e9c0 with SMTP id a640c23a62f3a-aa689b9fd00mr227335466b.8.1733742442511;
        Mon, 09 Dec 2024 03:07:22 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:8256:2d00:9c39:c2d7:aedd:294d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa672d377fbsm257013366b.75.2024.12.09.03.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:07:22 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/7] refs: add reflog support to `git refs migrate`
Date: Mon, 09 Dec 2024 12:07:14 +0100
Message-Id: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGLPVmcC/x3MSwqAMAxF0a1Ixga0VUG3Ig5KTWvAH42IIO7d6
 JsdHtwbhBKTQJfdkOhk4W1VlHkGfnJrJORRDaYwValDawqMfGCiILhwTO6gD/MWBV1tybrGh+B
 b0MSuB19/vh+e5wXeFWJNbgAAAA==
X-Change-ID: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qW2Svi9KBt4pVw5YRGvSjx9iIuZePOW+jhRvfn8qIJU=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnVs9mLuPqGqMV5z/y3G/2NOch3Ys6/tiuFaYEm
 Pog/dmWKXeJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ1bPZgAKCRA+1Z8kjkaM
 f5rhC/kBbF2+tU3cPRNv9N8oDjlK9DZkJS62auDV+DE9UD4W9x7HJCuTQ5DYA40VUtVozPuj5q7
 RsGGmkirKakHEy5QMuwp5ZSlGsPh5JxTe6zug3ab8KyPQ7XTQ8261NxO+XGEjb9SuYeA7+vGdEE
 8o2qwX90Ch7fXOZH13GrRW3FkAgJwErRccFaFYhab9O1clBZxJImdP1l1Hq2jqGb7imqUvnUiXw
 inj9Nq3lgsRc3jAtyeUMWp6VmfOPo+PMlMrBvHttN4KyPsWj9ZjAMn1BJifbku6C8TOS5wUipfv
 iZX60sDW4PKu7gMwkW/ukrD29Ejsog/541QVWvFidz6zl9Ugnm/OnN4RIcgV8MiJp+JO3hcjs6J
 kC2byPfrfHmEPXTzw3K5F9uJeGOvFJFuZ09IDn1rmg6uYvAzxd2Ji4mY2sJTyFI9/hI/7qbfO/S
 c92brb5meCdM/jOf/qexClJhDZl/yqhJ5X4oLhEgAnGkwOfYmQCWn1b8au1wHEpOUVEVE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs migrate` command was introduced in
25a0023f28 (builtin/refs: new command to migrate ref storage formats,
2024-06-06) to support migrating from one reference backend to another.

One limitation of the feature was that it didn't support migrating
repositories which contained reflogs. This isn't a requirement on the
server side as repositories are stored as bare repositories (which do
not contain any reflogs). Clients however generally use reflogs and
until now couldn't use the `git refs migrate` command to migrate their
repositories to the new reftable format.

One of the issues for adding reflog support is that the ref transactions
don't support reflogs additions:
  1. While there is REF_LOG_ONLY flag, there is no function to utilize
  the flag and add reflogs.
  2. reference backends generally sort the updates by the refname. This
  wouldn't work for reflogs which need to ensure that they maintain the
  order of creation.
  3. In the files backend, reflog entries are added by obtaining locks
  on the refs themselves. This means each update in the transaction, will
  obtain a ref_lock. This paradigm fails to accompany the fact that there
  could be multiple reflog updates for a refname in a single transaction.
  4. The backends check for duplicate entries, which doesn't make sense
  in the context of adding multiple reflogs for a given refname.

We overcome these issue we make the following changes:
  - Update the ref_update structure to also include the committer
  information. Using this, we can add a new function which only adds
  reflog updates to the transaction.
  - Add an index field to the ref_update structure, this will help order
  updates in pre-defined order, this fixes #2.
  - While the ideal fix for #3 would be to actually introduce reflog
  locks, this wouldn't be possible without breaking backward
  compatibility. So we add a count field to the existing ref_lock. With
  this, multiple reflog updates can share a single ref_lock.

Overall, this series is a bit more involved, and I would appreciate it
if it receives a bit more scrutiny.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Karthik Nayak (7):
      refs: include committer info in `ref_update` struct
      refs: add `index` field to `struct ref_udpate`
      refs/files: add count field to ref_lock
      refs: extract out refname verification in transactions
      refs: introduce the `ref_transaction_update_reflog` function
      refs: allow multiple reflog entries for the same refname
      refs: add support for migrating reflogs

 Documentation/git-refs.txt |   2 -
 refs.c                     | 204 ++++++++++++++++++++++++++++++++-------------
 refs.h                     |  12 +++
 refs/files-backend.c       | 144 ++++++++++++++++++++------------
 refs/refs-internal.h       |  24 ++++--
 refs/reftable-backend.c    |  47 +++++++++--
 t/t1460-refs-migrate.sh    |  73 +++++++++++-----
 7 files changed, 360 insertions(+), 146 deletions(-)
---



--- 

base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241111-320-git-refs-migrate-reflogs-a53e3a6cffc9

Thanks
- Karthik

