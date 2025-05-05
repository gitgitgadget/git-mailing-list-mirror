Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49A2DC789
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436724; cv=none; b=FMK86l34S4TjEw+WtujtLgTrAdzAp8f1TaNDX+fFpbesa24sA6Q0rMQZ/OHSB0ldcoH0nJNogtpXDmmyTLZ0xq2An7LGgw6IPdv4gfgnD2h3+dzYhepQpps8z5gyxBFflG3JCylTKa8MV9yRLHUUjEJfc1uUXQdgPfbNV9PgErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436724; c=relaxed/simple;
	bh=QhZB551z+a0s8NTYIhZj5lIkMaj9JP9OedbtUuiiDxo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=U087N6PhgtMnOw4VLKY30v3dqWP7EYYAUuosoUVJhqwQv9EQGdmZPdDuqkWYHa2+FjuEGjpwy+5naXkmwjxYa8ZagI+gAZf28yViFQaIubvstFJ3XA0W0xI648HBY0DkZsxO9DSHIsJlYbq5S9WH7jHNZHzfNW3hvtxYP0XXPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8wbphbg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8wbphbg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf680d351so26363705e9.0
        for <git@vger.kernel.org>; Mon, 05 May 2025 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436721; x=1747041521; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YRpHxng/O2KyGUwn25ceTfGmqKNN9W5xpNzHMfuK+WQ=;
        b=k8wbphbg9IEJqE/GdnUEkLYoE+eWUfiY19e+Iyk9Pon2dxM1KAcnY4YWvnJxOTmCEU
         vxFJGKN1gE658vgD7at4Ap1afI5Ku9qrEVqMQiNvbXNsi8XpP2zotU1Uy1F6RPOZtMjg
         VLC3fa8MGaI0bA6EIQWqwUGb6n7WhIWYHJSO9jZLeqPTHhl1CFPZmB9yo9LjVji1bEPp
         BVfKC9HP9rKQoaBGTw9Y9T9nlOidbRTouBedUd10DRCrD9oEop31BgyleqNNpysIXSeU
         thL5I8nrtBKLS4JyxW5+rhGL80LAda93IxHUo8YlaToXOjubpyqm5JOQXw1F+6Ze84LY
         Yjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436721; x=1747041521;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRpHxng/O2KyGUwn25ceTfGmqKNN9W5xpNzHMfuK+WQ=;
        b=XStaz5Z0deJHk8FOn0gTMP2nu34gEYwL3nTySX6E3rqIagOS48jvALfi1izunvprc5
         KxhvlJsVHBS4lgtCWO0BeJecgv4czY5x/Mc/Ys/oTdFc+TqUNXWUvdrzR27056AvLuEC
         gQz3dqvnFUku3ny0QUhDae4FonR7s8Cwdnm7xd3tuiAaHzh/PXvT+TwdwNPefUNVV6zr
         T9CYIyunhHvEq3N4nJ9/lCnyyykiVV4dCBxWlK3He9silTaI2YdG1HmcO9r4hA8tHPCq
         Mzz9qC03/WHd9mi02cHI1/KKlqVPYVkMJaGG3eIQJAQNVM9Hx+3fvFrVJVLg9hrfCyPY
         Haaw==
X-Gm-Message-State: AOJu0Yz2uGm+ON4CFru20TEZLwdA9WN3Ct5ycj5ydps8mybMfjskSND+
	peOZtrEaRTEqRkvILwdS/Pnl2LVzmoDCB1wmai2hPpdKqCu9XWPbXVA7yA==
X-Gm-Gg: ASbGncsbSl+OQDom6SqWLxuaGf+LDusuRZxUKk1Er4xg8P6fGwcGVzrETTGLDeFJG5l
	JgIWNjeO7LkApQOZ5Y58rtSJ+79V7zXG6aMfQSt5PO3D+jPH2UA4ScUetzP9foWsAwe00WFZlmQ
	jmnUF359RwssblCX5ANHkWWzFNHFSTLFCQUdR+lvDUkojva/IbcnNZNJjEHrvlsTy2rNAMVSJzz
	kK0YZpAsN1SX75JJHKuyN9VdMR6U4Ea0Gs2qm62g5Yker6Gp8n6YtchjbnKA5LkbO0EiO7Ykj6E
	ScjAMSDX+8HUUUVb6cZE8vfqokustQ8KEAkKkL7QOw==
X-Google-Smtp-Source: AGHT+IFlZM7tFXqcdZ2KfMP+1FUP9aAP/o39T5w2H5KY/ljTWjlTv3r4VnjePy2j3Y5Rv+Zs/H6JXw==
X-Received: by 2002:a05:600c:c19:b0:439:9737:675b with SMTP id 5b1f17b1804b1-441bb856784mr89411365e9.7.1746436720655;
        Mon, 05 May 2025 02:18:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc480sm129687165e9.2.2025.05.05.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:18:40 -0700 (PDT)
Message-Id: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 09:18:36 +0000
Subject: [PATCH 0/3] Better support for customising context lines in --patch commands
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Leon Michalak <leonmichalak6@gmail.com>

This series of patches attempt to give --interactive/--patch compatible
builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
better support and nicer experience for configuring how many context lines
are shown in diffs through a variety of ways.

Prior to these patches, the user could not choose how many context lines
they saw in --patch commands (apart from one workaround by using
GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
persistent solution). Additionally, the behaviour around reading from the
diff.context and diff.interHunkContext configs was also inconsistent with
other diff generating commands such as "log -p".

The summarised changes below hopefully make this experience better and fix
some inconsistencies:

 * diff.context and diff.interHunkContext configs are now respected by
   --patch compatible commands
 * --unified and --inter-hunk-context command line options have been added
   to --patch compatible commands (which take prescendence over file
   configs)
 * "add" and "commit" in --interactive mode now expose a new "context"
   subcommand which configures the amount of context lines you wish to see
   in subsequent diffs generated from other subcommands such as "patch" or
   "diff"

The original discussion for this can be read at:

 * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/

Leon Michalak (3):
  add-patch: respect diff.context configuration
  add-patch: add diff.context command line overrides
  add-interactive: add new "context" subcommand

 Documentation/git-add.adoc      |  21 ++++++-
 Documentation/git-checkout.adoc |  11 ++++
 Documentation/git-commit.adoc   |  11 ++++
 Documentation/git-reset.adoc    |  11 ++++
 Documentation/git-restore.adoc  |  11 ++++
 Documentation/git-stash.adoc    |  11 ++++
 add-interactive.c               | 107 +++++++++++++++++++++++++++++---
 add-interactive.h               |  17 ++++-
 add-patch.c                     |  11 +++-
 builtin/add.c                   |  21 +++++--
 builtin/checkout.c              |  28 ++++++++-
 builtin/commit.c                |  15 ++++-
 builtin/reset.c                 |  16 ++++-
 builtin/stash.c                 |  54 ++++++++++++----
 commit.h                        |   3 +-
 t/t3701-add-interactive.sh      |  36 +++++++++--
 t/t4055-diff-context.sh         |  78 ++++++++++++++++++++++-
 t/t9902-completion.sh           |   2 +
 18 files changed, 420 insertions(+), 44 deletions(-)


base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1915
-- 
gitgitgadget
