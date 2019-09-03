Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59311F461
	for <e@80x24.org>; Tue,  3 Sep 2019 01:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfICBkD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 21:40:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34317 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfICBkC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 21:40:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id a13so17717205qtj.1
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 18:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVumj5vKBq3PUIt4j6XgY/FpJM3Y8b8XHDY/wPIW3cw=;
        b=gTlaJE/D23IEz83ZYA/kmRBKdpER4LE1ZsZSJNCoaQvXO37LRpxacAs9oSgQiQCLkB
         cFfbmpEc0FMNTNBn9BberwuTFsmgEHMbkLZjH2ln1EcbUaxCcFIeApQZGAr9GWLad84i
         TuGyPin4Ia5oR1KSqhNTNJbDjFzYUv+dRW9/N1uwUs5zCRgSIffztiwwhpCEAE0kvsUD
         4EY3WBofn9GzuQgWYtfBf3kINa5X+N3ZoVDQaBJc8005O6gL0fczBUXBqhHv+2ZHT/vN
         yJGfkkEAv2hqyYHMtV7SbUS4L3DGZHBhnUS6aVKnxAf5pAonZYqfwVzlAP3eSngiZZEp
         zfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVumj5vKBq3PUIt4j6XgY/FpJM3Y8b8XHDY/wPIW3cw=;
        b=CO6pDulgpUadrmMTT7yrIFGK3ETRYd+HMgXPa90t0KuniZv5Om83ErV570Q4zp407z
         xQ6PoguPU9ohq2QBXmVcjbQDMDGlNyi04JR2GqD/w8XyMNVqNcdH2vjfFvX+r8mYgleQ
         s5LhWM4AJL5wtJR1Vj19p036mAPZ7Nu56Iszqo/APGl+NF6mLzqch4lHl3PkfeLxGZZS
         YhzU2NA+ibGLns8EgI9NNBqKSti3u5fYZcKv4lUKbfXLCCpGXxeMv/PFBP5wGSl6cSvj
         IBQrRfemjQDxyoRKeyRWVEZGUhGY57dxbK39Qg7mvvG1zqqU6yCwopApGdq+JCNd+whr
         Q/xQ==
X-Gm-Message-State: APjAAAWeDHtvqrN1b8UGcsq16rxEFzqB3PPu6/ywKzTSM7Qg/KGR6x5i
        9Wrh/OAJwwVtlZzn+I+N8VfHYA==
X-Google-Smtp-Source: APXvYqw91VERY6nPIDi8G9DMXv7APq6mo2xfcIiieL33mr2Aq2cva+Pr8VTHY+ujmSnI7lmab8CRTg==
X-Received: by 2002:a0c:ae9a:: with SMTP id j26mr12481585qvd.163.1567474801398;
        Mon, 02 Sep 2019 18:40:01 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:fd52:2b30:74d5:e918])
        by smtp.gmail.com with ESMTPSA id w126sm7825946qkd.68.2019.09.02.18.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 18:40:00 -0700 (PDT)
Date:   Mon, 2 Sep 2019 21:39:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Warren He <pickydaemon@gmail.com>, git@vger.kernel.org,
        Warren He <wh109@yahoo.com>
Subject: Re: [PATCH] rebase: introduce --update-branches option
Message-ID: <20190903013959.GA40029@syl.lan>
References: <20190902234109.2922-1-wh109@yahoo.com>
 <20190903005018.GH11334@genre.crustytoothpaste.net>
 <xmqqwoeqtbs2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwoeqtbs2.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 02, 2019 at 06:21:33PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > I like the idea of using existing tooling for this and not needing an
> > additional verb.
> >
> > My gut tells me folks may want a bit more control over *which* branches
> > are rebased, but I don't have a personal need for that, so I'm not going
> > to request it or propose an interface for it.
>
> FWIW, I am in favor of both of the above two points.  It is quite
> clear because "exec git branch -f <that branch name>" is spelled
> out, people can remove the ones they want to keep a copy of when
> they need to.

I agree with what you're saying here. I don't see myself having a need
to modify the 'exec git branch -f ...' line, so I have no real need to
make an interface suggestion per brian's comment above, but I happened
to think of one while reading this thread that seemed worth pointing
out.

Perhaps we could avoid inserting the 'exec git branch -f' step in the
todo list for branches that have a configuration section forbidding them
from being updated?

For example, the configuration:

  [branch "dont-update-me"]
    updateAfterRebase = false

would cause the rebase of a branch upstream from 'dont-update-me' to
omit the 'git branch -f dont-update-me'.

To be honest, this configuration option seems like a knob we don't need.
Especially since now three of us feel that removing the 'exec' line
suffices anyway. I suppose that I could see a user wanting some
integration branch to not get updated over many rebases, but it seems a
little contrived.

Anyway, perhaps others can chime in and share what they think about this
interface and whether or not we need it. If not, we can simply file this
away.

> I didn't look at the code more deeply than just eyeballing and
> noticing style violations etc., and will leave the reviewing to
> others for now.
>
> Thanks.

Thanks,
Taylor
