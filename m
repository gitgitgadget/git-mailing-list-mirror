Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32801531D5
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988839; cv=none; b=Fqy6pJcA2RwQuUUIIQ1hMymH2HdQ7BYFfrrvHdrVkyek79qC+NGoKIezxB12V8zhbaLXlRN7BbqzxdgjIa/gC6HAIMPEYrUyaqCaRct64TpigLfNHBva2wbd6BGSz6Odgmxkif62r5RK22KXFv6S3cijfHqfvzk30WXWJj6Cb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988839; c=relaxed/simple;
	bh=Wi1te2tk7Yjewldo6UilCDIAuX7osZBhiyanhGcegmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSFinCbRgj5f7EuLvtWhHilusgowdAROxyZp9txTK3d6ndDQ9leEShX/46l/gjXk7WF+/336gRFy90JaVRGeatDzfP2U0Fgy/Ykkv0NpdpTsIw3lSihvBtuypwdaBI0MUqjjXq/Gb5kJLD8yM+UU1Zm6HTRfxRlK6VMdb9bqOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=OBJQ9y70; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="OBJQ9y70"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso5272561276.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748988836; x=1749593636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhQdMxQkvhyOuMPuwBI64Jo+4Mv+d2zySxy42wG/H8Y=;
        b=OBJQ9y70CSdTCXNoM1aan33yaIhjs0rGFgmp3aUba4G+54wdpn4yuRzPFDMOcmjzzq
         SJLWY7HZyre4kKAPSWhNGgZQKke378NFMCrA80hai3PpUO3ATMPyLX7g2wD9SqVkOcZb
         x+ieQ5fuXyRlMinErhBqvF8PqgovGjDEFZmTR1ORAdzK3xUDCowwA5tkW9KnvdvrgPOJ
         3OGKLcnQcCjZ0tVPIrX8q700STRQFb+4Hdis46N8uLaVjVvIm2FYylLbH5z7lbpB9M3K
         Iaw6OTCsPdUAKup/jZL9pNoFdYgvd1XBHcSDpzz5JQeAzP8Dn2P2ewHjueUu/5Q3Jdpc
         pDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988836; x=1749593636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhQdMxQkvhyOuMPuwBI64Jo+4Mv+d2zySxy42wG/H8Y=;
        b=IQ7CTcWB9oB6hN8Dep9IsTk6dRcvPvB5VjiD/dM+BS0DWSHdRnXXPS71VddvjoYteL
         KC9isiTZgq7GnNKu+nFU6v0EwlZ7LrxbLFimNb09NiAUs92FfDEwvB2v3i2GvBgiUdPb
         LBpWPK8IvH9l32HhJvsUEXnEqgwBl4tpQrmwVcU6uFXJDyZC/d4u0jQBnEuZzMQslbHf
         7OrQyO1zUd8D46WgLz8MZs8OzoXOm1ygyo9Dw3JG/2ORqJ2smKu7Qt1LrjYdEtuJMtJ8
         k6N5MTiIoaFdKwiMBW87PgGLKV3mIZzCffHEezW3W+ejkllLlwgFrziXNRvAXizbMPQ8
         NYtg==
X-Gm-Message-State: AOJu0Yzj4K7iaxOwbKWxpe4ScyvEMDLgaRxuDH/BHIoRlKYiTy3eS4bL
	1kslb9jhK0SYu45swzTpdRzx3iKeKml08hiReMf/ipvehxLUVVigti6q+vth7YOa1fA7iU3z8Xa
	JbMFR
X-Gm-Gg: ASbGncsKWoc/8jMJ8UzQQmXBEIeWg6k2H4o1dSy9j0SG3CaLIcefJkcbd9OvHOKYBP1
	3iZhRqV9VS9tu26qhTo4Bxs3cqlCI18zrXMooPMGh0evW/AdoG/CbLP4gozSbKJFhwMP0kRhy1A
	/Qj2jIJQY0VIz6ilDUJyYbhCh9BsnBgkhWgkQ1WIV+o8cBJQF65u9Amttcj2ldTcrUxNtt4y5vC
	FB3Pus0GzhL1bMmo/LK63r47LrkMpGmxqQsr8PolaF6iTtB+onoN9zlVvKDJga7QZsTx494wyb/
	7A3ZLqYaJyuE8J4fwoMFHFBNm5EhlqcyFNpoXUjgobMtBNHwKIKrRsD+pkDZz1kAr+nVQBqd2aI
	d52vlXnj029vINu/CwUTSGW2fALY0bZFQOA==
X-Google-Smtp-Source: AGHT+IHkGDwr+6WDyYSUO7bofhy9/473qpI1j7358a/Mnnppd/1HFcZ9/uG18fpNqdnaPOMPCm28fw==
X-Received: by 2002:a05:6902:1148:b0:e7e:fa65:8fe7 with SMTP id 3f1490d57ef6-e8179c5a039mr695393276.11.1748988836496;
        Tue, 03 Jun 2025 15:13:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f73522de4sm2869760276.54.2025.06.03.15.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:13:56 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:13:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v5 2/3] pack-bitmap: reword comments in
 test_bitmap_commits()
Message-ID: <aD9zo30dXflldlGt@nand.local>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
 <a75d0a3cc7fc78d13e7703bd02a7e30fbd601831.1748920445.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a75d0a3cc7fc78d13e7703bd02a7e30fbd601831.1748920445.git.gitgitgadget@gmail.com>

On Tue, Jun 03, 2025 at 03:14:03AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In pack-bitmap.c:test_bitmap_commits(), it comments
>
>     /*
>      * As this function is only used to print bitmap selected
>      * commits, we don't have to read the commit table.
>      */
>

There is no need to include the original comment here, since it is clear
from the patch below what you're referring to.

I don't think this alone is worth rerolling the series, but others may
feel differently.

> This suggests that we can avoid reading the commit table altogether.
> However, this comment is misleading. The reason we load bitmap entries here
> is because test_bitmap_commits() needs to print the commit IDs from the
> bitmap, and we must read the bitmap entries to obtain those commit IDs.
> So reword this comment.
>
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  pack-bitmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index fd19c2255163..e514c9da239b 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2839,8 +2839,9 @@ int test_bitmap_commits(struct repository *r)
>  		die(_("failed to load bitmap indexes"));
>
>  	/*
> -	 * As this function is only used to print bitmap selected
> -	 * commits, we don't have to read the commit table.
> +	 * Since this function needs to print bitmap selected

The phrase "bitmap selected commits" is a little awkward. I might have
written either "the bitmapped commits", or "the set of commits which
have bitmaps".

> +	 * commits, bypass the commit lookup table (if one exists)
> +	 * by forcing the bitmap to eagerly load its entries.
>  	 */
>  	if (bitmap_git->table_lookup) {
>  		if (load_bitmap_entries_v1(bitmap_git) < 0)
> --
> gitgitgadget
>
Thanks,
Taylor
