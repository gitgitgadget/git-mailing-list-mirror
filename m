Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577807;
	b=lU0B9xwO1uYMotau3HTOJ0n0Na6J5liympyrSjIawF9rICjxA75vD03jFwjfP5ixC2fm
	 jEY6Dy4SxLuvsI+DqHuGpNEOL6Rxte7rXzUUPRPbXBafzc0Erbe8IhwSDxsAL/AJ623uw
	 3YsyT3n1ZfHOMPalNJLfvcH1hLGD0wRx3RDNQ0mPXn07SIEvYDQk4wn5PRQcD5uX2S/Nw
	 LXYOBH9vKtSlQ47KAtifBh4e+6eEvnMpJIFGzPV1Hol8sK4Jkf7lfFyy8ogYz+Lig8SJi
	 F1i1L+CYDjEfwDfgGjFO/b0HgFwKZ6R3GowSmi/tBqvVG3uONp/YtZhwxx1jQlhy44g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dB9wt81Sdc2QQqirhgYyQ2GOsMbmS0kEVmX+mIzzW3g=;
	b=IMY7Zmus3+y5dzIM+ACiU6yKVNr9R/aFyNFQTUhRSlnMb8a4ddyPeK6h+blWubPNcXBR
	 dAmnCLhtih/IEO9NOSdv6xHU1Kz08sYh1Noa5PLuthOgJ41flS8WZWnxQkDzMa33X1u/y
	 tHTDuqcRvCgKrtweopq7hncrCe3baeWndSQxOUGFMn+Y0q8RXPONeNRK4BIgp4C6FSTbH
	 XgQpF1/499i81hbLE9Jts9tnZCKcbxqMro1GlXI0y9UEQHSnpWDb92P4Q742fx6ntsyzX
	 Z8kt3pkuvq8lOoJxJ3zFZcDFrZDpCpIDcfwUzAGwwplWy3NGHiabHeCBN95sR74jiDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="emdKI5/Y";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFF606A334
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23DFF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=emdKI5/Y
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b060ec084so424290f8f.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577805; x=1793182605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dB9wt81Sdc2QQqirhgYyQ2GOsMbmS0kEVmX+mIzzW3g=;
        b=emdKI5/YSNN68du1QJccsiVlwOlnV9fwP1u2dME55i8DAIUZkvC5/YVnwccFmVOPyy
         EnjQhQ0Ov0sadQn3dDo0LQR6ipgixfUG6Gsxeq4U6wFwkVb5zVkkidPLvROlRIuLRwGR
         kqJLKrh2oehU6yNpu41io63/iZ0M2h1ubOkSsSZHn5fLjHVEg9FAT171s388mYNtNByE
         UYlar2WS/aWB4rm+eXCNevKs2R4XgEGUwE1Ul66VR9IYGoo+RGjZDJf3iYyCDzbQA0Ge
         CBaXlbVw4x1MgPwtGBPCetCWXeIgRiOakfu/Ay2GgAFydymG8T4xY+wKMHIIgcPzTODy
         bukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577805; x=1793182605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dB9wt81Sdc2QQqirhgYyQ2GOsMbmS0kEVmX+mIzzW3g=;
        b=OA72kNXHLyGX11WyotoP4SmuVwz3GK2DoqzUuEPjhqSkb8TnZnAzEFJdNOVPr54dj0
         RnPLaq2FuCRbwKI0XwEvnrwpZ7b3MsoXXpSHveBXOLnmgS5EbV82ZSCjjOMBcimiESiI
         yJfGgtAY3gbsLCn/Eo6UaSyt7aF/9K3gMm1Rq7FGnOhadmIgwygpcmCfy1gYdodFVu4K
         YmPMMH0xN5iAQJrXL3pAwVfdu1BWSazJd8iLVIT2GWZcY0h7cCBbCUNHLQz7EZDKVVhY
         DjEzO15BdAkz3xLpUQJheltBNKcxSv38mSDGTRPOCoJcgKzwNXPq+QzPC76a/uRg1IqI
         2oVg==
X-Gm-Message-State: AFq9FYJShkflOUyLOmDYpVSWHkcPllu6PXFUoHn+TNj6dnnqTJXZToqT
	h7ndH8mQk3nnZ+jdbRmmQZGYLSXppVcANeotScgEBKVpZihnavUZbmPX9/Km2v/G
X-Gm-Gg: AYBFou3QrIfZ494G/zRHoylimHMTUitg4LahXWUE2fkJJXQmcmBs2Ux84DuXvfQ8XKG
	mjemaTJbhngc8Oq+0PEnpex9oGJBDEgH9PzJV7AZMYtc09titbjQJ2zQA9m6t4oTJCDXHo9r+MZ
	oib8PAFiGEnhtDydE5bAGH4iw31exXmewM0B/+DrfE5huRPOsnQa0xOaH1+lCneBUzk204/MKRG
	VRPztXsjKul1a2OVGhu4VTKsXMiHbfGO9I68ddZX3TQNwBpVxcW5SOqGtiZ+Kh8T/YgGnHDSYtj
	EfbWSOMsOZtkZDiycBUuwQ9ibGLDfESspnhdIAU3cpxqv4yo0oseN+qizhagYCGbSpuKEQMDu9V
	eS/AobHjAujAYvrqTt95xaylOItbss0Rx0fMc0jNN4f7KxO57tyvLq4EYIC4yeiCrS737m7v0Fy
	iXU33Sgx+sG8LqbTQ2F6asic/CXhGczmdCsZ4uyCoC9W40g5B+GnpM1ewdniIRe6qwK7jHwzrWI
	IkudbbIcfoCOkj3Zw7FEvkQoQXOYw42VsUorM8N2yCgrcxYzVhlwfzEQytVPN5GiLlkbmu+E+64
	xivv9ZENB5w=
X-Received: by 2002:a05:6000:2b04:b0:48d:fe88:ffee with SMTP id ffacd0b85a97d-48e264e20c3mr2118536f8f.53.1792577805156;
        Wed, 21 Oct 2026 03:16:45 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm4472602f8f.52.2026.10.21.03.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:16:44 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 0/3] use size_t for a few more object and buffer sizes
Date: Wed, 21 Oct 2026 12:16:36 +0200
Message-ID: <20261021101640.329990-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 64-bit Windows, "long" is still 32 bits wide. Whenever a size_t
travels through an "unsigned long", anything above 4 GiB is silently
lost. Johannes's js/objects-larger-than-4gb-on-windows work fixed the
read side of the object database, and Peff's jk/xdiff-size_t did the
same for the diff and merge machinery. This series picks up three
places that were left narrow.

 - odb: the write API still takes the object length as unsigned long.
   A large file that is converted before being stored (for example
   with core.autocrlf, which Git for Windows enables by default) can
   reach odb_write_object() with a size_t length above 4 GiB. The
   blob is then written truncated, with no error, and the index
   happily records it.

 - diff: diff_words_fill() grows its buffer with a signed "long"
   allocation size. Its output can be twice its input, and on LLP64
   the growth computation overflows past about 700MiB, which is well
   within what xdiff accepts. In practice Git dies on a huge
   allocation request.

 - convert: the helpers that decide whether a file is binary, has
   CRLF line endings or "$Id$" keywords take an unsigned long length.
   For files over 4GiB they only look at a prefix. In the same area,
   read_blob_data_from_index() narrows its result with
   cast_size_t_to_ulong(), so "git add" with core.autocrlf dies when
   the staged version is that large.

There are no new tests. Each case needs files of several GiB and a
32-bit "long", and the commit messages explain how to reproduce them.

How these were found
--------------------

I wanted a list of all the places where a 64-bit size is narrowed on
Windows, rather than waiting for the next bug report. Linux compilers
cannot see the problem, because there "long" and "size_t" have the
same width. So I analysed the tree as a Windows target instead.

The first step is a compilation database from a real MinGW
configuration. Forcing --target onto a database generated on Linux
does not work well: Linux-only defines leak in, regex.h is missing
from MinGW, and the precompiled header is rejected for the wrong
target. A Meson cross build avoids all of that:

  $ cat mingw64.cross
  [binaries]
  c       = 'x86_64-w64-mingw32-gcc'
  ar      = 'x86_64-w64-mingw32-ar'
  strip   = 'x86_64-w64-mingw32-strip'
  windres = 'x86_64-w64-mingw32-windres'

  [host_machine]
  system     = 'windows'
  cpu_family = 'x86_64'
  cpu        = 'x86_64'
  endian     = 'little'

  $ meson setup build-win --cross-file mingw64.cross \
	-Db_pch=false -Dsane_tool_path=/usr/bin \
	-Dcurl=disabled -Dexpat=disabled -Dpcre2=disabled \
	-Dgettext=disabled -Diconv=disabled -Drust=disabled
  $ meson compile -C build-win

Two of these options are not obvious. Without -Dsane_tool_path,
setup stops because meson.build adds "C:/Program Files/Git/bin" to
the program search path, which is not absolute on a Linux host. And
-Db_pch=false is needed because clang cannot read the precompiled
header that GCC produces. The build only has to get far enough to
generate the headers; link errors do not matter here.

The second step runs clang-tidy over that database with
-Wshorten-64-to-32, for the x86_64-w64-mingw32 target, skipping the
bundled zlib and OpenSSL. One detail cost me a while: with
"-checks=-*", clang-tidy drops compiler warnings unless
clang-diagnostic-shorten-64-to-32 is enabled explicitly. I wrapped
all this in a small script, which also refuses to report "no
findings" when some translation units failed to parse:

  https://github.com/devzero2000/toyscript/blob/main/check_llp64_portability.sh

It is not meant for inclusion. I mention it so that the numbers below
can be reproduced, and in case someone finds it useful.

What the scan shows
-------------------

All 569 translation units were analysed, none failed. There are 1432
64-to-32 truncation warnings, but most of them are not specific to
Windows: about 1200 narrow a size_t to an int, as they do on Linux.
Only 237 have "long" or "unsigned long" as their destination.

Most of those 237 sit on API boundaries that are known and that
commit c6a4629e32 names explicitly: diff, blame, textconv and
fast-import. Others are in tree walking, object parsing and the pack
tools, where an oversized object makes Git die rather than misbehave.
I would like to convert them in later small series, one area at a
time, in the same style as jk/xdiff-size_t.

Johannes, the first patch continues your write-side work. I hope it
does not step on a follow-up you already have in progress.

Elia Pinto (3):
  odb: use size_t for the length of objects to write
  diff: use size_t for the allocation size of word-diff buffers
  convert: use size_t for buffer sizes

 attr.c                |  2 +-
 convert.c             | 14 +++++++-------
 diff.c                |  4 ++--
 odb.c                 |  2 +-
 odb.h                 |  4 ++--
 odb/source-inmemory.c |  2 +-
 odb/source-loose.c    |  2 +-
 odb/source.h          |  2 +-
 read-cache-ll.h       |  2 +-
 read-cache.c          |  4 ++--
 10 files changed, 19 insertions(+), 19 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
--
2.53.0

