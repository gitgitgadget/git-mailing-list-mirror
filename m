Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0992AF07
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849635; cv=none; b=QIvFHdWqQHNnYu532Lkf0ySrFnjutqOFBI0eBNtMSi3yJd5A30HnhsMcPPZpiCzgeMnTv5h2AB83ZBx4+5Ljtem3d0vPX5amWeAhkNf/Y8JJO46fGdrH+c1A5/eCd2Q9kjawAEDB0Evl7hGDqD8TdpZSbHTwv23yL6qoADzNRA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849635; c=relaxed/simple;
	bh=QvppkMrJR5opUKH+wAe1/CysgKv5AP4d5exTNOlkuIA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kB2m8Mum1n1GfVjgwx3Sm9qEOO0DW9X2fLFim0esgnA1R3jKdHhkcoPwTMcllS3slCiqaoQxp0/nvU8Tkjd+iK3MPglsrrfmzULh/SHk61iJ29qEwJXN8YgAv+xLiwhjHfZcNimbLcAXnB4tVmV0W3Ym6nGN8QRZSufUlnavk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNhCAMuX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNhCAMuX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45617887276so15614125e9.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752849632; x=1753454432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLvSok3Ju0CjLvjhXd68a7rdtrm3nw9KEFTJqZNm+OI=;
        b=kNhCAMuXnxjMqRK8lya07sLxR9XN9zuirFrreD7Tnpajm2xHjZP92FqYoYiqFQ2aKG
         YeRUvVWfGaJ3J3yG29O/yvaap59qL3fZ8mxgEv9QOUwkkqs0y04k8wOpnHpE2SzwnIE1
         G6HjM8S2dX98GuYLbwlPaD1iin2wVufOm4qirr2hwOKpz68av5NOySVGcyU+d7beFusP
         x/qjNb9nNPnQdwshYFAN3sdnR1ehXwdiCuCT5SpvW8ywCgFDofGar2u3p87agqNAtyFe
         d/50GFgYKfy5ieQu2ezgL32dSsVUjMmRD5ek5m9xa61caIyKLBN41YGKk/qHQEbD8NNt
         4ZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752849632; x=1753454432;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLvSok3Ju0CjLvjhXd68a7rdtrm3nw9KEFTJqZNm+OI=;
        b=qSEu54T5ogbleSbgOsD3p6lOqduh2i0hnAyiXuoHS9EWPPKqHmbsrbNvW1iNPsPnwP
         QoDevNshtEML+TDoH75+goCBM5Z9vQWY2AYGZ0rswE6f5O0chBdX8rmxPym7MqmcuWm9
         e0Bk2Kn619fQPSxphEOY4fO6IRimrhcEwTIrDEC8slIviXphGSXaVw0QvFvW7ZPB8hEq
         d2pFJorDJgy4TmHHkl82WJDSdEASgQ7ASlzyUHFFhinVXBQHOxFMGIKMalwV8Id6PbRJ
         ICZjmOkfyTLxoflM5083rYYHodOOx9iUSSL2BQ/ftacruUEEzYUaH69NxBVkp7JAXHKk
         hoqw==
X-Gm-Message-State: AOJu0YwHtYOY5jAr9tfCAShA2895B7nix3uVlT8k8K8AlS8Xb93iPsEV
	vk3QmzKsGd1IkeT0oSNTgqMsT7z+BCzFD4l8m62DOaE0qlGY6Ag5nTXD
X-Gm-Gg: ASbGnct6gxm8qebNzKafY75509GIHNU0NMsfPT0Zm181kwEAi6BoqNxSx4MgGzd+R4K
	gHZCGPkYGd4TUD049D5KqBQEdwrP+aJhnCQChLugC8MlmMsltFnS5qBgUNwSpmOkI4WLwbR+Smb
	Mb7qvbE7TsetFWVcdjbn5PRxWtSr/nssVCrErN9DJCkLB0AEpSA+6119WNhqve2rlmJNllpcNxg
	Tlv3VSZEa1eRcWP4N8LOqRiwhPBMiP0F++tKqLpzdIDGbEQ7B+wO96kFizcnSLGKs9PegJUJZrY
	xveut50Y4SO30aWqM3KeIK7sKvfxPNgRogKZXxIo+Nn4r0OCxokNKQLHgaGqpNO/8eoe/1vkSiw
	7JBUZB5Yp6Wcalhvww3bHDOH5Xfg2txb4Lryi3TaraUNINFbXtLiA/bray3/VT7NEF2uM4NS52J
	AR
X-Google-Smtp-Source: AGHT+IFVaWfRbnlW975kIgobrjcbI2b8PqJDMD784a6aOo0nyhgpF4dnbV9udyWMaldZdTTrQtAIWg==
X-Received: by 2002:a05:600c:3b29:b0:456:1b93:76b with SMTP id 5b1f17b1804b1-4562e34a578mr102707175e9.4.1752849631722;
        Fri, 18 Jul 2025 07:40:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca315basm2041770f8f.39.2025.07.18.07.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:40:31 -0700 (PDT)
Message-ID: <2ff3a900-daea-4264-8509-70464952f74f@gmail.com>
Date: Fri, 18 Jul 2025 15:40:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: remove unneeded struct field
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
References: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
 <xmqqv7nq67wr.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqv7nq67wr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2025 18:31, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> I stumbled across this use-after-free while working on the deprecation
>> of core.commentChar=auto.
> 
> And that other topic also adds more uses of "is kvi->path set?", so
> we'd need a bit of semantic conflict resolution, which was fun ;-)

Oh sorry I'd updated it locally and forgotten that you'd need to do the 
same.

> FYI, here is what I'd be using as merge-fix, a change that would be
> squashed in when the named branch is merged in.
> 
> I expect that this part would change a lot anyway, to make it fail
> when "auto" is used under WITH_BREAKING_CHANGES, so the conflict
> resolution for the current/previous round may not matter all that
> much.

This part of the code gets moved but doesn't really change. Your 
resolution looks good. I'm mostly there with the re-roll but it will be 
next week before it is ready to post to the.

Thanks

Phillip

> 
> --- >8 ---
> Subject: [PATCH] merge-fix/pw/3.0-commentchar-auto-deprecation
> 
> Conflicts with pw/config-kvi-remove-path that removes kvi->path
> field.  Checking if kvi->path is set should be done by inspecting
> kvi->origin_type and seeing if it is CONFIG_ORIGIN_FILE instead, and
> otherwise kvi->filename is usable when it is CONFIG_ORIGIN_FILE.
> ---
>   builtin/commit.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a513709a51..04440fbd3f 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -771,10 +771,10 @@ static int comment_char_config_cb(const char *key, const char *value,
>   		return 0;
>   
>   	cfg->last_key_id = key_id;
> -	if (!kvi->path) {
> +	if (kvi->origin_type != CONFIG_ORIGIN_FILE) {
>   		return 0;
> -	} else if (get_comment_key_flags(cfg, kvi->path, key_id)) {
> -		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_TWICE);
> +	} else if (get_comment_key_flags(cfg, kvi->filename, key_id)) {
> +		set_comment_key_flags(cfg, kvi->filename, key_id, KEY_SEEN_TWICE);
>   	} else {
>   		struct comment_char_cfg_item *item;
>   
> @@ -782,8 +782,8 @@ static int comment_char_config_cb(const char *key, const char *value,
>   		item = &cfg->item[cfg->nr - 1];
>   		item->key_id = key_id;
>   		item->scope = kvi->scope;
> -		item->path = xstrdup(kvi->path);
> -		set_comment_key_flags(cfg, kvi->path, key_id, KEY_SEEN_ONCE);
> +		item->path = xstrdup(kvi->filename);
> +		set_comment_key_flags(cfg, kvi->filename, key_id, KEY_SEEN_ONCE);
>   	}
>   	cfg->auto_set_in_file =	value && !strcmp(value, "auto");
>   


