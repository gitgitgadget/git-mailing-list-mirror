Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF9399004
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276676; cv=none; b=RruYbAlvLwqwkwWsM3uBtCdZmibyJcyz571uOPrBEkICJJNBAV5hT+Wmj+mNaKBBX4tD1ksytUiAEDVFPGUAhxrC7Z+cL7Xwm79eDyYlVPEVNCla7FX+1AciaJSMv3UCXyF0EptgcX6VQ1WaaKJFTzeJsiGLu5SSRTJlTCzfDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276676; c=relaxed/simple;
	bh=WkuOk8WBIJN4XT/neba6pDAIqLITsflDwczQrHgMufs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KEyquE4p4m4J5eTziBuC93wgEWaby2feakJu+Bi8J+24oqt9cisZHt1U92EyTjFwf7gvXNa+I9VFGbLiqpGn4cKP1wwaQPV7M2RQ1u3HJyERzy2hBOLpSYgxdiEBsFJyzDM6JKR/Vg2sZGxdMy6qhz+8nOgieZi9OJg+lY5D0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfAmobxI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfAmobxI"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486ff201041so23281365e9.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774276674; x=1774881474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsGtyEVEb7/MDjDGH8u6op7js0Kg416E+TJ2HmRhaWk=;
        b=EfAmobxI417rE1chI3KNsTbkoR8SRiipmS+R/32qSqb/iYMBdMvLv/A6JP2Y608Emz
         jy3qdOSeTdWeCXa6vLqU0O6MWOePWVHVbHviMNOyArIeGPjmti7WDgYstH+3iE3QAbUl
         /iSDSXbUgULyn0LJRvCD22UQK+cehwLLH9jzuMcKmu8/0hezY22y0mUPalcFMVX3/1l6
         XJRH0ArWgXy8SWEmlNPQk+joo9GWN3pkjiteqPbJP7ujcfmVAeKKoRg3A475aapn2l4M
         s+XJCTnEfaS6FkGpOvFi+A6nh1UTICdV55oQ8WFxmyrRFZFl63vUlJeGENg2/Hnmg3U0
         AFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774276674; x=1774881474;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsGtyEVEb7/MDjDGH8u6op7js0Kg416E+TJ2HmRhaWk=;
        b=FyHxT8GMsf6ZdoErx8pI6UpzqQK8wJY+BP1l87oogzW0dKdbT4WoYaDrIP7v2k2uY0
         4xZAZUkvAsOyVHY1Ic46q5AxSL6FVgWM90wbAyK4NwkUshwFvqArJFRGXUawugGw/Kd+
         2lZWHlkYMJqMc2j2CaqULBcPzQQuSqTWvadsNMLfYNyyYFHZZdbDqGCu19z2NaqsbXaJ
         xpCY1JxkYVmc93fN1Newu+UjBk8aLBTNnk9zA6Ot+sX7Tst3uW96aph26yT1mM2htCt/
         ZU9XS8mn8uH8WKoH6eyLWJqHEy21voR2ViyWQiSC9AUVoPK1HYssFyLzocRRrhOWRD27
         N+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFEvYceZt2uqOfHQmRRkYFYzeuKJy1GN5y/LrqxRTHVxKhw5qHPXnZYXYLow/fhjWksjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILlZMuZ6ITKA8VIqhER5dnrba8vAMaBJcI6L0ahXp6tnR6moN
	yGL2YRFrScLwIFgG3Hsg2o2oeYBjUsv/cV/fef/dxFK1GYmX7LO6LAwD
X-Gm-Gg: ATEYQzzSNfkJe8UqhTxIh8sjOfyIIS44C2sC+NjtN1ym0EQl+6rE0RCh1w2Om+90SnP
	n1gI2qPCt1MXO1FcCuFvkP7fIHbbRxl5RF5ZFt+/2KtdP3kB7SevbFfrnvXwQ4K0VoXhLv67mKg
	o6yS0v35BnENWHpf+9WjZQMpC2NeWo6fJ+BU6KgizXn908WgA1v4Uy5hqNDuJpubvqMEfXG42lW
	rBHHAQI2rXmGsVanvuNj4r1qSqwZtrvKi2hRTtlDBNtJia5i5UAk1Oq4hRBaJk9ktRkLxM7ckfE
	pPk5sGDY1bdtKJ/An5RUURzyfzouBDL0p3AN+Bf0VHuxwoCS6f6zCfT04OC+bsthWJGWtQiEpMy
	LU4HIfinBoMpb5JsHip42fGFMzuijfDiIWbHVdU5FFPca4EBI0ukHO/Cg7kTy/H2csAChEaWUfr
	6yQ1/Hg3k6GEOOpuvdptcrh0rNBb4N7wVAA0h56Or9b9yEzgYKSsq6makIx3bzzHukGNZw4oFZi
	TcJOw==
X-Received: by 2002:a05:600c:4705:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-486fee04a53mr170898255e9.21.1774276673557;
        Mon, 23 Mar 2026 07:37:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fd9845a2sm527743385e9.6.2026.03.23.07.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 07:37:53 -0700 (PDT)
Message-ID: <532616a4-d410-4a38-8038-1fd22e39217f@gmail.com>
Date: Mon, 23 Mar 2026 14:37:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from
 is_current_worktree()
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, ps@pks.im
References: <9c915043-02da-4823-b4e7-d2a340c0373d@gmail.com>
 <20260323094341.880375-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
In-Reply-To: <20260323094341.880375-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/03/2026 09:41, Shreyansh Paliwal wrote:
> 
> This may be slightly out of scope for this series. My understanding so far
> has been that originally wt == NULL is used to represent the 'current worktree',
> which eventually meant following the process-wide state (the_repository).
> With the ongoing multi-repository work, the meaning is being changed to be
> interpreted as 'the worktree associated with the repository that we are working in'.
> However, in path.c there are some callers of repo_git_pathv() passing wt as 'NULL',
> I know that there is not involvement of the_repository state but it would be create
> less confusion if the semantics of worktrees are same everywhere. So if we replace
> those NULL callers with the current worktree and update the checks of (!wt) to
> (is_current_worktree(wt)), some tests are failing mostly related to refs of linked
> worktrees, and I think the error is originating from this,
> 
>          if (!wt)
>                  adjust_git_path(repo, buf, gitdir_len);
> 
> So I am a bit confused to whether wt being NULL here could mean something else
> behaviour wise ?

That line comes from 543107333b3 (path: worktree_git_path() should not 
use file relocation, 2017-06-22) which explains why we don't adjust the 
patch when wt is non-NULL. worktree_git_path() is called from 
builtin/fsck.c in a loop over all worktrees so changing 'if (!wt)' 'if 
(!wt->is_current)' will change the behavior for the current worktree. 
While it might be nice to clean this up in the future, it is an internal 
helper function so I'm less worried it than if it were a public function.

Thanks

Phillip
