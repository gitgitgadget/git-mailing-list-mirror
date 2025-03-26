Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AB202C21
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009561; cv=none; b=FzD7dt72oJE/6YBLXQ7ZWNZPB+lytpBHdKoWGhiwXD3tf6nFQAcckItYq/8qNkxPopTRqbVJpFm3Qrx1jCo8dLxy0DN9eiMP9HVad9Zvh2aV76xPb1rPK3wAxQoZcUmvwIsug/Nz70uT53JBIfImOJaelS0BfR/elp8s+MQu1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009561; c=relaxed/simple;
	bh=mxjdalkk963HbB3LT1jMQRJ7uuWJ6T895Xf0OwQcQEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucl/UCGYdAAvFG56OVvE8ifrvBD9f9MlS5kcEyZVDEjUkaepv0dgV7r+JYCQmp4hmMkVp6eVMRfo0mHCTHkWQ2GnpAMPybyLC2NvmYOP8YjrCtQd3EZicP1GlGcMP97FFWcPyCSx2ZOpjK61wijVJhUfjg1MbTUwOuQWNboQaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oTr7oh8M; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oTr7oh8M"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85db3475637so38703139f.1
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743009559; x=1743614359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBhIbhVwltEu2/HsL9qHoukx3cPifkvYlAeRh472164=;
        b=oTr7oh8MKGYS60hOyZwXb2KBpsazQpt/imyNede6QD9khlGy4026B0jIqCoJH+s4Jd
         tqRvUqDnkYU4INtWbRKbZ+SRFKKcvmazJ/8zbP/Wf/RNsEKsKczXLrfvvA1zsFMmorON
         GAUUjQjwhovvS1k4wV2XJDOmkNtMDJllsE+HW++fufdC+8kkPIi/Xg2B6o4Y6yfveK3b
         ryx2lQCSL8oM3NogDLobiZ5drP/VevjTbeyDjbhJ/u/0KNK4rGCk1VIGqoMlSGwIe60p
         5iXf0MmzAwCmZOfiugI87HkBFx44poxLGYYd9G81iD9iV6TrwihvOXHlsrNsecrLcH2i
         t38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009559; x=1743614359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBhIbhVwltEu2/HsL9qHoukx3cPifkvYlAeRh472164=;
        b=tdW9/mVXEN/BSxbMqP9jKIyQdmjte2c+AYJS1RHuOv0mC0OZDwlrWCYym+b77JHSpD
         B/JQ24wevFqsLR02zy8ASPqd2s3qnM5ES3t2xzsjMhDQVtu7ufwLY3u8C8WLu88pM+ve
         9H7JUSy9BIoYiirRBdo6cJMOMO3idpP7OifzoLRa2H0jIEflPKD9qaQexMzLcEMF4CEn
         1Qa874SN5i39e12YFuzIktt4yT857fOgvYywSFvZIw6BXRnhgVBe+wHM5Ig0Sz3O5IfS
         doKfLd+6vnyUtbeh3SMwvYnOSs/cPZHtZIT6+SagPmvI83KURdnyaETaoErjgEdS2Jiz
         kNBw==
X-Forwarded-Encrypted: i=1; AJvYcCVMJFPX8dgGp3RzXpFuejrZa6TEH2qRic36Y3mjyLydtpj+q6jZgRs0OKhmpxkIroS21XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypq48FW5ygPjfgHTFducNi7YAxTA6zs0r0g6Uw0Nj5MVBAUBWk
	oPQVL+RhxY5Vn+QkmhY4xczuXG+GqoJR0CvjUcRcsmnl/4l+Y8huprSA4V5DDfg=
X-Gm-Gg: ASbGncuGCWZO+N7mfV6uTsEyVyd4W7eFosWEfStT2WzX5+BnnnSqRf7S1txKEZS3dUK
	TGWEBHLaWaYvghoVQIHrIqyjtTTrDIh3pOGLE1GgnYitlICMdw8sRu4DQbxiBcBwtmacZpFrJaX
	E9duZp0Vp2kcmcf2HSz7P/J+i72ZUWy1c+poVfFkZwiC2rPNCmfDwZqzqwyv5oBacoEHW8GLNpU
	dzlgD95d2GuFXIiKM8XePBxaC5gyxJURN43Hp2ln0y/edfeoEs9YtydzMc67zo8O6liK9jQ73qz
	pmSrXCs8uLEURpadjVEcQkJsDfHs4k4IhZgLX7L4MhJeFEbVQlg2SVv43I51O1mHPyHeGYKJ8VR
	/QpIje4Cw4gTVieYYxxyjfu55HaA=
X-Google-Smtp-Source: AGHT+IGq3rwSYhk86rUo8OHYiOMUYNJSBKulGW4ridtnIW6Ek0uMhNnLfH5w4NVi82st25TdSBYrOw==
X-Received: by 2002:a05:6e02:4401:20b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d5c2230c98mr44132045ab.9.1743009558917;
        Wed, 26 Mar 2025 10:19:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-4f4466a0819sm636097173.18.2025.03.26.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:19:18 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:19:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #07; Wed, 26)
Message-ID: <Z+Q3FUCcsPETzVBs@nand.local>
References: <xmqqiknwhsdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiknwhsdz.fsf@gitster.g>

On Wed, Mar 26, 2025 at 05:46:00AM -0700, Junio C Hamano wrote:
> * tb/incremental-midx-part-2 (2025-03-21) 14 commits
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
>  - Documentation: remove a "future work" item from the MIDX docs
>
>  Incrementally updating multi-pack index files.
>
>  Comments?
>  source: <cover.1742493373.git.me@ttaylorr.com>

I think that this one is ready to go. Elijah was satisfied[1] with the
changes between v4->v5. Peff looked at v4 and seemed generally
satisfied[2], and I think the changes he suggested were faithfully
implemented in v5.

If either have thoughts or think that it shouldn't be merged yet, I'm
more than happy to keep plugging away at this one, but I suspect it's
ready to start being merged down.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/CABPp-BGv_KDdviT0C6khs0gaoHLSt+ZfmbAVrAkTyT9PC1=Unw@mail.gmail.com/
[2]: https://lore.kernel.org/git/20250318022134.GD1473033@coredump.intra.peff.net/
