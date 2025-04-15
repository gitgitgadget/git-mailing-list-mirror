Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025424397A
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756057; cv=none; b=qTbVRXYJVXcfgnwkr9oyfwO81xCpB/F744n8TYeWYFLxJzZGN1BCigEg/KDVrrjAoOkr0F5Dk7gY8QAOVe+Lk+D0pd1ZBVOzDLGN137mBOB7l2h1tx2ZqI5rje17gZShwRZUwg5wVUDd+CgbRUhjyN4rOqOJRXwnKF/1U9iAEiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756057; c=relaxed/simple;
	bh=+gkXka1qxst3nokZqTpj8vxuKtdCGCTg93zOY4CDnEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQrmnUr2UtyW61NH++55ARY0G902O7sPS73sLU5Q4X21cW3sfJP2Iyzhs7iT7Xxp75PcZdJYqbH8zHeH1sbPtPEj1aET9KV7WNwKhokjvn0kAieaV30BpN0vTe3yexUMV1V/1+vQvYSFK22WT68gOewprTGsHuiRiHRXyCuSvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QTVofSGT; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QTVofSGT"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5b8d13f73so646641485a.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744756055; x=1745360855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBq9cWDJEUkW2mIxrKcBolOngOkMM7P1mCJqg4KnoOQ=;
        b=QTVofSGTvQ1k4Qs7Y2JnVqfSoJH/vpLwfVM9hLipBZz/FeVTTOztoGKDq0rr1Gd+S+
         F8la/r3g+DgQxKn+0gaD8H9Ye72sXvuSi414uLx4UaQ+2N5DoxCIKditRnKbehBlP3G+
         JWmr/J943SE0xSrt9kEcjypoFgiuaGu4yHdnSYQO1G6Vjc2lFItYf+ftWk0tj+rqXxIL
         RDKZD6E0Nvm9BN1JsZwetck5BlHb1yjujCMmLrDx48gllSyLTf6dO1ZTtaxesTuzAtKK
         DHpkxfGbQgT4pFk6Tz8mM5ZPm5L6NA0GnhGSiRvljlWXNjgYvXBKJSJXG0Afs5gRMInt
         nL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744756055; x=1745360855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBq9cWDJEUkW2mIxrKcBolOngOkMM7P1mCJqg4KnoOQ=;
        b=OWH182gaWjqG7LjC8XY2Kh8cermHCIXGuTn2WNJovRezBsYawQo7l6YX1G1pSHldII
         BTjAu06rWXZaeEbBEBpNLnmnzlFE8lYmMNiVDv4lpK3a9vdTtS4Ix5CsWhF4BZXbSa35
         sQWzM/il9HRCnohPHo+mk4HxdzkJzyc0mwRX1qWdfcmzZnuhbDwbIlsmb4wmspiNUO11
         x4V2iqVnm6RrYzRjRcbqqlzcPRD4XIy48Jjb8LRECEi5CnjW4YOhT9qtNDqhJ3vmUUB+
         G+Aptf67HvD+TV1UqInIJfx3FQuZlmRtLpt88tkPq2VjRPc3wVZ1WMZmC8M6wEBVNllI
         wbeA==
X-Gm-Message-State: AOJu0YxBowJeXQ+lJ0zN5txlmD1mQcaVizcnCLXkSFvSEkfKmdfQ/t8i
	dJqn6bU6eKJnK4aPMBzxhgdmatnVlBW5kg5gBueP8eyFlgccr/jmRi7VvXwdxig=
X-Gm-Gg: ASbGnct9cNWrK42227QJEDYVSGQ8j0xdJT28DmU6aAR6ruYMyoNP8xMhs0qkTyCUx5R
	WPZUpzAROFlFGRSPno9gOurZTibeM9mU7U1RSsi7V9eWjsvUxqEb8SHgVNUfFJrLANJhipDa/0k
	9ZHOqDTb+wFdEcbeJssqsOTCTYhz1hihYtQPJKuFTfnclWL1+t2CoMCUCjGNYlSV5szjySrFmKd
	57u2DevwIgxE5Jy3KJh43vOoslIvRnXb7EirxmdydsGrx1bFdzSHSTurBcM3C+Wo75xFHfPEfqY
	4vNiEocT8XGHaAWFNUvthzZfPogcRI3chTJM/WlXHAKlqNr0sqXh2jQlrxU/MEwWokuBCIqDr7k
	Qu37KimagpY7M
X-Google-Smtp-Source: AGHT+IHWgj5OFjCLoZOjuX9Z1jBGL0wCI6/ALjBo4UI4wlSisvcNAv7Dkd02lS1vvIe6CRF/IysbrQ==
X-Received: by 2002:a05:620a:43a2:b0:7c5:d1b2:166b with SMTP id af79cd13be357-7c91415f9famr201792185a.8.1744756054898;
        Tue, 15 Apr 2025 15:27:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a895174esm960957585a.38.2025.04.15.15.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:27:34 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:27:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/8] pack-objects: use standard option incompatibility
 functions
Message-ID: <Z/7dVa+RnEqayEMf@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
 <xmqqwmbmpjbc.fsf@gitster.g>
 <Z/60anmKVxke0AVX@nand.local>
 <xmqqo6wxkxy2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6wxkxy2.fsf@gitster.g>

On Tue, Apr 15, 2025 at 12:48:53PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Now I can't un-see it ;-). Even though it's not a correctness issue as
> > you note, the whole thing leaves a bad taste in my mouth. I'll swap the
> > ordering to match the original in the next round.
>
> I do not think we can be completely faithful to the original in this
> rewrite, simply because the original is not consistent with what
> die_for_incompat() thing produces and you'd need to adjust the test
> anyway.  So unless there are other things you need to reroll, I
> wouldn't worry about it too much.

Yeah, we need to adjust the test either way. I just disliked reading the
patch and seeing:

    if (stdin_packs && filter_options.choice)
      die(_("--stdin-packs and --filter can't be used together"));

turn into

    die_for_incompatible_opt2(filter_options.choice, "--filter",
                              stdin_packs, "--stdin-packs");

since the check is "stdin_packs then filter_options.choice" in the
original, but "filter_options.choice then stdin_packs" in this patch.

Funny enough, the test that breaks expects output that mentions
"--filter" before "--stdin-packs" here, so preserving the order of the
check in the code reverses the order in which the incompatible arguments
appear in the die() message.

> Thanks.

Thanks,
Taylor
