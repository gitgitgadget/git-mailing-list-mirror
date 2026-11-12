Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506421;
	b=Zf1t57kgUhgXquv/3NtU1OXL0kEuCvYn+zSAjxp499vhWzd6ZhRqvD/MrUqbqYv775/y
	 DxlCQWU2+1lkR/+/P6L2142LgTYrjaD81G5tSEoFHouATAcAVY8z2c5ZGTV3xqogqM7+0
	 0uXkKnt1P4GsJw+s3h+ntHU5MJLx1ZndXigQKXJrTSplMFod3HtvmuyHkAF9PUxIyvyDu
	 FF9i7xvCihxTygTSg+zhVisWVYjO19vtxUCbp89r8ERo+lOdS9iBVdlh5Cm55bATvdBu4
	 JDt8oLhj8ADRTr8ypQyUUfBMH7jyyunJcJqCBiXM06MDmlBTxpNRAupcGS2V4u5K7Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=T4aaW24yiqSmYRgiVbzTJnnFHu9ChrRc5a9sVR7bur0=;
	b=n3AgRPdeU0kMG+6sWJUa8AFFPd5F155bTAN8KhFNtoyiAGMUxqTC5Nl6CIPQoN9QXYp+
	 9e94gvrZ3w85QuDXZXSjLanpgAM0xXqnCmRDHsuDX6ygH9QRIHx8MZGqnFPHAIjWFks53
	 9wD1KWmx7yGvOmrCJSYugJeEuUIYnghlZXC3wp8y42uY0ia6hTJquKtE8n6Pk3RbKnqeU
	 6dlNhb03XBTiXZsjZvyg5Js62VK1yrOSeaiia3HVuz+0R9GiKVOfHMJ4zVf1ppFVn3QRT
	 zsBtBZr3BfE2Kz/NJ9XEtjJ3HEx1aIUxFRZPnFKOkSMNGmgn5hVtSsOz1dG56Nf2Vmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMtKbaO1;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F955606A321
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 18:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F955606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMtKbaO1
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b315dd057bso1382817b3.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794506420; x=1795111220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T4aaW24yiqSmYRgiVbzTJnnFHu9ChrRc5a9sVR7bur0=;
        b=JMtKbaO1JT/hGIJk1//eMojRcEHKUkneTRq9W73bZemcUG7rXl/46VvkFUxNW1l/p5
         lHd34JQdFitNOhtLqxtuR0QvbEVX9tp31bIsITa1dEg6o26I09MmDsPBeNxTl7hXm9s4
         fOu1RR4/HY+macM5SnA9wm/X72sWYkaGGx0tzpaTcolGeR3RWUsWYL5f4XfSGKNWsch7
         ktIHbH2pcitW5yLVnwLLeFUhZCdoqNA+DQ4Tx+BS9HRqGwMhGT/g5oDjqTjt5mrwE6rw
         09lFqO6epLnEljZFBzetDcVgyFkmNjV8gDWLRNuk4rfpIEujSmcdviowyy+LTVKZHeCk
         tY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506420; x=1795111220;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T4aaW24yiqSmYRgiVbzTJnnFHu9ChrRc5a9sVR7bur0=;
        b=NL6MLQTZ/MsxO5ZHR9mQx2DX4sTAiA2mhViSmmeU8wDYzoNmUknP1s0qSnvE41yN/h
         7EumTiwSKOo23sqEh2MlarfO+AXNMYl9UdYwT8oveYhBE/RG6lD7k8c6qWQE7hVARlt+
         qCHw2rODLIr7EBVu1Fdq8CrQGkOzdlPFAQd+ExNqXkASU65T85IA7I+JBNvRAd+0dVGz
         U0CR2HigbXwDHwcDHNtgwU6B1Q5r3qeHj0guFIDIVw/gwSHoZc0FQtNMYFlgCxY6jVbh
         rDzoLXMnFm43BoZIgUp1YpbjTJH3lHHVlH31VYaf0HV8BSmS6d92EstPiyFz50nYKJOU
         emhg==
X-Forwarded-Encrypted: i=1; AL+hErF08uTaOPGxERC+riwc0tcqiOUvJ6H0ykEvnNannHVOcJqAx3RS2MZD9wJHZuye7oUgDZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9L55lPP0xc/g8DqsC7VR7S79Ej2riOgsR4hrTkKZhw9Gx2YKEb
	+41YPpP0oGMHR8+so/3GeonvpSJTGp7xuDokN1wcgG4F50qDTHlbjOql/2sjzsHB
X-Gm-Gg: AYBFou3wvseE0lubpOLKQZdebhKCMWxT2kdEnJk1hqLiH5W/pkmkD2yBe3cdVtc5zAP
	hODEegp2Wvbs1tJW+zOZemFdb4i7x9HKS40J6VFKtQcY2fYYMR4xu6OMNDDCU7YZnrwDhgccsUl
	TAsrZ8UDOxlbBVX9nFJvHCeG0l4HhYe4QOE7xZItwtNUN6wgFrwciXKbjB5hsLjfTtXiLZQYwoD
	qNM47ORh6QGGvGLShqA2KKJVy78PbGjToChgcxPuI6EmN0BUS98/XAQLI/slhGCGKxsoYeOQjcN
	OFtZcawJDDoMYsDgK/+EhVd6Czpn0M1+8GYhJ7o2OZci9M7FbxBMFRoOygCv0CmKAcA0TMGxVDO
	7SLEm8H9/oZzWc+0luLOU/kVAu/Fme1j0i8oLx9Btnj224eeZWJiXCzmnRqi3xkFnBlKJIqkMAi
	Jn5NohuJDUiT+aNnvCwr0SVjLF6OLtiN2xhYnQX3AvWFHkPwBdIyTRHtZS9CPDij/8yo6u1SJfG
	DzIOhbyP550hzATI6dsAxdlrIftxMWweaPc0KjUPZ15kNAZ057fg2edCWn7SB8tbEa/qq6QPoZ0
	NIHIQyi8iDxNX8Cg+mEVzaEwn25n395+RLy0D+YHnDYMbA22SKwf0HC7Iu41D0Encu5VKgysrYl
	WXkgGfJCbMFF6yODwdxuE1mS4MznzYyIQnJ9klKA+yBbv3nAr4WLpU0fd5igC78/RPDUiX2LIwr
	Woo6QMRwp28lDBqPzIyGSrve83s3EY/lsErjxatclKIssTIVjI/N+3FFs=
X-Received: by 2002:a05:690c:e288:20b0:8b3:3956:6f71 with SMTP id 00721157ae682-8b4aa29780fmr2126687b3.20.1794506420086;
        Thu, 12 Nov 2026 10:00:20 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa958d0asm1556257b3.22.2026.11.12.10.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:00:18 -0800 (PST)
Message-ID: <60c1d61e-777d-4c5a-b5a1-10c6530aa0d5@gmail.com>
Date: Thu, 12 Nov 2026 13:00:18 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] commit: remove padding from struct commit
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2309.git.1794500044740.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/2026 11:14 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> On 64-bit platforms, "struct commit" is 80 bytes, 8 of which are
> padding:
>  - 4 bytes between .object and .date
>  - 4 bytes of tail padding after .index

Good find.

> Reduce memory usage by moving .index into the hole after .object.
> On 64-bit platforms this shrinks the struct to 72 bytes and
> eliminates the padding, resulting in 10% less memory for every commit
> allocated, with no change in behaviour.
> 
> On platforms where 8-byte members only need 4-byte alignment (e.g.
> i386) both layouts are already free of padding, so the size stays the
> same there.
> 
> Measuring peak RSS of "git rev-list --all" over an internal monorepo
> with ~4.5 million commits (three runs each):
> 
>              peak RSS     time
>   before     ~849 MiB   12.8-13.7s
>   after      ~817 MiB   12.8-13.0s
> 
> The ~32 MiB saved is close to the expected 8 bytes * 4.5M commits
> (~34 MiB); running time is unchanged within noise.

Thanks for measuring the memory load improvement. And of course this
won't have any impact on 32-bit machines as the struct will use
4-byte alignment by default.

>  struct commit {
>  	struct object object;
> +	unsigned int index;
>  	timestamp_t date;
>  	struct commit_list *parents;
>  
> @@ -35,7 +36,6 @@ struct commit {
>  	 * or get_commit_tree_oid().
>  	 */
>  	struct tree *maybe_tree;
> -	unsigned int index;
>  };
This certainly looks like it should be obviously correct. I
believe that the only order-critical part is the object
struct needing to be first so we can "cast" a commit to an
object.

Thanks,
-Stolee

