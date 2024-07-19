Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413B142642
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721396317; cv=none; b=e7TpTZaLia+CkZPdoulX3AS9RPk+g8AWYQbeyq224sqf1ACF4geh4LAOUhEg6ANWn8P8XCMguFUxfnM1bAgo5hn8ZKLwbxG53YbBfgEP1heanvEPAAHObb+E1DSj+xXpqKJHpQRO5nm/dtYqEg5s3huxLZ4fDQHKK6vmbwUMmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721396317; c=relaxed/simple;
	bh=KEUzpOZC/56rn5HMQLAyexlRBwnSu1W8LS8OyIrQrQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8DVrT3aigIAjwys16nrldBigsoSm2wMV+Ehgyvh5lfyPcSX+FB/yzc8sgWz71sZhpfojw3YJURoPiN9bdeJYLlAsPJrtduFsVlmbflQ9Der7tAwZUZOQMkKWQNSEkMMAlNjsfE7h46wivjM+0+Jfu40DTPmyrF5xwTRtxYZ5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QI+fvlXu; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QI+fvlXu"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79ef93865afso93565185a.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721396315; x=1722001115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEUzpOZC/56rn5HMQLAyexlRBwnSu1W8LS8OyIrQrQ8=;
        b=QI+fvlXuJBhOogORaKRiCjmW7YZO8QF/Ay9FRmDZmK4EBypoIejNSqMMsSnaQ6HIoK
         dE9rwQTZUyUsR8X3QWRDTqInqh+QmBjND+6LjpRORkxUDFkZVuYtj4qxBORjBVSjICvy
         8GH/X0RtFMXFL/jVeU7LHcjZHnhvVqzTc+CA4UlxiZrADVp7nJlke4y8AhbUeoVGkpwn
         YZG1wvVeAmNjobd9U5A2edsHIsqYSoB4w1nR83oy2h2Ct5/Joupvqz8oCnltBQpF3oxJ
         T57zJPCFJBgm01GPTaJ5DA2ZkQI9aGcgnk1uQ1k9J6B5lF+6A5OkQPvaZEZQD+tytIhV
         KCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721396315; x=1722001115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEUzpOZC/56rn5HMQLAyexlRBwnSu1W8LS8OyIrQrQ8=;
        b=CEDjj/ycklsX3iFpBd77xL6bdtNLAdFrBgocyBbvdIFQIur3AxWFbShJmPIi7YL8VK
         1PgtDQTm18u33iEMfxCt5MaNQqxBFB+RtyYEws1ZERxU3LpuaUIqRKdv7QQlGx66VuLo
         cSAOb+C5n1eWItOrbqtpww7VqZvX5dxk4sYAoPHG1KTZs742fLKlDNSQyt633G/eXnx2
         +g6J+yG0iairdc/Nlk+5uld1YCtJBOOEtzDZmGj1dn49ANLNK+yZaIQgYkhMgp20CKG7
         cquSdKibDvpTXM/1+vr7mLftKp/hfFeEnVt6vapn6xSFi9rlkkric9RwXc1Lfs16raH5
         UQTw==
X-Forwarded-Encrypted: i=1; AJvYcCWe9YqHeJJ6n/tGD1FPbf9s1ofuaBV7EcjgDp/CFmHwiKL1QEr5NnKtPbZNbWWJzzlwHFAZjt/sCkp3K3Y+f1gELAuB
X-Gm-Message-State: AOJu0YzJyufNQGkOSYGCrhrbpYeTJAhpajDJqgTMYL1VudfOHxEKGzsH
	WY+Rd0uYf4A8LsDQ9NIzdLZgabIpzAe630ELdScrvvNlGv00KVxFhEP3S2JMGQw=
X-Google-Smtp-Source: AGHT+IF+PRmiUk5B1V/w0MlFAiIYQHClrX4xAE6imD2Ww4FnklkSQKCOZJN//pw3HVEfUAHsBp9uLQ==
X-Received: by 2002:a05:620a:2455:b0:79f:18ee:a650 with SMTP id af79cd13be357-7a187446a81mr948111985a.17.1721396314728;
        Fri, 19 Jul 2024 06:38:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19900d413sm80199585a.70.2024.07.19.06.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 06:38:34 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:38:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
Message-ID: <ZppsWZ6u05U65Blp@nand.local>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <ZpmcK23coi5Qqm7E@nand.local>
 <118b164e-67c5-4dfc-b440-62b8986bf356@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <118b164e-67c5-4dfc-b440-62b8986bf356@gmail.com>

On Fri, Jul 19, 2024 at 09:21:51AM -0400, Derrick Stolee wrote:
> On 7/18/24 6:50 PM, Taylor Blau wrote:
>
> > I think this matches my own understanding, but let me know if I'm
> > missing something. Assuming I'm thinking about this the same way you
> > are, the fix (stop using --stdin-packss) makes sense to me.
>
> Your interpretation matches mine. Thanks for the careful read.
>
> I think we can accomplish similar goals that match the reasoning for
> --stdin-packs (better deltas while also limiting the object walk to the
> repacked objects) with some changes to read_object_list_from_stdin(),
> but that's a more subtle kind of change.

FWIW, the main motivation for that change was to limit the amount of
cross-process I/O that was necessary to generate the new pack. I figured
that for relatively small amounts of packs which contain relatively
large amounts of objects that it would be more efficient to write out
the pack names than the object names.

I was thinking a little bit about how we would alter the behavior of
'--stdin-packs' to match what the 'multi-pack-index repack' caller
needs. I agree that it is possible, and I doubly agree that it is subtle
;-).

TBH, I think that the amount of I/O we're potentially saving is dwarfed
by the amount of I/O and CPU time it takes to actually generate the new
pack, so I doubt the effort to make such a subtle change would be all
that worthwhile, though certainly an interesting exercise ;-).

> Taking this change as-is will cause a regression in the quality of
> delta choices, but recovers our ability to expire "repacked" pack-files
> in all cases.

Yeah, definitely.

Thanks,
Taylor
