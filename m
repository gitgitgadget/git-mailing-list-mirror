Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B3421EF6
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603833; cv=none; b=FewUCxXhnNOudl58Ms1jOhq9LGZbKonWJbH9GroNDtTj+w9WocAgNtPxzgKDi0CCgqTgp/AdS4gYV3IiuaxxiD9Vi64YtW0C5MUZ/wJo7mH4i8QbqOW/xidtOQxba6tCUEP8ho3B/JjOKuW9/nI1AwtOOHKtO3D1UaIQn/rUiWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603833; c=relaxed/simple;
	bh=v78NEEwbTzAQmrVo40dgXIP8vBJZO3HQcW+Lv/0Ktqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbqvmcUmJYCDQGrliL6SgQTnHJSuzYpZWgz7tIxOFqkPMxB5cK68Mr3QklR31foxUAxIqSXtCwBjLyPfdM1n63h7OMNazKZafXTNAGwQedCjQfFnPk64yhD8MybgQy1KaCzJgAJFKKnmtiDIQqRWVgmOAHYIad33AwwgmzdYogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdDlhzFD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdDlhzFD"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c0115a3794bso449788066b.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781603830; x=1782208630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8d7rnrWAquwzY34v2jhr3jmjjOwNULifz4GzbsYSaZ8=;
        b=CdDlhzFDDLeH/PjaRUnt2uS3z4hhTMzSAdC2vj+JNFy0TT1UX0BVyuiUpT16kLl4U4
         UOGMGjZ+iYHkBYCsyR7Xmo50QGbNbfIED5h2kTiQ6dGb/MPW4QDE0xDNOY5pI67g13e0
         snzDAv3ltvT35L37bhkUSvWsXnDKwBYibC9jzuKC3zSx7JWaRdM5vj3956S8wVZb9rZB
         FS9auCM5I2uuCqKc8KrDfk1+I9wzf8wgd7dZmparGj9cTsh/z7DZRoUdfXxTcrvjf24M
         PPzbtDdz7XVcgHw5Jgq+FDE2C2JRNHJVywChJ+pO26/x7a1kwyXiLmRfl3r0O771mmLl
         c5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603830; x=1782208630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d7rnrWAquwzY34v2jhr3jmjjOwNULifz4GzbsYSaZ8=;
        b=oWnhkTt+yxIJED/huVQDHtBjMtyzImR/fnU16qUrsRGVrzTKovk5U96+j1SOuBZlBD
         E9MddsqcmeItMI1m0aw2YPlZwcusDiIg7Wp/dWwAw4/19BEKhnIoLMU/gk8BggauBcyi
         S7Q75sL5kfcr3u5F16Tt/1PsJ+vgEfd9dS82GFiqIWS7towfZ5V2428Hi3CUCnoqezH9
         hlcmhDq/cLvKL20ab594Ay87gnwBVvkaJk7hKyQnG/M2ehXg+CETme0sL4VB3sT5Swts
         ZXS30W6ailjzBMb7izkYSOr9ednkKiYtD0KNq6HZKru+6VEql5uRGBhecyDMeNiUneey
         g2ig==
X-Forwarded-Encrypted: i=1; AFNElJ/SVct+/SeSDyfRqP/WtajL4JYodr7jSE4G8dnTXRhtVGWS5+DeeWiWqXrc51zZY9Kh0Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc+G5wG47Njg1UTPAFBJxnqdaZ7TvWMDmvljvEHnrlD6peBGs
	MQ+TFnKugGynXj0FloFPKdysb+oH2gibhI8OHpYiCMFzjhH4Xj8+es0y
X-Gm-Gg: Acq92OF124giS/gGBpBSOM8YtHku7wjL4AISUWcktXzYP1vfP+E3nrrv6pkKOZw4mMS
	B8V6w/2u/UUXlZrHXpSzUb0qcLme3nZcPdom39N6poEdt7Vjxc7eMWYVcst1Vg/5vTLZ2RQm6Pr
	PCoSFRCh2iWiY65wXXQva7G2uVZA4LmP2c8qsLDy4umUWFh0GSwBGlF0vY6pOSUDBkdnxVvwOfu
	X5xPNDsJNfL/XChMyOUSme68T26uZWVlTDxGKHCYvrBDyPBw/JALNDrfPfZoO4xFSJLY1T8cqfD
	rSbIUia9kGiHhwrEWIuc27H/CPk21cWF1JCca8xcnU8Vol3E12gOy7FbWlRjzNqHHwDcnPQSnIY
	dMgfX8PR5Z2jI51gVmQMKrr5k7Ec/NL0pOQFvPxmoyMuFymu//0eOdPk3wiOxYn93UAoZyYOYs6
	2xsqvdFGfljiz18ZT1o3EJpriEspi6txUB2ay8bTHpFsS+omeAKycRB6ABprTZE86vYX+uT7L9D
	Ny9mt06KH4=
X-Received: by 2002:a17:907:7636:b0:bf8:6011:53b1 with SMTP id a640c23a62f3a-bff49620fe4mr442048466b.4.1781603829833;
        Tue, 16 Jun 2026 02:57:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4420823sm621199566b.4.2026.06.16.02.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 02:57:09 -0700 (PDT)
Message-ID: <7b43a0f1-32a0-40f0-8c82-d2ee78809cc2@gmail.com>
Date: Tue, 16 Jun 2026 10:57:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 6/6] branch: add --dry-run for --prune-merged
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <ede8c6172963fb8d15f0ae28f4e11501cf42be6c.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ede8c6172963fb8d15f0ae28f4e11501cf42be6c.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> With --dry-run, --prune-merged prints the local branches it would
> delete, one "Would delete branch <name>" line each, and exits
> without touching any ref. The same filtering applies, so the output
> is exactly the set that the real run would delete.

I can see this being very useful.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 52a0371292..7c52a88af2 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -717,7 +717,7 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
>   }
>   
>   static int prune_merged_branches(int argc, const char **argv,
> -				 int quiet)
> +				 int quiet, int dry_run)

Let's not start adding multiple boolean augments - use a flags argument 
like we do for delete_branches() - if you get feedback on one patch you 
should think about whether it applies later in the series as well. The 
rest of the implementation looks good.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 3f7b1fc3d6..305c0141fc 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -2040,4 +2040,48 @@ test_expect_success 'branch -d still deletes a pruneMerged=false branch' '
>   	test_must_fail git -C pm-optout-d rev-parse --verify refs/heads/one
>   '
>   
> +test_expect_success '--prune-merged --dry-run lists but does not delete' '

A good way to test --dry-run would be to add it to an existing test 
before calling --prune-merged without --dry-run.

Thanks

Phillip

> +	test_when_finished "rm -rf pm-dry" &&
> +	git clone pm-upstream pm-dry &&
> +	git -C pm-dry remote add fork ../pm-fork &&
> +	test_config -C pm-dry remote.pushDefault fork &&
> +	test_config -C pm-dry push.default current &&
> +	git -C pm-dry branch one one-commit &&
> +	git -C pm-dry branch --set-upstream-to=origin/next one &&
> +	git -C pm-dry branch two two-commit &&
> +	git -C pm-dry branch --set-upstream-to=origin/next two &&
> +
> +	git -C pm-dry branch --dry-run --prune-merged "origin/*" >actual &&
> +	test_grep "Would delete branch one " actual &&
> +	test_grep "Would delete branch two " actual &&
> +
> +	git -C pm-dry rev-parse --verify refs/heads/one &&
> +	git -C pm-dry rev-parse --verify refs/heads/two
> +'
> +
> +test_expect_success '--prune-merged --dry-run only lists branches the live run would delete' '
> +	test_when_finished "rm -rf pm-dry-mixed" &&
> +	git clone pm-upstream pm-dry-mixed &&
> +	git -C pm-dry-mixed remote add fork ../pm-fork &&
> +	test_config -C pm-dry-mixed remote.pushDefault fork &&
> +	test_config -C pm-dry-mixed push.default current &&
> +	git -C pm-dry-mixed checkout -b wip origin/next &&
> +	git -C pm-dry-mixed branch --set-upstream-to=origin/next wip &&
> +	test_commit -C pm-dry-mixed local-only &&
> +	git -C pm-dry-mixed checkout - &&
> +	git -C pm-dry-mixed branch merged one-commit &&
> +	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
> +
> +	git -C pm-dry-mixed branch --dry-run --prune-merged "origin/*" >out &&
> +	test_grep "Would delete branch merged" out &&
> +	test_grep ! "Would delete branch wip" out &&
> +	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&
> +	git -C pm-dry-mixed rev-parse --verify refs/heads/merged
> +'
> +
> +test_expect_success '--dry-run without --prune-merged is rejected' '
> +	test_must_fail git -C forked branch --dry-run 2>err &&
> +	test_grep "requires --prune-merged" err
> +'
> +
>   test_done

