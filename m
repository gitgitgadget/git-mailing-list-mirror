Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D253FE5
	for <git@vger.kernel.org>; Fri, 23 May 2025 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747960287; cv=none; b=FkoQDVw2MJlhyvbIrWK7ZmdtoR6Q0Ss85XFWsjP99DCSxiOcDfsEAzdq45B27trHG9EsTRwL4ENDJfUzai8JaT/8sbNclm8PVSV7qVpIPSa3oATxfpzoIhPrcerzH0W/yUUeOTAE5F0C2I34UYHaKpnqQ35Lm0yLFHYygZimqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747960287; c=relaxed/simple;
	bh=2NOibofuYuuQ1phwJYv1Vw44Pf+JGR2Fsp8uWcesYsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKmZg7xMriRZHNHgVn8itgjIWXn5CMqSW+2kfThir619iRN9lF4LYNVOeb85iGxf62TraUBnO9bEJA57ncmjUbzVqExF34mYQNW3xa3z6Lin/uFI/Z6wKq+ARJn2ub1U/6ogEAeCMrhOeWXep61f1UwKGoLZqde6QwcZd10kndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JRgAMb7v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JRgAMb7v"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774d68c670so124880301cf.0
        for <git@vger.kernel.org>; Thu, 22 May 2025 17:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747960284; x=1748565084; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbe7Yvu3Pg747C0TjhqrAlOs3CqjuO+odfMCG1k4OVA=;
        b=JRgAMb7v6JzzFyRdoN6tRVkNuUhsPsf2ZM8W+vqY+vR9uIU6r7Sfq96MYWd8hjcbgC
         h0pJtfUqh7k5GwiXD0qRPqeoDxF/L9Sw1FyafQwvcOUaveAIr7Gr61FrggcAvQRPr8tB
         rM7Wqx9awz5wrVHbtbVRchZe1AL4QN+Q2XPrOmXmYegW8l+KaW74774/wxsQQMQlh+CP
         tEyMY96W6lgzZLYjYWkq7spyajXfM4IE/eGsjaS8K1WoeFTT8kemRMpiGZHfdVHFTjMc
         j/FFnhHBsv9FC18VKDhxeNeElhHUGSu9bcVgvZchHFOie/bEp62kq5jK2y7tzdPUF2Hn
         Rriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747960284; x=1748565084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbe7Yvu3Pg747C0TjhqrAlOs3CqjuO+odfMCG1k4OVA=;
        b=J1eQQM5XEicEXfHdtPYxDZGd5kPcz2IZyZd4ezv5h64rJkhXwJWdtPsIEg5oeO2765
         498Tuz1lvPS/WgF0e4HK2eqhxqkrgA+mxKEaVmKJxtA4dGwYqGLsXzoDSoYG50hhnZaj
         vjxR9mHHZPJSlPwzfRptaAugfQcPWqgst2onvN18vAne5dKtv1W6yZtk2CskYcjeaYE+
         Uav9OXSjD4Yuh4fwu/uxjZk+lWNMZ5T/5TB89rXQkq3Ik3esxZAuv8BJCx7g4Wcz8Mad
         JnvrEj68pSPi7qR4IdELTdaX0sdeR+PBRBZYfnTwqj69KVXp/EYI+N0uvTdDSR5jLYAi
         fGWg==
X-Forwarded-Encrypted: i=1; AJvYcCVcN7nUWEEz8oBG1HdEJkrVXbuuTc7nmqeeB2dFzJ3/qk261LXdKW6KLws1t2XK5/7mEIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GrkRoGtkuc5hlHG4zR8Z9XF2Zn2bx1hfZFHDc4OX/3GhadDT
	jnbgWZuJ5ttauj2PjRCCWe5EObeO7YRFgEU0kVX9uimmNZFVbk8iYnMLoviIhSIP9p4=
X-Gm-Gg: ASbGncvFcLXKmREkbzfaKgulUa9LLqSJllxIohDMuqbnK/N28TXENN1U/QU0icjyc6V
	oRce15YWmkfe1J7A3MKqJWLBlrkjZUddlLE8X79c/dbFzbqY4NpuP99lvBVBbtJusOsKNI0TLxO
	T7Q18ZO3pymiILkDnrC4QVMYPwXT/mt0pWB8bFEmGH72qzJGt5pD31412QlY7Ypf2CjvYPhvc3C
	A0mZ6zoTKrl+Q5a5H10bUO4Rrkh4X2KL1v53RYcmO87kwXcBCTHgLDB/UIRJ/jRMAmK0vcrKR1t
	lJvtn1Shq/L4+2WnaPZpnFk32DI/b06YPjNCiLop6TI3vOHHa8iEvbmSGcy38sc3PjrTKGL27A2
	A1Pc2+kiyC2CosxZ3l4ohsgI=
X-Google-Smtp-Source: AGHT+IFiAUJYxwSGpIAcl0DxEr/iR/4gNWaif80xFQWkJ0BwZ3eyD7IylnlD9S2pzCsHCztMT2qdow==
X-Received: by 2002:a05:622a:5592:b0:476:aa36:d674 with SMTP id d75a77b69052e-494b07eabbbmr447701611cf.28.1747960284550;
        Thu, 22 May 2025 17:31:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae528713sm105391761cf.71.2025.05.22.17.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 17:31:24 -0700 (PDT)
Date: Thu, 22 May 2025 20:31:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] pack-bitmap: add loading corrupt bitmap_index test
Message-ID: <aC/B21ZYCixgFSfe@nand.local>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>
 <aC5rCRJd3GaTNgL5@nand.local>
 <013153DA-8314-429B-8408-9A79A3304013@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013153DA-8314-429B-8408-9A79A3304013@smail.nju.edu.cn>

On Thu, May 22, 2025 at 11:05:56PM +0800, lidongyan wrote:
> > (As an aside unrelated to this part of the test, this skip_ewah_bitmap()
> > function seems awfully fragile. I wonder if it would make more sense to
> > implement this as a test helper that can dump the offsets of EWAH
> > bitmaps in a *.bitmap file by object ID rather than trying to parse the
> > file ourselves?
> >
>
> I am actually replaying the pack-bitmap.c:prepare_bitmap() here. Also I have had
> write a test helper version once. And since I want to use prepare_bitmap()
> I have to put the code in pack-bitmap.c. It looks like this
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index b9f1d866046..9642a06b3fe 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> [...]

Yeah, since the pack_bitmap struct is defined locally within the
pack-bitmap.c compilation unit, any test helper that performs any
non-trivial operation would likely need to be defined in that file.

The "test helper" code would be a little shim into the real
functionality within pack-bitmap.c. See the following for an example:

    - t/helper/test-bitmap.c::bitmap_list_commits()
    - pack-bitmap.c::test_bitmap_commits()

Here the former dispatches a single call to the latter, where all of the
real functionality is.

But the (elided) code below isn't quite what I was thinking. I think the
"write garbage data" part is fine as-is and can continue to be written
in shell. We have lots of examples of using dd to write garbage data
into files (see for e.g., the "corrupt_data()" function in t5319).

What I was thinking is the test helper would print (via some new mode,
or bolted onto "list-commits") line-delimited output like the following:

    $COMMIT_OID $BITMAP_OFFSET $FLAGS $XOR_OFFSET

or similar. Then you could use the output of that to determine the
location (replacing everything up to the actual "printf | dd
of=$bitmap ...", which is the most fragile in my opinion).

> > Hmmph. I don't think this is quite testing what we want, since this test
> > passes with or without your first patch. And that makes sense, we have
> > tests elsewhere in this script that verify we can still fall back to
> > classic traversal when the bitmap index can't be read. (For some
> > examples, see: "truncated bitmap fails gracefully (ewah)" and "truncated
> > bitmap fails gracefully (cache)".)
>
> I want to *test* for a memory leak here, not whether git can load a corrupt bitmap.
> Since git ci linux-leak test runs each test script with ASAN_OPTIONS=detect_leaks=1, I’m
> including this test case specifically to check whether it triggers a crash when
> `SANITIZE_LEAK` is enabled. And I do find if without the first patch, leak sanitizer
> running this test script would output error message.

Makes sense.

> > I think what we're really testing here is the absence of a memory leak,
> > which we are as of 1fc7ddf35b (test-lib: unconditionally enable leak
> > checking, 2024-11-20). I wonder whether or not we need this test at all?
> >
> > Thanks,
> > Taylor
>
> I am not truly following what are you talking here. But If you think it’s unnecessary to
> check for potential leaks in load_bitmap() or load_bitmap_entries_v1(). Or this test
> script shouldn’t be put in this way. I’m happy to drop the final patch.

I think the above scenario (writing a test that would have leaked memory
otherwise behind a SANITIZE_LEAK prerequisite) is reasonable.

Thanks,
Taylor
