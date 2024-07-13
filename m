Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD713C838
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904911; cv=none; b=gIKC+cR6ytbO+exWixP+LSr3R6X5VzAPfMbVRNaCLazK4iT7OQ9Ed1vBocR70gBIv2O0y8u3u50qQvlj0231l82WjM5nPpwpxSH8UHkqeKvdpSW79pz96aVhs/34hcX1gGWxPbMUJMH3O76PWvj5Lj4r/2XEalYOjDawegOCFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904911; c=relaxed/simple;
	bh=vJ6ISFRjIDG2Qzadlh7gj3FcqnekMDYhN3SV9SLvUew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rlDQ5y7hOcE2B1g2ztNKss8ADb6jjGGL0n9T4V5tsYOQ84jQWQIUWQuagRjaXfVsjlHm76PDY2Eo971ZRmZ3lXFljNZ2MWDTsZ+6Akea6MsWZ7fPPeiF9KgFEQGvrG7matIJBNUfXwP9Qa2gcssZzWH/r6uFcHaeUpZdlP6elWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtdwSEBB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtdwSEBB"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so20496155e9.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904907; x=1721509707; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Z0T/SXqW87F2Q7HKgIpVz/Gv3lNAEXKYNfiIHI2gw=;
        b=AtdwSEBBMhvQLmIqIHBJeGu1aVnbjtds9UJj7BSP7A0I9/N1HakCu3OggD0+ZV7lvs
         u/TlF/CjbgE5PC/QCL8nKYkkM+7Be/B0QMTPHEVGA2meQLia8X2TLHamjloWEaxLeZ8m
         /Snte8tV2w1pGcIYIsTRcwV1ZSVSOc3gids3V7LQX+w3+O6WcPQu+e1TOhRH9jTulqTM
         I8E51+VCy13nrlLG+1fih7mnLPPFZUSbrAPbI/hnX8hxCnH82+MTjHhidAkCCy0y36yd
         2rTOpRzu/Ns5mYdaYWtuBuD5HV7l/t21uQXAe7Aqg0xzyLGMQIfEm7m8L8eHCLZ1ymi8
         xhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904907; x=1721509707;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Z0T/SXqW87F2Q7HKgIpVz/Gv3lNAEXKYNfiIHI2gw=;
        b=WczO3CSo84V2T7YpIrLzOHmuyFUB8J5U4vXPDgjLOivON4/NKwCGt8f38ecleUXVdZ
         BXJ1WhxyNT72QBnP/RvzPkMhbI+hYeNf+UpFB/MRFPdt5FALorGn4IQ2NY5HdINo0CQu
         dnyqGpSNqfSkm7vPlVBD/TxBUaC49E0/1qZTIA9RUVn25zlYVptG2OaXKDcPMyp4UlR7
         26y5I96cXjwEpnZjrSvDcqZfecJxiNyBMisdXfUKp0zCsoFqAulJrR22ZZdhbBCTyghv
         RyaknREZJfBl5Ay987juGGyOFn4g2imUY7UdFipAs+8ay5DnDleAMG+Fxup7wSXDIvZa
         gTtQ==
X-Gm-Message-State: AOJu0YwVHlTRV7yt3SiQ7en5C4f/d8iIOJR9WXclia7IL+TWb2yBO8jz
	cUU1sobEwQt0DDhdyTm21c2Si1uKEJtJRKnAhQow9YG3X5/MVhxuB1vpCQ==
X-Google-Smtp-Source: AGHT+IGk9MOOtlCKAhHZ+24fq7Ij0wsUq7yU+wOgR+WjW8SLU1aUxOhafDfxIagOMDrlgE7V7I4zHQ==
X-Received: by 2002:a05:600c:4c15:b0:425:7796:8e2c with SMTP id 5b1f17b1804b1-426707d8b58mr107630925e9.12.1720904906970;
        Sat, 13 Jul 2024 14:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2d73bdsm68128335e9.43.2024.07.13.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:26 -0700 (PDT)
Message-Id: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:17 +0000
Subject: [PATCH v3 0/7] var(win32): do report the GIT_SHELL_PATH that is actually used
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Changes since v2:

 * Now fspathncmp() is overridden on Windows just like fspathcmp().
 * The win32_fspath*cmp() functions now respect core.ignoreCase.

Changes since v1:

 * This patch series now shares the logic that determines the path of the
   Unix shell that Git uses between prepare_shell_cmd() and git var
   GIT_SHELL_PATH.

Johannes Schindelin (7):
  run-command: refactor getting the Unix shell path into its own
    function
  strvec: declare the `strvec_push_nodup()` function globally
  win32: override `fspathcmp()` with a directory separator-aware version
  mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
  run-command(win32): resolve the path to the Unix shell early
  run-command: declare the `git_shell_path()` function globally
  var(win32): do report the GIT_SHELL_PATH that is actually used

 builtin/var.c             |  3 ++-
 compat/mingw.c            |  2 +-
 compat/win32/path-utils.c | 37 +++++++++++++++++++++++++++++++++++++
 compat/win32/path-utils.h |  4 ++++
 dir.c                     |  4 ++--
 dir.h                     |  4 ++--
 git-compat-util.h         |  8 ++++++++
 run-command.c             | 17 ++++++++++++-----
 run-command.h             |  5 +++++
 strvec.c                  |  2 +-
 strvec.h                  |  3 +++
 t/t0007-git-var.sh        |  2 +-
 12 files changed, 78 insertions(+), 13 deletions(-)


base-commit: 06e570c0dfb2a2deb64d217db78e2ec21672f558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1760%2Fdscho%2Fgit-var-on-windows-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1760/dscho/git-var-on-windows-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1760

Range-diff vs v2:

 1:  e0970381042 = 1:  e0970381042 run-command: refactor getting the Unix shell path into its own function
 2:  91ebccbc39f = 2:  91ebccbc39f strvec: declare the `strvec_push_nodup()` function globally
 3:  a718183bb3b ! 3:  f46315ac0b2 win32: override `fspathcmp()` with a directory separator-aware version
     @@ Commit message
          This means that the paths `a/b` and `a\b` are equivalent, and
          `fspathcmp()` needs to be made aware of that fact.
      
     +    Note that we have to override both `fspathcmp()` and `fspathncmp()`, and
     +    the former cannot be a mere pre-processor constant that transforms calls
     +    to `fspathcmp(a, b)` into `fspathncmp(a, b, (size_t)-1)` because the
     +    function `report_collided_checkout()` in `unpack-trees.c` wants to
     +    assign `list.cmp = fspathcmp`.
     +
     +    Also note that `fspatheq()` does _not_ need to be overridden because it
     +    calls `fspathcmp()` internally.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## compat/win32/path-utils.c ##
     +@@
     + #include "../../git-compat-util.h"
     ++#include "../../environment.h"
     + 
     + int win32_has_dos_drive_prefix(const char *path)
     + {
      @@ compat/win32/path-utils.c: int win32_offset_1st_component(const char *path)
       
       	return pos + is_dir_sep(*pos) - path;
       }
      +
     -+int win32_fspathcmp(const char *a, const char *b)
     ++int win32_fspathncmp(const char *a, const char *b, size_t count)
      +{
      +	int diff;
      +
      +	for (;;) {
     ++		if (!count--)
     ++			return 0;
      +		if (!*a)
     -+			return !*b ? 0 : -1;
     ++			return *b ? -1 : 0;
      +		if (!*b)
      +			return +1;
      +
     @@ compat/win32/path-utils.c: int win32_offset_1st_component(const char *path)
      +		} else if (is_dir_sep(*b))
      +			return +1;
      +
     -+		diff = (unsigned char)tolower(*(a++)) - (unsigned char)tolower(*(b++));
     ++		diff = ignore_case ?
     ++			(unsigned char)tolower(*a) - (int)(unsigned char)tolower(*b) :
     ++			(unsigned char)*a - (int)(unsigned char)*b;
      +		if (diff)
      +			return diff;
     ++		a++;
     ++		b++;
      +	}
     ++}
     ++
     ++int win32_fspathcmp(const char *a, const char *b)
     ++{
     ++	return win32_fspathncmp(a, b, (size_t)-1);
      +}
      
       ## compat/win32/path-utils.h ##
     @@ compat/win32/path-utils.h: static inline int win32_has_dir_sep(const char *path)
       #define offset_1st_component win32_offset_1st_component
      +int win32_fspathcmp(const char *a, const char *b);
      +#define fspathcmp win32_fspathcmp
     ++int win32_fspathncmp(const char *a, const char *b, size_t count);
     ++#define fspathncmp win32_fspathncmp
       
       #endif
      
     @@ dir.c: int count_slashes(const char *s)
       {
       	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
       }
     +@@ dir.c: int fspatheq(const char *a, const char *b)
     + 	return !fspathcmp(a, b);
     + }
     + 
     +-int fspathncmp(const char *a, const char *b, size_t count)
     ++int git_fspathncmp(const char *a, const char *b, size_t count)
     + {
     + 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
     + }
      
       ## dir.h ##
      @@ dir.h: int remove_dir_recursively(struct strbuf *path, int flag);
     @@ dir.h: int remove_dir_recursively(struct strbuf *path, int flag);
      -int fspathcmp(const char *a, const char *b);
      +int git_fspathcmp(const char *a, const char *b);
       int fspatheq(const char *a, const char *b);
     - int fspathncmp(const char *a, const char *b, size_t count);
     +-int fspathncmp(const char *a, const char *b, size_t count);
     ++int git_fspathncmp(const char *a, const char *b, size_t count);
       unsigned int fspathhash(const char *str);
     + 
     + /*
      
       ## git-compat-util.h ##
      @@ git-compat-util.h: static inline int git_offset_1st_component(const char *path)
       #define offset_1st_component git_offset_1st_component
       #endif
       
     -+
      +#ifndef fspathcmp
      +#define fspathcmp git_fspathcmp
      +#endif
     ++
     ++#ifndef fspathncmp
     ++#define fspathncmp git_fspathncmp
     ++#endif
      +
       #ifndef is_valid_path
       #define is_valid_path(path) 1
 4:  f04cfd91bd9 = 4:  60fde81d35c mingw(is_msys2_sh): handle forward slashes in the `sh.exe` path, too
 5:  707daf246bd = 5:  797cf9094ea run-command(win32): resolve the path to the Unix shell early
 6:  a74a7b4bb11 = 6:  7c53a4f4707 run-command: declare the `git_shell_path()` function globally
 7:  8bfd23cfa00 = 7:  7c8eba5bfd8 var(win32): do report the GIT_SHELL_PATH that is actually used

-- 
gitgitgadget
