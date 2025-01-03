Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314517DE2D
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869659; cv=none; b=VZaPPFA+mDO3ZsZEaBlL60QkeZVASJsakffvs0cT6ctIpeNCWrgHjeH9tTozMAI0WbEwkLxmJzP0B3SAGXv1TyfTLrSmmQGxbRdmdhkt8OJX5+ro0AWXjctmtqRDf7wkuQfV3t605YnIfrNO0NPAch7QwcbFuLfusMoGE1qHSFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869659; c=relaxed/simple;
	bh=Na+h6kRxYogmJBXi2wUndTCzL0gFoxraWCzbZHT8VzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj/dVaU1TIdxnfqKNOIVAcxoKiPPcTc1A9NRFs+Y1HLxXWGuCVvim+2uwUJIAb8kPDhLemb/qTnKRMxRDgkpoRLbWj+aowW6RDruUMTP+xWVfCsGZacLJaP9Q7tFsUvb36F3iZHWLScKFKXzskksT8MmQyB9R12CVigUldo6cGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwt4rQHg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwt4rQHg"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e2766994bso6113475a34.3
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 18:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869656; x=1736474456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geZbIodQQaR2trIvIwbHb2E3cc3KWoA2gNhZvm7n414=;
        b=dwt4rQHgPOYgcBBgzrEe0/I1rNYO5cRZmXoFARQknALJYZhZQsyeIHz2jzm2Yu/S8W
         JKSWene+ePekXwEn1XF/QfgZVWAFYzFAqdaaQcr4lkkPfRJrmcrJnvUxgG0W3IGEN6E/
         53+nJhM74fV/JNG7ib1RWLLKu8XcvmROaurimN8qO2W+yVMh5WAP9oyRt6Yz2NVQbAe2
         zwPqOTc484I9sDjm+Ccn9OdfK8IP+K/9wOuRm5XLeREuo/bQpAJlPHUfFLqtSaWsQwXD
         C/nM4TO49tGgzbUDBcGUGLl+OEX9YgXMUl04N+VLvnhW+xl8ZoEzpPULpnH2kQKQ3zxi
         QyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869656; x=1736474456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geZbIodQQaR2trIvIwbHb2E3cc3KWoA2gNhZvm7n414=;
        b=f3ABhOFfLzqM4j0OpuzPuzbZMvAafJ9ucCBaZjYddumPKKQ7cBomyVDc7uxjMw/bV6
         beBbybAqi+Ki21lEenBoOvKbTFv5aecXb3eupp/iTvVXPsSDDhnP8L7Pa+37+67/GE9Z
         biLLhLXZTaffgldq4TDT/eUPyYtG8hY92Zl/2Mj324ayQMCxQC3nAzQzXzSqlRU0D7FD
         Gyb8i7PeI4OoHE/hbwqc0Zxa19sGvo6ecdq0HQG1uZ2J/LLs0gNWMBzj1qddUPtNsAkw
         TZ275o541hhvlYgcvw6vdPVMCj48TmvkyNLzCE/ByGHi8GokZPwFeDY2xL5m/6+BZOZh
         cUbw==
X-Gm-Message-State: AOJu0YwM0loMOYTrAF77A1jyzFE33Lwwf3AghgzrXaVZwhJ/GM92hLRz
	1mezEJts4nDtGGmGnESLZVEEK1mHqEwZh2ZFm73fZpX2sSnUhnvz
X-Gm-Gg: ASbGncsd22zGfgzBNRE1HQa3v9322K9oDnOQvLJlXoAscsngBGaEdZXQ1dlzVzR8c28
	9DSgvc98IO0ziydyCkPWVdU1j1ZSyph1lH9Vbo+VHkD6Jkn3wsiKyxlwpArhGfeR8zM18Ny9tkP
	YHYzKzmRU1Y2cyv8lI2SJmBhHXedGiePWYYuc8INVzeCr5j9OFponJk36WMZpefKWMicckKFTFz
	cqdoCg4X8vKVBsIjI79yjuoReb5SlP63NOh+rcqQfvxRm1XbQ==
X-Google-Smtp-Source: AGHT+IGQz+Yf1bfWn4CUXESvGIDBdIH/vM1nqXwFa6yZjNupdhS3nTSv5ZreXa8jbLFaUbxtzqbMUA==
X-Received: by 2002:a05:6871:a9c2:b0:2a3:dca5:cae8 with SMTP id 586e51a60fabf-2a7fb30be44mr21864683fac.34.1735869655730;
        Thu, 02 Jan 2025 18:00:55 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d751e457sm9531696fac.25.2025.01.02.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 18:00:54 -0800 (PST)
Date: Thu, 2 Jan 2025 19:58:24 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] builtin/log: use `size_t` to track indices
Message-ID: <3b7ep2hex2vae56p2ba2kjeextjrjcsu5jrufr7hqewrnv3z45@ftrrcuvihxxs>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-6-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-6-07c59c2aa632@pks.im>

On 24/12/27 11:46AM, Patrick Steinhardt wrote:
> Similar as with the preceding commit, adapt "builtin/log.c" so that it
> tracks array indices via `size_t` instead of using signed integers. This
> fixes a couple of -Wsign-compare warnings and prepares the code for
> a similar refactoring of `repo_get_merge_bases_many()` in a subsequent
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/log.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
[snip]
>  	if (show_progress)
>  		progress = start_delayed_progress(_("Generating patches"), total);
> -	while (0 <= --nr) {
> +	for (i = 0; i < nr; i++) {
> +		size_t idx = nr - i - 1;
>  		int shown;
> -		display_progress(progress, total - nr);
> -		commit = list[nr];
> -		rev.nr = total - nr + (start_number - 1);
> +
> +		display_progress(progress, total - idx);
> +		commit = list[idx];
> +		rev.nr = total - idx + (start_number - 1);

Along with updating array indices variables to use `size_t`, the loop
structure here is also changed. Instead of iterating backwards from
`nr`, the loop iterator increases and each iteration computes the index
starting from the end. This is functionally the same behavior and it
looks like it was done to improve readability.

> +
>  		/* Make the second and subsequent mails replies to the first */
>  		if (cfg.thread) {
>  			/* Have we already had a message ID? */
> 
> -- 
> 2.48.0.rc0.184.g0fc57dec57.dirty
> 
> 
