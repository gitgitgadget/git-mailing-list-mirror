Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC111AA1E4
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700106; cv=none; b=XjynOK/zgnapTArC5CW9NO7jefBR7lp/MRuMqDhFDC0kf0lGaVsNv22MIuKTOZ+efTLtBGSDMWE4tB/IfWlBJ3uUp3Sia9iOkpnGLdLkl/gLSmHPFuPekllWyFuq/GKaSXPr4iCIHckNE/t9Bm4C7KXJtB3RRnJsW24lEAcYwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700106; c=relaxed/simple;
	bh=fTX+sbkePiIZSI56i36QPc5ELMwrHSOmSUvkH3iecGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnbgOdUtUr259PFpvVDEm1i/obP59wNlqqlA7KCg+D7tf5G4KRiy4mS2G+P2sBf2cZosxb8iBaA4VXIdTagfPJOB04f3uDc7D0t8sqdJJEGNVIsiJqtAZVhN1HwqQxuGjpfkJVrTEnw+B5mI3R5Bf6JnysD/nWnaC8qXoYIUIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jxlrCi0l; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jxlrCi0l"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f754678c29so14930457b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740700104; x=1741304904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0z9WoCkb/0QO6hzyi17lCiEmiNiH7qAKgDAZ5eTX+s=;
        b=jxlrCi0lFvtTE3nD9VtsnE04zshJqpXyfFSnABx5GE8ZL8rQyJ9da7XlopdyoI5IQy
         u1FZwt49mPP8dBMxJM8RvSrqsX5OkPtZxR7gT0LH2LY47R+XJ/5TaMzDL4CiLFj5TsAO
         0C7BEnA0FiAGL/TlHVx8bXxP6nKcMWx0frLAICzTwgQDDKR53TCOfY2tnYgqCJGT1rVI
         i3bqA5RG86Na1k3Gt0/QeGkA17PquGC20TkHntsKGGtzbKwjFrhibInEHUnIcMulpeiO
         MsreRO1ZiTcj7jfOd2zHTJKuCejDV1YHeXgWaCSpHIg1uYoGc8LV3iIRNN9rYmNCQc9r
         DxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740700104; x=1741304904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0z9WoCkb/0QO6hzyi17lCiEmiNiH7qAKgDAZ5eTX+s=;
        b=Sk8DGakgaWIB1DDTEJmzI7GaYbaPQjG+AJQpCRnpjBLUr9MS07g2SpQdFFKve5M36l
         ZTdry1hDq7gEkDI2o1VCeZTL/rXVO/mRT+mfmLf8w8xUad9/b0MJbbZPXzs/9sGAQ/ml
         K4cvIv69BANHeFZQ1uQSoJ78Ia4rN+U8VJ2St8O1qA3BF7oex9TDyOMziVfu5XiZHHGU
         FHN5YgvLFokYfeef98pJ58UGw0sKJg8TCdctfrJWAUQQdGXn+ZlVlfVc2+BAjlGgEq+h
         g+lbbyRKTOrTZCeAfYVdvIx0ng0TKCGrcKk3ZKek1qBIvTtp4bN8R8uOhHJkmgTnc1G+
         qvGQ==
X-Gm-Message-State: AOJu0YyaSmrFJk5ZW4jtf1lqahP3ow4l0Yn1SqHZpxZR8OgKtkDPybH6
	kPysZ3sDrbeBQ9FuA4i46Ai7Nm6aSrCpLitzdD2UhYIh1/D63wLxnNEuTwCvKrPxOue5PNK6mhQ
	y
X-Gm-Gg: ASbGncv0xU8d6i3VTuAqeRoGLo4UnuXpn3iVU+5u+diOBfiCBei4CleM40Zo2O0RusB
	dk6gOpz6Oh6V62oRxIZUpdrEa44soCY1Jf6ZfpdUfSHv52oDFhEoeMmqeh0BiCJdmnUK9w3UysQ
	LLioqbQY6UgeVwkFvYrN0QugFkZRU3r/TBPGkzFkepEs6HaczRe43BLGDE11+FeTKrCteMkbt6o
	5QsuD5q1k0MRQ7eec8eX1VaBPSAzp3KZ2aWjQBzZxfRqcfb3Lo7hC6xadJj/dUKISNFoewcGCdJ
	BbVXzDAanX6YJS4d8DlELI19Ybop/hLhoaCRm79FZdLo64m8JFuj3q34CRoa8dEGs+upf7XfmQ=
	=
X-Google-Smtp-Source: AGHT+IH+w6Oj+Cd505s4ulWFtn7y/Tt0fqodT8VGkjlOAp1ywUU8noBxu8GyA3nKKUc/BVp/R6Ppsw==
X-Received: by 2002:a05:690c:6186:b0:6fb:b3c1:b97b with SMTP id 00721157ae682-6fd4a03af66mr21446247b3.4.1740700104242;
        Thu, 27 Feb 2025 15:48:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca633d6sm5017747b3.54.2025.02.27.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:48:23 -0800 (PST)
Date: Thu, 27 Feb 2025 18:48:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 9/9] builtin/cat-file: use bitmaps to efficiently filter
 by object type
Message-ID: <Z8D5xiAVmWOUJJ1v@nand.local>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-9-0852530888e2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-9-0852530888e2@pks.im>

On Fri, Feb 21, 2025 at 08:47:34AM +0100, Patrick Steinhardt wrote:
> @@ -813,9 +827,40 @@ static void batch_each_object(for_each_object_fn callback,
>  		.callback = callback,
>  		.payload = _payload,
>  	};
> +	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
> +
>  	for_each_loose_object(batch_one_object_loose, &payload, 0);
> -	for_each_packed_object(the_repository, batch_one_object_packed,
> -			       &payload, flags);
> +
> +	if (bitmap &&
> +	    (opt->objects_filter.choice == LOFC_OBJECT_TYPE ||
> +	     opt->objects_filter.choice == LOFC_BLOB_NONE)) {

Makes sense. I think there is one more case here that we could handle,
which is

    opt->objects_filter.choice == LOFC_TREE_DEPTH && opt->objects_filter.depth == 0

where we'd just want to show commits.

I am scratching my head on if there is a convenient way to unify this
logic with pack-bitmap.c::filter_bitmap(). I think there is, but there
are a couple of wrinkles:

  - filter_bitmap() is really designed to work with a whole 'struct
    bitmap', and doesn't know how to deal with an ewah_iterator.

  - traverse_bitmap_commit_list() is designed to provide a way for
    callers to iterate over the set of objects reachable for some
    rev-list query.

    There we *do* have good facilities for iterating over an
    ewah_iterator, which is what you'd want. But that function really
    wants to have performed a bitmap walk first (see the
    "assert(bitmap_git->result)" call at the beginning of that
    function).

The new pieces of batch_each_object() introduced in this patch are
tantalizingly close to much of the existing logic in pack-bitmap.c. I
think there is a way to unify them by introducing a way to traverse over
the bitmap as a whole as if bitmap_git->result were the all-1s bitmap.

Thanks,
Taylor
