Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1213AA31
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120832; cv=none; b=W21p2bXHmc5IQPCEfAUoGGNg6ZGbK+dIqNnx46O3gwh8qMGuNCXuVTHz7fedeIeQz7bt0Wz1ILhHfGVL0NghsCzMQfgTA9WLnWgTUQnxbAkIGJkE4Y3A/R9kSCKjudXoygFc10m3kb5fPt5m5ZvNvY23HZbRl0xwGR2v/FJqdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120832; c=relaxed/simple;
	bh=YnvjU978V1SH2ukPYIRau88/EnQLupNNBtxHlJBeMFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwI9BDOdr9NeyZzcSzsn2WUg2yvSsRpmZvmhtBvCaK5Uf1KOSFBzrBOLTjmq9eBIdgp3F7n56Aa9+iwy6oPovjIbLs5/yxnlrEZAwuq+qkV0l7WDqOojWq69vRD9x8TTrZru9l+hFqBfhP+qp+k0bSQfGLPTPbl/9G9KBgHZNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q9U6FjdF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q9U6FjdF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e387e50d98eso2102556276.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732120829; x=1732725629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgjIOp75abitRh8sD+c8+1PNI/otZxvREun7Fsg/Ykw=;
        b=Q9U6FjdF0KDSWZUt1r1GjaR3wubQMSbDx5+ChVjLA5kMpI7Q5A0K68pOgY+G3sR4Vz
         RLJwa4tlKLHSH69toobn35tZWjxSjCjrrd0aFUbN09wztr8e9ZT+LrS2nCL3nkfZs81r
         YlyBO88b4NVP2AtOinBLw2VRtD5bH5auNMYBNuTjrWVnuiNqzxIt2qq6FkHD2qaa3Ov5
         6OQ9hoWGEFhbe0lv060SscPfYKC/9qrUApsTaKMn/fq6+3nbk8ujKXeHlwepvk8Fd0Fz
         lIz6p7uoWoxykR8TLynN98vhwmnPFR0iF2itE8Ek/o1tSUdkuYdenWfz96K/ZH2WesXd
         YFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120829; x=1732725629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgjIOp75abitRh8sD+c8+1PNI/otZxvREun7Fsg/Ykw=;
        b=EY5ugwm8uIEZMP57AWXqNTwszvW8YUieR3ykO0ARmIUNgUeSC2IBVugkZSxN0siPDd
         07ioEQBoZGXsJa4hnbVzawZ+xw0K8cDiCuQOAiwDmgWs0RIbWSdTXGw9Hit13cs/CIOr
         NKynQtzswBFLi9wN9UWMEUPlBb47LJ6LpbdWN05ii18KLTC+EQVw7pisfoXzT516PsXA
         pHPFwMxVb/E1FduDi2BU2sCnhA84XpKNa8DJnDqH39B5ebiFqM+6QO985WznHtIDlNVT
         vTnQe/u+bKI3ZGHeTEHn9nRv6h58/KZGBOd2NBJKMFgDCMxr0XvSx/pC09/pi8RIS9Ks
         /x0w==
X-Gm-Message-State: AOJu0YzQ0A77xxdsWcUbdKpBZdhxfVTPOSiKBIwjTOHl1NAcoex+ZbSS
	ODf2RS/WFfBULGlg5AnCumJ/brEhzLukpirxYT7xCfl7EXVV9qmLcIfO3/ST1GdlZz8SGX/Xshb
	l
X-Google-Smtp-Source: AGHT+IHP9of1NL9NTzLnG2Jhi1AZ/uosRWeV2uqpr1bQ3tFgx1H37eviCeLQ+PP9rMhNykfVHes7kg==
X-Received: by 2002:a05:6902:18d5:b0:e2e:3701:7824 with SMTP id 3f1490d57ef6-e38cb54da18mr2584883276.2.1732120828850;
        Wed, 20 Nov 2024 08:40:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e73ac56sm3137697276.21.2024.11.20.08.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:40:28 -0800 (PST)
Date: Wed, 20 Nov 2024 11:40:27 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
Message-ID: <Zz4Q+2X3wXhLO6FE@nand.local>
References: <xmqqo72ai929.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo72ai929.fsf@gitster.g>

On Wed, Nov 20, 2024 at 05:49:34PM +0900, Junio C Hamano wrote:
> * tb/incremental-midx-part-2 (2024-11-20) 15 commits
>  - midx: implement writing incremental MIDX bitmaps
>  - pack-bitmap.c: use `ewah_or_iterator` for type bitmap iterators
>  - pack-bitmap.c: keep track of each layer's type bitmaps
>  - ewah: implement `struct ewah_or_iterator`
>  - pack-bitmap.c: apply pseudo-merge commits with incremental MIDXs
>  - pack-bitmap.c: compute disk-usage with incremental MIDXs
>  - pack-bitmap.c: teach `rev-list --test-bitmap` about incremental MIDXs
>  - pack-bitmap.c: support bitmap pack-reuse with incremental MIDXs
>  - pack-bitmap.c: teach `show_objects_for_type()` about incremental MIDXs
>  - pack-bitmap.c: teach `bitmap_for_commit()` about incremental MIDXs
>  - pack-bitmap.c: open and store incremental bitmap layers
>  - pack-revindex: prepare for incremental MIDX bitmaps
>  - Documentation: describe incremental MIDX bitmaps
>  - Merge branch 'tb/pseudo-merge-bitmap-fixes' into tb/incremental-midx-part-2
>  - Merge branch 'tb/incremental-midx-part-1' into tb/incremental-midx-part-2
>
>  Incrementally updating multi-pack index files.
>
>  Needs review.
>  source: <cover.1732054032.git.me@ttaylorr.com>

Sorry for not making clearer that I had changed the base to current
'master' for this topic, so these two merges should no longer be
necessary.

It at least seems to build and pass 'make test' just fine even when
applied on top of its old base (477ce5ccd6 (The fourth batch,
2024-08-14)). Sorry again.

> * tb/multi-pack-reuse-dupfix (2024-11-15) 2 commits
>   (merged to 'next' on 2024-11-16 at 32792297e5)
>  + pack-objects: only perform verbatim reuse on the preferred pack
>  + t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure
>
>  Object reuse code based on multi-pack-index sent an unwanted copy
>  of object.
>
>  Will merge to 'master'.
>  source: <cover.1731591708.git.me@ttaylorr.com>

Thanks.

One topic I did not see is [1], which appeared not to be picked up in
this or the last cycle. That topic has been reviewed and should be in
good shape. I think the thread died down after agreeing on some
potentially interesting future improvements we could make, but I don't
think there were any outstanding issues with the current patches.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1730833506.git.me@ttaylorr.com/
