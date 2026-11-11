Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357606;
	b=CGFQHtW1isSaAKqYu0T4gW//7PazptLCWXnOW76koY+Gz+afNEwguWoYUAePiepIhg7C
	 GA3YScgM6AdaMbzDPZj6A2B05L9A286PO/dGF5/LokqLNtxbruJ6q+j6kdzbQVUJ16GPF
	 vC3w5NNJpfwuofS3HdGtMjfVnGYJh6mVv6SJ5v7YodVzdyboO+d8XGg2j0gyqTnjRz7UK
	 wiLV/V4sicklfowYufFb+Zlsr4kBS8IMO1LYaDzh1UE6/4SOF2r9Kwunt0r3ORMuBVxY4
	 65DBF/XUdFPWW8j9zq5qkGpby4kokv19HrqhBO3jtYsexEIuCCa+WUeSJ3DEO5vqGKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=X2GI6Gpftu/T2zpGfZMs1FMzZm31RP7Gq90Wlm2/z70=;
	b=yT+r75w8ujLtHcSwcKtZGzwKLDvyj46Shymnsz+NzvPL7dz+UBIlxczEoFWzunG+zUfi
	 W1OBlUDkIuxYyUstY7+4ZXG/4IleRpyI7DwWjumQrboRUj2GbKxY4ZEWJ6jjHs0zmv+C1
	 RPiH02gZKSn74bSN77BWktXiZqjvPepwUYiLx1pcozTajJ54bMVzIbuvtBUVfniXUBl6s
	 lIVsPV6qlslANHnwvinKqBbkz0suzEExSguwCYRDJ9x3IgvJ472Pl32D5M7yJIRo8OK16
	 drFrmhf+2TKY0f0FSn7LvFhaejlI3AvJsKz0vsxB7YnJ/a+FCagOSeQdGaKk+//RIOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOTJa4PZ;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74247606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 00:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74247606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IOTJa4PZ
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-84e513874f8so1871490a34.2
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794357605; x=1794962405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X2GI6Gpftu/T2zpGfZMs1FMzZm31RP7Gq90Wlm2/z70=;
        b=IOTJa4PZwJECAKGhn1KUHNykuk7UklBHKLKg/yBJaxQPELoFfjnNhpQrxNQA5jgqzf
         CMNHwb4aH+74ep2LhHzGd9I0JF+xCYX9na+kL0y0GdUjVv3J5C4xA81xMiDwY1A3/rxX
         87gF8kXCfyYZ8aAGqC5kQxlg7rrOuUXfI94tfdlYwQ8N9Ia4rDcbPsWUZXNixZTPkEiQ
         kb/Hjtf4kRvUDDuh1Zzy5wTPuWrh7taE09zRR8H8Z/ZKjpmFi87qXF432c4Zo8zCe7hQ
         32PLw93AS7uenx0F8+8j04VsSZ2SuTk8WxzaaphKUzMmoCoH3wQ0e4qsb8wUEEHRz5jl
         gfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794357605; x=1794962405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X2GI6Gpftu/T2zpGfZMs1FMzZm31RP7Gq90Wlm2/z70=;
        b=mNguRyOQxa8I5hwkaulBNvNJ2CL2fBd6LIs7whPM+HF1Bs+zGTo1s3+7WuzHrFEWtj
         icH70g11B4dsH2Br/uMHM65YxUMqylVapooIqU7n2OiUJAoyUlhxgSrIvM2zCqIqm7RI
         4jUYRaO4pRLI9LAn1ZwzeJdRgM/ytp2DiMX2iHzKBGLxA/Ky8xcSdLxV/nZkDuMsXLJ9
         sqTrX5VFcdMS9ShJJMQD6B0eYZoVE99oLK6SOSLjq7lNrEKRdm99vYTSjYaKCQsYOfxL
         lAELjSMHHkb6ecvJfegob/6OXdXWYRAThuxPVliBG/uw/tUL74OXaQduf5kA6wVpjizT
         e0pg==
X-Forwarded-Encrypted: i=1; AL+hErFieZGIq1zjyN6f2NdjhvrO9c5W1QeIKF39Wnt1d06XS2bLWa4s//tvMriI4t4uoJamJKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OpMpshXztxwx4puJzUjK34Gn0WUrjpUODe3lScULlc7SLpj+v
	qZT5+Acm3zf6ReX8BU5y3BhZjG28Zi7qKZclcyNQmpseEkdpwTaaFEbvUuy5EQ==
X-Gm-Gg: AYBFou2xnyoRI2Oh1qNuTwuNfqV2EiKXEri8jIy6AVdhS8kyjUvdxa4uPL9vGS2KCLd
	Prb3Iq3vnty8MY7VhKX+GMssByRVpc0sF2/jLBJfXXROl1jfSCBCCxGHuhhBuBBrJkB+pUDhzJg
	z3pJmpFksIrFW9pwzfQy56uzfeZZF3a0Ow9k1mrLcAmJhZ8kfxZv1iGY+wI+Bt8hZ/k8VHLvdaP
	gdc/NEQFoOtTxvZlTLUyywqXirQ1rl6qlLzSkGtTWX6kt5n5iZZECjH+Nh0uQXMRrAAF+/QiV7C
	1r36MyvmJaO3J5tShJErFY9q1dRrMdze2jI6Or22DHstcTsq29udLWJivgNuaafrIl9FWeLKXfo
	7wIteipA31oZTjAjQHipvz5y2WwVAvTF/ViBFY9I7flPwOd8SO6yGOnQUju52GmXCyz1jz16j9J
	v2b5lLlNVpy0tmkwDs/F+zgyPWOjDnYcMs5TsUm4vBvuikUlf/JWUQ7pVMHgW9Uj2LNAM7iZI0H
	s3GFPeUK7vF2cMzt247IaFqYSAswNXxEdt/SQZ3xUc6JLNgitHYKLqhq9GhqBa8Eck6gxBVFhUH
	CQPpx1YJ7dlQBa4BpECEDnGxWKIJPseu8Sicpw8saWjJejqQwSLhhg==
X-Received: by 2002:a05:6820:1396:b0:6d7:7f22:f59e with SMTP id 006d021491bc7-71917926f6bmr573291eaf.38.1794357605262;
        Tue, 10 Nov 2026 16:40:05 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a94588d4sm3030025eaf.6.2026.11.10.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 16:40:04 -0800 (PST)
Date: Tue, 10 Nov 2026 18:40:00 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, ps@pks.im, 
	git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] log: speed up --follow following renames for
 non-linear history
Message-ID: <avOzVCHdGBNIG8sT@jtobler--20250820-SHC54>
References: <cover.1793298331.git.vmiklos@collabora.com>
 <cover.1794078554.git.vmiklos@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1794078554.git.vmiklos@collabora.com>

On 26/11/09 09:03AM, Miklos Vajna wrote:
>Hi Patrick,
>
>Thanks for the reviews of v4. Changes in v5:
>
>- The fix of the old 6/6 is now squashed into the speedup patch (5/5),
>  so no commit in the series loses history, and its test is moved to
>  1/5. While at it, I simplified 5/5: instead of two passes of diffs
>  against the parents, it first finds a parent where the path is
>  unchanged, and then only diffs against the other parents if they
>  still need renames to be followed. Because of the squash, the
>  range-diff pairs the new 5/5 with the old 6/6.
>
>- 5/5 now also follows renames when a parent has no merge base with
>  the parent where the path is unchanged, e.g. a subtree merge of
>  unrelated histories. Added a test for this to 1/5.
>
>- 5/5 now also follows copies, not only renames, when the merge dropped
>  the edit of the copy source. Added your test for this to 1/5. With
>  this, the linux.git case takes about 42s, instead of 37s.

I'm a bit late to the party, but I decided to run some benchmarks
against linux.git to showcase performance with 304812ed33de (log:
improve --follow following renames for non-linear history, 2026-06-22)
reverted, at the regression, and with v5 of this series applied:

   Benchmark 1: git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33 reverted)
     Time (mean ± σ):     23.493 s ±  0.645 s    [User: 23.001 s, System: 0.389 s]
     Range (min … max):   22.748 s … 23.883 s    3 runs

   Benchmark 2: git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33)
     Time (mean ± σ):     335.883 s ±  4.866 s    [User: 333.773 s, System: 0.577 s]
     Range (min … max):   332.296 s … 341.422 s    3 runs

   Benchmark 3: git log --stat --follow -- include/linux/rsc_table.h (rev = v5)
     Time (mean ± σ):     38.688 s ±  0.379 s    [User: 38.081 s, System: 0.415 s]
     Range (min … max):   38.250 s … 38.923 s    3 runs

   Summary
     git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33 reverted) ran
      14.30 ± 0.44 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = 304812ed33)
       1.65 ± 0.05 times faster than git log --stat --follow -- include/linux/rsc_table.h (rev = v5)

While the fix in this series does improve the state of things, it is
still overall a significant performance regression that I expect will
result in increased file history timeouts on the server-side for some
repositories we host at GitLab. Rename following for a file's history
even prior to this regression can be expensive for large repositories.

While the original patch and this series do improve correctness of
following a file through history, I wonder if the increased cost is
ultimately worth it in most scenarios. Maybe this could be something
opt-in with another flag instead of toggled on my default?

With this in mind, maybe it would be worth it to revert 304812ed33de
(log: improve --follow following renames for non-linear history,
2026-06-22) and restart with a fresh series. IMO, it might make the
changes here a bit easier to validate also.

Thanks,
-Justin
