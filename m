Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA71431E73
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383669; cv=none; b=YpzCp6ktQCxlvBTX0wTVqsLZnzwSje+TFuocKy/O21RsQ/7KiWQPktwn7JKRz0/BS99QzkxHaTuIA6aMR1Wz8V99lqO7GbZf3vO2MRLStAyMLqJBzwwmyGqBHl4YhQQPlieuYMZsHxZLds0fWOEeuqWtwpxjKvSWAKjaP4RVHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383669; c=relaxed/simple;
	bh=LlqoZAKJHtbUJqY3aboQkIEnrZlYtibc3GYzzAKJh6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXhOXraFEx/CHhuv7UHnX7HYa8hKHqkzKq20Q/tdbAUs2ZX1I9JqPnzomF3e+i1RjMbAR3Ui2e9UYIoLIO5Tx8BXh0m89PZXVbiekaR9emiXADPDr0pPvJN1atrOYKMt/ufNjXeAmrWRGeHstYh+1he+vEqVgxJzwbauoF0iup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMPcp4Dc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMPcp4Dc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so13539a12.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383667; x=1786988467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dkevkXmZJ5IF3FzrYSkH2V0Y1oRIUHSLYva6JVXoEyA=;
        b=QMPcp4DcQzCpFx0vBA3spJKlK/DgYDFzMD/5UuSNO6HmKmwzxIj4dPx1qEBDbGWLT2
         7ttfBwNn3/XuLLB0PxQOR9tLzyVrXMEvJHUwxP/62GyIKq6jehWnH/8jb2G8zh8HPt02
         9eZPc6xTBK7mRqjNOsxeKPuML6wpiniffLU1HBQq14cxFSd7QoJnUKmpMqYFyRHRaVww
         xf7J99ohdTGnM5d5FbFInXCMWZ3+J8bBY/LUsvtbQqyZOmaTF6xJoqVcPLiqxx3kuK68
         V88ehL/hCIasUEBC4M4jYnXUG9p0SPDxLPLtrMNzH/vRxoR6w0DzpaVhSpx0c2+Zwxaj
         Oilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383667; x=1786988467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dkevkXmZJ5IF3FzrYSkH2V0Y1oRIUHSLYva6JVXoEyA=;
        b=C7QSLfGzPl2tWJL0zP35YcEqfiJvwIZtWF/rLKGz0h1G4FU6QkJnbsjHctmQ9GlFEw
         ZELLJfo8bx4C1HRb/V/qY6fmFS0askzMrYOlAjaNEJfSIXSCScjPd281f4N1xp+/n6Eb
         y4/+g6sSbbYLt7dPhM8956brLuKXv13t3Pg8zLvcQPC9VLW5fkKWprostHPW4cHfT/Vf
         qD5+rJ7NIk1E41Ib8fVzsLjXSkbM4h/g/UFQUgaGJlsC6TX3frocqt1rXUEaM8NvT57M
         r6Rqv6U+C0go/LC+WXd6mnyWvxuWBMQOSE5htl9VIZyqEWQIpReHxdCOmXwM+0IKGRk3
         giTA==
X-Gm-Message-State: AOJu0YysOyMGoaXOs2N+3XBHtAVTsv3MscffzJL7gbAND9yCRBjN9p2f
	Njsic9fsgWr+UCSTxUwU8pdNBbSTgKC36mZRsDqg05SPiPHvT0YOvvVCPwUA5Bna
X-Gm-Gg: AR+sD120yrbiYeQ0c2dPw2j0pML1Mh1Z/bQ9M7Eql+gdpMg1ppty6dAss0ULhJRTmfp
	Rm5MhrohxElU6XPNYgDspq2iOkpK3LTVBu0vN229KnwVs2/vf8jyIcWjnYOYgsv+kRtepoilGDj
	xtCw2x7IRySx67CfjMf3KFbH4+HIGYakbdojyXZK3tAszuobBzLyTF8+ScGtBjTmJopfrJ4MIUU
	D/wwjEHcafO1T0CTBlTf8hxj0hL78ku4d6JoqGC9w8pKIZp+4c+avfOGCK3tWjA3CjszCtMIIWy
	tFcyL8qY+3kdgzOc6+IuGIY4gLXtYtcOmj44K67JaC1LEOky6YbLR+E0pUGw3wj8tjpfwaEBnVw
	LBD36ce7AhuTWVWTje5uCvfzZyGyz1hqs+hETyXYnGGILY8Rv6a6qOk3OafZyAjXagppjFZ1JuZ
	bQduWbuYWD+e7DCjz47KTVpsBPSt1YRcK7mcjQHQr6Ro7VqH430+33QmDEUuZyf0LaCjd7KWx2w
	gCdUksI4B3GuToGAQn04WdVrssITOxXGI+0o/OA2jLnSS38EhOQ/uYlEKBkWiC8G2DPtK2c00zV
	itYX5W867LKWd+4yLgWBhA==
X-Received: by 2002:a05:6a20:6a03:b0:3cb:82de:b952 with SMTP id adf61e73a8af0-3cb85de816cmr40354383637.2.1786383666835;
        Mon, 10 Aug 2026 10:41:06 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5026:8db8:20aa:c615:9a47:206a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7b39bsm36865585c88.14.2026.08.10.10.41.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 10:41:06 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v4 0/7] repack: add --drop-filtered to reclaim space in partial clones
Date: Mon, 10 Aug 2026 23:10:40 +0530
Message-ID: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4. v3 was at [1].

Partial clones let you work with large repositories without downloading
every blob up front. Missing blobs are lazily fetched from the promisor
remote on demand. Over time these accumulate locally and there is
currently no safe, built-in way to reclaim that space short of
re-cloning. This series adds that reverse direction: enumerate promisor
blobs over a size threshold, drop them locally, and rely on the existing
lazy-fetch machinery to bring them back transparently when needed.

How it works:
  * Enumerate promisor objects directly (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)
    and select the blobs exceeding the filter threshold. Every enumerated
    object is a promisor object, so it is recoverable from the promisor
    remote as long as the remote still has it, the same assumption the
    rest of partial clone relies on.
  * Rebuild the promisor pack without the selected blobs, reusing the
    existing repack machinery, so the drop is crash-safe (write, fsync,
    install, then delete the old pack).
  * --dry-run lists the candidates and changes nothing.

The guards refuse to run while a merge, rebase, am, cherry-pick, revert,
or bisect is in progress, and refuse to drop a blob referenced by the
current index. Dropped objects stay recoverable via lazy fetch, so these
are a convenience (avoid pointless re-fetch and a surprising
mid-operation fetch) rather than a correctness measure. Both are skipped
for bare repositories.

Changes since v3:
  * fixed the git repack -h usage string to include --drop-filtered and
    --dry-run, so it matches the SYNOPSIS in the documentation (t0450
    was failing - caught by Junio)
  * converted a bare grep in the test to test_grep (test-lint error -
    caught by Junio)
  * removed a stray bracket in the documentation SYNOPSIS

To do:
  * remote verification: verifying against the remote awaits the
    "remote-object-info" cat-file protocol command
  * recency: a "don't cull recently-fetched objects" rule as another
    selection criterion alongside size
  * drop log: introduce with the error-path change that reads it

[1] https://lore.kernel.org/git/20260806112202.75067-1-r.siddharth.shrimali@gmail.com/

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
 builtin/repack.c                | 151 +++++++++++++++++++++++++-
 list-objects-filter.c           |  45 ++++++++
 list-objects-filter.h           |  16 +++
 repack-filtered.c               |  82 ++++++++++++++
 repack-promisor.c               |  15 ++-
 repack.h                        |   8 +-
 t/meson.build                   |   1 +
 t/t7706-repack-drop-filtered.sh | 185 ++++++++++++++++++++++++++++++++
 9 files changed, 533 insertions(+), 7 deletions(-)
 create mode 100755 t/t7706-repack-drop-filtered.sh

-- 
2.54.0

