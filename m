Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766B11712
	for <git@vger.kernel.org>; Sat, 10 May 2025 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746851975; cv=none; b=p6jE/iYjFYxIdgwA006pBcmdUBEMaAg6lpc9sZ/p5BI5Q4j30UqxD2GSvl1JZaaLoyr0626s5Kx3NWfRMfBhrFq0ILcByi4TFhEZMat9QGkc00ijVAis8n4N8B/UsaaaKsE3ix59PWiA691LzJL6OucoeOtrV82U1dstUs9AraY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746851975; c=relaxed/simple;
	bh=rXZoMIaPXsYfdWeFMrfld2qQM/aeXsW8IXzoHepAS+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3nzZhgdvLApkemjcuMqj8Fs1AL0F0/IImZDDL+cUpVshSSNp++3+rjchjwEiFNVItVOQ28ZuZbno7PSOKpooBVF5QKJ6BL2P+aP7DUTbcXn0f8S2h8+CLTgSAgTb4IfGVy5d6Fq2nWFyoZUr9XsM7FenC/bcPkh3h/QNXBzE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvnhPTLz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvnhPTLz"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d81ca1d436so23121915ab.2
        for <git@vger.kernel.org>; Fri, 09 May 2025 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746851973; x=1747456773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbWEjaPP+1P6DaMmPp+4DtgnogkDu+vZH6khZ1mW4EQ=;
        b=fvnhPTLzsqwXgmtk282tqiv+Hm4JpnMvXpaIhl4yiXj9OWxTLRDEE1i+6FXfaf5LNX
         3klAVdK7hwb4WeS30d4itAFSb+UQeD5iUH4XD94KqBYw1ytWUwu/yhcAxdHzbAk1HqY/
         WDxhsjLp0W7qy3PTjTLpxZmer8nKbXwaWkum6JPrft9th3RmfXKYcTRd4lyu5IFRX7ob
         kmSR6h1iT6iNz4upNpACafil4HmeQX8DX+/npCA1LiSmWn0XcPV3j+Fdb6YGl7HcRVJ5
         L7GW0r+ewojIVKdWC0Jtu017teHpPeLpS7Lvupw3Udc6gt/7OsSkt3KGyuAIYm8p4j1e
         SxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746851973; x=1747456773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbWEjaPP+1P6DaMmPp+4DtgnogkDu+vZH6khZ1mW4EQ=;
        b=j7zR60LWkprJUhYn+Pi6SI95O4ETG53Y9t+nZeRg9u8+9IpexXQNq2mjLawOTjIyDx
         NE8Amhjp+nNpsq4B0qo0t7mvZVQE+mbcXGGg6/rEgYjbwsVmrLSd/wUIqld7TFh0c1q3
         dH7VwBrYqMJIoi/xaDhKh6ohUfryE+iYlIkXprjtirfl1o0251o7YG+wosqX8hRxyvBs
         06unoayYLjHIRofyCy390prpwN9G6/ijpdw2LAyZ5N0TGFETUkz9HKriyqiVKXBxH7tD
         PzGMLqdytDTlE6NdfglJ2dlzMqyHr6BEdtwUclKI8tcVmTCCFtB7O+uJ/whKK3u2OUDz
         ltnA==
X-Gm-Message-State: AOJu0YzMAxWEevIesZlqVMoZ+2z2rUirRvcGdaW7yYR9Kx12r/DPx/Xi
	lWWP/GBJJdsyfKdpe3bPezFC3ZO3sfteSA9tgqVFVdh2HxKeXqAxLRLH2U8OPDyJWN41S36affv
	A5DdVPKsHfXZA01J48xbRJlplX+8=
X-Gm-Gg: ASbGnctAQVd0ZT4+zzOa1eOnOD7bpCF2FER03UFGBuEMgpzskLRZHnxiGjGy4pF3W5V
	6RPw3A1U2+IqPMvzFPRkZXEmJ6rq4p/rzwVRACEagblKFug4Oe9P/yucUIWKmeohPchviTnmBCh
	R4d8HPw3DYWW6hBYtPUMQxBrjOOjTCdYQFFK2r7Bv2/5kLeqJvxN7SCADb3cLqaD2afg==
X-Google-Smtp-Source: AGHT+IGsMFTOaUULdWjZjJdTgVpJCqMAT/cJg22YTR94t4nEk9JWJwd974H3oBoWC/5C0kbEAcs66PetySBlDUmH8DM=
X-Received: by 2002:a05:6e02:3185:b0:3d9:3a09:415e with SMTP id
 e9e14a558f8ab-3da7e211974mr81142615ab.19.1746851973031; Fri, 09 May 2025
 21:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com> <7a777281626dc5fa9b191efe25442e0e856950e6.1746579321.git.gitgitgadget@gmail.com>
In-Reply-To: <7a777281626dc5fa9b191efe25442e0e856950e6.1746579321.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 9 May 2025 21:39:22 -0700
X-Gm-Features: AX0GCFuid-TSbJou31Z0FK1aQm5y9MODBXIi2jqLlaLqIQqdPBmt7l_DvvBGu3M
Message-ID: <CABPp-BG4XOqsHmQyaTEju=ZNk5vjGidzqQ=aW+vFMkmscV5KyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] p2000: add performance test for 'git add -p'
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:55=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The previous two changes contributed performance improvements to 'git
> apply' and 'git add -p' when using a sparse index. Add a performance
> test to demonstrate this (and to help validate that performance remains
> good in the future).
>
> In the truncated test output below, we see that the full checkout
> performance changes within noise expectations, but the sparse index
> cases improve 33% and then 96%.
>
>                       HEAD~3     HEAD~2         HEAD~1
> ---------------------------------------------------------
> 2000.118: (full-v3)     0.80   0.84 +5.0%     0.84  +5.0%
> 2000.119: (full-v4)     0.76   0.79 +3.9%     0.80  +5.3%
> 2000.120: (sparse-v3)   2.09   1.39 -33.5%    0.07 -96.7%
> 2000.121: (sparse-v4)   2.09   1.39 -33.5%    0.07 -96.7%
>
> It is worth noting that if our test was more involved and had multiple
> hunks to evaluate, then the time spent in 'git apply' would dominate due
> to multiple index loads and writes. As it stands, we need the sparse
> index improvement in 'git add -p' itself to confirm this performance
> improvement.
>
> Since the change for 'git add -i' is identical, we avoid a second test
> case for that similar operation.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  t/perf/p2000-sparse-operations.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-oper=
ations.sh
> index 39e92b084143..3da6ae59c000 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -135,5 +135,6 @@ test_perf_on_all git diff-tree HEAD
>  test_perf_on_all git diff-tree HEAD -- $SPARSE_CONE/a
>  test_perf_on_all "git worktree add ../temp && git worktree remove ../tem=
p"
>  test_perf_on_all git check-attr -a -- $SPARSE_CONE/a
> +test_perf_on_all 'echo >>a && test_write_lines y | git add -p'
>
>  test_done
> --
> gitgitgadget

Very nice!
