Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF323D2B2
	for <git@vger.kernel.org>; Sat,  3 May 2025 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746282352; cv=none; b=SJHTFPdxlYhidHlP+StscV2rEV4e8NR4cBjYBCwzDQL7Ox+B22BKnT2hDYSVfv+8QcZaoIrBrDJwHiP8W+6oFdRjcCTXGMzT/YWp25vIycCH5ec0sMQ5r0XKO2MpMaHaLzwultHd7iDUHOkOxJJw3H0RgtjjKzRX+9i+yZKSHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746282352; c=relaxed/simple;
	bh=WRaW8uRUZEgwOESxkWxf2HwO6EIOYdKdB9CbAq0DbOs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QvB2796kY4c0CDczVb9ZDiNYy5MC6BisejLumJa8/Einq7CWhjJbMvH+ux73S1QJsu0Alb8cg7vYCN1Etf5mUyRhPD+j40BFHpt8PfHIf8ACnJhdPQLPPm8JhmSLHiH4zdRnhE76pUG6JwnNYh91QQgFa1+VJBwYiP+GgcYOOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgdVGgZD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgdVGgZD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso16724765e9.0
        for <git@vger.kernel.org>; Sat, 03 May 2025 07:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746282348; x=1746887148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Iv+d2kVyszIQxZfc5Szy5vusHvm+CHdfH0v75MiPBQ=;
        b=NgdVGgZD26GOgQKB4ZKbnLVucFYvEF5k079OrMhnUsxrVDUWEiVqABmdTOZOurPGLY
         rXLe/I6C1HrHLJp+k880TH+OEnh5il+Y+GFptccFgmUFdzddBG1c4POkkBt0U7a5sRAk
         LCfMUEUuhx9hieJaXhOdJzCADiF2KPu5tymAidb8Taklf8IhCXHcHk5u8lWHX8s0dGOU
         5x5MmgcIl4GogMPfTN21M95fD2JH5oL3MogCBUDsbm1YRw+/Sdbvnf40CsZPpvG3BjHc
         h4lYoTK1OQND2eX98OF+QtM0onfktqGi4mbpUkDjd/FYbouTWaz+ZwJFLB/9dyqzKvqS
         Elyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746282348; x=1746887148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Iv+d2kVyszIQxZfc5Szy5vusHvm+CHdfH0v75MiPBQ=;
        b=Oc8aAeNKCqmw5NwBh3nK4wcDuQORx4+/jxomrYgDjsqRmhJN+wsO8QxCYH5j8fl2CK
         5XT7oziEPV1gc/nip7FNb3Qq/FHvKUG6bRkD1gmk46dzNPJZsV+TWoo2QPsRProeYWTP
         N2OXiZzvKmhsLbKRrw10VVbCbWdLe19qBc6fLikOftQJtjC1HAQ4Zvt2O39BLeU2EPf4
         DENYn5Zia+T6XkGM847Q926MB/xwlHE7NZLhSq8Ah+/hQqLl+Unx+ItqPXL7kmKBSzi5
         NNlh5oJuzZkEoJ9rlmW5W6cOLwFUInmH6jTq/UiiRk+jz0ceTxh2fBhomtDwDB7RfKsM
         pHLg==
X-Gm-Message-State: AOJu0YwS0vMP19t79A+Ajfy7j9CwtZpFA611sTyal0k3KO+5Ead1a4SB
	C2bJyqwE5nkCzhcHxcN4BYNrnkW/6/umJuCG7QJl/SyiyaV/cDIqbk3HYw==
X-Gm-Gg: ASbGncuID+AeU97KC1cMRW0lMcJ7FWhxeroma+xcsJvyJa//OhsSPvUDEigbuF3mGLH
	2AwK5ZF9bUs4NeAsTombNEJ18aUdLi8Fs3Wz8ZjZMt/5HPQ5TZf0nkKBMfceQvnrcCosTNY+/li
	+Piz2wQtPdGzFVcBLO4hN0A5cRMJooV0sOa5r+hyuBnvR/SyIDtRELUj2AmQNSgY7xFmFM3681S
	eA/P5vkiXypHy2IrX4np4QL4MeysQQ2CKmNfJCKguG77J7QU6vrXE1HeZN8H5bpUNpQAEhqC8tC
	PI082J4EqVI/9uyrsYFueHG28XJN1JBCObQ3QcZR+A==
X-Google-Smtp-Source: AGHT+IGR3BRRwFLaWN03wK+hPLk09Xbq3e9G8AxP9xoGsH4dvw6L7uguSmNMVWUiz6sTnm/3ozDnfA==
X-Received: by 2002:a05:600c:8012:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-441c48b05cdmr9918655e9.7.1746282347695;
        Sat, 03 May 2025 07:25:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3528sm5084608f8f.30.2025.05.03.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 07:25:47 -0700 (PDT)
Message-Id: <pull.1908.v2.git.1746282346370.gitgitgadget@gmail.com>
In-Reply-To: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 May 2025 14:25:46 +0000
Subject: [PATCH v2] ci(win+Meson): build in Release mode
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When the `win+Meson` job was added to Git's CI, modeled after the
`win+vs` job, it overlooked that the latter built the Git artifacts in
release mode.

The reason for this is that there is code in `compat/mingw.c` that turns
on the modal assertion dialogs in debug mode, which are very useful when
debugging interactively (as they offer to attach Visual Studio's
debugger), but they are scarcely useful in CI builds (where that modal
dialog would sit around, waiting for a human being to see and deal with
it, which obviously won't ever happen).

This problem was not realized immediately because of a separate bug: the
`win+Meson` job erroneously built using the `gcc` that is in the `PATH`
by default on hosted GitHub Actions runners. Since that bug was fixed by
switching to `--vsenv`, though, the t7001-mv test consistently timed out
after six hours in the CI builds on GitHub, quite often, and wasting
build minutes without any benefit in return.

The reason for this timeout was a symptom of aforementioned debug mode
problem, where the test case 'nonsense mv triggers assertion failure and
partially updated index' in t7001-mv triggered an assertion.

I originally proposed this here patch to address the timeouts in CI
builds. The Git project decided to address this timeout differently,
though: by fixing the bug that the t7001-mv test case demonstrated. This
does not address the debug mode problem, though, as an `assert()` call
could be triggered in other ways in CI, and it should still not cause
the CI build to hang but should cause Git to error out instead. To avoid
having to accept this here patch, it was then proposed to replace all
`assert()` calls in Git's code base by `BUG()` calls. This might be
reasonable for independent reasons, but it obviously still does not
address the debug mode problem, as `assert()` calls could be easily
re-introduced by mistake, and besides, Git has a couple of dependencies
that all may have their own `assert()` calls (which are then safely
outside the control of the Git project to remove), therefore this here
patch is still needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
    
    I was surprised to find this issue today, and that this had not been
    addressed yet.
    
    Changes since v1:
    
     * Rewrote the commit message to reflect that this patch is still
       needed, even if the symptom that originally motivated the patch was
       addressed in a different manner, because it was merely a symptom of
       the underlying root cause that CI builds should not let Visual C
       build Git in debug mode.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1908%2Fdscho%2Fdont-let-win%2BMeson-hang-in-t7001-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1908/dscho/dont-let-win+Meson-hang-in-t7001-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1908

Range-diff vs v1:

 1:  18d1d18c48a ! 1:  c04b6c97b25 ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    ci(win+Meson): build in Release mode, avoiding t7001-mv hangs
     -
     -    Since switching to `--vsenv`, the t7001-mv test consistently times out
     -    after six hours in the CI builds on GitHub. This kind of waste is
     -    inconsistent with my values.
     -
     -    The reason for this timeout is the test case 'nonsense mv triggers
     -    assertion failure and partially updated index' in t7001-mv (which is
     -    not even a regression test, but instead merely demonstrates a bug that
     -    someone thought someone else should fix at some time). As the name
     -    suggests, it triggers an assertion. The problem with this is that an
     -    assertion on Windows, at least when run in Debug mode, will open a modal
     -    dialog that patiently awaits some buttons to be clicked. Which never
     -    happens in automated builds.
     -
     -    The solution is straight-forward: Just like the `win+VS` job already did
     -    in forever, build in Release mode (where that modal assertion dialog is
     -    never shown).
     +    ci(win+Meson): build in Release mode
     +
     +    When the `win+Meson` job was added to Git's CI, modeled after the
     +    `win+vs` job, it overlooked that the latter built the Git artifacts in
     +    release mode.
     +
     +    The reason for this is that there is code in `compat/mingw.c` that turns
     +    on the modal assertion dialogs in debug mode, which are very useful when
     +    debugging interactively (as they offer to attach Visual Studio's
     +    debugger), but they are scarcely useful in CI builds (where that modal
     +    dialog would sit around, waiting for a human being to see and deal with
     +    it, which obviously won't ever happen).
     +
     +    This problem was not realized immediately because of a separate bug: the
     +    `win+Meson` job erroneously built using the `gcc` that is in the `PATH`
     +    by default on hosted GitHub Actions runners. Since that bug was fixed by
     +    switching to `--vsenv`, though, the t7001-mv test consistently timed out
     +    after six hours in the CI builds on GitHub, quite often, and wasting
     +    build minutes without any benefit in return.
     +
     +    The reason for this timeout was a symptom of aforementioned debug mode
     +    problem, where the test case 'nonsense mv triggers assertion failure and
     +    partially updated index' in t7001-mv triggered an assertion.
     +
     +    I originally proposed this here patch to address the timeouts in CI
     +    builds. The Git project decided to address this timeout differently,
     +    though: by fixing the bug that the t7001-mv test case demonstrated. This
     +    does not address the debug mode problem, though, as an `assert()` call
     +    could be triggered in other ways in CI, and it should still not cause
     +    the CI build to hang but should cause Git to error out instead. To avoid
     +    having to accept this here patch, it was then proposed to replace all
     +    `assert()` calls in Git's code base by `BUG()` calls. This might be
     +    reasonable for independent reasons, but it obviously still does not
     +    address the debug mode problem, as `assert()` calls could be easily
     +    re-introduced by mistake, and besides, Git has a couple of dependencies
     +    that all may have their own `assert()` calls (which are then safely
     +    outside the control of the Git project to remove), therefore this here
     +    patch is still needed.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      


 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 83ca8e4182b..275240be5dc 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -265,7 +265,7 @@ jobs:
       run: pip install meson ninja
     - name: Setup
       shell: pwsh
-      run: meson setup build --vsenv -Dperl=disabled -Dcredential_helpers=wincred
+      run: meson setup build --vsenv -Dbuildtype=release -Dperl=disabled -Dcredential_helpers=wincred
     - name: Compile
       shell: pwsh
       run: meson compile -C build

base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
-- 
gitgitgadget
