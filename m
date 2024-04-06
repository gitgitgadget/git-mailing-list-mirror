Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048F374EA
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712412282; cv=none; b=if0W2NjnBBiPHnPaV3ibQ/DI53Up2Pf1qjEhGg5mMxun4TvK64gRsAgh9nj4WJVWpo7x0EEjvQIzGp+FWuYe+9VXnDpBuT3r6IciHJlE6yReXB4wng/Rl0lLOJvzyxeLDKw/xkg4+VRGrvG6DvrMge58rJr+aMBg5MUU0shQ4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712412282; c=relaxed/simple;
	bh=DCh1yl8755Bk2NLtPMrP+AaQhx4xokmEGPUoadAU2+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PF0Xr9sjrVlMUiSWux0C9eCvVy6BKIC0ixAsMTsJstgrfYRG3sfYJ3OlFi0biia/c2xFCdP1LtjKudGaeblwUmQ6We0l8iHt3QGPxzag/xz2OLirgozpsIkcn5OWAZWi0rsn1PkGIrwTRsyjrSWyNG5QdRdB+QnZ6LAJGR9hzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uglah68Q; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uglah68Q"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4163de6d2afso2199505e9.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712412279; x=1713017079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gp/AtswJpFQYJmq2bKc21Z5YUfiLLsMgSuxv0seE+Os=;
        b=Uglah68QMGxX8z39bn5nXeuCfMtmS1wRK22xCNXXyzOrHK3Q9f6XBw29uFLGAHzcq3
         JHINT4Hvz/oON67o6nrXNBtGhRg3LPZ+10h+wrUDqd9mvvZGgx5AlGu8Hf2fsLYGeyjp
         O5iBs0dugk01exyCvxw6JbU4cm3OL0IZ3/Ly2zeWE0NEWEvvcS3aHk0S6hnXfUSvfZH/
         VHhpXsj1txM6GrBGmcbexFlPInsOhtlJPw3f8/1eQtF37Lf+BleuB6RstRYXCFDHWlam
         1ojLob1BxbMD/HdHayO/A3TiC+CQjJqP6KiUnYZD712LhwvYvcO1k9bnJ0LLHdXlkNfz
         wOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712412279; x=1713017079;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gp/AtswJpFQYJmq2bKc21Z5YUfiLLsMgSuxv0seE+Os=;
        b=WsjHmRTr8FAcy9U97B9qoaTwxjfAInwgUd1O7tvGrDBoL9Tqo2jQvJ/BMCFQtZn6uE
         yePpsABItmuW9OFUhP9Q1rldm1Jfy1Jxn15un503jTCmLJYQDU3jGRM997z0lEtPn6kQ
         0MOkWiCjmUmU4LqhppO9+arVZFNjnpwtYGE9Be6ml/nWwprISlocjlyF8gILPpj+Mr57
         XiOTzoRvS2MnJ64ghmM6Tztyvh9QwE7kRVTEr2Qn9EOX+/AgoLxfJuH2YubaL5EDC3uv
         N9yE+qdvR+ZSpA+j5KCfTrhil8eZ+WsKfGSz9iQIIqRRQVgXOE3++4EZfz0Tt3ctAxqm
         LaXA==
X-Forwarded-Encrypted: i=1; AJvYcCVnD+P0IHyrvSTnIF3PNS8B0eR9OTuWUNl1v3Q1laBS1/Hz55WpguYSeRhafVjhpxncTyRj1G3FFGs/36YGlJkgoHEq
X-Gm-Message-State: AOJu0Yz8Fr7ZKbJbicHZMfzs4ZNhcvzuJaxmLlwFB2VWqFRR+RGVwaqY
	RagKJws1Hh/o9W+qWJNYrolJcDGILM8/Rj58fcwD9h+r6PrO1FUJjy5rAdmN
X-Google-Smtp-Source: AGHT+IGA77dME+tt9UeIB3P9+FDlzUilPRmGq28j+6De0GPVMxwUaT9hH0WLLD3gXfp9oI/ua2jJiQ==
X-Received: by 2002:a05:600c:358f:b0:415:4853:f722 with SMTP id p15-20020a05600c358f00b004154853f722mr3309909wmq.10.1712412278746;
        Sat, 06 Apr 2024 07:04:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b00415f496b9b7sm7543734wmo.39.2024.04.06.07.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 07:04:38 -0700 (PDT)
Message-ID: <c93817ba-5945-4ec0-9775-5621481b972c@gmail.com>
Date: Sat, 6 Apr 2024 15:04:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] feat(log): add option to search for header or body to
 `git log`
To: Max Coplan via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Max Coplan <mchcopl@gmail.com>
References: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Max

On 05/04/2024 22:48, Max Coplan via GitGitGadget wrote:
> From: =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
>   =?UTF-8?q?an?= <mchcopl@gmail.com>
> 
> Note to reviewer: I hate the name `--header-or`!  Please help me come up
> with a better name.
> 
> Summary:
> This change adds a new option to `git log` that allows users to search
> for commits that match either the author or the commit message. This is
> useful for finding commits that were either authored or co-authored by a
> specific person.

I think that having a way to find all the commits that are authored by, 
or have a specific trailer naming someone is a good idea. I'm not sure 
about combining "--author" with "--grep" to do it though. Perhaps we 
could design a new option (tentatively called "--indent") that allows 
the user to specify a name and which trailers and commit headers (author 
and/or committer) to match.

A couple of house keeping notes. We do not use the "feat(...)" style of 
commit messages in this project. The subject line should just start with 
"log: " the rest of the subject looks fine. I think everything under the 
"Summary:" line above does a good job of explaining why the change is 
useful which is great. We tend to avoid emoji's in peoples names as well.

 > [...]
> +test_expect_success 'log --grep --author --header-or uses union' '
> +	# grep matches only third and fourth
> +	# author matches only initial and third

I'm a bit confused by this comment as we seem to only expect "third" and 
"fourth" below - what happened to "initial"?

> +	git log --author="A U Thor" --grep=r --header-or --format=%s >actual &&
> +	{
> +	    echo fourth && echo third
> +	} >expect &&

We have a test helper to help with this

     test_write_lines fourth third >expect

Best Wishes

Phillip
