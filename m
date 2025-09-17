Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB222868AF
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144416; cv=none; b=N0SSB/JbtK9DSgI+++ZAXrezrrI9REKGfPJGsiFFsJTF4YZfWh1Uf1ZU5TWQ5LxHqC3EC8vy8qITv9D0yzqFraie8heUlmOj0RjKD0uFzK4tHSvkflKhCGNtZ9fMixs4N/KUitTjlIouij5P/2obsf6FyKQgi1A+kCMQKH/JQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144416; c=relaxed/simple;
	bh=svmoOhqdqzPiZ5/I8/Kk5nGEikrdHkBBPGf3gEVvORI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1/ArZzry16cJcCqQfuAWBDQPfxi694oTkXMnRAFS/KZG47vEAaTSHIC003SStnKF2tNVD8YJqM4NAWoQhlWTQwhaLNGlJl1z+DYom9cnNiSC7RJndd/HJIQUoYIj8MHKDx4icGN0DJ+hDbIADsesZSbqqtmz16nmQPEl72HXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkUiBNrc; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkUiBNrc"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30ccec59b4bso172541fac.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758144414; x=1758749214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Z4+yyKe/6SXVGFGXZlUp+j3F1XZnomEz87S5lr5sE=;
        b=FkUiBNrcpYhMAQLlOXeegnhh1UUFPNvDqXox8yXg6j09BN55ffpEbORaOWvzLgY9ss
         FLPiesRVyfkSeIWP909PLmSJ21Yc+uC48nRfd2fVaF4TCkkixOBEx2MSVjzKeVbqVb1r
         XOnB66S8C2vOjHlxVgjWgQnX3wulYzS6DNnTlK4bP/Mp65hHZql6vYFoJGf5rJdWgyB2
         wzJsWtuw3APGt5t3iZpb6xnyerR53gnuSvrDVfvcUaiTgy94nQBW0YuzjEXNlH19a3ZO
         nH4bYtnKBqHhaxfrYRiDOWYY0NbFWYTQe6slcfHIMbBlEZ87Syk2bgj4lCPEAlUnIn2R
         ZF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758144414; x=1758749214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0Z4+yyKe/6SXVGFGXZlUp+j3F1XZnomEz87S5lr5sE=;
        b=wbTdNDE/8VW7OGlh2j2DIz4+TGyxIyg/OHOVwU0pCNgnsD/6pZMDblrH0W9swZ31sD
         bqQ+G/fu6EXDmyfpYRnODtqkdeMDTFYsqCeoNT0CHNa3o0yAM24bN5D6UE+sXx6V/iL2
         tzx48TCgrtbwX/x8sjasytD/lBwT3FvKXIYyUC2XWmYYtVLhHxdPmvWJmxL9Fd/PPX97
         r9D1n7iAG5+43pkDMukezxINdynqQqoiKAVPDr8EEG5mwGgPS9HYZU0NfwAM5yXawVdL
         /syWr8FaAyllAbVgcbeSwtnJCyjiDv5+DrIgcOJsaY++QqLxvRTwKSXRMz8vfnWMp3U4
         WwGg==
X-Gm-Message-State: AOJu0YwjwtCJ6Ozf6DnBhvaXQ00cEs6ByRMtqmVtHOazfRcxowHwhXyl
	LTtjfHp9B86yKctvXymCIh6TgFD+yAY7MrcTaefAznYQB45PdKmsXE+d
X-Gm-Gg: ASbGncuP34adPMg7wd62CUld+z5rvyArKGh5vuR+u6cygb4MLPfHIZnqOpgieUlJu1r
	OEvTWesN4Ws12S9HuSCxRTXYTKtkgoVPKTCw5N02KizFLWGFPvR9MPjYROC4IOSrhVOEyRruxZd
	UjsKK+QjqWseXEoPFSB5L+/VZCvejwmhhl7u8YhoZldzIy1V18t6Pfd9SXX3i48D05VOjFim0ud
	N79YXMZAzoPBkZDj5QGFzmQ3VB86BeowN3mPpSOAePDAHVFWPmvsyfaMDmI2abp5sMfnDFThaSF
	mUnIIrcVm85SSfRh1w6ioQL1rWNi7nu4tP5vh16u1tg1N7Qb94AlRtEy+/5FhRcew0LKqUTkdLt
	vPQZegGUqzkx0uYgFbsiLSC7kw1Brlqo5t2U=
X-Google-Smtp-Source: AGHT+IHxT8QZXPaXjBaNoQQoMslp9o2mpvX19bTrRZ1d6dzP5SKSNQOBi0E7aJuOFpfZD3PzmrjYyw==
X-Received: by 2002:a05:6870:55d3:b0:321:7bd4:963d with SMTP id 586e51a60fabf-335beedc46amr2200976fac.14.1758144413695;
        Wed, 17 Sep 2025 14:26:53 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7691946549esm272834a34.8.2025.09.17.14.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:26:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:26:52 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/15] packfile: introduce a new `struct
 packfile_store`
Message-ID: <hez25mocjub4zswsptv4j5etgygavllfai6zb6h2tdln2xhmo6@kjvvzrbjmilc>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
 <20250915-b4-pks-packfiles-store-v5-1-d6340350934f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-1-d6340350934f@pks.im>

On 25/09/15 10:54AM, Patrick Steinhardt wrote:
> Information about a object database's packfiles is currently distributed

s/a object/an object/

> across two different structures:
> 
>   - `struct packed_git` contains the `next` pointer as well as the
>     `mru_head`, both of which serve to store the list of packfiles.
> 
>   - `struct object_database` contains several fields that relate to the
>     packfiles.
> 
> So we don't really have a central data structure that tracks our
> packfiles, and consequently responsibilities aren't always clear cut.
> A consequence for the upcoming pluggable object databases is that this
> makes it very hard to move management of packfiles from the object
> database level down into the object database source.
> 
> Introduce a new `struct packfile_store` which is about to become the
> single source of truth for managing packfiles. Right now this data
> structure doesn't yet contain anything, but in subsequent patches we
> will move all data structures that relate to packfiles and that are
> currently contained in `struct object_database` into this new home.
> 
> Note that this is only a first step: most importantly, we won't (yet)
> move the `struct packed_git::next` pointer around. This will happen in a
> subsequent patch series though so that `struct packed_git` will really
> only host information about the specific packfile it represents.
> 
> Further note that the new structure still sits at the wrong level at the
> end of this patch series: as mentioned, it should eventually sit at the
> level of the object database source, not at the object database level.
> But introducing the packfile store now already makes it way easier to
> eventually push down the now-selfcontained data structure by one level.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -91,6 +91,7 @@ struct odb_source {
>  };
>  
>  struct packed_git;
> +struct packfile_store;

I find it a bit suprising that we already add a `struct packfile_store`
to `struct odb_source` since it doesn't get wired up yet. I suppose it's
just acting as a placeholder for what's to come though.

>  struct cached_object_entry;

-Justin
