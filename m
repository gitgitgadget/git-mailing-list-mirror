Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A0487B4
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945019; cv=none; b=iej0HH3MhXwaKmo7uBTgGLnw/uu65ohVUtM+2heo3Fcl9QApoNQeh5PjXMTdRYF/Nfx1MEem3yH/GDzU4GYou0RSBZkkA/eRGQmO0ChZzbLnXMm7sJU5Po/bf2WcBGRtjEPTY84Yq1eVZxQ1DJeWs5pr8zvCSkaUZchQtqB/wj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945019; c=relaxed/simple;
	bh=yyrFGsmAkrT5iK7YyWnFH0z6Tyz2eI31xJn9MRlfT94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXeHGH5iep4kPa77zfWwF3SuiLXFd3D/NYTnLQF1pblIhhqrKanmHYx9qwppHa239d4RtyR2nzbo4gvhXhrtFOjQtqrvkNvUBjSeSajI/69OHBC9+waLk7mNBvzwSzTLt44/J3vJ2E9Lh9a2kj327FceGIS00qoxymFdYCtIMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwRi+ZAn; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwRi+ZAn"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bd533be0so3362503e87.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708945013; x=1709549813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QFgY9jHxH7uggvs7vON6mFNyK5JZRgUPx/7vkr9/HoY=;
        b=FwRi+ZAn/X1tjMBbZMEa0+VO30Eu3Qim9+CyXdVQyz8oyZr4drz8VlTxTeH97V7qZR
         NKFcBHbnKjuTHIfSPu8n7KIYoy4Fas+D4fg5Gs8b4D+PmuhwEo8p9BwaYXAh9f0dX/9n
         A4tOBspfaWHoswFAXkmUeup7AP4C663dcQxfPtHQPQxcyiuwzQyZVQAYiJ4zqx2kixpv
         dt1pnc/0GxRF+7hRjQmwxkKjsVzT1rhPRm53GEQUS5TM2nucFIMUGvSiXGSSzp34vwer
         ir9youXpqVXPbcMJfWQqDLJkta95wh6k8nxjwQpdKFKud9AI0GXFwh+IJ9dxMWi5Vzmk
         0DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708945013; x=1709549813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFgY9jHxH7uggvs7vON6mFNyK5JZRgUPx/7vkr9/HoY=;
        b=pxsLMmBM8xRWY95AMzwC9LQewazlFiqznAML4cd5YV4t4wIegUMKYTTIoLLj4hke+S
         NQRs3relj/wF1Y5E4Lj1n169TrEm7yyUjpz08XIgmaLisepxaWGzvqJnbXuWWITurAgr
         zXMXtkyklk46yoaXiQ4BQe8bJq10ijeW6zneFEQJErdsotHu/xzahSKrATBRl4dCu8T3
         chmfY+lYSy0X2PO3wrhIiQwsSyZJ9EGIDp0krYDs2cuvqDrTDU6tlV6IxoGWKEgZr3dx
         f0Ig4p5vfhQUigiiLRUIp1Pr0su3CL7zbpa/MoIiIBYqyaw71hSI719SL32DDvj52POC
         2HFQ==
X-Gm-Message-State: AOJu0Yz8Lrp+cOIE4tMmgWBt8FyL2kVehjfH2nhwd5Nlgxk57p9t65hX
	PsLverauF51f/XAjAtQCDsZn775LPDLNUAy1ilcq+B60s4m6hDVq
X-Google-Smtp-Source: AGHT+IG95PR27x23sy5H/I+Rqt3c1K6aKjm4uB4lATAiRP8qklT5ZMbAxHkhLIYImZMYnMVdmuiAPQ==
X-Received: by 2002:ac2:4909:0:b0:512:ce6c:1906 with SMTP id n9-20020ac24909000000b00512ce6c1906mr3858477lfi.50.1708945013108;
        Mon, 26 Feb 2024 02:56:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id f6-20020a05600c154600b00412a482cd90sm3292538wmg.25.2024.02.26.02.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 02:56:52 -0800 (PST)
Message-ID: <b4781808-f722-4be5-906f-4c3409c3295c@gmail.com>
Date: Mon, 26 Feb 2024 10:56:51 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Interactive rebase: using "pick" for merge commits
To: Stefan Haller <lists@haller-berlin.de>, phillip.wood@dunelm.org.uk,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
 <ZcnFl8kypKRYeLo3@tanuki> <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
 <2739325d-93b1-445c-aac9-3e0ec54a27e4@haller-berlin.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <2739325d-93b1-445c-aac9-3e0ec54a27e4@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stefan

On 23/02/2024 20:59, Stefan Haller wrote:
> On 12.02.24 15:38, Phillip Wood wrote:
>> Hi Patrick and Stefan
 >>
>> It would certainly be possible to extend the sequencer to do that but
>> I'm not familiar with why people use "git cherry-pick -m" [1] so I'm
>> wondering what this would be used for. It would involve a bit of extra
>> complexity so I think we'd want a compelling reason as to why
>> cherry-picking merges without maintaining the topology is useful
>> especially as one can currently do that via "exec git cherry-pick -m ..."
> 
> Ok, I suppose the answer will probably not count as a compelling reason.
> My reason for wanting this is that lazygit currently implements
> cherry-picking in terms of an interactive rebase, rather then calling
> git-cherry-pick. And the reason why it does this is that when you
> cherry-pick multiple commits, and one of them conflicts, then you get
> lazygit's nice visualization of the rebase todo list to show you where
> in the sequence you are, what the conflicting commit is, how many are
> left etc. It just happens to support this well for
> .git/rebase-merge/git-rebase-todo, but not for .git/sequencer/todo.

Thanks for the context. I can see how that is convenient for lazygit 
(and makes we think that perhaps we should teach "git status" to show 
pending cherry-picks) but I'm afraid I don't think that is a good reason 
for adding the ability to pick merges to git rebase.

> It probably makes more sense to teach lazygit to visualize the
> .git/sequencer/todo file, and then use git cherry-pick.

If lazygit is generating the todo list for the cherry-pick could it 
check if the commit is a merge and insert "exec cherry-pick -m ..." for 
those commits? The UI could detect that and display something more user 
friendly for those lines in the todo list. It is still more work for 
lazygit but perhaps less than supporting cherry-picks directly.

Best Wishes

Phillip

