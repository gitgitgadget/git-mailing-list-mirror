Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7673D994
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179638; cv=none; b=RYJNpKqMJOmhe/ZVYE5js/7M+hBRNRTjheTjreQrlfaBmmNHLm+6NAzeALKIItxsu+jxSJ2DWjNTECaXfdstLDWu4pKcxQWvePcVDycKC7nDK/DU/6w1mSQ8fgv4ijSF8pjT9VncXSTSebEuCdyVKsWTQuvbpkyzx4xyXzZC3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179638; c=relaxed/simple;
	bh=fblhkH26mlNL6HZuw66NIYGuVQOk+fBez82v6VUQ6Ts=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AbLB1E9CQNJQTXyhmCNvB/SGpieObU/kHCfb3LKoMYYz2/dtZetRJhECMm5jvEsmYbcf/7hAubetTr1uwlihbcscN7xF5P86AvOQk+Kj/0yJQpVh1etUbjGII56j2Eu5imWH8ePSel8Y0rwZHQEtSrJpOzcohxXJWqI3IWsbTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ3HW2zK; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ3HW2zK"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so17242505e9.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769179635; x=1769784435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nDE6AbjD57WxyBk+EuM+bSN7ao07zEAXc4Jpz3YOapY=;
        b=DZ3HW2zKrCvIfv8Mr/EC4dnTGeN77e1ngs30U5H1SOVLpQoLTO9Kd1vv8mS4z6uI6S
         DrT9KZN7ofcwdQ98UYW50GGoJqVq9ueieVkyuuPdwz566yzAL5Ti2ItesKX152bvotgu
         q9Nmw4kiwvdmiFjNEIz0rTmCRSH+uaNl4+l1zMiREpbhe515PyFn1AW8f7QCLOsoveKq
         uwlWy5WWaxVMrv0GOEMAk6Bf8LJcTwkM+Z4GFU4rvvOmtqKOekD5oMnTrvruviWfF6nU
         xSNdMNPcgsnKXsHHoARq+P1bKTq40152KhPnCzW+Z/U++Y626dmWvFplC6MZ56wGnEFL
         DUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179635; x=1769784435;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDE6AbjD57WxyBk+EuM+bSN7ao07zEAXc4Jpz3YOapY=;
        b=oFdSrulGWrbV1odyAWp+A3Tg/xviOLKMfyX9vxSlx37zIRrMsbNiG9d2pyLxVMnjx2
         nnqIcpYThCDhxN4ieAwevhjwZVyzBdqlQpvV7DgiYujl6VfJSypJlQ0POL6F4b7Zw5SR
         jZNrM1UfRn4fcp5cvXa3/z1p9vWCBzx1FNiUzj/FC58Iaq/m28qWoFvu1J+WvsxHrSw2
         4cudlH5Lw4XZQ+3WCHiS8Se7PVykg9htwht5Pg/Lz+Olu1/MVPli6IUuJ2AGJOiDWocW
         N1r4O0a6sZ3N6oizHN0kMjQ/NeHmOXhyT00dD3UzWcty5kHiSaQGOsqExsHYEFppzV4A
         O/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnhOZV+zx8q7NqVKBluhuvK3nLlKnfDqHqk0bEdu2lMgL2oj/loAFEsGQYb/boW420nes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOHmMNhIESnJ/AOIE8Jpf0BA3QgcL3mEYoWK+hlDJaaUDH62K
	rTVhhkCR03yq/tZoAPZ6a0vSl5ksbwybuM7GCWHWwEQlcwWb4a/aRAhI6sXCkNky
X-Gm-Gg: AZuq6aLHug6zLYvSyuVYiaPY4Tp8OCs7PyrqfqBxsPLS+2Zj3gCo40lPLs7oYy7Kpfa
	lxIRw3gp0ZxObyxgIjiHMmIM0hxYx1/nWwO6wz7RPy7gpTU35VZlDD80hrF/JydOYOEAnCh/wqy
	O/C4SsStiKACD0DspawY5dq1AU2ZOvYE6xutvbbkNUwcldU6GOxC9Xf+IJmqFVoFAvSP1QQ6ek3
	kAgr2+gnlXAGM3CeBb4OmPVOk76QaxL919/ZhB4ETggUwt8QdM+mK1nP4NjGAygUCWIB2Ls+jJ1
	gOiiJCOBF/bzxeImSKV46VOgkLpH87BfsKXLPgaJywYLHvtaFLb0jzo1wooV77pYSeAMq1n4iPj
	C7fnub3fgbo8wxylyWFKJGetgMtZ0Hp4dD4F0Og05Mse3chRcV4aWu0H3ECSmPWZsRVa8oEWtc6
	P1l35fsKwXNoZpz5z6exfLFvXhdG3VXFQEd7YdFkoN3m7T6xyvRHm3ZlqEV1BoPLoreg==
X-Received: by 2002:a05:600d:8444:10b0:47e:e91d:73c0 with SMTP id 5b1f17b1804b1-4804ca6b2a9mr38345265e9.19.1769179634897;
        Fri, 23 Jan 2026 06:47:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm6997602f8f.38.2026.01.23.06.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:47:14 -0800 (PST)
Message-ID: <a29ce07a-9585-475e-bb3d-4742f2ec400a@gmail.com>
Date: Fri, 23 Jan 2026 14:47:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
 <b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com> <xmqqa4yc5brq.fsf@gitster.g>
 <79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com> <xmqq1pjk2sv2.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq1pjk2sv2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/01/2026 15:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> The patch looks good to me, it is very convenient that we can put the
>> test in the library files rather than each test file. Should we drop
>> these tests from the ASan job as well?
> 
> That's probably a good idea.
> 
> I also was wondering if we want a blanket NO_FOO_TESTS that we can
> use instead listing all.  That FOO should not be SCM, though, as the
> reason why we exclude the tests is not because they are test about
> foreign SCM.  We exclude them as low value because testing them
> exercises little code of ours that we may make mistakes these checks
> are trying to uncover and that we can fix when they do.
> NO_FOREIGN_CODE_TESTS?  I dunno.

Having a single Makefile knob is tempting, the naming as tricky though. 
We're skipping these tests because they're scripted and we already have 
leak coverage for the git commands that they call, the fact that they're 
calling foreign programs is incidental to that. If "git svn" was 
implemented in C then we probably would want to check it for leaks even 
though it called a foreign program. That's a long winded way of saying I 
don't have any better suggestions!

Thanks

Phillip

