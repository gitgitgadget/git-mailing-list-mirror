Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427A38331F
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192857; cv=none; b=AtCxpS4iDAWvurqcbbqxQR6MUNK0uwiNpGWoKrrVm08nVIbHCHBjVJpgsTJREIMG9hlUuXW1SL2p/zlAEUXOFKe08w7VV2oaVo5thresHVtBiFf+MBljucH4cyOItM4AYdAJDo5nJxIlzetq6xEMw9KZcyTDY/5Iyq47KqrldJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192857; c=relaxed/simple;
	bh=D3acoOz4Xb1b8nWalIboJLirAZUiF3DEE57NdSf9GNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0E3JnwOSFdhKgp9JnhLyqBmVy6yfWSX56pvVxi+pkvyO22IjLMqfC1tFU1NdqvuPhav9rfwCntea3ndZkk0KG1xDNMGTTlLibHpXMzDX8mSS2brqDBWSFjKlcqi3YnZ6117yqJKGOPAd72sF1hXNLuNgv4nw97tKLbq3CzOJxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxQuaiXc; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxQuaiXc"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-48633190849so21705b6e.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192853; x=1781797653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lffsHXTMGeJEwCURsW/zP/xL/saqmoU6WxGU91NdZck=;
        b=YxQuaiXcvhoh1gFxlc/9+fiqqSuCgpQgJnfbApESFyjVzaedXG8myTb5zo2hioKpQg
         jos4G1UYyzPVZfEOruI13Zt2av2jGazCRFVNpVtZwttlNumSGkDuLTZHaqjSxMj56vsD
         jTNM7+tWhbYVXq2WS5Pv+KEdK0VrbfoSZjsX02PfArJgF4lDZ6n0L8xKwZrM7BCqK38J
         RmQcg7DJ85XK9Iu1RR5BPcmw8suEfpl/+TKsNLA2XU6f0XILlsHJltm6ZMu27JXwk+7W
         mfPH+xla4v0G5Ff1+m9bIeRoTVIUdwAljyPOI33qKPsAIxzWpbeQiIe5V2+4QXz7IYaa
         hTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192853; x=1781797653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lffsHXTMGeJEwCURsW/zP/xL/saqmoU6WxGU91NdZck=;
        b=p2zzZdhZcvjuYaNoUlNSPofr4KoQerjLayKAVxa6niw2DMHLWL2zXZFKCjDQ8UP0v/
         AJh1usjVglT53WgFKMaksZhOYlfAbOJhvqWa2RsgkYMWDCgaDMSlyIDw2DVylQrNVbUS
         5Azns8It463zl/WDwi/FAEnSg500EhQoflfPfzlBvkCx3ga6SmCeziEr4uwn+MyGL2WQ
         xYOZWEFF3mAdz9nVtZOkawFsMNy0xoi4zCUHt6cpdR0f9VewsiegMLi/N7Bb+KOR5xvV
         1yE12mviDII0EHQeHtqS3QW8EwJoNADEptQL+7QS1m92z4G01O3o/9OF3qarwrIoZsqL
         6GOQ==
X-Gm-Message-State: AOJu0YzAgWQOJSZCtLKeRHpI6mciDpkqLNYZZZZip35LyATkcN/PUSAI
	UHpXA79N31cuYQU61G5H5mtkq+S4n5g3iSWee6Gq9Qi7/En1obouQR2T99P+Cw==
X-Gm-Gg: Acq92OHzdEF2cweaqioHjZkadwWRIUzMm+UdijOjnEqWyYwdNAvRayzHbNB9PMornfn
	tD2KWtVIynWBClpoh5sBNvTIehPayIlrBBz4ADlW5NBtxInSqo3zg7BvxTgz00tdva1YHJw7nRz
	AFoYDSC+cvKGMjBijiMOTQ1ah0a0fOwIwPOEM+htklW53dmldm/yGvJZCHnE8KkCczFQV3kTQt9
	yiWJ1SrpjeTvPyxUb4O9a+ZIPhvV41pH6Y8Sw0r4fedV1uc0aQywMHHNVf6PNZrFkuPPyfYkuKj
	NGad4vKO6nMWhNpmKZWOh+N0Hi1f/WQq2Nb+OxeNwHb0KJkV0Wg0rMqU56OGEwFTqXCjlqlS+8z
	k+Y0avR0r2x0k1bM9udFZnl0/UGA8EfYSonrwdJh1Eq2rOh6qNcynISuWol82TOfZpH1I12gjhI
	k4wdziRdvEVTGLXpatoRt6AlT/rf4=
X-Received: by 2002:a05:6820:1907:b0:69e:ba66:4e11 with SMTP id 006d021491bc7-69ecb08102amr2270198eaf.56.1781192852904;
        Thu, 11 Jun 2026 08:47:32 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ecb111c49sm1189945eaf.0.2026.06.11.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:47:32 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:47:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] setup: drop global state
Message-ID: <airVOrTboNDDGBak@denethor>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
 <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>

On 26/06/11 08:44AM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series continues to refactor "setup.c", where the focus is to
> drop remaining global state that we have in "setup.c". The most
> important consequence of this is that we don't need to rely on
> `the_repository` in `is_bare_repository()` anymore.
> 
> This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
> with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
> object database in `apply_repository_format()`, 2026-06-04) merged into
> it.
> 
> Changes in v2:
>   - Improve documentation for some aspects of `check_repository_format_gently()`.
>   - Link to v1: https://patch.msgid.link/20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im
> 
> Thanks!
> 
> Patrick
> 
> ---
[snip]
> Range-diff versus v1:
> 
> 1:  0281a4bca9 = 1:  96b71f5223 builtin/init: stop modifying global `git_work_tree_cfg` variable
> 2:  6fdc8d77e8 = 2:  a51c0ff79d builtin/init: simplify logic to configure worktree
> 3:  ce31595ff5 ! 3:  e06393ddc5 setup: remove global `git_work_tree_cfg` variable
>     @@ Commit message
>          Refactor the code so that we instead use the worktree configuration as
>          discovered via the repository format. Drop the global variable.
>      
>     +    Note that in `check_repository_format_gently()` we now have to free the
>     +    candidate work tree variable. This change is required to retain previous
>     +    semantics: before we essentially had an implicit `else` branch where we
>     +    set `git_work_tree_cfg = NULL`, but we were able to elide that branch
>     +    because we already knew that it would be `NULL` anyway. Now that we use
>     +    the candidate work tree directly to populate the repository's work tree
>     +    though we have to clear it to retain those semantics.

I find the additional explaination here quite helpful. Thanks.

>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>      
>       ## setup.c ##
> 4:  6a69dc853c = 4:  628ed54c8c builtin/init: stop modifying `is_bare_repository_cfg`
> 5:  afa2d8bbda ! 5:  02ceaf4a20 environment: split up concerns of `is_bare_repository_cfg`
>     @@ setup.c: static int check_repository_format_gently(const char *gitdir,
>      +		 * dictate bareness; it is inherited from the main worktree.
>      +		 */
>      +		candidate->is_bare = -1;
>     ++
>     ++		/*
>     ++		 * Furthermore, "core.worktree" is supposed to be ignored when
>     ++		 * we have a commondir configured, unless it comes from the
>     ++		 * per-worktree configuration.
>     ++		 */
>       		FREE_AND_NULL(candidate->work_tree);

Ok, so when we have a commondir set we need to clear
`candidate->work_tree` since we need to ignore core.worktree
configuration in such cases. Makes sense.

The changes in this version of the series looks good to me.

-Justin
