Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793522701;
	b=2tXA4QpW3YoMh1pcx3kZjENGvitC3nYvNFwfqJDcTBV6hp+tSTyyC7FPsjV9W1wqtSTQ
	 Of5cTqViW//JhLcZ3D6/ndkfYNBtI4bjQMGPNpxZnbh+DoqOasijI+/qLsbISuO6MCVpw
	 N4QOnUyB1/XUWhsf0saTFg6h5fdx8Tl5A+YGll0VFRZP4MIwwJD3jeWhr1YHIkb2gTqA2
	 PfW4Gp9KZ/uqqGmncDgwnOq4TDrtTtA6rfmcP/Qo2xxhN6zLTYkCToG8gqe3elKQtp689
	 CTtCpLKQD+wQXSwmWqHMVtE72vy9TQbhqmWoNoZjexqbopLmr7vNKIVZo52GhPcIhRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793522701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HG4jSdlIW6vaY9/8cWolqytCrm6nbtCOV9zrhEfw6l0=;
	b=O76/jaafSTVSj3cMGW/2VQaZai9atMKChabSG+ePboYQX+ZOXuhSd/EO4He4jiJ41dfn
	 /P5fd+vXV0pp+jVHU4lmYQazwCM7SDBrCRVf/eo4pFVBWcUNx404KN97MoCbOfqev5TI4
	 1RwNQJezHqSjrwwBt3ppXXY0zPczOauLDLLbKFyPtm1vP9w+Rj3miIKWq+4l6SCbPcs5x
	 ouTutm9xSdcYbn7jB6+BsloNBv+Vu9fzExVAw1hBvCdxZ2Y//hrvkWMJqmpC1Syv+yczu
	 hnK1rNGFIbCaQJD+pBnK2J4kWe2gViz5cB8TDdWglyeeVygJiVhiQi4jSYUooyECWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kj+3thyF;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B4606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kj+3thyF
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1698009f8f.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793522700; x=1794127500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HG4jSdlIW6vaY9/8cWolqytCrm6nbtCOV9zrhEfw6l0=;
        b=kj+3thyFLsEQT9p9mWdsLexgZ00Y6odaz4b9w8y+wcWBOFyXSboTuSX+vUignzDgO7
         wyo36OorFRf5fdRp6njU1fNn+TpJxgl8xy0MZUAgzzENZtRY2QyM6im6vdc3FOC+DnzP
         S3Kvoib8zI65XBoWJNabGfb2A/3BQ5HiFxgknfpDQVJfltro/zLBFECsmmEG1UAnOdoB
         slfwnD/k4ZwF+r/y3g0MR+mP0PTFQIV5hscSe5x2kpdSCKJH23tkpXW9J6lLSXR654yr
         YfGgu1cqz6u12Slvl8TV/+bYmfJC+ETBUWVjtpHuS2tEiq1b5hd8lGrhB8Zm7pSncB+3
         Xwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793522700; x=1794127500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HG4jSdlIW6vaY9/8cWolqytCrm6nbtCOV9zrhEfw6l0=;
        b=eTl11wqZ7MEyJResuLMFygBstZhcYBv5Aso/P6SDoXt4Rwz9oBbhaCFq+D2FAOb4bj
         fkdC6xGxKyqlDlhHVGWiv/w05fnDYcLCYMdZX/jL8As1BkEHrU2ZhphxOI5z+wo3xsLT
         4j5I59btyjsto0MyFNroVYbgoB0HWknoYmQhQRV21g2SS2SV3FMgOv7plAvkKWA0LpVs
         YHR+9ewVUrwtD0y+sbiNuFOgRZ9h1lpUCU/iCtNljSe9sC/GwSFoqC31faY7JSNYC1OI
         ozlM1Z6Tc0XR3wnz4Ur49c4fhg7sn6YRr+UtTq9nC0J1zUxOYnDoUkcdlUhO0Eize1+t
         PP4w==
X-Gm-Message-State: APuU4Z+/DEHT2LSeCeCD3Gof0jBA+DY+gmgOOJVzI1zUVNKGwRgglEHu
	0Yj32OxZKfXPAMI+0/wicEQCggAGNsw7sQ85aRyPY7xIMBECeVu1C/gqe45UZNM4
X-Gm-Gg: AYBFou0aw0SqnLgD3oArV7cki/ncdTAfiXdtIvCkSZonihJVYgt+vohzLO2wY7vtrRC
	4IoUCh5/tN6UkwWU1zN91QFMcqnFCOGqEBe+ZysiUIEdXIF0P5VZb1EVTdhX7ojbGu2WxcxCCB9
	4VQEnTXVVz6nl9e+XRc/qpMBGQwE2UuGWHPT/jaKWTCGC2+FaIM1Lk3lYVmIFrt1qet8jEr2puQ
	EcG9urmXaRk50LXZeLsa0g5ZgKOjenQPIj1ika9B7y99iAgehGCNQlE8mopAfKHS1mGJOwGmKgQ
	G8uogB74JZhXktIkDKfifEKKpXpnOdUnnHD4uY/TMIdJAXKVceKzxNqX4m+3bY8WknWr7fNU6wP
	DbqD0kcbskhPXbzoxQteS1tA7XPkdU/9s5aku92qBHMlBN4ETEI0a+n5gRvtlCfqVgQD6CC6WI0
	S7JYDVK3Ub6n8nVTbIrCXHdXhHu/Pm+8vdJczAz0ugSzZct9l6tCGPL5EyZ6AXoll8z5UTmZK8R
	rI6RED3qldYwM5OfzpUUqtXL4/SZLbuboDxXBd5L7fGHULGhBhul50fcZZpQvLG/FrmgpGz0B7P
	8G/vhcZOHE+47H5l5i6dIsh2MO8SSByPVPmhj3VG+5VRCjmbx1Ea0I3XpglRlkw=
X-Received: by 2002:a5d:5f85:0:b0:487:21be:dcc6 with SMTP id ffacd0b85a97d-48e6e5008a9mr15314407f8f.21.1793522699594;
        Sun, 01 Nov 2026 01:44:59 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80ecbsm13330965f8f.35.2026.11.01.01.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:44:59 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] grep, diff: do not silently truncate sizes of 4GiB or more
Date: Sun,  1 Nov 2026 09:44:55 +0100
Message-ID: <cover.1793521916.git.gitter.spiros@gmail.com>
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

This series continues the search for truncated sizes on platforms where
"long" is 32 bits but size_t is 64 bits (64-bit Windows). This time it
covers grep and diff, where a file of 4GiB or more produced wrong
results without any error.

- 1/2 grep: on the working tree and --no-index, it silently missed
  matches beyond the truncated size. Now it uses size_t and works,
  for blobs too.
- 2/2 diff: on the working tree, textconv, --no-index and combine-diff,
  it produced a diff of a prefix, and a patch that truncates the file
  when applied (as git add -p does). Now it dies with a clear error,
  like the blob side already did.

Of the remaining -Wshorten-64-to-32 warnings in the diff and grep code,
these are the only reachable ones. The others are in xdiff internals
(inputs limited to MAX_XDIFF_SIZE, 1023MiB), in buffer_is_binary()
(which looks at 8000 bytes), or in places where the size can't exceed
4GiB. Widening diff_filespec.size to size_t, so that diff actually works
above 4GiB, is a much bigger change, left for later.

No tests, as they would need 4GiB of input on such a platform. Both
effects were verified by simulating the truncation at 16 bits, and the
commit messages give the details.

It doesn't depend on the other series in flight and merges cleanly with
them. Based on master 50fe5cc63f.

Elia Pinto (2):
  grep: use size_t for the size of buffers to search
  diff: die instead of truncating sizes of 4GiB or more

 combine-diff.c  | 11 +++++++----
 diff-no-index.c |  2 +-
 diff.c          |  8 ++++----
 grep.c          | 16 ++++++++--------
 grep.h          |  4 ++--
 5 files changed, 22 insertions(+), 19 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

