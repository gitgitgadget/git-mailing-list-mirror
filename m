Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90E19AD90
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534470; cv=none; b=dGEQ/RjlBvnSRNeEIufLergtyMlPfrFnC0ubaE6MuOBkZrcf/9uOLh7aI3uiNIzqFiE5QZGhUEg8v/XkMd0hF0ivhQgKaLJME1p0f3+etyEHtgYXQSvTS318p4OGAkSbgjvRKLq/I48es/Ag4UjC9Fx41l63rfrXknpAdgWEg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534470; c=relaxed/simple;
	bh=RhGMePsWHGu2iKEJjWzmKAMyooSnc8sCAJx/+gc8a7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma+Ctz2pOgpVD82VDwEbquJoOy5+X0Z6kKJqsM1fMw5LclsycKOvk0JMP++L/9OVpW5Yg0vq4oYeYklP0+H2sO/Q8vAF8WbwaarlMHI1fLzxpwZclulytqB9tCUQltKoVHsS6NF+f/Jxl3J62nv9MTazd2BR9Xd3FKvHCtV9vgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgtb+4P4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgtb+4P4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441ab63a415so12264025e9.3
        for <git@vger.kernel.org>; Thu, 29 May 2025 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748534466; x=1749139266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6FvOPrzAbKzsPYIoUjlQQeKve9/Ii4mMJ4cm5LtEe5Y=;
        b=hgtb+4P4Je+dSxWFQ9kaOwjSOWzM0FOrIE+0xJ3Eb4cU15IhITa3C7aOQa4pIrG3m+
         xV/rKeenK6e/KacC6FwZL2L+10OpniowpzLTfk9TbFrWPv7+AEmR5SJ5xQrDamQNloOJ
         T4JOKDSndDIARR16su1SzugxIh7Kuu0rdVi2s5LRxNjovvn+qQe2jvDZyOYFejtZaQw4
         YP7qEJdBv5pEHfl0tZKrL05hyaK3Za6sETyCVbh5FPQhNLhabQOhzzopjy6QSi0jeSlV
         gClCTT/C4BpW7whXC/7QDuj259gMO2O5/3oBkA+oy+CdSP9W9aVhg9Wc6oSvadE9KLPB
         RfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748534466; x=1749139266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FvOPrzAbKzsPYIoUjlQQeKve9/Ii4mMJ4cm5LtEe5Y=;
        b=kTVq+C8HbNowV1WdZx9tU0TXo7eVast9QpilXZze6Vnz++0GfrBlj40lr0pM4SDHUH
         iO13SwEuBxVWeWWi2rQk5ZUS+dW4pCePkVOuwzWICiWcPRcI7EUbPmxxo5+bgtRb068K
         S27eZIPGDjvYkIcGbNT+2vWuFdrkMSAVRc7wxiIP/KbQXDRSmzj+YgqkiiL/O0kvHsia
         5pEQBI9ktpsM3lxDsa9Z4SBglFB2rpc1t2w336VomspH7oYEJu6McfkINomVkpf0bD/a
         a0xu0Eq9i9dUCOX9c6aobqRvKNPlvtc3A6P0Jo65J5Fs1frcVDFVRZYTdyoKzmF1NocX
         YkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqs4CM/qh33i1xhtqlIoMoX9Da96+sIlcgUd9FYr8aEOFzeFptcFl6ggfNPmwasgO90QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYRBN6eNwiMRC6TMVG3BoNBI6Wd5BwYVjnAvaVO40oQkq56bZ
	v2w1CHfZ1nCAJsbVsU95e4stlEu7UWnBQG3OmQvjyuk6MaKT3ZQfNDtd02FHeg==
X-Gm-Gg: ASbGncuArRQvZPvuqwOOP20gixZHDlhyltCM1NrdG4/oFJZ/vFmy0nIo7buTVbx4ag+
	BYC54eTEMSSXgG3KnSZqUnEC4ZQafF/AGKdBznDmuQBxGNCUEItMn5ox7ecrH5EVTJOSushpTef
	Vl11G6YZkEPU1+jJ6i7GN0Ss8dlIxcjyI6rXYuDVfrIdVGOAYUvGXa+/LetH+3BgbDr/HIKELep
	sbkaoB8IHXHaSUwm8dJ9n/cRjaO0opCbrkGHc2D3UmnO29HPVI/b8A/77OspnR4GIHYRBWbgsAG
	XdGbPB5McW/OrfRycQMKoFN6Gk+sMeFgztgsPBCCmKW6P0+1j40IWYSk5nZhJl0JX9+iIs0Xy21
	n0R5mD3Magv/0UjzTCcvd/DZr4m0=
X-Google-Smtp-Source: AGHT+IH70az8eDFq3d6LffKn8RdInnMgwNZcDNTlEpbRpizAq5omU6HBS9GFJuRQ/2kmHhA1ptyv+g==
X-Received: by 2002:a05:600c:3f10:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-450d6591a0cmr2184745e9.32.1748534466078;
        Thu, 29 May 2025 09:01:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc02ce4sm23197205e9.10.2025.05.29.09.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 09:01:05 -0700 (PDT)
Message-ID: <9429a84c-d5e0-45df-8fd2-6dc92cf39d9e@gmail.com>
Date: Thu, 29 May 2025 17:01:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/5] builtin/stash: provide a way to export stashes to
 a ref
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-6-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250522185524.18398-6-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

This is looking pretty nice, I don't have much to add to Junio's comments.

On 22/05/2025 19:55, brian m. carlson wrote:
> [...]
> +out:
> +	strbuf_release(&msg);
> +	repo_unuse_commit_buffer(r, this, buffer);
> +	free_commit_list(parents);

I found this confusing when I was reading the caller as I couldn't see 
where the list of parent commits was being free()d. I think it would be 
easier to follow if this function did not take ownership of the list.

> +	/*
> +	 * Now, create a set of commits identical to the regular stash commits,
> +	 * but where their first parents form a chain to our original empty
> +	 * base commit.
> +	 */
> +	for (i = (ssize_t)items.nr - 1; i >= 0; i--) {

This cast is pretty horrible. ssize_t is not guaranteed to be the same 
width as size_t (see [1] for a bug fix on NonStop caused by this). I 
think we'd normally write this as

	for (size_t i = items.nr; i > 0; i--) {
		const struct object_id *oid = &items[i - 1];

[1] c14e5a1a501 (transport-helper: use xread instead of read, 2019-01-03)

> +		struct commit_list *parents = NULL;
> +		struct commit_list **next = &parents;
> +		struct object_id out;
> +		const struct object_id *oid = items.oid + i;
> [...]
> +static int export_stash(int argc,
> +			const char **argv,
> +			const char *prefix,
> +			struct repository *repo)
> +{
> +	const char *ref = NULL;
> +	enum export_action action = ACTION_NONE;
> +	struct option options[] = {
> +		OPT_CMDMODE(0, "print", &action,
> +			    N_("print the object ID instead of writing it to a ref"),
> +			    ACTION_PRINT),
> +		OPT_STRING(0, "to-ref", &ref, "ref",
> +			    N_("save the data to the given ref")),
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_export_usage,
> +			     PARSE_OPT_KEEP_DASHDASH);
> +
> +	if (ref && action == ACTION_NONE)
> +		action = ACTION_TO_REF;
> +
> +	if (action == ACTION_NONE)
> +		return error(_("exactly one of --print and --to-ref is required"));
I don't think this protects against 'git stash export --print --to-ref'. 
It is a bit odd to have a single option marked with OPT_CMDMODE() it 
might be worth changing that to OPT_SET_INT().

Best Wishes

Phillip

