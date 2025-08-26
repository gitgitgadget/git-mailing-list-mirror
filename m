Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0C13FD86
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215353; cv=none; b=Hkr6HmrYEBHkDC6qEm4d0sAtQd5xIyvY+CcIyNglWXq0jeW4TD48p9swLlr3kSKSTmKRnk+KGDz2+Z3bAzgWDfPemVySzv7dK5mIrIIkIk0P3Xed9QV39z7OhNQlnOqVvn9eXrjZHh7Wm/zLRxZyKh3gkfyMdGdon5slOsSvWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215353; c=relaxed/simple;
	bh=0ZVWcPjjZJPOYf4EIM3+I7ZccmnMX1yYId4NGwhfIpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aymP/v7bDCB0fpQLPaTsAcX5aLS5n8Egc53ABinc2cZmHmio2rC5BBuuVSaeWgVnWF0Ob4XM/p9ZYiOxu12rHt4SSL8nZ8MwG2Y7Pu8YaeuUiXcvJp9SuirxmnnTFiaTNoNkEgfS44DRw9JkOaw6/5SSYaf3lj1IDK0mPRQWURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAMmYngg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAMmYngg"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso2753508f8f.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215348; x=1756820148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+WuuiwXdVwjuZyYvtcokfs623Vpup9jv7o85An8Sk/M=;
        b=MAMmYnggrWFk55uJjUljHaEC+WGYXlRclrlnUMctlJyesfaAlSnRNBPSAacgqhx4Uv
         2gZswsppKE6gjlLnIBQ8PUPZM50cf9GoedyNux1bg6NHLuxhOwoJDIg0+0GUa3qWtA1Q
         pQbwY3VPRYKyOYjSe1j8N6h99ShskHOl0qzB9uiUsiKJppXVmkSBxKR2d6+XZGCd9FIK
         rQvWjKWYvpBitzYGqHe/+IINs7beYKWDvE8zHJJOAfLCTH/3Vz9dCzWowLSqXERrAauj
         xEpYQBz+zYAS4+3EbaAYeuiclnJ9LsujanQi0U62m9Qunx065Rd+WILtj9m2VKqo1Z9B
         9KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215348; x=1756820148;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WuuiwXdVwjuZyYvtcokfs623Vpup9jv7o85An8Sk/M=;
        b=schshYrYD1HhODKLb/tUsfkGf8wWi6yCm9u8lWKbktNmRJhsUqTG1zj5bKYWuw3Ozi
         eZeDGys9mG+ilWqrEVJqovvBkqghlKrXLJ2xkpAqU7aAkTNaZVSjvMhka8Xe203xqrWB
         mEw+fFNmVbcZ6z9gs/BC6BmhjgBTYXvsJQSeMiuT/2zPCvHUb53CeQdGR5nB3EDKjtdE
         J/dZjP2+P9EWNK/duXj2W4Jmmqx7EmuGWf2OrQbvK6oTE3xWnQWgaeFpeeoMO8w2ZplF
         nQhe22ZwCxjocWffaK4reTlHDFJdbqU3Jng7iUM1I7iLMWhLzGgJfhp2/12KZdIEJaYX
         DPRg==
X-Gm-Message-State: AOJu0Yz6GICCuAG3islBqY1VNR5FkuzoRTLouajBJbumE1cetSMhC1Qw
	tmLahMvd33NVptd75BEtBhDBDmPv8o556x+xxE4DRRmj3CG2QnDfMlm9on1Bmg==
X-Gm-Gg: ASbGncuQs9Vj18yAmlfrB+ENa6b0END392c/WzSRzDNzmfDvSiCZCtKNADhXxIMRNsw
	PfgF4RclRM6eTKW6TdvV27m3XoZHLvbrJv08Yx5f6n0f2G2Twtsx4mMd6wpapnECy4R5EexFCKu
	cuCoXO3KVAX6IsJkPOLStHbsCwNNsp3ypt15rSTAuuIfvM/cm/6y86JKdSBdmmi/lBcDZCAudNz
	mbmsTt7nIiVd295PQq9Ts+eXJY9kMMlqyuMMAzSH24cNSrMNj/A5E9GZcM4+2Ml0bXrGHa+FoNc
	W348ENVjKx/NqkAgpPQdjyoCZaWiWutP1Jx4bqYuaEbDsianI7fEP+yt4oj0MtvegN0CtyoJwv0
	epL2dDAGKTqjbR5cBFFuB+64ptOkED32ixK9huC/pDwrAAmqNAjCPW42w
X-Google-Smtp-Source: AGHT+IGjbFkUIFdJaU7N/lGG39pC0P1ATtnykzuV/xBvin0LheN4pircLLOC9yvtQSX2jpwYVw2TwQ==
X-Received: by 2002:a05:6000:238a:b0:3b7:940e:6520 with SMTP id ffacd0b85a97d-3c5daefc7ccmr12113410f8f.18.1756215348071;
        Tue, 26 Aug 2025 06:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70eb7eed5sm15837863f8f.18.2025.08.26.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:35:47 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 0/3] breaking-changes: deprecate support for core.commentChar=auto
Date: Tue, 26 Aug 2025 14:35:25 +0100
Message-ID: <cover.1756215326.git.phillip.wood@dunelm.org.uk>
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

Thanks to Junio and Oswald for their comments on V2.
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
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/1ae5bd276...ee6cf11a8
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v3


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

Range-diff against v2:
1:  a6355451d4b ! 1:  5b921064f1e breaking-changes: deprecate support for core.commentString=auto
    @@ Commit message
         automatically select the comment character ensuring that it is not the
         first character on any of the lines in the commit message. This was
         introduced by commit 84c9dc2c5a2 (commit: allow core.commentChar=auto
    -    for character auto selection, 2014-05-17) The motivation seems to be
    +    for character auto selection, 2014-05-17). The motivation seems to be
         to avoid commenting out lines from the existing message when amending
         a commit that was created with a message from a file.
     
    @@ Commit message
         consequence of the design of this feature and are therefore hard to
         fix.
     
    -    As the costs of this feature outweigh the benefits deprecate it and
    +    As the costs of this feature outweigh the benefits, deprecate it and
         remove it in Git 3.0. If someone comes up with some patches that fix
         all the issues in a maintainable way then I'd be happy to see this
         change reverted.
2:  8b575980426 ! 2:  5dd897c95e6 config: warn on core.commentString=auto
    @@ Commit message
     
         As support for this setting was deprecated in the last commit print a
         warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
    -    When printing a warning avoid bombarding the user by only printing it
    -    when running commands commands that run "git commit" and only only
    -    once per command. Some scaffolding is added to repo_read_config()
    -    to allow it to detect deprecated config settings and warn about
    -    them. As both "core.commentChar" and "core.commentString" set the
    -    comment character we record which one of them is used and tailor the
    -    warning message appropriately.
    +    Avoid bombarding the user with warnings by only printing it (a) when
    +    running commands commands that call "git commit" and (b) only once
    +    per command. Some scaffolding is added to repo_read_config() to allow
    +    it to detect deprecated config settings and warn about them. As both
    +    "core.commentChar" and "core.commentString" set the comment character
    +    we record which one of them is used and tailor the warning message
    +    appropriately.
     
         Note the odd combination of die_message() followed by die(NULL)
         is to allow the next commit to insert a call to advise() in the middle.
    @@ builtin/revert.c: struct repository *repo UNUSED)
     
      ## config.c ##
     @@
    - 
    - #include "git-compat-util.h"
    - #include "abspath.h"
    -+#include "advice.h"
      #include "date.h"
      #include "branch.h"
      #include "config.h"
    @@ config.c: int git_configset_get_pathname(struct config_set *set, const char *key
     +
     +#define COMMENT_CHAR_CFG_INIT { 0 }
     +
    -+static const char* comment_key_name(unsigned id)
    ++static const char *comment_key_name(unsigned id)
     +{
     +	static const char *name[] = {
     +		"core.commentChar",
3:  0e7c08b15e5 ! 3:  ee6cf11a82c commit: print advice when core.commentString=auto
    @@ Commit message
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## config.c ##
    +@@
    + 
    + #include "git-compat-util.h"
    + #include "abspath.h"
    ++#include "advice.h"
    + #include "date.h"
    + #include "branch.h"
    + #include "config.h"
     @@ config.c: int git_configset_get_pathname(struct config_set *set, const char *key, char **d
      struct comment_char_config {
      	unsigned last_key_id;
    @@ config.c: int git_configset_get_pathname(struct config_set *set, const char *key
     +	return (value & COMMENT_KEY_MASK(id)) >> COMMENT_KEY_SHIFT(id);
     +}
      
    - static const char* comment_key_name(unsigned id)
    + static const char *comment_key_name(unsigned id)
      {
    -@@ config.c: static const char* comment_key_name(unsigned id)
    +@@ config.c: static const char *comment_key_name(unsigned id)
      }
      
      static void comment_char_callback(const char *key, const char *value,
-- 
2.49.0.897.gfad3eb7d210

