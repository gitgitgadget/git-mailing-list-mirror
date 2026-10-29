Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308734;
	b=pDt8aUGPUZAiuGuTCN75WrO4kbqEGLT8M01TdREmi3WFXRLyEtPQXBzlCXL/3lcZVHKf
	 4FHzGgnuhYyD6MxqpFcQ5qFpmdyfElXZSIDjNlisD4N6fHSNCPDViHZQx6/jW897ToEb2
	 GVhIMiGw8s3lXK3Jv77kq5JMi6UPGNkALTIAAqObQpa5J/o+gNUdigOBTkt5BsFjqs4fp
	 APN7XKpyPlegPb1jY+gBvRrOP8nlKF0dz0sLNF2+pXJYbXRst4CeK+xBhSDk4cVmbu5sV
	 hFijEWURxmfXn13X9pfJzeXieu77wDayvmas078ZzqmFuYzGQD+Enqwr4IuDSlQQRdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QmejRpjEwVi1tW3IoouzF63GXCjV8gNv5mXQK+ZeFDM=;
	b=5XwOvB2linQVmN9DbDzoZyhMiT6f/WQkUplXnxUxErUI2G7UecW3XKo1ZURGSQ1b3URS
	 Uu1JMytGUKt+LVIqz2un25gMppIKpckS2Idb2cdZ1nHO7XYwuiOafhOjVuth91wXImgay
	 gCiihV6bHWypyEnigWyaxo/lbYG00LOIEwudE5POBCy3ritIO3Y/o292qrwRAR7oWZOU0
	 zU+XKItEkJD9QMTJkCmoLEDWfEMjnIkGEX1qznv5x+WNwJu+rq5IdxOK0v0ukR14hl7DB
	 dQEfMKe2xYmxOxnbesR2ba9Va+KpAFNMGAxJ8RYwVMyMNvPUktefXfkDg3YX++i+UKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+Q8KVbD;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6A606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 21:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+Q8KVbD
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-82109f51565so51313a34.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308732; x=1793913532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QmejRpjEwVi1tW3IoouzF63GXCjV8gNv5mXQK+ZeFDM=;
        b=n+Q8KVbD21Xr2sAxF2MzUv8h3hUq5orAOg6IOkxD5QgIKH0RFeMR37M2A1CJL1c5l6
         +lKmaFYPdUKpfSeMVWl9WGY7Ck+WVoPn12ci8mvayah2x//JyPFKk6rwu0bcUvjk8h2e
         aZr/3Ec0OfWwrEhckD164SdvyTUAx9Qiohgkk/YfMaLCsH16NHpVlwWBmzxGm6mJ1N+R
         Lfsxq2OMDGeCbT0EPFtHZRsJ1aQx2fArM5zH4WW1sD6pvAoz43IMBHMfN9oJZMbsBQLO
         /L8xyMV96NMM77LeKEryOQAZEcDqVHKbhPPEfktTx9AxKyKJmLg9SgwCBN1gyiUTpiRF
         Q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308732; x=1793913532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmejRpjEwVi1tW3IoouzF63GXCjV8gNv5mXQK+ZeFDM=;
        b=2IgqI2rgZgxKWNBXBkd51ksTARQXg70h+lBgayld0MJYpouOiYL42HHESWbWm7caHs
         LdeC4qmVbdvZSBfSBybHI13P4fbSz6Tu8OrNICDqC3KqmUjzG7Hv3PEnj/7w8RHikloN
         IbpNobkYCv2BSWJMauxdlnMSF6R/e4qXeJOTvJKvwnjLoL0MrBksPVtLre82y3GEWje0
         FG5Q5jHPm98YzJZn3I9t45rj+QfVOGCpeHLmOeZMXYQ4PQVCw/UYfElYYr4NeerKgKyj
         jOOwBBi0fUZxRBpc3rWwr5DTnb8QjLnR9UatFDaiunw9WiJ70mJxyxjzo4o0m9lGnsv6
         Dvzw==
X-Gm-Message-State: AFq9FYKygRjQH1/lE6LGvDRUyGAix3GZLAysVMXPWf3Xw92ogYVnYROU
	ujwP7jMyuogZdP4tHH6nowkpRzHiF9ZkwV47U+3RymDepaI/UnbYKIWW5QPHFQ==
X-Gm-Gg: AYBFou30JKTIEEQd3Umix42vDaVhiBYCdY/Tyhu+oifG3NbfWBmrkEvy4OpNL1MqaUI
	sNtwlpkX1BkoApxvyH/dciGz41XbPTM3MdiGq3gT70tyziijGuSciya7STtUU5/DvnJsbY949N5
	1J8PLJu1pcGKlMfGA+NufLsgVEUQ6WMun7qA+fHvGbBGw3p1xknkFZeaf/FDJhPPI5aH2uvHDVa
	72y9Qy56A6D/a2dYTrXCdg5sMPwZYEpaKWM9+l9UBQrbKnIVrHAWB2dgud2lXxiFEniDhD1VTof
	R2OaGScHTRsRtnJPpZ8DQ66qojE6tgYZz4ZY12u5YApl1e8WzAymPtmGWMvLhY69lSSq+t4U7ST
	4bsvoYJhpd97y/SwkU8275Bgmmk4hBLoMNiasqkjqqvoeEamxx8MwFvw+6sZ7fzNXmbyrkEGvaD
	EZZyAV5n7J6+n/ItmrFqfHt01X1Ri3xquj9mPRraR6ZOH7wzn6+lqgd0ahXMwFnNvlaRhBoJMPj
	Dg4kAWBhHWOg5ZymWd/2Xf+8br18CuMV2FM4lrdKwE17MnADw0r2Ki+DRN6/e2DpNWJaqke9DP7
	vuqir0zX+6rQ2L/7dBsimJm4Rv5Dp6mfxT/Z2oO82qRc9ThBEU34vw==
X-Received: by 2002:a05:6830:3151:b0:7fa:ab72:9df9 with SMTP id 46e09a7af769-85d3652cf22mr477803a34.17.1793308732475;
        Thu, 29 Oct 2026 14:18:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm546420a34.5.2026.10.29.14.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:18:51 -0700 (PDT)
Date: Thu, 29 Oct 2026 16:18:51 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] loose: lift loose object index writing logic into
 helper
Message-ID: <auO2XTTAz5RNlhvG@denethor>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029002413.3291184-4-jltobler@gmail.com>
 <auL-YMoeDgx3wEv0@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auL-YMoeDgx3wEv0@pks.im>

On 26/10/29 09:05AM, Patrick Steinhardt wrote:
> On Wed, Oct 28, 2026 at 07:24:12PM -0500, Justin Tobler wrote:
> > -int repo_write_loose_object_map(struct repository *repo)
> > +static int loose_object_map_write(struct repository *repo,
> > +				  struct loose_object_map *loose_map, int fd)
> 
> Curious that you're using a file descriptor instead of a path as you did
> in the preceding commit. But I guess that's because of how we first have
> to lock the file, which we of course don't have to do on the writing
> side.

That is correct. When we lock the file, it gives us back the file
descriptor back for the lockfile. I decided to use the file descriptor
here because it was readily available to pass around.

> I guess we could've also moved locking into this function here to make
> both interfaces match, but maybe the next commit will give a hint why we
> don't.

Yup, this becomes more apparent in the next commit, but we don't want to
acquire the lock in the helper, so that callers can lock the file prior
to reading any preexisting version to get a consistent view. I may leave
a note about this in the next versions commit message.

-Justin
