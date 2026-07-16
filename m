Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D4423EBB
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208551; cv=none; b=uPrjxZ+5+Ak4tU48A/DMXhn/Dpf+ahZc4/C1T9GxiC/OD2WeMdpX4wKyEUGUEO86iJgdMAkv9D0EoUvGhI+PoL6/+Ntv26q+0dmER69OUYPvKuox0mTOB6a0L5UfVFC/l+wUOWJx6vEp90ydDxhvzD1P1ulZfj18EDi4QVnfxAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208551; c=relaxed/simple;
	bh=lNqW2PsWHh2IMqJPykR+xyjPW1Fo6zdrLQEr7Pif2uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk5w/A4ig4OcBHqs94SBWodr6gUOGGlFLtl4vITbHB2V1YM3ScHbMniPUPeEGB3HVDYuYWN1D9MDBAG4ZcB2XQIHij38WXixPzzT4XiHiZqehwcNEJchABNXpQ2dPtWvnYcJA5v7h6esMLpZj7cMnBt7AkNSfGNLCihrTHSCsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoe4XTGz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoe4XTGz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381216921aaso6731158a91.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208549; x=1784813349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+GcMWAu7nDKWeKOlpsYHNaNIvxdreCi47KuCYpPMFTY=;
        b=Hoe4XTGzzf7jOa7949cqLYlSG03uyheqHLUcTyeZN+qWnhC4JtuI06qe4+MkTW2JsP
         ngJ+33ccC3ocfabfAJz2gGcut4lFmrJ8+MuvbLCBzTpntGGx56c7AZuLV+vBZh430GSY
         qpB0/muXCNxkFH4tDd1KrG74gRD/A2/K4Qm7kYgTVx9YNH4JgU2u2ygcohCx0UkH7N2g
         nATVt6Tamg5j8vAjunLlTG/NjStLbQSGq3d7DBvTFBvAA9iTy8qfxhAXClkzcDwBZB6C
         1EwXDs+bhIpMTPpO7OfiDdTDW1+NbC6MCfkFxxzahM27YexcOw6vK/6If96TYusEP/40
         VaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208549; x=1784813349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+GcMWAu7nDKWeKOlpsYHNaNIvxdreCi47KuCYpPMFTY=;
        b=Vd0VM9yzCu8itUnfqm8xDvORKi4XhTSdncpV3gipy2vUgLsqZOCoEo/U7haM7iWoRl
         e20TVOQ4p0V6E7y673/9Es9YpXZUgkkeQnGKkPGLbAmAAjufH1XAoHOFTWDcVql3Uz7h
         zjnF2OJOTTZcm34pQgxHGVwHUFabghjGMl8yuQG5SmjuJlHKExndxVa4STPy4CPdeiB7
         bb/gFFGVkCKFqsynKQ5Y7nwYi039dbZt8vdZtpqw6JB+0rqpoOXPzfEdRv6a15NNOzd+
         4wUo4DOvge36s2p1+QfCM1InzF2vFsFugm9rwhOvi+Gp+T7oBOMwrnY7jeistTF2NfQE
         fkXg==
X-Gm-Message-State: AOJu0Yw8puNdg9m+VMy+3BvclcbH/9IwpI2EybJ1T6GMPXURbeFQuWf6
	h0NjzSr/tA0uHFeXreqVPwFSeO0MvemNd3OvnhM+W8yvPSR2vRoLsHolqc3mAwkG
X-Gm-Gg: AfdE7cnjKf72lt4/la0nDxv3N8+9C9fX9nLNv9Ij8YVSOT5zLS8Meg82wQh5LUk8c2Y
	aGxdAX+dhM/BBz4kPdovF4kIkOowZF1n+GUjZuOQ9IZKXBhNibMoK5/yQ66rO5Lrv1Jz1Fo0CHi
	+KmFaH3+FsFRGSKaDxOHfWZEXmg7mqHjmPfIKeXXIdZpD28Vc5qKHt93aMfZX40QohMYoAaxt05
	en+6zm4/Cf4QCBImHailVy057O5wRUapIrOq4yeiaahRGfInmvQ7tWEihBnBFp1+3/NIVCEgAEA
	xBONU4CoKTKQTN0OBqosL8lgJgE2DtGj77B4xlmF86j5wFj4aWORBaV/2hTwsKvGx5waF3VbzKL
	aKrdgfU4oY+RydAg9IM5xJX197WOTQylhYOss8Z9S+tjyelf4/tA1vzYiN5YUc7FamEt1TgMFNr
	MeAy7HowPl1zgYGJsvugsubmGWAN7JVXEoDFKKz36xfjujOdJ4gCwwM1OIG+10KmLOsmHLVfGXD
	XkVeAAfPXhFys3HUSWZ/f9hKCFX6w5Zc/f32YSItsSP
X-Received: by 2002:a17:90b:58a3:b0:38e:2e16:859b with SMTP id 98e67ed59e1d1-38e2e1688fbmr3319380a91.20.1784208548891;
        Thu, 16 Jul 2026 06:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:08 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 0/7] repack: add --drop-filtered to reclaim space in partial clones
Date: Thu, 16 Jul 2026 18:58:41 +0530
Message-ID: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC series seeking feedback on the design and approach.
Several pieces are still missing (noted below) and the commit
organization needs cleanup.

Partial clones let you work with large repositories without downloading
every blob up front and the missing blobs are lazily fetched from the promisor
remote on demand. Over time, though, these lazily-fetched blobs
accumulate locally and there is currently no safe, built-in way to
reclaim that disk space instead of re-cloning.

This series adds a "git repack --drop-filtered --filter=<spec>" command
that removes large, locally-held promisor blobs that are recoverable
from the promisor remote. The dropped blobs become absent locally but
remain lazily re-fetchable, making the partial-clone still reversible.

How it works:
  * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
    and select the blobs exceeding the filter threshold. Because every
    enumerated object is a promisor object, it is guaranteed recoverable and
    locally-created objects are never candidates.

  * Rebuild the promisor pack without the selected blobs, reusing the
    existing repack machinery, so the drop is crash-safe.

  * Record each dropped object in a drop log
    ($GIT_DIR/objects/info/promisor-dropped) so a later change can
    explain a failed lazy fetch (when it was dropped, which filter
    matched, which remotes) instead of a bare "could not fetch" error.

  * --dry-run lists the candidates and changes nothing.

Planned follow-ups:
  * Safety guards: refuse to run while a merge/rebase/cherry-pick is in
    progress, and refuse to drop blobs referenced by the current index.

  * Authoritative remote verification: the drop log currently lists all
    configured promisor remotes rather than the exact remote each object
    is recoverable from, because there is no client-side way to query a
    remote for object availability yet. A "remote-object-info" command
    is being added to the "git cat-file --batch" protocol for this. Once
    available, the exact remote can be recorded.

Known issues to address in v2:
  * There is churn between "enumerate promisor blobs" and "actually drop
    filtered promisor blobs". The former introduces
    enumerate_promisor_blobs() with an interim signature that the latter
    rewrites. These will be reorganized so the function is introduced
    in its final form.

  * The tests are in a standalone commit. They will instead be
    distributed into the commits that introduce the behavior they test.

Siddharth Shrimali (7):
  builtin/repack.c: add --drop-filtered and --dry-run options
  list-objects-filter: add list_objects_filter__filter_oidset()
  repack-promisor: allow excluding objects from the rebuilt promisor
    pack
  builtin/repack: enumerate promisor blobs for --drop-filtered
  t7706: test --drop-filtered enumeration and validation
  builtin/repack: actually drop filtered promisor blobs
  repack-promisor: record dropped objects in a drop log

 builtin/repack.c                |  76 ++++++++++++++++-
 list-objects-filter.c           |  45 ++++++++++
 list-objects-filter.h           |  16 ++++
 repack-filtered.c               |  81 ++++++++++++++++++
 repack-promisor.c               | 106 ++++++++++++++++++++++-
 repack.h                        |  12 ++-
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 145 ++++++++++++++++++++++++++++++++
 8 files changed, 478 insertions(+), 4 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

-- 
2.54.0

