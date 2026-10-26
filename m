Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029568;
	b=PdYsm6vLEcSHG/nEYJlS17yJ/EUGNlVj+QDhEa16cW0a8+k2QyTj9It37vJVlt34KdtL
	 /CTg+1FrbqdO/Zwwi+WbKLfpwMQ9V8IOOwtBy/46Tm3sqOnH5Ku6u7I56Q7rmYeFBpsTK
	 LyIq88bTDe+EfEC7RxqieS/WlZOxZ6QoJgzRdh91MbOMYTbUDqs5b+48OM/zE5XNUU73Z
	 KJa7mjjNcHPpqXOYRkzNCDdD/6QeJqQC8mu8ydwGf+D950Nlb9da/zy7gicLYdrx0V3ef
	 0vcsZHsr6HNDKPsuorVsrkGwbBiq6wwnqSQbxO669r1F3Gtt2zy8hr/aKBwnFGeN0cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=O5eQoff691zv4bHbA0CQyWsnRm247AA3YZWKFQnJhSw=;
	b=PwFacQlvy4hY6DbBUdgiIvWeO+Jd9HN0zg2zaz4u5kRGCuilx5xiTj99xfpRmPaW2c2T
	 gGrDoLMO+aN1dyzft98g07YhYI+L9PJGbctc5W6Gt2WbKolgx+JwjaOnSUSs9URjbwtq9
	 eWv9PcrRpB9h96Nu/taj5Bb4yMZkdrlih+Q7Gom22Oy2GlrGJsuZi/FLnEwVIZwE25b7g
	 /bn5YcHjVaU5uaB0MjxOcSGnYnYhFMSG8jyeCSkzwWjBPjax/R7D6Hl5qO5Z/x1yH9QB2
	 XZBCDpAQTLVnJaMMCEdVZ5k+2AO0ypZ7lw2nI1/ptRsyyjQ4xZGinAPQlZKwWE8KGCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cim0G2Lb;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA6606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0EA6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cim0G2Lb
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9e53d011eso22283435ad.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793029567; x=1793634367; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O5eQoff691zv4bHbA0CQyWsnRm247AA3YZWKFQnJhSw=;
        b=Cim0G2LbjA2vzOJ58/3Gr9da1y1AdvnX4cm7uqfr9X8vbfxVJksKs4nGtY6I51O1pr
         6MajzeIBkCI+G+ODxxJ70Y/T7jOeqZrl9SHpYWZHiYAR6FVJ1dDVhhIwlbPi4HaCz7cI
         IRjrXqZYKDpmKNUWjzseO2XajBmRn7nznC2Qjp38oNq9gK3HSIiIv2UP+AQRvTIrs2yk
         8C8vlECfj8QAMcJe/gJ78dTtpOD21oaNY9S5cjzOZBgYrzXj0Wkbvh9hVf2KZaF0R5PL
         iBooIVX/PXcEEQGMrY62wSBvQ4IBb2nhVM1OPVJn8L4epYP0ZKe2aNt57vhnXmXw9QCj
         CcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793029567; x=1793634367;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O5eQoff691zv4bHbA0CQyWsnRm247AA3YZWKFQnJhSw=;
        b=NFD/dnEYlkTk7b6rEZycuVtAAkvoMw5gQcl2dgWWJ4FlOJfVZRBC+K+4Y5yI9U5Mnq
         X9quHhN2mlj8tMMMwqOrlttPd6qZdEnKQwUk++GNcPPPF5gaXMTEyzuAOg4GOL9dF+1C
         Nt5Q0HKVZsv23DZDt0dNFRueHmQXmbHfDOl1ExDL4YxcOan1M5Fy/jg1N9hFxvKDmxvK
         mujswQPtxj3i8E8FD9vVgJ28QDTPT7EoQX5gRdn0RrE5W0hfZD+ihPW3mSLpqqxcft/h
         P7Wlk23Vu3t9cyqpVJSZerFswP8VnERd5HtZIdo2VoTDNsr1RuOIzi/ebTwojGTvQszu
         GSCA==
X-Gm-Message-State: AFq9FYKuIGQmRE/MNYly9FsAolA4tljkdgY7LiwgjQAkhkh7uBhcO5XU
	BgNrHken3lKDj8JWUmFavN+9c5ioNJ73qSr2p2XVVBf1hIIeOgqFcnEf6uY57alF
X-Gm-Gg: AYBFou0aWh3DmVXgJJKYE5oXD4K0ityaem9iq8GJa92Ug9B9FAk2+EzaRcn6TnJ/gUF
	oeJ5R28sbr6lQAo8NP+kbLbMwO/w2TBEbxeHlVKQnYW9IYOKWtgM7aNkgCfs6N8VakFavhUzhpG
	ios2PumVyPUwhuOmg2jPopYGueEMh1s2/eJp2QcaH4W9JDVoxYbFcsa1bbssJS78uDCLFYJkbsh
	AO9+qzX5aHoV2dr/MdRb/tNlx2sKWWod+oSWbwncyspXxcMqEEN+EyTrQUIkQqTYAliRmPOehdZ
	Hzl6rcwa7gYF28zZ1S0tSeUw2N+vu5asmRr/XK9A0GUSiEPmumKKVJiKcsUuW1BhgelBvgmMRGr
	Tcs/DnEIVpSnA9hgWaBcGuO10oP5U6U4f2w2DRRsomSHCGIaUGFOAUlopDGbaGpCLD9sH/79LsD
	w1bsHhBbiFU8xXxPdicofJ6+AeXRNdfqHiPZ9LpHY4OlJLok4bPOr46XYPZKHB3BiViHOlRj7uG
	fOfobBPnj/C9ZvQMAGv6CwcODZZ9chZNHmXFsiXAOf+NZagIbp4z+wPsw==
X-Received: by 2002:a17:903:1a0d:b0:2e9:4f73:83d1 with SMTP id d9443c01a7336-2ea9c674e67mr62938425ad.22.1793029566716;
        Mon, 26 Oct 2026 08:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.34.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1dfee1sm18683115ad.64.2026.10.26.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:46:06 -0700 (PDT)
Message-Id: <pull.2281.git.1793029565.gitgitgadget@gmail.com>
From: "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 15:46:02 +0000
Subject: [PATCH 0/3] send-pack: avoid resending unchanged objects after rebasing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Marc Strapetz <marc.strapetz@syntevo.com>

A common feature-branch workflow is to push a branch, rebase it onto an
updated upstream, and force-push the rewritten commits. Large blobs added or
changed on the feature branch may survive the rebase unchanged. Although the
receiver already has those blobs through the old branch tip, Git can pack
and send them again. This can turn a small history rewrite into a large
upload.

This series teaches send-pack to request inspection of the old tip's tree
before packing, so more receiver-known objects can be excluded.

The additional inspection is enabled only for forced non-fast-forward
updates of existing branches with locally available old tips. Ordinary
fast-forward pushes do not enable it, including ones made with --force. No
server or wire-protocol change is needed.

The old tip is already a negative revision, but it may lie outside the
boundary visited by the ordinary revision walk. Its tree is then not
necessarily inspected. Passing it to pack-objects as --inspect-have lets us
compare its root tree with the outgoing trees using the existing sparse tree
marking. This excludes additional receiver-known objects without walking the
old tip's commit history, and prunes identical and receiver-only subtrees.

Shallow pushes keep their existing aggressive edge handling. Partial clones
skip the extra tree inspection to avoid fetching missing objects, and
successful bitmap enumeration keeps its existing path. Old tips are resolved
in pack-objects, where replacement refs are already disabled.

I compared upstream 7e34d8174dcda3435d1404c9a30bef46afe6c13e with the
patched source using trees from Chromium commit
5b05cc16e960a021389ef9b543ab38a037c38d60. A depth-two clone supplies the
objects; the measured fixture has a complete, non-shallow history with a
common base and sibling receiver/outgoing commits.

Both builds used GCC 15.2.0 and -g -O2 -Wall on an Intel i7-13700H under
WSL2. Measurements used a warm cache, sparse enumeration, no bitmaps, one
packing thread, two warm-up pairs and 15 measured pairs with alternating
build order. Values below are upstream/patched; total wall times are medians
in milliseconds, including process startup.

Case Objects Pack bytes Total wall ms Reword 3 / 1 421 / 215 2.776 / 1.338
Single file 6 / 5 667 / 553 3.542 / 2.744 ~99% of files 552,724 / 552,723
58,082,988 / 58,082,873 4,525.094 / 4,883.623

In the single-file case, enumeration increases from 0.758 to 0.982 ms, but
pack preparation decreases from 1.637 to 0.458 ms. In the last case, 506,468
regular files receive distinct small replacement blobs; total packing time
increases by about 8%, saving only 115 pack bytes.

These are isolated local pack-objects measurements, not end-to-end pushes:
network transfer and receiving-server work are excluded. Where redundant
large blobs materially inflate the pack, avoiding their transfer should
further reduce end-to-end push time, especially on slower connections; that
benefit was not measured here.

Most objects in this fixture are already excluded through the common base,
so the pack-size savings are small. The widespread-change case tests
inspection overhead on Chromium's directory structure, rather than realistic
compression of a whole-project rewrite. Feedback on this cost and the scope
of the inspection would be particularly useful.

Local verification passed t5322-pack-objects-sparse.sh (19 tests) and
t5516-fetch-push.sh (132 tests). Coverage includes identical trees, shared
blobs under different trees, retained changed objects, subtree pruning,
partial clones and local replacement refs.

Marc Strapetz (3):
  t5516: record redundant blobs after rebasing
  pack-objects: inspect selected haves for shared objects
  send-pack: avoid resending unchanged blobs after rebasing

 Documentation/git-pack-objects.adoc |   7 ++
 builtin/pack-objects.c              |  81 ++++++++++++++-
 odb.c                               |   1 +
 odb.h                               |   8 ++
 odb/source-files.c                  |   3 +
 send-pack.c                         |  30 ++++--
 t/t5322-pack-objects-sparse.sh      | 148 ++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh               |  43 ++++++++
 8 files changed, 314 insertions(+), 7 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2281%2Fmstrap%2Fsend-pack-inspect-haves-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2281/mstrap/send-pack-inspect-haves-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2281
-- 
gitgitgadget
