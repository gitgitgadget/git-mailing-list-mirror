Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884723932E8
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242520; cv=none; b=fDYTymeG9bgClWlV8jZ8ewsREP/3AYlp3bWHuAwyzHfDuxPUYrh+8mqz+ELkCXP1RSR+2dDieS8UPXQCKTmdsKKJlbJVYhq9k1J5lVikkpXdhYJl1TCYCA0gKleVnPRHsiuJPh4OvAv6bodriSU1Mt1KeMyrZYPXkoEfhkB3mYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242520; c=relaxed/simple;
	bh=NHnBW/GSnijzWt9S6o8CGWmqH+LQBAdAyADlOnjFso4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqHbZzR2o+1rLxlKcV+XC0Lk5Xc5cixhqVBG30rdmlzX2bBEsf9x9zDo8SDkD2NUXa9HeoAFHHewro6Z7kt+WWQXg46a6eMlI5Mwlgll6P0FlMDbut9kSid7xu4h6DJkmd2gSLZAhTfyuJ5bOhLStRcTZowH0Gx4567wvv1vWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyZJf/j/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyZJf/j/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so4215205e9.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 22:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781242517; x=1781847317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYBryw2QYr2wSInjgBjqDM0vM3rKpt4GvaUCeLbWJtA=;
        b=eyZJf/j/LxyFUPAKle2urTXlJU2rhbdkdmZoCNsfKVD/QnL0YiwXZcYVA62mRjtj9u
         iEAQXKKoWxejIi+Mv35NHFApQLOY16Vsd3T6gyyGVKSrTraC0kyAVieT7JPLtGfbp88C
         KtVSgfM/sGaZpTFOrc40HyG8JPejQkb1voDfhgqAMKjCZIJsRqc5gU04uB0EaEXPT8Op
         ys8ndZ0BPxsKEBfV6AYa7UcXhOA/TIBNGnJWhBQvCWSplxkUu3Jvtj6k75E716f22z8d
         Agi9S1+S1w5wBcQOTLoERj5RjHBw04K1D4bMuN3TcMibGC+pSEMJp873LEOIHgG1PQF7
         1EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781242517; x=1781847317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYBryw2QYr2wSInjgBjqDM0vM3rKpt4GvaUCeLbWJtA=;
        b=VLC7g3RPHD3+rh+9WF+fwZTeFZX4U2FcBE40oOCzBLRGgg3AEoHrbcbPx7vem8LVmB
         HDXi1cpLlXaCe3WuC3ub7o0kz2DNUEsbGjURikYY5sFIfOVDb9h8XvPVQOQjlG7O1RQ7
         Yf4d+6xJroHuyfsf91JwJssd2FDmPsh8FO079VXvHLQlg1K3hZ59hUihAawbMIXYSQie
         6hL4T7r48+dQ8UR6qghofrDk6IEAT2dYebroK8lPJAxv8A8AlB2LvaEqbYhlmn4rN76g
         pCNxpbX7wWDUMWaKZUjyzcru3OzRz0Kv8wAqqr6jrVSUCr7IOAjpvvooszTvCFAgq492
         KV5g==
X-Gm-Message-State: AOJu0YxeyAYdVcS6M9Ve9yYir2zCgcT3jttGIKLzXwTufbscSEL8GmS5
	c6wi01ScnNThIJzFtWewGFfQiC/p5ubqHuYXQhQV1c8G+dBrTDP5hQGE
X-Gm-Gg: Acq92OEGsLPnmbl8W/xUkTK+ub6jDeqHB2HSLMVkOke1dxmoU/K68nZdSMQU88Rpmtp
	Omq3i0844dEb/BKY8OSvwQO7/t9eTyuyjmQI0P7d/tf6GHau9z1frG+ZugumsHlYYz783OJ7ejM
	aZ2O4U9g8BbF6fST9XyD0aCjaRiW0g5RW2fSxw45k7qvHKcdPzmNondX7saK//qUdmck+9QfS7b
	x+M/FTiP6usTppn0YkpqpFcrZe8BSeVSvYdQ42aGRyY770a15UE3oHIKmMlUr37UGt/DvaAqRHD
	XZ666NNiedoH5Hg1j+4AAt0QudSZnaDl3qbLpFhfMtpC5NVrFXZbfPv/HJVLdUFpPCw18XOG2OX
	Al7G1BXz1vs9Mcmr325z+XHK4lLQzHrW9nFK8o29BeQFD9BbBLfz23fAllixAifaBzA0qcZqKe3
	4ciWeX12FQRxdjEbbLihX5wr8tcbbRZNsGOs/Kq8mUgkQPiOLJKNtsowBludXHoADEHQZeOYbJ+
	QgbIeF8USDS
X-Received: by 2002:a05:600d:644a:10b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490ec50a39bmr7669445e9.28.1781242516586;
        Thu, 11 Jun 2026 22:35:16 -0700 (PDT)
Received: from localhost (20014C4D24E52C006DFABB7466B15AA5.dsl.pool.telekom.hu. [2001:4c4d:24e5:2c00:6dfa:bb74:66b1:5aa5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm2696184f8f.27.2026.06.11.22.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:35:16 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:34:55 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 06/16] midx: support custom `--base` for incremental
 MIDX writes
Message-ID: <aiuaf3fKJ6kIITrf@szeder.dev>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
 <1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 11:57:54AM -0400, Taylor Blau wrote:
> diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
> index 66d6894761b..68a103d13d2 100755
> --- a/t/t5334-incremental-multi-pack-index.sh
> +++ b/t/t5334-incremental-multi-pack-index.sh
> @@ -113,6 +113,36 @@ test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
>  	test_grep "cannot use --no-write-chain-file without --incremental" err
>  '
>  
> +test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
> +	test_must_fail git multi-pack-index write --bitmap --incremental \
> +		--base=none 2>err &&
> +	test_grep "cannot use --base without --no-write-chain-file" err
> +'
> +
> +test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
> +	test_commit base-none &&
> +	git repack -d &&
> +
> +	cp "$midx_chain" "$midx_chain.bak" &&
> +	layer="$(git multi-pack-index write --bitmap --incremental \
> +		--no-write-chain-file --base=none)" &&
> +
> +	test_cmp "$midx_chain.bak" "$midx_chain" &&
> +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
> +'
> +
> +test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
> +	test_commit base-hash &&
> +	git repack -d &&
> +
> +	cp "$midx_chain" "$midx_chain.bak" &&
> +	layer="$(git multi-pack-index write --bitmap --incremental \
> +		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&

There is no 'nth_line' helper function in this test script.

> +
> +	test_cmp "$midx_chain.bak" "$midx_chain" &&
> +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
> +'
> +
>  for reuse in false single multi
>  do
>  	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
