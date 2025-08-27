Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AD27FD6D
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308469; cv=none; b=nqePyWQN6ETu6ybAL0LVPVCoxxKhq7zgHX1V+9+JYekNA0Hcu+vimUJ70EDEadVUZ+GUMD3xCW0XJzBJCYVmjEbLHLJf6zw5NxzfStMDkPAhnPOzOulo48RWVynynJNTKn/JIfi47bCd+VIP6CU0wS8huWHi0ZZz8x3Z2bT6zMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308469; c=relaxed/simple;
	bh=bgaDakFqIGu9lUx+OUt0/7vhOga4DNlpW30mrMf0QOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0DNNJyv+cLFrgeXefBDuoWsmM3X4mVaJwuWSA4OxkABgIwcq47pvefXVieLlZLKURzilg+2Xiy0yAF2/O06wHLQT8m8ulnJ8T0IXFOqOmu8vXXs+jOgVAGOjQqbujMC1efUlgLgzBUOep7YcUHtlO6RtMieXi4n7BgQ6Lc2lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7qMLydC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7qMLydC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso2548706f8f.0
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308465; x=1756913265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnrmFKNaj9DWB/KwR0BGQ/obkv0G7cu40DKB8PDhIuI=;
        b=d7qMLydCrr8KYh9Y9ay9gW28EPXJmuYZcS3fpjDMouf0IkDILCBl4ZehuIOpLBZeeN
         RlB4yR7KoX7Lp0LdRnlAkKtsrvqANbSV0JSjwVCp9Lyw8PZWZqiZkPttXBBcInz80Jyi
         GvIRdZBSyOC6ugB/TH6SltJ0U/LJ1kiEf+gdrvKDx3nNK+MRNSzadzlcxq9dSIAmIeG0
         8sHnLsnArgfYBCe5Q8bSYaV27mgJsm/2iIcuinNJy683+4a3I9oIG6T5znaTuxpKEXEk
         qHFGWpW+s/NYpusz/0FuGMUU2LafMgrhzMg9ZBfkiecDzC4QEHGgbPAiu6qr+scBgLCB
         hMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308465; x=1756913265;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnrmFKNaj9DWB/KwR0BGQ/obkv0G7cu40DKB8PDhIuI=;
        b=BleNu7doocBD9muwczdOmYS6NJBmlXnN40Z3AzDOWaTOeGInmF0PlfVsgLsZc8Gjg0
         +iGuZtY9D+GSvKUSFZW1CnVjjX21jz4875SyvPy8ZbR1ZJEkqdvyCUtvMqJv0ij80WY4
         hqtdsIsxhlG3J++z8jPQcp+uvEDLGV6I36pDKgDc5hrfYKACNTWqryD0Q/CMzGD90QDB
         aOpGBa1ZcSGn4FeiIu12lj5QtAnkhhEU4QKXH7dA/ft3ZKZ3a13ZQvqxsG+tTYvpQHOc
         ybTeNrumthq+FV2u1z3SGI7fb7XVQe0pJPcoDRouNLkrexmlT28BaXeq+uT9aa50ISHd
         hgfg==
X-Gm-Message-State: AOJu0Yx0F7JnMp24zQeAt8wHB+dXhRDmpPII5MIOSiLfawgpMuiTM+9U
	Wtje0SJWtLtI/3yFOtKAVzMCZe0Ccaw31YF5CoqlsVbvWJSpDaW+HHF6uKqkCA==
X-Gm-Gg: ASbGncu5LE9I9s6xB+zh1BsX9U5Ro1bdtxYac7SzhCetAvNdj7M1cVCWu5KmmE9kH2J
	XELiI9xfGr4dXUbDuDy5aiQljOlg3fqEfug1jBar5EtDTNfkAK4p613+302C8jiIGy2ouF+Cy0Y
	y4RpG89mM8RlnoOeEQNohrIABxTBi9Fitg8b6YoiALYtfuzZPtbe9K6ytOKnUFxwYgf3T1cwyOm
	N44Ecj5oq5OY2CcJqBiGBkOPZdH8AcuCxVB4fQv0a7r6mcc7ex7tu+3ferZg14DACUTeDvKWSni
	UPfVR7UcHtcz7RwGALMlNJNwVFHFD70RVnM8dLddO6GhrFqUGcUUOj3gD4VFNGopwBdES+vkRl9
	Ic46o1nUHxf0RD9HJyjuejGbHz9I0lkhQdVj1pwcwPPylGg==
X-Google-Smtp-Source: AGHT+IGKXuUXrDARSWUmOoRyAjYGb+3Fzct6h1Y/eY3Y5t4Y+ucJpbLG6EebLVQdOPi6v2V7ZHuICQ==
X-Received: by 2002:a05:6000:2408:b0:3ca:8b32:e43d with SMTP id ffacd0b85a97d-3ca8b32e8c6mr6467124f8f.1.1756308465280;
        Wed, 27 Aug 2025 08:27:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711211bd7sm21511597f8f.38.2025.08.27.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:27:44 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 0/3] breaking-changes: deprecate support for core.commentChar=auto
Date: Wed, 27 Aug 2025 16:27:27 +0100
Message-ID: <cover.1756308431.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series implements the plan to deprecate and remove support for
core.commentChar=auto outlined in [1]. This feature has been the
source of a couple of bug reports recently [2,3] and it is hard to
see how the design can be fixed as it is incompatible with preparing
a commit message template containing comments. When git sees the
deprecated config setting it will print advice based on the user's
config setting to help the user either remove the setting or set a
custom comment string. In the example below core.commentString is set
multiple times in $XDG_CONFIG_HOME/git/config and core.commentChar
is set in ~/.gitconfig and $XDG_CONFIG_HOME/git/config.

warning: Support for 'core.commentChar=auto' is deprecated and will be removed in Git 3.0
hint:
hint: To use the default comment string (#) please run
hint:
hint:     git config unset --file ~/.config/git/config --all core.commentString
hint:     git config unset --file ~/.config/git/config core.commentChar
hint:     git config unset --global core.commentChar
hint:
hint: To set a custom comment string please run
hint:
hint:     git config set --global core.commentChar <comment string>
hint:
hint: where '<comment string>' is the string you wish to use.

[1] https://lore.kernel.org/git/6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com
[2] https://lore.kernel.org/git/20250315140913.577404-1-oswald.buddenhagen@gmx.de
[3] https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com

Changes since V3:
 - Patch 2: Remove repeated word from commit message

Changes since V2:
 - Patch 1: Punctuation fixes
 - Patch 2: Reworded the commit message slightly
            Remove unnecessary include of advice.h
            Fix variable declaration
 - Patch 3: Include advice.h

Changes since V1:
 - Rebased onto a merge of 'ps/config-wo-the-repository' and 'master'
 - Reworded commit messages
 - What was patch 2 has been split into two separate patches and
   reworked to die when core.commentChar=auto and WITH_BREAKING_CHANGES
   is enabled.

Base-Commit: 1ae5bd276bdf101e37c1a8f2904a2eae05fbb744
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv4
View-Changes-At: https://github.com/phillipwood/git/compare/1ae5bd276...39d824db4
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v4


Phillip Wood (3):
  breaking-changes: deprecate support for core.commentString=auto
  config: warn on core.commentString=auto
  commit: print advice when core.commentString=auto

 Documentation/BreakingChanges.adoc |   5 +
 Documentation/config/core.adoc     |  20 +-
 builtin/commit.c                   |   7 +
 builtin/merge.c                    |   3 +
 builtin/rebase.c                   |   3 +
 builtin/revert.c                   |   7 +
 config.c                           | 297 ++++++++++++++++++++++++++++-
 environment.c                      |  11 +-
 environment.h                      |   3 +
 repository.c                       |   1 +
 repository.h                       |   3 +
 t/t3404-rebase-interactive.sh      |  19 +-
 t/t3418-rebase-continue.sh         |   2 +-
 t/t7502-commit-porcelain.sh        |  52 ++++-
 14 files changed, 421 insertions(+), 12 deletions(-)

Range-diff against v3:
1:  5b921064f1e = 1:  5b921064f1e breaking-changes: deprecate support for core.commentString=auto
2:  5dd897c95e6 ! 2:  e92511ce21c config: warn on core.commentString=auto
    @@ Commit message
     
         As support for this setting was deprecated in the last commit print a
         warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
    -    Avoid bombarding the user with warnings by only printing it (a) when
    -    running commands commands that call "git commit" and (b) only once
    -    per command. Some scaffolding is added to repo_read_config() to allow
    +    Avoid bombarding the user with warnings by only printing it (a)
    +    when running commands that call "git commit" and (b) only once per
    +    command. Some scaffolding is added to repo_read_config() to allow
         it to detect deprecated config settings and warn about them. As both
         "core.commentChar" and "core.commentString" set the comment character
         we record which one of them is used and tailor the warning message
3:  ee6cf11a82c = 3:  39d824db4ab commit: print advice when core.commentString=auto
-- 
2.49.0.897.gfad3eb7d210

