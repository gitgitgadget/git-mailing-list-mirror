Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E93DEAEF
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242379; cv=none; b=PLjAFTcdkC2lVDOZu7uUIQpEDl0GvudNlREhCYOuPDWxAn3RrDyYGSFMuH1fQRoBcRMlYmhYtuoD8yW4jTp5/kLGh50CrRwyVLFwP522UH+xFZFpg2ceRqw0xvj+FPkEL6NZvX45X9oy4aW2XyiNtzLuBR0pPh5lxIXZE0zvVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242379; c=relaxed/simple;
	bh=eWsxuZneaX0qT4iYSLAoA0Yx1FljWwzfm1HYnqzFxOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDeZ0e0xWoGbS/2vpDB/fCURp9FHPt+me6tF4bQb2N5mhGrGaY0GL4y2T6LXbvLdAlpDs33k+UryGR8c0xuyYKGYIq3qcNYGYkmxJonaIdN7VzYA2Ls1KvsBZXDQFubmHtyFPzXb9ytw2S4IejQ5pveW0lpvt9Fw5/fx3GUcS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiVqcEI6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiVqcEI6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so35237995e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773242377; x=1773847177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4jHyaNGuRlVIL0t5kbXraRZjiC3aPEbYhqFETLOrPA=;
        b=UiVqcEI6pgCFMntbnZCUiuAnFGvsnyhRzcny1N2J5k042r2BkOv+n830AsofA097aG
         QtMHC5tvDFfQauTS13xw4mpbJz1fF5mbbeBxAjn/X6C+M4Sne9COJEdcxMKtY+learkF
         4yQUZvSiesNK8VVlFopuUxoQqDaZDIQPPTMg2dSbG3J50Eq8j78HJ6kqc0DsaDWfgH96
         7u+hia9UjZfguBxuM8ZVjUpsq7CWu18JcuZ09CFtpAorYIPC4yD3iJvUM0wQy2gmFpBt
         Q11e1Esxw42bs7js69o9q0iPpFT/nr86h5sv471dpkRJsx1DkNCQ9pZi/8mgMgz643XL
         9AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242377; x=1773847177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4jHyaNGuRlVIL0t5kbXraRZjiC3aPEbYhqFETLOrPA=;
        b=gbjgBbb5rpCuFIazk9azDz86fLTIBcWlmHnzkQXWiccXbPezq+QikGm2PDcZMM54xA
         9qqi/MKdIDASsAkohTiOeeYDT2QBfCVJpsl/ZUjBX+lkHavwvDlRTSYFjiPccynV0Q9S
         F8L6Qorj5LSCqVYXIRVBxgnKnAEG/jQI56FJ8Od+knaI6Z+HuOUFXG7HtCKax4uKRnwx
         21oyuxcE2T6Z5gk7983/NVv4fPGy5fezfRPghCEXwUPIZoA6jA142cuB7rPyOUF/pPYO
         Za3hh05cu5ZKYxed2sk0nYBUp+8n9UV9SjmiUm58jH1SoOxI/bv/5bUjpBeuf9BR1XO5
         i8rw==
X-Gm-Message-State: AOJu0YyrartBTqTq7pwizNMreM/cfzLqxsiEdwqD2iPU7zStd0YQMsWq
	IdYHm6bhqn6ihqOJDBtYWjylcwY9FghAPwyK4WX3G/36cXfKqB4yFhFmQPAZ9hVH
X-Gm-Gg: ATEYQzytQhxDn7aEl6P9WC5HW7fVF3L8guVOGa1PnlySfogS03lYA6hFOH8lxHCtAUM
	oX/bAmLq4uZbDW9DN4FHq58YGtbb5F7OLJTbzyEv2cubBXmHri0n3GP9Wma6SRcbXwKPzs55E19
	2j2SaeG80TUYeYlIRR8QZ5cfdquiq3YyipDwF57kjbR3zX0x8WwUK8wekZqWyM2+tX3QiiSKxAn
	EZGXv6S8f6iK+4iR6cigCR4tDssA97/6RoKO3ZJ5f1RecI48Ao8h5BY24mEOXZrKSDqSJex5OMv
	BXt9y9vukqmBzjeuEt8ssE8ug8vL0KkK1jIRgttchTC1599B6v6Z/vU4AJnMjclai9P3e03J38A
	V8TvIY8CdbP1zCIbERrVilfFweVKrNWAgqbB5z5Vrp9plupyRqiMTutdU/JhZrptPrcNAdbJzmu
	1xLjl2F8I763FnoYY=
X-Received: by 2002:a05:600c:8b13:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-4854b100d98mr55013815e9.16.1773242376257;
        Wed, 11 Mar 2026 08:19:36 -0700 (PDT)
Received: from fedora ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm62743975e9.10.2026.03.11.08.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:19:35 -0700 (PDT)
From: =?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	l.s.r@web.de,
	ps@pks.im,
	=?UTF-8?q?Burak=20Kaan=20Kara=C3=A7ay?= <bkkaracay@gmail.com>
Subject: [PATCH 0/4] wean start_command() off the_repository
Date: Wed, 11 Mar 2026 18:19:19 +0300
Message-ID: <20260311151923.4178655-1-bkkaracay@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

start_command() relies on the_repository due to the 'close_object_store'
flag in 'struct child_process'. Introduce repo_start_command() to allow
working with arbitrary repositories. Turn start_command() into a macro
that wraps repo_start_command() and migrate the existing callers with a
cocci script.

For callers that cannot access 'the_repository' due to the lack of
USE_THE_REPOSITORY_VARIABLE, define the macro. If the caller already has
a local repository context, pass it explicitly instead of defining the
macro.

Thanks,
Burak Kaan Karaçay

Burak Kaan Karaçay (4):
  run-command: add repo_start_command()
  run-command: use repo_start_command() in strict callers
  run-command: redefine start_command() as a wrapper macro
  cocci: convert start_command() to repo_start_command()

 archive-tar.c                           |  2 +-
 branch.c                                |  2 +-
 builtin/credential-cache.c              |  4 +++-
 builtin/difftool.c                      |  4 ++--
 builtin/gc.c                            | 16 ++++++++--------
 builtin/help.c                          |  2 +-
 builtin/index-pack.c                    |  2 +-
 builtin/merge.c                         |  2 +-
 builtin/notes.c                         |  2 +-
 builtin/receive-pack.c                  |  6 +++---
 builtin/remote-ext.c                    |  4 +++-
 builtin/repack.c                        |  2 +-
 builtin/replace.c                       |  2 +-
 builtin/upload-archive.c                |  2 +-
 builtin/worktree.c                      |  2 +-
 bundle-uri.c                            |  2 +-
 bundle.c                                |  2 +-
 column.c                                |  3 ++-
 compat/mingw.c                          |  2 +-
 connect.c                               |  4 ++--
 connected.c                             |  2 +-
 contrib/coccinelle/the_repository.cocci |  3 +++
 convert.c                               |  2 +-
 credential.c                            |  3 ++-
 daemon.c                                |  6 +++---
 diff.c                                  |  2 +-
 editor.c                                |  2 +-
 fetch-pack.c                            |  4 ++--
 http-backend.c                          |  2 +-
 imap-send.c                             |  2 +-
 midx-write.c                            |  4 +++-
 odb.c                                   |  2 +-
 pager.c                                 |  2 +-
 parallel-checkout.c                     |  2 +-
 promisor-remote.c                       |  2 +-
 prompt.c                                |  3 ++-
 range-diff.c                            |  2 +-
 reachable.c                             |  2 +-
 remote-curl.c                           |  2 +-
 repack-cruft.c                          |  4 +++-
 repack-filtered.c                       |  4 +++-
 repack-midx.c                           |  4 +++-
 repack-promisor.c                       |  6 ++++--
 run-command.c                           | 12 ++++++------
 run-command.h                           |  6 ++++--
 send-pack.c                             |  4 ++--
 sub-process.c                           |  5 ++++-
 submodule.c                             | 12 ++++++------
 t/helper/test-run-command.c             |  6 ++++--
 transport-helper.c                      |  6 +++---
 upload-pack.c                           |  4 ++--
 51 files changed, 108 insertions(+), 81 deletions(-)

-- 
2.53.0

