Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20982DC321
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854470; cv=pass; b=aLy+vHyRjILZCopbwG4/kneTVtDMxkKwUuz4pvkQZr6/17YAyiI2hiF8AM9t2UgXADX2r7eDK7zHmxRPLOO0beR9fJ2DnxaamJcs+WactRyiwa7E8HX2U6IdhBHXthubafDA4E0Kuy4ikqnmm/yUQpRwEGv+mRqjq4+3ZlH7Reo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854470; c=relaxed/simple;
	bh=RW21PskSCANSNylrMjdML+Foo0OWXfabVkoWFUfEPYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p33wJ8xTBLPINJ+0mAIL7dS/hkFgZPNXipDX8iVPqzem1wOssxJxSRSASE7oPxRKAQLw0KipMqh3zCgpW+pbhUTTEEFeh4DyEjJ47JKGTjCy0i4aOlK6d07UBqC4/0lOVGxlBFiPu0g9L1qDJhT+a6w+hlwbzYMnjeLhqILrtk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=MNVoPAFc; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="MNVoPAFc"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-662bcc30fafso2019944d50.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 00:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781854468; cv=none;
        d=google.com; s=arc-20240605;
        b=ZARIgpQh7kFaxLKhOSl2Ds7Zn3YiKgI94uzecijpK4uqk9nGeflCqQXdvZoRQ1A4Ms
         C36Wy6LV+XUSqn0zycAcFgD+L2afTp8MXdjMJeHSQw9A1VscjtXEozkI66QdTdjeKail
         6CrVsc1rUoIojpKrc4wEk+EmmIj3IilNZNgOTb4gdnULnuHVJoiCE19zxBuQPLXhAdlw
         NBPCF3R6n0nIhUZgIzpqDvO75t5r8QK/7xOiRUb3BLMhEVlr9qmuvdVLwwNDVcum6Qxq
         dm1rAAOH3J1QfRbP701cavhQdZhCUd+ukxDXAEVMnUjLgNbN+45vap3/IDwKhz6Oo71y
         DJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ICu0fsX+zktGTOxJMZBisgpUa0oSG+e4sNmiOH7w9Dk=;
        fh=R5TrLSplp9lGS57cY3SRkE+Lug5clNpdqMqNvEgllww=;
        b=EXps+j1XI6/hyta78wjCslkM6s0IgMA+7JlXvdaa5iFzdQpVkCbfCTc0JclP5/jfvc
         1skcKY8+LHBl5OotyN7bXv8Io+EwJrM0z5XH19/oshB8LM5rZb8hv8KPR9r9niIoy/Uy
         r+d2axpZERI7PEKP3xcjS/pUR3R82Otq+He6wUrrg+2I38zeJQuuEnBu4pJWt/CKb+Jc
         u7W+wOK1dC4fPqDosBwUcudZx+WJKAH5DvweFlUJn6tSCfVvqGDJ4qyR5fD7LLnTbs6H
         HVmNVMt5N2KHGWrqkDhgHkH1Ah+HAuMut1oVli7+oaJqeOONYacOx3Q6n2T3bhRZXmIB
         dl7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781854468; x=1782459268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICu0fsX+zktGTOxJMZBisgpUa0oSG+e4sNmiOH7w9Dk=;
        b=MNVoPAFc+3Jgdg/wlRet9CtiF22yfKbi3Eth4xFVtImDWSsKRvZbHezYODmvNqoNwU
         IOdkuJwqKrhuWe2HpAXtKtb4yENn7Ez9ggzcYZv8HR5EC588r6C5ffomws8MXNDaTNG6
         ztV9dD37T2LpQ7F/UTTU5F7aop16v0xN+73EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854468; x=1782459268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICu0fsX+zktGTOxJMZBisgpUa0oSG+e4sNmiOH7w9Dk=;
        b=WBXFUe52LxX6llDChscm/WQX7C8yhqPMTSbiVplh4qeqZRTb2sne4/ZPdatflvSIW+
         2opoT7Xkh0Dhpz66nVbnDszNgHoLPE/Vs89v0aAfYNBJdcyYk2xWyyGou2VBm6t/r+Do
         vkZVzIiYWghuD1NEpaz/h46R/zj7rRKMfKifLl/yOOoi47qW8x27/cbB2kf6cCjNGbO6
         MXg9WaXewibSxPqyzqa42t1FoEW2zRoZEmyucNQxFCki21zEef/IRg0jvVExtHGJUzck
         NS55lU4ZMCzhUGdI2dmn/b9Ux3vdaeijG5UM3MmVLe+DBSVS4bCSEFtXPO2H/q1XK8Ip
         l10w==
X-Forwarded-Encrypted: i=1; AFNElJ+E6I7cMlVKASrjIiz6YZYt1CfDl3+J+BxzJgnsLlcjYNq+2BoNThNwDvffbYaOtIcRM8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxESKyy+qrPkjR7vs2Akjx8J1JUUdFh1MQaW3ijS/7nHC0mVu
	VLN1a1tWk1VFtkTzkp3+D8tna7DaWyrq3kiTWSI8oh9SnlnduyClIM89XAkyJMLJVqs79dm1fp2
	JKvfmGAkfNGNaBPVXe06p6WgQOwgL6EAWO8sJYNeFQg==
X-Gm-Gg: AfdE7cl6LeMAfeiOoi9n1qyVByBgvA91MSTcxlinq2GjvQ3Fy30h9zXeOEQ1G0csWfF
	/YfpZXKey6KR7U2W2Z6r9vTQR2LQpIWu5fFqH4uqdEoLEgeyq7ywe49jZU7fAB3RpjdgO3ipA7C
	zOVbw7yB7i2+G7ext87zmhbM40ZbID01USCd7YunGgm0ua8EvXr1PGYA9ARAMN8TE73BzbXQ6Yk
	sv+jqPuOWk4PnAHkrQ84kZ09+L7MAyIObC3MI1DXxwaI071oPhwLZ9sYzK9w9FiFTT4GFw4yuOw
	4q8nRw==
X-Received: by 2002:a05:690e:480e:b0:65e:b05:7679 with SMTP id
 956f58d0204a3-662ffc949c7mr1468986d50.3.1781854467825; Fri, 19 Jun 2026
 00:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
 <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
 <20260617202744.GA3465855@coredump.intra.peff.net> <CAN5EUNSQY2oK7BE4J9Y8APfkP6eJxta050OUu=RoJYhXOjX_OA@mail.gmail.com>
 <20260618160504.GA818042@coredump.intra.peff.net>
In-Reply-To: <20260618160504.GA818042@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 19 Jun 2026 09:34:16 +0200
X-Gm-Features: AVVi8Ceolg4BaQIIWt7wBa2hLHfT5Tp6lhB3sATvrTH4Cr_HOUvgfohLwM8wjsA
Message-ID: <CAL71e4MAtD4MqE-22UyYaNFVYcFgYmffngihhovEChVfHLmEdA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
To: Jeff King <peff@peff.net>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, phillip.wood@dunelm.org.uk, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 at 18:05, Jeff King <peff@peff.net> wrote:
>
> Thanks for looking into it. I meant to also cc the Kristofer, the author
> of dd4bc01c0a, for any thoughts (adding him now).
>

Thanks for the CC. I took a look at how this interacts with my
change.

dd4bc01c0a doesn't hurt here I think, but future followup changes
might. From what I can tell --graph triggers topo_order, so
the walk mode is either REV_WALK_TOPO or REV_WALK_LIMITED
and the prio_queue change only applies to REV_WALK_STREAMING.

That said, graph_peek_next_visible() reaching directly into
revs->commits feels fragile -- especially if we drop revs->commits
in the future. One option would be to add a thin abstraction in
revision.c that dispatches per walk mode, something like:

    int revision_has_more_commits(struct rev_info *revs)
    {
        if (revs->topo_walk_info)
            return revs->topo_walk_info->topo_queue.nr > 0;
        return revs->commits != NULL;
    }

    struct commit *revision_peek_next_commit(struct rev_info *revs)
    {
        if (revs->topo_walk_info)
            return prio_queue_peek(&revs->topo_walk_info->topo_queue);
        if (revs->commits)
            return revs->commits->item;
        return NULL;
    }

That way graph.c does not need to know which data structure the
walker uses, and if the internals change later the API adapts in
one place.

This would perhaps be an intermediate safety net -- once we have
fully rolled it out, those functions could be removed again.

As for the multi-element peek question, I think I would either opt
for draining into a buffer if it's really needed, though when looking
at the code here I think multi-element peeking is not truly needed.
It seems like the logic just checks if there is at least another
element after the peek, but it does not try to read the actual value,
so we can just check the queue size instead.

Thanks,
Kristofer
