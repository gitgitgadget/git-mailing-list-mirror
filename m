Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F048C1F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904084; cv=pass; b=E74pgMdaqsqnEReoHJsBrxIvClj5rpdHP/lbyPpTyyIGAQl+rQWfHRSwiNUSmwgWln6WNn14fIJuZ75N/OmVnLvlm7WJUftr9V+e1Ue0S37G5ivKwdrlRPmM+TpbCIjFQ1ClZ3qsjsTlgD6GLr9CBI2inthfeFGirG9hVWLEYmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904084; c=relaxed/simple;
	bh=1/UnOo8Oaoy3V+tJTfFFftfE8blSjboWBB9/6cA4oWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XU8z6dkgq97Q0ef3uKm39LtklSIZrRO7pyW8fZ0GGB3/Oo7nC5HrGH79AHu6houtfSb4F1F20GFekepcNQTknaIKkGhhrlDZ8ka6zyylkJ8slSukl+oJxqRHtA6zKqVSBtRzsjQV3EOtq+tzBK0EGSxlMqHKgFMjtgftr6YvoO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ba85f77203so270613eec.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904082; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9ImZCRNGlbyFS/nmmLedJd5iZ0wYmfEhiu46K/cChTQLx0eERKu/+DH97776WTUQa
         LF87CFLDdtlitB1FYD0XuvI1YAzyz/9D/cxw1rnkNeNw8GmJsQgmz5aqd/08zYA99rrd
         XiuyDBr34MtQ8qKCX+vUOWxdY+PxBALdIuij559ATmuMC+v/hZpzCRoJd3ddxDOzVgfS
         LBBHb/Xk1JC1YRWQ0RNCY6mHUOEyJV6KKgX5ryki0g/grpRTXE3pvzFHbtjgM20+6Cr8
         qyFZdpd81cGmuHRyuaDgFkxhuhkSJtuMEqu4Rlfy/bwuyzUx0jBh05h1l1tpgi1vTjLv
         BIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=LtrEtXbTKawYSN0DPbgbVMw8XlhVNHOtR+zCXookDSE=;
        fh=36iwRaJBsb32XvpeUe98G8QFtbYqPVSB+M7lMi+IMik=;
        b=T2PA22ccy8dSuk/FOWLzkE8vVpuDKNHYHO4O79X/5N1oUVyG+ikYDkNFoZQ2guL7v6
         b0jJpy8ZCLKS8dQu//2KH/jeu0doLE2Y9GJREv2D7144CS5ZmK/W+MWp9zXX+MajgIs7
         ggzebsMdaja7WBrKJBRCqO3yMGjOdyz33xN0Cin7k/h3y3l2cbpbjt2Ht+E6frLUyeux
         ErWe3VoQqpNAmrlxRdKmQQeVJyZJAfzHgw8ptwnPdizosVwLG2GRPNLDyqs0nwNg8nSE
         yCOYtcP5L6AI8xoeMpJBLB0L9CvrJBTFMvYZuFsOLNIQc03eK5G+QiredJ3RiIOAgtaX
         /Ygw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904082; x=1772508882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LtrEtXbTKawYSN0DPbgbVMw8XlhVNHOtR+zCXookDSE=;
        b=gyTRXMIZUCknGV5zSmFvpbck2Ec0jOeJsZA2i1kHls+8bXid2OwGjxnkyw3oWDVrFL
         lORlxkzhppHwiGOZilVpa17gx2RFXjmHHIPpKw7Ej9/8V3aToNQeQitZu5IPOPbgTI+A
         e3waYrEkbZJGQ3xDk2NCVGXKoK7VQfpWJHxfbimB3LEr5SMJY5at6s5Pfu9TWRWUqjrw
         0Buvjx0n6P60da1iCYXjs1T1RJ/7cyqklp9Un1FubTLJDI1UrqvTnT1Hy/s49TPfh0QK
         bmRzqcAA/fB3HCn5XNywg8C1mrfDwLteo3ACQshSH2BE6lM2B/W9ZPai2vIEfA+ITSgn
         WFLg==
X-Gm-Message-State: AOJu0YxZGgqgMRbYAFvsj/xRNho3L1Df/Rg0mVThla1CW0HLrrZregX0
	oF2St2AQYLwj2rQvzntQ3aaIuoXxlNYkXsBVCIBMTfQK/mMahsp/ZpTZNj2TC0oKRsp2Z7hk116
	mO4sf0ufjr2F2E+olI1TuPGA4iuEvnGo=
X-Gm-Gg: ATEYQzxvJFGarg8tmaAXK1ylsUeOiwn7E9b/ZAM9ItQ9Kd+U5jYPedhfe3coi/Tt8aC
	37EuzeM90w2yZ8Wnft1yTSHMV3VEpINtY8K55JmvBMTJsjfaMIhvJRSEvEozZt0DaYJb/3aZCcx
	/bcq5exuPhSu9Pcy9NUBkh8LzObzZpIHPOEBP4uSDhcNm49NImqduhfTdUxA/K+qKtjU/EzG/us
	8i+YJHTbvWKTY3sKcv8VaNGdY2cSdZsbicfE80YhFo7xPK9XuEaavI/exuf87HUvAO13bOidNvW
	c/x2x0w3T70AXrfprJ9zxqG8IQM+BkwLPCjZYXM=
X-Received: by 2002:a05:7300:df43:b0:2b7:e929:856b with SMTP id
 5a478bee46e88-2bd7bd714f0mr2294576eec.5.1771904082278; Mon, 23 Feb 2026
 19:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com> <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
In-Reply-To: <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 23 Feb 2026 22:34:30 -0500
X-Gm-Features: AaiRm51UYCDeM2d-S4vq_Et7imkdUcHGxQWS_WzTcWpVEPCrFxigJEYHJb14OUE
Message-ID: <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] for-each-repo: work correctly in a worktree
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com, 
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Cc:+peff]

On Mon, Feb 23, 2026 at 10:32=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When run in a worktree, the GIT_DIR directory is set in a different way
> than in a typical repository. Show this by updating t0068 to include a
> worktree and add a test that runs from that worktree. This requires
> moving the repo.key config into a global config instead of the base test
> repository's local config (demonstrating that it worked with
> non-worktree Git repositories).
>
> The fix is simple: unset the environment variable before looping over
> the repos.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> @@ -60,6 +61,9 @@ int cmd_for_each_repo(int argc,
> +       /* Be sure to not pass GIT_DIR to children. */
> +       unsetenv(GIT_DIR_ENVIRONMENT);

This only unsets GIT_DIR. Is that sufficient in the general case?
Elsewhere, we recommend[*] unsetting all of Git's local environment
variables.

[*]: From the "githooks" man page: "Environment variables, such as
GIT_DIR, GIT_WORK_TREE, etc., are exported so that Git commands run by
the hook can correctly locate the repository. If your hook needs to
invoke Git commands in a foreign repository or in a different working
tree of the same repository, then it should clear these environment
variables so they do not interfere with Git operations at the foreign
location. For example: `unset $(git rev-parse --local-env-vars)`"
