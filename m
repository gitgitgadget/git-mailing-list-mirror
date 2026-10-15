Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D73E0C6F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083590; cv=pass; b=BGPrEcoeJEZXw32LVxHEta77w6k8+O3LejNNyr4uJu62YXEkSCE7riPXRxeUAkC3WMD4WnCCzbcpDCXLc0ZgO+c7wH2ZrPHlcvrWV9IMcvpggcfRx8qLUtMAa3njwGpCXz2DSPNYARkLQvjzHP4No+Ue7TaPEqzQWbvQcHuu6fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083590; c=relaxed/simple;
	bh=mk5j9CFw5svqL/rz276Q/9DDcIls902cpj9/j02I7TI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJxJz5RdNjUmeBxuot4V/O/Ni3fSYkSc4kco/WrSVKmnMiRfIj7XZMAJu5/w7neU0cq7q11R/ZlzK4pOaldzPV7fJJegSX7XXSUihm4RzXeav/MrjLnhQHBuj7eHAGFHivmBRxmqQhO61GpiM1Deupq/p0LkNuxM1MUtxWiPnqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svoRZSIZ; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svoRZSIZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2055573c8cso713215466b.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792083571; cv=none;
        d=google.com; s=arc-20260327;
        b=NnKLzP8WYYh5Wy6B3b4QAQ/OL1FZ0RVZwNgBamxPt2ydyKQkykkkICIN407CrrxTML
         WYAtnxOFA67rA6twsnnsfQRpyXZz/PaQMJyLm75RHMW180G5L7TRIdTWdRvrmWipRhZk
         ZUmybZgY4bqH/Sx8LdFdqAqah4s3ZFQtk3Wm2I1KQw+qL79mn1s2rutlcE+gLvyl0sfP
         UdWWW58B+BsOWmMTwE5ojtexJHhA4AU+0MBNlxdcor8ZLTVa38nHFcPvMMIzREFr+Tgr
         bBDIiNoMw0ZRqe9eC6O6t4kkgx5Bi+z6Eu3DR6+7wPNfVFS/tioi7oBiAKXn6XDYgKPl
         X0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PpqPzuBgePieT2FIucIkF1ezWAp3ZzxvRa4Ca/eDxA8=;
        fh=CnX4cmA08HLBIymu/PwW3vmU/KVxlZcSsjTDObVVhac=;
        b=UktCPIuU09Fry+miZabKIuqvhn10I/UlgJQaVxYm7wDxh/xhYrrBcorHwxAOlrLna/
         f/sxwrWrM1JXT65S0vLsYlKLc/1PWQ+XOuKo5SGhrRFSI2doxTsePUz4xBn4RWh8vLpq
         xSNUXotniPzaZLH3cUEG9uVYSZCnK9oOuslXWpnbmblO1RrEYX4pp3BuD5TxaTDrLzlW
         0eIg5zcIYSq5HZsWx6s0hJgGrFs3tLXRWazvIJERfwWd+STRz2yTOplWTpfb9WTB7GSg
         vCzY++UcauCUQ5qBz5kk6M4+K2ySdMD/NI81YjiZzKKYn2j8+Rr5ryLQWuQFOu04AYSh
         uetg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083571; x=1792688371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PpqPzuBgePieT2FIucIkF1ezWAp3ZzxvRa4Ca/eDxA8=;
        b=svoRZSIZz0CQjnxZ/f334YHCjeFDQNdd34imVIRKj3/l6Ivdj1jIljn5zZ3cfkKL1x
         zj9tR5MpZhUAAOAaaZSdR0x1tC95Y5w8nSvheJ+rvNDk6MztqJvvpbv+wQvir/EUpTMU
         WD8/ltmMzi4FuLzPvwBcxIcHiKileyVNvjCItpTGzTt7vaFbmbLjpyK+xph3/45Hfcjn
         t66pbQPXk3x4uYinbeh3qoGWGMO/evvxbY1fQYM9LavfZJWF0mCDMHIeFLMtyPeGbxLs
         E6Kvs4Qd+llfG3GLKSZUQ4dPwlKkFnwVM2oY4sY02XyYTGIa8qhpCVqjBO3zJ2geYdU0
         lTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083571; x=1792688371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PpqPzuBgePieT2FIucIkF1ezWAp3ZzxvRa4Ca/eDxA8=;
        b=CK4iyAp9hnJEmRsIbmOF5/Appm2jnwtJKrbmuAEWdjgkITKpRHa5LuEGDI1ArK08rr
         3pb/8iTmSC0QsSXU0kSFP6RqY5v8f7PCwFXrSkzq3cLKwf7egjRuI/N4pLK8Kxv8s7n0
         H59gaYImr+T/8yWqaMdcNPPXeSho9USAh3rpg1HU6B5IOt/a3Ed7RbJSWzC3SKvFy88s
         esIU9PrGPTywzoJ7hszQmVSOL9K027UqWpJgmj0Q5wyHhMcvXR/w5/ub1+UTjejynJem
         uK1TcUfy12oUeoicZsR0BugUbx6HZw+/B0o0Sd1pcBuGy5sLYlGLSh3fVZqAuSxNqj9o
         4/cg==
X-Forwarded-Encrypted: i=1; AKwUvBw0136KWInPiVgID50zOYN/ZSDk6K+bgs1w8aM16CmE3pJM/s7P0e/avb+rCkUAGeqnsFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRTKTH6GzVEt8e7O8o/RLILm5Kd8tYlHN2pr1B5PDSH/enQnL2
	DFd9Bg/CAbrt3ma91A5JyW8UoetlZqAxS+vIgQ26IR5KAPysiIPyl8uNkHxMIhuNhvX/qqxCU+7
	+eOQ/nzHNygsEcmnjI620H7i2YaiFmIQ=
X-Gm-Gg: AYBFou1P8H5EfKdNKPPfSZXfDRiPUc3BvaCdVCwBArzLq3/7mvShJPQkNPgDdb+wY/F
	wAaFEISjMOoVoXSTcY3puVKWT6JLZEV3IZ601lbMoQabc84H/Q3yJvFRmJVM6Tvj5YrPY3QCnYw
	/6zIwqZSAZKLsm9KGDl1dsjugq4HAB6WaP/cBtyiTIsfl+xf7igFqPQW5G6g4O4d9mR1xDTz5Zx
	Bpjnz2HHsblwslN9GvHIf/WlEQX2zUp0a2mmYGwLDKWuZ8DiW/uPyuzSwAYVTE4amyd/3Txau3f
	wUrbTFJqA25qRBaSlMHnaELsInBWWNN9pWJd1I+B7d8gqMsqka0pnDozlOaJB8nD4RpjZIy9VVE
	B4zWHs64EfKw=
X-Received: by 2002:a17:907:3da1:b0:c2e:61e:f4fd with SMTP id
 a640c23a62f3a-c31a9a07772mr1745825966b.5.1792083571474; Thu, 15 Oct 2026
 09:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 15 Oct 2026 17:59:20 +0100
X-Gm-Features: AclHuK9h52gpAKUDCtEtM3XOAubg5PaKekNJLLjzNVBns7eA3d5v42nUNUNiyK4
Message-ID: <CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

>
> try_merge_command() and checkout_fast_forward() already receive a
> repository, so use it instead of relying on global variables.
>
> Add a repository parameter to merge_argument() and pass it
> from try_merge_command(). Use the repository in
> checkout_fast_forward() when parsing trees.
>
> Remove the now-unnecessary USE_THE_REPOSITORY_VARIABLE
> definition.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Good catch.
> ---
>  merge.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

> +               strvec_push(&cmd.args, merge_argument(r, j->item));
>         strvec_push(&cmd.args, "--");
>         strvec_push(&cmd.args, head_arg);
>         for (j = remotes; j; j = j->next)
> -               strvec_push(&cmd.args, merge_argument(j->item));
> +               strvec_push(&cmd.args, merge_argument(r, j->item));
>
>         cmd.git_cmd = 1;
>         ret = run_command(&cmd);
> @@ -68,18 +66,18 @@ int checkout_fast_forward(struct repository *r,
>         memset(&trees, 0, sizeof(trees));
>         memset(&t, 0, sizeof(t));
>         }
>         for (i = 0; i < nr_trees; i++) {
> -               if (repo_parse_tree(the_repository, trees[i]) < 0) {
> +               if (repo_parse_tree(r, trees[i]) < 0) {
>                         rollback_lock_file(&lock_file);
>                         return -1;
>                 }
> --
> 2.54.0
>
looks good to me.
