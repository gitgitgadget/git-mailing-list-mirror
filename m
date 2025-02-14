Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8E1A83F2
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574140; cv=none; b=eG4psUgAyopkXhmibzYEAAFG3pFzNEi5iZ6j2T15Ms85lEmQxoVR+d/NZWfC4aWOCyvCWRlrB6Sji+vG39j8tT4R278pZg8m6sTJaWjA7cj5SZoDXAlJV2Qj53OueXvynoWnbnvD7zqlFYJlIfhPylUY1j95k48i+gv7Sy9tjP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574140; c=relaxed/simple;
	bh=uZGtDtTkrBFYUS49ieBLNbZFZOpJ499X2dZQHbAoVbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGy9tVUUFaT/nDxZNceicxrZL3sHXKjsgAXFk6a44N8ZDXdeXj4z2+G7PebyVv0QOFz+5W/zUwoSuMRyuYFWoVYFNIdKQ7mqhUN55clcXcFAm02yJILVNnp9J789R299A3fO377cs/ndty5bh5QQI3uPRnIGn/1PvqgLs21g5GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0/9sTDz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0/9sTDz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8cf98bbso51511465ad.1
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574137; x=1740178937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPuyWmnkNmqm9XmNul1Nbxl2pfwJ44GQo7Hl5MjiLXs=;
        b=V0/9sTDzLGjR6lpz/BJU/JnMpb1/IOTZZ8yy9MoBXIQtBoxx81q2L28pdEMzsa7+SP
         ucho7aMX9EtXZGGxfezddPmsPrH0dGtDYMYRU3uYNi/Ds9KpN5ghj/MtVwBfuJqMPNlQ
         GWM+KSINDZRl7oaodZjAz/KSzmdcAf+0o3YfVhWTP98wFV7VZhEjA6OyBbnHyrrbXGeU
         SNRvYgINSlOLth1YRx6M9GHHa3jZLMpNP+F9V7EzPxWEMKDzAUqSxO6Ux3M6pOas7fWo
         pWJCwxGC/pK6/07d60Z3e0bVwAVrnoidZHhykZacr9vhb+rwwDDQ59W60XRozo/7H2+T
         Z+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574137; x=1740178937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPuyWmnkNmqm9XmNul1Nbxl2pfwJ44GQo7Hl5MjiLXs=;
        b=km25SfyCaMw+VSFh4X++vq418urT2RcDfbxUaQE4RkV6jrAFz7Ybr40tUQB8+AxAiS
         uEh1UtuZHrCSShQ5pijFhZg4O+i6q5E8qiGG4/fzWkD51cxp8aGx3QU2yMixQGUgDyB6
         NFbYZCfqCHnVF7GMhTqcwN+NTaCGagJf3viOFeYgJjfBpOwSHv0hy14zR4VjwMGRUmiJ
         bmxGhicY9kUUKwTTjU929PNiXIWWHww3Q1Y8k+zBGvkRCQKQXAQK+gDFrHfhUTDBI5PQ
         wue8ru8TE14g8RlpwBmYI12nF6mddRXzt6kTgdjUyyHOlK+tEL+0bZNMO2m3mUVlYezA
         Ej4g==
X-Gm-Message-State: AOJu0YzwZwP0DmckRzHraatRzdAn3XGh955MnmIXtXx+44UROFniE18I
	pd4agoq+ixGJr9SUsmJbPqrdV6Ha13+K/Lu9UXj3HDHpcfk0KUdIDTNjvUQH
X-Gm-Gg: ASbGncuj8py0p9WT1f152NBYwRRtDf8qf5hsTJZuWVtGihoVAE5r1ynf8SGimFUfVX1
	oKt17TUhAJKdK+R+9B/k/GaPNsduO31iXHEnA2uKyDiBMtZo6A0OtDE6E7KUR+lkrC6KtPFTdgG
	1XvKJojutZrOWQJtby7Y7WfBPHxgXfoSTGObrQrhCMnIbi2xzLmNF4qRaX4QD+i96TzH/bxIlCm
	P2p5MAs83+bhuSYRMXtnOAzht5D1lmAD2+TsXEi0s1Y/csnO9DZCC7c0EyreVuP0c14AKNs0NYB
	0Sp7l6WlrLDH2ITL9zqqWJinghtdpvGM+evAwhy8
X-Google-Smtp-Source: AGHT+IF6c0TIJNeOdoW1a3CbrwH5XFhb/HguYUamURWQnpElx/luWpyKs3r3rmYj72t3vaoueenaeA==
X-Received: by 2002:a17:903:2341:b0:21a:8d8c:450d with SMTP id d9443c01a7336-221040d11e4mr16406025ad.53.1739574136479;
        Fri, 14 Feb 2025 15:02:16 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:16 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 0/7][Outreachy] stop using the_repository global variable. 
Date: Sat, 15 Feb 2025 04:27:16 +0530
Message-ID: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `the_repository` global variable in favor of the repository
argument that gets passed in builtin commands. 

These sets of commands are commands that use only RUN_SETUP macro in "git.c".
Basically, When `-h` is passed to any of this command outside a Git repository,
the `run_builtin()` will call the `cmd_x()` function (where `x` is any
of the command from the sets of builtin commands that `the_repository` is removed
from) with `repo` set to NULL and then early in the function, `parse_options()`
or show_usage_with_options_if_asked() call will give the options help and exit,
without having to consult much of the configuration file.

As there exist some builtin commands where the `repository` variable is accessed
before options is given exit and fail, we should check if the `repository` variable
is not NULL in such scenerio.

Some, functions also uses `the_repository` global internally, so, let's
let's refactor them and pass `struct repo` as one of the argument. 

I picked some of this files based on the above explanation, how easy they are to
resolve and how easy easy to review. 

[1]: https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
*** BLURB HERE ***

Usman Akinyemi (7):
  builtin/verify-tag: stop using `the_repository`
  builtin/verify-commit.c: stop using `the_repository`
  builtin/send-pack.c: stop using `the_repository`
  builtin/pack-refs: stop using `the_repository`
  builtin/ls-files: stop using `the_repository`
  builtin/for-each-ref: stop using `the_repository`
  builtin/checkout-index.c: stop using `the_repository`

 builtin/checkout-index.c | 43 ++++++++++++++++++++--------------------
 builtin/for-each-ref.c   |  6 +++---
 builtin/ls-files.c       | 32 +++++++++++++++---------------
 builtin/pack-refs.c      |  9 ++++-----
 builtin/send-pack.c      |  8 ++++----
 builtin/verify-commit.c  | 14 ++++++-------
 builtin/verify-tag.c     |  8 ++++----
 7 files changed, 59 insertions(+), 61 deletions(-)

-- 
2.48.1

