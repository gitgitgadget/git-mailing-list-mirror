Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA075478D
	for <git@vger.kernel.org>; Mon, 25 May 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674398; cv=none; b=l/YJnv2SeDKZRLrXxogGzPrgj18QI4vmeq8AJ7aKBTu5rgijAYlX66ShjdWKdV7oGbGplODGrl1vP1MZXNshufRG7NhwQ/LdBrXFir9bsGLSFMkvUGaMX1sw4Mg58WBY7Z8yoRqV6amnPrEnRTRb9Ht82GmIcMoNlakpyTPW37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674398; c=relaxed/simple;
	bh=cUFPoA1b3/vh5+7iiuH1YM6SExTFk/iN2F+c5mJgtDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2YXwB/yvcOoCKozd2m8CY402sJzZIbwF878Aqy/5h/Clz0VdbjJH3DMzF7Ywttln6moa3x0pQkamRSoFJEnFzkySCkoFa7EDxghCYqP2lwmeL8MjsqWhloYXazx6ems4iDaMzmxdTM2xBRgIrRamnKgnkwRu9tDSM3Cwgn1YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwPMVZFz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwPMVZFz"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b98482b253so154490156d6.1
        for <git@vger.kernel.org>; Sun, 24 May 2026 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779674396; x=1780279196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL3IwZZz2x3mg4FJ2GCzz/PLHK5mP7+1PAsqr3EFrzk=;
        b=jwPMVZFz8KT7DIE1ViE6rczY4SobjaJfiPcBsYv/bLa4MdI7QY2vX4oo/2kVUK9qG7
         dt8scOqc/JHILbwbdAo8eQ8vuZAZrLW1M7/ZRl78kyN9OQcVGRcWijn1LniKegfaP8jo
         6A43WozeBIy0hfv+XP3O7EeYwFEjs93MUQr4CrVGvttFLP0looK+cFWwOYhdT1/m+3GB
         Skz4tOg3dZh7XaMvUwb0uvaQO0UeI4G8N2tWFM1S5WCZigpjJT81WarLYIuafXZYuuwL
         yP2XNvsZXVErTy0y6z70mj9HNFmm1skb+TUYwXhGhqZ03gXKcaHtDS9M2fhml6WtovOq
         frCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674396; x=1780279196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL3IwZZz2x3mg4FJ2GCzz/PLHK5mP7+1PAsqr3EFrzk=;
        b=L57CnYKw1Y8T0k+O9zh3N+anpnovyZheQdY/JQa4Ca0w/Oiwmcir1ydDDN+73VnwXl
         u/nuWdHK3Zom7se2KQG++CKKRw9Fu5HgA+7sBugArTKPjTFzSTy4wgGssLXMYRUhT3Cs
         SVq5M1YSgoWlwF1BYgnGa260wN2+JUOuwDmqSnVma1GR9iP3dX7TVQJVc9dvPx/zS0up
         LU/JZ0QU/JWtBafLxHaJvsZsCCLkOj5r8IFAF6/OfFB8vWtFLlquksCNpuCQvKWVzl0o
         XsXwt0ujVztvr3ob2q7fsrecPkcHmE6VsRGRWkXxezvufBvyooxPmpA9t6WXgkylANL1
         qbZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/OC2rtLV/o8DlrILlNz8fU0LsJVgLlwGS6n2ekJ8qNbyXZXmcNgEWLfemj6k5U1liol90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sCIvmG0HA483m3/kBSqtApGKDcUFO2C9Dad7e1kpY8yeb8IP
	2eFK88Cm6L2wPH2B26US57cFOhS36sIUq2xjKUYn53JBAQS4tNKF3OJl
X-Gm-Gg: Acq92OFKDptlTO3+eHrZA3qMIjv9A09oaTjk7/FbJBwPwsMZGw2ubEEYxn0xeJMbpxA
	2QlI071jx+I2eYf0/BsV8pa8dy8F+QhTlXxGm+7TwbJuh7vrgU0xLOUjOIS/+34yQ8PCOiup6b/
	5RWSW8i7BGz+/JsyYvTg0ZECWZNAgwtjrUyopaAssLrhxM4XXigyAh1rmlarl0DipooJS67Lc7X
	3XG5q2Yz2ezhuEmgLgKB6XT6WJLTAdm8ejrhIeE+wEP9t92iPUbbipbdZ34pRaOs8V/OB/DPc0K
	62axr9hXInm38Prv8ZiW+ZuygExocbd8yNyWBQkOo9fI4IMrzPQgaYXVt50P/21w3gD6IF2tNdP
	1d0PgGme4B0WKd0FEq8KOWX5F6r2t/la4OZgcVMSMy8JUQP1iL0dsWnZA4dUBSIxoiFr8caAThq
	UjmaQ8ZWoNcDdlR9Ft/ijvYUazz7ECiMyxnAOpaoTEBOS5tN6b30tWKHd6pS9T+GcBZ6B/81wCJ
	x8KvaQnU6YcP3W3FiFJcrxG5LUrP2gYhDlh/bhTzM/9OWfspHrx4RwdBBKvQg==
X-Received: by 2002:a05:6214:1c85:b0:8ac:a6f7:8a70 with SMTP id 6a1803df08f44-8cc7b5d288amr221249206d6.22.1779674396473;
        Sun, 24 May 2026 18:59:56 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:4178:7958:947f:ef4f? ([2605:a601:9b88:8300:4178:7958:947f:ef4f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca9c02e56sm98316d6.43.2026.05.24.18.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 18:59:54 -0700 (PDT)
Message-ID: <42aef000-7952-482d-8532-2287cf32b275@gmail.com>
Date: Sun, 24 May 2026 21:59:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] commit-reach: optimize queue scan in
 paint_down_to_common
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
 <4742f5e634b55820f3b5a626ec97e24617fdae3d.1779644541.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <4742f5e634b55820f3b5a626ec97e24617fdae3d.1779644541.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/26 1:42 PM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> paint_down_to_common() terminates when every commit remaining in its
> priority queue is STALE. This was checked by queue_has_nonstale(),
> which performed an O(n) linear scan of the entire queue on every
> iteration, resulting in O(n*m) total overhead where n is the queue
> size and m is the number of commits processed.
> 
> Replace this with an O(1) nonstale_count that tracks the number of
> non-stale commits currently in the queue. The counter is incremented
> by maybe_enqueue() and decremented on dequeue and by mark_stale()
> when a commit transitions to STALE while still in the queue. Since
> each commit appears at most once (guaranteed by the ENQUEUED flag
> from the previous commit), the counter is exact.

This idea has a lot of merit, but I'm a bit concerned about the
organization of data. My ideas of how to improve things may also
impact patch 1's use of ENQUEUED.

> -static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
> +static void maybe_enqueue(struct prio_queue *queue, struct commit *c,
> +			  int *nonstale_count)
>   {
>   	if (c->object.flags & ENQUEUED)
>   		return;
>   	c->object.flags |= ENQUEUED;
>   	prio_queue_put(queue, c);
> +	if (!(c->object.flags & STALE))
> +		(*nonstale_count)++;
> +}
> +
> +static void mark_stale(struct commit *c, unsigned queued_flag,
> +		       int *nonstale_count)
> +{
> +	if (!(c->object.flags & STALE)) {
> +		if (c->object.flags & queued_flag)
> +			(*nonstale_count)--;
> +		c->object.flags |= STALE;
> +	}
>   }

These two methods have some concerns on my end:

1. We need to store the nonstale count somewhere other than the
    priority queue, even though it's necessarily representing a
    subset of the commits within the queue.

2. mark_stale() needs a queued_flag. (I need to check to see if
    this is indeed changing in multiple callers or should always
    be ENQUEUED).

>   static int queue_has_nonstale(struct prio_queue *queue)
> @@ -68,6 +81,7 @@ static int paint_down_to_common(struct repository *r,
>   {
>   	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>   	int i;
> +	int nonstale_count = 0;

My preference would be to create a new struct that contains a
prio_queue as a member _and_ a nonstale_count. It could initialize
with compare_commits_by_gen_then_commit_date by default.

The important thing is that consumers of such a "stale-tracking"
queue would not be setting the STALE or ENQUEUED bits themselves,
but instead the queue would be responsible for that.

This could allow us to simplify callers by always assuming we can
"add" an element to the queue and the queue will use its ENQUEUED
bit to prevent duplicates from reaching its internal prio_queue.

Such a data structure could be private to commit-reach.c for now,
since all the methods that would use it seem to be colocated there.

This is a big ask, but I'm interested to see if such an approach
would simplify things here.

Here's a potential breakdown of how to build such a thing in
"small" patches:

1. Create the data structure and update paint_down_to_common and
    ahead_behind to use that structure, but still use the existing
    prio_queue methods on its internal member.

2. Add the ENQUEUED bit and methods on the new struct that add
    that bit as it adds commits to the inner prio_queue. It would
    also ignore commits that already have that bit. (Should it
    also remove the bit as commits are removed from the queue?)

3. Now add the nonstale_count (or stale count?) to the struct and
    have it control the STALE bit modifications, with increasing
    the stale count when ENQUEUED is live, and decreasing the stale
    count as such a STALE object is dequeued.

I like the idea of this being encapsulated within the struct and
its helper methods. But the proof will be in the implementation.

Thanks,
-Stolee

