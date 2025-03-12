Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C623F39D
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781568; cv=none; b=EMrHwJaaqnzUSuU80tgtd7SX2zVzIfs3RdQ6WZkJavknKtgI9PXmKaRRTPvMLRrbyg8giXMksjvKf9Tgpkhif63AxC39DJZXGYwR5Lch8quKq1lVwGVt6FFcroF/sTZT6y26n59vfedvt63nHAWUHFSWJYaDTl8r2LaFLBeUat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781568; c=relaxed/simple;
	bh=iWje2Josc0bs1gwja74ilqQRA+3KsA+qKv0RdnjD07A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4lMYFX9q2xSJMK24dQceRAQGPlDRS7u7+5UjD8dVj/JyIJIlxWuDE9k25oiXBsdFrhjdCTPXOhAf8wACXnVACilclBF1P/fN5KtuxHLyiCIthwxpx7YADw1ICI+/xSz9AWDi0/an1EUA/78wjjBjnhIPnKTez3pxBbLhbpVIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUqM0e+w; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUqM0e+w"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22438c356c8so88845455ad.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781567; x=1742386367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljJ+VyDR78VVk71qNJ5tUSqw+kyUIrWfbCkp/Wsy8rs=;
        b=nUqM0e+w7DndZPZoezVyq7QojxFFHeHkSzdF+m1yEECVod66Nz8Ww7bUJBENCErLUS
         DyyH4ZLpRJM+f4Aii6MqVFrlr3uqQFLmuC4SmIE68U1NLlxWTdax5+ZjXGlOsPJP/q4w
         ej0mwyGJrFmHZU5jd0Fwds2dub5ZcVqi/T2HJnk2rQXqSCre+DffB4UcgzTZGMtbVgXY
         4josl+8UoZ3RYpPTiikNuWSLhJfGifVqkJkuK4jT4KN0A+1QHeXqc1z0mQ+A1Z7nrky1
         MaDQ3muHSQ+kbjwzvR0vVloyeksn4nEgPIZVsEi9uiRZt0JFYsiZ4yTFCXKgPB1Zz+TU
         vMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781567; x=1742386367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljJ+VyDR78VVk71qNJ5tUSqw+kyUIrWfbCkp/Wsy8rs=;
        b=wOpG2V3nSb6zKyxvVghPUU7NqSdVKyUBsAgDYca9T4GWzjG9ywFZa0zpoxRNe4MPpo
         WSBOmBnNtYXWE8EXf/O9wGPKvAyMlGTMKF9SvKJXlWHMRnk+/jpOs9bg8YKWSipd0nJS
         IDO3iSeItEp40Q8CqL8808ceh7rxD8H54bng5n8x7Be+Q1nPoX3kF6Zwap4kkAPyh+tL
         jARVbklHnJDzcEebl9VJFx4XERlEg6G86pOHUmDHFExM2HMOPNoyoU733Kv4a7ZZ+hA2
         9ZFwQPI9xNyzzUsHCRDA+ioK1PbqxQLS94OqKM9dQxWYqkXf8Ud2+2JrrUQEn767Fm44
         K7oQ==
X-Gm-Message-State: AOJu0Yxp3Rh0sk1qWt3MmKTXzo55mo2yTj/TEN104d0f+PrcfUEfNhYq
	9401Y6gD+Lv8XY7vdujUVMdQNzYvV6etSA8+DhfwTYjK1XT7D+WJrCx4SA7L6rc=
X-Gm-Gg: ASbGncvgQdQ+tby+homwz3btb2FRw4GfmUIZzgvZHUSegOESvfEy/U84gxAaBsizFFq
	vuqD06tCdIeItdPoCDVF5w38tiVvGaolMpPJLerZ3KykXU6pthQ+TM3zfsRvPf+zgCeJhAOHAxU
	UVkUfhfeUmDy7DTdgm2IS1sNyOtCFuJqC2bqjXHsy17yuUgzjlvvbeYi20AJXNxbYDmtZMFOosU
	S2qmywdl34FNNNqhFcKx7FVTpkc/HIa2jTYRF1fYbhQkgm0JXsJiE8e1dlqW3hm24uGzVkKXHdk
	G4KrsNxCwfGSvqtX+hPyEOcuE5Wsyh6aG7g/ksbY
X-Google-Smtp-Source: AGHT+IF+67s6QWEfWl5R8UuxYMeCcE1IvXcRxiiKj57eOg13jBN/IkouQi6CeW1dlfMdV5kjkDCz/w==
X-Received: by 2002:a17:903:32c6:b0:224:826:279e with SMTP id d9443c01a7336-22428bf1937mr293084505ad.50.1741781566827;
        Wed, 12 Mar 2025 05:12:46 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410aa5ebbsm114675835ad.229.2025.03.12.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:12:46 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:12:56 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Message-ID: <Z9F6SFwh50s2MNkI@ArchLinux>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-2-dcb2ee037e97@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-pks-update-ref-optimization-v5-2-dcb2ee037e97@pks.im>

On Thu, Mar 06, 2025 at 04:08:33PM +0100, Patrick Steinhardt wrote:
> When reading an object ID via `get_oid_basic()` or any of its related
> functions we perform a check whether the object ID is ambiguous, which
> can be the case when a reference with the same name exists. While the
> check is generally helpful, there are cases where it only adds to the
> runtime overhead without providing much of a benefit.
> 

When reading, I am wondering which cases. I somehow think that we may
combine this patch with the next patch. For this standalone commit, the
reader cannot easily get the motivation until reading the next patch.

However, I also understand why you use this standalone commit. So, both
ways are OK from my side.

> Add a new flag that allows us to disable the check. The flag will be
> used in a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
