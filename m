Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A2E22756A
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332787; cv=none; b=IeF5BJIs7eKDe0x0yv5isfCDHPRbF9BARQ8syS05QeLZVmVIB8LmKNqD6DhnyM7/yyv5fUEPC1tGf4xro7P6q+rfXf1i4SkftjgWXq0XT/8FFGNA5HNQPyGOU+98mg/x8xGL+qsc2AxBxJfougG7Z7aGGkWKDiYK9moXfRdaSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332787; c=relaxed/simple;
	bh=nIINA5khcwacjQ6oAfc9FINasx2WFi0RM/kwAq3IGzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxHjiyqRHjmEvjES7uawFnaLeBURnjDdwf6SBZKa0Z3Ym8W8swwLsn0jaJOQk4ewZLJrQ21XaWlbLgpBCvzbbvKykvALA1JEg6decj31eCjEurAsHmHNwMyotviIPV7O212kZwCUmADLkjRVSJb8PzBKULLzMyodWJEUuEGrau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dixDr4jZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dixDr4jZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313f928718eso470984a91.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750332784; x=1750937584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/xvTrpF2haaUqk6TO/f1VBf3V6cwdAjNToTwlhZmmY=;
        b=dixDr4jZlVC7fSq/RRrPkD8+ot9YSSUG3wXIteiK0/tDcftrd1Xm4vaOdFVE5Z+ebY
         j59jfGxymBtTzBgUEv5mC7sQTVnbzPl3qZI2qn8Z/LWV4sJLqrmB98NPfH9AP7xvHpKd
         dE59CubPe9EvQaDAju837MejejMfgyHvLXfccau4StfNGkfsxZtOsMkPLMbS6yhFLaON
         4QArsRwytWwdtME/hk7uGrcT0evNX5fC/MNx5bvfjs2YCyozFXtXN6DPrUDKnF5tTnks
         an9zhcvLNuTt+yeXyg+fG96f7796HUpxfflscWhyQYnuJO82Mj15GijhxhBOoj7YIeHH
         2UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332784; x=1750937584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/xvTrpF2haaUqk6TO/f1VBf3V6cwdAjNToTwlhZmmY=;
        b=uRrn0NvEdutAQPEzrU/b2diqNCZNBfQzfs1F9ZUS9qvY02F3/ZOhuV56Nx6KaAUyoB
         9JSbBhvw+fUQ4CIGy74CpF3JLF04a4JBhD9UKpuJUHNBs46fqIClaK5p2jqTKzS6bGfq
         G4rQF18/vELgbnOIatYHkccoV+R/0I3qlm/7aLpRkNPJkfW60j45Ztd0WGC/Al7VRbfv
         xLvIkRuDy04v0fGJT6XYNGiKc17yzcc8xuQHQec7CiDPmA4mrr0O80Sl/QEoghtDAETw
         nKSTLoaPdSjfZYbYE0hTQidVVdNR+xEce/EmOEeHOOzeBRsn0lDwbKRqcCLNovWA6Ja+
         FH/w==
X-Gm-Message-State: AOJu0Yy8g+ubJnLYJtAZww6mRL/yiNECxupeoIqwmZHM4aGbBZkAcHS+
	4vCWf4JyglXIHeF1Hxx8yHdn/G+IdYHh5oW5kdh7Gh4VFN+DuumcULNM
X-Gm-Gg: ASbGnct/y2kzsRGxlxzBgfqxGjfWrXQPeP6Z5Y93TaFUWW5jp+QWsX+zIS3qM9ffuwo
	jTOblZGSkMggTEoz5hqfzv4DVe3R8u9FSTdKF2q5y1dWtjkWZjq2MvYpKlO8stzZ3dHTzKkLL7T
	IeC0B28SYMt5Qih31yuuF8RSk2gjJ2NqT7nBtSx43ngNE7f/Smt6erxSb30h120VswVhOYBhp8e
	DWZxBh7cy9CuHCxQsq321njXdaD9RvUW3F5GvUvq5p8a1ipOu71rAQAzKH1ShUTya9+4L7kh6xa
	krO5f4LCz9hTIDMRsRf03WdumlayOk6YUTP1XoTlQ1JmXhHA5x1KAxl44pjlPoApInfpqDR+c/w
	Gdr2pP0mX0AH6sa/OxyWG7w==
X-Google-Smtp-Source: AGHT+IGUgin4ROIR0WJjN39hPPjTBVxnkLq60ETZQzRm0bIf6TQr3w4tb9IRDLEwoIm7Cf2i3ywZzQ==
X-Received: by 2002:a17:90b:5847:b0:312:1b53:5ea8 with SMTP id 98e67ed59e1d1-313f1ce2aa1mr31450397a91.24.1750332784354;
        Thu, 19 Jun 2025 04:33:04 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:6060:cc4e:bcf:f4d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a331426sm1928768a91.44.2025.06.19.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 04:33:03 -0700 (PDT)
Date: Thu, 19 Jun 2025 04:33:02 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <lfrgmt2ukanevmcctzsnc422iv2l2nb3qmiddpsj6jnyvz4m4s@5eohhsm6knw3>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
 <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a069ef48f5a573c58a369b69827a40c7712247.1748473890.git.me@ttaylorr.com>

On Wed, May 28, 2025 at 07:20:35PM -0800, Taylor Blau wrote:
> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 8aebfb45f5..2b0a55f8fd 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -724,4 +724,94 @@ test_expect_success 'cruft repack respects --quiet' '
>  	)
>  '
>  
> +setup_cruft_exclude_tests() {
> +	git init "$1" &&
> +	(
> +		cd "$1" &&
> +
> +		git config repack.midxMustContainCruft false &&
> +
> +		test_commit one &&
> +
> +		test_commit --no-tag two &&
> +		two="$(git rev-parse HEAD)" &&
> +		test_commit --no-tag three &&
> +		three="$(git rev-parse HEAD)" &&
> +		git reset --hard one &&
> +		git reflog expire --all --expire=all &&
> +
> +		GIT_TEST_MULTI_PACK_INDEX=0 git repack --cruft -d &&
> +
> +		git merge $two &&
> +		test_commit four
> +	)
> +}
> +
> +test_expect_success 'repack --write-midx excludes cruft where possible' '
> +	setup_cruft_exclude_tests exclude-cruft-when-possible &&
> +	(
> +		cd exclude-cruft-when-possible &&
> +
> +		GIT_TEST_MULTI_PACK_INDEX=0 \
> +		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
> +
> +		test-tool read-midx --show-objects $objdir >midx &&
> +		cruft="$(ls $packdir/*.mtimes)" &&
> +		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
> +
> +		git rev-list --all --objects --no-object-names >reachable.raw &&
> +		sort reachable.raw >reachable.objects &&
> +		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
> +
> +		test_cmp reachable.objects midx.objects
> +	)
> +'
> +
> +test_expect_success 'repack --write-midx includes cruft when instructed' '
> +	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
> +	(
> +		cd exclude-cruft-when-instructed &&
> +
> +		GIT_TEST_MULTI_PACK_INDEX=0 \
> +		git -c repack.midxMustContainCruft=true repack \
> +			-d --geometric=2 --write-midx --write-bitmap-index &&
> +
> +		test-tool read-midx --show-objects $objdir >midx &&
> +		cruft="$(ls $packdir/*.mtimes)" &&
> +		test_grep "$(basename "$cruft" .mtimes).idx" midx &&
> +
> +		git cat-file --batch-check="%(objectname)" --batch-all-objects \
> +			>all.objects &&
> +		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
> +
> +		test_cmp all.objects midx.objects
> +	)
> +'
> +
> +test_expect_success 'repack --write-midx includes cruft when necessary' '
> +	setup_cruft_exclude_tests exclude-cruft-when-necessary &&
> +	(
> +		cd exclude-cruft-when-necessary &&
> +
> +		test_path_is_file $(ls $packdir/pack-*.mtimes) &&
> +		ls $packdir/pack-*.idx | sort >packs.all &&
> +		grep -o "pack-.*\.idx$" packs.all >in &&

this is introducing `grep -o` to our codebase, which is not in POSIX and
therefore will not be portable (ex: AIX)

something like (untested) :

	sed -n '/\(pack-.*\.idx$\)/\1/p' packs.all >in

will likely work the same and be more portable.

Carlo
