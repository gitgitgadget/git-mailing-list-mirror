Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468D23C4FA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981042; cv=pass; b=BJN4KUSqMiX5VeZqYdTKqx+ONaKEO0yVviaGuIkRSNdr//itX1uftDlxuek4VSu8B4WK4gTKzWdPApJXzsI7JJqTHdqKxdGJaLJ1FHnendOS0xKRu0ncUUDykHkRbOqn98DKXQ+yX4qHyMSWJ7Rrmkq+AwqIXP6HYbWyw3mRdGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981042; c=relaxed/simple;
	bh=GSDmgXOAs5nasX+qYBvOjuL2mXtSfUvsp6PYih1SAaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDKW9TFLtzJ3/ziTZrG4j0GrWv7l5+uWK3Gvk0w9KAiIhbcyJoZF8ZGyxYKU/rNUFA4nc3QPx+Rv6VpkzcZ5XHsazjv6RlSz3LWN+OeOhdvJoVGZVZ1F9MO6Q4dtVXiu7CbrJsbd5HQcaYhLRmmEcORSOTELptF8CvQ7vKfBPQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=HQ/sgVh5; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="HQ/sgVh5"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-667971437d6so5870604d50.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783981040; cv=none;
        d=google.com; s=arc-20260327;
        b=re6BVCZsMymUP/yxTrQxcyFGPsbHLUc+yL1BnAsubv2Wf4O1RJ5ooCHw71Ljd2C5EI
         DVQFehvc8RPNAhdcC3Ou4tXNdwonV7DhEN+ottDB9bsewUfIh1Mj5WxC7zlvllGKWxDD
         1szHvDlUj9wG0jVlOi1BPD1OoDDyXnfoPK02oPBBrIwcKomQ4cqhcRDtGlEmKF4oypAt
         JIQ1LBKW9gI4nMwuKL348Hgvu+BjkzGppzLZcwnxvrHJYAatLy9IsWd2WL/yg1dXRyrs
         +AWFJQxIMKe8EEvh+THpCBZIP5yStoxtbe7gPikwIZHqV3d08g6d+23gmUDZZxaWEqFW
         +n+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/F7wGg5E2dXY5+62i753ZdhUGytc03TWuz6CJ8E9Njo=;
        fh=pFPjargKWfayp2AfdRSMz2KZkQSSHiw63+NeEvmFViY=;
        b=OQCI/i4qT7dtDabskHIWqiY0qcr+HhSRUdYEDlWovOWjZHMxMk7s/YrntNISCpIjUj
         8s+zW/oMqSOw2GdGb9iSW7owRmGSDWfxRAc+4+wdJ0i20NKtTz+V4ggvCFzAuJOxEZp3
         IzpaYkwLiGR/bdfwj6GG++zDZAPeKT6FAXEsoC3z/XSxHVzaz9sGpPUPCP3Uv9u/tN++
         q0oWfQZk/QL8Y03eR6KbqSd2y2Zn7rh2Qbb7Fy6ofj3FwrnV4zT7N/NuiqWGr3j9Dcig
         Cb3Rbi3X75S7rFa8J0dmoqU9nK1/kF8YT0bj0AJtU6nlp9ldNpAjYKgsKslS0iyTUsXZ
         ykNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783981040; x=1784585840; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/F7wGg5E2dXY5+62i753ZdhUGytc03TWuz6CJ8E9Njo=;
        b=HQ/sgVh5icux/RQzg1yuUYWtQynhJyW/bF9sZzQXA4rv3vIPxxTxaMXDGSB8JC0NUM
         uzg/qY3RIFNWgcRByylreNSebP9gwauMChm/JcuWnGtWiaU8x95L7yW37ZJdeMpMKOHa
         NuCD84VarhZqFF51ASOwWXcK7WTIVb9M6216Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981040; x=1784585840;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/F7wGg5E2dXY5+62i753ZdhUGytc03TWuz6CJ8E9Njo=;
        b=Wi6iWB2KUCw2YRxbrZa1UD6bfO4Z6RiFKd+6EB4WzRwydI0sHxXkB78zLt7OaVq9Eh
         TMz7oq7HCS01KNb+QcrTbDrx8I8qFmWDPAQcSYVSusdbsToiZyDcfEf0To72P/OVmChx
         hC/W+jQH2N6huDIjDEtyK19V2FGXZasmbYz53TYKK31LoRTMA1n6nQdBQ0s+B0FU3NzW
         DJOv38WfZ7qQW+AXatACL5rDk7m+TirOugD40/Vgh7E/5DmrrTZeL11Sflq0z2gl9XXQ
         b5cZGsqEgmQ6p0BbcSDfkHOUuu1fw6X0DrsIUTbR/czwSQ9c9SxE+l7LCmvRD8xGREGT
         BOFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7rsbwN3/qeS6JGPvc/FkJGMQdsupc/fAJnNTXEvfkMw0c0SY6OrxBeYPCjcPHW1AoNWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynj1AOvyda6QAS+7B5Lg8NcciE9IoUTZyL4kctWIYDY3lqeYX8
	z/ykL1onlP88Aot3U1eFCeE3xa9HSUjnddM0J+iyKVpkzrtIb/IhV144Dg2Z8IFMASbPMN8y5ZB
	CNoMnGFTJ1Mu3AxVf/es1YZBrKD9uAAcPpcdTR5Inpg==
X-Gm-Gg: AfdE7ckAuGtOCirteJUJ1Hq6nYVFGxutb8NPLCff0vqL6LFjzldzISimxbn+NuBI1P9
	HJly56EoBCFVaNH06z7k7xkxUP7QQuedGTRJ2zsqinW52yAZOcKN9lEmyR9XLJcxk/RqlK6qvBb
	+eMKgJDhW8y23RjO9u+1MEfKSO5NM/QtsVo3/2D7s2WLj3EdnqpAE2UKEo75AW+YFogvGxOPJXV
	AhgOENq87GW75+KqpKEvPPhOt74R38x77dy9MMy6pTQrvzJ0fU3/drbQ2cFHkauBM2aSDdzcmlM
	sW8WJZZ7
X-Received: by 2002:a05:690e:4803:b0:667:a82d:4b1f with SMTP id
 956f58d0204a3-667d7b7d0damr5276912d50.32.1783981039864; Mon, 13 Jul 2026
 15:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
 <b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
 <ak0DUx5Y/5y1OINz@nand.local> <CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
 <alFthqGQjsowvpEz@com-79390> <xmqqik6mbhtw.fsf@gitster.g> <alF4rYSTxpQUC38K@com-79390>
 <xmqqech99qe3.fsf@gitster.g> <CAL71e4M8-KtnkC5qQP2iuhON=ROoOTVZfbZB8UhJ-+3KgEP9=g@mail.gmail.com>
 <xmqqldbewriu.fsf@gitster.g>
In-Reply-To: <xmqqldbewriu.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 14 Jul 2026 00:17:08 +0200
X-Gm-Features: AUfX_mzUsrkqdUJaHqK8Mmh7uvaxMo-VczV71BUzy81N9tbNp_8JfnJNKILAekw
Message-ID: <CAL71e4MOz1PqAAdGCnKsdkWkOs+HN_Q1d4mpZc_g1Mi2+2czgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <ttaylorr@openai.com>, Taylor Blau <me@ttaylorr.com>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 at 22:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not quite understand.  Even if you fix the code and add a
> passing test, the commit remains atomic.  With an artificial
> split, you only increase your commit count while making the changes
> harder to review.  When grouping a code fix with a newly passing
> test:
>
>   * "git show" displays both the implementation changes and the
>     test.  You can review both, and if you agree with the behavior
>     expected by the test, the change is complete.
>
>   * If the pre-fix behavior is unclear, it is easy to check by
>     running:
>
>       $ git show ':!t/' | git apply -R && make test

That's quite neat, and it matches the local
development flow if you write the failing test first.

I can see the advantages of grouping the test and bugfix in the
same commit, and I'm happy to follow that convention going forward.

> > Too late for this round, but I might give that a try in the future
> > if I run into a similar scenario again.
>
> The existing tooling already supports this workflow (as demonstrated
> by the command above).  Please avoid artificially making the context
> larger, as doing so increases the likelihood of merge conflicts with
> other changes.

Thanks, that makes sense. It was an interesting thought experiment,
but I'll leave it there.

- Kristofer
