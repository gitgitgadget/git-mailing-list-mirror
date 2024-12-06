Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA371D6DBC
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515643; cv=none; b=Sz/em5W+3Ohtm+6n58DC7l77NM/1L3kWShJjwqZMDgE3D/hypA7VIcDqajxvLH5NUhGAjspY9lDXQv8gaAKBrxw1WJ1aHGT6l7hFICyxMtIvYyAu250QJ42Db1MHRlNVb3y2GUbC612Y+jrursP+o5qcu2H9NLWU7coHvJatKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515643; c=relaxed/simple;
	bh=pSGPPC5mBiUzWT7O3UcmqKkolSEWySV+j4nHl4YBgLc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=o6RBbA98+y+b+em2EDyY24fOjEYh+rDZjW9bxPqnis96OF3GDhuuuO7ueshLfQ5IMlW234Yx3e8R5MVOFuhxhmSUJoCkyWQVZYy6a3VPBPCouugs2Gjp34da5aRHKVOnR26jZTF3E5mG25CtgsFd9RUB2TOinKPCuhs90k+fLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxxeJKNy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxxeJKNy"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385deda28b3so1900176f8f.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515639; x=1734120439; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o8c6+xLjx/xH84ucPgUs0SCOzMAGaT+Fxx2D4DbTKGM=;
        b=OxxeJKNyeLTO6yQZVRTqRshRcwLUhhIZZC9YAhRy0VYxWdYcIhc+4GbeKXymv7lD8M
         BXeZfrRsuvHEzHlZFQLHhtAXH9JzTbEVLTfn7fGQU9rU+nwlWQdFrY8Iva+6qeGM7ybm
         QVKzoYfOguJjzuNZVOA1CPb97Eq/8ivjzUsbcLJytCScDSnfnmooRqJPR6BbvnZ7blDA
         cBcOaTEascJxXxqKG2j75sdCGFY3pEELZqCfVgczVX/nwmP9nCWDkA4YwD+XOiDfhci2
         sh+gfsVXfxBsCADPvJLJp4Ug91voDIs1qTXjoQUqN9owtC9fXyhvezBnh1zfoAcY89F+
         WtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515639; x=1734120439;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8c6+xLjx/xH84ucPgUs0SCOzMAGaT+Fxx2D4DbTKGM=;
        b=h41KRlS7wMi0ug5uspCOHIVMrQn5oy0I4DqYTMhk3bhibsuTDl+cF4twqKCG4ZUk45
         jQOqHP/klg754fxoIzTt5sv1AHmkN9BPmMVVPihqBUM7OdA+KIAs++O3Kh6l/Cn3xi2A
         YMqE3qC+Yb4KZOFUmaijKYXLuepUH3uF+Lbvg4BZKvpcnQ6SgnHJ8FnGsGPEiycmE3ke
         rnLE19+fbPNJVDA+iSzzcnw2P/fonP52oJjDz5Sl1DB1IqdeqnYNCceesVBkDOwz10H/
         rB6vBnZwRVfL4D7g7K8BkiDx+lmyS6Ik2buV76HEbXOGoxsPKbIo8px00INVcDRmkBY/
         I6Dg==
X-Gm-Message-State: AOJu0YwVAxqN6REYV5/61S7JmyYY8n5TFaod6t9DDGEUx/4gf0U0LMws
	3sxyIL7OfJc0gR7yuMS6VMW3S2yyYv54BKBAka33l1Jq1qwCH0IXb0mXtw==
X-Gm-Gg: ASbGnct9v+GjyE3X9Efwis9Bdzaf9ezjI6f7IFAg9aVsBDcx1+OVNJnxXhpzenRSeFa
	QSnI8obw/uVCm/OhLvRorqrAu/9Fk395zsqYQSMVU+U+RBiBqWUPEa9KsDECIC2t7Zhv5QVauGd
	jgrIPP84+aiP8kbGauiMCRJcefGJSoGuEnLY6NicYymmf+SlB3yel9XiM+ZurHGqL2pDk2x9OfU
	jouKkTAtCGSZT+SjUuzBI9U+izAWGwoZxIlA7SCWNCDD37uXqg=
X-Google-Smtp-Source: AGHT+IEjq7SjfBLk3R8ykg26XVCX7K39mcvxC4mh6YFRBgbCU1gmWTYnVuQBTrolNbWl4WVLmm1+tw==
X-Received: by 2002:a05:6000:709:b0:385:e1e8:40db with SMTP id ffacd0b85a97d-3862b37b40fmr3822091f8f.24.1733515639386;
        Fri, 06 Dec 2024 12:07:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46b73sm5305896f8f.58.2024.12.06.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:18 -0800 (PST)
Message-Id: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:13 +0000
Subject: [PATCH 0/5] PATH WALK III: Add 'git backfill' command
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>

This is based on v3 of ds/path-walk-1 [1] and an earlier version was part of
my initial path-walk RFC [2].

[1]
https://lore.kernel.org/git/pull.1818.v3.git.1733514358.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1786.git.1725935335.gitgitgadget@gmail.com/

This series adds a new 'git backfill' command that uses the path-walk API to
download missing blobs in a blobless partial clone. Users can specify
interaction with the sparse-checkout using '--[no-]sparse' but the
'--sparse' option is implied by the existence of a sparse-checkout.

The reason to use the path-walk API is to make sure that the missing objects
are grouped by a common path, giving a reasonable process for batching
requests and expecting the server to compress the resulting packfile nicely
together.

I first prototyped this feature in June 2024 as an exploration and created
the path-walk algorithm for this purpose. It was only my intuition that led
me to believe that batching by path would lead to better packfiles. This has
been proven out as a very important feature due to recent investigations to
compressing full repositories by doing a better job of grouping objects by
path. See the --name-hash-version series [3] or the 'git pack-objects
--path-walk' series [4] (currently on hold as it conflicts with the
--name-hash-version series).

[3]
https://lore.kernel.org/git/pull.1823.v2.git.1733181682.gitgitgadget@gmail.com/

[4]
https://lore.kernel.org/git/pull.1813.v2.git.1729431810.gitgitgadget@gmail.com/

This idea can be further demonstrated by the evidence in testing this
feature: by downloading objects in small batch sizes, the client can force
the server to repack things more efficiently than a full repack.

The example repository I have used in multiple places is the
microsoft/fluentui repo [5] as it has many CHANGELOG.md files that cause
name hash collisions that make the full repack inefficient.

[5] https://github.com/microsoft/fluentui

If we create a blobless clone of the fluentui repo, then this downloads 105
MB across two packfiles (the commits and trees pack, followed by the blobs
needed for an initial checkout). Running 'git backfill --batch-size=' for
different sizes leads to some interesting results:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 105 MB    |        |
| 5K              | 53         | 348 MB    | 2m 26s |
| 10K             | 28         | 365 MB    | 2m 22s |
| 15K             | 19         | 407 MB    | 2m 21s |
| 20K             | 15         | 393 MB    | 2m 28s |
| 25K             | 13         | 417 MB    | 2m 06s |
| 50K             | 8          | 509 MB    | 1m 34s |
| 100K            | 5          | 535 MB    | 1m 56s |
| 250K            | 4          | 698 MB    | 1m 33s |
| 500K            | 3          | 696 MB    | 1m 42s |


The smaller batches cause the server to realize that the existing deltas
cannot be reused and it finds better deltas. This takes some extra time for
the small batches, but halves the size of the repo. Even in the 500K batch
size, we get less data than the 738 MB of a full clone.

Implementing the --sparse feature is best done by augmenting the path-walk
API to be aware of a pattern list. This works for both cone and non-cone
mode sparse-checkouts.

There are future directions we could take this command, especially to run
the command with a user-specified pathspec. The tricky case for that
additional feature is trying to make the path-walk more efficient by
skipping tree paths that would not lead to a match of the pathspec. It would
likely need optimization in a small subset of pathspec features (such as
prefix matches) to work as efficiently as possible. I did prototype a
version that puts the pathspec match in the callback function within
builtin/backfill.c, but I found that uninspiring and unnecessary for now.

Thanks, -Stolee

Derrick Stolee (5):
  backfill: add builtin boilerplate
  backfill: basic functionality and tests
  backfill: add --batch-size=<n> option
  backfill: add --sparse option
  backfill: assume --sparse when sparse-checkout is enabled

 .gitignore                                |   1 +
 Documentation/git-backfill.txt            |  60 ++++++++
 Documentation/technical/api-path-walk.txt |  11 +-
 Makefile                                  |   1 +
 builtin.h                                 |   1 +
 builtin/backfill.c                        | 147 ++++++++++++++++++
 command-list.txt                          |   1 +
 dir.c                                     |  10 +-
 dir.h                                     |   3 +
 git.c                                     |   1 +
 path-walk.c                               |  18 +++
 path-walk.h                               |  11 ++
 t/helper/test-path-walk.c                 |  22 ++-
 t/t5620-backfill.sh                       | 178 ++++++++++++++++++++++
 t/t6601-path-walk.sh                      |  32 ++++
 15 files changed, 488 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-backfill.txt
 create mode 100644 builtin/backfill.c
 create mode 100755 t/t5620-backfill.sh


base-commit: e716672c041473dd2bf257b7532b86696fef32a0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1820%2Fderrickstolee%2Fbackfill-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1820/derrickstolee/backfill-upstream-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1820
-- 
gitgitgadget
