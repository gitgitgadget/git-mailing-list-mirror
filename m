Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416B21FDE2E
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144460; cv=none; b=Js3JSXNhclmKxcUda2WQ1oQklkJ3xIsH8IcmOsonq6ROGBVOL7afZev96vRhTA1yFJBOEiU9xLhbKxOfHAjTctop8NPcHWaprcmVUClGPu6erJfzeEr0NXsfnvzey5p5FbXcSiapZCN/MmJs+8mfE9exAphhCajwQA4kCKcCX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144460; c=relaxed/simple;
	bh=VEj9+bwRy1FkflOEeu3PWbtW0zZgsGWjW9FQiKhWKZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgo127db9dTljgXHUraJM0qkWZINCZgKVNw71seBbMpdGqn+iadOs9kaqUUGTlznmuC3Aexr7AzBCMWNz3lCCpADkGz7bw+Mpd58dNoIocIKcrEyI7asZIRkPBCTPRkt9cFYTUAfkY0qF9c4ko4IgDdnVOoenpDiXaan11LJWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHL4pHix; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHL4pHix"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21200c749bfso35508575ad.1
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733144458; x=1733749258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1Z7Ez+7SxxPcOZ7V4WfVlJkkor/6SdIP2nzgTcYx8o=;
        b=cHL4pHixDUTZpsJb1OYARUPkGAGeJCJMH7R4DER9DLsQQpGYx5a+QAG5jBkxM/AB+K
         slkgtXjeks864fobLt4/yZ1v8oyta0ZyTxDXypxcuxE2qPDiSOkKIfIsiJMBehucrErF
         y3at13DJopOaXAe7oNR9lChjdzK2sTJOl4rALTqF9Y1YYG3LEn/9Bh27RCq7j/OA+iNs
         ce6WPxe15lOkQ2FAn1MrBK5gOpirc5rWFYQAlWLPRrwyCNBmfc5O7eehbIglYRDG5K55
         qewKWcs+uktx8YLch5Clp3ajwDlU54WIaD7SZLBn/z4mEz2Ng5z39/CQzhvZZZErdTU1
         3eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733144458; x=1733749258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1Z7Ez+7SxxPcOZ7V4WfVlJkkor/6SdIP2nzgTcYx8o=;
        b=gZAWOJC/n5mLBzux3sGQ2HSVKMk5VLR2BwvxOJHbVsgT8pcv4gnqs2PztcSarCAO2c
         OchIA9/pJqb8vOEaJExQkki+DmjkXXsFr6LGUKB7H8pi7aEievI916IvmZp3MxWWpSut
         ClEz3kmpgNb4XQZEh+kDP6kjR+prU09cZnOcYKMe87xB+1Gtvbi8ZV4Wcdhf/EJXY/Qn
         0aoCJqB48N98J/CY62akssaDHdutlOxeN2tv4KOC4V4GuVx2LmTxJcjNBG/s6t54xBLQ
         2Uelt22/2+dvCt5RBOIOeIB/BFvDaHh5AOZBs6TNqtUvXdrPSf8mShDQujL/C+Pd6iCX
         Vltw==
X-Gm-Message-State: AOJu0YxuWa9J/jIvV9uwWyuqC7dNWXpp1WAMl+6yQZbRJgXEcgVhsujY
	0/X5Dce2Xeu5cMrwW9sO4j4mRXVQxDCaN1CWsWsoqHrykvWDR2TE
X-Gm-Gg: ASbGncv7C9kbKJ9Zy5Fvb/q0L/KnPARtSM0TVbLmtCUNGjWn9axnWNqFDPPen5i1E1h
	FQklU7D3PrtvHb+svP90EhdYD9ubiDtpPkeMNh4NQkj6z3PuAOU4PZKDxMcpWVajpVuR+uKyBix
	hyo629drjs1Q5mzePzJCMfR1Ked6acoggbpzBjDGSL1RYpQiSatYM7LQ/5soTK5YUEKp7BeNebi
	+jpdXiJN3t1WB+H7VPee7/xHFy9aU4lW6IMK11328RLgQ==
X-Google-Smtp-Source: AGHT+IHACcwoy9k5ZYzOwcFtlLiTl2O2v2mkknBChZxeTYjHE3aos2lAdSDhQD/cs/NiZzZ2cR2SNA==
X-Received: by 2002:a17:902:d489:b0:215:827e:3a6 with SMTP id d9443c01a7336-215827e05b5mr81809105ad.40.1733144458400;
        Mon, 02 Dec 2024 05:00:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153a70bbd1sm62593985ad.231.2024.12.02.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:00:57 -0800 (PST)
Date: Mon, 2 Dec 2024 21:01:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, git@jowil.de, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Message-ID: <Z02voaSNYRciv38z@ArchLinux>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202070714.3028549-5-gitster@pobox.com>

On Mon, Dec 02, 2024 at 04:07:14PM +0900, Junio C Hamano wrote:

[snip]

> diff --git a/refs.c b/refs.c
> index a24bfe3845..01ef2a3093 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -735,7 +735,7 @@ int check_branch_ref(struct strbuf *sb, const char *name)
>  
>  int check_tag_ref(struct strbuf *sb, const char *name)
>  {
> -	if (name[0] == '-')
> +	if (name[0] == '-' || !strcmp(name, "HEAD"))

I am wondering whether we should also update "check_refname_format"
function to report "refs/heads/HEAD" and "refs/tags/HEAD" is bad ref
name.

>  		return -1;
>  
>  	strbuf_reset(sb);

Thanks,
Jialuo
