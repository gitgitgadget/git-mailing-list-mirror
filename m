Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B99156CA
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345127; cv=none; b=gYxKENyZYHsPpGXHx6oPWGM4EDKcEK9zONcKCntWFEfN0KiJz02SDj/yGNJn7sGqMVk+MpdJe5G8GpD7ws/NqTHFmrUCyAJjNp1MFfNmabS9UBu/uEEMYBAsv8aH5IsZIVSMr7M9NSVHIfmJOnIwuboFPQxbAWbqU3fy4NMe1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345127; c=relaxed/simple;
	bh=TFpLL3B2QvDBAWyPwR0Yy/2VUWnI8NC3rp9YOCjtdsI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SNbZIZkFmw6N7DqN7UisUtxJLBgilJPZia1yfxfMnn80ew4ldKZhmlqc+NlYJBUcJ9kUp/EnY0ze4EB3bTlSVHHCYhc8irSPNqzxDnfzIlSoheOwJcLTCmQ2rZz9SYG82cIONE1a5HswHcSXNedUx+VYSp9Zcl5GXIiRYvo3U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKJVKLbb; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJVKLbb"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f293so4057202c88.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 18:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770345126; x=1770949926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pVErAzwxw2xQeTpm66VTBPEVadzotuDadLzXlioGRbo=;
        b=lKJVKLbbm7Z9aGN8WlcrH/PoWKo/rMPpBOowTek4vJQJgblZhBMaRxviuj3ua6DdPT
         L3HFihYpnLsK1azyYFXdqd2ENIF15zCk82eq5G8dEfcvByhjFsd4KrkVehfxFIx7KPWG
         S9UZ3CrFB+AitVktMOE5SiOoH/DyVGYiMVGLIGWaZRTOL+VR+8mZhn9dSZYFw5tFeaI/
         QvJrEXE+8YDoSxtdGZ9Ocd1wveGBSwu8NmE3WB5kqRK/sKwfYx41xFlJTZd4FCaOO6dE
         a2khyijizvKOlYmSHxvPp2cNmONuiAdnqNU5rHM3Gz0niG5UI6OcCU6mR36SsYdFlw3Y
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770345126; x=1770949926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVErAzwxw2xQeTpm66VTBPEVadzotuDadLzXlioGRbo=;
        b=oLvLkaBG/XLzy/qbM3NJ/e67IOZMSNrtIQICwEQCy6iBsdOQ+k/lmrYNVapklCVns7
         JH0tKzBx4M4hIp/LWHsjE1SEkJYz/9nSTndk6SS8t8w26C91Xv7iESreirG//wSTT/dC
         EwS2towyFqy/au+8pWqtyw+w7KhxLtW7TpJCApU4yIYbL8ApyJHzkqDauTXsjXrmW/nr
         tzRsLAZgfwPMdIdGS6SsXjGJLA2+wwGST2Tn3e+9m90l42hO84Ws0RAs3aoNC1//G4x6
         WvfiUlw76EgA7wPUVtZgMl9cxde0qKmAlV89RZccna3fOAHd6lqZN12dF0RzlFyJpsLu
         Dj/A==
X-Gm-Message-State: AOJu0Yyj324UU2Qp8U3XlzidrfgpHFr1dyJqosUK6XuVDCCJFRTALdTW
	sumcP3r49HgWcappmxucTPcWwaxS3Ht8uKbPZseehRzsNxD8lsweUbq8HsILPA==
X-Gm-Gg: AZuq6aKGwFGAn8pNLmo0Tt1slDb2WH16jF7EhvWpSC2PccRqRVT4kGHcdCgXNSAwSQf
	pj0I1I1KzFjcm8ogwzXzJC96qwWDokYabGvB363dL25vHlUojksWUV1th6LX86YQF5JoUZdxyjT
	rFUnqQRQYBVJHsRsLkHKOPjytl3Dy7rrZC6neg6Q9g3TmE7gqA38vZZZnLYB7Fs3Z4Xrz+03K26
	v9u4g7OVkjgmX6PBrmvtZ+qVbKPevqLHQfVvnIzUOqcVuueyOrfBn2uURWUyOpylRa20S8a0p+Z
	v04z6CVWTL+JYF1NbZlhM8mcVUkO7LQoAfAXhu5IXSUFrCwetXbF+9FocxDa7FTfUtuGwJx0/Qn
	T8U+ts6dPtwNoANYf4lLZfzyA2bnEjGMG8s3DI8csb+P53U25xrnxJxzAIlaiiws1FCPvOhQXHm
	gTMch9jsuTrg==
X-Received: by 2002:a05:7022:4597:b0:123:348b:979c with SMTP id a92af1059eb24-12703fe453emr579277c88.6.1770345125759;
        Thu, 05 Feb 2026 18:32:05 -0800 (PST)
Received: from [127.0.0.1] ([20.163.4.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433abdfsm832517c88.12.2026.02.05.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 18:32:05 -0800 (PST)
Message-Id: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 02:32:02 +0000
Subject: [PATCH 0/2] merge-ours: sparse-index integration
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
Cc: Sam Bostock <sam@sambostock.ca>

This short series teaches merge-ours to work with a sparse index.

Patch 1 is a preparatory cleanup that converts merge-ours away from
the_repository global, using the repo parameter instead.

Patch 2 adds the actual sparse-index integration and tests. Because
merge-ours is invoked as a subprocess by git merge -s ours and never
previously read config, the sparse-checkout globals remained unset, causing
the index to be expanded unconditionally. A repo_config() call fixes this.

Developed with AI assistance (Claude).

Sam Bostock (2):
  merge-ours: drop USE_THE_REPOSITORY_VARIABLE
  merge-ours: integrate with sparse-index

 builtin/merge-ours.c                     | 15 +++++++++------
 t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)


base-commit: b2826b52eb7caff9f4ed6e85ec45e338bf02ad09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2189%2Fsambostock%2Fsb%2Fmerge-ours-sparse-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2189/sambostock/sb/merge-ours-sparse-index-v1
Pull-Request: https://github.com/git/git/pull/2189
-- 
gitgitgadget
