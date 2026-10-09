Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A933EB06
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559124; cv=none; b=nnM4C5iaAOoTwHkcyXNxbeSTmXsmzg8Sn5NJwXhLusdy4XkcjRD5FLDdqoTmIm9LJI2499Ylm5mWuD80GW/wHZj7GDf0dSPf7fsWCaWjcLall2Yd7Ey9ypxR4lY1a4aUM0lw09qzLOBT7m2MeE61yLPnnqil0qm2hx6Yxnb7P9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559124; c=relaxed/simple;
	bh=hc3GqRw1stW/g2Fo1SxjPHAO8F/N2+cP2ClAIxgnyRI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYx5bV2lefjseFVCZncPANzTN7ElO4SI5R4C8d8FVEblhYBhwdKan+8kT5BJVweARUX/6o3XgAhxoN5IxtHDsB+IBGlbD2WTpMIr2n6GYipiZ6sPWRZlIom/Wmz8F9ZtZU+w3cyMeY1BASR/N40uiz/VL1mg1S3UyypdUQ8qALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5RybhEH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5RybhEH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso26985955e9.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791559121; x=1792163921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfBeA3qNtDR50wnma9w5th6EFik8gO2uBNB5bcfluYQ=;
        b=K5RybhEHsVMgmvagme4LeAKA7s/vXyghRpEeT1OT5BeBQm0/Lj/Rrkpv9Jqrll3RwQ
         YPgwAJ1nH3MR1MRJBrkJoHh5Yz08hv1pH2XFZg6TI34CKNt6Pp5645yW0c/o3pNv7r6n
         a+k0uksjsMFyT60IkvLf7hMxRe02A/t2oHEZdMdnFrA53aIR6Gr3Y7NuA+cjKIjU7o6S
         wotqUtmJao36+LxDqKKW90peKgL9+/3g+UJGx5DMdVcWEvhpu1EQ6M2YNaWg2zlMJx3E
         3ieoUojhUTTf8PIY3OkvySbBhhdeWAxMS9pwGHx6XVh2zUcZ1ZKl1hPCt33bCH72i9sk
         IQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791559121; x=1792163921;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfBeA3qNtDR50wnma9w5th6EFik8gO2uBNB5bcfluYQ=;
        b=VQeBu/6W3+oDdS1DpqvOGoS2QUW8gf8fS21Yylbmpj+TEcTYcbWm3jkoxLr7ca0Dpl
         Qpe1hO4TXxwsDdIJXEWyow6FzYDKSnu/DdTMiaVvE0Ih1kqfI86QVv6MqGp3TF+vNZGw
         Dqa7JCYMwTHRg95V9x5RfEHnvgxMz2AGaqYNf6FlmZOSZA76Rt0ISqkbW/fKFDXbY0v2
         1YxLqtRbFFXjhmSIxQ799+JCB+LsCmVj2r1FHrToeMGZNuCnNAnpqn5LDTGq5sxSvRvl
         dSEu9lrgBJoKziCe8qhW5505PfoLJRv+tF7fFuLBD2quFV4HQhXo6/k4XAqAUMj7T+GY
         YHqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwLBRkY6lMcKR4MDmlbvVHl5YDkYLwWh6hmjRfKaLbKL3C/u1PUYotmXkjbaWIKs+waTNA=@vger.kernel.org
X-Gm-Message-State: AFuF++mgzJJFXFxS/kyPwP3AlrkBLTs8SgsGBz9AF4AbGRnzS/fQPxot
	qxu+9E8KNO/1MaT9g2kmwPCoMjeeCMNWjl6OaI6ZKrwRu4GdcXVaqBxD
X-Gm-Gg: AYBFou0HNSL5poO+tSpvXix+7gI15JS/ftXrStC4b+Uu4BhkyBYgQHJF/P4ahPtuaAS
	e/zHcp0AcsOIzxZTrJQmeQI+FDMJ5ekSBklIi6SNOULPa3TNCj2b02f8m7baeFkS7u3R4pvueGz
	74f3+BunXEjfCoC2a1QL9ZmwftwsJycrIzlEWqggnRQbkzXpCVPx/t/97WY7JA1PK0CsaSDwPZK
	jq6E6ROZsxYrMfY3OaWK+XEvinF0qWGX6nFgk90TLv+Y1DeniNgbtdriPqvDlXwrfRngCmtU8KF
	QmwbJSuXU/gTtDp3k/qVGuB2cVq+0z4H1YuVjKgzdO/OBoNU7ZTUSog4eZWOSBzQajFqYzMCp8q
	iPsb1/s79E9Zf95w9E+F4F3GG3Zwuj10KGhpst2qdJYRxkD9La/c/8eQigWDJdplNl+y7F2xKVj
	Ggn8suTbhikHiWqD7q1uzVX7ps3uHh9jAcJFK9d5xk9wwwxWxYGR0mH+6HqiXTWU6IF+bZqetXU
	ei1OTjRgmWEUrw8lnv1i8B5R0ZPKeKsdF9B/JL1lp96iDMjHawl
X-Received: by 2002:a05:600c:6097:b0:49f:bd3c:bc24 with SMTP id 5b1f17b1804b1-4a18e4b8885mr43701115e9.31.1791559120531;
        Fri, 09 Oct 2026 08:18:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18dcd7dd3sm36676515e9.2.2026.10.09.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 08:18:40 -0700 (PDT)
Message-ID: <3e43682f-6dbf-49fc-91e4-2019f3c13f48@gmail.com>
Date: Fri, 9 Oct 2026 16:18:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] status: suggest `git merge --continue`, not `git
 commit`
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
 <pull.2249.v3.git.1791558823445.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2249.v3.git.1791558823445.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julia

On 09/10/2026 16:13, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> During a merge conflict, we suggest using --continue to continue the
> merge for rebase, revert, and cherry-pick.
> 
> Change the `git merge` advice to be consistent. 367ff69428
> (merge: add '--continue' option as a synonym for 'git commit', 2016-12-14)
> says that `git merge --continue` is intended to be a synonym for
> `git commit`, and the `git merge` man page already suggests to use
> `git merge --continue`.

This version looks good to me, thanks for working on it

Phillip

> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>      status: suggest git merge --continue, not git commit
>      
>      Changes in v2:
>      
>       * Use git show -s --format=reference to format the reference in the
>         commit message (thanks to Phillip)
>       * change to "conclude the merge" (thanks to Phillip)
>      
>      Changes in v3:
>      
>       * Actually format the reference correctly (oops)
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2249%2Fjvns%2Fadvice-merge-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2249/jvns/advice-merge-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/2249
> 
> Range-diff vs v2:
> 
>   1:  afc69ffeb8 ! 1:  27678e07a8 status: suggest `git merge --continue`, not `git commit`
>       @@ Commit message
>            During a merge conflict, we suggest using --continue to continue the
>            merge for rebase, revert, and cherry-pick.
>        
>       -    Change the `git merge` advice to be consistent.
>       -    Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
>       -    `git merge --continue` is intended to be a synonym for `git commit`,
>       -    and the `git merge` man page already suggests to use
>       +    Change the `git merge` advice to be consistent. 367ff69428
>       +    (merge: add '--continue' option as a synonym for 'git commit', 2016-12-14)
>       +    says that `git merge --continue` is intended to be a synonym for
>       +    `git commit`, and the `git merge` man page already suggests to use
>            `git merge --continue`.
>        
>            Signed-off-by: Julia Evans <julia@jvns.ca>
> 
> 
>   t/t7060-wtstatus.sh    | 8 ++++----
>   t/t7512-status-help.sh | 4 ++--
>   wt-status.c            | 4 ++--
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index 942ddbbf0e..a9b435b5e3 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
>   	cat >expect <<EOF &&
>   On branch side
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -141,7 +141,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
>   	cat >expected <<\EOF &&
>   On branch main
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -174,7 +174,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
>   	cat >expected <<\EOF &&
>   On branch conflict_second
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -198,7 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
>   	cat >expected <<\EOF &&
>   On branch conflict_second
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Changes to be committed:
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index aca4b6d332..f2e712ac39 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -31,7 +31,7 @@ test_expect_success 'status when conflicts unresolved' '
>   	cat >expected <<\EOF &&
>   On branch conflicts
>   You have unmerged paths.
> -  (fix conflicts and run "git commit")
> +  (fix conflicts and run "git merge --continue")
>     (use "git merge --abort" to abort the merge)
>   
>   Unmerged paths:
> @@ -53,7 +53,7 @@ test_expect_success 'status when conflicts resolved before commit' '
>   	cat >expected <<\EOF &&
>   On branch conflicts
>   All conflicts fixed but you are still merging.
> -  (use "git commit" to conclude merge)
> +  (use "git merge --continue" to conclude the merge)
>   
>   Changes to be committed:
>   	modified:   main.txt
> diff --git a/wt-status.c b/wt-status.c
> index 57772c7501..238bb48643 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
>   		status_printf_ln(s, color, _("You have unmerged paths."));
>   		if (s->hints) {
>   			status_printf_ln(s, color,
> -					 _("  (fix conflicts and run \"git commit\")"));
> +					 _("  (fix conflicts and run \"git merge --continue\")"));
>   			status_printf_ln(s, color,
>   					 _("  (use \"git merge --abort\" to abort the merge)"));
>   		}
> @@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
>   			_("All conflicts fixed but you are still merging."));
>   		if (s->hints)
>   			status_printf_ln(s, color,
> -				_("  (use \"git commit\" to conclude merge)"));
> +				_("  (use \"git merge --continue\" to conclude the merge)"));
>   	}
>   	wt_longstatus_print_trailer(s);
>   }
> 
> base-commit: 5a7d1e8045ce66c908f62598e26cbb8df7b39a90

