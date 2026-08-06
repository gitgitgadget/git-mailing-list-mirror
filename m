Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38534D384
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015339; cv=none; b=pjcFRFIYdWz0lX/ZQ0knCyKsGV6GcaNMeI+IYGLVr6KtD+ttBbnMbLJsWdG+8sYWJl7pb7LsKVM4HiQ4BgxMP0N8JOl6wRYdYYaCzi4gCkMIuv4ypnmZlHnIilW7Sg1rh9Yd8JtHQYp8ba23BFrAYFG0FSDV1f71YSLxClN3UlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015339; c=relaxed/simple;
	bh=vx4Wmu9aXdBarl9dXWZfMSfYHDwcxE2k+tlNWPXIq7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWt+lqC2shxeP7AzK9l8V93liKW5B1/MfYZFpb3ZoznER5LR6gc/l+4MqGEK9FEQ8N+m6pzdBl5K6V6WzwXQlscMioZYDZbThZ9S7LUcMJdptzEfK68BrzMvbBCMflcMSx1hoG5F9ywT3pwV01ZIQXdCETg8eBZO2SfpBQvlRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYjomiKA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYjomiKA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2493118a91.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015337; x=1786620137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dzeh4Z8oClDSi7XoZSRQOxbP0Ru5NJJBj7Hbxn4eh0U=;
        b=IYjomiKAz8yKUIvUgv71zbY9eoAYP0stF7oqtts8Bf3o8lc1M2PQ7I4XqvcXj/hzLJ
         JSMsiAgdNf7njawwat3ww6R8eSmPnEtfTwvjoFenAyppIdqJ7qjWricI6yU6/UnRDoMI
         RfJ+R8OfwYt+Gp8eeXm3q6qVsVVBL2BDCNu1pIbW6rwyMyWQQ1e+t+dz8wIAdYrq5DNp
         Ozz369uP4G1erp917bbxBsKrw8dEVED8oUGj/7dlbG279rVfvEI6+ikEgoZ85gS9m3En
         kDcYe6qXJZHS+dcTYKp3j7B6gT+TXrj7Oay26RJpxmCB4tJvXdOPFBBFW8W/iyORSBka
         E8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015337; x=1786620137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dzeh4Z8oClDSi7XoZSRQOxbP0Ru5NJJBj7Hbxn4eh0U=;
        b=H4Y4U7kZE8ULMuHXZ83zsBgh556Jv2vD36jMwAEcYG+aI8fKlGMYA5zak0kVZ5I5SZ
         xPOaCbu1zix32GmMDW3H51ApPu1EeQrnJpPrvdaDRbMypI2DYnTgcRDcUJlkDjSkQIqk
         9GnMC2dTWTh0UP3i0vrF4ezFyWKU2KKPIiygqzm8r023yq7mvZlNEC8jcQfxlYJHDFr8
         ULQtzjcaD/T1n5Y/JsrxtIEVgl+FxstoipFDVL6XN23eYMbswHg+wlBaoQqst9zOBmDr
         njpiFMgWxAX3+0mh7IkNZ1Gh4i/LauSpaAoKef3z2yzxdl6eBtW+N+5VHr3kv5Jhsu+8
         jr4A==
X-Gm-Message-State: AOJu0YyisJbPlfp/vCEnC92+YN/b7NxZufRLlt+lnmrkWrY6RMnxe24/
	HKoBUESYUirFHIGQiV9UX2e/lxdOe3EmR7ex9y5sWjNx7yQ++fWx8pvQELH5+ML9
X-Gm-Gg: AR+sD10r5HewKPCPT3c+fJGDGequ7GHewWHkqpMfijOJAZbj0Jqq5KibPf+ocYtvnTW
	ygkslctTwK4vTfIU+/RhQYcWIy4KjUU/MFcsCYNc0Eo48drl5LUXORfhWvq05vguqe3Kn5LLR52
	I6DUfXQnWXh75nFRhTYcOh3E8A7FPrsyipF0zl1T9vNuIbS5+cccrAHhWfaObbnXkAUBSnVcbN7
	b/JNFQ38rKUrSVTr8aKNqmtgOj5ZkoItySmwkK8mVB66EuAzG3/j2BpliSEyx5BpHQZe+/bLHgO
	ha5almy4MO4V4e/juXX6rzSGlGR64Zp/KgfsS4ADwx0IVBBCyGqmgS1Urp+ebHbUflMnkd+NSdE
	2wujUcZyPNJEFSOlJ/aGeztmzf1CbDI4AZnuZNMP/vK8AvhDqerbN4Tf/4St+p0GZ1L30/FIwx9
	S+BXbJAKvn4jQ6sDrZTy5i+wfYhCJ4gOGrSLvqyc+g+tTcNlsvJv1X+2J+8grvxMsbk9YqJsqNN
	hsIAB0TEiGCJZspMp+e+Ft+I2aXrivNghQTPcObNpg1+ZCmtAfHnBgsdniKRjInZRGTryKtxUMe
	LUJYnGel/stk
X-Received: by 2002:a17:90a:ec8e:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-3903c56ae7amr16332659a91.9.1786015336914;
        Thu, 06 Aug 2026 04:22:16 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:16 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 0/7] repack: add --drop-filtered to reclaim space in partial clones
Date: Thu,  6 Aug 2026 16:51:55 +0530
Message-ID: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the series adding "git repack --drop-filtered" to reclaim
disk space in partial clones by dropping large, locally-held promisor
blobs that remain recoverable from the promisor remote. v2 was at [1].

Partial clones let you work with large repositories without downloading
every blob up front. Missing blobs are lazily fetched from the promisor
remote on demand. over time these accumulate locally and there is
currently no safe, built-in way to reclaim that space short of
re-cloning. This series adds that reverse direction: enumerate promisor
blobs over a size threshold, drop them locally, and rely on the existing
lazy-fetch machinery to bring them back transparently when needed.

How it works:
  * enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
    and select the blobs exceeding the filter threshold. Every enumerated
    object is a promisor object, so it is recoverable from the promisor
    remote as long as the remote still has it, the same assumption the
    rest of partial clone relies on
  * rebuild the promisor pack without the selected blobs, reusing the
    existing repack machinery, so the drop is crash-safe (write, fsync,
    install, then delete the old pack)
  * --dry-run lists the candidates and changes nothing

the guards refuse to run while a merge, rebase, am, cherry-pick, revert,
or bisect is in progress, and refuse to drop a blob referenced by the
current index (it would only be lazily re-fetched by the next worktree
command). Dropped objects stay recoverable via lazy fetch, so these are
a convenience (avoid pointless re-fetch and a surprising mid-operation
fetch) rather than a correctness measure. Both are skipped for bare
repositories

Changes since v2:
  * bitmap config: detect an explicit -b/--write-bitmap-index
    with an option callback instead of a before/after snapshot, so an
    explicit -b is always reported as a conflict, even when
    repack.writeBitmaps is already true in config
  * softened "guaranteed recoverable" to "recoverable as long as the
    remote still has it"
  * reframed the guards in the commit message and docs as a convenience
    rather than a safety measure

To do:
  * Remote verification: verifying against the remote awaits the "remote-object-info"
    cat-file protocol command
  * Recency: a "don't cull recently-fetched objects" rule as another
    selection criterion alongside size
  * Drop log: introduce with the error-path change that reads it.

[1] https://lore.kernel.org/git/20260730174153.9949-1-r.siddharth.shrimali@gmail.com/

Siddharth Shrimali (7):
  builtin/repack.c: add --drop-filtered and --dry-run options
  list-objects-filter: add list_objects_filter__filter_oidset()
  repack-promisor: allow excluding objects from the rebuilt promisor
    pack
  builtin/repack: enumerate promisor blobs for --drop-filtered
  builtin/repack: actually drop filtered promisor blobs
  builtin/repack: add guards for --drop-filtered
  Documentation/git-repack: document --drop-filtered and --dry-run

 Documentation/git-repack.adoc   |  37 +++++++
 builtin/repack.c                | 148 ++++++++++++++++++++++++-
 list-objects-filter.c           |  45 ++++++++
 list-objects-filter.h           |  16 +++
 repack-filtered.c               |  82 ++++++++++++++
 repack-promisor.c               |  15 ++-
 repack.h                        |   8 +-
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 185 ++++++++++++++++++++++++++++++++
 9 files changed, 531 insertions(+), 6 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

-- 
2.54.0

