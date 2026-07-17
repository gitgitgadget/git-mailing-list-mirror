Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F837C910
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295064; cv=none; b=h1f0OOBwz6m4g0AoEfu2ZbbdAqLRI+AhMOHHoWtggB537OHzdjUxNF+/8iRGlB00UKBlFnKZNKhzxeY4g8uewq/MmnDatHFNkM3/RicBVRZ/zQdwS6YUNbdL+QH0XgWcxA/02C9dNf9F2n0tat2UKqTrucCVl/yIPa4Ayw22hUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295064; c=relaxed/simple;
	bh=2dEDR5x8CwivEhttnuNsNHQlxfPhICfsP5QV3Q5ZboY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJxVC1sj7+cLULMjvWF0AnhpvXN1x6EhqBpR0V7JOtKf+EL67Jf2ZnzV1bByqJrs3DyzHcQjnRIKjIt6gFL+WWAlkH9RM7f+APleWxChovgMVI57BMyCdRN8OiEuji5ow1eUqmmMrTiuwAdyeX4OMttwwj48qqyEWYFkABDCBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=My7UcWOt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="My7UcWOt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c7c61b5292so59523655ad.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784295063; x=1784899863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1HkJAvEM/ZqxEH0TMe5u2IwUgMcaKkZy/PVidfRgOK0=;
        b=My7UcWOtlc9NW3Fy3g9Vvvn0hj7Ztocjx3pIhB54DB4hzZD7yv6Y0jyTqaG9s8zI0O
         43minKxLbo/xETOBZ0DpYnG+7kthYPqRArRTN1+zhRMGAA7jCXHhf7CNvSzX6ukOC4od
         +9TQgDbxaG+WL7tCt3Y/YgUCAh43x9o44O+eOmITZLzBdMyQdFxLEA54ZovM+OvFPBSl
         6rDxBRFFUYON2xADYq5CWz6h7Q/RrQTNUCstv5byjr1d8QkaCpJpJL8tc7srgsugBr2p
         8fhAeaYbjmq5QJ4RXneewZP0XMq3KXZaQF1TuYBcNpPVpCzoXGSBtl897/vXM0Zpw9Pn
         7b1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295063; x=1784899863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1HkJAvEM/ZqxEH0TMe5u2IwUgMcaKkZy/PVidfRgOK0=;
        b=FGgW+/5+lvOrMaYpFzhPs6+85c33feBL03z6HH+tw5mfFyyH6c6JL68cgELQiBFIMf
         7X6zoV8EMMymOsRQQ6b37PztWOsV4Yeb3YvsdM1HtiACbysYbgbueY8r6BLyNdXX6NPy
         omm6fSqxRtlXFjjWodBHHg5Gyaeici0rgeiRSrEILPEEF6H89v43SyedaXa6eVkdnITw
         WtOsnaSixwsusetmLSD2T1Ew5fOlEQ6Lz79oK1bcQ8GSNWcWRgCchdeTJWGrtuQmY0LB
         o3/4XXyuz7rQRKRVysGECsGGo8kmIFjbKoFVAbHRuaUpXQQmvAtuAwd6tKwLkOmOpTck
         gwuw==
X-Gm-Message-State: AOJu0Yw5AzvKUoYe1/phGWRuKjNyXi6E8pez4fbVYUqpjMrOkwfzwoLw
	mDd2BoZ/hocrL3koizVddIxQ9jN02VsyN5PbXoJWVzD1tbJAe5PPy304
X-Gm-Gg: AfdE7ckknQVtC8WZ1pi+jty/IJA6sRuTUVVUsXr6XTE87CtmrI9MQcZF/udR0T556Cd
	enFmbEIhl9TTCP9pohEcfxmHzYpy5+3knKIHTowEEXFszsAp0wXDNjFd9owPw60bWYEdFk7Lv5T
	mNhDCdDeoH3PVqKieaOQnRlOSkZjcSQm47R+q2jbgWmcwzEbmIHTURcez+BrVlc+0xaTaxAqlG8
	zS4+tyUbqLVnhlys1YJuhuDcS14HYjmn4M3L7t2llRXmMoVkfFR2xJNghLBMaUmZoPnWiwO5bOK
	mq2QyN0fZFR4O6Qd8aEBeA/bgQffKQY3g1lNW2Ku95f5jV0bBrVdN9o0VNmb9RLwRIv4X0ySG4E
	OLRjR7PJLiT6mPGKn+J2OwrsE2VYIZ3rD5xjcdtwUBg1KH/3nd/vcfgnfn0WqyIoFKJHEr7Txqn
	83Q2NIj23JyS9VczsKWM0PKYicFEf8754kHd/dJ/niNCb2zR64KAah3WSwEwvgyDSEpiEBUhLJV
	SzMq/AOINcf
X-Received: by 2002:a17:90b:3943:b0:387:e0db:3fa9 with SMTP id 98e67ed59e1d1-38e4b5a8246mr2922699a91.34.1784295062651;
        Fri, 17 Jul 2026 06:31:02 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20cfe3sm7867411eec.30.2026.07.17.06.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:31:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v2 0/7] repo: add more path keys to git repo info
Date: Fri, 17 Jul 2026 19:00:08 +0530
Message-ID: <20260717133015.32040-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.
Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-working-tree: superproject tree from submodules.
* path.objects: repository objects.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.

Keys support suffixes for format.
Commits contain documentation and tests.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-working-tree with absolute and relative
    suffixes
  repo: add path.objects with absolute and relative suffix formatting
  repo: add path.hooks with absolute and relative suffix formatting
  repo: add path.index with absolute and relative suffix formatting
  repo: add path.grafts with absolute and relative suffix formatting
  repo: add path.git-prefix path key

 Documentation/git-repo.adoc |  58 +++++++++++++
 builtin/repo.c              | 166 ++++++++++++++++++++++++++++++++++++
 t/t1900-repo-info.sh        | 108 +++++++++++++++++++++++
 3 files changed, 332 insertions(+)

-- 
2.55.GIT
