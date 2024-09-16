Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6A2A1B2
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726515602; cv=none; b=E1fu5tZ+9NKDDSoOMnbDuenQ6hvpOlr7zmKBhLSVP9f3l95wHVZmU9B9YUskZu0OLsINwtx71kuaVhQdk8QDWj6ZUlJlU+xzwobkOZx5Jx+bwikC7f2m2/M5INkjoljMeYaIRCRGjdsSAX5kiTAOFtLwUNTyXOvd6rr7EXcmNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726515602; c=relaxed/simple;
	bh=oMXNdTu5iZ2BIlHIdFsoCiJyPOJ+xxAx/rGPGmKDGu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpxA5M24/3us1FMaxpAdYPwil7NRmzloQoOZwHv2b1zIk8Nel1xh0dhRPFFsP5vdK+NduT5yRDD2gge4NbunMA3Xxo4dKctBGV3hM+UMy2c35kW829QudXvxJTti2anN5hHBw7Fod/Mjd8FqMbDhzGH2yICFYbGSap/ar2JCA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NAArqx8D; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NAArqx8D"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so262392639f.3
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726515599; x=1727120399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBRSJEmeTpNxvvLRBi0mghDfDONbF953wFKEdg/IuA=;
        b=NAArqx8DaA+k9RXM/HT6GIE3hDrsvrPiHD5+Lybz8IcudWJx7gq7wirywyL2dgWFL4
         aaFyo0bk/6H2mLFUQLfhX1tPBq8lUOsCwJwR5CV4bzT/BrelWN0BGNKtPiqqheTjqF2v
         GeH4D6LyxDlfrijYIbhzj7iOoD6IKdnIUFvgB0MdMojEtcsb455SfBgQePeHoLqM/t3s
         xsNve3Sq0WiIrOwkw1iHwGaitvaLyD3kXm50vWT4C1NGpOlgIO/7+9xILidTSyhzOiB5
         cmiZ7Lu3NjNgq5EgD1xdQxPEuh07UdZsD+KsT4qCY8nd8qEi3KS3Ff8vaCkOJxKbP8Q4
         kvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726515599; x=1727120399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJBRSJEmeTpNxvvLRBi0mghDfDONbF953wFKEdg/IuA=;
        b=cZwYdArJS0rHF4HCstgN53QQkLJhdLFRUaXIcYr+7epccskxxRVVOTsfMBP8WzHZhi
         0RvLZXqdVeTgWxbmsFxAFiXEcb2JO1Gjme1BG6o9K2EYD3flfc2MmJIlqX8+sfjuQZdI
         PqDyZtpxoE9UxpC6WG1vMOZ8gl7VQ/bFF3vakH1cRDL0kjEKV22kJCTqjm9whgk7P+Vq
         U25jS+Ek3kzNJaulT91h5NP0Jc4zANlKrFzrHg88OyumvRlUnmcVqSTBRQOsmvbpN1AL
         spdzIPv11/fr+uKalisasj1P4swmjp9dl9wazhGOS7JUiZAicLG/a0urSzdp9AkCEKSp
         HvIw==
X-Gm-Message-State: AOJu0YwinxtmMUFAfS9RbKMq0jHg3RJ9h2EfPzsDJZRE0unzYzbOsbJ9
	DNXlPtsBmSP6ZxJCmdQce9wAtws6p4CG5SeQ2aT241RU+gXzmyatYYP4OFzm3ec/+OCMRnbZqgN
	agSM=
X-Google-Smtp-Source: AGHT+IH/AWrQxhmKfaxetsMhlxquCDqS6qj/kyoRjm89AZoQWlJgXxChZnJ9CdIrefWOYuMEpAZP/w==
X-Received: by 2002:a05:6e02:1788:b0:3a0:9f96:5bbd with SMTP id e9e14a558f8ab-3a09f966302mr35816995ab.10.1726515599582;
        Mon, 16 Sep 2024 12:39:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092dfeb76sm18295845ab.15.2024.09.16.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 12:39:59 -0700 (PDT)
Date: Mon, 16 Sep 2024 15:39:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #05; Fri, 13)
Message-ID: <ZuiJjQCZ23DznwJo@nand.local>
References: <xmqqwmjerqvl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmjerqvl.fsf@gitster.g>

On Sat, Sep 14, 2024 at 12:12:46PM -0700, Junio C Hamano wrote:
> * tb/weak-sha1-for-tail-sum (2024-09-06) 9 commits
>  - csum-file.c: use fast SHA-1 implementation when available
>  - Makefile: allow specifying a SHA-1 for non-cryptographic uses
>  - hash.h: scaffolding for _fast hashing variants
>  - sha1: do not redefine `platform_SHA_CTX` and friends
>  - i5500-git-daemon.sh: use compile-able version of Git without OpenSSL
>  - pack-objects: use finalize_object_file() to rename pack/idx/etc
>  - finalize_object_file(): implement collision check
>  - finalize_object_file(): refactor unlink_or_warn() placement
>  - finalize_object_file(): check for name collision before renaming
>
>  The checksum at the tail of files are now computed without
>  collision detection protection.
>
>  Will merge to 'next'?
>  source: <cover.1725651952.git.me@ttaylorr.com>

Let's hold off on this one. Patrick raised a good point in [1] that I
think I have a fix for, but want to hear some further discussion before
I convince myself that's the case.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/ZugMUv1xbnjYH-el@pks.im/
