Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168536D4FD
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771350542; cv=pass; b=BCdelqNySoNkSqoOE89iUah8747DEJUyhCYYFsREfx4hCxeCTp1vJl5qMQYkRGo9AdIg/912e+rBuBh1ZOLxhY5oQLpf4moN7NO6CdNS+L8fwr9eVGzrKUNPw1vrbjQjD/sRryQEMaVUthzaeo8zrSOpJwuSAikbczf89fXNFm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771350542; c=relaxed/simple;
	bh=MkvGtfZcQWqHY4ngs4p+CFCubgOwIo62fIbizK69qpo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njKntnGTbvvwQne9a8NyIfrm1u0IlyO827y+T6p3vFK8Pf+CygRYwc3A5Q17/w9SXA9LTQLhIo/IiQCPQ+g07gIDRLxL5LWS91mDiGqcAZrPbPWIKqa32mKa6EyBC1a0qn8c1TT7bGAdFJ6YBamcMtY8/Ggwrqq23vfC6x3+8nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJHGwYB7; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJHGwYB7"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56706fd623fso2250510e0c.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:49:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771350541; cv=none;
        d=google.com; s=arc-20240605;
        b=RAmmA0yBqNdoGPHk3lv/3FUmQleI08Z6YyL+kQqqv2Le6Ir9zhwgKmGqWhGBppKlwu
         x7id7wG/HTZZHiTObSbO+9YDNfDsOAfWQ9LVhB1HpQerOejuzqgldrDpzdEb8o7Lq5A4
         DACp8h/5BlS4xxKv5/x6qymBAmn7JdgcGhE/zgion4rb03ZB+548Nqj3umJwyIeEWGnn
         9pFGXZ1lT1sQv1kdr7tBXGgAyZ2u9L1uab/pZpvcmvPceCJRn+8+kPXAKg7HHbbhQt4b
         H/wmkDb4j1F6AC8BEK2CbJLvC84TANvQzp6W+RBJo/tb7GWu9mPhgxwO/ml6d7OGJnV5
         fkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=haTNIsEgq0lLzT29bL5wa43ct5vaLBuBhqZ6lxMFpmI=;
        fh=wsNpIgHLBOm4Az5fjnBmB5hJ5PB1sZifqDo7w1z76kU=;
        b=lXtR8NX3YYNLVTu0cZFqqhBC9YAtFUekDQQ1stkZ5UR2ARfE12ZoZQiM/HnaQMT9ms
         eK8Cj/4ORNXby1Whz9dY7VKsGqV9xIUa78FYqmF0dTqtvgH5FsfHaDJ4et/ByN0FnQxT
         9IPrcbzcj4YL+Rzaad2NT0cgCRWp9xxq7OlkLF0CMyKwsu4j+pjVungDpsL4LH4kzAZ0
         z1LeLtb/dbfYGLW94F36pqyFYUl2qWpPs8mjI1881MK78ctiJcKfwBzvcXjEhAZhTa6b
         664F2jq8Wl5PYN8O54zPPSHMMja7ubDhCPuKocFgyIBdfhU7IuKYJzoRbPegTNh8+XRr
         7Y0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771350541; x=1771955341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=haTNIsEgq0lLzT29bL5wa43ct5vaLBuBhqZ6lxMFpmI=;
        b=CJHGwYB7ocPBkUB+/Sipj123Xgdv56QeXJeAFqgNSeSK3H4GEHOBJfyTB/X7AYWfUC
         n93fokJgJma+XEBQL9R2/zby06g2tPrDMD9nJxX12lVnz8yPNViBaOCRvqy0ERgL8KA6
         uqcdoRAF3t6N1PyOLI+Vsij+144cGgl9yFHr56Xr5p2O7tVyalCmlX8uGKGbjLglWQ7O
         8c4wc3DBeepFtopMIFbcLVzFMUK4LI/TmLP21cP2ZpRN/UW2lc3A4XJHYJRVa9psSx5r
         qPwB+uRuDVHMYaWoDfk2k2I7nN0zxra4qcEdMYLhlxjya0aMsgx9cAn0WNa6P1KiYSq7
         3Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771350541; x=1771955341;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haTNIsEgq0lLzT29bL5wa43ct5vaLBuBhqZ6lxMFpmI=;
        b=gr0JszB9dp1h3w9g0q8XoJgjs1nsJ5Ho5vJPZyOtPmnyIZ9EHTd6mc6U5oH3HkXsOH
         Jcr9RYF0gEJiayo/QaTnE/cBRYWF3a+J/1rhU3eUSKJ3zZD+a8EH90OpP3pJg8x4oKFe
         0q8dKNLMflV6PS1zV2ZanfJAYngS0rxufzEvsWDXo48NO5e/w3A84ajG4Mu/Lj4EIG1S
         h9tlOBd38UaRJf1PyOPz787d7gkAuW8XlZFVjH/yDlxqQI5607UZmh0xB4/omK5Iixbc
         SdVUqEHLaRA7TslHZsBgEFN9lm8jNJKDJahIxdh4So+Mmpm02BifjyEIBQgdn3U1l2ye
         bMmw==
X-Forwarded-Encrypted: i=1; AJvYcCVaZai82pzBr0BPerApBXDbFJaRnXAe40Wt4pvo3yTXPOnmlQYV6ArWX84DQTqzfG3JED8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfxbjjcIJG6TlU53Hl9zGUb4w9eenjr5uqiuAuncLlKQBB4CRl
	mMjpgZ60fZjeVR6g7C4Hmvb96S6ipFbgEbniABHDUh+qo5wLkCgDPCLWg62BkoXeFvlSkGN941i
	cBkXaox9+949UsIHNlTTlYlHRZJihGgI=
X-Gm-Gg: AZuq6aKOkPC0CrjDP4HYYdQmGGv6L5E9tV/hBCXOSZOCSHuERyp5fEjP6ZvZ7NCiihI
	5lb/bmxGzLFuKL294qBjf6m838wjESwG2/2gjMVVWd76tk3OU0pi8ca6HhR3iazl8P2l3TvbVoP
	2q/oD3OL3eRpw39xO/Og8Iqi8MANmtaRekn7C3bitrm/8NMQamyomJyLB2v49zfur3UxrBCh9K+
	0ISA1ont6ZzvhyJRADZyAOW5jxxJGToe10pkB9DMskilDHHg6RmIBwpy8lCU2qZ02sL43G/TE0U
	o+g6Rgy5ug9AtopIPvSTC7m4VOZpOff3hjn2AWcRvw==
X-Received: by 2002:a05:6122:8284:b0:55f:c318:1afa with SMTP id
 71dfb90a1353d-56889b68e4fmr3960627e0c.6.1771350540384; Tue, 17 Feb 2026
 09:49:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:48:59 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 09:48:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <23b8a355b414da2b6216a50006bf2276dd3ea6ae.1771258688.git.phillip.wood@dunelm.org.uk>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <cover.1771258688.git.phillip.wood@dunelm.org.uk> <23b8a355b414da2b6216a50006bf2276dd3ea6ae.1771258688.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 09:48:59 -0800
X-Gm-Features: AaiRm53R6hwQ002-ht2DOVJO_lr2hbXpigO0ZNGJRs3qNv6EHwdNc_yq31qLzug
Message-ID: <CAOLa=ZQ5YUz7c8w7PY=cfAn57wV0NNwOj2czqbojQ65=jVuAWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] path: remove repository argument from worktree_git_path()
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000bba0ea064b08af73"

--000000000000bba0ea064b08af73
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> worktree_git_path() takes a struct repository and a struct worktree
> which also contains a struct repository. The repository argument
> was added by a973f60dc7c (path: stop relying on `the_repository` in
> `worktree_git_path()`, 2024-08-13) and exists because the worktree
> argument is optional. Having two ways of passing a repository is
> a potential foot-gun as if the the worktree argument is present the
> repository argument must match the worktree's repository member. Since
> the last commit there are no callers that pass a NULL worktree so lets
> remove the repository argument. This removes the potential confusion
> and lets us delete a number of uses of "the_repository".
>
> worktree_git_path() has the following callers:
>
>  - builtin/worktree.c:validate_no_submodules() which is called from
>    check_clean_worktree() and move_worktree(), both of which supply
>    a non-NULL worktree.
>
>  - builtin/fsck.c:cmd_fsck() which loops over all worktrees.
>
>  - revision.c:add_index_objects_to_pending() which loops over all
>    worktrees.
>
>  - worktree.c:worktree_lock_reason() which dereferences wt before
>    calling worktree_git_path().
>
>  - wt-status.c:wt_status_check_bisect() and wt_status_check_rebase()
>    which are always called with a non-NULL worktree after the last
>    commit.
>
>  - wt-status.c:git_branch() which is only called by
>    wt_status_check_bisect() and wt_status_check_rebase().
>

Nice. Well explained, the patch looks good to me :)

[snip]

--000000000000bba0ea064b08af73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1a92e7bfb60d50b7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVXFnb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOG9CQy85RzBMTGlKNVplNzlVenNOQ0xNaExkMEFoTQo0emdSQ2hibFNz
UkJXdmZvdGR6bEovV0RENkNWdDAvOGFUUUVFYXNGME5lTlJVNHhGZzBRWUJVeGd4OUZEQkk4CkU0
LytiMC9mU0sxZVc4M3FmWjUvM2lJazJ3YVlNTHJDVUcrTS9HbDhVWHZUR3pQSTg3RXAzS1ZJUXN2
WmF6bFYKNnN6Wm1lQjVUWlZFQzJ6Y09iZ1QzWmdSRXg1Zktld2haVzdqdWZERFJDR3pCR3Q3Ynhl
V3VadjNwSEg1Y3hteQpBQXJTTEFRVCtsdVFpREx5a0F3QjVEVFdaRE9KdnU3cEJEMDZiUnNvM2dU
bHgvMnZsYnRMejFyeTkwTkY3T1FVCjc5YTFjcm9JZXhXMGZ1WmVDbGhNNGxSVGVLcmJyRS93aW5x
Qm8yWEtIZURtOElVZXdSL2FUVWlWRHJGeUlSbjEKUk4wN0F5bjZ6bmtXek83LzlWRDZvR2xmZzBF
VFkxZFBQbUovdmJOOGUrNnRqdFRWS3ptVmk2U1N3bklUM09XbQovc3IrVGlIYzVQMThpbEFwRWlZ
bi9qSkhsdWNQK1QwT1VJalpOWlUyaWNtbHZESXlXQktPTVZuVE9oYmd0OGI2CktCMnNoYm5ma1FG
MWJuVTRuUmNaNGt1VVQ4UzRMSnRCdk84Y0tvTT0KPXhXb0IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bba0ea064b08af73--
