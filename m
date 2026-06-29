Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D136A366
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739165; cv=none; b=mKZdH+UZL9srMQm0EvUMpm5tQO/Nkkur2Wp6yDLNVb8tZpns6ai7KH0k0VvMAx1xqG7BmImfo4Bqm9wWddjbPQVWp8ebXZxazK7uYvpuwHf3YuLczqibJF43vzzbUP+oEooGoOnol6GGhOouEYOikknFPKnokp9dLbhI40gI8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739165; c=relaxed/simple;
	bh=nzeLNv90Cic+bISGO1c4EcQJbN5vW4ikDADxmWbva3k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=u2P21s48rbb5yyYmBn7sYBJYlyR2IUxgNPIMl0cacJ9aDYvrYidnZCg+sYu8ucKJyfHXWhUjqeE0Y4rIm3Us24d8JkdMZPqKx1eEtiElXRaCCysogdlkA/Bvx86OG1QuFpIC6YpP/z4boEF72VdbQGLMV8UTAV1WDmDp4n0QTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T22LBAjv; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T22LBAjv"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-920f33347f5so296945285a.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739163; x=1783343963; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUa0cWPv628GjkQWXFvAilvFMep5UNQsd+n7IMg+3qo=;
        b=T22LBAjvSPSIRgSj9GXHBdypIj8eoNws30sKBPUKviWnFULrwyHIyUgQLyWE0nP4pE
         ldXRQf3Bxdm9+cHAL7DH5ljFuAeOjcAXrRRdfBPZ+Gd/w/mGHf0p8mwAZE8Weho1tBwk
         32+D+AmAKNUaqAmMwGnSjI+wICecb5jHp8zpJ5en8ZHav70Vlic4Y/KGYNB852CC8B4Q
         JBEwO3MCtp9avzooO0s8dJ4AvWS8XRVhp/v/KtgwXiFbjAUz2EGzDm5c88WFZ4jP6Pcv
         t6sTcg1fthGd3OM7gig7cFrO7JV0tz40FiyOVqra7oVQLAk9l+S3ek+m87OktkJHEODO
         leTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739164; x=1783343964;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUa0cWPv628GjkQWXFvAilvFMep5UNQsd+n7IMg+3qo=;
        b=aqCNYevhYudGreQjJeiTDCyNPZ7OE4MuoQf1xfsGhQqlkPfQk61MhjVd9Rv/jy60wB
         5f19u18yuLIPPaEy9Z3b4bfxjWC8Z1Y3yhDVJDg2LyDPAcX7ry7mwqqUNaAArqtGVcGl
         11HHK/BYNWWnbLvrBPxZDFhbl4EdqxVrLcvRKVQT611fJqSzLCo44qdhsrkU1lBESI7F
         zl19ySVM8vMOepnmg27maD8Q1ABe1fTb5YGum4reyTALGt9xk7j1Z+/CmEhO8vI7jCPs
         TGPrGf9nreyON6GmKdcuKKkqnXHyNggtv3Jk4I3XDnxv9M3O18SrQvHRUohJqF6VH2cR
         98rg==
X-Gm-Message-State: AOJu0YyYdWA7f+67g6vGkc1vnobk7iaSk1L/0B2ejoMiq0t11uKvd3zu
	51X5DJ+qAV5/IZKwb3Gq68CAkdQpyAVqQfUWISlICjFquNPtuuYGgGvu3boHtUzN
X-Gm-Gg: AfdE7cnmpcWfi6xTY/O/wwyfqCkSiMO84E3I/GE4n96jffo3gbp/m3AQgnDKX4tE26+
	uduGkwKNBKFA5tNzVu2jny/HXQ3mDKmdCM3hHMmOk93j3zD9eVkJRcL7V7gsxK+DGk5mKkVu2/O
	WxRIHaqUPYkq2iABNLMtLdG+bopxoTWFrMqYeUEB8QzxTLRjRQZotSu6c4QssU9IHHBAuI24KYl
	u6uU4/DNRSbBBWfHQvH6p9tw4PX40vXmZJedIiXAwScJiXUw4xpNwtTtL41Qm4b0WXcRaJAQ7JX
	qpOXga0W2K+v2Njm0Vr32EK81g0vYGTY4GYXcofvOlrl/Ah40/1LKdrqbb3/yCijlU7tBWWo7e5
	t4iZA28EuDVdOynnflTeKO3LD0f8KfGCgld9LRWAwuD0boPsGmlB+VNWF0TUKppH1uhKGdtatVO
	EvSXTy0bJ/J1Zt5V7cE55KcA/JTQ==
X-Received: by 2002:a05:620a:4495:b0:92e:5d19:bf82 with SMTP id af79cd13be357-92e5d19c7f5mr172199085a.17.1782739163414;
        Mon, 29 Jun 2026 06:19:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.102.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92db08a13c1sm731659985a.37.2026.06.29.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:19:22 -0700 (PDT)
Message-Id: <pull.2162.git.1782739162.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jun 2026 13:19:19 +0000
Subject: [PATCH 0/2] commit-reach: fix !FIND_ALL early exit with v1 commit graph
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Derrick Stolee <stolee@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>

Fixes a bug introduced by 93e5b1680e (commit-reach: early exit
paint_down_to_common for single merge-base, 2025-04-10) where git merge-base
can return the wrong result.

The bug requires all of the following to trigger:

 1. A v1 commit graph (topological levels only, no corrected commit dates).
    Generation v2 with corrected commit dates has been the default since
    2021, so only repos that have not rewritten their commit graph in over
    four years would be affected.
 2. git merge-base without --all (the common case, but --all is unaffected
    because it disables the early exit).
 3. A topology with clock skew: the correct merge base has a lower committer
    date than one of its ancestors that is also a common ancestor. With date
    ordering, the deeper ancestor pops first and the early exit fires before
    the correct result is found.

This two-patch series:

 1. Adds a test demonstrating the bug (clock-skew topology where the correct
    merge base has a lower date than its ancestor)
 2. Fixes it by tracking whether the queue is generation-ordered and gating
    the early exit on that flag

Kristofer Karlsson (2):
  t6600: add test for merge-base early exit with clock skew
  commit-reach: guard !FIND_ALL early exit with generation ordering
    check

 commit-reach.c        | 10 +++++++---
 t/t6600-test-reach.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)


base-commit: 9aa172cd1f113276d360d4e48937dc95ef46b780
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2162%2Fspkrka%2Ffind-all-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2162/spkrka/find-all-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2162
-- 
gitgitgadget
