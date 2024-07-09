Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB36153505
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560597; cv=none; b=LChbM0U6B15XzVXHWXEVjaKA50i7DhqxW2frwWxz1ogP2JYMDHz1FMdrnCwaHsTq2QkTUBSO/ah7k6e6vDDIOCqPMmcVC3iRrsQni0UcYaKQg0NbjpQ/Y/Fx418QBHwx1L0asaLvvHvgaPNR5Gyd1RVTLEoWndpl1ZMu8M+YLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560597; c=relaxed/simple;
	bh=HFnt7MOjcTycv73mrMHHMxprv1ZiwTSyM6rFh+APxu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIh6CAZnhylggImkoSTj8j/xBl3Yi8tKyvEnOIB++rq/SRlCyVFzQBSArgdSBX3T5Hk2Piw+7ec0aJ0jeY1Dao1q05n5nu+Fifql9j1EuQxYQQXPfafhn+HKhkIStsPuzg6rsoQ7ryWndb1JcdkRLHhFMmjosWLZqnLcEn4T14s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBlzXi2c; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBlzXi2c"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d932f991f6so1529237b6e.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720560595; x=1721165395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeQZbwKrrvDfAjZJE2pTNNQinxH+qRwpWiY2HdFEZgs=;
        b=jBlzXi2crHCbRlx6H0J+PL+hXfB/ZgXk51z08ENt+QvbM92PeldTdayAREDD6fyTvY
         P9aqKEu/q5V1uSjtPuibiXI2B5XvhCAKTLS00rGI8lzedbgXMYHTY2PjbR+YFTs/g+QH
         an9Ls4vFdO7UHhiZlrqn80D9fkvjPSKBUdiqPqVEKqhuQRDKA8hUWysiuaoiqqwzf43I
         +MGsyi07XpOKmr8rsa3tUts6+/XOTiYnUvNYgLY462m/hvCkNFQeN1SPcB5HGsMLR/H2
         7HiXrg3yzerE23hIf2YtQnio76byKj2eOurciG+2EcdXZS+J5u2O/d/T296bd+WxSTj2
         IzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720560595; x=1721165395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeQZbwKrrvDfAjZJE2pTNNQinxH+qRwpWiY2HdFEZgs=;
        b=iimH/69ECMBwzCbe66DNOzI2ORIcY8Q83kMDL9Ph5AyOgnkxUrIY1lK2KQD9HafjaM
         js5xXVYIEEV8W+vAHeqoWNzl7hVsJQbhalgSxG+JU42eaR2JqQc/I9aMnaP33JSil/Iu
         6lEKTWgADb4DCi2555Sx471+1DawDfo9nrpwKoPomdaNANDAtsNRsmVQ+gTUxQhZZmrK
         Sj4JBZUJAxyQxbWKOGPSeLc1vPIjVr642fWfNITt0dbuCju65Weno27DrmYgZECEB4dc
         andf6AQYYr7ZG1CeDmy+ruhJNphgZD6/aKuB0RreDs649ic6/+A7XVVl/pZ7JyEjZtm0
         So+Q==
X-Gm-Message-State: AOJu0YxIXzuvFgo1SAdsg0TJN8KyI8C3p03LWQaFoT6VPTMXAJyBzcvm
	gg67pPDIG07E6PFGGJdom+Q2BKwoSr9dnrb7zdDOL8ZaOXkyIPy5
X-Google-Smtp-Source: AGHT+IH8i5B8AxAQfjKFMCVcqRrHLeuGXrPeoZMlUxAWhBdt2NPiB88tNfD/CP495vbsg6a3oTwq+g==
X-Received: by 2002:a05:6808:d4b:b0:3d9:28b7:a4a5 with SMTP id 5614622812f47-3d93c08650amr4391951b6e.36.1720560594543;
        Tue, 09 Jul 2024 14:29:54 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad13728sm563895b6e.18.2024.07.09.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:29:54 -0700 (PDT)
Date: Tue, 9 Jul 2024 16:29:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 3/9] fsck: add refs-related options and error
 report function
Message-ID: <oan7pcamqpi2z4jzfshff2sfziqgisd3jcbpzfoiuyks5g57mk@7isgeztkcgmy>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0uiz1y6hJld2Rv@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0uiz1y6hJld2Rv@ArchLinux>

On 24/07/09 08:35PM, shejialuo wrote:
> Add refs-related options to the "fsck_options", create refs-specific
> "error_func" callback "fsck_refs_error_function".
> 
> "fsck_refs_error_function" will use the "oid" parameter. When the caller
> passes the oid, it will use "oid_to_hex" to get the corresponding hex
> value to report to the caller.

Out of curiousity, under what circumstances would the caller want to
also pass the oid? Would it simply be to optionally provide additional
context?

> 
> Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
> macros to create refs options easily.
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  fsck.c | 23 +++++++++++++++++++++++
>  fsck.h | 15 +++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/fsck.c b/fsck.c
> index e1819964e3..c5c7e8454f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -1252,6 +1252,29 @@ int fsck_objects_error_function(struct fsck_options *o,
>  	return 1;
>  }
>  
> +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> +			     const struct object_id *oid,
> +			     enum object_type object_type UNUSED,
> +			     const char *checked_ref_name,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id UNUSED,
> +			     const char *message)
> +{
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_reset(&sb);

Naive question, is there reason to reset `sb` immediately after
`STRBUF_INIT`? My understanding is that because we initialize the
buffer, the other fields should also be zeroed. If so, resetting the
buffer here seems redundant.

> +	strbuf_addstr(&sb, checked_ref_name);
> +	if (oid)
> +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
> +
> +	if (msg_type == FSCK_WARN) {
> +		warning("%s: %s", sb.buf, message);
> +		return 0;
> +	}
> +	error("%s: %s", sb.buf, message);
> +	return 1;
> +}
> +
>  static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
>  		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
>  		      struct fsck_options *options, const char *blob_type)
> diff --git a/fsck.h b/fsck.h
> index 8ce48395f6..ff52913494 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -135,11 +135,19 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
>  						   enum fsck_msg_type msg_type,
>  						   enum fsck_msg_id msg_id,
>  						   const char *message);
> +int fsck_refs_error_function(struct fsck_options *options,
> +			     const struct object_id *oid,
> +			     enum object_type object_type,
> +			     const char *checked_ref_name,
> +			     enum fsck_msg_type msg_type,
> +			     enum fsck_msg_id msg_id,
> +			     const char *message);
>  
>  struct fsck_options {
>  	fsck_walk_func walk;
>  	fsck_error error_func;
>  	unsigned strict:1;
> +	unsigned verbose_refs:1;

What is the purpose of adding `verbose_refs` in this patch? At this
point, I'm not seeing it used. If there is a reason to be included in
this patch, it might be nice to mention in the commit message.

>  	enum fsck_msg_type *msg_type;
>  	struct oidset skip_oids;
>  	struct oidset gitmodules_found;
> @@ -173,6 +181,13 @@ struct fsck_options {
>  	.gitattributes_done = OIDSET_INIT, \
>  	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
>  }
> +#define FSCK_REFS_OPTIONS_DEFAULT { \
> +	.error_func = fsck_refs_error_function, \
> +}
> +#define FSCK_REFS_OPTIONS_STRICT { \
> +	.strict = 1, \
> +	.error_func = fsck_refs_error_function, \
> +}
>  
>  /* descend in all linked child objects
>   * the return value is:
> -- 
> 2.45.2
> 
