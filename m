Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701807F
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 02:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717814656; cv=none; b=mhbsrYSmXSSSLEqW1OxbfwUxKPjmtDO3JAAUZSKkmwsAhutkewqQYWs7QNT5dVoXxSsvLsTh/6Ez06N7losJnrI7jH3jzpTfwNZZ6GvneJwsPedXlpFeu+qoRRN4kxiwfd+J5k9+3D9Xur4XJzDPvt6CASLcoC6mzsnaG8AJAvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717814656; c=relaxed/simple;
	bh=/WvEl2dhlH6HsiSsYrHNgB/JJzO58opsCcBft/1TONs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZaqR6meUhNqBaCLZIxo0wYun5oIqvmhWcImBqeNMQdiLyD8zu9KufWtIyv6LBu1Pmb/GgwyLhme9XHYvag8ckaA2jU73ptXcFrD8JS3L7ZqvJoL5vewR+RnX9vtL3GDzyNO/mtSSqruaSf1yGUpXxPbK2vZ3WWKcT3tfMsqW6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gluH5lC1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gluH5lC1"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so1218635e87.0
        for <git@vger.kernel.org>; Fri, 07 Jun 2024 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717814652; x=1718419452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WvEl2dhlH6HsiSsYrHNgB/JJzO58opsCcBft/1TONs=;
        b=gluH5lC1KFgyyYGJWgt/+XUX9Krkn56WrBLGZN1QaRzL/lYpHfOgT2OWQ2/QJ94Rn5
         Gcu9pTSYUIaTF4GAuZOgxDgQsxNzjaK0qXeLhnp12Z3FEBj/GIPDJo9UTLBri2lPFAoG
         e98zeoU4cCsrF9Iz6+tfOKg6c5COaUrLkwyoYAVeGoQbrlwZFi9hepn7dmBaZu4JaqMm
         IAgwgJhAsdsRDH1SFibZmHj3/RAueccwRYG7GLnim7CLwRirtjA9Pchx++FYDN/CZsGQ
         PFQlnIGs//SXaRBo6OHxijeOczy/1yIuNiCG9bsTNgHY/K9OefiI/O58jrzw2siXnTqx
         OZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717814652; x=1718419452;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/WvEl2dhlH6HsiSsYrHNgB/JJzO58opsCcBft/1TONs=;
        b=CqoNLR+Ih3m/jbqr1S2sYm80zntCS3b22zFgQEgeoDMSxpj5cRb20uWSA+eP73hZtZ
         4K3s62iMZ8trZowwlAMVsmkX4OuTYveAp6TtHibwLP/DUsSElhyTPdErbfDz1tMczmYU
         4dObaD6j2qG059ug1fvSIP95n7YrmDDyja9djRPtMcfAiVlY4b8CA26Wc511jRp9E/Ig
         gJSxXKjg1XA2lJ6q7tk7WKqKPGir0UQz06ep0eCQwdaProYZ5SCIGbcjjBDiMft/0Sws
         JfET+Y3htAVKyiHDFWScrzey91P9xyAfWWY+Eatyfhl4W00Xy9ViAqOpp1bggoHTivHG
         lvYA==
X-Gm-Message-State: AOJu0YzUFWvc+KuSqTGjk9XbPgJRfF36Yu7Y08sujIbOVskv1x92f/3s
	0xeeh66pWvkz4eHdU91E6RQUp5bG11b0oPUg9zpw4SPAotzNeuCnfPRGUajFjFmSfw0RCKppDeQ
	mJC3DwNlQgYY7wB2FaJjCGG7tZIyRRtve8XlDeowfouiZorxCNw==
X-Google-Smtp-Source: AGHT+IEEaP9GfLXHGBDh4vM1a3C7+P1HX/+zVBOqrsubv8jXHfD56196iGzvA2UisR8r9kBvWZSubv9x2clye6RW3LQ=
X-Received: by 2002:a05:6512:3f09:b0:51f:3e0c:ace3 with SMTP id
 2adb3069b0e04-52bb9f785d9mr4460137e87.16.1717814652043; Fri, 07 Jun 2024
 19:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kyle Lippincott <spectral@google.com>
Date: Fri, 7 Jun 2024 19:43:56 -0700
Message-ID: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
Subject: MSan failures in pack-bitmap
To: Git Mailing List <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

While running t/t5326-multi-pack-bitmaps:

test 24:
expecting success of 5326.24 'clone from bitmapped repository':
rm -fr clone.git &&
git clone --no-local --bare . clone.git &&
git rev-parse HEAD >expect &&
git --git-dir=clone.git rev-parse HEAD >actual &&
test_cmp expect actual

Cloning into bare repository 'clone.git'...
remote: ==7474==WARNING: MemorySanitizer: use-of-uninitialized-value
remote: #0 0x55c5cd191dde in try_partial_reuse pack-bitmap.c:1887:8
remote: #1 0x55c5cd191dde in reuse_partial_packfile_from_bitmap_1
pack-bitmap.c:2001:8
remote: #2 0x55c5cd191dde in reuse_partial_packfile_from_bitmap
pack-bitmap.c:2105:3
remote: #3 0x55c5cce0bd0e in get_object_list_from_bitmap
builtin/pack-objects.c:4043:3
remote: #4 0x55c5cce0bd0e in get_object_list builtin/pack-objects.c:4156:27
remote: #5 0x55c5cce0bd0e in cmd_pack_objects builtin/pack-objects.c:4596:3
remote: #6 0x55c5ccc8fac8 in run_builtin git.c:474:11
remote: #7 0x55c5ccc8d660 in handle_builtin git.c:729:3
remote: #8 0x55c5ccc8b634 in run_argv git.c:793:4
remote: #9 0x55c5ccc8b634 in cmd_main git.c:928:19
remote: #10 0x55c5ccf10a5b in main common-main.c:62:11
remote: #11 0x7f9ef142e3d3 in __libc_start_main
remote: #12 0x55c5ccbf28e9 in _start
remote:
remote: Uninitialized value was stored to memory at
remote: #0 0x55c5cd191dd7 in try_partial_reuse pack-bitmap.c:1888:15
remote: #1 0x55c5cd191dd7 in reuse_partial_packfile_from_bitmap_1
pack-bitmap.c:2001:8
remote: #2 0x55c5cd191dd7 in reuse_partial_packfile_from_bitmap
pack-bitmap.c:2105:3
remote: #3 0x55c5cce0bd0e in get_object_list_from_bitmap
builtin/pack-objects.c:4043:3
remote: #4 0x55c5cce0bd0e in get_object_list builtin/pack-objects.c:4156:27
remote: #5 0x55c5cce0bd0e in cmd_pack_objects builtin/pack-objects.c:4596:3
remote: #6 0x55c5ccc8fac8 in run_builtin git.c:474:11
remote: #7 0x55c5ccc8d660 in handle_builtin git.c:729:3
remote: #8 0x55c5ccc8b634 in run_argv git.c:793:4
remote: #9 0x55c5ccc8b634 in cmd_main git.c:928:19
remote: #10 0x55c5ccf10a5b in main common-main.c:62:11
remote: #11 0x7f9ef142e3d3 in __libc_start_main
remote: #12 0x55c5ccbf28e9 in _start
remote:
remote: Uninitialized value was created by a heap allocation
remote: #0 0x55c5ccc052ca in realloc msan/msan_interceptors.cpp:1009:3
remote: #1 0x55c5cd3d04d6 in xrealloc wrapper.c:137:8
remote: #2 0x55c5cd190d95 in reuse_partial_packfile_from_bitmap
pack-bitmap.c:2091:3
remote: #3 0x55c5cce0bd0e in get_object_list_from_bitmap
builtin/pack-objects.c:4043:3
remote: #4 0x55c5cce0bd0e in get_object_list builtin/pack-objects.c:4156:27
remote: #5 0x55c5cce0bd0e in cmd_pack_objects builtin/pack-objects.c:4596:3
remote: #6 0x55c5ccc8fac8 in run_builtin git.c:474:11
remote: #7 0x55c5ccc8d660 in handle_builtin git.c:729:3
remote: #8 0x55c5ccc8b634 in run_argv git.c:793:4
remote: #9 0x55c5ccc8b634 in cmd_main git.c:928:19
remote: #10 0x55c5ccf10a5b in main common-main.c:62:11
remote: #11 0x7f9ef142e3d3 in __libc_start_main
remote: #12 0x55c5ccbf28e9 in _start
remote:
remote: SUMMARY: MemorySanitizer: use-of-uninitialized-value
pack-bitmap.c:1887:8 in try_partial_reuse
remote: Exiting
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: fetch-pack: invalid index-pack output
not ok 24 - clone from bitmapped repository
#
# rm -fr clone.git &&
# git clone --no-local --bare . clone.git &&
# git rev-parse HEAD >expect &&
# git --git-dir=clone.git rev-parse HEAD >actual &&
# test_cmp expect actual
#

There are similar failures in test 25, 198, 199, 319, and 320.
---

I believe what's happening is that pack-bitmap.c:2091 grows the packs
list and sets up some of the fields, but doesn't set pack_int_id. We
then use it at pack-bitmap.c:1888.

I investigated, but couldn't prove to myself what value should be
placed there while growing it, or if it's incorrect to read from it in
this case (so we shouldn't be in pack-bitmap.c:1888 with this pack).

Reproducing is potentially non-trivial. This may work:

make -j CFLAGS="-fsanitize=memory -fsanitize-memory-track-origins
-fno-omit-frame-pointer -g -O2" CC=clang && \
make -C t t5326-multi-pack-bitmaps.sh GIT_TEST_OPTS="--verbose --debug"
