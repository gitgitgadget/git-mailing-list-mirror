Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92B50097B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022022; cv=none; b=jKOkKZAOY5dwqRdiTx2iw/N0DqQkg5cuddDMEPppEPwyuVaQXfVlC+AWGWpu/Ht4+XQT3lM3An1wBXbOOk3B8ELFYyKQKodjbxrhs0Gxxch5J523rLRCMpQwXoonC3PDWQJS9GeRbdYrERkpOac3flYGScQpwNoSJd6AWeJsR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022022; c=relaxed/simple;
	bh=uq0rVi5F7YxU/zLkjQqcgVoq6Bxl3/xUHHgaZ/jgUVc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=eQZ9M6k4WN85vHTRltyZ/zjDS4QpHZZ/uqTOWG7szptmvWjPXu1yZWQFMfiByh77ndlKu1sqKaWkcT6nFsBEUL+11S7TJbKdX/YW7YlurLL/24lcR3lSWZ5B1HejUmczS/aPYNbIDkkD5zI/yvF0YNTozxcoJrp85C1vlXRAFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1y4tlJ+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1y4tlJ+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so67917981cf.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 21:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768022019; x=1768626819; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pemwj+Dqp7W2nMBbX3iSfN/CdQ6BAd3tSKr0OrPgg4=;
        b=h1y4tlJ+18nIQRr32yRv9fS+0qPjJLqR0egeCt1dlc8i9aka91Ytb8QWk6Si4SULXb
         6U3zjmkrDo45dHoSeKVpR9jKcwcqTdMbwq6JFrDEodn/PtxozrMBbI8FtoKjG49eaEqF
         3/BwUZo1RPbrzO5hRzcH5kxrEUUe94LCqLG3ohZ2yBI/6E9nhOOmiTaQg5qRijZgikkw
         S8079IFbMdn+tALg18HVWErqo+R3PRddjbeOKHUMFA7KctfWrgNRz5zTGgx6fScsKsZs
         As1U38abU/qCe5vR7Ty3HqgMnDbh5Lr5qwVbP98kw0u+wIwHWYupJYlS4rOwAN2wyU+h
         fuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022019; x=1768626819;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pemwj+Dqp7W2nMBbX3iSfN/CdQ6BAd3tSKr0OrPgg4=;
        b=ONrYVNGEfMfl+ndv6KgcaubrsS3Uj3DHGBLFTnFRN0gRnxtJafkeW0ip1e/NgE88pG
         jxSQvBCEUmqaC8ZRQA/Yrg7oqEEaANczNBMS+vE1w0yNiv6PoBD0M1AOloFlXy6YzxFL
         T82wg8tmZdcWloC27zVkOodu4Ji+af6BnSFK5fJKUCUW9OInwgJlK6Dz1pPg4xAncNv1
         oG5OaJv64xMsYdQbseUokKiAXUCX3ml3d7QSKMotTxbAjuvZN630/ZBi9J0u9X0jYXeo
         vp2lapArfq/Y70dqy/08FWC8B88aD9ZxbtAdlioUVeFBBhpyYxUMCNBkHSjU428oFm28
         aR3g==
X-Gm-Message-State: AOJu0YwFRt+RcXy1qL5DOuSeahSaBqp0sGUw7ptB0GVQmhEvYsfGYixi
	/xWkLD6j85VE7Rz4VI9LMbeg8BbaJ1DAqpbhyR6JBsWmU5cHcCz8xA+flNrb4oXh
X-Gm-Gg: AY/fxX5BWyPKCbIOnVGuCNJc9bM/BSpMperH/hNIxD0Wr9O3K/IFE4gysnCEvqAPRy5
	9KQIFNF6X6cEqWAXl3bvrEeP2ff+XpRpo8bL6TDN4OWZq82cx24tDLnb5ooOLfjYqBJ1WfTOvOA
	GsSFAWYcgq66kgAfJP+rOCwY5P1INcCoGzeQ+bZnQ2jYIME53sHAqrXbKuO8yJD8rqiKZrnNEM3
	utd/6+0rwV7hULCKs2NKG3FEC8BkE/St+yd8WWqdl+UxYwoRW5x3qVtQfwkfA9sXQxIw9xk0S8Z
	nDCAJKWOZ8zS/TkgA4orDCgfpG4X1cKPVjr3eyunwhaRIExSvWmFxqCbeV+2LHDoHTucw25THQl
	T+3rcJPToVlOG/xUvCRK8AqMIiPkCA5GaS6IcFKSNNCNlJxyyTPDNtQwEEUKxZHD7mKS6f4eKAq
	ph/FgFVqfmORrHMOf4JqfNNoMq
X-Google-Smtp-Source: AGHT+IGK2e+jN6CIu/gMUjnx0QG73ml1IGD91pD8V4mzs7VAU08im2J9r/OtKj/Dy2iUxHaVklkYjw==
X-Received: by 2002:a05:622a:283:b0:4f3:4bbb:d5c9 with SMTP id d75a77b69052e-4ffb4a640ecmr192161551cf.79.1768022019469;
        Fri, 09 Jan 2026 21:13:39 -0800 (PST)
Received: from [127.0.0.1] ([172.172.153.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm86497136d6.18.2026.01.09.21.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:13:38 -0800 (PST)
Message-Id: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
References: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 05:13:36 +0000
Subject: [PATCH v3 0/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a merged
branch, we may endup with some shallows, that are behind the reachable ones.
Added test 'fetching deepen beyond merged branch' exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven fetches
result in all the correct shallows. That led to this proposal, which unifies
absolute and relative deepening in a way that the same get_shallow_commits()
call is used in both cases. The difference is only that depth is adapted for
relative deepening by measuring equivalent depth of current local shallow
commits in the current remote repo. Thus a new function get_shallows_depth()
has been added and the function get_reachable_list() became redundant /
removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of each
existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative deepening
anyway. That way we can allways summ 'data->deepen_relative' and 'depth'
values, because 'data->deepen_relative' is always 0 in absolute deepening.

Samo Pogačnik (2):
  shallow: free local object_array allocations
  shallow: handling fetch relative-deepen

 shallow.c             | 45 +++++++++++++++++--------
 shallow.h             |  1 +
 t/t5500-fetch-pack.sh | 23 +++++++++++++
 upload-pack.c         | 76 +++++--------------------------------------
 4 files changed, 64 insertions(+), 81 deletions(-)


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2121%2Fspog%2Ffix-fetch-deepen-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2121/spog/fix-fetch-deepen-v3
Pull-Request: https://github.com/git/git/pull/2121

Range-diff vs v2:

 1:  f8a8d077cd = 1:  f8a8d077cd shallow: free local object_array allocations
 2:  ba1f80105f ! 2:  e79ab6b740 shallow: handling fetch relative-deepen
     @@ Commit message
      
          An example showing the problem based on added test:
          0. Whole initial git repo to be cloned from
     -    Graph:
     -    *   033585d (HEAD -> main) Merge branch 'branch'
     -    |\
     -    | * 984f8b1 (branch) five
     -    | * ecb578a four
     -    |/
     -    * 0cb5d20 three
     -    * 2b4e70d two
     -    * 61ba98b one
     +       Graph:
     +       *   033585d (HEAD -> main) Merge branch 'branch'
     +       |\
     +       | * 984f8b1 (branch) five
     +       | * ecb578a four
     +       |/
     +       * 0cb5d20 three
     +       * 2b4e70d two
     +       * 61ba98b one
      
          1. Initial shallow clone --depth=3 (all good)
     -    Shallows:
     -    2b4e70da2a10e1d3231a0ae2df396024735601f1
     -    ecb578a3cf37198d122ae5df7efed9abaca17144
     -    Graph:
     -    *   033585d (HEAD -> main) Merge branch 'branch'
     -    |\
     -    | * 984f8b1 five
     -    | * ecb578a (grafted) four
     -    * 0cb5d20 three
     -    * 2b4e70d (grafted) two
     +       Shallows:
     +       2b4e70da2a10e1d3231a0ae2df396024735601f1
     +       ecb578a3cf37198d122ae5df7efed9abaca17144
     +       Graph:
     +       *   033585d (HEAD -> main) Merge branch 'branch'
     +       |\
     +       | * 984f8b1 five
     +       | * ecb578a (grafted) four
     +       * 0cb5d20 three
     +       * 2b4e70d (grafted) two
      
          2. Deepen shallow clone with fetch --deepen=1 (NOT OK)
     -    Shallows:
     -    0cb5d204f4ef96ed241feb0f2088c9f4794ba758
     -    61ba98be443fd51c542eb66585a1f6d7e15fcdae
     -    Graph:
     -    *   033585d (HEAD -> main) Merge branch 'branch'
     -    |\
     -    | * 984f8b1 five
     -    | * ecb578a four
     -    |/
     -    * 0cb5d20 (grafted) three
     -    ---
     -    Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15fcdae
     -    is not reachable.
     +       Shallows:
     +       0cb5d204f4ef96ed241feb0f2088c9f4794ba758
     +       61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +       Graph:
     +       *   033585d (HEAD -> main) Merge branch 'branch'
     +       |\
     +       | * 984f8b1 five
     +       | * ecb578a four
     +       |/
     +       * 0cb5d20 (grafted) three
     +       ---
     +       Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +       is not reachable.
      
          On the other hand, it seems that equivalent absolute depth driven
          fetches result in all the correct shallows. That led to this proposal,
     @@ Commit message
      
          Same example showing the corrected second step:
          2. Deepen shallow clone with fetch --deepen=1 (all good)
     -    Shallow:
     -    61ba98be443fd51c542eb66585a1f6d7e15fcdae
     -    Graph:
     -    *   033585d (HEAD -> main) Merge branch 'branch'
     -    |\
     -    | * 984f8b1 five
     -    | * ecb578a four
     -    |/
     -    * 0cb5d20 three
     -    * 2b4e70d two
     -    * 61ba98b (grafted) one
     +       Shallow:
     +       61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +       Graph:
     +       *   033585d (HEAD -> main) Merge branch 'branch'
     +       |\
     +       | * 984f8b1 five
     +       | * ecb578a four
     +       |/
     +       * 0cb5d20 three
     +       * 2b4e70d two
     +       * 61ba98b (grafted) one
      
          The get_shallows_depth() function also shares the logic of the
          get_shallow_commits() function, but it focuses on counting depth of

-- 
gitgitgadget
