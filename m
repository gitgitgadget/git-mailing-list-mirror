Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01117269894
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489590; cv=none; b=nHdgSs6wlyINz+7ZQgwWoPYn/kkLMXalXRlA9W/E84mUyC9p1jQv0xRHTSr+gj199BuCVYX4iUi45oXkxt9r4WR/4004dyTLYlL8LA9ATOoFOeNMXYId1aMu4Y4AWAED74kc0ASIV8iebvVikwew4wlkMeXmrNkzyMGlvWHAk6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489590; c=relaxed/simple;
	bh=7BRc4AyglW4/ojpL6ykaC+hwM6mK9jbPRpINdi2WXyQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=D61iXVp6ULVoBtTttyGRN1mV66VSd7o+c8GDmGlbs2KTzrD9v4+XhaqWfAqvgfh8yzMZtTY3XFAvLZVbEyXSu3J29Tu3sTkNeY5vGL0OfWXGjnGrBIr7+r/L1RSoGACobkb6bYRehdkbg1FcZOCBwm+pJ1Gkm0bCNicCnppNCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlqurDdx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlqurDdx"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f3486062eso4733909f8f.0
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489587; x=1741094387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DwTiHxIw9owNT//9eBTymg/lNbuST8/1NN+5tvDdnvc=;
        b=IlqurDdxWrA5HpFb2R2NYatXsUdvE+KBdRXgMft/Das6UaOrGOBOdIIfTrOUkdDEo0
         tk8EoC1hMWrhAsAgSz0e3oqwrxSUBVMNdV9+dCE3P4flpd2OMFuh5OKf/g9CtxOzUy5x
         fjhjD1ep/BVwwfzrm6DZZLEjlwqKM8NVNqIHtwJktYvkcua6RZkwLAtpCseGSGIM0zdg
         NKWslbxas23/ZHrlclHvoNBwL1526aKY7SJfzfxiiNhjqbKfkuXvlNgERyktYqvYz6xi
         44joskucnr7unETPh+VN5yx+fGVZ+Cpz9jn3RWyfybrHA/m4xg087sFeUUncKuXvbpAR
         WwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489587; x=1741094387;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwTiHxIw9owNT//9eBTymg/lNbuST8/1NN+5tvDdnvc=;
        b=FkjRbDonxirjV/PmOlA6bkmbt2GZ83SkgPSOwXJ3+Ks+RlDPv43atpNl3QynKAnaTX
         Gv9TgAuRvfVW4SUtTDOMLIXLjKPlM1qZ20md5OsJCHubltCZ3OChA4WOzU05kU4izvYZ
         1/nKL+mCOFrswLie9TRSu3SZkELQy3/JoQLWNFCEaLtV9VHgXdnFVApwZkvZ1ZZ8Pogh
         8f6tqnLo/Kh/UZsejsO5mOjA9b5jtGuDjN0E4in1zfVqrWWsC91ZEgkC0HR20ieTWfI3
         MJX4oCXoBZC+MwHUNpWhYYgKCyj6xO3Pgv5SBITM3m3LnOaQ+hB7Ew3ek+0D2gC7+thN
         gDwQ==
X-Gm-Message-State: AOJu0YytAPtVJQ8az5p3mzXH48VMcc/Y3yhYxQrroAbkMUgRsNEX3TYe
	uY3e46hqfBsVYvoRvu/pPC6p89HGrvNx3XfX48lFAEcEWHzL9vZ2rLkTlA==
X-Gm-Gg: ASbGnctGQUPvXNnduwePnFWQwe+4IgBoOB9bgs9DDMAK9XmnWS1k/YjCCbKoEQ5jKr1
	rMRoTXGk9A2RijNoI3p+gUSTVL75S7T2RyR7IBlGOu+376LS0z4mt8A1QnNHDR/1e0101CIEj+j
	1UU/2StqvoPJfHk2gnBK3LT9rcewPd6J/a5mN+9nZKljlPP5db6+OhvRniljRq4bwcemZrmb93f
	gvNPDbGuHKD3aiMAngSHDNfNc3eoCsWbTswmQsdymsvWXNyGT0pOVnY10dB/IWh5lBda+yY/fQL
	/L1kgiic1cj9Q7IaQKV+gxtgcUI=
X-Google-Smtp-Source: AGHT+IHdDLA6LkNLueA5uxJPwtFzOoBM1Eqot6a6KS254pGbtvBl6qCd1zcny5wcE5TPQUfaup3z7g==
X-Received: by 2002:a05:6000:1fa3:b0:38d:d223:f8e6 with SMTP id ffacd0b85a97d-38f7d1ff3c6mr10259982f8f.0.1740489586585;
        Tue, 25 Feb 2025 05:19:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7121sm2286665f8f.61.2025.02.25.05.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:19:46 -0800 (PST)
Message-Id: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Feb 2025 13:19:45 +0000
Subject: [PATCH] bundle-uri: copy all bundle references ino the refs/bundle
 space
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
Cc: Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

When downloading bundles via the bundle-uri functionality, we only copy the
references from refs/heads into the refs/bundle space. I'm not sure why this
refspec is hardcoded to be so limited, but it makes the ref negotiation on
the subsequent fetch suboptimal, since it won't use objects that are
referenced outside of the current heads of the bundled repository.

This change to copy everything in refs/ in the bundle to refs/bundles/
significantly helps the subsequent fetch, since nearly all the references
are now included in the negotiation.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
    bundle-uri: copy all bundle references ino the refs/bundle space
    
    This patch probably isn't meant for inclusion, but I wanted to see if
    I'm crazy here or missing something.
    
    It appears that the bundle-uri functionality has an issue with ref
    negotiation. I hit this because I assumed all the objects I bundled
    would be seen in the negotiation, but since only references under
    refs/heads are copied to refs/bundles, they are the only ones that are
    seen for negotiation, so it's quite inefficient.
    
    I did several experiments trying to create a bundle where the subsequent
    fetch was almost a no-op and it was frustratingly impossible and it took
    me a while to figure out why it kept trying to get tons of other
    objects.
    
    Furthermore, when I bundled just a tag (thinking it would have most
    reachable objects) it completely failed to work because there were no
    refs/heads/ available for negotiation - so it downloaded a huge file and
    then still started from scratch on the fetch.
    
    However, if I copy all the refs in the bundle, it makes a big
    difference.
    
    Here are some benchmarks from the gitlab oss repo.
    
    A normal clone pulls down 3,005,985 objects:
    
    ❯  time git clone https://gitlab.com/gitlab-org/gitlab-foss.git gl5
    Cloning into 'gl5'...
    remote: Enumerating objects: 3005985, done.
    remote: Counting objects: 100% (314617/314617), done.
    remote: Compressing objects: 100% (64278/64278), done.
    remote: Total 3005985 (delta 244429), reused 311002 (delta 241404), pack-reused 2691368 (from 1)
    Receiving objects: 100% (3005985/3005985), 1.35 GiB | 23.91 MiB/s, done.
    Resolving deltas: 100% (2361484/2361484), done.
    Updating files: 100% (59972/59972), done.
    (*) 162.93s user 37.94s system 128% cpu 2:36.49 total
    
    
    Then, I tried to bundle everything from a fresh clone, including all the
    refs.
    
     ❯  git bundle create gitlab-base.bundle --all
    
    
    This creates a 1.4G bundle, which I uploaded to a CDN and cloned again
    with the bundle-uri:
    
    ❯  time git clone --bundle-uri=https://[cdn]/bundle/gitlab-base.bundle https://gitlab.com/gitlab-org/gitlab-foss.git gl4
    Cloning into 'gl4'...
    remote: Enumerating objects: 1092703, done.
    remote: Counting objects: 100% (973405/973405), done.
    remote: Compressing objects: 100% (385827/385827), done.
    remote: Total 959773 (delta 710976), reused 766809 (delta 554276), pack-reused 0 (from 0)
    Receiving objects: 100% (959773/959773), 366.94 MiB | 20.87 MiB/s, done.
    Resolving deltas: 100% (710976/710976), completed with 9081 local objects.
    Checking objects: 100% (4194304/4194304), done.
    Checking connectivity: 959668, done.
    Updating files: 100% (59972/59972), done.
    (*) 181.98s user 40.23s system 110% cpu 3:20.89 total
    
    
    Which is better from an "objects from the server" perspective, but still
    has to download 959,773 objects, so 32% of the total. But it also takes
    quite a lot longer, because it's redownloading most of those objects for
    a second time.
    
    If I apply this patch where I change the refspec for the bundle ref copy
    from refs/heads/ to just refs/ and clone with this patched version, it's
    much better:
    
    ❯  time ./git clone --bundle-uri=https://[cdn]/bundle/gitlab-base.bundle https://gitlab.com/gitlab-org/gitlab-foss.git gl3
    Cloning into 'gl3'...
    remote: Enumerating objects: 65538, done.
    remote: Counting objects: 100% (56054/56054), done.
    remote: Compressing objects: 100% (28950/28950), done.
    remote: Total 43877 (delta 27401), reused 25170 (delta 13546), pack-reused 0 (from 0)
    Receiving objects: 100% (43877/43877), 40.42 MiB | 22.27 MiB/s, done.
    Resolving deltas: 100% (27401/27401), completed with 8564 local objects.
    Updating files: 100% (59972/59972), done.
    (*) 143.45s user 29.33s system 124% cpu 2:19.27 total
    
    
    Now I'm only getting an extra 43k objects, so 1% of the original total,
    and the entire operation is a bit faster as well.
    
    I'm not sure if there is a downside here, it seems clearly how you would
    want the negotiation to go. It ends up with way more refs under
    refs/bundle (now there is refs/bundle/origin/master, etc) but that's
    being polluted by the head refs anyhow, right?
    
    Is this a reasonable change?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v1
Pull-Request: https://github.com/git/git/pull/1897

 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 744257c49c1..3371d56f4ce 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		const char *branch_name;
 		int has_old;
 
-		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+		if (!skip_prefix(refname->string, "refs/", &branch_name))
 			continue;
 
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);

base-commit: 2d2a71ce85026edcc40f469678a1035df0dfcf57
-- 
gitgitgadget
