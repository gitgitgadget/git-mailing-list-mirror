Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3213B298
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729113530; cv=none; b=pB22vLJswSn+cp9W8NbRRxNmez2QPTaGyw0+BKGeI2FaEXH/643W4EPLKQH3RmQYptnt/bgezSCUPhJDuZvuVY5k9tqq/9xbxk4KItkXXkfqAtSDFopvS0TT1t6rVyhP64O3pHAcPkUcTSa5d2MpBCaHF2vq99BK4xgaiHLbsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729113530; c=relaxed/simple;
	bh=sRuZMvFmrDui20CuGpV5hyuLwsnAxywSqDu60iox6Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bestbthHhHVXnntkdc5Xsb1heyvof0b11Ch7AS6EUzMlZxZAucpq8U08v4VcR4A3wWCZfCvrYK7rNX9pzZDk6HObshmB4etUP9uzOq9ZHt7L1R0CVxU2kgsz8FkJSYJTOmFhbbLpNDK8pAgDL39DLWXN+XGKOh1n64x8JSqPbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Dh+BuJlU; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Dh+BuJlU"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2f4c1f79bso3098887b3.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729113527; x=1729718327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUZoBABmV/1g416WRhnaV79I7OmfvOMmUY38rmnxdH4=;
        b=Dh+BuJlUh5iyA4bNIxUV3uWYjd3ik4omzQiYnB0Qff0YfqnNiclDtHUrN8BeNMQuFW
         ifwUSs2QSVwdpSBi5XDWdVjU9pTpN+GBeMx1CP9P+s18MqQR919mn+Nll5bFFCCQaHkz
         fF61b0Ks1wjFTV7ENGk0a1Kcs7dOUW++2q8u6pzgP74l2Cu9s7Ot7nfofB+kjDVjVPfd
         18px1oZ5sIs2J0EQDMixjdlGSoExlalBUaXWke9kb/MRn9o3dlophjILiQ6cGGNB4bBl
         oxMVfhDCedPjoDhe0gej11N/QoFYBevDKw3MufJm4+2DnGe55WtwgH88Sc1Y8q+7G4KA
         nMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729113527; x=1729718327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUZoBABmV/1g416WRhnaV79I7OmfvOMmUY38rmnxdH4=;
        b=EadmI53AE2tN7nvPU08B7gCJXDlzBUEHaQSBAvYECJuIEYuX2X8GMdteoNQFmvRDuv
         5Xlmf5qkjVAXLLpuBSIVrpmtOL4RYxAPb/tFYh+dNhcYZKd9otl38L76X6Oe1xcX2A6W
         8XW16U4NX3q+/PQ4ExXfDJb6+XvKxEgKPw9UgJD+jw4GVJtEHKdvUN6Qt51sj92AK+4g
         EA+H6v++Zr8YhHA032QOwdEa+rnh6C7U3DUJplHrulGCWo86GshInadXUG8BPV57d2MY
         HJsIVCFf2ZEjP4DEb6KkKlTj/wtJDj3IBt+rrGP3qc7HKql/zM65rQntTUNeAC5SV8ZD
         B3Jg==
X-Gm-Message-State: AOJu0YzL56B9t2z64++UXMrDro7GnnS4Lb7c0cK5UAq+Yxe5ExDeZ0Kx
	Uoulmzp6uaUbiFk15TRWnZUdk9qhPNTUf8hr31rfCmOF3ckTxoeXMKQgN4eQL1E=
X-Google-Smtp-Source: AGHT+IFSX3JsfG3doSEd9wujC73HUBC6YH7rAKoXjsdeG2RK7DygPbOHPAM9JW+CCaHb8jS8icMP1w==
X-Received: by 2002:a05:690c:1a:b0:6dd:d0fa:159f with SMTP id 00721157ae682-6e347b366d0mr173392837b3.34.1729113527511;
        Wed, 16 Oct 2024 14:18:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae8614sm8503347b3.29.2024.10.16.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:18:47 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:18:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	David Turner <dturner@twosigma.com>,
	Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
Message-ID: <ZxAttC1dQUllR76m@nand.local>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>

On Wed, Oct 16, 2024 at 09:06:34PM +0000, Piotr Szlazak via GitGitGadget wrote:
> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>
> ALLOW_ANY_SHA1 implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1.
> Yet ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1 flags can be enabled
> independently.
> If uploadpack.allowAnySHA1InWant is not enabled in config file,
> other flags should not be disabled together with ALLOW_ANY_SHA1.
> They should be kept enabled if they were separately enabled in
> config file with they respective options.
>
> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
> ---
>     upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1814%2Fpszlazak%2Fupload-pack-allow-flags-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1814/pszlazak/upload-pack-allow-flags-v1
> Pull-Request: https://github.com/git/git/pull/1814
>
>  upload-pack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 6d6e0f9f980..cf99b228719 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -53,6 +53,7 @@ enum allow_uor {
>  	/* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
>  	ALLOW_REACHABLE_SHA1 = 0x02,
>  	/* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
> +	/* As this flag implies other two flags, be careful when it must be disabled. */
>  	ALLOW_ANY_SHA1 = 0x07
>  };
>
> @@ -1368,7 +1369,7 @@ static int upload_pack_config(const char *var, const char *value,
>  		if (git_config_bool(var, value))
>  			data->allow_uor |= ALLOW_ANY_SHA1;
>  		else
> -			data->allow_uor &= ~ALLOW_ANY_SHA1;
> +			data->allow_uor &= ~(ALLOW_ANY_SHA1 -(ALLOW_TIP_SHA1|ALLOW_REACHABLE_SHA1));

Subtracting the result of a bitwise-OR feels a little odd to me.

Since ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1 are defined as 0x1 and
0x2, respectively, I think the end result is as you described it, but
the route to get there feels a little odd to me.

I think it would probably make more sense to write this as:

    data->allow_uor &= ~(ALLOW_ANY_SHA1 ^ (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));

Stepping back a moment, I suppose this is handling the case where a user
writes:

    [uploadpack]
        allowTipSHA1InWant = true
        allowReachableSHA1InWant = true
        allowAnySHA1InWant = false

and is surprised when the final "uploadPack.allowAnySHA1InWant" unsets
the previous two options.

I'm not sure that the current behavior is actually wrong. The final line
in the example above seems to indicate "do not allow any SHA-1 in the
'wants'", which would indeed imply that the other two options should be
set to false as well.

And that is what the current code is doing, which I think is correct.

I do see that our upload-pack section of "git-config(1)" is lacking in
this area, though, as it does not indicate that
uploadPack.allowAnySHA1InWant implies the other two options. It may be
worth saying something like:

    NOTE: this option implies both uploadPack.allowTipSHA1InWant and
    uploadPack.allowReachableSHA1InWant. Setting this option to "false"
    will do the same for the implied ones.

Thanks,
Taylor
