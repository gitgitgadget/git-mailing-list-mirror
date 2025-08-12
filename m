Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6441898F8
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006574; cv=none; b=ApnF3H5Wtk685WbsL8aqZRS4Hd2q97TLXHoubEbNL6erD9mTABBP02wqhNPB83NoLjg5hVta3h08/UDlH76DnDEPcLjt/yfw74W+aQoHPVr8uZtcs0iCpEpfNyUuiCw90HnoP2++aHu9OdoqHdjLsxKwgU5LkiPcuUvh/EKAisU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006574; c=relaxed/simple;
	bh=GuMCqbSSAosZlgaRr2oW499tp++syoK0nfhdibuzzG0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9lyWvxcu46hJV797YjTy16J8IrusGMRFJN4/LYrclVEC3ETFCdU+bX+hOViWwzlUREpPSibue5g3XddWi6kW3VXRGQZ3jr3LqtGmzgYC/JrBx8nWybuM5U9RnZEcjoTnUigmWxU3NQFG8F+QfDYlKcJ8AJVQpUtrMTPSkYJZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddA8vyo+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddA8vyo+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so50161825e9.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755006570; x=1755611370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp1Hh1sJ5o+zhRC941Qbico7QvxWzvB5aERweTNmrEU=;
        b=ddA8vyo+on2PMjWV+qqV/xhzGjxf2osf4M+PUOBuHitEj4bMtKttpxUz40wx/EVUEM
         rv2KqoCmOObXmfGen30tw0N6kUmYzETf79UXpKfPIZLmR+Csh7Rml1oOaSnqxQrR+n8W
         W3TalXcMhtXnQKorTBY/RtPu3JYCdAz6HeZCmCSr8IxvaKwXJCco7qsOJPWYXJLcOrpE
         us/03K6SgyWSPqdZHyKQsPyWbeRXk85Z3eKBdwdgGf3OO4uKUI0y+3KyJobIREe/w55d
         urqLtvUMVgeZZnzxPrg5G2hbH6t2BNkAYopJ3hpt4ShdRoYLS65v3hYTNy8mm0P6z0kc
         tB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006570; x=1755611370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp1Hh1sJ5o+zhRC941Qbico7QvxWzvB5aERweTNmrEU=;
        b=IDvjRn3BZveZRBAMfPqg21F8SBhOfGCpnyOza6Tt5LB3jIy6bPZnCAxzZkR0ssL24E
         Ua1giYkFBp1+zDKS8xcT39nH50jCAWDhBwSmJuQ4tbAjBVN9DvBJnBTVVH6Dvap+Qffw
         P9FrA+sTEmJXUcaJ6U+tW8KbzqK86z/Cv5vVZYzxE5PQoVqo2OF5NVWn/WH6PK1SUH/A
         MpkaJ8jYfbvQmtMTmGB7hwrCxNQXgNcWAM1P7I4nM6piyMP6h2cTOdUSnu2E0L487dfP
         o5JCZEaM6vlxwGWJSgAffMBGtXkccPImipXoXMXtoAkvdmyZ6KcW5AQ7FTXyyEc0dUyK
         yC/g==
X-Gm-Message-State: AOJu0YxdC/KUsJ9Oe39SFWmKY0Phet3gaOoBLjQiB+XbIrLYskZDSa6b
	CyYU3O9Umz+8WxzNBhpGT1IexPsuZfLe39Kxx3/Qx+MYp7bkyquFiQSC3W+Hjg==
X-Gm-Gg: ASbGncv5wUmHwjhwpyHkrM3Kr/sb3ygHw7+HpHNRnOHKfd0FfStU4MWgG9xW5nAwFiu
	/UVucQgxVI4k1qW8zKv35pZP3QFuzg2WEu03yJA5oE7HTZn1j1+zP7PFjz7xnXKSwXmuYk9ub0X
	KPsT6bRj+LzVkeKM2wJDdjvErcuv2n2aDKi/pxb6r15tPTa9Js17OVq1XXwBQXSFK4XLbHmSaOt
	Vt45qKskKXZmuyjNCe3DcC6FXLI3ub5Mzaq5d3ny8qdefTuFpDccEmFmjPIZUrqsN6YtwAzhSWE
	ZXrWbSVKFyMBOAZcPiSS3SEe6sbOZMvUSqFNUlrV0ocOXAv4x3ar1urmrM2kw6zVz7THrDsyPBF
	7s3lo5mSySks4FjY3AndIjO1defa9393iXQ==
X-Google-Smtp-Source: AGHT+IGAaJCrZ4GltiAuWxE4tFRaOiC8rcOs0lmgws1ukj2a6GzmqwVLJqvMeAXBy2Jvf+g/Hh/tgQ==
X-Received: by 2002:a05:600c:3b02:b0:456:1dd2:4e3a with SMTP id 5b1f17b1804b1-459f4e9e620mr161588555e9.3.1755006570034;
        Tue, 12 Aug 2025 06:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453d6esm44165063f8f.37.2025.08.12.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:49:29 -0700 (PDT)
Message-Id: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 Aug 2025 13:49:23 +0000
Subject: [PATCH v7 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>

 * Rephrase "duplicates of commits" to clarify that in step 2, rebase is
   using git patch-id (or the equivalent) to compare commits instead of
   using the SHA.
 * wrap some text correctly
 * s/git checkout -C/git checkout -B/

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 304 +++++++++++++++-------------------
 1 file changed, 138 insertions(+), 166 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v7
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v6:

 1:  e7a8fbbe53c = 1:  e7a8fbbe53c doc: git-rebase: start with an example
 2:  ad63f69918d = 2:  ad63f69918d doc: git rebase: dedup merge conflict discussion
 3:  7ee6b0afe88 = 3:  7ee6b0afe88 doc: git rebase: clarify arguments syntax
 4:  4686417b28e = 4:  4686417b28e doc: git-rebase: move --onto explanation down
 5:  9c7f2716bc8 ! 5:  79f29ad1e68 doc: git-rebase: update discussion of internals
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
      +   off from `<upstream>`. This is the same set of commits that would be shown
      +   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
      +   change how this list of commits is constructed.
     -+2. Check whether any of those commits are duplicates of commits already
     -+   in `<upstream>` and remove them from the list.
     -+3. Check out `<upstream>` with the equivalent of `git checkout --detach <upstream>`.
     ++2. Check whether any of those commits contain the same changes (according to
     ++   `git patch-id`) as a commit already in `<upstream>` and remove them from
     ++   the list.
     ++3. Check out `<upstream>` with the equivalent of
     ++   `git checkout --detach <upstream>`.
      +4. Replay the commits, one by one, in order. This is similar to running
      +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
      +   are handled.
      +5. Update your branch to point to the final commit with the equivalent
     -+   of `git checkout -C <branch>`.
     ++   of `git checkout -B <branch>`.
       
       [NOTE]
      -`ORIG_HEAD` is not guaranteed to still point to the previous branch tip

-- 
gitgitgadget
