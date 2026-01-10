Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B71DE4FB
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051872; cv=none; b=hyolbfuNie2l08DN7MIzfpnXPgpeO890JV8PZGOrwXbNE00gSUwS8a1anpX1R2+/ciHDVwQ0IRESAbEYvJ/OvdxV9BKSG1Ng/PLfofg+yUKRqkIW/75phSAkgO2RAwNzrAAgkANA3HVzGMRFzrUSCCUMrDSi1mzmnimTBWyGpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051872; c=relaxed/simple;
	bh=LY9Hjrdy05qZehB6aG+7QtS0O7RBVtNMICVX1gCEUWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx0PxLvsy3Y0j+J2GKaN6slBmfQh70UBXIrxHaCZbA6F+Thkkc9CoxpDCskuY+Ntgs1AejTnXVCGi9qhf/wQKpP3yhmod3GT0L+GIwBlIj9Mo2IwbZQSQj+c4ZcpMeiKocRyDhnjF/C3DpfKnJTM5C4V8179LDgwWtHo2DA3t3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLd77kpV; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLd77kpV"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121b14efeb8so723182c88.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051871; x=1768656671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2yL5mVr4eqNUXq04nMw9orCXXlPFv1Ulu26jQQgAeo=;
        b=OLd77kpVwWoMJ7Baj7guDcb8V+ktD6ixCzNMU6/UESdHIniDtIckgN8yDKh3YLVnY7
         PPzYYFu7rqxTIwqKhF5nBw6cPCWh0khl+Qf5HERKBwDoWkB4OWgTpeNd20xR60XSJuJX
         Bs7O7Dr8U7jNTZvBIW44u9CQddoXVV0SH/q6GyWe6YphqmBjnA5k8b7fs+N78RF/QJ07
         QJGU2Tl/oJo4H08rt5i5O/f135Tn2aGsDf/yBoZGMCrBRNk19yrJ5Prn6eXMSIcKUPIR
         oTfpchZgjKRz7Srs9EO91UMHQ7V945dCkM4nftWCD9kuo1++RqnnOQBUhW8msNW8jTm5
         XAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051871; x=1768656671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2yL5mVr4eqNUXq04nMw9orCXXlPFv1Ulu26jQQgAeo=;
        b=vb2ZBBwMqCeTcboMmuVU07O343Xr0tVZBDHIk3ESL9JVYsUBHdsMEulUT75K4EL+FU
         Sn4emEP8sdgkfqr+Pgi3HXjMIyXJX7cVbiZnEU2x+OTNKag1PByCAv9wzyAFzPu9PvVe
         BGo1OJHnLdIqo29PhP+QM2E4n48wxy1weFPfLcGee95JXm6ApGwZL7T1u0CuHMFr35RR
         hTrS+8RdnxFWMrdRGiPIPnVjs7C12mCthxA1UpsD8imyAT1A7kajXQBCz6tKBUm6+hge
         RzptjpXvj4VAoQ/svfErSaTokvt24EY+V+674Vdo31pb0nTjHuIiz1ySoXhBzMn416I1
         GB9A==
X-Gm-Message-State: AOJu0Yy74bNyNAYMlox/r9tLjfTeOYo5eXM0lyNLVD1eYHWwtOH+/xLo
	kjwDz3kS0ReHoWcs+FetlgMaHdJYNpt3iSC2BMwV3ctUH+ujd9D+d5Nf
X-Gm-Gg: AY/fxX5hlK1q4xq2S29teCySeVfcF2qN0mkAJQatJwp7yKhLESuUpcSdJ+6VRU6hKzx
	CGgpX3Bju51eweJXyzhqWYzn85d1DldroKt4Wz4Xr9UX38FgI4K0xovFZYF4mGJoSdBYS3ZHbDS
	0Gg5GuE++qU5MsSx6Uk4y9zvPQiWjEvy1Oua/IdFLmg9uIsZB254g7KhFItNEVWDWi6Dm0HANHK
	Rc3ailjYiwz+ckmvFuBSUk49xeEcWHzpEBrLvsgQncpGW0TPiVbjCbc6S7ACXGeuG8cX5nneHA7
	MRUU7YwmIKfA3HMHxF0ks+xFGtci4hF9bWFgYGpAk3RqimZdfwf2whgb6iNm8SQQk2Rw+lKQEFM
	LvF9L6MO+8NEIBr0vtvviu4gpnI55nZDC4+dI0szl4MRhiwnm9ecZm8363GGtsUE8GLPOQHdLWf
	rf6cV79x5RC5AaZRXv
X-Google-Smtp-Source: AGHT+IGOmaShqn1aWcTGikUWSyU/PrkwNfrUfOU5lVHhI7+QV3OxCc+6pTnm19R91kdeBgZ8Fln6IA==
X-Received: by 2002:a05:7022:251f:b0:11d:f5ea:7429 with SMTP id a92af1059eb24-121f8ae690amr13373049c88.12.1768051870520;
        Sat, 10 Jan 2026 05:31:10 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm15558243c88.17.2026.01.10.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:31:09 -0800 (PST)
Date: Sat, 10 Jan 2026 21:31:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 16/17] builtin/fsck: move generic HEAD check into
 `refs_fsck()`
Message-ID: <aWJUm-hrPquegbdf@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-16-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-16-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:45PM +0100, Patrick Steinhardt wrote:
> Move the check that detects "HEAD" refs that do not point at a branch
> into `refs_fsck()`. This follows the same motivation as the preceding
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/fsck-msgids.adoc |  3 +++
>  builtin/fsck.c                 |  7 -------
>  fsck.h                         |  1 +
>  refs.c                         | 12 +++++++++++-
>  t/t0602-reffiles-fsck.sh       |  8 ++++----
>  t/t1450-fsck.sh                |  4 ++--
>  6 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
> index 76609321f6..6a4db3a991 100644
> --- a/Documentation/fsck-msgids.adoc
> +++ b/Documentation/fsck-msgids.adoc
> @@ -13,6 +13,9 @@
>  `badGpgsig`::
>  	(ERROR) A tag contains a bad (truncated) signature (e.g., `gpgsig`) header.
>  
> +`badHeadTarget`::
> +	(ERROR) The `HEAD` ref is a symref that does not refer to a branch.
> +
>  `badHeaderContinuation`::
>  	(ERROR) A continuation header (such as for `gpgsig`) is unexpectedly truncated.
>  
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 4dd4d74d1e..5dda441f45 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -728,13 +728,6 @@ static void fsck_head_link(const char *head_ref_name,
>  		error(_("invalid %s"), head_ref_name);
>  		return;
>  	}
> -	if (strcmp(*head_points_at, head_ref_name) &&
> -	    !starts_with(*head_points_at, "refs/heads/")) {
> -		errors_found |= ERROR_REFS;
> -		error(_("%s points to something strange (%s)"),
> -		      head_ref_name, *head_points_at);
> -		return;
> -	}
>  
>  	return;
>  }
> diff --git a/fsck.h b/fsck.h
> index 1f472b7daa..65ecbb7fe1 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -30,6 +30,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_DATE_OVERFLOW, ERROR) \
>  	FUNC(BAD_EMAIL, ERROR) \
>  	FUNC(BAD_GPGSIG, ERROR) \
> +	FUNC(BAD_HEAD_TARGET, ERROR) \
>  	FUNC(BAD_NAME, ERROR) \
>  	FUNC(BAD_OBJECT_SHA1, ERROR) \
>  	FUNC(BAD_PACKED_REF_ENTRY, ERROR) \
> diff --git a/refs.c b/refs.c
> index c3528862c6..a772d371cd 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -334,8 +334,18 @@ int refs_fsck_ref(struct ref_store *refs UNUSED, struct fsck_options *o,
>  
>  int refs_fsck_symref(struct ref_store *refs UNUSED, struct fsck_options *o,
>  		     struct fsck_ref_report *report,
> -		     const char *refname UNUSED, const char *target)
> +		     const char *refname, const char *target)
>  {
> +	const char *stripped_refname;
> +
> +	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
> +
> +	if (!strcmp(stripped_refname, "HEAD") &&
> +	    !starts_with(target, "refs/heads/") &&

We would first check whether the current ref is `HEAD`. And I am
wondering whether we have some common APIs. And I find the similar logic
in `reglog.c::is_head` like the following shows:

    static int is_head(const char *refname)
    {
            const char *stripped_refname;
            parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
            return !strcmp(stripped_refname, "HEAD");
    }

I think we might just extract this common logic to avoid introducing
repetition.

Thanks,
Jialuo
