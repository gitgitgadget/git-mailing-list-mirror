Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A847301470
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127224; cv=none; b=eECGwQa0YuNdu8qe1q813gxqbTR34vx44lcpwMZtB2P6cf8LzGhK/EJN1+rlJryhMqofR+JsboWS9HNk0ATdmQmY5DlfI5KXrwr6ASzornigPBVSVtUvcRE+VQ2dtDWQv/7jUQxssnm4sgwfgmP7BvWrbFmvEKGDgtO36BYR/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127224; c=relaxed/simple;
	bh=VPQELEps5qrXPYOgBeG1zbTLg396Dh6aD99qoTBPtkE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d/ufnbQHMeouGKzGhI6PpMTHpf7HLFy4/KnZHRuMu2n/sypLo2fc4/JXqhmPVjStAK6NaLvWUPDvlB/pef/9tA5z77t26vU2Se9iVVZfbH9obINZPkMD3Cy8gZJHmg7/rFUtRIpQjwk/CGxfAnrw7xbgwANtPiD5934mHmijBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdVsF7wn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdVsF7wn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so2121275e9.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 16:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755127220; x=1755732020; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0WzpEBDMZtNiB7er+D0M0myg/LPBSHoeXgXHljm5B8=;
        b=VdVsF7wn3q5zAIrtarhazz/ahM4ndrkSdGhS+Wkr6M55nSkU38WcUz0vCZe/fTV3rA
         cVPRADmkeEJZcxhaz0Mn8tumPXsPrARTB46RFnW1Bw/1ovqveV0Teh+DxIQR2wxf8O+w
         /gYLz/vpgoc+ceA+ztl/BuJuxGyr/vMH2QlrSbCz0d3UQEOTpKPv+J/r52koNszAKsJC
         HH5mnmQ82AconhG+7QARyQ84oLUDuWdypdsvaD+tokS2V+p8QK6EQKTIsLezyYTqVGvW
         3o+5dHruzKtFpvYPSXE+yXJLC3OLBuBMpio15joJlIrvFzxRFPGNhuxO6mQfnZseHKZE
         Jy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755127220; x=1755732020;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0WzpEBDMZtNiB7er+D0M0myg/LPBSHoeXgXHljm5B8=;
        b=YoZhiLd7u2GQP664OPQNABBTV7BgMda524z5iuKmcLq7U5hygxehAqca8Y45HTkqH4
         PRZ2xfqYgfGXAKC1Rqc02gVe88UMvZ6pQ6A9owLFDmJ35aBtpa3C02CRUxmsN0QEg0M6
         w3nL9UVFpH6TDyCfuVpQoNmrP5UfeQl9+vlEmOaWleM6+P8ygH0T2CUiuDCeaI1BjdYU
         8U15hBbW5kiB9m85Zx2falbDiOvA7eKyJKWmUp/oGDd6bVtRJr4EhZ2ZUmnEH2Y9Qhgo
         hKlPkKNh3LZi8Nb6q3xFDUpD2vxLXLT8UoPQgg0o/xuieoWqhwUHRoT8tnm0b5eN4HrM
         L3WQ==
X-Gm-Message-State: AOJu0YwNi5Ktxa9fXCiUhtkHljS2qO2f584sCtcP9lkjNA7/ojHzbx/Z
	YB4K9XsfqUIGF1t7V/XrGIVDjuqYIJEqkXP2yIuil3oCSbfuQowhTBGbpIYj7Q==
X-Gm-Gg: ASbGncssQeMKSpJ7xnmnHKezvaLU+9DXEZ7JjaqyE73OIR9MXrvbFRpjzzWP2lEtnb2
	aEJkrmDm7sRTwnGM9n1KcFMRbub/QZe7eH2iY5NGSip/s+DNym7ew20z4eBXqBDqRuSO0pi224l
	HxJhO9kjmJodlDvdh3kDeq8ptDjPFpOEmUqtc5XaQnYxyw6nk7MWQHCwxXcRiHM5pCFtRqW78tv
	yhTvYaSMAe5lM3LUCoZr39ZgZPUziLTX6fdQJP/dVEhtFqlVQ0/2fBrHkJyfKI67DUredbFd+QV
	Rr3kB0vu36LmFtx2tqc15jnB/55QB/SeBa0bt3gWhLXTJd482BGj9VLVYxu76/HDUBoGJR374vO
	EjwZyngCGcPqRrN16rd3IbSY=
X-Google-Smtp-Source: AGHT+IHvmMsjPGlBlbDYRBpvVyGK8u1XoSOyiWc6Nc00gkEuUDm8t+/MRPaHiBm3ocHwYai+8YSSdg==
X-Received: by 2002:a05:6000:2508:b0:3b7:78c8:9392 with SMTP id ffacd0b85a97d-3b9efa99e59mr623764f8f.19.1755127220116;
        Wed, 13 Aug 2025 16:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b91b05b28fsm2799729f8f.21.2025.08.13.16.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 16:20:19 -0700 (PDT)
Message-Id: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
In-Reply-To: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Aug 2025 23:20:14 +0000
Subject: [PATCH v2 0/4] doc: git-add: clarify DESCRIPTION section
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
Cc: Chris Torek <chris.torek@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Julia Evans <julia@jvns.ca>

 * Remove changes to SYNOPSIS
 * Add a sentence describing what "the index" is.
 * Shorten the terminology note
 * Say "The git add command" instead of git add

Julia Evans (4):
  doc: git-add: start man page with an example
  doc: git-add: simplify discussion of ignored files
  doc: git-add: make explanation less dry
  doc: git-add: explain inconsistent terminology

 Documentation/git-add.adoc | 64 ++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 31 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1952%2Fjvns%2Fclarify-add-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1952/jvns/clarify-add-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1952

Range-diff vs v1:

 1:  3a2cc38b72f < -:  ----------- doc: git-add: remove options from SYNOPSIS
 2:  310d2c1d8f7 ! 1:  d041d09589b doc: git-add: start man page with an example
     @@ Documentation/git-add.adoc: git-add(1)
       
       SYNOPSIS
       --------
     -@@ Documentation/git-add.adoc: git add [<options>] [--] [<pathspec>...]
     +@@ Documentation/git-add.adoc: git add [--verbose | -v] [--dry-run | -n] [--force | -f] [--interactive | -i] [-
       
       DESCRIPTION
       -----------
     @@ Documentation/git-add.adoc: git add [<options>] [--] [<pathspec>...]
      -after making any changes to the working tree, and before running
      -the commit command, you must use the `add` command to add any new or
      -modified files to the index.
     -+Add new or changed files to the index (also known as "staging area") to
     -+prepare for a commit.
     ++Add new or changed files to the index to prepare for a commit. The
     ++"index" (also known as "staging area") is where Git stores the changes
     ++that will be in the next commit.
      +
      +By default, `git commit` only commits changes that you've added to the
      +index. For example, if you've edited `file.c` and want to commit your
 3:  3f4ab615069 = 2:  63c9e0361dc doc: git-add: simplify discussion of ignored files
 4:  34b09deb61a ! 3:  ce1eafb0286 doc: git-add: make explanation less dry
     @@ Documentation/git-add.adoc: You can also add only part of your changes to a file
      -adds the content of the specified file(s) at the time the add command is
      -run; if you want subsequent changes included in the next commit, then
      -you must run `git add` again to add the new content to the index.
     -+`git add` only adds the changes at the time that you run it. If you edit
     -+`file.c` after adding it, you need to run `git add file.c` again before
     -+committing.
     ++The `git add` command only adds the changes at the time that you run it.
     ++If you edit `file.c` after adding it, you need to run `git add file.c`
     ++again before committing.
       
      -The `git status` command can be used to obtain a summary of which
      -files have changes that are staged for the next commit.
 5:  f7e8e4c63a1 ! 4:  9e595f9ad59 doc: git-add: explain inconsistent terminology
     @@ Documentation/git-add.adoc: exact filename of an ignored file (e.g. `git add ign
       add` will fail with a list of ignored files. Otherwise it will silently
       ignore the file.
       
     -+TERMINOLOGY NOTE
     -+----------------
     -+
     ++[NOTE]
      +Git uses the terms "staging area", "index" and "cache" interchangeably
     -+for historical reasons. Many commands have flags like `--staged`,
     -+`--index`, or `--cached`, and they all refer to the index.
     ++for historical reasons.
      +
       OPTIONS
       -------

-- 
gitgitgadget
