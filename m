Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793618742;
	b=oDBxVv4NNvP6FSjj7fqQF/i7MQQQQauXCvraDgEBBFleB5y5CjqlV5PgbJ4GxOq30gay
	 vO0Zui6bv6MM81sBYskVTxULroLdERbSkRUGcZGTMp5IUSKIIRsJz15xDUGbRi7PY+XoS
	 vaWKJLAw1CID2uw3k7+S1CuQR/PgKRMQg0NQxO/3NFddingaBbyBtyr/qvQIeR2hA8QkY
	 GGfjihrjmfuHOe0CtX9lKJKvbLU7qCREghZjaylQepHKHvmzv4zUMxPxepcx0AtrpB7/S
	 zF6f2ihUtgeivEMrxQfpN8wD8XZCvts/gcY1WedT5FHt+W8/amPwv5M5qsfie9RvJMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=YndPSVh+DbIcVLiTNyjGGLX07QLw38TSAUHFEyGGKuw=;
	b=qvlBJwntCDvoYAJzNBtkgAsVClcWRvQ2kFbScBbWkZ2+iM7AtGQh+swQSygEw9AADKia
	 FQXYZNd1xEme1USoQJ8QRi9U4eBSyfEF2EbYDOObAXnm6fVDaQHoQ+1TiIJxDO9azt6uQ
	 mQ2L2lyb3IKIIq1hMRoJ15tNVb2K4ANFdnvJ+TIBOp9G4m93OnxI+jKXMm5iZ4a3eIYto
	 Bn3tPzi4YxPo6vA2x96mu00cRkagPPSIeenMSRhLGDMFX2w3joZYYftr2qtnWaTH/e851
	 78iB0JM3L1VC/HPLaAs6IP9HgtRqPs8Fwb+XI3v2/tlhaDWi0lB0whdKjc3OpPG6VQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gHZg9dxn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47404606A32F
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47404606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gHZg9dxn
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c8fef5ce2so38030586d6.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 03:25:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618741; cv=none;
        d=google.com; s=arc-20260327;
        b=olewUqYXId+VtRLJZf5Nyczgt63vS1lC/4yARJzyOU74mUOJK26huAKUYwiERq0PUD
         zitzUJI5+bg4GJO69BEoZpIbshPRM1hF6rcQ0gdR8y+NHbnqqs04bxkGaAG0kqp9JKXM
         BKfhXKSL/NjWInD6CSimP7mJQmSu+wBUqYs3D0cdFf0UIdtXLb0r4+QVzx2GMOwAcddi
         JHOLw60WtX1ar7O1hIM/ENdtEGpjYdfu7ZJSPxcYxUVWV0pTfEKqHVCb7f8yOtMtSbJO
         rO1+pa1SP3gL+tNVY43enAZLaw0n/+3tC2Px/G4K7sCZEtfN/3jZnYIOpyI4+lo9dZ5U
         LalA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YndPSVh+DbIcVLiTNyjGGLX07QLw38TSAUHFEyGGKuw=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=YJY7qIrhqEoE2VMS+HniK4ejCBVwECB8U00CZyFWR020RWT/OElpYgtFk5pEFTADLi
         BsdpQiW8hOSGLbh4qxUDExDkV/HbJSKdnH/1mP23t6x+nguU0uJyK8ymXn+Y8aninor6
         0z0z0LVsr2u6snnLwVCX4dnUQpRaAoITzoI+qGbc914bcYDQGJ9Bvw/zvhH+MIgC83dg
         KfO6Uv0fwcKSjjjAxP7pJpY9h1lUClI8TYpjIHT5OGzpCTf81IZsrxNLL+NXUda3OWdI
         eD/a6hsRnKKNPaZcvPy76egvV5F4HdcEpMcIlJS6pOVUgzGq5GlcQ20MeTWuPHL873G2
         V+gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618741; x=1794223541; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YndPSVh+DbIcVLiTNyjGGLX07QLw38TSAUHFEyGGKuw=;
        b=gHZg9dxnpq9FOv7NMarl3EqnVmoJWT4gQgJtQkT2SzeKsE8WlP3pjHy7jd+iLtMrq3
         AkM5BwaJK3RuuRZmDkKqulO7jimlrfU9yklbuEvI3tbPMyFWPmu1mKH66j5U1I8WR9YH
         0sHwcTU6KB4su4E2GGM7Jr7umPEda7+m2xZo5oCAx/HilbMqJts970ZZd7bSg7y6S+AS
         4h+4bo+g2xn5CEa8M+aPgVEqTth8T4CzDw2tAI85HcDhIxOkEsxLq5kVcxgyYhnru53j
         If0DRbFH3Q6tEUl+GqczAjA9M5+Yzgpq28JTFIAdL45DUt4pB0DzdzwzFt2uAa5gMyaD
         V3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618741; x=1794223541;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YndPSVh+DbIcVLiTNyjGGLX07QLw38TSAUHFEyGGKuw=;
        b=HSUkbt4XSD+SLfQaBn+iztRGpSut03rQrZkqcVg/Y7rPZuNKuR8N7eOWCX0QBJVmIy
         2a+PRVN5WGqxZ+fpzwCzIItwePTY397j6HeRIiQv3QOelhmTpKN3RwPqLpdhPEK+4zjM
         +ug6nOpUeS0rl2XF88yGtX3YDF7yWayaHkqTYjbvzX6Yek0gkL3Qe4UIhcn39STi+x0S
         O7+pP0n/1EeEIOxa7e0/Xf+NTXkxxJE5oH1fytJFtVeCAhi6KiuuQeQ0G4qrXTAOWbCM
         pMik3wA8XVKSJPT866G8sLirC/UNT1WjroIqChFWxiEWOVCvHjC3pqIoeZ7J8fJPwKBs
         9HHw==
X-Gm-Message-State: APuU4Z9l+bv77PApPC/yB6NGUL0lHJYZsI2VMi2ZPUhgqgftv+nqtVHb
	ZMOpE64duHgfZ9gAYmr2t7JmWxSm/PaZgXyDK66hza2SdLtvj4tia8I9tnih/j7QXGNNd6W6Ubk
	gVifQlKk3i2sNnfhf03ImpKaSjzVQseJBzUy/y60=
X-Gm-Gg: AYBFou3stUlKpvJ22RtgWAP/B+kMkKeFUb6AEHG+FKjSjypMbtSj31zhgYW5szrkW7i
	G4i+IBOthaE5qWudmDeh9UaeoobzCnHDvaUNlQOOjVfKHdFImbFH5O80akEttrmRanuK9cGwpNq
	JrYcHIsHX+Az124CFmtZsVfbLEgH2EB7mykHBoZ0xfWBN48ob6W3a+iLZguI4SFM+onu4UgLaWc
	j1/t0811/BUqpVbuB6IO3EHw7wB1p+OsgxcGZZO8sdLEg0y5Ezd+IAIVmyolXsSHY1lUwQODxfR
	96pi1ydu0XWx9gWe+yf97/5AJGOFAGbm7I9Wt9IRY6Brrm7iMhPrcM6R23SIfvG1IrxwDQDPTBN
	bg21M8qiTia5ZeLs9YJ3//7CKLzk8tDmXHixGXYHCEx31sQEBhDsPCE96lq/TVRNlokvijwbP+N
	RszGDKZTu8s3P147eWKneXTzQYz3JdvNOoPS0GlLk2t73Mru48VpmnToxH
X-Received: by 2002:a05:6214:c43:b0:91c:6388:a45d with SMTP id
 6a1803df08f44-91ca49f1bb7mr152166526d6.5.1793618740981; Mon, 02 Nov 2026
 03:25:40 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Mon, 2 Nov 2026 16:55:28 +0530
X-Gm-Features: AclHuK8Y32hvEK6Y2gVk9NSyEBk7LL13MhKJVRqrfUceHhzZ9DioW8wJWDfpATM
Message-ID: <CABh_KWhJt0JiqhJYxnZmvHjkAs-gCyP8++DK+Pr+-So142YfvA@mail.gmail.com>
Subject: [Outreachy] Guidance on a possible pathspec contribution
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git community,

I am currently working on my proposal for the December 2026 round of
Outreachy for the project "Reduce Git's global state to enable Git's
libification."

Whilst looking through pathspec.c, I noticed that
find_pathspecs_matching_skip_worktree() takes the index directly from
the global repository via the_repository->index.

This function finds pathspec matches for index entries that are either
marked as skip-worktree or are outside the sparse checkout.

Looking at matches_skip_worktree() (which calls this helper), I
noticed that although the results are calculated and cached, no index
is passed to the wrapper.

The existing find_pathspecs_matching_against_index() API already
accepts an explicit struct index_state *istate from its caller.
However, it also takes an enum ps_skip_worktree_action as an argument,
which currently has only two options. One option includes
skip-worktree and out-of-sparse-checkout entries in matching, while
the other ignores those entries. There is no option to match only
those special entries.

I am thinking of two potential solutions.

Option 1: Continue using the specialised helper function, but pass the
index_state explicitly. This would also require looking into passing
the index through matches_skip_worktree() and its callers.

Option 2: Look into adding another option to the existing
ps_skip_worktree_action enum and updating the matching logic. This
could allow us to match only skip-worktree or out-of-sparse-checkout
entries using the existing matching API.

Looking into where matches_skip_worktree() is used, I found calls in
pathspec.c, builtin/add.c and builtin/rm.c.

In builtin/rm.c, I also noticed several other uses of the_repository.
Similarly, pathspec.c has other uses of the_repository, including in
init_pathspec_item(). So I understand that changing this helper alone
would only address one specific dependency and would not make the
whole of pathspec.c or builtin/rm.c independent of global repository
state.

I have a few questions:

- Do you think this is a useful and focused contribution to help with
Git's libification?
- Does passing the index explicitly through the specialised helper and
wrapper make more sense, or should I look into modifying the existing
matching API?
- Is there any similar work already planned or being done?

I haven't implemented either of these approaches or tested them yet. I
wanted to get a good understanding of how the existing code works and
check whether this would be a suitable contribution before proceeding.

Thanks for your time.

Kind regards,
Srujith
