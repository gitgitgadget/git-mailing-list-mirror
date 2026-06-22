Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F018AE2
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151831; cv=none; b=BROrX4hEgzr1D/dC+sPclaaJJdXrlnGqQ4ZTcM1qr9qLCXB0iMVsg1HAB9sWzBZlkNjmBWh39j+9BAgh8+ieBylD4tmsYpys7VPO8RH1T4/ydyiRicDQORIL5KIi0tdhPPMSAAhR0pSh00eMBrCcPltVEtVagzpXf1Q/rVyddho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151831; c=relaxed/simple;
	bh=C9uKgWYhs5+IiZ0HxlrcQ1eqAklWM3cjhzSDHbBGKYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edryrQyoKECKZ+m55hIvhCVAJo4blA/qZIgFuPFIVcObOKjnOOOdCqmnDV8YOAkyQC/RR7VLIJb1kPCmW5othKKZX3eP0r0g6hIMbv+uY8JOjqpeB9sSPsb1sTiqwfyuB8b8b/dNE7a6pTEXRhx52gj0wzCJYeOup7m8xRib6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olAcVE3b; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olAcVE3b"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7e8b45dfb3dso52237497b3.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782151829; x=1782756629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4bJD0DbincsiX3kjm7XV2TCZwQCwSPFDLrvrYpSM+I8=;
        b=olAcVE3bn+yP6XbJUgWDYewR6ECw7T3WUGzdT7h5qPCkbz029hA9IAONzSeKOA56vb
         uek78ZCmesGy2cdBzopIJw5NC/khIXpVO86+uLX/5pZK2PBmyB4o1byRFzWtwXKW9T0q
         WboUYGqSOLiSzGuPpHPAp8Jtk51Hq3GJhW6YzfOQA3TAu7L9TIB/u07S4q9UV2bxPDMN
         y9qNRTKfpU+QWMVgBzTui5rw9rpJ2fF9q6kpQa/S5Tv/JEL+HnbnVC1URSD9ytIm/3dJ
         efWaRJ+7WUtTuDiYXO9e7BjHyL7vDM0VSPAaweapT+I7wm6DVXbj9tIUH/1MjMBHXk27
         hCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782151829; x=1782756629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bJD0DbincsiX3kjm7XV2TCZwQCwSPFDLrvrYpSM+I8=;
        b=sFXq6J+j055O33zndC9BO9nIh4yIu/QUdsW/3hYjffbkAlgiQQKRFmB0on5cjSjiLM
         8rsvE6T6pN6s2mFJiO4aHnbx4nVnZ9EkrXHf1ptCd3RnWhHzj3hDeuT6XjhE5RSkTMgn
         ARFnHQTibRvrinjkKJ31y+fAsi+4NxlTB5CzZvLoe6FaV1Ky/ydYNgyLfClMp+DgpFRM
         L28bs29vQbpBFXf+7b3LAp8wZ/wkw4P3AjQIvzOeViCwxexy/qGL0ovUwiqMq5LBZiXq
         USOMB7odFRoc0qIiN9lrtTnhu3L/iARbtWDBt/x4Cs7ECoPhPqGqerLVXASmC21Hb3ri
         MeZQ==
X-Forwarded-Encrypted: i=1; AHgh+RorpwX3AgGqwcXSIMp8q8zh6cC06Gs8RTEovlbvPUofLxGFBNbMl9yz48BQPcCcaBepChg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgo8iTfg9+I8xCOiyuDu/SttFVjlZqWfhbX8F2oEn8IuzHgdUM
	WKDR6/JxLFzipAnwFJFX8quydz9ypRk0eZSx1iXGTCdz06/Iq0phLIiI
X-Gm-Gg: AfdE7clJefCijdsQmOPsTaH0ysqHPIYArv1PyoLuT4+UVGYRbuYBn/Fvihr8M+xgCa+
	u9sAsAmx0JTvUYRAYVLvqqrQeMHSTERWYeBekQ2RG/FCk+5N3opZwHVdAjDCrDauin3RZU7HSEI
	Xak7Yo3fotf7czhLvV1oUGh9VTRlDz/Pq3V4eci2fFlKOCEE4dXKw79lwRliVW7h6wxMw1Ui80m
	6R8rthc58sy5zB41HrJ47wdqUTIcR6SYmMyX2eY+fyCW9rZpDANzQxILXR5/OgwW/I2ndMDEOxp
	fE6FgmwBP7LO30VlG7sNlhAU8JCusgKASH2ndzHBanQ2utrzTsMzDhEIhO3l+gCaSJp3lUzlmP4
	JeyAQTIvLEk8ud7xQ6r03YRRd0kAlucy7SWekZn0FuXtr9NTuZezIP2c8ceh7sS1x4S0VvKW6KR
	LnOWROMpzqCB15KxrfB08DXOi4hmQ09Py12noEW0A3EqcacbiIYzxDE7nWqg==
X-Received: by 2002:a05:690c:450e:b0:7f8:7e6f:f546 with SMTP id 00721157ae682-8013498b245mr173525377b3.52.1782151828823;
        Mon, 22 Jun 2026 11:10:28 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7fbdc9cfsm102084606d6.20.2026.06.22.11.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:10:28 -0700 (PDT)
Message-ID: <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com>
Date: Mon, 22 Jun 2026 14:10:27 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>

> +	if (!(old_paint & STALE)) {
> +		switch (old_paint & (PARENT1 | PARENT2)) {
> +		case 0:                  break;
> +		case PARENT1:            queue->p1_count--; break;
> +		case PARENT2:            queue->p2_count--; break;
> +		case PARENT1 | PARENT2:  queue->pending_merge_bases--; break;
> +		default:                 BUG("unexpected paint state");
> +		}
> +	}
> +	if (!(new_paint & STALE)) {
> +		switch (new_paint & (PARENT1 | PARENT2)) {
> +		case 0:                  break;
> +		case PARENT1:            queue->p1_count++; break;
> +		case PARENT2:            queue->p2_count++; break;
> +		case PARENT1 | PARENT2:  queue->pending_merge_bases++; break;
> +		default:                 BUG("unexpected paint state");
> +		}
> +	}

While correct and compact, I don't believe that these switch
statements follow the coding guidelines. We should split the
lines appropriately so they are more standard, such as:

if (!(new_paint & STALE)) {
	switch (new_paint & (PARENT1 | PARENT2)) {
	case 0:
		break;

	case PARENT1:
		queue->p1_count++;
		break;

	case PARENT2:
		queue->p2_count++;
		break;

	case PARENT1 | PARENT2:
		queue->pending_merge_bases++;
		break;

	default:
		BUG("unexpected paint state");
	}
}

Also: technically "case 0" should be a BUG() state, right? We
shouldn't be walking any commit that isn't reachable from at
least one side. (case 0 does happen for old_paint, though.)

>  }
>  
> -static void clear_nonstale_queue(struct nonstale_queue *queue)
> +static void paint_queue_put(struct paint_queue *queue,
> +			    struct commit *c, unsigned add_flags)
>  {
> -	clear_prio_queue(&queue->pq);
> -	queue->max_nonstale = NULL;
> -}
> +	unsigned old_flags = c->object.flags;
> +	c->object.flags |= add_flags;
  
Diffs like this are part of the reason I'd like to see a _new_
data structure instead of replacing the old one. Keeping the
old one for ahead_behind seems like a good idea to me, but even
if we don't land on that end state then deleting the old code
_after_ adding the new code will make the diff more readable.

> -	struct nonstale_queue queue = {
> -		{ compare_commits_by_gen_then_commit_date }
> +	struct paint_queue queue = {
> +		.pq = { compare_commits_by_gen_then_commit_date }
>  	};

I didn't notice when reading the struct definition, but looking at
'pq' here makes me think that we shouldn't be using that abbreviation
as it could stand for "prio_queue" or "paint_queue".

> +	while ((commit = paint_queue_get(&queue))) {
...> +
> +		if (queue.p1_count + queue.p2_count +
> +		    queue.pending_merge_bases == 0)
> +			break;
>  	}
When possible, I like to try to make loops only have one terminating
condition. Should we have paint_queue_get() return NULL when it sees
this internal state condition?

Also, I'd rather see it of the form of (!count) instead of using
addition to make it clear that we care about each value being zero.

Finally, I think we actually want this case to get the benefit:

	if ((!queue.p1_count || !queue.p2_count) &&
	    !queue.pending_merge_bases)
	    
I do see that you have this condition in patch 3 with the extra
detail that the max generation in the queue is finite. I think this
is more reason to include this in the data structure method and not
in the loop.

Thanks,
-Stolee

