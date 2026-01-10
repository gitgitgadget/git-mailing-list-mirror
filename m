Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D11400C
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768049256; cv=none; b=aHAOZFRaohSBYe9kvV9DEAgWbNzVfA0oKUHnrSCBCF+PE4XOAbEp9rVgveV5Umc8R1dmHFcvaCL5lOlWQeqgCZuR6wixgFPrePL58KOFl57SMoV2NwRaJghe8DawUTRtdw2wGVEZ9U5CeymRbR9ZInzCAKy9ZM/PJfC5CBgweAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768049256; c=relaxed/simple;
	bh=5W21Jv7DUbv/Me7lwRcR4qYdRlrjQk3MPh5sHRm/AGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMRQumnxycljxrixeukExFHk2kFaiTlWWG9bNneet/tnEN3dLBbf+shb2/CMl5+92MNcrTTfm061bYQSuP1nqrwqplj+XOLBKtnlSMrZUXRhG6B7NtRUb87BEoPLrQsX7lwHTYK/5k3oMcLWg8ZJJEtSIwWXl99HLu7jPefQMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwlvrd5G; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwlvrd5G"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae53df0be7so7850689eec.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768049254; x=1768654054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4bk/zDklkWGprVZU3xWNjZD2SAzjQsJ446c5jdlH3g=;
        b=Zwlvrd5GeCdXifvRb14T3V7UxMFyOwErsgcw2mVzKj+VatG/NJWoLf+00VIN2+clTl
         G/aGcZ60w/qA4j4XNc0xgofQgT47gpNlocV1VR01gljodC0IXauIYnI6w1QBHLWqgzqf
         bpQK7A7wmEn8M4qdRxfKpvtygLA05evWhCUeb9oeHSIsSnWQS+dem3/gAL7c4gU81Pmn
         wzgkE0o2zlyAXfc8z/znO+XSzoWK+g48xzuuVysv9WgD4sKy5PxQ5lYpex1QQBrMeNNl
         bX70ANBtlOMGxvsaMAcCTyqbUFExBV75vkgiSOX80Qk4y6WFoE7IV/m6mdtfrV4i4Oj2
         U2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768049254; x=1768654054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4bk/zDklkWGprVZU3xWNjZD2SAzjQsJ446c5jdlH3g=;
        b=sFK1Ig+dYT0m2vCy+1b2wXO+Je5X9WmMsW7wXTFkDzMp0poXpTecAGw/k3Mkr/Yxlm
         UIEx+QsXwvTAdMarGLuz05ieII0H9LYEvNJoQHKIQR8QX3aPz2mkgvw1WlaTuoZ0b+83
         wbnNrszaNh73etAakDjqLcWyRg7j74hb74w2wM3Y9H5xbtwZm/1Nrl9SYTsYrZ7FRsyl
         lqGVB59XVJRuuLsSCO8oSB+Gc34UBnf8xu/J9gkp0Jv2W0qL3/wXOVlasFwH0gMim7U5
         ZYY5EwzO9obJu/Ukps+NcDTWpwdWrwxYVdPgiPYc9+CgPAtCInF3WHjd6hozZ7ExIKfA
         gvKA==
X-Gm-Message-State: AOJu0YxC5uS02GN/XQPsZXwS2MCPleBh3fl+enDo4U7OeERokpxP9fWF
	iHcaVuWUmcO8f97oMVPisGrbOYObvTLTS2O+wWu/Puq9rUYK9CAvsHy+
X-Gm-Gg: AY/fxX4qzWAFBW8l0Lk99pzxbfi47G9Cq5jYABsLpegTdfpLraH/P7uZNVwyt2FRhsP
	k98dKCdjTtTs00SpxirMkUtCCaf20VrPF7Bb9P4TDxyG5IT9CO4AhAYFQ78jd0p/jit+ucTCDq7
	iQszaocRq3d0pZOkhnHeC5iB8FMZGBwsYjRsg1QlADsdXKZYMmIDU/DrRviDCvey3WGRzLZTVuU
	qad7H0GUCP1moTvJCiiNwKglUXjo3Aoe4DNTN8SWF7GmDmH09oZMk4l9uEdhY8Pw7JntbsyJfmu
	eE4GBm/SmRV3RxlvjHo055APH1mzARAQyzFlKLAF3Ss5ZxtkAOX6E8lTpTBjZFRsLyG1Twif5Gu
	1oNJhTqlO1GhKfkcdQeb7+WMvkl02XZJaPOwG1rJCKogUKtWHeG+wdVimngm4NlHLkETDBKNH6W
	EsFaeNog==
X-Google-Smtp-Source: AGHT+IE46TFrMN6Se6/33jb8Opb+buxM2M6v6W9ZvWakuIOefHacf5Dmb9aN5fAQwUOVBAhBcueXoQ==
X-Received: by 2002:a05:7301:180d:b0:2ae:598e:abe8 with SMTP id 5a478bee46e88-2b17d2e4edcmr10242469eec.24.1768049254448;
        Sat, 10 Jan 2026 04:47:34 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm13345907eec.5.2026.01.10.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 04:47:33 -0800 (PST)
Date: Sat, 10 Jan 2026 20:47:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 07/17] refs/files: perform consistency checks for root
 refs
Message-ID: <aWJKYzcY3H_-xy1V@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-7-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-7-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:36PM +0100, Patrick Steinhardt wrote:
>  static int files_fsck(struct ref_store *ref_store,
>  		      struct fsck_options *o,
>  		      struct worktree *wt)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> +	struct files_fsck_root_ref_data data = {
> +		.refs = refs,
> +		.o = o,
> +		.wt = wt,
> +		.refname = STRBUF_INIT,
> +		.path = STRBUF_INIT,
> +	};
>  	int ret = 0;
>  
>  	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
>  		ret = -1;
> +
> +	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0 ||
> +	    data.errors_found)

I am wondering where we update this filed in `files_fsck_root_ref`. It
seems that we never do this in this commit. I think we should delete
this filed in `files_fsck_root_ref_data` and add this field back when we
do need this to avoid confusion.

Thanks,
Jialuo
