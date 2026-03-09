Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD09237180
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017692; cv=pass; b=GENd68rc19Gr37MCgtt0JF6vm8BV2R7kFKgmp7riCcoZoDbFJYgo7BZtMeSxo5xBNZE1aulafFJ3cc720c9aArlAiOqtdhjh1gyEKyFMNRcb8bJTkvIJrJERu2/SBQk8rEvVlydPidtOvxmCR4i7/Mv3aDIcMT14IAeZJrdA+Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017692; c=relaxed/simple;
	bh=fialMFnt7bRrIM64VN5D6TcnSvO2bb/ILeZD8aYLG40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t34857/Wj4BhlNDVaOFsDzRVbd/exgs0x/4VjW+E0oE2p7+M4dYiQs4cmlTQPDL1C6lCxHHDSw37q/NAquzVF1KnaYU/WvTgel/D+kBrjEZCS3Oa83mZlPW+gBx/ZPRCzUIMQAbEyCOiM9NIM32dCBHnAxHBI4QBrGrfg2bAZhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=U1XFJ743; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="U1XFJ743"
ARC-Seal: i=1; a=rsa-sha256; t=1773017677; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TxEk7AGJULBo19bstmnIgMjVen0sW9ed9ajbyURVEZSgy69cxEvUbRnmiT9ddFaUE/kphR9ekMQvu3YagxC2QT8ueqAbSG6Wyi0yXail0H7n1OJo+3bCgy22MjGwh+juLvHKECRJLmUEYa3/lVwujIOGMWkhf1Vu9PaSbi1WDaU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017677; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2zhlBkpY3yo2yOn2ej2tARO2jjU0LZDzX/4k/IwnpnU=; 
	b=E3ytFcp5u0aXVlsGXZArhGP0WihvgS147Bez6lLUjaxlQOtxHVJzC7PsJ0B1oUkouNoUlLgM8bU7SU+/dPurmquGw9/JDKffp91YHviShEhxp/LwOZNB26+F5RVtykdFQ7WmCrSRm5T+NBKkJtIc+ugS+F3ab4gaT9Ph9kMSwv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017677;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2zhlBkpY3yo2yOn2ej2tARO2jjU0LZDzX/4k/IwnpnU=;
	b=U1XFJ743uaRg3zhCw53RQj+9lVjOntGWYJ3uJlkIBMW6w7xgPHR0FAW5xKEyQNY9
	lPYkTU8I/4yGGf72gSSXDiz9VxCL1TdWqq4l1ZGF0DXtY1Lu/gfF5QX39jJ+wtWKVMq
	3aURYv7kpBqHsso3JQdjo/khfMD+sxN2aUFf+mHE=
Received: by mx.zohomail.com with SMTPS id 1773017675753647.9355458890271;
	Sun, 8 Mar 2026 17:54:35 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 00/10] config-hook cleanups and two small 'git hook list' features
Date: Mon,  9 Mar 2026 02:54:06 +0200
Message-ID: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

As promised I've spun-off v3 of the config series [1] into its own standalone
patch series after v2 landed in next.

This is mostly minor cleanups and refactorings + two minor feature additions
to `git hook list`, which resulted from the previous review discussions:

1. The ability to show the config scope (--show-scope).
2. The ability to show which hooks are disabled.

This is based on next because the config hooks support is only in next.

I have pushed the branch to Github [2] and provided a clean CI run [3].

Big thank-you's to all who contributed to this up to now,
Adrian

1: https://lore.kernel.org/git/20260204165126.1548805-1-adrian.ratiu@collabora.com/T/#mafc63b5b32a78e48a703cccca3b7d6d9fe668fa2
2: https://github.com/10ne1/git/tree/dev/aratiu/config-cleanups-v1
3: https://github.com/10ne1/git/actions/runs/22833022192

Adrian Ratiu (10):
  hook: move unsorted_string_list_remove() to string-list.[ch]
  hook: fix minor style issues
  hook: rename cb_data_free/alloc -> hook_data_free/alloc
  hook: detect & emit two more bugs
  hook: replace hook_list_clear() -> string_list_clear_func()
  hook: make consistent use of friendly-name in docs
  t1800: add test to verify hook execution ordering
  hook: refactor hook_config_cache from strmap to named struct
  hook: show config scope in git hook list
  hook: show disabled hooks in "git hook list"

 Documentation/config/hook.adoc |  30 ++---
 Documentation/git-hook.adoc    |  15 ++-
 builtin/hook.c                 |  28 +++--
 builtin/receive-pack.c         |  11 +-
 hook.c                         | 220 +++++++++++++++++++++------------
 hook.h                         |  39 ++++--
 refs.c                         |   3 +-
 repository.h                   |   3 +-
 string-list.c                  |   9 ++
 string-list.h                  |   8 ++
 t/t1800-hook.sh                |  83 ++++++++++++-
 transport.c                    |   3 +-
 12 files changed, 321 insertions(+), 131 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

