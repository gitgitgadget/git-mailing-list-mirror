Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB54EC665
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415744; cv=none; b=nlHdkBAlTJnCdedVm9BOT7DV92rBNOvd3B4a79dPqbMBNXUYT/O4jsTWBWGF/sAmgd1aB3+etsJ8uNPWM5hdgcTotyw4vXwDrtGEMqcILq5VXe3MZamy0TajXqilGcXAp0YQp7dmQe/xPGpHtQ9XcICjOpz/dASnA3aevCgS6L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415744; c=relaxed/simple;
	bh=+6oIfH9nwjpMWnWvhsq2/TDeCgM1ZuSW2pmyF8iBxZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTKC6jOmupTNjOn++83KCIEnaEmwwvWD2Qkro5exl/2E5cf+kQx4ral2rVwwcOIXo7uvkhnSbZIS2sQrf2Kd7P4H7EgFPCR9Bb4QX9+QceD7kpb9nJBZ0IbYJ/v3LxEUJdsaC5JcIjCThOEZNp07uaUjWxcOZgUMvFsBHTpy31w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtwSVPjP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtwSVPjP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e011d370dso1753306f8f.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792415741; x=1793020541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WALcbzj0LtHlcM8beHI2DB5I+n6Ao8lPAx8y//YE4dM=;
        b=KtwSVPjP3pMeax9TtTFUAIFL2OqVT7+0ADWSskm3W4bzU/D7GArr4a5YmzC4QA2I6q
         Ocp+ot1jEOZoROIhPuIclJDGK1E5rjOJ46IbXiHfD93pt3ggaaU2B+lGaP0aNWpT4/5U
         J0Zn+u5Ye0u60lzqOnGBBgj0LsJo4VEPylTsOqvJA6hpCTxEBykggGhqx2znUjC0jejV
         m1lPvF5tZc2ZCmP9WUacHsCB5qRgrlgbEF+dZyQlgzAtQQZISbdVSj4feaCzoOd+sUSl
         lQsr8PCxZe4k7j0b5Rzr4EbdzDYyFkvJzz3E3HpS5Lg5cl1oyCIS2ihKKGsDOC0rTCZw
         eqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792415741; x=1793020541;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WALcbzj0LtHlcM8beHI2DB5I+n6Ao8lPAx8y//YE4dM=;
        b=AiVzIztzWm4I9e6YKi+4bTK7WXpRJXzLN04w8wSi/H8gbAOoAJ6nEly5icDg19TpFM
         oEu6gIQvuA7GOuRTfe4nL4DaBjTshFxF7sc5cNuiQj3Ik5s6eVMtAESu+hETWlo2R6Ah
         R8HjuylZch97KVRzS5DXh8tCSYlidIyWzHUGMhDeRkpiuxkEotw1pgzm8QwlbRD2KRgB
         +OnlfOZod95YDEMY0KyuFEc/MgFKsHTGiLw2ww0JuftBPZ7k6dKCT6DK6FwLdm46BaVi
         ZerM02ZWzP9ET4AXSzb+cB/l1x14kLkPfnoaP+HjITtdMlfKkCwPwjzwFbbAxaZeSQrL
         PKFA==
X-Forwarded-Encrypted: i=1; AKwUvBxKsP56Bb1FjVi8PM+ofILPofkdIy4QUeYQo5uisSS2VgJ0gJAF4kvplfs1P4dADGgcfd8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIugEAqyNNzhQrsjRc5dPOI6UdLIiDh1YTUXzKUD8TXKEhQdP8K
	buR844gcHyLqtkj8RSdtmX4kK4gir6TdP4xWBzTShVH5gk9+2JaJ9OH1
X-Gm-Gg: AYBFou1IWHyVCzz1zabQCkWjhaNdHfD4trhQ9lRtAIr0ZFehKLsjjw/fzJspspD/sfi
	mcCGP6HCyq+UBE+pYrmjJGHg99xpvnrWKDNNizRWLn25qAg779eP3+DA/CLyGVMafhymPbCX3Ky
	Mv7vwX/xJ8ckOgEs1/H7T7mhhwO6LRxdGLuIkAMXiI5+D6lh0IOwUkPFlL14Lqz6So0FmpMjxRi
	iePzHc45hXiK9iPIkOVAyK0ydQ8J0Vrh/TCKs038BgjOJRT3bq+pCuBQhnY8Fm5jHu4eqZ+NhJY
	RxCTiw6h81eyG3X60gH37zSnTilAAb61CuFUFgFFTH238BcEcj0g9q4A7Ho3eDTRvM9m990zM0U
	h/CbH/McyTxuEzxWfffwGDBWpafE4dtyDPbD7DETpAS5u2jR3QDZ3m80K/Ruhi6rvNiGl6XkT1z
	Q41bXWBcqyUbWTEFvCNCZy1DjJgBlt9lUGm4/VFdcrKnomvPuF8qWr/jldg3nsKnkssJ4jnyrbM
	SrjqatHkh9nJAAiBLBPLoxc6pdEVD7mUD71RL+bUP1JAQtQrkF9
X-Received: by 2002:a05:6000:4805:b0:48e:10a7:40f with SMTP id ffacd0b85a97d-48e10a70508mr9649687f8f.17.1792415740899;
        Mon, 19 Oct 2026 06:15:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5957sm22823084f8f.9.2026.10.19.06.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 06:15:40 -0700 (PDT)
Message-ID: <921b3a6e-5d3f-4c75-97c6-35da57c6d76f@gmail.com>
Date: Mon, 19 Oct 2026 14:15:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: git-rebase: Update incompatible options
To: Omri Sarig <omri.sarig13@gmail.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Julia Evans <julia@jvns.ca>,
 Li Chen <me@linux.beauty>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>
References: <20261018132541.131506-1-omri.sarig13@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261018132541.131506-1-omri.sarig13@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Omri

On 18/10/2026 14:25, Omri Sarig wrote:
> Several options in the rebase man page were described as incompatible,
> where this is no longer the case:

Our convention is to use the present tense when describing the current 
situation so we'd say

Several options in the rebase man page link to the "INCOMPATIBLE 
OPTIONS" section when the option is no-longer incompatible with any 
other option.
> 
> - Commit 1a66d8c6f658051a02b6d8f024e80e06fccdcd11 removed
>    `--allow-empty-message` for the incompatible option list, but did not
>    update the the documentation of the option itself.

It is very helpful to link to the commit that introduced the change like 
this, but we format commit references in commit messages with "git log 
--format=reference" so this would be

Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from 
incompatible opts, 2023-01-25) removed "--allow-empty-message" from the 
INCOMPATIBLE OPTIONS section, but did not remove the link to that 
section from the option description.


> - Commit a74b35081c51adbde3ef01870ba03e859db33be6 removed the
>    `--preserve-merges` option from rebase, which removes all
>    incompatbiilty references to `--ignore-date, --reset-author-date` and
>    `--signoff`.

The same applies here

> Update the description of these option, to no longer reference the
> INCOMPATIBLE OPTIONS section.

Excellent
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
> 
> I've also found out that the option `--onto` is now mentioned in the
> INCOMPATIBLE OPTIONS section, but is not referencing it from its own
> documentation. If this is not intentional, I'll happily send another patch/V2
> to address this issue as well.

"--onto" is incompatible with "--keep-base" and "--keep-base" links to 
INCOMPATIBLE OPTIONS so "--onto" should probably do so too.

The changes below all look correct, thanks for improving the documentation.

Phillip

>   Documentation/git-rebase.adoc | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 6536ebdc90..9fd3cf8ce2 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -334,8 +334,6 @@ See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   	and this option would override that behavior, allowing commits
>   	with empty messages to be rebased.  Now commits with an empty
>   	message do not cause rebasing to halt.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   -m::
>   --merge::
> @@ -489,15 +487,11 @@ applying (in terms of the author date).
>   	Instead of using the author date of the original commit, use
>   	the current time as the	author date of the rebased commit.  This
>   	option implies `--force-rebase`.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   --signoff::
>   	Add a `Signed-off-by` trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
>   	picked, edited or reworded will have the trailer added.
> -+
> -See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
>   
>   --trailer=<trailer>::
>   	Append the given trailer to every rebased commit message, processed

