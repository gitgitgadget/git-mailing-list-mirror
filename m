Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59B3081A2
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176479; cv=none; b=Ss3ckkk0hbjfYdBa/CgO5QsbmLKUUmRlMsHH5fjPvqHs+z9TVdTAmOnyAkOkoJz3vnMd7cIKW6bsLxK4hIxnOHGdHXOWEUcpe2mW7d4ac59lDxu5mCpdGllIiwSjOKyB8AGH5SlVFglQ2upTe2qqcHvYm6jKxlPvyD+yr4zhNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176479; c=relaxed/simple;
	bh=8WC9QjzyyPhocndfT8G/yRtD8w1lBbZAApoXF8cdj8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7cc0JiUddjlM+Io+ayC6Xh7pD0MNRdk4jvSGmWusju43aNk5dddGJ6s8yFMZtyG1L8Z7SsK8qaHjXI2rga3DGXcHJu0PUL8sIwPbDXqM4PtsBmY0+VSFSsv6cLz7vn8EtXI7A6Py6lyY5UTWXEqkh22Uo+nM304XZvh78jNPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUcqL5LJ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUcqL5LJ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso138872066b.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790176476; x=1790781276; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qpv/5hQ8b6roLer6yWyLqQdJdf+iuaFFhX7oGAGbPb4=;
        b=cUcqL5LJdV15lJHfsSA7iQLiQolrM8BjtEJnA/S+BA40jF8iHlj72Ci7XUgPkMCKlJ
         3MZOPM6CSnLIaGM+Vfwaz9t/dX3PtaKGgMJ3Bjcg7LWWhiZLgply3VMT75rV7RZr7yNm
         OImOW9JdtFcx/vR2Kp9NNv5IHFtRCsMd+mtgeyd7fYjjQM03g9fF0rIRcTA+v0n/gOAk
         gmNIcLk2249jcADghT/SxvhBqSDLiNjKaiZiHMrMGx0ulSX5lA63MWXlQ8zCctWRIwl3
         Yxqj31xJn30WwxRX8E8h1ztg4oqPWHXxX6wdLwXIx/Byzclg1R8dbZ5o71vq9iUfk97b
         Zfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176476; x=1790781276;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qpv/5hQ8b6roLer6yWyLqQdJdf+iuaFFhX7oGAGbPb4=;
        b=M4wbzkZM21bvtTtdPNhDHF2Wc0etv5i6OGZ6dpapa3Q852tC9EuwarqunJurAflWp4
         ESFkwUZaHKXLAzAll03quDa7GhNoka2/PgZ6lR1qoQjHfL0s8r0U0ieZIDsyiv6vN2X5
         +Z2oa0DhUrryCV9HR/umigyuw6W9gcNZLtrzsnJi6G535JZNkKc7+FrEv/3G3TG+RKES
         crMQNsMmBbfOnPPQCxAnUn56ZRcYCtVTYDFRWLtK9znSVYm8RdTA5uw9EuYAvpsalHYZ
         3M/snZ240eY1m5AQ4a3ZIGZBEXO2T8Ay9cLEw32oI41FIppekOGLDLJdwU6Fk/Eot+rU
         pHhw==
X-Forwarded-Encrypted: i=1; AKwUvBx2fYeVswpH3Xhvp4l7k8aVAWNTMRTBnn1OZsxW7sIiGvvURBExtKx2tcDYiEOOCSO5FFM=@vger.kernel.org
X-Gm-Message-State: AFuF++lpnw2bguo1m3pmeJeee9t2h+yIvBagsgZ7K7ciodTRiNoi0eBG
	Hnm323K5nw8G74+8nhrUPjtG1QrGD5tqnVhEF/fXajJL9ab6v8lRjJGldRv7Tz8N
X-Gm-Gg: AYBFou0VXaNI9VyvNT5i0gn7eKxvECugu9oOpdd2Ipf7EgbEI0ja4lNQMrlgU+VcQ81
	AAslMa7zs7Ahs8bHIBl3aMu3kb5nxKVLi5HAd7FA4A7n2rWSwBvXwatQxv+AOHBudtbeyStTjaW
	1r8SfrmzuocSJAc5ZRe0PZG9OYJZIOeP5E569NGX7IRA+J6dOXSdvLDcxL6ad8ov8kSidBnCnQa
	gHsZZJOe3D5IQRQXkqOI7Q4cCYT6enJkJork+iRf0DB25xHT5JkcwcKRr3cd7d2o6pIKL+F9ZFR
	EvpV9DWWFbKvACLDyJBaOblYpCMLGjuJnpcSU8ZcgYrVIvJh8eSpW9tyZUqmKdf25agUUa86P8u
	9g34hw16PgEImgOYM/8FHGd1STkgwxPW9bkcnL8ZhKx500MWjRbDzsUTu6s0efy/IVZMkc1SIW+
	fa9ueq64f5h/kwJ9fNa+DdH1jfAf3lIC4svSdcfpZTdzB+k2o47blWYieWSSr9u3Uy/5pY1oiqM
	5/IB/a/i9bsV35bkfxUmqoXnLtnd1EtZq8Kg736lE+zlKPTWEy30A==
X-Received: by 2002:a17:906:9fd2:b0:c26:1649:47a5 with SMTP id a640c23a62f3a-c2aae16ffbbmr244068766b.27.1790176476257;
        Wed, 23 Sep 2026 08:14:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab3897a6fsm1917019a12.17.2026.09.23.08.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:14:35 -0700 (PDT)
Message-ID: <c5710264-d901-4b23-81f9-fc69f8268826@gmail.com>
Date: Wed, 23 Sep 2026 16:14:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fetch: add config to avoid fetching every branch in
 shallow repo
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <7f084e4d-f738-4bd4-9b4d-cad995f04be8@gmail.com>
 <CAHwyqnWbbCK40qAU1vhCFmN86J-dCY3tv_N_nBYgK2Bxf3o1fg@mail.gmail.com>
 <CAHwyqnUVkVUjKCiN7YT3tkvHEVCQwb3jDGM0OTojPxptFKrsLQ@mail.gmail.com>
 <15c85d2d-4fb0-427d-b52e-8e4dd958dcb9@gmail.com>
 <CAHwyqnUjDJNjER2AxFXOR6G3sOJKpsXj-agzmm7410_QAFu8PQ@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnUjDJNjER2AxFXOR6G3sOJKpsXj-agzmm7410_QAFu8PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

On 22/09/2026 16:37, Harald Nordgren wrote:
> On Tue, Sep 22, 2026 at 4:53 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 22/09/2026 14:00, Harald Nordgren wrote:
>>>>> If it is the former then we should think
>>>>> how we can improve the behavior of "git remote add" in a sparse
>>>>> repository to prevent it adding a wildcard fetch refspec and instead
>>>>> setup the new remote to fetch only the branch(es) we're interested in.
>>>>
>>>> I didn't even consider that, that sounds like an interesting idea!
>>>
>>> Would you suggest we do that instead of this, or in addition to this
>>> fix?
>>
>> I'd say instead - if we can fix "git remote add" then the problem
>> shouldn't arise in the first place which is better than having an opt-in
>> config option that most users are probably unaware of.
> 
> That makes a lot of sense.
> 
> However, I think there is info missing on the local side that we can't
> get without making a network call to the newly added remote, like its
> branches (and default branch). How do we handle that?

There is a "--track" option for "git remote add" to set up the branches 
that are fetched. Without "--fetch" we could refuse to add a new remote 
in a shallow repository unless the user tells us which branches to 
track. That is a bit of a pain, but I think it is better than adding a 
wildcard refspec that makes "git fetch" unusably slow. We could also 
perhaps look at the refspecs for the existing remotes and, if they are 
all fetching the same branch(es?) copy those.

With "--fetch" we could lookup the default branch on the remote and 
fetch that if "--track" isn't given.

Thanks

Phillip
