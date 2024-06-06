Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B51535C8
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715070; cv=none; b=o99quXurmq4NMQun/9QcugMw7NOQwqpVxFxkwUAMR1Qi3c5aED0tjCmIkW7nKIMNjzLBeuIARdwNp68z733gKD6zHwBMYDmPoG6el+0BFY3oLbVYpTWobv7YyFthBZfnZkwJUevl0WRvBdhPODQV2Uh0rYjSysv8r8ge2lfqAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715070; c=relaxed/simple;
	bh=rY5B1rT7X9JHR5XUrwCUYdVOGe6cTmqDe3KSx/9ScDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y5UQLaUacYeDZ+1yKgYyPXsUhcf4Xac7fu6guzIIVWXV4eFHOPdXLqq+rUzDdy5FxMuo7zWzhrGG77oupgFBR4JlzWCaEYK/WFnAaq2yO66P/Okf3JDyvE1UeKxwYyRprvAFNvw5wuCtHGgkjoIRPWLwQdl/QDqVt4UJYt8jbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=euoRRhTp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="euoRRhTp"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b9776123a3so794122eaf.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715064; x=1718319864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XgPuF1jDStH/+DGSFjVusIVBzBUT+1JhL9m6Pp5EoU=;
        b=euoRRhTpT3NxkpfGaoCgIu8R6kmQE2Y8DFSjmpbiK7Uo/jXD4sOAAhuYJwo6aKRLVN
         uaLSG2KimMsBhXTeqtQmUSU/osJp4xR6x8pW/mJMEF8MMMCmrAKwU8xlM1pX4b9mM+3E
         u2MkWQfkM+uiizjHZBmXHREkhqCakJ58JRrdlgGDAqp0gSblbQcP3qqcybanIx/LIfgG
         CRtEG7wzy4Y3HQJuiILMX2aWQPT4FJcKhRBMZnI9BnYbmemDOWScLO8sSYx/2JFIwjE8
         wHJpOrQZ5qT6ve03Soign6TnLC5xpOcRGNS9T7/wRPrBic6+KXYKsxR81ezoQpzNaAy+
         FDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715064; x=1718319864;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XgPuF1jDStH/+DGSFjVusIVBzBUT+1JhL9m6Pp5EoU=;
        b=fMIzA8aIVynoS05/B5HgMbkbCCKSyfcdE3XkK2J9IA/Pk3rX/86YZLGI3QxSTUQy67
         /ClyLvGDXn0THrXsDEnLynt3wttQmpJAuFxDVwDHCI7riroBjPN/Cy/t6m6YV8sSb6MO
         U+uJasvQj5a51Z3TLHa33YIdlZUwZKeSeteoTlm5eXxfUriJfO6ZvBAWuE2NeCqnWZ2n
         r9SPnS1fiSHp1/Vn/kSGTS5y7R3JLUWjJlER3q15kXIdYEPcrq+6JRcbPYSJwXDbnq1d
         Y1zUB+9fDJ35CKtdM0578Jh7EzTePPvbAXKvDHV1klWVT/5iQ8fL20AaS3WsQ3JRLu31
         6dLA==
X-Gm-Message-State: AOJu0YzBHEtkuKiuVLO4Rr/J3U8SKlXrI+J1n8u5XrPoCqgIQORMIdMR
	wXorZt/ot5f9B8yTYQ/l6x9JAXGd84KDc3zGmj9piZIZdETgfk8wngWM3ibrRVTePjQq+CHwWrU
	aIFQ=
X-Google-Smtp-Source: AGHT+IGUASIjAk5XhcFac753wrWnk+AeUi4oXsugSUsjc0pxn0PGqXtIWdNsOB7agh4NhaGTPfuf8w==
X-Received: by 2002:a05:6358:5e17:b0:17b:f721:4565 with SMTP id e5c5f4694b2df-19f1fe18697mr117799955d.9.1717715063845;
        Thu, 06 Jun 2024 16:04:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f623c5asm10489626d6.11.2024.06.06.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:23 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

This series implements incremental MIDXs, which allow for storing
a MIDX across multiple layers, each with their own distinct set of
packs.

MOTIVATION
==========

Doing so allows large repositories to make use of the MIDX feature
without having to rewrite the entire MIDX every time they want to update
the set of packs contained in the MIDX. For extremely large
repositories, doing so is often infeasible.

OVERVIEW
========

This series implements the first component of incremental MIDXs, meaning
by the end of it you can run:

    $ git multi-pack-index write --incremental

a couple of times, and produce a directory structure like:

    $ .git/objects/pack/multi-pack-index.d
    .git/objects/pack/multi-pack-index.d
    ├── multi-pack-index-chain
    ├── multi-pack-index-baa53bc5092bed50378fe9232ae7878828df2890.midx
    └── multi-pack-index-f60023a8a104be94eab96dd7c42a6a5db67c82ba.midx

where each *.midx file behaves the same way as existing non-incremental
MIDX implementation behaves today, but in a way that stitches together
multiple MIDX "layers" without having to rewrite the whole MIDX anytime
you want to make a modification to it.

This is "part one" of a multi-part series. The overview of how all of
these series fit together is as follows:

  - "Part zero": preparatory work like 'tb/midx-write-cleanup' and my
    series to clean up temporary file handling [1, 2].

  - "Part one": this series, which enables reading and writing
    incremental MIDXs, but does not have support for more advanced
    features like bitmaps support or rewriting parts of the MIDX chain.

  - "Part two": the next series, which builds on support for multi-pack
    reachability bitmaps in an incremental MIDX world, meaning that each
    `*.midx` layer can have its own `*.bitmap`, and the bitmaps at each
    layer can be used together.

  - "Part three": which supports more advanced management of the MIDX
    chain, like compressing intermediate layers to avoid the chain
    growing too long.

Parts zero, one, and two all exist, and the first two have been shared
with the list. Part two exists in ttaylorr/git [3], but is excluded from
this series to keep the length manageable. I avoided sending this series
until I was confident that bitmaps worked on top of incremental MIDXs to
avoid designing ourselves into a corner.

Part three doesn't exist yet, but is straightforward to do on top. None
of the design decisions made in this series inhibit my goals for part
three.

[1]: https://lore.kernel.org/git/cover.1717023301.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/cover.1717712358.git.me@ttaylorr.com/
[3]: https://github.com/ttaylorr/git/compare/tb/incremental-midx...ttaylorr:git:tb/incremental-midx-bitmaps

Taylor Blau (19):
  Documentation: describe incremental MIDX format
  midx: add new fields for incremental MIDX chains
  midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
  midx: teach `prepare_midx_pack()` about incremental MIDXs
  midx: teach `nth_midxed_object_oid()` about incremental MIDXs
  midx: teach `nth_bitmapped_pack()` about incremental MIDXs
  midx: introduce `bsearch_one_midx()`
  midx: teach `bsearch_midx()` about incremental MIDXs
  midx: teach `nth_midxed_offset()` about incremental MIDXs
  midx: teach `fill_midx_entry()` about incremental MIDXs
  midx: remove unused `midx_locate_pack()`
  midx: teach `midx_contains_pack()` about incremental MIDXs
  midx: teach `midx_preferred_pack()` about incremental MIDXs
  midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
  midx: support reading incremental MIDX chains
  midx: implement verification support for incremental MIDXs
  t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  t/t5313-pack-bounds-checks.sh: prepare for sub-directories
  midx: implement support for writing incremental MIDX chains

 Documentation/git-multi-pack-index.txt       |  11 +-
 Documentation/technical/multi-pack-index.txt | 100 +++++
 builtin/multi-pack-index.c                   |   2 +
 builtin/repack.c                             |   8 +-
 ci/run-build-and-tests.sh                    |   2 +-
 midx-write.c                                 | 293 +++++++++++--
 midx.c                                       | 410 ++++++++++++++++---
 midx.h                                       |  26 +-
 object-name.c                                |  99 ++---
 packfile.c                                   |  21 +-
 packfile.h                                   |   4 +
 t/README                                     |   6 +-
 t/helper/test-read-midx.c                    |  24 +-
 t/lib-bitmap.sh                              |   6 +-
 t/lib-midx.sh                                |  28 ++
 t/t0410-partial-clone.sh                     |   2 -
 t/t5310-pack-bitmaps.sh                      |   4 -
 t/t5313-pack-bounds-checks.sh                |   8 +-
 t/t5319-multi-pack-index.sh                  |  30 +-
 t/t5326-multi-pack-bitmaps.sh                |   4 +-
 t/t5327-multi-pack-bitmaps-rev.sh            |   6 +-
 t/t5332-multi-pack-reuse.sh                  |   2 +
 t/t5334-incremental-multi-pack-index.sh      |  46 +++
 t/t7700-repack.sh                            |  48 +--
 24 files changed, 935 insertions(+), 255 deletions(-)
 create mode 100755 t/t5334-incremental-multi-pack-index.sh


base-commit: 680474691b4639280a73baa0bb8792634f99f611
-- 
2.45.2.437.gecb9450a0e
