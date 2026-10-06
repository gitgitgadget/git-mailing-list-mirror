Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316226AA91
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791270509; cv=none; b=ne869tqn9Y1bc5q2gDK5kAcrdXnOXeNtPkqHr/jf0edKRX64g7XMqpZstVpsQ5BjicGAm/Vt0rMHI4ENmxHwxi8M7LHPd9xiW82Q0A+6ordzNGZJtzciJpqdHLfV4B+JAeFtN9xXDtm8jUGmXp3pMjNZuOYPwWGVFKexNddaiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791270509; c=relaxed/simple;
	bh=YcRfKRla7NUGXPVEcidLpflw9fyUTWbj6CxDRr6DFcM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jnAMZRXFILfFiYzHvW2/XguJ0SmLBFVUJG72XaftK91PpIN447xfRGUoezvnvuZbqGsWzAOyLdbL1t80IHmXbPlOYpVs2kKgROOuOxvwPFmVjFbQ+L/7uzTGRLL5i3OGVvzFELULHyWtQiTHwgErFQtm9QZ1TD3YLuseUbs0+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA33gMSi; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA33gMSi"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-823b938464fso2205879a34.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791270507; x=1791875307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3jqJSDeMclpbUPOnl+GvqosLAnd+ljnEUj4eyNSF9iw=;
        b=mA33gMSiv9zQe8gR5vreYvQyFd84UKPZy4iEC57nN8akOng3nvE8eGXfJwQAtbrPI6
         mwXKwfVOR22CoWkwRH7gTZEX4RYOpFblK5Cfl594jkCe969Si/A7No5JnabXNEIOUNRD
         M1vmIp7xi6oDT7EheeQ8s1bCidtRaIfw2Cl8HIcwMPrjseG3i59y09Tz4aRzBbFEPRdF
         Ow1XC+ZVMePcNgSJ+q1z9lVymcytjfgzHVkoP3eZwx/gQecTY2U5WgUs9T5D4sgzIBRP
         mMmdK1KXSWThbWKJBCMasA+aDsTcOHEY0X9LwTCB7H0g7hCmy4EQxVw+uaiE5AjJSRGe
         5Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791270507; x=1791875307;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3jqJSDeMclpbUPOnl+GvqosLAnd+ljnEUj4eyNSF9iw=;
        b=2KI3Cjzdv9UKE9jw6JT9Y/qqCPk7knWsJ0UZ+K53bCrfjfYpEQQ1JLVt61a528dJUl
         KleyT1xX16nCoRW+FRmpo0qucRdMmMZKDzehnfctxwlzRQ3CGIC1ReZ5dcOZSQDGBDzJ
         4ZEt0ubNWuPvivCXUGvb1BMSua6A3g8f8gjsKM8Fp8Mm9kpnxMD1uUVr4CeaVG55Cyvq
         YZgdf/G7go5U4bBJm4B1KOWboR01nin5yW/aTRadwKK6NTbahJmSgi09FKXstEBJ82d6
         gd5s0pjeZsLuyutZSWOCsIOCps+j0OgtQv8GNeBjL/nsMOpeO4gwkZUoVmZ9v/zIhyKO
         7gOg==
X-Gm-Message-State: AFuF++m4TnzoP0LiRPWBr/N2qONZlPOUzV7q7tbhrAgFGO74arRuX4dq
	rsxUSlcS6aw/tLrBueJmjOX3dhgrvWnFzJj+VuJ3dzPthmb9mpc1+nFr6LQx3Q==
X-Gm-Gg: AYBFou2m6DMhNd6Ip5/HGp0vZ1brWaVzjpmDBla1yPZp/GYAHB4I48O3D+ipbY0pybJ
	VXtv3QK+ud6marNv8Sjnb+A+dTIB/zaPOnEYdsBhsvsT4bFque+GxkGvrfg4b9tb/skxy560QGr
	vra4tQziCnj+UuqfW6rXtGd2NOVMKhi9a0ld9SXTpkkJt0uj0lIUlXzjvBjwc8QgPohqHpo1Jis
	HUMm/PBijUJzwqgKgSDr8eD6N6h9y5Il3YWMy5Mh5EK75700JKut9/knIiR6v0Q/f4HygSYjizQ
	tqkW2fTj7LTAEwIedN0zORneMXsehaVm0NI3mA1FwemdbMYVQWWUBtmjNHCtUoZ6pQDNa8+bRra
	wVJlQIvlkSRzm/0jXeN/MKMdYg9rEg3qSkAV0pdT/qpR9mA2mLwKlv4lR6ThlBUKKIKRAj8J3aL
	gEv/jyA47F9MF8LEkE18W19R2HQiVsOzUOfTztFD47dJEVngEib9R8pdhOZrawTqbZPuvjGKAKA
	8qe
X-Received: by 2002:a05:6830:2b0a:b0:805:9b28:87d7 with SMTP id 46e09a7af769-828a167af3amr454360a34.8.1791270506934;
        Tue, 06 Oct 2026 00:08:26 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8281fcce2desm1721723a34.9.2026.10.06.00.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:08:25 -0700 (PDT)
Message-Id: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 07:08:18 +0000
Subject: [PATCH 0/6] status, push: handle a push branch rebased onto a newer upstream
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

git status now tells when the push branch only differs because your work was
rebased onto a newer upstream.

With status.compareBranches including @{push}, when your branch and the push
branch have diverged:

 * commits from @{upstream} are counted apart: (1 and 1 not in
   'upstream/main')
 * if the rest carry the same changes on both sides: (rebased cleanly on
   'upstream/main'), with a hint to git push --force-with-lease
 * if nothing came from @{upstream}, the message is unchanged

When git push is rejected because the branch it updates has diverged:

 * if someone else updated your upstream branch, the hint still says git
   pull
 * if you amended or rebased commits you already pushed, the hint offers git
   pull and git push --force-with-lease
 * if they were rebased cleanly, the hint offers git push --force-with-lease

Harald Nordgren (6):
  status: count push divergence outside the upstream
  status: say when the push branch was rebased cleanly
  status: suggest a force push after a clean rebase
  push: name the branch to pull from when it is not the upstream
  push: offer a force push after rewriting pushed commits
  push: suggest a force push after a clean rebase

 builtin/push.c           |  62 ++++++++++++++-
 remote.c                 | 132 +++++++++++++++++++++++++++----
 remote.h                 |   6 ++
 t/t6040-tracking-info.sh | 163 +++++++++++++++++++++++++++++++++++++++
 transport.c              |  42 +++++++++-
 transport.h              |  13 ++--
 6 files changed, 393 insertions(+), 25 deletions(-)


base-commit: 8103b446517e0c44e67561b9d0ccce56efa60a71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2437%2FHaraldNordgren%2Fstatus-push-not-in-upstream-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2437/HaraldNordgren/status-push-not-in-upstream-v1
Pull-Request: https://github.com/git/git/pull/2437
-- 
gitgitgadget
