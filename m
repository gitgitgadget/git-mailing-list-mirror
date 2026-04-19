Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA71925BC
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776642735; cv=none; b=L0PcmE+FfxdUVXUKXQYD8pNIC0IgQKt+K9cZXzoI3sBU5Jgu/8TRT6Wq6s6ZO1uHjbrGliCgZLtw5A/vksBauLFEsvNUjziakQ0FFP622AAgcMXmr41EivnoWgrz/Oi7tqGqioeOrIc1krqVOqG6uEGel1Yw5DXXVWx3RCVfgfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776642735; c=relaxed/simple;
	bh=QCHSV0mQ7y5GChoDyBonnbQis9t4q+wN8zTqkp9z1y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyHtvSu7K91G4P4rjzFJU7NZpWFhgynbNL98dZfEe4Vf+Um5zgVilaKZjXueqYyGTFpH62U5hXSUKGShykuT8BQw3xXs/uJkpo0hQEX5N6jYvkAP1ifxjQbRXhmbaB5jiRcC+sXKFHl6hYu0Qty4rKgtEkXJbwhrQOC2u4Rce5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp4n6dl9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp4n6dl9"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so15334615e9.2
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776642733; x=1777247533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QP3uzktMNKJihyq/X4aelebdzgo9XASUC4UXTG6slys=;
        b=Rp4n6dl9d2LzjHBw8pgFnWIXTtMML2hWuRkCHKWnd/IGzosUJiHnMuIRPic+mMk9hI
         U6HaU3nqx2faaDo/VPM5/wXPRZ9xJmIvIA7JnlthhPrgrrqIImmmrqhvaXVExslkjXpW
         BHYT1F9DF8uXIYnymE6wOE9CCxkZnbqCNzjsfeUaeL08uLlgvGgpdKKNFYUlqueKOlKR
         fSLTS+X36/1KuyIoZDSChpnySmmstUI3L0UpmR4/rt081N9gah3rFexmlaHWwTP5pq1/
         37ufC+5TiB4nUMSjJ8K6X/Zxze4C51oebt0UvtdI8buEs5sLmI0T0FrBp2Ab6hYzgZ8e
         jjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776642733; x=1777247533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP3uzktMNKJihyq/X4aelebdzgo9XASUC4UXTG6slys=;
        b=jbEv5YX4rrqP7g5laMz72pAahjEKQOaGuCpL79Olp0dMx9NSoYgsjmhAf2Zu1j5Zij
         lD1ocEpK4Svx8FzvL90HFv3V44oDbc3ajvuDBblvkEqwCI351OxVqSzOaz5DKdo5qkOH
         6Tfn2aBkx+6XEuCflblTRU8Zt26gx6aOetj+as6H7G0xXufDQb8xJz/Bx+a0/gIBERLJ
         Ldzbh+dmQXHSfdDk8E4SqMJUYiOOCsRk+h7MGOMcJLKlruVKvyERgiYrJ4xA+yy1+3oa
         qsqPltN5UOjbR49Rs+d+IV/j5M+I0JDNumNMkrzcvD2Llf/TvhBPmpns5rpCu2+uFk3P
         4zCg==
X-Gm-Message-State: AOJu0Yy/WaLgytdrlpaGNOdwcfCQ6UOdhQ9JdJnzde39MVE5pouHNLnv
	aQJEY0CCDVArDaGSe4YlhjM5pA2yRM0phuvDd25C4op8a4ZKtAHwCQf5xOnMFQ==
X-Gm-Gg: AeBDiev0B8D6d1bll3uA55CPTvlope8AauB6p9JefB0Orn6lz9rnUoXGK99kPVM5Xj2
	C4MSQ5TZW/Sbfg2Uun5z0QENeIr3/iyXy9H4rVz37mPHBHgr1KRpGozJiQHvWvoYdPbhHQgMQ1Y
	es48Z13ECVYaOSBsMf5HSGp9SwIM51sd+yKJjCATwHYwNU06fMwgeWFQetT+ixeOFCwSCWR1fim
	LpYOQ3c3uWISxP2UMKEiCvCFZWyTimctjfmfIYkcD9Zjr5+2hCbCpo5vR0k4wUJFB0XaHc1zdBh
	V9RpDsILbxxwhXjrJyzT3sVWhNQ5bpVy1nyyPxStzIuGazpG2eXGUKjfYZU91GorLH2DDPqxjcZ
	9JCLE0XU1bgy74jaeJc9A4IGbom8z1GnQYNFKaVE2YUAPYUm+PdwwBo4W4sV8byS2sd3Zf3aiHd
	DbkIos2UEquO1Tjg0pWZ9ki9I/RjhQYod+0/6f8pYLto829EacalXYQiPQcWhvdxMn0xjW5EN+P
	KE8PEazrUOqrtELtno=
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488fb78ba6fmr130600305e9.24.1776642732527;
        Sun, 19 Apr 2026 16:52:12 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891df9e50asm16580335e9.0.2026.04.19.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 16:52:12 -0700 (PDT)
Date: Mon, 20 Apr 2026 01:52:10 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] diff: fix out-of-bounds reads and NULL deref in
 diffstat UTF-8 truncation
Message-ID: <aeVqqsdq9B7GE9gS@lorenzo-VM>
References: <pull.2093.git.1776443163041.gitgitgadget@gmail.com>
 <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2093.v2.git.1776465910538.gitgitgadget@gmail.com>

On Fri, Apr 17, 2026 at 10:45:10PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> f85b49f3d4a (diff: improve scaling of filenames in diffstat to handle
> UTF-8 chars, 2026-01-16) introduced a loop in show_stats() that calls
> utf8_width() repeatedly to skip leading characters until the displayed
> width fits.  However, utf8_width() can return problematic values:
> 
>   - For invalid UTF-8 sequences, pick_one_utf8_char() sets the name
>     pointer to NULL and utf8_width() returns 0.  Since name_len does
>     not change, the loop iterates once more and pick_one_utf8_char()
>     dereferences the NULL pointer, crashing.
> 
>   - For control characters, utf8_width() returns -1, so name_len
>     grows when it is expected to shrink.  This can cause the loop to
>     consume more characters than the string contains, reading past
>     the trailing NUL.
> 
> By default, fill_print_name() will C-quotes filenames which escapes
> control characters and invalid bytes to printable text.  That avoids
> this bug from being triggered; however, with core.quotePath=false,
> raw bytes can reach this code.
> 
> Add tests exercising both failure modes with core.quotePath=false and
> a narrow --stat-name-width to force truncation: one with a bare 0xC0
> byte (invalid UTF-8 lead byte, triggers NULL deref) and one with a
> 0x01 byte (control character, causes the loop to read past the end
> of the string).
> 
> Fix both issues by introducing utf8_ish_width(), a thin wrapper
> around utf8_width() that guarantees the pointer always advances and
> the returned width is never negative:
> 
>   - On invalid UTF-8 it restores the pointer, advances by one byte,
>     and returns width 1 (matching the strlen()-based fallback used
>     by utf8_strwidth()).
>   - On a control character it returns 0 (matching utf8_strnwidth()
>     which skips them).
> 
> Also add a "&& *name" guard to the while-loop condition so it
> terminates at end-of-string even when utf8_strwidth()'s strlen()
> fallback causes name_len to exceed the sum of per-character widths.
i> 
> Signed-off-by: Elijah Newren <newren@gmail.com>

Hi, thanks for CCing me and thanks for improving on my previous work.

All of these changes make a lot of sense, and indeed they fix issues
that I didn't consider in f85b49f3d4a (diff: improve scaling of
filenames in diffstat to handle UTF-8 chars, 2026-01-16).

[...]

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 7c749062e2..84c53c1a51 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -445,4 +445,29 @@ test_expect_success 'diffstat where line_prefix contains ANSI escape codes is co

[...]

>
> +test_expect_success FUNNYNAMES 'diffstat truncation with control chars does not crash' '
> +	FNAME=$(printf "aaa-\x01-aaa") &&
> +	git commit --allow-empty -m setup &&
> +	>$FNAME &&
> +	git add -- $FNAME &&
> +	git commit -m "add file with control char name" &&
> +	git -c core.quotepath=false diff --stat --stat-name-width=5 HEAD~1..HEAD >output &&
> +	test_grep "| 0" output &&
> +	rm -- $FNAME &&
> +	git rm -- $FNAME &&
> +	git commit -m "remove test file"
> +'
> +
>  test_done

The only thing that I don't quite understand is this second test.

From my tests, the previous code using:

```
[...]
while (name_len > len)
	name_len -= utf8_width((const char**)&name, NULL);
[...]
```

passes this second test just fine, while I believe it's supposed to
fail.

Am I missing something?


Thanks,
Lorenzo
