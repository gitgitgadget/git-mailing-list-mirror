Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168F25E475
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739214942; cv=none; b=n+++IiTakg1fbTBioJXon/x8dmkZSrzxbzEuoESNYnBMBdUqYopz6oaqkpNYY0tIJlYpztzCj2tsikLbiKVHzY45JEgzdNfXYmI8wV9rTgjnlPoBQLTnjLJU1H3A4ckyxRJBJZ3TuWUyoT7TCZYvL31smSS/shWPAMy5lUXehY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739214942; c=relaxed/simple;
	bh=xDSTmM4Vt1UV1XXTFw/anDNhnqLw5s1JH8wo+TqJNLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCFkgXN9FuogF7PqZ7mvseFPlNIpi2bIv5QPQCYrQBKuSLWB159ax+cAYOaWrgRBBTMUlxcU15o1enTTqlswdJRWg8x8pEAm8IsQtaa3UYKpu/l04n88TpzDCdvuzT7sXjUo4pegccuSFM4nXIW1nAHHow4nk2BYDN5hW+8DJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=W3wXr7Gb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="W3wXr7Gb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43624b2d453so55826165e9.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 11:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739214938; x=1739819738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LygBYa8WXRVu7WUqeAnGGa1u3+XpEoesNs0bplYdDO8=;
        b=W3wXr7Gbp5AdjSz0flqEkT7+dkZ5CrlkDoUvTWYwtrPUSJSeHeRGvzfTs+0+74WL/L
         EGV6eLgAVd3KWHEU17N41JDSEchg+AKkryqeo5QHkpD0xUpEayT+hNrkb1B8v5Nz4AsR
         wuII76PFIiyI6j6VR3T1XvxV4qxv1IrAMz+L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739214938; x=1739819738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LygBYa8WXRVu7WUqeAnGGa1u3+XpEoesNs0bplYdDO8=;
        b=KuFYA0VcJ0Fz/o/1h1zyJgfqUtMYC3ekCfDpEttoPYlgVFpdD5tgjKOGT5ssK2POSx
         NbxT/56e459wjr4xOnpexwFH6xYjO/oAWBM1cL8etvBM/bROUR23peBW6NmQvnLltmm4
         53mmv/TgqB/WTsedsvbhsrlfvV5Z6d17GOGN330rFudNYXdP0Ggl+uCl1iIpu7zrO+S5
         05yGzViiWQpbpT59fEwfLJV298ZWxl0UROzRROT2WzSGH4xjn+00RC3LiKPY13M+BF4x
         ui/oCJX+4k+rd5yysDf8iIe1bMSaxcY8aBDLiVpCPtblcU5Gy7LsAcZ206nCKPQRjwiq
         wyyg==
X-Gm-Message-State: AOJu0YwSEO7U6kuFGVkIv4fh5KuzwaYvzR+izBBwEvoyAiq9ORCcSSHg
	tNwdX27RwLTIrLdtLSPJkz7zF5tAsUrC6/FfnhshKLnPBPbOj6iZaGpgz14Py8rmE2LOoUmQ6Qm
	SMr+Tzw==
X-Gm-Gg: ASbGncurU5gyTgQMV5rPtnFnzTtHSs6I+yZNDh9PkcmAa/tvkyFzMrlBEtshQhbg8DD
	rMXmV71qLWHAt9NEmR/0PwSB1WBxTNI5Ov+D2OXO22SNMpriXnkIMjiHJ1J3UxoIF81zwQLJ6+J
	lAncPtngNZWwEXU1u8PLVgEgMJrT5LlaCZp5JSnYJ5fl4SAmoLMbOgY9MiyqgOkAcmBtyvWkRU1
	n2t/NYkPG4sC04QXKL/PjfO/EAnbZMWSFoFCLy/s+pHoPBk9F2bLQ4zBzsf/nDbelJyQZzESRdM
	1V7l027JgNDW5YXDPI85MPvUEWFdQG4mpA==
X-Google-Smtp-Source: AGHT+IFe5ds1mQ7Zw0r+iy1h65nY1sdEcg/ZLXVP+TogYVJ+9hrgDC7X4mbdnKhjNX60gvyF37XWRw==
X-Received: by 2002:a05:600c:6995:b0:439:45ce:15da with SMTP id 5b1f17b1804b1-43945ce18a8mr35358065e9.25.1739214937638;
        Mon, 10 Feb 2025 11:15:37 -0800 (PST)
Received: from able.tailbefcf.ts.net ([91.151.136.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43946bff4d4sm30477055e9.3.2025.02.10.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:15:37 -0800 (PST)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: git@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] clean: add `config.exclude` and `--remove-excluded`
Date: Mon, 10 Feb 2025 23:14:36 +0400
Message-ID: <20250210191504.309661-1-intelfx@intelfx.name>
X-Mailer: git-send-email 2.48.1.5.g9188e14f140
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends the concept of "excluded files" in `git clean` to
make it useful to protect "precious files" that might be present in a
specific developer's working tree (see below).

Specifically, this series adds a `config.exclude` knob to configure
"always excluded" files (same as `-e` on the command line), and a
`--remove-excluded` flag (intentionally without a short form) to
"REALLY remove everything, dammit!"

This might seem like euphemism treadmill, but there is a specific
use-case for all of the exclusion methods and options:

.gitignore:     files that _the project_ does not want to track or touch
                (build artifacts)
clean.exclude:  files that _the user_ does not want to track or touch
                (IDE configuration)
git clean -x:   remove build artifacts, but keep precious files
                (when a pristine build is desired)
git clean -x --remove-excluded:
                remove everything, including precious files
                (e.g. for redistribution)

For instance, if I use Sublime Text or JetBrains IDEs to work on
projects, I might want to add this to my ~/.gitconfig:

[clean]
  exclude = /*.sublime-*
  exclude = /.idea

Or, if I make use of the Bear compiler wrapper to generate the
compilation database in those projects that do not use any of the
modern build-systems to automate such generation, I might write:

[clean]
  exclude = /compile_commands.json

This way, even if I run `git clean -fxd` to test a clean build, I do
not need to worry about accidentally removing the compilation database
that would take a bunch of CPU-time to regenerate.

Ivan Shapovalov (3):
  clean, dir: add and use new helper `add_patterns_from_string_list()`
  clean: rename `ignored` -> `remove_ignored`
  clean: add `config.exclude` and `--remove-excluded`

 Documentation/config/clean.txt | 11 +++++++++++
 Documentation/git-clean.txt    | 22 +++++++++++++++-------
 builtin/clean.c                | 32 +++++++++++++++++++++-----------
 dir.c                          | 15 +++++++++++++++
 dir.h                          |  4 ++++
 5 files changed, 66 insertions(+), 18 deletions(-)

-- 
2.48.1.5.g9188e14f140

