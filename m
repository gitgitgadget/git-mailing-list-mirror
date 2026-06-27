Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921A374726
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782543564; cv=none; b=qRe2PN9nbXsRucBt3MOeGv/mWvxB7FTROlWLmZsNIKm1bmZLYtcxkgpPMtSiC3v63hgaZNzCFF2G1r3FPkYbbcYmjKwIJyuXzP9rcbrUA0U0d1peQ82jlsl5eM6zaa1D3rpB7kEoMq4eikRkxMTQ52tO0dQ0bOMrC1dgVWi3v1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782543564; c=relaxed/simple;
	bh=EZIUsZ4xLKTPTFaJFkHBG1QzHu8b9vrOveP3kaN2DCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeHl8ePwqFsrok21IytHfZ5e9PJaGquYTZ4rbZcMoVflXbWEgfbaJ8lAS7D8OoGUUsVWAT3rjd6Ixp0wEC/sNhhWBoRYneS1jYucFQt+WXQieoYVLiQYVqxbuo9Vc5eRESBugKnEHVTeQ7j2xCipV5zBY9IezSL7GfNjs3NYY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg+XFitD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg+XFitD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso179232f8f.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782543561; x=1783148361; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHVd1UIjqKDnTvwHZSPOPEVEVnkWfCGsbjOawKKEAPU=;
        b=Cg+XFitDHB2nKWZGNIP/zoW0qWc+I6t9XDwMGCCY7Gww1LK2cPfmeR+f9E8pbOyCe8
         u31IHv/DchFUMt8Z3vvZVPXYvWXOXf1y+9ufkzLmFaammvopIbEg7MN9/6KdcsArNZqs
         9g2qdzZh1QQDDycM1EQyuDVujeBDjQiXpo13w1Yu8MAQXSjDxgNcok0uCoINHFPmTWuH
         RLrktseu6mQq1RT3wznHSgvHmf/9SlzFSoKZtbLfMDgx/zitSA52xx263wZM4gA8F8Ua
         zKIletFEUTRKi+MeFdIFpV74XGPdQDNXtfckQ1zwqgEynUC0JXlI8mnfXWK0RnSNL2Bu
         +lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782543561; x=1783148361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHVd1UIjqKDnTvwHZSPOPEVEVnkWfCGsbjOawKKEAPU=;
        b=VrUnhzZfINBmcD2XqZpNMb7XPrH/BKiTryCHHEGauR9TNYDMA5zntDsQC1HBia6kJH
         CavUyEgqWXdiGEqTxKVxpvMtlvug5NsBm6ONh4EAkgDJXMqRJ0b+GBr136Nl6Qka04ya
         xc7RPNHnkV/IvifMX/tc2sbEmOOccnlTulJx8kZCkarMf4qBU1iQqZ+73yHVNQOdrsJe
         birfMLdpHRNmUZFGW3vRDLn6E+9wykYnFQD8qTsaKD3pSLiiYUE0h0Do8NrZCjkImqg1
         T8p+wz3wZ7K7qk0KqvXECtM5nOopv+iUHgB0ELcc/oCY8cBOCn8jNE8tWTtIzIOBtdau
         fNiQ==
X-Gm-Message-State: AOJu0YzLnoa/w3YkSMWZyyWfTjramO+MW5O/rw1k6IGTNdzC7NTbUJyi
	bN3Qi+zRUMPV1B1kJTgeiv8kMOoYKzotdLdT/NcLJPfRLmuyhdtZYFBZFsMLmw==
X-Gm-Gg: AfdE7clvBc8IwnE5jOrHN0QV1NhcGi5BjYrNVC/ecj140P2c7Svd7kZKXTrFgY/EWtg
	h4UWdzRfIcLUfN2OJHNlvpu84uyYmoSX4Qw7iI0Gt3sbLqli7RSAvY0GTS2dsDzL6xPtBdZ6GKW
	1f8ctTcB2zHXEjyVtX1Zzpf8wLbULaZAzjPC7CX0oJ3RnlevoVId6XZ1J+OAxxIH+1WzXUij6DF
	6ExsfhRk9IPiNX70EjGT0CFnym+J/zxLnw3kigwsDMCf9yYC+HbFUTc/0YOyBlCNAT1s0XuVWKe
	2QiKb6yKYG7nrQT3mcro5XH5PmBXDqgpDdPWxiKKWnFRaauLBqJ6AfTvBc2he8+IV/WVHNe8vr8
	eXc+yJxxp2XJBmyFKDpU7RLdPNrYD/fUesGJCVymn6WibvBKVxnlzxsvc7bv8rZqZKQYjWKDj1j
	2onRTyH515UE1c65IP6I2t7HjeIfh7xRIvGfxaNggzKmBtt7vIdUD0Zdn4CEgwzPBZe50/40kmC
	Q==
X-Received: by 2002:a05:600c:1d25:b0:492:3c49:88ac with SMTP id 5b1f17b1804b1-49266847bb9mr125445075e9.10.1782543560890;
        Fri, 26 Jun 2026 23:59:20 -0700 (PDT)
Received: from localhost (20014C4D24E33B0043387749135D9649.dsl.pool.telekom.hu. [2001:4c4d:24e3:3b00:4338:7749:135d:9649])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690100c7sm151575585e9.12.2026.06.26.23.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:59:20 -0700 (PDT)
Date: Sat, 27 Jun 2026 08:59:19 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>,
	Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] t3420-rebase-autostash: don't try to grep non-existing
 files
Message-ID: <aj90x3DsER5HASUS@szeder.dev>
References: <20211010172809.1472914-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211010172809.1472914-1-szeder.dev@gmail.com>

On Sun, Oct 10, 2021 at 07:28:09PM +0200, SZEDER Gábor wrote:
> Several tests in 't3420-rebase-autostash.sh' start various rebase
> processes that are expected to fail because of merge conflicts.  The
> tests [1] checking that 'git rebase --quit' and autostash work
> together as expected after such a failure then run '! grep ...' to
> ensure that the dirty contents of the file is gone.  However, due to
> the test repo's history and the choice of upstream branch that file
> shouldn't exist in the conflicted state at all, and thus it shouldn't
> exist after the subsequent 'git rebase --quit' either.  Consequently,
> this 'grep' doesn't fail as expected, i.e. because it can't find the
> dirty content, but instead it fails, because it can't open the file.
> 
> Thighten this check by using 'test_path_is_missing' instead, thereby
> avoiding unexpected errors from 'grep' as well.
> 
> Previously 2745817028 (t3420-rebase-autostash: don't try to grep
> non-existing files, 2018-08-22) fixed a couple of similar issues; this
> one was added later in 9b2df3e8d0 (rebase: save autostash entry into
> stash reflog on --quit, 2020-04-28).
> 
> [1] This patch modifies only a single test, but that test is run
>     several times with different strategies ('--apply', '--merge', and
>     '--interactive'), hence the plural "tests".
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/t3420-rebase-autostash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 43fcb68f27..bbe82d2c0c 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -200,7 +200,7 @@ testrebase () {
>  		git rebase --quit &&
>  		test_when_finished git stash drop &&
>  		test_path_is_missing $dotest/autostash &&
> -		! grep dirty file3 &&
> +		test_path_is_missing file3 &&
>  		git stash show -p >actual &&
>  		test_cmp expect actual &&
>  		git reset --hard &&
> -- 
> 2.33.0.1279.g1a260bf8c2

It appears that this patch might have fallen quite deep through the
cracks... ;)

But the issue this patch is addressing is still there, and the patch
still applies cleanly after almost 5 years.
