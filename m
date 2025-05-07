Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537082E40B
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581620; cv=none; b=nGlhV37+4cpE2ucj7H2/w/5Jo/NHY5ecqnEt5MdeatKgVkfKt1TRsTj5HxAirtDoLekmWNm7gSxCIe0krJ2M9x0Sl0L7ZNPCVqq2/Mj4bNtGDQyN55ZHpnNBbCNNdiHoo0hq36CGmYaxJykW9zUBy4/vKDNfEZ6Ei9/V9aZwKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581620; c=relaxed/simple;
	bh=+MGHgaA+7dKUtV+Sl4sypLFC9XXhdOZ/F9fB/Za9uaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMhyW+o7xt/wiHdUeihJWQSiOyZnPfCg02l5+35HuZfNB9Clk65+TZ+j1+qBOxcjefdqpGkZVPsppq1exonTrffpBj8QZhQ5j3uy978ZUDxhoXCC7rBUUMQO07sryPl9d9HUMj6Z7SfUC1Bqf+PBo7hZnaDWHsaU44lJKL/xNvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MQWWSNkA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MQWWSNkA"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f5373067b3so15745846d6.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1746581617; x=1747186417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAOJipLAfvljJKhlgEm9y/aIqpqUuOjEnrDo6nu6248=;
        b=MQWWSNkAhEDkrfrc3O+zC2BzIZL/aPnRih+QxgvGLOVfM3hr4ps5hwr54SQk5HFYmW
         gSefAx0VQSft1u7m+sXFNoZepxKl8KWzuZuTxfm7vWIU0kiHUW6VwTWQb8zgCrifSE5d
         UzFX6zVRsNRxjsmR8wrAkAwLtTFEhazeO5uHceM3F55mOvXRTtWaBpAl4XJcfoI3xO8s
         nzBLyYVd0JJyLA4SxqprgoiTU70/LTHABiSBwVanG6UyaI0AHCkbWjAY1c8igyh0B20B
         zIEwXjy0B9xY9w69qEdzT0RW/M0TqwgiACZaEQ6267lRQd/TJCk//yT5esQZ7lQz2+vI
         AvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581617; x=1747186417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAOJipLAfvljJKhlgEm9y/aIqpqUuOjEnrDo6nu6248=;
        b=GDyrzLquBCab+CuDV/N3KjlXuWIrVCWOBwgpaxHyczulFUHeiGYm+mtk/ABR6/8OYi
         v/CxhNekKfgx/CoxSFUC3w3xkrVUpnnqKufKaxvQFNWgX1L3GP6AHa5sfnDZo+i6vwXm
         W/kLRpw6p70ehfTepnhjznPWJEIaPrALZ8cXebNz3JoVSI6Fqb5qg1QMo1n+WrTJG+Qo
         gfLvQHDGty2BWjUxedyshUE/GFxcPuEuH0soDd6GfMMZEUqaUBUsOD2HRIkSHzN4+Dl8
         v/jilZFXvq89c0aOkmQziR60/Fg37unmYM580XrNjTQ1hb5sefGw2mmJgt9WKsDfbRA8
         0xNw==
X-Gm-Message-State: AOJu0Yx7hwXiAKhUQodFp/9BuX5D8DMsSJKsKujgyo6R4ccqMzXw3Q5c
	97Rwuf3hAynHZqfVR37Pl8fFqzFAXKinSoKqGiOA6BhMfCJhpKzkbTdW2RtFh9s=
X-Gm-Gg: ASbGncvhmstIa8otxeT6BGWHVZJ6feb7HfEuuHmXmad5X8Zalarff/xderiVM/HNw6x
	/uyo1EWewIt7ixX7tKV4R9eB1mH35m/ZJqrMvqXapz+MKTKjOFNJElv8XUvm1EwIJ2BL47dmYV7
	TOVPVxP7ZLAB62gGoDWwplP8Ig4tIHxi2iAVeVSwKbi9MPBcVJTK8peM1U0BeonaamtoKrp0hSt
	5VDG2MeYDZJiOtbpMsUHm3c+AsUH8zCZuUBE7RWw2cmErtVUXeNI6Lc4TocTzntKvKq3vWWM2oh
	wgRGVll3ypmmeTsSJhUgUlsii0tN4iBM0yTYe05eS9XIntQ7vE22mlbfG62vfCzvtyjc6/vVMbG
	QK+FFSc5+Fcmzv7BLT8aY5ns=
X-Google-Smtp-Source: AGHT+IGRL3BMVm7z7UWpCsKw/x3ES+GiTxpIVltFzDabKTP1takRgJPiLbUppeZpLSgwJDMk7MKllw==
X-Received: by 2002:a05:6214:e42:b0:6e8:8d76:f38c with SMTP id 6a1803df08f44-6f542af7a3dmr25319426d6.40.1746581616950;
        Tue, 06 May 2025 18:33:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542623e96sm6155856d6.14.2025.05.06.18.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 18:33:36 -0700 (PDT)
Date: Tue, 6 May 2025 21:33:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	jonathantanmy@google.com, karthik.188@gmail.com,
	kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net,
	ps@pks.im, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 11/13] pack-objects: thread the path-based compression
Message-ID: <aBq4b2R0pAS5PiZm@nand.local>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <ae73d26319ac5db338507988eb23f1ecaac67671.1742829770.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae73d26319ac5db338507988eb23f1ecaac67671.1742829770.git.gitgitgadget@gmail.com>

On Mon, Mar 24, 2025 at 03:22:47PM +0000, Derrick Stolee via GitGitGadget wrote:
> Using the Git repository as a test repo, the p5313 performance test
> shows that the resulting size of the repo is the same, but the threaded
> implementation gives gains of varying degrees depending on the number of
> objects being packed. (This was tested on a 16-core machine.)
>
> Test                        HEAD~1      HEAD
> ---------------------------------------------------
> 5313.20: big pack             2.38      1.99 -16.4%
> 5313.21: big pack size       16.1M     16.0M  -0.2%
> 5313.24: repack             107.32     45.41 -57.7%
> 5313.25: repack size        213.3M    213.2M  -0.0%

Very nice indeed!

> This ~60% reduction in 'git repack --path-walk' time is typical across
> all repos I used for testing. What is interesting is to compare when the
> overall time improves enough to outperform the --name-hash-version=1
> case. These time improvements correlate with repositories with data
> shapes that significantly improve their data size as well. The

I had to read this sentence a couple of times to wrap my head around it,
but perhaps you can double-check my understanding. Are you saying that
reducing the size of the resulting packs suggests that our runtime with
the path-walk algorithm is improved enough to be competitive with (or
better than) the non-path-walk implementation with name-hash v1?

I think that's what you mean, and I admit that I don't find my own
restatement to be all that much clearer. So I think it's fine to leave
this as-is, though it is interesting to think about why the statement
is true.

I suspect (without having tested it thoroughly) that a significant
proportion of the time saved on the path-walk side is because we found
better deltas that are easier to compress, as a result of a more
well-tuned search technique. I don't think you necessarily have to get
too far into the details here, but I was curious (not for commit message
polishing, but purely for my own curiosity) if you had any thoughts or
measurements of why this might be the case.

But...

> --path-walk feature frequently takes longer than --name-hash-verison=2,
> trading some extrac computation for some additional compression. The

s/extrac/extra/

> natural place where this additional computation comes from is the two
> compression passes that --path-walk takes, though the first pass is
> naturally faster due to the path boundaries avoiding a number of delta
> compression attempts.

... I should have kept reading before commenting the above! ;-)

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/pack-objects.c | 163 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 161 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index d4e05ca4434..2a6246c1e78 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2964,6 +2964,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
>  struct thread_params {
>  	pthread_t thread;
>  	struct object_entry **list;
> +	struct packing_region *regions;
>  	unsigned list_size;
>  	unsigned remaining;
>  	int window;
> @@ -3281,6 +3282,164 @@ static void find_deltas_by_region(struct object_entry *list,
>  	stop_progress(&progress_state);
>  }
>
> +static void *threaded_find_deltas_by_path(void *arg)
> +{
> +	struct thread_params *me = arg;
> +
> +	progress_lock();
> +	while (me->remaining) {
> +		while (me->remaining) {

I am not quite following the double-while loop here. Could you help
clarify what's going on here? Is this due to the work-stealing below?

> +static void ll_find_deltas_by_region(struct object_entry *list,
> +				     struct packing_region *regions,
> +				     uint32_t start, uint32_t nr)
> +{
> +	struct thread_params *p;
> +	int i, ret, active_threads = 0;
> +	unsigned int processed = 0;
> +	uint32_t progress_nr;
> +	init_threaded_search();
> +
> +	if (!nr)
> +		return;
> +
> +	progress_nr =  regions[nr - 1].start + regions[nr - 1].nr;
> +	if (delta_search_threads <= 1) {
> +		find_deltas_by_region(list, regions, start, nr);
> +		cleanup_threaded_search();
> +		return;
> +	}
> +
> +	if (progress > pack_to_stdout)
> +		fprintf_ln(stderr, _("Path-based delta compression using up to %d threads"),
> +			   delta_search_threads);

This looks a copy-and-paste from the non-path-walk code, but I wonder if
it might be worth using Q_() here instead of _() to provide better
output in the case that delta_search_threads is 1.

The rest of the implementation of ll_find_deltas_by_region() looks good
to me.

Thanks,
Taylor
