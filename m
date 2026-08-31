Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FC4052B5
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179890; cv=none; b=cJLco9+/WwS8PisiZjD8eSHD3qCAONapX/sD1MdZce1i4YxQ8D/EnPU4/qZJPBw36XEa4yZmr6ZcmurIGXu0kAeiOI62jmL6pqWQHkDw7SBF37AVHSh+srOK+Xt2xcnB7H4gHI3JHtt6o40ySXJlOqVLoHAMLXyEU+Rv9od1sbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179890; c=relaxed/simple;
	bh=PqX0S94UIAOtzWFNNZOShTjv9B5EixorfsliDluMrUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km24KfF55Ey83DfbY3eoCX+6ia3SgsxFt3F617oCscHshNnoH62xoLBZmforUL0naqHa20B2T63QjVQ5ip/onGiPhtYdylBeH7VPE+FR1DI6fHpqfmWj9P/QKtNl7BPgFmvs2T2W0OKC+yLin2FTvshFy3aL4wEcyI0rzpOMRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4BZtLSo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4BZtLSo"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-90c522298d2so49735626d6.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179884; x=1788784684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cKt8Y0SaIJvYUekGRDEHEzR2n1gZLRQgQRIXyNYTAg=;
        b=S4BZtLSoWKKo8ESiJgV+OVi6tUWItor5ygQG91mGODDIt2Ff+YgcnCOq8eHjfFr5aa
         ZvSrKdSCbJW5E6CbjbsrR4OWCbflVpGvxAUF7zzQgEyWMXS+QhGurIk7l9FFjuUhaPGJ
         cx8RPqWXj1DEWV+pwSRW3GaGUtFo8A/2D7mfFpKGPXoUVs9SXS0Lz4SQhOdMPj/WJJaK
         XTsIZkHf8m6eyxXTuPTXsr7m3jOq2aaUpJEgVPpWWXs0tyl3pqSXnNzYKBa8oNKhLcgK
         jJo1f9dRo+5xHDdJ+LcraOHm1js6z9tqs4AY5ILHKxgxr1nQnYplW/CJK1XwJausp4EG
         o5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179884; x=1788784684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cKt8Y0SaIJvYUekGRDEHEzR2n1gZLRQgQRIXyNYTAg=;
        b=BQ9lfAeCb7Pu7VO/2vIr0uvXsLgbHk9CelqSORwykJTy8c+btIXSR0FR9hwLq7Jp/A
         Hn0mnTbnf3uReqLDjGRP7am4XiEIRuglIUPGF539XiNghNOEvNfnQZIfC28QO6aPeE63
         PHQ2MLgi3ELs8eowZ5qtXasSnkCmBrNBd6fQOTq/sUo1SFlLvuj9uD+Ewd2neB1V8Bu2
         AfyaxA7wGm/tg5WymlpTXuD/dj9ap8oWnO2mAVHjLqH2A3yuZ6L3nXBXjDChpA+dZB38
         lH0QMrdqGgEOmTCFHWWRzqmtTkiZdUVpZ1a70qR5ul57G2GSUSC6o1DkZ7AR8dr7n/5R
         Hpgg==
X-Gm-Message-State: AFuF++mBrk5k0pZcOcUELUirS8Bx1/gYUx7W0X2GBEYwuzEBxtaJ9CSx
	r0cx6GT/tr8Lq4IpjUIQZVLdvJQMKhip4p/JhKg+CR39G3opn3G9qDjf
X-Gm-Gg: AR+sD11jmyLXwBgn0iBQeKNTe4nA3desw3l7CUojQVfAUOu3b+YTUgpf++rgzhwX40w
	gKptL32b/yGx+atBDIa9r+d1kskl5tkqceOSVtBW1Y3nIHM+8hoo72WOu3tv1kTxg7ViEaoSyT+
	M5zIJ+KwmYzj2mub7gPWLcM0vjT+jNj3ACQMPAyET1ovmscOhd/TbaVT9B180HN5cC2q3wV+5eK
	U2ScMqPe+XqC/6tSDU0vEM3TrZhbc/OWljJz89Hd+le1UYZGeMRqtT7t6oKa8rF4JCkq4R34qM3
	/qee8INuPCclzL3B87xiMCTIKvuHkslKpZm+pWiJc9AhV7lL8ss4uzfhD15E/EaqFw7TfIq8LaD
	egrkotwKOPhfLY38r1QOcm8DaH4/R27LKS8ZpoAo5wPkHo/0sPUU5k5EAXFFHCB4SCey39QIDco
	SS5a8sdSJEZ9IpJeLVeL7M3S85vwnqwREIatzo7kB1LQKfVMOaOVfaEQ1+HZYgCSkmN8ityL27g
	j5dNSOLjsxEBPtyyQ9kFvuuMmPtsXLgz+jqZzyTHpBQ6qXdYIkp2zC0ykHrZRhrOAHeves0Qgwn
	xNKa219I0M06O6E=
X-Received: by 2002:a05:620a:1981:b0:939:93f:3b41 with SMTP id af79cd13be357-9394801242fmr107870485a.16.1788179883638;
        Mon, 31 Aug 2026 05:38:03 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917012b65sm779719885a.2.2026.08.31.05.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:38:03 -0700 (PDT)
Message-ID: <9a84da3f-3409-49ea-be57-1e17e373273c@gmail.com>
Date: Mon, 31 Aug 2026 08:38:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] banned-die: create header for banning of functions
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v2.git.1787684181.gitgitgadget@gmail.com>
 <84634717e2eca479026d1cdf39a089a8f61d131e.1787684181.git.gitgitgadget@gmail.com>
 <20260827051053.GB176544@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260827051053.GB176544@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/2026 1:10 AM, Jeff King wrote:
> On Tue, Aug 25, 2026 at 06:56:15PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> We have universally-banned functions listed in banned.h since
>> c8af66ab8ad (automatically ban strcpy(), 2018-07-26), but some layers of
>> the code should be more strict than others.
>>
>> One such example is the trace2 API which runs during atexit() and can
>> prove to cause die()-handler recursion problems if it calls die().
>>
>> Create a new banned-die.h header file that will ban some Git methods
>> that call die(). Include that in all trace2 API implementation files.
>> This currently only bans die() itself, and that was already not used.
> 
> There's a subtle but big difference between the universal code bans in
> banned.h and this banned-die.h. In the former case we are deciding
> strcpy() is unfit for our code base and outlawing it everywhere. The
> potential problem is in the source code, so catching it while compiling
> the source code is OK.
> 
> But we are not doing that with die(). It is a perfectly OK function in
> general, but we do not want to ever trigger its runtime effects from
> certain code paths. Banning it from being called from those code paths
> can catch _some_ instances, but not any transitive calls. If we call
> foo(), it may call die() itself, and we would not want to ban foo() from
> doing so. And recursively for functions called by foo() and so on.

Yes, this makes it tricky to be 100% sure without some kind of static
analysis.

> So you end up playing whack-a-mole with functions that might call die()
> and adding them to this ban list.

This does have some benefit that we can gradually remove these
transitive callers in the multi-commit series. But it's unsatisfying
as a full protection in the end.

> I think that's _probably_ the best we can do in practice. I think the
> framing above suggests that we could approach the problem more directly
> with a runtime flag: when we enter those code paths, set a flag to avoid
> the unwanted behavior, and have the low-level code respect that. But
> die() is a special case here, because we'd want to suppress its
> no-return behavior. And its callers are not prepared for die() to
> suddenly start returning because of some global flag.
> 
> So I think the whack-a-mole is the best we can do. But I would not want
> to see this strategy extended to other areas. In most cases some kind of
> runtime support is probably a better solution.
The other alternative that we could consider is to reorganize the
codebase in such a way that certain sections of code don't have
access to headers that could lead to die() or other "higher" methods
that are acceptable for user-facing processes but are best to avoid
in library APIs. Even then, we'd need some checks at compile time to
avoid crossing boundaries.

I don't think such a reorganization is desirable overall, because
that will be very disruptive to the project and file history.

Having some amount of protection through this header gives us a
mechanism to demonstrate and enforce some protection.

Thanks,
-Stolee

